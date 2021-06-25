unit uMTDApi;

interface
uses
   Classes, Forms, Dialogs, uAccounts, HTTP, JSON, LoginCredentials, SysUtils;

type
  TMTDConfig = record
     IsAgent: Boolean;
     WebUrl: string;
     ApiUrl: string;
  end;

  TMTDVATReceipts = array of TMTDVATReceipt;
  TMTDApi = class
  private
   FLastError: string;
   FRawReceipt: string;
   FHTTP: THTTP;
   FCustomHeaders : TStringList;
   FLoginCredentials: TLoginCredentials;
   FConfig: TMTDConfig;
   function GetAccessToken(): string;
   function GetGovClientPublicPort: integer;
   procedure ParseHttpException(const AHttpException: Exception);
  public
   constructor create(const ALoginCredentials: TLoginCredentials; const AConfig: TMTDConfig);
   destructor destroy;override;
   function ValidateCredentials: boolean;
   function GetReceipt(const ATransactionId: string) : TMTDVATReceipt;
   // VRN = VAT Registration Number
   function GetReceipts(const AVRN: string = '') : TMTDVATReceipts;
   function StageVATReturn(const ARequest: TMTDVATReturnRequest): boolean;overload;
   function GetClientVRN(const AClientSecret: string): string;
   property LastError: string read FLastError;
   property RawReceipt: string read FRawReceipt write FRawReceipt;
   property GovClientPublicPort: integer read GetGovClientPublicPort;
   class function GetPort(const AConfig: TMTDConfig): integer;
  end;

  function ServerDateToDateTime(const AValue: string) :TDateTime;
                       //D3E7C10F-63F2-4891-AA42-2A98562DC6EC

const
   TOKEN_URI = '/token';
   RECEIPT_URI = '/vat/receipt?transactionId=%s';
   RECEIPTS_URI = '/vat/receipts';
   RECEIPTS_BY_VRN_URI = '/vat/receipts?vrn=%s';
   GET_VRN = '/vat/vrn?clientSecret=%s';

implementation
uses
   FileCtrl, AccsUtils, idHttp;

{ TMTDApi }

constructor TMTDApi.create(const ALoginCredentials: TLoginCredentials;
  const AConfig:TMTDConfig);
begin
   FHTTP := THTTP.create();
   FLoginCredentials:= ALoginCredentials;
   FRawReceipt := FRawReceipt;
   FCustomHeaders := TStringList.Create;
   FConfig := AConfig;
end;

destructor TMTDApi.destroy;
begin
  inherited;
  if (FHTTP <> nil) then
     FHTTP.Free;
  if (FCustomHeaders <> nil) then
     FCustomHeaders.Free;
end;

function TMTDApi.GetAccessToken: string;
var
   Content: String;
   HttpResponse: string;
   JSONResponse: JSONItem;
begin
   Result := '';
   if (FLoginCredentials=nil) then
      begin
         FLastError := 'It appears that you haven''t entered your login details.';
         Abort;
      end;

   Content := Format('grant_type=password&username=%s&password=%s',
         [FLoginCredentials.Username,FLoginCredentials.Password]);

   FCustomHeaders.Clear;
   FCustomHeaders.Values['client-name'] := 'kw-accs';

   try
      HttpResponse := FHTTP.Post(FConfig.ApiUrl + TOKEN_URI, Content, 'application/x-www-form-urlencoded', FCustomHeaders);
      if (Trim(HttpResponse) = '') then
         begin
            FLastError := 'HttpResponse parse error.';
            Exit;
         end;

      JSONResponse := JSONItem.Parse(HttpResponse);
      if (JSONResponse<>nil) then
         Result := JSONResponse['access_token'].getStr('');
   except
     on E: Exception do
        FLastError := 'Login error: ' + E.Message;
   end;
end;

function TMTDApi.GetClientVRN(const AClientSecret: string): string;
var
   AccessToken: string;
   HttpResponse: string;
begin
   Result := '';
   AccessToken := GetAccessToken();
   if (AccessToken='') then Exit;

   FCustomHeaders.Clear;
   FCustomHeaders.Values['Authorization'] := 'Bearer ' + AccessToken;
   FCustomHeaders.Values['client-name'] := 'kw-accs';

   try
      Result := FHTTP.Get(FConfig.ApiUrl + Format(GET_VRN,[AClientSecret]), 'application/json', FCustomHeaders);
      if (Result[1] = '"') and (Result[Length(Result)] = '"') then
         Result := Copy(Result, 2, Length(Result)-2);
   except
      on E: Exception do
        ParseHttpException(E);
   end;
end;

function TMTDApi.GetGovClientPublicPort: integer;
begin
   Result := FHTTP.Port;
end;
// helper function - return the http port number - this is a required fraud prevention header value
class function TMTDApi.GetPort(const AConfig: TMTDConfig): integer;
begin
   with TMTDApi.Create(nil,AConfig) do
      try
         Result := FHTTP.Port;
      finally
        Free;
      end;
end;

function TMTDApi.GetReceipt(const ATransactionId: string): TMTDVATReceipt;
var
   AccessToken: string;
   HttpResponse: string;
   JSONResponse: JSONItem;
begin
   Result := nil;
   FRawReceipt := '';

   AccessToken := GetAccessToken();
   if (AccessToken='') then Exit;

   FCustomHeaders.Clear;
   FCustomHeaders.Values['Authorization'] := 'Bearer ' + AccessToken;
   FCustomHeaders.Values['client-name'] := 'kw-accs';

   try
      HttpResponse := FHTTP.Get(FConfig.ApiUrl + Format(RECEIPT_URI,[ATransactionId]), 'application/json', FCustomHeaders);
      if (Trim(HttpResponse) = '') then
         begin
            FLastError := 'HttpResponse parse error.';
            Exit;
         end;

        JSONResponse := JSONItem.Parse(HttpResponse);
        if (JSONResponse=nil) then
           begin
              FLastError := 'JSON parse error.';
              Exit;
           end;

        Result := TMTDVATReceipt.create;
        Result.ProcessingDate := JSONResponse['processingDate'].getStr();
        Result.BundleNumber := JSONResponse['formBundleNumber'].getStr();
        Result.PaymentIndicator := JSONResponse['paymentIndicator'].getStr();

        FRawReceipt := JSONResponse.Code;
     except
        on E: Exception do
          ParseHttpException(E);
     end;
end;

function TMTDApi.GetReceipts(
   const AVRN: string = ''): TMTDVATReceipts;
var
   AccessToken: string;
   HttpResponse: string;
   VATReceipt: TMTDVATReceipt;
   JSONResponse: JSONItem;
   I : Integer;
   Item, NestItem : JSONItem;
   URI: string;
begin
   SetLength(Result, 0);

   FRawReceipt := '';

   AccessToken := GetAccessToken();
   if (AccessToken='') then Exit;

   FCustomHeaders.Clear;
   FCustomHeaders.Values['Authorization'] := 'Bearer ' + AccessToken;
   FCustomHeaders.Values['client-name'] := 'kw-accs';

   try
      URI := IfThenElse(AVRN<>'', Format(RECEIPTS_BY_VRN_URI,[AVRN]),RECEIPTS_URI);
      HttpResponse := FHTTP.Get(FConfig.ApiUrl + URI, 'application/json', FCustomHeaders);
      if (Trim(HttpResponse) = '') then
         begin
            FLastError := 'HttpResponse parse error.';
            Exit;
         end;

        JSONResponse := JSONItem.Parse(HttpResponse);
        if (JSONResponse=nil) then
           begin
              FLastError := 'JSON parse error.';
              Exit;
           end;

        for i := 0 to JSONResponse.Count-1 do
           begin
              Item := JSONResponse.Value[i];
              VATReceipt := TMTDVATReceipt.create;
              VATReceipt.TransactionId := Item['transactionId'].getStr();
              VATReceipt.BundleNumber := Item['formBundleNumber'].getStr();
              VATReceipt.ChargeRefNumber := Item['chargeRefNumber'].getStr();
              VATReceipt.PaymentIndicator := Item['paymentIndicator'].getStr();
              VATReceipt.ProcessingDate := Item['processingDate'].getStr();
              VATReceipt.PeriodStart := Item['periodStart'].getStr();
              VATReceipt.PeriodEnd := Item['periodEnd'].getStr();
              VATReceipt.DueBy := Item['dueBy'].getStr();
              VATReceipt.SubmissionDate := Item['submissionDate'].getStr();
              NestItem := Item['return'];
              with VATReceipt.VATReturn do
                 begin
                    VATDueSales := NestItem['vatduesales'].getNum();
                    VATDueAcquisitions := NestItem['vatdueacquisitions'].getNum();
                    TotalVATDue := NestItem['totalVatDue'].getNum();
                    VATReclaimedCurrPeriod :=NestItem['vatReclaimedCurrPeriod'].getNum();
                    NetVATDue := NestItem['netVatDue'].getNum();
                    totalValueSalesExVAT := NestItem['totalValueSalesExVAT'].getNum();
                    TotalValuePurchasesExVAT := NestItem['totalValuePurchasesExVAT'].getNum();
                    TotalValueGoodsSuppliedExVAT := NestItem['totalValueGoodsSuppliedExVAT'].getNum();
                    TotalAcquisitionsExVAT := NestItem['totalAcquisitionsExVAT'].getNum();
                    Finalised := LowerCase(NestItem['finalised'].getStr())='true';
                 end;
              SetLength(Result, i+1);
              Result[i] := VATReceipt;
           end;
   except
      on E: Exception do
        ParseHttpException(E);
   end;
end;

function TMTDApi.StageVATReturn(
  const ARequest: TMTDVATReturnRequest): boolean;
var
   AccessToken: string;
   JSONErrorResponse: JSONItem;
begin
   Result := False;

   AccessToken := GetAccessToken();
   if (AccessToken='') then Exit;

   FCustomHeaders.Clear;
   FCustomHeaders.Values['Authorization'] := 'Bearer ' + AccessToken;
   FCustomHeaders.Values['client-name'] := 'kw-accs';

   try
      FHTTP.Post(FConfig.ApiUrl + '/vat/stage/', ARequest.AsJSON, 'application/json', FCustomHeaders);
      Result := True;
   except
      on E: Exception do
        ParseHttpException(E);
   end;
end;

function TMTDApi.ValidateCredentials: boolean;
begin
   Result := GetAccessToken() <> '';
end;

procedure TMTDApi.ParseHttpException(const AHttpException: Exception);
var
   HttpErrorResponse: EIdHTTPProtocolException;
   JSONErrorResponse: JSONItem;
begin
   FLastError := '';
   if not (AHttpException is EIdHTTPProtocolException) then Exit;

   HttpErrorResponse := (AHttpException as EIdHTTPProtocolException);
   if (HttpErrorResponse.ReplyErrorCode = 400) then
      begin
         JSONErrorResponse := JSONItem.Parse(HttpErrorResponse.ErrorMessage);
         if (JSONErrorResponse<>nil) then
            begin
               FLastError := JSONErrorResponse.Item['message'].getStr();
               FLastError := IfThenElse(FLastError <> '',FLastError, 'An error occurred while processing request');
               FLastError := Format('  Http Status(%d): %s ', [HttpErrorResponse.ReplyErrorCode, FLastError]);
            end;
      end;
   if (FLastError='') then
      FLastError := AHttpException.Message;
end;
// UTILS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function ServerDateToDateTime(const AValue: string) :TDateTime;
var
   tempValue: string;
begin
   Result := 0;
   tempValue := StripAllNomNumAlpha(AValue);
   if (Length(tempValue) = 8) then
      try
         Result := EncodeDate(StrToInt(Copy(tempValue,5,4)), StrToInt(Copy(tempValue,3,2)), StrToInt(Copy(tempValue,1,2)));
      except

      end;
end;
end.
