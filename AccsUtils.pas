{
   29/09/20 [V4.5 R3.9] /MK Change - Add two new functions - GetUserDownloadsDir - Gets users Desktop/Downloads folder (whichever directory has CSV files).
                                                           - GetUserDownloadsDir - Get the Downloads directory.

   14/10/20 [V4.5 R4.3] /MK Change - Prompted_Validated_Saved_MTDCredentials - Added new function to prompt, validate and store MDT Credentials.

   20/10/20 [V4.5 R4.4] /MK Bug Fix - Prompted_Validated_Saved_MTDCredentials - Result of MTDApi.ValidateCredentials() was being returned as reverse.
}

unit AccsUtils;

interface

uses
   Windows, Classes, Dialogs, Types, Forms, WinInet, NB30,
   LoginCredentials, uLoginCredentials, uMTDApi, Controls,
   CredentialsStore;

type
  TStringArray = Array of String;
  TIntArray = array of Integer;

  function IsDebugging : Boolean;
  procedure ShowDebugMessage(AMessage : string);
  function PadString(const AString : string; const APadChar : Char; ALength : Integer) : string;
  function StripLeadingZero(const AString : string) : string;
  function StripAllNomNumAlpha(StrToStrip: String): String;
  function StripSpaces( StrToStrip : String) : String;
  function StripAllSpaces(StrToStrip: String): String;

  function IsAlphaNumeric(AString : String) : Boolean;
  function IsNumeric(AString : string; const ACheckIsFormatted : Boolean = false) : Boolean;
  function StrArrayToSQLInString( const AValue : TStringArray ) : string;
  function IntArrayToSQLInString( const AValue : TIntArray ) : string;
  procedure GetDirectoryFiles(const ADirectory : String;
      AFileList : TStrings; const FileType : string = '*.*');
  function DesktopDirectory : string;
  function GetSpecialFolder(Location : LongInt) : String;
  function GetFileCreationDate(const AFile: string): TDateTime;
  function FormatDate(const ADate : TDateTime; const DateStyle : TDateStyle; AFourDigitYear : Boolean = true) : string;
  function DefaultRemovableDrive: string;
  function RemovableDriveCount: Integer;
  function ApplicationPath : string;
  procedure CreateDirectory(const Dir : String; const RaiseExceptionOnFail : Boolean = True);
  function CheckBackupFileName(const sDir: String): Boolean;
  function AToZ : string;
  function ExtractDirFromPath(DirPath : String) : String;
  function GetParentDirectory(path : string) : string;

  function IsAccountant (AFarmgateSerialNo : Integer) : Boolean;

  function ForceTopMostMessageDlg(const Msg: string; DlgType: TMsgDlgType;
     Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;

  procedure InvokeExternalProgram(ProgramPath : String);
  function IsNetConnected : boolean;

  function VarIsNullOrEmpty(const V: Variant): Boolean;
  function VarToDouble(const V: Variant): Double;

  procedure ChangeToLongValue(var AString : ShortString);
  function VarToLongStr(var AValue : Variant): ShortString;
  function SplitString(const AString : string; const ASeperator : string = ',') : TStringArray;overload;
  function SplitString(const AString : string; const ASeperator : string;
     const AIncludeEmptyStrings: Boolean) : TStringArray;overload;

  function IsEmpty(const AString : string): Boolean;

  procedure InsertAllText(AText, AFileName : string);
  procedure WriteAllText(AText, AFileName : string);
  function ReadAllText(AFileName : string) : string;

  procedure GetDatabases(ADirList : TStrings; const AIncludeArchived : Boolean = false);

  function GUID: String;
  function ClientSecretIsValid(const AValue: string): Boolean;
  procedure Parse(const Line: string; const ASeparator: string; AFields: TStrings);

  function _MessageDlg(const Msg: string; DlgType: TMsgDlgType;
   Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;

  function GetShortMonthNameDate(AStrDate : String) : TDateTime;
  function MonthIsShortName(AValue : String) : Boolean;
  function IfThenElse(const Condition: Boolean; const AConsequent : Variant; const AAlternative: Variant) : Variant;

  function FlipNegative(const AValue : string): string;
  function URLEncode(s: string): string;
  function GetIPAddress(): string;
  function GetMACAddress: string;

  function GetUserDownloadsDir : String;
  function GetDownloadedCSVDir : string;

  
  // Support for MTD Anti Fraud Measures
  function ClientDeviceID : string;
  function UTCDateTimeAsString(): string;

const
   CSIDL_DESKTOP = $00;

implementation
uses
   FileCtrl, Sysutils, ShlObj, ActiveX, DBGen, uParser, Clears, Winsock, Registry;


function IsDebugging : Boolean;
begin
   Result := FindWindow(nil,'Delphi 5 - Winaccs [Running]')>0;
end;

procedure ShowDebugMessage(AMessage : string);
begin
   if (IsDebugging) then
      ShowMessage(AMessage);
end;

function PadString(const AString : string; const APadChar : Char; ALength : Integer) : string;
begin
   Result := AString;
   while length(Result) < ALength do
      Result := ConCat ('0',Result);
end;

function StripLeadingZero(const AString : string) : string;
begin
   Result := AString;
   while Length(Result) > 1 do
      begin
         if Result[1] = '0' then
            Delete(Result, 1, 1)
         else
            Break;
      end;
end;

function IsNumeric(AString : string; const ACheckIsFormatted : Boolean = false) : Boolean;
var
   i : Integer;
begin
   Result := False;
   AString := Trim(AString);
   if ( Length(AString) = 0 ) then Exit;

   Result := True;
   for i := 1 to Length(AString) do
      begin
         if ACheckIsFormatted then
            begin
               if not (AString[i] in ['0'..'9', ',', '-', '.']) then
                  begin
                     Result := False;
                     Break;
                  end;
            end
         else
            begin
               if not (AString[i] in ['0'..'9']) then
                  begin
                     Result := False;
                     Break;
                  end;
            end
      end;
end;

function AppDir : string;
begin
   Result := ExtractFilePath( ParamStr(0));
end;

procedure InvokeExternalProgram(ProgramPath : String);
var
   TSI : TStartUpInfo;
   TPI : TProcessInformation;
begin
   // this opens the file/program passed to it and waits for it to finish
   // before passing back control to WinHerd - kr
   FillChar(TSI,SizeOf(TSI),0);
   TSI.CB      := SizeOf(TSI);
   TSI.dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
   // this is the call to execute program
   if CreateProcess(NIL,PChar(ProgramPath),NIL,NIL,False,
                    NORMAL_PRIORITY_CLASS,NIL,NIL,TSI,TPI) then
      begin
         // this is where it waits
         WaitForInputIdle(TPI.hProcess,INFINITE);
         WaitForSingleObject(TPI.hProcess,INFINITE);
      end;
end;

function StrArrayToSQLInString( const AValue : TStringArray ) : string;
var
   I : Integer;
begin
   if Length( AValue ) < 1 then
      Result := '()'
   else if Length( AValue ) = 1 then
      begin
         Result := '(' +  '"'+AValue[ 0 ]+'"'  +')';
      end
   else
      begin
         for I := 0 to Length( AValue ) - 1 do      // Iterate
            begin
               if Length( Result ) = 0 then
                  Result := '(' +  '"'+ AValue[ I ] +'"'
               else
                  Result := Result +', '+  '"'+ AValue[ I ] +'"';
            end;  // for
         Result := Result + ')';
       end;
end;

function IntArrayToSQLInString( const AValue : TIntArray ) : string;
var
   I : Integer;
begin
   Result := '';
   if Length( AValue ) = 1 then
      begin
         Result := '(' + IntToStr( AValue[ 0 ] ) +')';
      end
   else
      begin
         for I := 0 to Length( AValue ) - 1 do      // Iterate
            begin
               if Length( Result ) = 0 then
                  Result := '(' + IntToStr( AValue[ I ] )
               else
                  Result := Result +', '+  IntToStr( AValue[ I ] );
            end;  // for
         if Result <> '' then
            Result := Result + ')'
         else
            Result := Result + '()'
       end;

end;

procedure GetDirectoryFiles(const ADirectory : String;
  AFileList : TStrings; const FileType : string = '*.*');
var
   i : Integer;
   SearchRec : TSearchRec;
   ScanDir : String;
begin
   if AFileList = nil then
      AFileList := TStringList.Create;

   AFileList.Clear;
   ScanDir := IncludeTrailingBackslash( ADirectory);
   i := FindFirst( ScanDir + FileType , faAnyFile , SearchRec ) ;
   if i = 0 then
     begin
        if ( SearchRec.Name <> '.' ) and ( SearchRec.Name <> '..' ) then
           begin
              AFileList.Add(ScanDir + SearchRec.Name);
           end;

        while FindNext( SearchRec ) = 0 do
           if ( SearchRec.Name <> '.' ) and ( SearchRec.Name <> '..' ) then
              begin
                 AFileList.Add( ScanDir + SearchRec.Name);
              end;
        SysUtils.FindClose( SearchRec ) ;
     end;
end;

function DesktopDirectory : string;
begin
   Result := GetSpecialFolder(CSIDL_DESKTOP);
end;

function GetSpecialFolder(Location : LongInt) : String;
var
   pItemList : pItemIDList;
   ItemPath : Array [0..MAX_PATH] of Char;
   MemAlloc : IMalloc;
begin
   Result := '';
   if SUCCEEDED(SHGetSpecialFolderLocation(0, Location, pItemList)) then
      begin
         if pItemList <> nil then
            begin
               if SHGetPathFromIDList(pItemList, ItemPath) then
                  begin
                     Result := StrPas(ItemPath);
                     if Result[Length(Result)] <> '\' then
                        Result := Result + '\';
                  end;
            end;
      end;
  if Succeeded(SHGetMalloc(MemAlloc)) then
     MemAlloc.Free(pItemList);
end;

function GetFileCreationDate(const AFile: string): TDateTime;
var
  FileH : THandle;
  LocalFT : TFileTime;
  DosFT : DWORD;
  CreationDateTime : TDateTime;
  FindData : TWin32FindData;
begin
  Result := 0;
  FileH := FindFirstFile(PChar(AFile), FindData) ;
  if FileH <> INVALID_HANDLE_VALUE then
     begin
        if (FindData.dwFileAttributes AND FILE_ATTRIBUTE_DIRECTORY) = 0 then
            begin
               FileTimeToLocalFileTime(FindData.ftCreationTime,LocalFT) ;
               FileTimeToDosDateTime(LocalFT,LongRec(DosFT).Hi,LongRec(DosFT).Lo);
               CreationDateTime := FileDateToDateTime(DosFT);
               Result := CreationDateTime;
            end;
     end;
  Windows.FindClose(FileH) ;
end;

function FormatDate(const ADate : TDateTime; const DateStyle : TDateStyle; AFourDigitYear : Boolean) : string;
var
   YearDigits : string;
   DateFormat : string;
begin
   Result := '';
   if ADate > 0 then
      begin
         if AFourDigitYear then
            YearDigits := 'yyyy'
         else
            YearDigits := 'yy';
         if DateStyle = dsIrish then
            DateFormat := Format('dd/mm/%s', [YearDigits])
         else
            DateFormat := Format('mm/dd/%s', [YearDigits]);
         Result := FormatDateTime(DateFormat, ADate);
      end;
end;

function DefaultRemovableDrive: string;
var
  Drive: Char;
  DriveLetter: String;
begin
  Result := '';
  for Drive := 'B' to 'Z' do
  begin
   DriveLetter := Drive + ':\';
   if GetDriveType(PChar(Drive + ':\')) = DRIVE_REMOVABLE then
      begin
         Result :=  DriveLetter;
         Break;
      end;
  end;
end;

function RemovableDriveCount: Integer;
var
  Drive: Char;
begin
  Result := 0;
  for Drive := 'B' to 'Z' do
  begin
   if GetDriveType(PChar(Drive + ':\')) = DRIVE_REMOVABLE then
   Inc( Result ) ;
  end;
end;

function ApplicationPath : string;
begin
   Result := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));
end;

procedure CreateDirectory(const Dir : String; const RaiseExceptionOnFail : Boolean = True);
begin
   if DirectoryExists(Dir) then Exit;
   if not CreateDir(Dir) then
      if RaiseExceptionOnFail then
         raise Exception.CreateFmt('Unable to create directory %s, contact Kingswood',[Dir]);
end;

function CheckBackupFileName(const sDir: String): Boolean;
var
  x : Byte;
begin
   Result := True;
   for x := 1 to Length(sDir) do
      begin
         if not( sDir[x] in ['a'..'z', 'A'..'Z', '0'..'9', ' '] ) then
            begin
               Result := False;
               Exit;
            end
      end;
end;

function ForceTopMostMessageDlg(const Msg: string; DlgType: TMsgDlgType;
   Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
begin
   Application.NormalizeTopMosts;
   try
      // forces the messagedlg to be shown top most preventing the dialog
      // from being hidden behind the top most form.
      Result := MessageDlg(msg,DlgType,Buttons,HelpCtx);
   finally
      Application.RestoreTopMosts;
   end;
end;

{ NET METHODS }

function IsNetConnected : boolean;
var
   InetState: DWORD;
   hHttpSession, hReqUrl: HInternet;
   dwConnectionTypes: DWORD;
begin
   dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY;
   Result := InternetGetConnectedState(@dwConnectionTypes, 0);
   if not Result then
      begin
         hHttpSession := InternetOpen(PChar('Kingswood Computing Ltd.'), INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
         try
            hReqUrl := InternetOpenURL(hHttpSession, 'http://www.google.com', nil, 0,0,0);
            Result := hReqUrl <> nil;
            InternetCloseHandle(hReqUrl);
         finally
            InternetCloseHandle(hHttpSession);
         end;
      end;
end;

function AToZ : string;
var
   i : integer;
begin
   for i := 65 to 90 do result := result + chr(i);
end;

function ExtractDirFromPath(DirPath : String) : String;
var
   x : Byte;
begin
   Result := '';
   DirPath := ExcludeTrailingBackslash(DirPath);
   for x := Length(DirPath) downto 1 do
      begin
         if DirPath[x] = '\' then
            Break
         else
            Result := DirPath[x] + Result;
      end;
end;

function VarIsNullOrEmpty(const V: Variant): Boolean;
begin
   Result := VarIsNull(V) or VarIsEmpty(V);
end;

function VarToDouble(const V: Variant): Double;
begin
   if not VarIsNullOrEmpty(V) then
      try
         Result := StrToFloat(VarToStr(V));
      except
         Result := 0;
      end
   else
      Result := 0;
end;

//returns the parent directory for the
//provided "path" (file or directory)
function GetParentDirectory(path : string) : string;
begin
   result := IncludeTrailingBackslash(ExpandFileName(path + '\..'));
end;

procedure ChangeToLongValue(var AString: ShortString);
var
   TempStr  : ShortString;
begin
   ChangeToLong ( TempStr );
end;

function VarToLongStr(var AValue : Variant): ShortString;
var
   TempStr : ShortString;
begin
   Result := '';

   if VarIsNull(AValue) then Exit;

   TempStr := AValue;
   if TempStr = '' then Exit;

   SlimAll ( TempStr );
   try
      ChangeToLong ( TempStr );
      Result := TempStr;
   except
   end;
end;

function SplitString(const AString : string;
   const ASeperator : string = ',') : TStringArray;
var
   i, Index : Integer;
   Parser : TParser;
   Value : String;
begin
   Index := 0;
   Parser := TParser.Create;
   try
      Parser.FieldSep := ASeperator;
      Parser.Parse(AString);

      for i:= 1 to Parser.Parsecount do
         begin
            Value := Trim(Parser.Parsefields[i]);
            if length(Trim(Value)) > 0 then
               begin
                  SetLength(Result, Index+1);

                  Result[Index] := Value;
                  Inc(Index);
               end;
         end;
   finally
      if ( Parser <> nil ) then Parser.Free;
   end;
end;

function SplitString(const AString : string; const ASeperator : string;
  const AIncludeEmptyStrings: Boolean) : TStringArray;overload;
var
   i, Index : Integer;
   Parser : TParser;
   Value : String;
begin
   Index := 0;
   Parser := TParser.Create;
   try
      Parser.FieldSep := ASeperator;
      Parser.Parse(AString);

      for i:= 1 to Parser.Parsecount do
         begin
            Value := Trim(Parser.Parsefields[i]);
            if (AIncludeEmptyStrings) or (length(Trim(Value)) > 0) then
               begin
                  SetLength(Result, Index+1);

                  Result[Index] := Value;
                  Inc(Index);
               end;
         end;
   finally
      if ( Parser <> nil ) then Parser.Free;
   end;
end;

function IsEmpty(const AString : string): Boolean;
begin
   Result := Length(Trim(AString)) = 0;
end;

procedure InsertAllText(AText, AFileName : string);
var
   TextFile : TStringList;
begin
   TextFile := TStringList.Create;
   try
      try
         if FileExists(AFileName) then
            TextFile.LoadFromFile(AFileName);
         TextFile.Insert(0,AText);
         TextFile.SaveToFile(AFileName);
      except

      end;
   finally
      FreeAndNil(TextFile);
   end;
end;


procedure WriteAllText(AText, AFileName : string);
var
   TextFile : TStringList;
begin
   TextFile := TStringList.Create;
   try
      TextFile.Add(AText);
      TextFile.SaveToFile(AFileName);
   finally
      FreeAndNil(TextFile);
   end;
end;

function ReadAllText(AFileName : string) : string;
var
   TextFile : TStringList;
begin
   TextFile := TStringList.Create;
   try
      TextFile.LoadFromFile(AFileName);
      Result := TextFile.Text;
   finally
      FreeAndNil(TextFile);
   end;
end;

procedure GetDatabases(ADirList : TStrings; const AIncludeArchived : Boolean = false);

   function IsArchived(AName : string) : Boolean;
   var
      i : Integer;
   begin
      Result := False;
      if (Length(AName)<=4) then Exit;

      for i := Length(AName) downto Length(AName)-4 do
         if not(AName[i] in ['0'..'9']) then Exit;

      Result := True;
   end;
var
  Databases : TStringList;
  SR : TSearchRec;
  i : Integer;
begin
   try
      ADirList.Clear;

      Databases := TStringList.Create;
      try
         i := FindFirst('C:\Kingsacc\*.*', faDirectory, sr);
         if i = 0 then
            repeat
               if (Sr.Attr and faDirectory) <> 0 then
                  Databases.Add(sr.Name);
               i := FindNext(Sr);
            until
               i <> 0;

          for i := 0 to Databases.Count-1 do
             if FindFirst('C:\Kingsacc\'+Databases.Strings[i]+'\Cashbook.def', faAnyFile, SR) = 0 then
                begin
                   if ((AIncludeArchived) or (not AIncludeArchived and (not(IsArchived(Databases.Strings[i]))))) then
                      ADirList.Add(UPPERCASE(Databases.Strings[i]));
                end;
      finally
         FreeAndNil(Databases);
      end;

   finally
      SysUtils.FindClose(SR);
   end;

end;

function _MessageDlg(const Msg: string; DlgType: TMsgDlgType;
   Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
begin
   Result := ForceTopMostMessageDlg(Msg,DlgType,Buttons,HelpCtx);
end;

function StripSpaces( StrToStrip : String) : String;
var
   i,
   j:integer;
begin
   if length(StrToStrip)>0 then
      begin
         i := 1;
         while (i<length(StrToStrip)) and (StrToStrip[i]=' ') do
            i := i+1;                     { find first non-blank character }
         if StrToStrip[i]=' ' then        { string is all blank }
            StrToStrip := ''
         else                      { string is not all blank }
            begin
               j := length(StrToStrip);
               while (j>1) and (StrToStrip[j]=' ') do
                  j := j-1;         { find end of non-blank section }
               StrToStrip := copy(StrToStrip,i,j+1-i);
            end;
      end;
   Result := StrToStrip;
end;

function StripAllNomNumAlpha(StrToStrip: String): String;
var
   j:integer;
   st : string;
begin
   St := StripAllSpaces(StrToStrip);
   if Length(St)>0 then
      begin
         j := length(St);
         while (j>1) do
            begin
               if NOT ( St[j] in ['A'..'Z','a'..'z','0'..'9'] ) then
                  Delete(St,j,1);
               Dec(j);
            end;
      end;
   Result := St;
end;

function StripAllSpaces(StrToStrip: String): String;
var
   j:integer;
   st : string;
begin
   st := StripSpaces(StrToStrip);
   if length(St)>0 then
      begin
         j := length(St);
         while (j>1) do
            begin
               if St[j] = ' ' then
                  Delete(St,j,1);
               Dec(j);
            end;
      end;
   Result := St;
end;

function GUID: String;
var
  Guid: TGUID;
  wsGuid: WideString;
begin
  Result := '';
  if CoCreateGuid(Guid) = S_OK then
     begin
        SetLength(wsGuid, 38);
        if StringFromGUID2(Guid, POleStr(wsGuid), 80) > 0 then
           Result := OleStrToString(PWideChar(wsGuid));
         if (Result[1] = '{') and (Result[Length(Result)] = '}') then
           Result := Copy(Result, 2, Length(Result)-2);
     end;
end;

function ClientSecretIsValid(const AValue: string): Boolean;
begin
   // Sample: 51C0567DFA664D36BD1642AE00F8FFA1
   Result := (Length(AValue)=32) and IsAlphaNumeric(AValue);
end;

function IsAlphaNumeric(AString : String) : Boolean;
var
   i : Integer;
begin
   Result := False;
   if ( Length(AString) = 0 ) then Exit;
   for i := 1 to Length(AString) do
      begin
         Result := AString[i] in ['A'..'Z','a'..'z','0'..'9'];
         if not Result then break;
      end;
end;

procedure Parse(const Line: string; const ASeparator: string; AFields: TStrings);
var
   i : Integer;
   Temp : string;
   TempLine: string;
begin
   if (AFields=nil) then
      AFields := AFields.Create;

   AFields.Clear();
   TempLine     := Line;

   i := Pos(ASeparator, TempLine);
   while i > 0 do
      begin
         Temp := Copy(TempLine,1,i-1);
         if (trim(Temp) <> '') then
            AFields.Add(Temp);
         delete(TempLine,1,i);
         i := pos(ASeparator, TempLine);
      end;

   if (Trim(tempLine) <> '') then
     AFields.Add(TempLine);
end;


function GetShortMonthNameDate(AStrDate : String) : TDateTime;
var
   i, iMnthPos, iMonth : Integer;
   sDate, sDay, sYear : String;
begin
   Result := 0;

   if ( Length(AStrDate) = 0 ) then Exit;
   sDate := UpperCase(AStrDate);
   for i := Low(ShortMonthNames) to High(ShortMonthNames) do
      begin
         iMnthPos := Pos(UpperCase(ShortMonthNames[i]),sDate);
         if ( iMnthPos > 0 ) then
            begin
               // If American date format "MMM DD YYYY" then Exit.
               if ( iMnthPos = 1 ) then Exit;
               iMonth := i;
               Delete(sDate,iMnthPos,3);
               Break;
            end;
      end;

   if ( Length(sDate) = 0 ) then Exit;

   sDay := StripSpaces(Copy(sDate,0,3));
   if ( Length(sDay) = 0 ) then Exit;

   Delete(sDate,Pos(sDay,sDate),Length(sDay));
   sYear := StripSpaces(sDate);
   if ( Length(sYear) = 0 ) then Exit;

   sDate := sDay+'/'+IntToStr(iMonth)+'/'+sYear;
   try
      Result := StrToDate(sDate);
   except
      Result := 0;
   end;
end;

function MonthIsShortName(AValue : String) : Boolean;
var
   i : Integer;
begin
   Result := False;
   for i := Low(ShortMonthNames) to High(ShortMonthNames) do
      begin
         Result := ( Pos(UpperCase(ShortMonthNames[i]), UpperCase(AValue) ) > 0 );
         if Result then Break;
     end;
end;

// c# ternary (?:) implementation
function IfThenElse(const Condition: Boolean; const AConsequent : Variant; const AAlternative: Variant) : Variant;
begin
   if Condition then
      Result := AConsequent
   else
      Result := AAlternative;
end;

function FlipNegative(const AValue : string): string;
var
   TempStr: string;
begin
   TempStr := AValue;

   if (Length(Trim(TempStr))>0) and (Trim(TempStr)[Length(TempStr)]='-') then
      begin
         System.Delete(TempStr, Length(TempStr), 1);
         TempStr := '-'+TempStr;
      end;

   Result := TempStr;
end;

function URLEncode(s: string): string;
var
  i: Integer;
  Source: PAnsiChar;
begin
  result := '';
  Source := PAnsiChar(S);
  for i := 1 to Length(Source) do
    if not (Source[i - 1] in ['A'..'Z', 'a'..'z', '0'..'9', '-', '_', '~', '.', '/']) then
       Result := Result + '%' + IntToHex(ord(Source[i - 1]), 2)
    else
       Result := Result + Source[i - 1];
end;

function GetIPAddress(): string;
type
  pu_long = ^u_long;
var
  varTWSAData : TWSAData;
  varPHostEnt : PHostEnt;
  varTInAddr : TInAddr;
  NameBuffer : Array[0..255] of char;
begin
   try
   try
      if WSAStartup($101,varTWSAData) <> 0 then
         begin
            Result := '';
            Exit;
         end;

        gethostname(NameBuffer,sizeof(NameBuffer));
        varPHostEnt := gethostbyname(NameBuffer);
        varTInAddr.S_addr := u_long(pu_long(varPHostEnt^.h_addr_list^)^);

        Result := inet_ntoa(varTInAddr);
   except
      Result := 'Unknown';
   end;
   finally
      WSACleanup;
   end;
end;

// Source: https://www.prestwoodboards.com/ASPSuite/KB/Document_View.asp?QID=100258
function GetAdapterInfo(Lana: Char): String;
var
   Adapter: TAdapterStatus;
   NCB: TNCB;
begin
   FillChar(NCB, SizeOf(NCB), 0);
   NCB.ncb_command := Char(NCBRESET);
   NCB.ncb_lana_num := Lana;
   if Netbios(@NCB) <> Char(NRC_GOODRET) then
      begin
         Result := 'NotFound';
         Exit;
      end;

   FillChar(NCB, SizeOf(NCB), 0);
   NCB.ncb_command := Char(NCBASTAT);
   NCB.ncb_lana_num := Lana;
   NCB.ncb_callname := '*';

   FillChar(Adapter, SizeOf(Adapter), 0);
   NCB.ncb_buffer := @Adapter;
   NCB.ncb_length := SizeOf(Adapter);
   if Netbios(@NCB) <> Char(NRC_GOODRET) then
      begin
         Result := 'NotFound';
         Exit;
      end;

   Result :=
          IntToHex(Byte(Adapter.adapter_address[0]), 2) + '-' +
          IntToHex(Byte(Adapter.adapter_address[1]), 2) + '-' +
          IntToHex(Byte(Adapter.adapter_address[2]), 2) + '-' +
          IntToHex(Byte(Adapter.adapter_address[3]), 2) + '-' +
          IntToHex(Byte(Adapter.adapter_address[4]), 2) + '-' +
          IntToHex(Byte(Adapter.adapter_address[5]), 2);
end;

function GetMACAddress: string;
var
   AdapterList: TLanaEnum;
   NCB: TNCB;
begin
   FillChar(NCB, SizeOf(NCB), 0);
   NCB.ncb_command := Char(NCBENUM);
   NCB.ncb_buffer := @AdapterList;
   NCB.ncb_length := SizeOf(AdapterList);
   Netbios(@NCB);
   if Byte(AdapterList.length) > 0 then
      Result := GetAdapterInfo(AdapterList.lana[0])
   else
      Result := 'NotFound';
end;

function IsAccountant (AFarmgateSerialNo : Integer) : Boolean;
begin
   Result := ( FileExists('C:\Kingsacc\kac.config') ) and ( ((AFarmgateSerialNo >= 100) and (AFarmgateSerialNo <= 999)) or (AFarmgateSerialNo = 10001) );
end;

function GetUserDownloadsDir : String;
var
   sDesktopDir : String;
   sUserName : String;
begin
   Result := '';
   sDesktopDir := GetSpecialFolder(CSIDL_DESKTOP);
   sUserName := ExtractDirFromPath(StringReplace(sDesktopDir,IncludeTrailingBackslash(ExtractDirFromPath(sDesktopDir)),'',[rfReplaceAll, rfIgnoreCase]));
   if ( Length(sUserName) > 0 ) then
      if ( DirectoryExists('C:\Users\') ) then
         begin
            if ( DirectoryExists('C:\Users\'+sUserName+'\Downloads') ) then
               Result := 'C:\Users\'+sUserName+'\Downloads';
         end
      else if ( DirectoryExists('C:\Documents and Settings\') ) then
         begin
            if ( DirectoryExists('C:\Documents and Settings\'+sUserName+'\Downloads') ) then
               Result := 'C:\Documents and Settings\'+sUserName+'\Downloads';
         end
end;

function GetDownloadedCSVDir : string;
var
   SearchRec : TSearchRec;
   i, SearchResult : Integer;
   saDirectories : TStringArray;
   slFilesFound : TStringList;
begin
   Result := '';
   SetLength(saDirectories,2);
   saDirectories[0] := GetSpecialFolder(CSIDL_DESKTOP);
   saDirectories[1] := GetUserDownloadsDir;

   slFilesFound := TStringList.Create();
   try
      for i := 0 to Length(saDirectories)-1 do
         begin
            GetDirectoryFiles(saDirectories[i], slFilesFound, '*.csv');
            if ( slFilesFound.Count > 0 ) then
               begin
                  Result := saDirectories[i];
                  Break;
               end;
         end;
      if ( Length(Result) = 0 ) then
         Result := GetSpecialFolder(CSIDL_DESKTOP);
   finally
      FreeAndNil(slFilesFound);
   end;
end;

function ClientDeviceID: string;
// UUID used to uniquely id device.
var
   Reg : tregistry;
begin
   Reg := TRegistry.Create;
   try
      if (Reg.OpenKey('Software\Kingswood\Kingsacc',False)) then
         try
            Result := Reg.ReadString('ClientDeviceID');
            if (Length(Trim(Result))=0) then
               begin
                  Result := Guid();
                  Reg.WriteString('ClientDeviceID',Result);
               end;
         finally
            Reg.CloseKey;
         end;
   finally
      Reg.Free;
   end;
end;

function UTCDateTimeAsString(): string;
var
  UTC: TSystemTime;
begin
  GetSystemTime(UTC);
  Result := StringReplace(FormatDateTime('yyyy-MM-dd hh:nn:ss.zzz',SystemTimeToDateTime(UTC)), ' ', 'T',[rfReplaceAll, rfIgnoreCase]) +'Z';
end;


end.
