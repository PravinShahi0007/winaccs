unit uApplicationLog;

interface
uses
   Classes, Windows, Sysutils, KRoutines;
type
   ApplicationLog = class
   private
   public
      class procedure LogError(AError : string);
      class procedure LogException(AException : Exception);
      class procedure LogDebugMessage(AMessage : string);
      class procedure LogInfo(AMessage: string);
      class procedure LogWarning(AMessage: string);
      class procedure DeleteDebugFile;
      class procedure LogDebugTickCountTimer(ACounterDesc : String; AStartTime, AEndTime : Integer);
      class procedure LogOpeningProgramError(AError : String);
      class procedure LogOpeningProgramException(AException : Exception);
   end;

const
   DefaultDirectory = 'C:\Kingsacc';

implementation

{ TApplicationLog }

class procedure ApplicationLog.DeleteDebugFile;
begin
   if ( FileExists(DefaultDirectory +'\debuglog.txt') ) then
      DeleteFile(DefaultDirectory +'\debuglog.txt');
end;

class procedure ApplicationLog.LogDebugMessage(AMessage: string);
var
   Entry : string;
begin
   Entry := Format('[DEBUG ENTRY: %s]',[FormatDateTime('dd/MM/yyyy hh:nn:ss',Now)]) + #13#10 + #13#10 +
                   AMessage + #13#10 + #13#10 +
                   '[END]' + #13#10 + #13#10;
   InsertAllText(Entry, DefaultDirectory +'\debuglog.txt');
end;

class procedure ApplicationLog.LogDebugTickCountTimer(ACounterDesc : String; AStartTime, AEndTime : Integer);
var
   Entry : string;
begin
   ACounterDesc := Format(ACounterDesc+ ' Elapsed Seconds: %s',[FormatFloat('0.00',((AEndTime - AStartTime) / 1000) / 60)]);
   Entry := Format('[DEBUG ENTRY: %s]',[FormatDateTime('dd/MM/yyyy hh:nn:ss',Now)]) + #13#10 + #13#10 +
                   ACounterDesc + #13#10 + #13#10 +
                   '[END]' + #13#10 + #13#10;
   InsertAllText(Entry, DefaultDirectory +'\debuglog.txt');
end;

class procedure ApplicationLog.LogError(AError: string);
var
   Entry : string;
begin
   Entry := Format('[ERROR: %s]',[FormatDateTime('dd/MM/yyyy hh:nn:ss',Now)]) + #13#10 + #13#10 +
                   AError + #13#10 + #13#10 +
                   '[END]' + #13#10 + #13#10;
   InsertAllText(Entry, DefaultDirectory +'\applog.txt');
end;

class procedure ApplicationLog.LogException(AException: Exception);
var
   Entry : string;
begin
   Entry := Format('[EXCEPTION: %s]',[FormatDateTime('dd/MM/yyyy hh:nn:ss',Now)]) + #13#10 + #13#10 +
                   AException.Message + #13#10 + #13#10 +
                   '[END]' + #13#10 + #13#10;
   InsertAllText(Entry, DefaultDirectory +'\applog.txt');
end;

class procedure ApplicationLog.LogInfo(AMessage: string);
var
   Entry : string;
begin
   Entry := Format('[INFO: %s]',[FormatDateTime('dd/MM/yyyy hh:nn:ss',Now)]) + #13#10 + #13#10 +
                   AMessage + #13#10 + #13#10 +
                   '[END]' + #13#10 + #13#10;
   InsertAllText(Entry, DefaultDirectory +'\applog.txt');
end;

class procedure ApplicationLog.LogOpeningProgramError(AError: String);
var
   Entry : string;
begin
   Entry := Format('[ERROR: %s]',[FormatDateTime('dd/MM/yyyy hh:nn:ss',Now)]) + #13#10 + #13#10 +
                   AError + #13#10 + #13#10 +
                   '[END]' + #13#10 + #13#10;
   InsertAllText(Entry, DefaultDirectory +'\applog_openProgram.txt');
end;

class procedure ApplicationLog.LogOpeningProgramException(AException: Exception);
var
   Entry : string;
begin
   Entry := Format('[EXCEPTION: %s]',[FormatDateTime('dd/MM/yyyy hh:nn:ss',Now)]) + #13#10 + #13#10 +
                   AException.Message + #13#10 + #13#10 +
                   '[END]' + #13#10 + #13#10;
   InsertAllText(Entry, DefaultDirectory +'\applog_openProgram.txt');
end;

class procedure ApplicationLog.LogWarning(AMessage: string);
var
   Entry : string;
begin
   Entry := Format('[WARNING: %s]',[FormatDateTime('dd/MM/yyyy hh:nn:ss',Now)]) + #13#10 + #13#10 +
                   AMessage + #13#10 + #13#10 +
                   '[END]' + #13#10 + #13#10;
   InsertAllText(Entry, DefaultDirectory +'\applog.txt');
end;

end.
