unit HTTP;

interface
uses
  Classes, IdHTTP, IdSSLOpenSSL;

type
  THTTP = class
  protected
     function CreateSSLHandler() : TIdSSLIOHandlerSocket;
  public
     function Post(const AUrl: string; const AContent: string;
        const AContentType: string; const ACustomHeaders: TStrings): string;
     function Get(const AUrl: string; const AContentType: string;
        const ACustomHeaders: TStrings): string;
  end;
implementation

{ THTTP }

function THTTP.CreateSSLHandler: TIdSSLIOHandlerSocket;
begin
   Result := TIdSSLIOHandlerSocket.Create(nil);
   Result.SSLOptions.Method := sslvSSLv23;
   Result.SSLOptions.Mode := sslmUnassigned;
end;

function THTTP.Get(const AUrl: string; const AContentType: string;
  const ACustomHeaders: TStrings): string;
var
   SSLHandler: TIdSSLIOHandlerSocket;
   i : Integer;
begin
   with TIdHTTP.Create(nil) do
   try
      AllowCookies := False;
      SSLHandler := CreateSSLHandler();
      try
         IOHandler := SSLHandler;
         if (ACustomHeaders<>nil) then
            begin
               for i := 0 to ACustomHeaders.Count-1 do
                  Request.CustomHeaders.Values[ACustomHeaders.Names[i]] := ACustomHeaders.Values[ACustomHeaders.Names[i]];
            end;
         Request.ContentType := AContentType;
         Result := Get(AUrl);
     finally
       SSLHandler.Free;
     end;
  finally
    Free;
  end;
end;

function THTTP.Post(const AUrl, AContent, AContentType: string;
  const ACustomHeaders: TStrings): string;
var
   SSLHandler: TIdSSLIOHandlerSocket;
   StringStream: TStringStream;
   i : Integer;
begin
   StringStream := TStringStream.Create(AContent);
   with TIdHTTP.Create(nil) do
   try
      SSLHandler := CreateSSLHandler();
      try
         IOHandler := SSLHandler;

         Request.ContentType := AContentType;
         if (ACustomHeaders<>nil) then
            begin
               for i := 0 to ACustomHeaders.Count-1 do
                  Request.CustomHeaders.Values[ACustomHeaders.Names[i]] := ACustomHeaders.Values[ACustomHeaders.Names[i]];
            end;
         Result := Post(AUrl, StringStream);
      finally
         SSLHandler.Free;
      end;
   finally
     StringStream.Free;
     Free;
   end;
end;

end.
