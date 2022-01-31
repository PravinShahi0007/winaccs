/// WARNING: To be used with extreme caution. These account objects do not track changes
// Reloading of account objects is required after changes to db.

//   16/09/19 [V4.5 R0.4] /MK Additional Feature - New class, TStoredBankLinkInfo, created to get stored nominal and txtype from BankImportNLStore table.

//   31/01/22 [V4.5 R6.5] /MK Additional Feature - TStoredBankLinkInfo - Added CustSuppNo and CustSuppName fields.

unit uAccounts;

interface
uses
   Classes, SysUtils, Windows, Messages, TYPES, db, dbTables;

type
   TTradeAccountType = (taCustomer, taSupplier);
   TNominalType = (ntIncome, ntExpense);
   TAccountType = (natNone, natAll, natEntIncome, natEntExpense, natNonEntIncome, natOverhead,
                   natCurrentAsset, natLiability, natFixedAsset, natBank, natControlAccount,
                   natPrivateIncome, natPrivateExpense);

   TAccountBase = class
   private
    FId: Integer;
    FName: string;
   public
    property Id : Integer read FId write FId;
    property Name : string read FName write FName;
   end;

   TProduct = TAccountBase;

   TTradeAccount = class(TAccountBase)
   private
      FTradeAccountType: TTradeAccountType;
   public
      property TradeAccountType : TTradeAccountType read FTradeAccountType write FTradeAccountType;
   end;

   TAppJobCard = class
   private
     FQuantity: double;
     FClientId: string;
     FUnitType: string;
     FComment: string;
     FOperator: TAccountBase;
     FActivity: TAccountBase;
     FCustomer: TAccountBase;
     FImportDate: TDateTime;
     FFinishDateTime: TDateTime;
     FStartDateTime: TDateTime;
     FUploadDateTime: TDateTime;
     FProduct1: TAccountBase;
     FJobReference: string;
     FJobCardId: integer;
    function GetUnitAndQuantityAsString: string;
   public
     constructor create;
     destructor destroy;override;
     property JobCardId: integer read FJobCardId write FJobCardId; // server id. 
     property ClientId : string read FClientId write FClientId;
     property Operator : TAccountBase read FOperator write FOperator;
     property Customer : TAccountBase read FCustomer write FCustomer;
     property Activity : TAccountBase read FActivity write FActivity;
     property Product1 : TAccountBase read FProduct1 write FProduct1;
     property UnitType : string read FUnitType write FUnitType;
     property Quantity : double read FQuantity write FQuantity;
     property UnitAndQuantityAsString : string read GetUnitAndQuantityAsString;
     property StartDateTime : TDateTime read FStartDateTime write FStartDateTime;
     property FinishDateTime : TDateTime read FFinishDateTime write FFinishDateTime;
     property UploadDateTime : TDateTime read FUploadDateTime write FUploadDateTime;
     property ImportDate : TDateTime read FImportDate write FImportDate;
     property Comment : string read FComment write FComment;
     property JobReference : string read FJobReference write FJobReference;
   end;

   TAppJobCards = class(TList)
   private
    function GetCount: Integer;
    function GetJobCard(Index: Integer): TAppJobCard;
    procedure SetJobCard(Index: Integer; const Value: TAppJobCard);
   public
    constructor create;
    destructor destroy;override;
    function Add(AJobCard: TAppJobCard): Integer;
    function Remove(AJobCard: TAppJobCard): Integer;
    function IndexOf(AClientId : string): TAppJobCard;
    function Get(const AClientId : string) : TAppJobCard;
    procedure Clear;override;
    property JobCard[Index: Integer]: TAppJobCard read GetJobCard write SetJobCard; default;
    property Count : Integer read GetCount;
   end;

   TAccount = class(TAccountBase)
   private
    FAccountType: TAccountType;
    FBalance: double;
    FReportGroup: string;
   public
    constructor create;
    destructor destroy;override;
    property AccountType : TAccountType read FAccountType write FAccountType;
    property Balance : double read FBalance write FBalance;
    property ReportGroup : string read FReportGroup write FReportGroup;
   end;

   TNominalAccount = class(TAccount)
   private
    FEntCode: string;
    FVATCode: string;
    FDefaultProduct: TAccountBase;
   public
    constructor create;
    destructor destroy;override;
    property EntCode : string read FEntCode write FEntCode;
    property VATCode : string read FVATCode write FVATCode;
    property DefaultProduct : TAccountBase read FDefaultProduct write FDefaultProduct;
   end;

   TAccountsBase = class(TList)
   private
     FAccRange : TAccRange;
     function GetCount: Integer;
   protected
     FQuery : TQuery;
     procedure LoadFromDatabase; virtual;
   public
     constructor create;
     destructor destroy;override;
     property AccRange : TAccRange read FAccRange;
     property Count : Integer read GetCount;
     procedure Load(const AAccRange : TAccRange);overload;
     procedure Load();overload;
   end;

   TNominalAccounts = class(TAccountsBase)
   protected
    procedure LoadFromDatabase;override;
    function GetAccountType(ANominalId : Integer) : TAccountType;
   public
    constructor create;
    destructor destroy;override;
    function Add(ANominalAccount: TNominalAccount): Integer;
    function Remove(ANominalAccount: TNominalAccount): Integer;
    function GetNominalAccount(const ANominalId : Integer) : TNominalAccount;overload;
    function GetNominalAccount(const ANominalName : string) : TNominalAccount;overload;
    procedure Clear;override;
   end;

   TBankAccount = class(TAccount)
   private
     FBankFileFormat: Integer;
   public
     property BankFileFormat : Integer read FBankFileFormat write FBankFileFormat;
   end;

   TBankAccounts = class(TAccountsBase)
   private
    function GetBankFileFormat(ABankId : Integer) : Integer;
   protected
    procedure LoadFromDataBase;override;
   public
    constructor create;
    destructor destroy;override;
    function Add(ABankAccount: TBankAccount): Integer;
    function Remove(ABankAccount: TBankAccount): Integer;
    function GetBankAccount(const ABankId : Integer) : TBankAccount;overload;
    function GetBankAccount(const ABankName : string) : TBankAccount;overload;
    procedure Clear;override;
    function First : TBankAccount;
   end;

   TAnalysisCode = class(TAccountBase);

   TAnalysisCodes = class(TAccountsBase)
   protected
    procedure LoadFromDataBase;override;
   public
    constructor create;
    destructor destroy;override;
    function GetAnalysisCode(const ACode : string) : TAnalysisCode;
    function DefaultAnalysisCode : TAnalysisCode;
   end;

  TEnterpriseAccount = class(TAccountBase)
  private
    FCode: string;
    FDefaultUnitTotal: Double;
    FDefaultUnitDescription: string;
    FJobCardEnabled: Boolean;
   public
    constructor create;
    destructor destroy;override;
    property Id : Integer read FId write FId;
    property Code : string read FCode write FCode;
    property DefaultUnitTotal : Double read FDefaultUnitTotal write FDefaultUnitTotal;
    property DefaultUnitDescription : string read FDefaultUnitDescription write FDefaultUnitDescription;
    property JobCardEnabled : Boolean read FJobCardEnabled write FJobCardEnabled;
   end;

   TEnterpriseAccounts = class(TAccountsBase)
   private
    function GetEnterpriseAccountByIndex(Index: Integer): TEnterpriseAccount;
    procedure SetEnterpriseAccountByIndex(Index: Integer; const Value: TEnterpriseAccount);
   protected
    procedure LoadFromDB;
   public
    constructor create;
    destructor destroy;override;
    function Add(AEnterpriseAccount: TEnterpriseAccount): Integer;
    function Remove(AEnterpriseAccount: TEnterpriseAccount): Integer;
    function IndexOf(AEnterpriseCode : string) : TEnterpriseAccount;
    procedure Clear;override;
    procedure Load;
    //function GetEnterpriseByNominalId(ANominalId : Integer) : TEnterpriseAccount;
    //function GetNominalAccountByNominalCode(ANominalCode : String) : TNominalAccount;
    property EnterpriseAccount[Index: Integer]: TEnterpriseAccount read GetEnterpriseAccountByIndex write SetEnterpriseAccountByIndex; default;
    function GetEnterpriseAccount(ACode: string): TEnterpriseAccount;overload;
    function GetEnterpriseAccount(AId: Integer): TEnterpriseAccount;overload;
    function Update(const AEnterpriseAccount : TEnterpriseAccount) : Boolean;
   end;

   TAccounts = class
   private
    FIncomeAccounts : TNominalAccounts;
    FExpenseAccounts : TNominalAccounts;
    FBankAccounts: TBankAccounts;
    FAnalysisCodes : TAnalysisCodes;
    FEnterpriseAccounts : TEnterpriseAccounts;
    function GetBankAccounts: TBankAccounts;
    procedure SetBankAccounts(const Value: TBankAccounts);
    function GetExpenseAccounts: TNominalAccounts;
    procedure SetExpenseAccounts(const Value: TNominalAccounts);
    function GetIncomeAccounts: TNominalAccounts;
    procedure SetIncomeAccounts(const Value: TNominalAccounts);
    function GetAnalysisCodes: TAnalysisCodes;
    procedure SetAnalysisCodes(const Value: TAnalysisCodes);
   public
    procedure LoadBankAccounts();
    procedure LoadIncomeAccounts();
    procedure LoadExpenseAccounts();
    procedure LoadAnalysisCodes;
    procedure LoadEnterpriseAccounts();
    procedure Refresh();
    constructor create(ADatabasePath : string; const ALazyLoading : Boolean = false);
    destructor destroy;override;

    function GetNominalAccount(const ANominalId : Integer) : TNominalAccount;overload;
    function GetNominalAccount(ANominalName : string; ANominalType: TNominalType) : TNominalAccount;overload;
    property EnterpriseAccounts : TEnterpriseAccounts read FEnterpriseAccounts write FEnterpriseAccounts;
    property IncomeAccounts : TNominalAccounts read GetIncomeAccounts write SetIncomeAccounts;
    property ExpenseAccounts : TNominalAccounts read GetExpenseAccounts write SetExpenseAccounts;
    property BankAccounts : TBankAccounts read GetBankAccounts write SetBankAccounts;
    property AnalysisCodes : TAnalysisCodes read GetAnalysisCodes write SetAnalysisCodes;
   end;

   TStoredBankLinkInfo = class
   private
     FNominalID: Integer;
     FTxTypeDesc: String;
     FCustSuppNo: Integer;
     FCustSupDesc: String;
   public
      property NominalID : Integer read FNominalID write FNominalID;
      property TxTypeDesc : String read FTxTypeDesc write FTxTypeDesc;
      property CustSuppNo : Integer read FCustSuppNo write FCustSuppNo;
      property CustSupDesc : String read FCustSupDesc write FCustSupDesc;
   end;

   TMTDVATReturn = class
   private
     FFinalised: boolean;
     FTotalValueSalesExVAT: double;
     FNetVATDue: double;
     FVATDueAcquisitions: double;
     FTotalAcquisitionsExVAT: double;
     FVATReclaimedCurrPeriod: double;
     FTotalValuePurchasesExVAT: double;
     FTotalValueGoodsSuppliedExVAT: double;
     FVATDueSales: double;
     FTotalVATDue: double;
   public
     property VATDueSales: double read FVATDueSales write FVATDueSales;
     property VATDueAcquisitions: double read FVATDueAcquisitions write FVATDueAcquisitions;
     property TotalVATDue: double read FTotalVATDue write FTotalVATDue;
     property VATReclaimedCurrPeriod: double read FVATReclaimedCurrPeriod write FVATReclaimedCurrPeriod;
     property NetVATDue: double read FNetVATDue write FNetVATDue;
     property TotalValueSalesExVAT: double read FTotalValueSalesExVAT write FTotalValueSalesExVAT;
     property TotalValuePurchasesExVAT: double read FTotalValuePurchasesExVAT write FTotalValuePurchasesExVAT;
     property TotalValueGoodsSuppliedExVAT: double read FTotalValueGoodsSuppliedExVAT write FTotalValueGoodsSuppliedExVAT;
     property TotalAcquisitionsExVAT: double read FTotalAcquisitionsExVAT write FTotalAcquisitionsExVAT;
     property Finalised: boolean read FFinalised write FFinalised;
   end;

   TMTDVATReceipt = class
   private
     FTransactionId: string;
     FBundleNumber: string;
     FChargeRefNumber: string;
     FPaymentIndicator: string;
     FProcessingDate: string;
     FPeriodStart: string;
     FPeriodEnd: string;
     FDueBy: string;
     FSubmissionDate: string;
     FVATReturn: TMTDVATReturn;
    public
     property TransactionId: string read FTransactionId write FTransactionId;
     property BundleNumber: string read FBundleNumber write FBundleNumber;
     property ChargeRefNumber: string read FChargeRefNumber write FChargeRefNumber;
     property PaymentIndicator: string read FPaymentIndicator write FPaymentIndicator;
     property ProcessingDate: string read FProcessingDate write FProcessingDate;
     property PeriodStart: string read FPeriodStart write FPeriodStart;
     property PeriodEnd: string read FPeriodEnd write FPeriodEnd;
     property DueBy: string read FDueBy write FDueBy;
     property SubmissionDate: string read FSubmissionDate write FSubmissionDate;
     property VATReturn: TMTDVATReturn read FVATReturn write FVATReturn;
     function CreateStamp(const ATransactionId: string): string;
     constructor create;
     destructor destroy;override;
    end;

    TMTDVATReturnRequest = class(TMTDVATReturn)
    private
     FHttpRequestHeaders: string;
     FVRN: string;
     FTransactionId: string;
     FPeriodEnd: string;
     FPeriodStart: string;
     function GetJSON: string;
    public
     procedure AddHeader(const AKey, AValue: string);
     property PeriodStart: string read FPeriodStart write FPeriodStart;
     property PeriodEnd: string read FPeriodEnd write FPeriodEnd;
     property HttpRequestHeaders: string read FHttpRequestHeaders;
     property TransactionId : string read FTransactionId write FTransactionId;
     property VRN: string read FVRN write FVRN;
     property AsJSON : string read GetJSON;
    end;

const
   { SP 04/07/2013 }
   cDefault_Enterprise_Income_Start = 1;
   cDefault_Enterprise_Expense_Start = 201;

   cNon_Enterprise_Income_Start = 181;
   cNon_Enterprise_Expense_Start = 401;

var
   DatabasePath : string;

{ MISC }
   function GetNominalDefaultProduct(ANominalId : Integer) : TProduct;

implementation
uses
   DBCore, UTIL, DBGEN, VARS, Clears, Global;


function GetNominalDefaultProduct(ANominalId : Integer) : TProduct;
begin
   Result := nil;
   with TQuery.Create(nil) do
      try
         DatabaseName := DatabasePath;
         SQL.Add('SELECT * FROM NomListing WHERE Account=:Id');
         Params[0].AsInteger := ANominalId;
         Open;
         if (RecordCount = 1) then
            begin
               Result := TProduct.Create;
               Result.Id := FieldByName('Product').AsInteger;
               Result.Name := FieldByName('Name').AsString;
            end;
      finally
         Free;
      end;
end;

{ TAccount }

constructor TAccount.create;
begin
   FId:= 0;
   FName:= '';
   FBalance := 0;
   FReportGroup := '';
   FAccountType:= natNone;
end;

destructor TAccount.destroy;
begin
  inherited;
  //
end;

{ TAccountsBase }

constructor TAccountsBase.create;
begin
   FQuery := TQuery.Create(nil);
   FQuery.DatabaseName := Global.AliasName;
end;

destructor TAccountsBase.destroy;
begin
   if (FQuery <> nil) then
      begin
         if FQuery.Active then
            FQuery.Active := False;
         FreeAndNil(FQuery);
      end;
  inherited;
end;

function TAccountsBase.GetCount: Integer;
begin
   Result := Inherited Count;
end;

procedure TAccountsBase.Load(const AAccRange: TAccRange);
begin
   FAccRange := AAccRange;
   LoadFromDatabase;
end;

procedure TAccountsBase.Load;
begin
   LoadFromDatabase;
end;

procedure TAccountsBase.LoadFromDatabase;
begin
   Clear;
end;

{ TNominalAccount }

constructor TNominalAccount.create;
begin
   Inherited;
   FEntCode:= '';
end;

destructor TNominalAccount.destroy;
begin
  inherited;

end;

{ TNominalAccounts }

function TNominalAccounts.Add(ANominalAccount: TNominalAccount): Integer;
begin
   Result := inherited Add( TNominalAccount(ANominalAccount) );
end;

procedure TNominalAccounts.Clear;
var
   i : Integer;
begin
  for i := 0 to Count-1 do
     begin
        if (TNominalAccount(Items[i]).DefaultProduct <> nil) then
           TNominalAccount(Items[i]).DefaultProduct.Free;
        TNominalAccount(Items[i]).Free;
     end;
  Inherited Clear;
end;

constructor TNominalAccounts.create;
begin
   inherited create;
   FAccRange[1] := 0;
   FAccRange[2] := 0;
   FAccRange[3] := 0;
   FAccRange[4] := 0;
   FAccRange[5] := 0;
   FAccRange[6] := 0;
end;

destructor TNominalAccounts.destroy;
begin
   Clear;
   inherited;
end;

function TNominalAccounts.GetAccountType(
  ANominalId : Integer): TAccountType;
begin
   Result := natNone;
   if ( ANominalId >= Cash1.xNomIncFrom ) and ( ANominalId <= Cash1.xNomIncTo ) Then
      Result := natEntIncome
   else if ( ANominalId >= Cash1.xNomExpFrom ) and ( ANominalId <= Cash1.xNomExpTo ) Then
      Result := natEntExpense
   else if ( ANominalId >= Cash1.xNomNonFrom ) and ( ANominalId <= Cash1.xNomNonTo ) Then
      Result := natNonEntIncome
   else if ( ANominalId >= Cash1.xNomOhFrom ) and ( ANominalId <= Cash1.xNomOhTo ) Then
      Result := natOverhead
   else if ( ANominalId >= Cash1.xNomCaFrom ) and ( ANominalId <= Cash1.xNomCaTo ) Then
      Result := natCurrentAsset
   else if ( ANominalId >= Cash1.xNomFaFrom ) and ( ANominalId <= Cash1.xNomFaTo ) Then
      Result := natFixedAsset
   else if ( ANominalId >= Cash1.xNomLiFrom ) and ( ANominalId <= Cash1.xNomLiTo ) Then
      Result := natLiability
   else if ( ANominalId >= Cash1.xBankMin ) and ( ANominalId <= Cash1.xBankMax ) Then
      Result := natBank
   else if ( ANominalId >= Cash1.xNomTax ) and ( ANominalId <= Cash1.xNomProfit+Cash11.xno_of_partners ) Then
      Result := natControlAccount
   else if ( ANominalId >= Cash1.xnomprvinc) and ( ANominalId < Cash1.xnomprvexp) then
      Result := natPrivateIncome
   else if ( ANominalId >= Cash1.xnomprvexp) and ( ANominalId < Cash1.xnomtax) then
      Result := natPrivateExpense
end;

function TNominalAccounts.GetNominalAccount(const ANominalId : Integer) : TNominalAccount;
var
  i : Integer;
  NominalAccount : TNominalAccount;
begin
  Result := nil;
  for i := 0 to Count-1 do
     begin
        NominalAccount := TNominalAccount(Items[i]);
        if (NominalAccount <> nil) then
           begin
              if ( NominalAccount.Id = ANominalId ) then
                 begin
                    Result := NominalAccount;
                    Break;
                 end;
           end;
     end;
end;

function TNominalAccounts.GetNominalAccount(
  const ANominalName: string): TNominalAccount;
var
  i : Integer;
  NominalAccount : TNominalAccount;
begin
  Result := nil;
  for i := 0 to Count-1 do
     begin
        NominalAccount := TNominalAccount(Items[i]);
        if (NominalAccount <> nil) then
           begin
              if ( NominalAccount.Name = ANominalName ) then
                 begin
                    Result := NominalAccount;
                    Break;
                 end;
           end;
     end;
end;

procedure TNominalAccounts.LoadFromDatabase;
var
   NominalAccount : TNominalAccount;
   NomRec : Integer;
   RangeStart : Integer;
begin
   Inherited LoadFromDatabase;
   RangeStart := 1;

   NomRec := FAccRange[RangeStart];
   SetDb ( NlFile );
   repeat
      repeat
         ReadRec ( NlFile, NomRec );
         dberr;
         if Recactive ( NlFile ) and ( not ExcludeNominal ( NomRec )) then
            begin
               NominalAccount := TNominalAccount.Create;
               NominalAccount.Id := NomRec;
               GetItem ( NlFile, 1 );
               NominalAccount.Name := CurrStr;

               GetItem ( NlFile, 20 );
               NominalAccount.VATCode := CurrStr;

               GetItem ( NlFile, 24 );
               NominalAccount.EntCode := CurrStr;
               NominalAccount.AccountType := GetAccountType(NominalAccount.Id);

               NominalAccount.DefaultProduct := GetNominalDefaultProduct(NominalAccount.Id);

               Add(NominalAccount);
            end;
         Inc ( NomRec );
      until ( NomRec > FAccRange[RangeStart+1] ) or ( NomRec = 0 );

      RangeStart := RangeStart + 2;

      NomRec := FAccRange[RangeStart];
   until
      (FAccRange[RangeStart] = 0) or (RangeStart >5);
end;

function TNominalAccounts.Remove(
  ANominalAccount: TNominalAccount): Integer;
begin
   Result := Inherited Remove ( TNominalAccount(ANominalAccount) ) ;
end;

{ TAccounts }

constructor TAccounts.create(ADatabasePath : string; const ALazyLoading : Boolean);
begin
   DatabasePath := ADatabasePath;
   FIncomeAccounts := TNominalAccounts.Create;
   FExpenseAccounts := TNominalAccounts.Create;
   FBankAccounts := TBankAccounts.Create;
   FAnalysisCodes := TAnalysisCodes.Create;
   FEnterpriseAccounts := TEnterpriseAccounts.Create;
   if not(ALazyLoading) then
      begin
         LoadIncomeAccounts();
         LoadExpenseAccounts();
         LoadBankAccounts();
         LoadAnalysisCodes();
         LoadEnterpriseAccounts();
      end;
end;

destructor TAccounts.destroy;
begin
  inherited;
  if ( FIncomeAccounts <> nil ) then
     FreeAndNil(FIncomeAccounts);
  if ( FExpenseAccounts <> nil ) then
     FreeAndNil(FExpenseAccounts);
  if (FBankAccounts <> nil) then
     FreeAndNil(FBankAccounts);
  if (FAnalysisCodes <> nil) then
     FreeAndNil(FAnalysisCodes);
  if (FEnterpriseAccounts <> nil) then
     FreeAndNil(FEnterpriseAccounts);
end;


function TAccounts.GetExpenseAccounts: TNominalAccounts;
begin
   if (FExpenseAccounts.Count = 0) then
      LoadExpenseAccounts();

   Result := FExpenseAccounts;
end;

procedure TAccounts.SetExpenseAccounts(const Value: TNominalAccounts);
begin
   FExpenseAccounts := Value;
end;

function TAccounts.GetIncomeAccounts: TNominalAccounts;
begin
   if (FIncomeAccounts.Count = 0) then
      LoadIncomeAccounts();

   Result := FIncomeAccounts;
end;

procedure TAccounts.SetIncomeAccounts(const Value: TNominalAccounts);
begin
   FIncomeAccounts := Value;
end;

function TAccounts.GetBankAccounts: TBankAccounts;
begin
   if (FBankAccounts.Count = 0) then
      LoadBankAccounts();

   Result := FBankAccounts;
end;

procedure TAccounts.SetBankAccounts(const Value: TBankAccounts);
begin
   FBankAccounts := Value;
end;

procedure TAccounts.LoadIncomeAccounts;
var
   AccRange : TAccRange;
begin
   // Load Income Accounts
   FillChar(AccRange, SizeOf(TAccRange), 0);

   AccRange[1] := Cash1.xNomIncFrom;
   AccRange[2] := Cash1.xNomIncTo;
   AccRange[3] := Cash1.xNomNonFrom;
   //   05/11/13 [V5.2 R5.1] /MK Bug Fix - Increased range to allow Overheads, Current Assets, Fixed Assets and Liabilities
   //                                      like Andrew TGM's original code allowed.
   AccRange[4] := Cash1.XNOMLITO;
   AccRange[5] := Cash1.xnomprvinc;
   AccRange[6] := Cash1.xnomprvexp-1;

   FIncomeAccounts.Load( AccRange );
end;

procedure TAccounts.LoadExpenseAccounts;
var
   AccRange : TAccRange;
begin
   // Load expense Accounts
   FillChar(AccRange, SizeOf(TAccRange), 0);

   AccRange[1] := Cash1.xNomExpFrom;
   AccRange[2] := Cash1.xNomExpTo;
   AccRange[3] := Cash1.xNomOhFrom;
   //   05/11/13 [V5.2 R5.1] /MK Bug Fix - Increased range to allow Current Assets, Fixed Assets and Liabilities
   //                                      like Andrew TGM's original code allowed.
   AccRange[4] := Cash1.XNOMLITO;
   AccRange[5] := Cash1.xnomprvexp;
   AccRange[6] := Cash1.xnomtax-1;

   FExpenseAccounts.Load( AccRange );
end;

procedure TAccounts.LoadBankAccounts;
var
   AccRange : TAccRange;
begin
   // Load Bank Accounts
   FillChar(AccRange, SizeOf(TAccRange), 0);

   AccRange[1] := Cash1.xBankMin;
   AccRange[2] := Cash1.xBankMax;


   FBankAccounts.Load(AccRange);
end;

procedure TAccounts.Refresh;
begin
   if (FBankAccounts.Count >0) then // only refresh when bank accounts have been previously loaded
      LoadBankAccounts();

   if (FIncomeAccounts.Count >0) then // only refresh when income accounts have been previously loaded
      LoadIncomeAccounts();

   if (FExpenseAccounts.Count >0) then // only refresh when expense accounts have been previously loaded
      LoadExpenseAccounts();

   if (FEnterpriseAccounts.Count >0) then 
      LoadEnterpriseAccounts();
end;

function TAccounts.GetAnalysisCodes: TAnalysisCodes;
begin
   if (FAnalysisCodes.Count = 0) then
      LoadAnalysisCodes();

   Result := FAnalysisCodes;
end;

procedure TAccounts.SetAnalysisCodes(const Value: TAnalysisCodes);
begin
   FAnalysisCodes := Value;
end;

procedure TAccounts.LoadAnalysisCodes;
begin
   FAnalysisCodes.Load();
end;

procedure TAccounts.LoadEnterpriseAccounts;
begin
   FEnterpriseAccounts.Load()
end;

function TAccounts.GetNominalAccount(const ANominalId: Integer): TNominalAccount;
begin
   Result := nil;
   if (( (ANominalId >= FIncomeAccounts.FAccRange[1]) and (ANominalId <= FIncomeAccounts.FAccRange[2]) ) or
       ( (ANominalId >= FIncomeAccounts.FAccRange[3]) and (ANominalId <= FIncomeAccounts.FAccRange[4]) ) or
       ( (ANominalId >= FIncomeAccounts.FAccRange[5]) and (ANominalId <= FIncomeAccounts.FAccRange[6]) )) then
      begin
         Result := FIncomeAccounts.GetNominalAccount(ANominalId)
      end
   else
      begin
         if (( ANominalId >= FExpenseAccounts.FAccRange[1] ) and ( ANominalId <= FExpenseAccounts.FAccRange[2] )) or
            (( ANominalId >= FExpenseAccounts.FAccRange[3] ) and ( ANominalId <= FExpenseAccounts.FAccRange[4] )) or
            (( ANominalId >= FExpenseAccounts.FAccRange[5] ) and ( ANominalId <= FExpenseAccounts.FAccRange[6] )) then
           begin
              Result := FExpenseAccounts.GetNominalAccount(ANominalId)
           end;
      end;
end;


function TAccounts.GetNominalAccount(ANominalName: string;
  ANominalType: TNominalType): TNominalAccount;
begin
   Result := nil;
   if (ANominalType = ntIncome) then
      Result := FIncomeAccounts.GetNominalAccount(ANominalName)
   else if (ANominalType = ntExpense) then
      Result := FExpenseAccounts.GetNominalAccount(ANominalName)
end;

{ TBankAccounts }

procedure TBankAccounts.LoadFromDataBase;
var
   BankAccount : TBankAccount;
   NomRec : Integer;
   RangeStart : Integer;
begin
   Inherited LoadFromDatabase;

   RangeStart := 1;

   NomRec := FAccRange[RangeStart];
   SetDb ( NlFile );
   repeat
      repeat
         ReadRec ( NlFile, NomRec );
         dberr;
         if Recactive ( NlFile ) and ( not ExcludeNominal ( NomRec )) then
            begin
               GetItem ( NlFile, 1 );
               if (CurrStr <> '') then
                  begin
                     BankAccount := TBankAccount.Create;
                     BankAccount.Id := NomRec;
                     BankAccount.Name := CurrStr;
                     BankAccount.AccountType := natBank;
                     BankAccount.BankFileFormat := GetBankFileFormat(BankAccount.Id);

                     Add(BankAccount);
                  end;
            end;
         Inc ( NomRec );
      until ( NomRec > FAccRange[RangeStart+1] ) or ( NomRec = 0 );

      RangeStart := RangeStart + 2;

      NomRec := FAccRange[RangeStart];
   until
      (FAccRange[RangeStart] = 0) or (RangeStart >5);
end;

function TBankAccounts.Add(ABankAccount: TBankAccount): Integer;
begin
   Result := inherited Add( TBankAccount(ABankAccount) );
end;

procedure TBankAccounts.Clear;
var
   i : Integer;
begin
  for i := 0 to Count-1 do
     TBankAccount(Items[i]).Free;
  Inherited Clear;
end;

constructor TBankAccounts.create;
begin
   Inherited Create;
   FAccRange[1] := 0;
   FAccRange[2] := 0;
   FAccRange[3] := 0;
   FAccRange[4] := 0;
   FAccRange[5] := 0;
   FAccRange[6] := 0;

   FQuery.SQL.Text := 'SELECT BankFileFormat FROM BankExt WHERE BankId =:ABankId';
end;

destructor TBankAccounts.destroy;
begin
   Clear;
   inherited;
end;

function TBankAccounts.GetBankAccount(
  const ABankId: Integer): TBankAccount;
var
  i : Integer;
  BankAccount : TBankAccount;
begin
  Result := nil;
  for i := 0 to Count-1 do
     begin
        BankAccount := TBankAccount(Items[i]);
        if (BankAccount <> nil) then
           begin
              if ( BankAccount.Id = ABankId ) then
                 begin
                    Result := BankAccount;
                    Break;
                 end;
           end;
     end;
end;

function TBankAccounts.GetBankAccount(
  const ABankName: string): TBankAccount;
var
  i : Integer;
  BankAccount : TBankAccount;
begin
  Result := nil;
  for i := 0 to Count-1 do
     begin
        BankAccount := TBankAccount(Items[i]);
        if (BankAccount <> nil) then
           begin
              if ( BankAccount.Name = ABankName ) then
                 begin
                    Result := BankAccount;
                    Break;
                 end;
           end;
     end;
end;

function TBankAccounts.Remove(ABankAccount: TBankAccount): Integer;
begin
   Result := Inherited Remove(TBankAccount(ABankAccount));
end;

function TBankAccounts.First: TBankAccount;
begin
   Result := nil;
   if (Count > 0) then
      Result := TBankAccount(Items[0]);
end;

function TBankAccounts.GetBankFileFormat(ABankId : Integer) : Integer;
begin
   FQuery.Active := False;
   FQuery.Params[0].AsInteger := ABankId;
   FQuery.Active := True;
   try
      Result := FQuery.Fields[0].AsInteger;
   finally
      FQuery.Active := False;
   end;
end;

{ TAnalysisCodes }

constructor TAnalysisCodes.create;
begin
   inherited create;
end;

function TAnalysisCodes.DefaultAnalysisCode: TAnalysisCode;
begin
   Result := nil;
   if (Count > 0) then
      Result := TAnalysisCode(Items[0]);
end;

destructor TAnalysisCodes.destroy;
begin
  inherited;

end;

function TAnalysisCodes.GetAnalysisCode(
  const ACode: string): TAnalysisCode;
var
  i : Integer;
begin
   Result := nil;
   for i := 0 to Count-1 do
      if (TAnalysisCode(Items[i]).Id = StrToInt(ACode)) then
         begin
            Result := TAnalysisCode(Items[i]);
            Break;
         end;
   {FQuery.SQL.Text := 'SELECT Number, Description FROM Analysis WHERE (ANumber=:ACode)';
   FQuery.Params[0].AsInteger := x;
   FQuery.Open;

   try
      Result := FQuery.RecordCount > 0;
   finally
      FQuery.Close;
   end;
    }
end;

procedure TAnalysisCodes.LoadFromDataBase;
var
  AnalysisCode : TAnalysisCode;
begin
  Inherited LoadFromDatabase;

  with FQuery do
     begin
        SQL.Text := 'SELECT Number, Description FROM Analysis';
        Open;

        First;
        try
           while not eof do
              begin
                 AnalysisCode := TAnalysisCode.Create;
                 AnalysisCode.Id := Fields[0].AsInteger;
                 AnalysisCode.Name := Fields[1].AsString;
                 Add(AnalysisCode);

                 Next;
              end;
        finally
           Close;
        end;
     end;
end;

{ TEnterpriseAccounts }

function TEnterpriseAccounts.Add(AEnterpriseAccount: TEnterpriseAccount): Integer;
begin
   Result := inherited Add( TEnterpriseAccounts(AEnterpriseAccount) );
end;

procedure TEnterpriseAccounts.Clear;
var
   i : Integer;
begin
  for i := 0 to Count-1 do
     TEnterpriseAccount(Items[i]).Free;
  inherited Clear;
end;

constructor TEnterpriseAccounts.create;
begin
   inherited create;
end;

destructor TEnterpriseAccounts.destroy;
var
   i : Integer;
begin
  Clear;
  inherited destroy;
end;

function TEnterpriseAccounts.GetEnterpriseAccountByIndex(
  Index: Integer): TEnterpriseAccount;
begin
   Result := TEnterpriseAccount(inherited Items[Index] );
end;

function TEnterpriseAccounts.GetEnterpriseAccount(
  ACode: string): TEnterpriseAccount;
var
  i : Integer;
  EnterpriseAccount : TEnterpriseAccount;
begin
  Result := nil;
  for i := 0 to Count-1 do
     begin
        EnterpriseAccount := TEnterpriseAccount(Items[i]);
        if (EnterpriseAccount <> nil) then
           begin
              if ( EnterpriseAccount.Code = ACode ) then
                 begin
                    Result := EnterpriseAccount;
                    Break;
                 end;
           end;
     end;
end;

function TEnterpriseAccounts.IndexOf(
  AEnterpriseCode: string): TEnterpriseAccount;
begin

end;

procedure TEnterpriseAccounts.Load;
begin
   LoadFromDB();
end;

procedure TEnterpriseAccounts.LoadFromDB;
var
   LastEnterprise,
   ArrPos,
   EntRec : Integer;
   EnterpriseAccount : TEnterpriseAccount;
begin
   ArrPos := 0;
   EntRec := 1;
   SetDb ( EntFile );
   LastEnterprise := db1.dbrechigh;
   repeat
      ReadRec ( EntFile, EntRec );
      dberr;
      if Recactive ( EntFile ) then
         begin
            EnterpriseAccount := TEnterpriseAccount.Create;
            EnterpriseAccount.Id := EntRec;
            dbCore.GetItem ( EntFile, 1 );
            EnterpriseAccount.Code := CurrStr;
            dbCore.GetItem ( EntFile, 2 );
            PadRight ( CurrStr, 20 );
            EnterpriseAccount.Name := Copy ( CurrStr, 1, 17 );
            dbCore.GetItem ( EntFile, 14 );
            if ( CurrLong > 0 ) then
               EnterpriseAccount.JobCardEnabled := bool(CurrLong)
            else
               EnterpriseAccount.JobCardEnabled := False;
            Add(EnterpriseAccount);
         end;
      Inc ( EntRec );
   until ( EntRec > LastEnterprise  ) Or ( EntRec = 0 );
end;

function TEnterpriseAccounts.Remove(
  AEnterpriseAccount: TEnterpriseAccount): Integer;
begin

end;

procedure TEnterpriseAccounts.SetEnterpriseAccountByIndex(Index: Integer;
  const Value: TEnterpriseAccount);
begin

end;

function TEnterpriseAccounts.Update(
  const AEnterpriseAccount: TEnterpriseAccount) : Boolean;
begin
   Result := False;
   with FQuery do
      try
         SQL.Clear;
         SQL.Add('UPDATE EntsFile SET JobCardEnabled = :arg1');
         SQL.Add('WHERE EntNo =:arg2');
         Params[0].AsBoolean := AEnterpriseAccount.JobCardEnabled;
         Params[1].AsInteger := AEnterpriseAccount.Id;
         ExecSQL;

         Result := True;
      except
      end;
end;

function TEnterpriseAccounts.GetEnterpriseAccount(
  AId: Integer): TEnterpriseAccount;
var
  i : Integer;
  EnterpriseAccount : TEnterpriseAccount;
begin
  Result := nil;
  for i := 0 to Count-1 do
     begin
        EnterpriseAccount := TEnterpriseAccount(Items[i]);
        if (EnterpriseAccount <> nil) then
           begin
              if ( EnterpriseAccount.Id = AId ) then
                 begin
                    Result := EnterpriseAccount;
                    Break;
                 end;
           end;
     end;
end;

{ TEnterpriseAccount }

constructor TEnterpriseAccount.create;
begin
   inherited create;
end;

destructor TEnterpriseAccount.destroy;
begin
   inherited destroy;
end;

{ TAppJobCard }

constructor TAppJobCard.create;
begin
  Operator := TAccountBase.Create;
  Customer := TAccountBase.Create;
  Activity := TAccountBase.Create;
  Product1 := TAccountBase.Create;
end;

destructor TAppJobCard.destroy;
begin
   if Assigned(FOperator) then
      FreeAndNil(FOperator);
   if Assigned(FCustomer) then
      FreeAndNil(FCustomer);
   if Assigned(FActivity) then
      FreeAndNil(FActivity);
   if Assigned(FProduct1) then
      FreeAndNil(FProduct1);
   inherited destroy;
end;


{ TAppJobCards }

function TAppJobCards.Add(AJobCard: TAppJobCard): Integer;
begin
   Result := inherited Add( TAppJobCard(AJobCard) );
end;

procedure TAppJobCards.Clear;
var
   i : Integer;
begin
  for i := 0 to Count-1 do
     TAppJobCard(Items[i]).Free;
  Inherited Clear;
end;

constructor TAppJobCards.create;
begin
   Inherited Create;
end;

destructor TAppJobCards.destroy;
begin
   Clear;
   inherited;
end;

function TAppJobCards.Get(const AClientId: string): TAppJobCard;
var
  i : Integer;
  JobCard : TAppJobCard;
begin
  Result := nil;
  for i := 0 to Count-1 do
     begin
        JobCard := TAppJobCard(Items[i]);
        if (JobCard <> nil) then
           begin
              if ( JobCard.ClientId = AClientId ) then
                 begin
                    Result := JobCard;
                    Break;
                 end;
           end;
     end;
end;

function TAppJobCards.GetCount: Integer;
begin
   Result := inherited Count;
end;

function TAppJobCards.GetJobCard(Index: Integer): TAppJobCard;
begin
   Result := TAppJobCard(inherited Items[Index] );
end;

function TAppJobCards.IndexOf(AClientId: string): TAppJobCard;
begin
   Result := Get(AClientId);
end;

function TAppJobCards.Remove(AJobCard: TAppJobCard): Integer;
begin
   Result := Inherited Remove ( TAppJobCard(AJobCard) ) ;
end;

procedure TAppJobCards.SetJobCard(Index: Integer;
  const Value: TAppJobCard);
begin
   Items[Index] := Value;
end;

function TAppJobCard.GetUnitAndQuantityAsString: string;
begin
   Result := FloatToStr(Quantity) + ' ' + UnitType;
end;

{ TMTDVATReceipt }

constructor TMTDVATReceipt.create;
begin
   FVATReturn := TMTDVATReturn.create();
end;

function TMTDVATReceipt.CreateStamp(const ATransactionId: string): string;
begin
   try
      Result := Format('KW_MTD_TRANSACTION_ID={%s}&PROCESSING_DATE={%s}&PAYMENT_INDICATOR={%s}&FORM_BUNDLE_NUMBER={%s}&CHARGE_REF_NUMBER={%s}',
       [ATransactionId,FProcessingDate,FPaymentIndicator,FBundleNumber,'']);
   except
      Result := '';
   end;
end;

destructor TMTDVATReceipt.destroy;
begin
  inherited;
  if (FVATReturn<>nil) then
     FreeAndNil(FVATReturn);
end;

{ TMTDVATReturnRequest }

procedure TMTDVATReturnRequest.AddHeader(const AKey, AValue: string);
begin
   if (FHttpRequestHeaders='') then
      FHttpRequestHeaders := AKey+'='+AValue
   else
      FHttpRequestHeaders := FHttpRequestHeaders+';'+AKey+'='+AValue
end;

function TMTDVATReturnRequest.GetJSON: string;
begin
   Result := Format(
     '{ '+
     'vrn:"%s", '+
     'periodStart: "%s", '+
     'periodEnd: "%s", '+
     'vatDueSales: %s, '+
     'vatDueAcquisitions: %s, '+
     'totalVATDue: %s, '+
     'vatReclaimedCurrPeriod: %s,'+
     'netVATDue: %s, '+
     'totalValueSalesExVAT: %s, '+
     'totalValuePurchasesExVAT: %s, '+
     'totalValueGoodsSuppliedExVAT: %s,'+
     'totalAcquisitionsExVAT: %s,'+
     'transactionId:"%s",'+
     'fraudPreventionHeaders: "%s" '+
     '}',
     [
     FVRN,
     PeriodStart,
     PeriodEnd,
     FloatToStr(VatDueSales),
     FloatToStr(VatDueAcquisitions),
     FloatToStr(TotalVATDue),
     FloatToStr(VatReclaimedCurrPeriod),
     FloatToStr(NetVATDue),
     FloatToStr(TotalValueSalesExVAT),
     FloatToStr(TotalValuePurchasesExVAT),
     FloatToStr(TotalValueGoodsSuppliedExVAT),
     FloatToStr(TotalAcquisitionsExVAT),
     TransactionId,
     HttpRequestHeaders
     ]);
end;


end.

