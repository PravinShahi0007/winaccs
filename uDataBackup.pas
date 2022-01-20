{
   14/12/16 [V4.2 R5.1] /MK Bug Fix - CopyFilesToDataFolder - Only copy the file when it doesn't exist.

   25/05/20 [V4.5 R2.1] /MK Additional Feature - Store the backup date in AccsDefaults if the backup was completed.

   30/07/20 [V4.5 R3.4] /MK Change - Execute - Pass in the Farmgate.def file so that we can check if user has accountant farmgate file.
                                   - FFarmgateSerialNo - New private varial to store farmgate serial passed in by Execute.
                                   - RestoreFromServer - If user has accountant serial number between 100 and 999 and the config file is missing then give prompt to contact Kingswood.
                                   - DownloadAccountantClients - Prompt user with new uRestoreToNewCompanyName to allow accountants to specify new name for downloaded company.
                                                               - If the user cancels the new uRestoreToNewCompanyName then cancel restore of data.
                                                               - If the new company name already exists prompt user with confirmation to overwrite this data.
                                                               - Removed FarmgateWrapper here as it was causing a Termination Message Security Error and then closing the program
                                                                 without the user getting the MessageDlg below to inform that the company name is different.

   26/11/20 [V4.5 R4.6] /MK Change - FormCreate - If the user is an accountant then default the BackupFileName to the Cashbook directory name.

   11/02/21 [V4.5 R5.0] /MK Bug Fix - BackupToCD, BackupToRemovable - Store the backup date in AccsDefaults if the backup was completed.
}

unit uDataBackup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  cxControls, cxContainer, cxEdit, cxLabel, ExtCtrls, StdCtrls, cxButtons,
  cxPC, Menus, dxStatusBar, DynaLibU, DynaZip, DynaLibZ, cxProgressBar,
  cxLookAndFeels, FileCtrl, dxBar, dxBarExtItems, LMDWebBase, LMDWebConfig,
  LMDWebHTTPGet, LMDDownload, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, AccsUtils,
  uAccountantDownloadHelper, DCPCryptManagement, uOnlineBackupHelper,
  uRestoreToNewCompanyName;

type
  TZipDestType = (zdFloppy, zdCDR, zdExternalDevice, zdOnlineServer);
  TZipDestinations = set of TZipDestType;
  TZipOperation = (zoZip, zoUnzip);
  TDataAction = (daBackup, daRestore, daSendToAccountant, daReceiveFromAccountant);
  TfmDataBackup = class(TForm)
    PopupMenu1: TPopupMenu;
    miFormatDisk: TMenuItem;
    StatusBar: TdxStatusBar;
    Zip: TZipFile;
    Unzip: TUnzipFile;
    dxStatusBar1Container2: TdxStatusBarContainerControl;
    miSpanDisks: TMenuItem;
    dxBarManager1: TdxBarManager;
    blbClose: TdxBarLargeButton;
    DataActionPageControl: TcxPageControl;
    tsBackup: TcxTabSheet;
    lCDStorageDescription: TcxLabel;
    lExternalStorageDescription: TcxLabel;
    lOnlineStorageDescription: TcxLabel;
    btnCDBackupRestore: TcxButton;
    btnExternalDeviceBackupRestore: TcxButton;
    btnOnlineBackupRestore: TcxButton;
    tsRestore: TcxTabSheet;
    lLastBackupDate: TcxLabel;
    dxBarStatic1: TdxBarStatic;
    lOnlineStorage: TcxLabel;
    lExternalStorage: TcxLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    lCDStorage: TcxLabel;
    OpenDialog: TOpenDialog;
    LDatabaseName: TcxLabel;
    LDate: TcxLabel;
    GetOBClient: TLMDWebHTTPGet;
    blbAccountantLink: TdxBarLargeButton;
    blbUndoPoints: TdxBarLargeButton;
    Timer: TTimer;
    procedure DataActionPageControlDrawTabEx(AControl: TcxCustomTabControl;
      ATab: TcxTab; Font: TFont);
    procedure DataActionPageControlPageChanging(Sender: TObject;
      NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ZipMajorCallback(szItem: PChar; Percent: Integer;
      var DoCancel: Boolean);
    procedure UnzipMajorCallback(szItem: PChar; Percent: Integer;
      var DoCancel: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnExternalDeviceBackupRestoreClick(Sender: TObject);
    procedure blbCloseClick(Sender: TObject);
    procedure btnCDBackupRestoreClick(Sender: TObject);
    procedure btnOnlineBackupRestoreClick(Sender: TObject);
    procedure GetOBClientProgress(Sender: TLMDWebHTTPGet;
      Item: TLMDDownloadItem);
    procedure GetOBClientProcessed(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure blbAccountantLinkClick(Sender: TObject);
    procedure blbUndoPointsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
    FDataAction : TDataAction;
    FProgressBar : TcxProgressBar;
    FDatabaseName : string;
    BackupFileName : String;
    DataDirectory : String;
    ZipArray   : array[0..70] of char;
    UnZipArray : array[0..70] of char;
    FExitEarly : Boolean;
    FArchiveDirectory : string;
    FResult : Boolean;
    FArchivedBackupFileName : string;
    FFarmgateSerialNo : Integer;
    procedure SetupStatusBar;
    function ZipDataExecuteAction(SourcePath, DestPath : string; const CloseDB,
                     SetBackupDate : Boolean;
                     ZipOp : TZipOperation = zoZip) : Boolean;
    procedure CloseDatabase;
    function ArchiveData : Boolean;
    function BackupToCD : Boolean;
    function BackupToRemovable : Integer;
    function BackupToServer : Boolean;
    procedure UpdateStatus( Text : string);
    function TestBackup(const AFileName : string) : Boolean;
    procedure RestoreData(const AFileName : string);
    function RestoreFromServer : Boolean;
    procedure DefaultHandler(var Message); override;
    procedure DeleteData(const ADirectory : string);
    procedure DownloadRequiredOnlineBackupClientDll;
    procedure DownloadAccountantClients();
    procedure SetupScreen;
    procedure DisableActions(AZipDestinations : TZipDestinations);
    procedure RestoreClientDataToDirectory(const AFileName : string; const ADataDirectory : string);

    // SP 01/10/2014 Copy the Farmgate.def file into the specified data folder
    // This is being done for reinstall of accounts programs via web installer
    procedure CopyFilesToDataFolder(ADataDirectory : string);
  public
    { Public declarations }
    class function Execute(const ADataAction : TDataAction = daBackup; const AFarmgateSNo : Integer = 0) : Boolean;
  end;

var
  fmDataBackup: TfmDataBackup;
  WM_KingswoodData_BackupUpdateScreen : Dword;

const

   TempDir = 'C:\Kingsacc\Archive\Temp';
   cBackupComplete = 'Backup successfully created with no problems found.';
   cCreatingBackupFile = 'Creating backup file, please wait...';
   cBackupFailed = 'Backup has failed. Please note any errors and contact Kingswood.';
   cNoValidDriveSelected = 'Unable to proceed with backup, no valid drive has been selected.';
   cServerBackupSuccess = 'Your backup file has been successfully uploaded to the Kingswood server.';

   cSelectOption = 'Select this option to ';

   cZipExt = '.zip';

   cAccountantDescription = 'This options allows you to securely %s your data to your accountant. ' +
                            'Requires selection of accountant before use. To select your accountant '+
                            'click the Accountant Link button on the toolbar above.';


implementation

uses
     AccsData,
     Types,
     Global,
     Def,
     Vars,
     DBGen,
     DBCore,
     Filed,
     Init,
     AbortPrg,
     uWinOS,
     uBackupDevice,
     uDownloadValidation,
     UserMsgConst,
     uDataRestoreConfirm,
     ChkDebug, uKingswoodAccountantController, uAccountantLink, uBackup,
     uAccsSettings, uFarmGateWrapper;

{$R *.DFM}

{ TfmDataBackup }

class function TfmDataBackup.Execute(const ADataAction : TDataAction = daBackup; const AFarmgateSNo : Integer = 0) : Boolean;
begin
   Result := False;
   with TfmDataBackup.create(nil) do
      try
         FDataAction := ADataAction;
         FFarmgateSerialNo := AFarmgateSNo;
         ShowModal;
      finally
         Result := FResult;
         Free;
      end;
end;

procedure TfmDataBackup.DataActionPageControlDrawTabEx(
  AControl: TcxCustomTabControl; ATab: TcxTab; Font: TFont);
begin
   Font.Style := [fsBold];
   if ( ATab.Index = DataActionPageControl.ActivePageIndex) then
      begin
         ATab.Color := clWhite;
         Font.Color := clGreen;
         Font.Size := 8;
         Font.Style := [fsBold];
      end
   else
      begin
         ATab.Color := 536870912;
         Font.Color := clBlack;
         Font.Size := 8;
         Font.Style := [];
      end;
end;

procedure TfmDataBackup.DataActionPageControlPageChanging(Sender: TObject;
  NewPage: TcxTabSheet; var AllowChange: Boolean);
begin

   if NewPage = nil then Exit;
   
   // Only allow toggle of FDataAction if current FDataAction is either daBackup or daRestore
   // Toogle of FDataAction should NOT occur if FDataAction is either daSendToAccountant or daReceiveFromAccountant
   if (FDataAction in [daBackup, daRestore]) then
      begin
         if NewPage = tsRestore then
            begin
               if TfmDataRestoreConfirm.ConfirmRestore then
                  FDataAction := daRestore
               else
                  begin
                     AllowChange := False;
                     if (FDataAction = daRestore) then
                        MessageDlg('Restore has been cancelled.',mtWarning,[mbOK],0)
                     else if (FDataAction = daReceiveFromAccountant) then
                        FExitEarly := true;
                     Exit;
                  end
            end
         else
            FDataAction := daBackup;
      end;

   DataActionPageControl.Tabs.BeginUpdate;
   try
      btnCDBackupRestore.Parent := NewPage;
      btnExternalDeviceBackupRestore.Parent := NewPage;
      btnOnlineBackupRestore.Parent := NewPage;

      lLastBackupDate.Parent := NewPage;
      LDate.Parent := NewPage;
      LDatabaseName.Parent := NewPage;

      lOnlineStorage.Parent := NewPage;
      lExternalStorage.Parent := NewPage;
      lCDStorage.Parent := NewPage;
      lOnlineStorageDescription.Parent := NewPage;
      lExternalStorageDescription.Parent := NewPage;
      lCDStorageDescription.Parent := NewPage;

      Bevel2.Parent := NewPage;
      Bevel3.Parent := NewPage;
      Bevel4.Parent := NewPage;

      lOnlineStorageDescription.Caption := '';
      lExternalStorageDescription.Caption := '';
      lCDStorageDescription.Caption := '';

      lOnlineStorage.Caption := '';
      lExternalStorage.Caption := '';
      lCDStorage.Caption := '';

      btnExternalDeviceBackupRestore.Visible := False;
      btnCDBackupRestore.Visible := False;

      Bevel3.Visible := ( FDataAction = daBackup) or (FDataAction = daRestore); // and not daSendToAccountant or daReceiveFromAccountant);
      Bevel4.Visible := Bevel3.Visible;

      if FDataAction = daBackup then
         begin
            lLastBackupDate.Caption := 'Last Backup:  '+FormatDate(AccsSettings.LastBackupDate, dsIrish);
            lLastBackupDate.Update;

            lOnlineStorageDescription.Caption := cselectoption +'save the backup files onto a secure Kingswood server. ';{+ cCRLF + 'Note: This requires a current maintenance contract by Standing Order.';}
            lExternalStorageDescription.Caption := cselectoption +'save the backup files onto an external device ( e.g USB Flash Disk/Memory Key)';
            lCDStorageDescription.Caption := cselectoption +'save the backup files onto a CD. Please note: CD Backup only available with Windows XP Home/Professional.';

            lOnlineStorage.Caption := 'Online Backup ';
            lExternalStorage.Caption := 'External Backup ';
            lCDStorage.Caption := 'CD Backup ';
            btnExternalDeviceBackupRestore.Visible := True;
            btnCDBackupRestore.Visible := True;
         end
      else if FDataAction = daSendToAccountant then
         begin
            lLastBackupDate.Caption := '';
            lLastBackupDate.Update;

            tsBackup.Caption := 'Send Data To Accountant';
            lOnlineStorage.Caption := tsBackup.Caption;
            lOnlineStorageDescription.Caption := Format(cAccountantDescription, ['send']);

            DisableActions([zdExternalDevice,zdCDR]);
            tsRestore.TabVisible := False;
            blbUndoPoints.Visible := ivNever;

         end
      else if FDataAction = daRestore then
         begin
            lLastBackupDate.Caption := 'Last Restore:  '+FormatDate(AccsSettings.LastRestoreDate, dsIrish);
            lLastBackupDate.Update;

            lOnlineStorageDescription.Caption := cselectoption +'restore a backup currently stored on the secure Kingswood server.';
            lExternalStorageDescription.Caption := cselectoption +'restore a backup file from an external device.';
            lCDStorageDescription.Caption := cselectoption +'restore a backup file from a CD.';

            lOnlineStorage.Caption := 'Online Restore ';
            lExternalStorage.Caption := 'External Restore ';
            lCDStorage.Caption := 'CD Restore ';

            btnExternalDeviceBackupRestore.Visible := True;
            btnCDBackupRestore.Visible := True;
         end
      else if FDataAction = daReceiveFromAccountant then
         begin
            lLastBackupDate.Caption := '';
            lLastBackupDate.Update;

            tsRestore.Caption := 'Receive Data From Accountant';
            lOnlineStorage.Caption := tsRestore.Caption;
            lOnlineStorageDescription.Caption := Format(cAccountantDescription, ['receive']);

            DisableActions([zdExternalDevice,zdCDR]);
            tsBackup.TabVisible := False;
            blbUndoPoints.Visible := ivNever;
         end;

   finally
      DataActionPageControl.Tabs.EndUpdate;
      Update;
   end;

end;

function TfmDataBackup.BackupToCD : Boolean;
var
   RunCmd, DestinationPath : string;
   i : Integer;
begin
   Result := False;
   DestinationPath := TempDir + '\' + BackupFileName + cZipExt;
   Cursor := crHourGlass;
   Enabled := False;
   FProgressBar.Position := 0;
   FProgressBar.Visible := True;

   // if previous temp backup exists delete.
   if FileExists(DestinationPath) then
      DeleteFile(DestinationPath);
   try
      UpdateStatus(cCreatingBackupFile);
      // Zip Data
      if ZipDataExecuteAction( DataDirectory, DestinationPath, TRUE, TRUE ) then
         begin
            Result := True;
            AccsDataModule.AccsDefaultsLastBackupDate := Now;
            RunCmd := cCDBackupExeName + ' ' + '"' + DestinationPath + '"';
            lLastBackupDate.Caption := 'Last Backup Taken:  '+FormatDate(AccsSettings.LastBackUpDate, dsIrish);
            lLastBackupDate.Update;
            Update;
            WinExec(PChar(RunCmd), SW_SHOWNORMAL);
         end;
   finally
      Application.ProcessMessages;
      FProgressBar.Visible := False;
      Cursor := crHourGlass;
      Enabled := True;
   end;
end;

function TfmDataBackup.BackupToRemovable : Integer;
var
   Drive : string;
   AccCompanies : TStringList;
   i : Integer;
   DestinationPath : string;

   function GetFileName(ABackupFile : string) : String;
   var
      CurrBackupNum : Integer;
      tFileName : string;
   begin
      // close database
      CurrBackupNum := 1;

      tFileName := Drive + ABackupFile + ' ' + FormatDateTime('ddmmyy', Date) + ' '+ '#'+IntToStr(CurrBackupNum)+cZipExt;
      while FileExists(tFileName) do
         begin
            Inc(CurrBackupNum);
            tFileName := Drive + ABackupFile + ' ' + FormatDateTime('ddmmyy', Date) + ' '+ '#'+IntToStr(CurrBackupNum)+cZipExt;
         end;

      Result := tFileName;
   end;
begin
   Result := 1;
   if RemovableDriveCount > 1 then
      begin
         Drive := uBackupDevice.Execute;
         Update;
      end
   else
      Drive := DefaultRemovableDrive;

   if (Drive <> '') then
      try
         Cursor := crHourGlass;
         Enabled := False;
         FProgressBar.Position := 0;
         FProgressBar.Visible := True;
         DestinationPath := GetFileName(BackupFileName);

         ArchiveData;
         UpdateStatus(cCreatingBackupFile);
         if ZipDataExecuteAction(DataDirectory, DestinationPath, TRUE, TRUE) then
            begin
               if TestBackup(DestinationPath) then
                  Result := 0
               else
                  Result := 1;

            if Result = 0 then
               begin
                  AccsDataModule.AccsDefaultsLastBackupDate := Now;
                  FResult := True;
                  lLastBackupDate.Caption := 'Last Backup Taken:  '+FormatDate(AccsSettings.LastBackUpDate, dsIrish);
                  lLastBackupDate.Update;
                  Update;
               end;
            end;
      finally
         FProgressBar.Visible := False;
         Enabled := True;
         Cursor := crDefault;
      end
   else
      Result := 2;
end;

procedure TfmDataBackup.CloseDatabase;
begin
   try
     //SlimAll ( DirString );
     accsdatamodule.closeallfiles;
     { Close all DATABASE files }
     CloseAll(MaxDatabases);
     { Close Cashbook.def file }
     cClose (CashFile, 'N');
     { Close Farmgate.def file }
     cClose ( FarmFile, 'N');
   except
      on E : Exception do
         raise Exception.Create('BACKUP/RESTORE Failed: Error occured while disconnecting from database.' + cCRLF +
                                'Restart program and try again. If problem persists contact Kingwood');
   end;
end;

function TfmDataBackup.ArchiveData : Boolean;
begin
   UpdateStatus('Archiving Data, please wait...');
   // create restore point if user mistakenly restores a backup! really...it does happen:)
   if (FDataAction in [daBackup,daSendToAccountant]) then
      FArchivedBackupFileName := FArchiveDirectory + BackupFileName +'\Restore Points\'+BackupFileName+ ' ' +FormatDateTime('ddmmyyhhnnss',now)+'_rp'+cZipExt
   else if (FDataAction in [daRestore,daReceiveFromAccountant]) then
      FArchivedBackupFileName := FArchiveDirectory + BackupFileName +'\Auto\'+BackupFileName+ ' ' +FormatDateTime('ddmmyyhhnnss',now)+'_auto'+cZipExt;
   Result := ZipDataExecuteAction(DataDirectory, FArchivedBackupFileName, TRUE, FALSE);
end;

function TfmDataBackup.ZipDataExecuteAction(SourcePath, DestPath: string; const CloseDB,
  SetBackupDate: Boolean; ZipOp: TZipOperation): Boolean;
begin
   Result := False;
   try
      try
         if ZipOp = zoZip then
            begin
               FillChar( ZipArray, SizeOf(ZipArray), #0); // Set Array contents to null
               SourcePath := IncludeTrailingBackSlash(SourcePath); // include back slash in source path
               StrPCopy(ZipArray, PChar('"'+ SourcePath +'*.*"' + #0));
               Zip.lpszZipFile.SetText(PChar('"'+ DestPath + '"' + #0));
               Zip.lpszItemList.SetText(ZipArray);
               Result := Zip.Execute(ZIP_ADD);
            end
         else
            begin
               FillChar( UnZipArray, SizeOf(UnZipArray), #0); // Set Array contents to null
               StrPCopy( UnZipArray, DestPath  + #0);
               Unzip.lpszDestination.SetText(UnZipArray);
               Unzip.lpszZipFile.SetText(PChar(SourcePath + #0));
               Unzip.lpszFileSpec.SetText('*.*' + #0);
               Result := Unzip.Execute(UNZIP_EXTRACT);
            end;
      except
         raise Exception.Create('An Error has occured in backup/restore process. Close program and retry again.' + cCRLF +
                                'If problem persists please contact Kingswood');
      end;
   finally
      if ( ZipOp = zoZip ) and ( SetBackupDate ) and ( Result ) then
         AccsSettings.LastBackupDate := Date;
   end;
end;

procedure TfmDataBackup.UpdateStatus(Text: string);
begin
   StatusBar.Panels[0].Text := Text;
   StatusBar.Refresh;
   Update;
end;

procedure TfmDataBackup.SetupStatusBar;
var
   APanel: TdxStatusBarPanel;
   APanelStyle: TdxStatusBarContainerPanelStyle;
begin
   APanel := StatusBar.Panels[1];
   APanel.PanelStyleClass := TdxStatusBarContainerPanelStyle;
   APanelStyle := TdxStatusBarContainerPanelStyle(APanel.PanelStyle);
   APanelStyle.AlignControl := True;

   FProgressBar := TcxProgressBar.Create(nil);
   FProgressBar.Properties.Max := 100;
   FProgressBar.Parent := APanelStyle.Container;
   FProgressBar.Style.LookAndFeel.NativeStyle := True;
   FProgressBar.Visible := False;
end;

procedure TfmDataBackup.FormCreate(Sender: TObject);
begin
   CloseDatabase;
   DataActionPageControl.ActivePage := nil;
   FExitEarly := False;
   SetupStatusBar;

   BackupFileName := '';
   DataDirectory := '';
   FDatabaseName := '';
   FArchiveDirectory := ApplicationPath + 'Archive\';
   if not DirectoryExists(FArchiveDirectory) then
      CreateDirectory(FArchiveDirectory);

   DataDirectory := AccsDataModule.AccsDataBase.Directory;
   SetLength(DataDirectory, Length(DataDirectory));

   CopyFilesToDataFolder(DataDirectory);

   FDatabaseName := ExtractDirFromPath(ExcludeTrailingBackslash(DataDirectory));

   //   26/11/20 [V4.5 R4.6] /MK Change - If the user is an accountant then default the BackupFileName to the Cashbook directory name.
   if ( KAC.Active ) then
      BackupFileName := ExcludeTrailingBackslash(Cash2.XDIRECTORY)
   else
      BackupFileName := FDatabaseName;

   SetLength(BackupFileName, Length(BackupFileName));

   LDate.Caption := 'Date:  '+FormatDateTime('d of mmmm yyyy', Date);
   LDatabaseName.Caption := 'Database Name:  '+BackupFileName;

   FResult := False;

   AccsDataModule.RestartProgramAfterBackupRestore := False;

   if (KAC.Active) then
      begin
         blbAccountantLink.Visible := ivNever;
         blbUndoPoints.Visible := ivNever;
      end
   else
      begin
         blbAccountantLink.Visible := ivAlways;
         blbUndoPoints.Visible := ivAlways;
      end ;
end;

procedure TfmDataBackup.ZipMajorCallback(szItem: PChar; Percent: Integer;
  var DoCancel: Boolean);
begin
   FProgressBar.Position := Percent;
   Application.ProcessMessages;
end;

procedure TfmDataBackup.UnzipMajorCallback(szItem: PChar; Percent: Integer;
  var DoCancel: Boolean);
begin
   FProgressBar.Position := Percent;
   Application.ProcessMessages;
end;

function TfmDataBackup.TestBackup(const AFileName: string): Boolean;

   function DeleteDirectory : Boolean;
   var
     DirInfo: TSearchRec;
     i : SmallInt;
   begin
      Result := True;
      try
         i := FindFirst(TempDir+'\*.*', FaAnyfile, DirInfo);
         while i = 0 do
            begin
               if ((DirInfo.Attr and FaDirectory <> FaDirectory) and
                   (DirInfo.Attr and FaVolumeId <> FaVolumeID)) then
                   DeleteFile(pChar(TempDir+'\'+DirInfo.Name));
              i := FindNext(DirInfo);
            end;
         SysUtils.FindClose(DirInfo);
         RemoveDirectory(TempDir);
      except
         Result := False;
      end;
   end;
   
begin
   Result := False;
   try
      UpdateStatus(Format('Testing %s file for problems, please wait...',[ExtractFileName(AFileName)]));
      CreateDirectory(TempDir);
      if ZipDataExecuteAction(AFileName, TempDir, FALSE, FALSE, zoUnzip) then
         Result := True;
      RemoveDir(TempDir);
   finally
      DeleteDirectory;
   end;

end;

procedure TfmDataBackup.FormShow(Sender: TObject);
begin
   SetupScreen;
   if not CheckBackupFileName(BackupFileName) then
      begin
         MessageDlg(Format('Unable to continue with backup.'+#13#10+
                           'The current data folder "%s"'+#13#10+
                           'contains illegal characters, contact Kingswood',[BackupFileName]),mtError,[mbOK],0);
         FExitEarly := True;
      end;
end;

procedure TfmDataBackup.btnExternalDeviceBackupRestoreClick(
  Sender: TObject);
var
   Result : Integer;
   StatusString : string;
begin
   btnExternalDeviceBackupRestore.Enabled := False;
   try
      if (FDataAction in [daBackup,daSendToAccountant]) then
         begin
            if ( RemovableDriveCount <= 0 ) then
               begin
                  MessageDlg('No removable device has been detected.'+#13#10+
                             'Please insert a removable device such as USB Flash Disk/Memory Key or External Hard Drive.',mtInformation,[mbOK],0);
                  Exit;
               end;

            Result := BackupToRemovable;
            if Result=0 then
               begin
                  FResult := True;
                  UpdateStatus(cBackupComplete);
                  MessageDLG(cBackupComplete,mtInformation,[mbOK],0)
               end
            else if result = 1 then
               begin
                  UpdateStatus(cBackupFailed);
                  MessageDLG(cBackupFailed, mtWarning,[mbOK],0)
               end
            else if result = 2 then
               begin
                  UpdateStatus(cNoValidDriveSelected);
                  MessageDlg(cNoValidDriveSelected,mtWarning,[mbOK],0);
               end;
         end
      else
         begin
            OpenDialog.InitialDir := GetSpecialFolder(CSIDL_DESKTOP);
            if OpenDialog.Execute then
               RestoreData(OpenDialog.FileName);
         end;
   finally
      btnExternalDeviceBackupRestore.Enabled := True;
   end;
end;

procedure TfmDataBackup.blbCloseClick(Sender: TObject);
begin
   Close;
end;

procedure TfmDataBackup.btnCDBackupRestoreClick(Sender: TObject);
var
   RunCmd, DestinationPath : string;
   AccCompanies : TStringList;
   i : Integer;
begin
   btnCDBackupRestore.Enabled := False;
   try
      if (FDataAction in [daBackup,daSendToAccountant]) then
         begin
            if not FileExists(ApplicationPath + cCDBackupExeName) then
               begin
                  MessageDlg('The Kingswood CDBackup program cannot be found, contact Kingswood',mtError,[mbOK],0);
                  Exit;
               end;

            ArchiveData;
            FResult := BackupToCD;

            if not FResult then
               MessageDLG(cBackupFailed,mtError,[mbOK],0);
         end
      else
         begin
            OpenDialog.InitialDir := GetSpecialFolder(CSIDL_DESKTOP);
            if OpenDialog.Execute then
               RestoreData(OpenDialog.FileName);
         end;
   finally
      btnCDBackupRestore.Enabled := True;
   end;
end;

procedure TfmDataBackup.RestoreData(const AFileName : string);
begin
   Cursor := crHourGlass;
   Enabled := False;
   FProgressBar.Position := 0;
   FProgressBar.Visible := True;
   UpdateStatus('Attempting Restore of Data...');
   try
      if not FileExists(AFileName) then
         begin
            UpdateStatus('Unable to restore backup.');
            MessageDlg(Format('Unable to proceed with data restore.'+#13#10+
                              'File : "%s" does not exist',[AFileName]),mtWarning,[mbOK],0);
            Application.ProcessMessages;
         end
      else if ForceTopMostMessageDlg('This restore will replace all existing data.'+cCRLFx2+'Do you want to continue?',mtWarning,[mbYes,mbNo],0) = mrYes Then
         begin
            if ArchiveData then
               begin
                  UpdateStatus('Attempting Restore of Data, please wait...');
                  // Remove all data files, which eliminates conflicts with index files
                  DeleteData(DataDirectory);
                  if ZipDataExecuteAction(AFileName, DataDirectory, TRUE, FALSE, zoUnzip) then
                     begin
                        AccsSettings.LastRestoreDate := Date;
                        lLastBackupDate.Caption := 'Last Restore Date:  '+FormatDate(AccsSettings.LastRestoreDate, dsIrish);
                        lLastBackupDate.Update;
                        Update;
                        UpdateStatus('Backup successfully restored.');
                        MessageDLG(StatusBar.Panels[0].Text,mtInformation,[mbOK],0);
                        Close;
                     end
                  else
                     begin
                        UpdateStatus('Backup restore has failed - contact Kingswood');
                        ForceTopMostMessageDlg('Backup restore has failed - Please note any error messages and contact Kingswood Computing',mtWarning,[mbOK],0);
                     end;
               end
            else
               begin
                  UpdateStatus('Cannot proceed with data restore. Data archive has failed!');
                  ForceTopMostMessageDlg(StatusBar.Panels[0].Text,mtError,[mbOK],0);
               end;
         end
      else
         begin
            UpdateStatus('Restore cancelled.');
            Application.ProcessMessages;
         end;
   finally
      Cursor := crHourGlass;
      Enabled := True;
      FProgressBar.Visible := False;
   end;

end;

procedure TfmDataBackup.btnOnlineBackupRestoreClick(Sender: TObject);
begin
   FResult := False;
   btnOnlineBackupRestore.Enabled := False;
   try
      if FDataAction = daBackup then
         FResult := BackupToServer
      else if FDataAction = daRestore then
         FResult := RestoreFromServer
      else if (FDataAction in [daSendToAccountant, daReceiveFromAccountant]) then
         begin
            if (TfmAccountantLink.GetStoredAccountantAccessKey = '') then
               begin
                  if MessageDlg('Before you can data your data you must select an accountant.' + cCRLF+
                                'Do you want to select an accountant now?',mtConfirmation,[mbyes,mbNo],0) = idNo then Exit;
                  TfmAccountantLink.Show();
               end;

            if (TfmAccountantLink.GetStoredAccountantAccessKey = '') then Exit;

            if (FDataAction = daSendToAccountant) then
               FResult := BackupToServer
            else if (FDataAction = daReceiveFromAccountant) then
               FResult := RestoreFromServer;
         end;
   finally
      btnOnlineBackupRestore.Enabled := True;
   end;
end;

function TfmDataBackup.BackupToServer : Boolean;
var
   UploadFile : TUploadFile;
   UploadFileWithParams : TUploadFileWithParams;
   UploadAccountantClientFile : TUploadAccountantClientFile;
   UserName, FilePath, DestinationPath : string;
   i : Integer;
   FileName : string;

   procedure ResultToScreen(ABackupResult : Boolean);
   begin
      DeleteFile(FileName);
      if Result then
         begin
            AccsSettings.LastBackupDate := Date;
            UpdateStatus(cServerBackupSuccess);
            ForceTopMostMessageDlg(StatusBar.Panels[0].Text,mtInformation,[mbOk],0);
            Close;
         end
      else
         begin
            UpdateStatus(cBackupFailed);
            ForceTopMostMessageDlg(StatusBar.Panels[0].Text,mtError,[mbOk],0);
         end;
   end;

   procedure DLLFuncFailure(AFuncName : string);
   var
      DisplayText : string;
   begin
      DisplayText := Format(cOnlineBackupDLLCallToFunctionFailed,[AFuncName]);
      UpdateStatus(DisplayText);
      ForceTopMostMessageDlg(DisplayText,mtError,[mbOk],0);
   end;

begin
   Result := False;
   if not FileExists( IncludeTrailingBackslash(ApplicationPath)+cOnlineBackupDLLName) then
      begin
         UpdateStatus('Program file "obclient.dll" has not been found, attempting download.');
         MessageDlg(cOnlineBackupDLLNotFound,mtError,[mbOk],0);
         Update;
         DownloadRequiredOnlineBackupClientDll;
         Exit;
      end;

   Screen.Cursor := crHourGlass;
   Update;
   try
      if not ArchiveData then
         begin
            MessageDlg('Data Archive failed - contact Kingswood',mtError,[mbOK],0);
            Update;
            Exit; // some error has occurred during Archiving, exit BackupToServer.
         end;

      if not TestBackup(FArchivedBackupFileName) then Exit;

      FileName := FArchiveDirectory + BackupFileName +'\'+BackupFileName+cZipExt;

      if FileExists(FileName) then
         DeleteFile(FileName);
      if not CopyFile(PChar(FArchivedBackupFileName), PChar(FileName), True) then
         begin
            UpdateStatus('Unable to copy file for backup.');
            Exit;
         end;

      SetCurrentDir(ApplicationPath);
      DLLHandle := LoadLibrary(cOnlineBackupDLLName);
      if DLLHandle = 0 then
         begin
            UpdateStatus(cOnlineBackupDLLUnableToLoad);
            MessageDlg(cOnlineBackupDLLUnableToLoad,mtError,[mbOk],0);
            Exit;
         end;

      UpdateStatus('Sending backup file to server...');
      try
         UserName := vartostr(PSysLongToDelphi(Cash11.serial_no));

         if KAC.IsAuthorised then // for accountant client data upload
            begin
               @UploadAccountantClientFile := GetProcAddress(DLLHandle, cFuncName_UploadAccountantClientFile);
               if @UploadAccountantClientFile <> nil then
                  begin
                     Result := UploadAccountantClientFile(PChar(IntToStr(KAC.Id)), PChar(KAC.AccessKey), PChar(UserName), PChar(FileName));
                     Update;
                     ResultToScreen(Result);
                  end
               else
                  DLLFuncFailure(cFuncName_UploadAccountantClientFile);
            end
         else
            begin
               if FDataAction = daBackup then
                  begin
                     @UploadFile := GetProcAddress(DLLHandle, cFuncName_UploadFile);
                     if @UploadFile <> nil then
                        begin
                           Result := UploadFile(PChar(UserName),PChar(FileName));
                           Update;
                           ResultToScreen(Result);
                           if Result then
                              AccsDataModule.AccsDefaultsLastBackupDate := Now;
                        end
                     else
                        DLLFuncFailure(cFuncName_UploadFile);
                  end
               else if FDataAction = daSendToAccountant then
                  begin
                     @UploadFileWithParams := GetProcAddress(DLLHandle, cFuncName_UploadFileWithParams);
                     if @UploadFileWithParams <> nil then
                        begin
                           Result := UploadFileWithParams(PChar(UserName),PChar(FileName),PChar('SEND_TO_ACCOUNTANT'));
                           Update;
                           ResultToScreen(Result);
                        end
                     else
                        DLLFuncFailure(cFuncName_UploadFileWithParams);
                  end;
            end;

      finally
         FreeLibrary(DLLHandle);
      end;
   finally
      Screen.Cursor := crDefault;
   end;
end;

function TfmDataBackup.RestoreFromServer: Boolean;
var
   RestoreFile : TRestoreFile;
   RestoreFileWithParams : TRestoreFileWithParams;

   UserName, DataStore : string;
   PResult : PChar;
   SFile : string;

   procedure ProcessResult(AFileName : string);
   begin
      Update;
      if FileExists(AFileName) then
         RestoreData(AFileName)
      else if (AFileName = '') then
         begin
            UpdateStatus('Restore has been cancelled.');
            ForceTopMostMessageDlg(StatusBar.Panels[0].Text,mtError,[mbOk],0);
         end
      else if (AFileName <> '') then
         begin
            UpdateStatus('Restore has failed!');
            ForceTopMostMessageDlg(StatusBar.Panels[0].Text,mtError,[mbOk],0);
         end;
   end;

begin
   Cursor := crHourGlass;
   try
      //   30/07/20 [V4.5 R3.4] /MK Change - If user has accountant serial number between 100 and 999 and the config file is missing then give prompt to contact Kingswood.
      if ( ((FFarmgateSerialNo >= 100) and (FFarmgateSerialNo <= 999)) or (FFarmgateSerialNo = 10001) ) and ( not(FileExists('C:\Kingsacc\kac.config')) ) then
         begin
            MessageDlg('The Kingswood Accountant Link control file is missing.'+cCRLF+
                       'Please contact Kingswood Support at +353-1-4559491.',mtError,[mbOK],0);
            Exit;
         end;

      if ( KAC.IsAuthorised ) then // for accountant client data download
         begin
            DownloadAccountantClients;
         end
      else if ArchiveData then
         begin
            UpdateStatus('Retrieving files from server...');
            SetCurrentDir(ApplicationPath);
            if FileExists( IncludeTrailingBackslash(ApplicationPath)+cOnlineBackupDLLName) then
               begin
                  DLLHandle := LoadLibrary(cOnlineBackupDLLName);
                  if (DLLHandle <> 0) then
                     begin
                        try
                          UserName := vartostr(PSysLongToDelphi(Cash11.serial_no));
                          DataStore := BackupFileName;

                          if (FDataAction = daRestore) then
                             begin
                                @RestoreFile := GetProcAddress(DLLHandle, cFuncName_RestoreFile);
                                if @RestoreFile <> nil then
                                   begin
                                      PResult := RestoreFile(PChar(UserName),PChar(DataStore));
                                      SFile := StrPas(PResult);
                                      Update;
                                      ProcessResult(SFile);
                                   end
                                else
                                   MessageDlg(Format(cOnlineBackupDLLCallToFunctionFailed,[cFuncName_UploadFile]),mtError,[mbOk],0);
                             end
                          else if (FDataAction = daReceiveFromAccountant) then
                             begin
                                @RestoreFileWithParams := GetProcAddress(DLLHandle, cFuncName_RestoreFileWithParams);
                                if @RestoreFileWithParams <> nil then
                                   begin
                                      PResult := RestoreFileWithParams( PChar(UserName), PChar(DataStore), 'RECEIVE_FROM_ACCOUNTANT');
                                      SFile := StrPas(PResult);
                                      Update;
                                      ProcessResult(SFile);
                                   end
                                else
                                   MessageDlg(Format(cOnlineBackupDLLCallToFunctionFailed,[cFuncName_RestoreFileWithParams]),mtError,[mbOk],0);
                             end
                         finally
                            FreeLibrary(DLLHandle);
                         end;
                      end
                   else
                      begin
                         UpdateStatus(cOnlineBackupDLLUnableToLoad);
                         MessageDlg(cOnlineBackupDLLUnableToLoad,mtError,[mbOk],0);
                      end;
                end
            else
               begin
                  MessageDlg(cOnlineBackupDLLNotFound,mtError,[mbOk],0);
                  DownloadRequiredOnlineBackupClientDll;
                end;
         end;
   finally
      Cursor := crDefault;
   end;
end;

procedure TfmDataBackup.DefaultHandler(var Message);
begin
  with TMessage(Message) do
  begin
    if (Msg = WM_KingswoodData_BackupUpdateScreen) then
       Update
    else
       inherited DefaultHandler(Message);
  end;
end;

procedure TfmDataBackup.DeleteData(const ADirectory: string);

var
   i : Integer;
   SearchRec : TSearchRec;
   ScanDir : String;
   ParentDir : string;
begin

   ScanDir := IncludeTrailingBackslash(ADirectory);

   ParentDir := LowerCase(GetParentDirectory(ScanDir));
   if (ParentDir <> 'c:\kingsacc\') then Exit; // new check

   if Pos('kingsacc\', LowerCase(ScanDir)) > -1 then // make sure it is a Kingsacc SubDirectory
      begin
         i := FindFirst( ScanDir + '*.*' , faAnyFile , SearchRec ) ;
         if i = 0 then
           begin
              if ( SearchRec.Name <> '.' ) and ( SearchRec.Name <> '..' ) then
                 begin
                    SysUtils.DeleteFile(ScanDir + SearchRec.Name);
                 end;

              while FindNext( SearchRec ) = 0 do
                 if ( SearchRec.Name <> '.' ) and ( SearchRec.Name <> '..' ) then
                    begin
                       SysUtils.DeleteFile(ScanDir + SearchRec.Name);
                    end;
              SysUtils.FindClose(SearchRec) ;
           end;
      end;
end;

procedure TfmDataBackup.GetOBClientProgress(Sender: TLMDWebHTTPGet;
  Item: TLMDDownloadItem);
begin
  FProgressBar.Position := Item.Progress;
  if FProgressBar.Position >= 100 then
     begin
        FProgressBar.Visible := False;
        FProgressBar.Position := 0;
     end;
  Update;
end;

procedure TfmDataBackup.GetOBClientProcessed(Sender: TObject);
var
   MsgText, FileName : string;
begin
   FileName := IncludeTrailingBackslash(GetOBClient.DownloadDir) + GetOBClient.DestinationName;
   if FileExists(FileName) then
      begin
         MsgText := 'File was successfully downloaded and installed.';
         MessageDlg(MsgText,mtInformation,[mbOK],0);
         BackupToServer;
      end
   else
      begin
         MsgText := 'File download has failed.';
         MessageDlg(MsgText,mtError,[mbOK],0);
      end;
   UpdateStatus(MsgText);
end;

procedure TfmDataBackup.DownloadRequiredOnlineBackupClientDll;
begin
   if IsNetConnected then
      begin
         Screen.Cursor := crHourGlass;
         Update;
         try
            Application.ProcessMessages;
            FProgressBar.Position := 0;
            FProgressBar.Visible := True;
            GetOBClient.Process(False, True);
         finally
            Screen.Cursor := crDefault;
            Update;
         end;
      end
   else
      MessageDlg(cINTERNET_CONNECTION_NOT_ESTABLISHED,mtError,[mbOK],0);
end;

procedure TfmDataBackup.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   // must reset the current directory to root dir before initializing data.
   SetCurrentDir(ExtractFilePath(ParamStr(0)));
   if not(AccsDataModule.RestartProgramAfterBackupRestore) then
      begin
         Initialise;
         AccsDataModule.OpenAllFiles;
         { ReOpen all other Files }
         If Not OpenAll Then
            AbortProgram ('Error Opening Database Files - Contact Kingswood');
      end;
end;

procedure TfmDataBackup.DownloadAccountantClients;
const
   ErrorInDownload = 'Error downloading client data.';
var
   DownloadAccountantClientData : TDownloadAccountantClientFile;
   UserName : string;
   PResult : PChar;
   ReturnVal : string;
   DLLHandle : THandle;
   FileName : string;
   RestoreToDatabase : string;
begin
   DLLHandle := LoadLibrary(pchar(ApplicationPath + cDLLName));
   if ( DLLHandle = 0 ) then
      begin
         MessageDlg(cDLLUnableToLoad,mtError,[mbOk],0);
         Exit;
      end;

   try
     try
        UserName := IntToStr(KAC.Id);
        @DownloadAccountantClientData := GetProcAddress(DLLHandle, cFuncName_DownloadAccountantClientFile);
        if (@DownloadAccountantClientData = nil) then
           begin
              MessageDlg(cDLLCallToFunctionFailed,mtError,[mbOk],0);
              Exit;
           end;

        Update;
        PResult := DownloadAccountantClientData(PChar(UserName),PChar(KAC.AccessKey));
        if (PResult = nil) then
           begin
              MessageDlg(ErrorInDownload,mtError,[mbOk],0);
              Exit;
           end;

        ReturnVal := StrPas(PResult);
        if (FileExists(ReturnVal)) then
           begin
              // Check if the company downloaded is different from the current company
              // If it is, notify user of program restart.

              //   30/07/20 [V4.5 R3.4] /MK Change - Prompt user with new uRestoreToNewCompanyName to allow accountants to specify new name for downloaded company.
              RestoreToDatabase := TfmRestoreToNewCompanyName.NewCompanyName(UPPERCASE(Copy(ReturnVal, Pos('_', ReturnVal)+1, Pos('.', ReturnVal)-Pos('_', ReturnVal)-1)));
              //   30/07/20 [V4.5 R3.4] /MK Change - If the user cancels the new uRestoreToNewCompanyName then cancel restore of data.
              if ( Length(RestoreToDatabase) = 0 ) then
                 begin
                    MessageDlg('Restore cancelled.',mtInformation,[mbOK],0);
                    Exit;
                 end;

              //   30/07/20 [V4.5 R3.4] /MK Change - If the new company name already exists prompt user with confirmation to overwrite this data.
              if ( DirectoryExists(ApplicationPath+RestoreToDatabase) ) then
                 if ( MessageDlg(Format('Company name %s already exists. Do you want to overwrite this company?',[RestoreToDatabase]),mtConfirmation,[mbYes,mbNo],0) = mrNo ) then
                    begin
                       MessageDlg('Restore cancelled.',mtInformation,[mbOK],0);
                       Exit;
                    end;

              if ( RestoreToDatabase <> UPPERCASE(FDatabaseName) ) then
                 begin
                    AccsDataModule.RestartProgramAfterBackupRestore := True;
                    RestoreClientDataToDirectory(ReturnVal, ApplicationPath + RestoreToDatabase);
                    //   30/07/20 [V4.5 R3.4] /MK Change - Removed FarmgateWrapper here as it was causing a Termination Message Security Error and then closing the program
                    //                                     without the user getting the MessageDlg below to inform that the company name is different.
                    //FarmGateWrapper.SetDefaultCompany(RestoreToDatabase);
                    MessageDlg('The database you have downloaded is named differently to the current database.'+#13#10+
                               'You must restart the program and select the downloaded company.',mtWarning,[mbOK],0);
                    Application.Terminate;
                 end
              else
                 begin
                    RestoreClientDataToDirectory(ReturnVal,DataDirectory);
                    Close;
                 end;
           end
        else if (ReturnVal = 'NOCLIENTSELECTED') or (ReturnVal = 'NOCOMPANYSELECTED') then
           // do nothing
        else if (ReturnVal = 'NOCLIENTSAVAILABLE') then
           MessageDlg('There are currently no clients available for download.',mtInformation,[mbOk],0)
        else
           MessageDlg(ErrorInDownload,mtError,[mbOk],0);
     except
        on e : Exception do
           raise Exception.Create(E.Message);
     end;
   finally
      FreeLibrary(DLLHandle);
   end;
end;

procedure TfmDataBackup.blbAccountantLinkClick(Sender: TObject);
begin
   TfmAccountantLink.Show();
end;

procedure TfmDataBackup.blbUndoPointsClick(Sender: TObject);
begin
   Application.CreateForm(TBackupForm, BackupForm);
   try
      BackupForm.showmodal;
   finally
      FreeAndNil(BackupForm);
   end;
end;

procedure TfmDataBackup.SetupScreen;
begin
   if (FDataAction in [daBackup,daSendToAccountant]) then
      DataActionPageControl.ActivePage := tsBackup
   else if (FDataAction in [daRestore,daReceiveFromAccountant]) then
      DataActionPageControl.ActivePage := tsRestore;
end;

procedure TfmDataBackup.DisableActions(AZipDestinations : TZipDestinations);
begin
   if (zdExternalDevice in AZipDestinations) then
      begin
         lExternalStorage.Enabled := False;
         lExternalStorageDescription.Enabled := False;
         btnExternalDeviceBackupRestore.Enabled := False;
         Bevel3.Enabled := False;
      end;

   if (zdCDR in AZipDestinations) then
      begin
         lCDStorage.Enabled := False;
         lCDStorageDescription.Enabled := False;
         btnCDBackupRestore.Enabled := False;
         Bevel4.Enabled := False;
      end;
end;

procedure TfmDataBackup.FormActivate(Sender: TObject);
begin
   if FExitEarly then
      Timer.Enabled := True;
end;

procedure TfmDataBackup.TimerTimer(Sender: TObject);
begin
   Timer.Enabled := False;
   Close;
end;

procedure TfmDataBackup.RestoreClientDataToDirectory(const AFileName,
  ADataDirectory: string);
begin
   Cursor := crHourGlass;
   Enabled := False;
   FProgressBar.Position := 0;
   FProgressBar.Visible := True;
   UpdateStatus('Attempting Restore of Data...');
   try
      if ForceTopMostMessageDlg('This restore will replace all existing data.'+cCRLFx2+'Do you want to continue?',mtWarning,[mbYes,mbNo],0) = mrYes Then
         begin
            UpdateStatus('Attempting restore of client data, please wait...');
            // Remove all data files, which eliminates conflicts with index files
            DeleteData(ADataDirectory);
            if ZipDataExecuteAction(AFileName, ADataDirectory, TRUE, FALSE, zoUnzip) then
               begin
                  AccsSettings.LastRestoreDate := Date;
                  Update;
                  UpdateStatus('Client data successfully restored to '+ ADataDirectory);
                  MessageDLG(StatusBar.Panels[0].Text,mtInformation,[mbOK],0);
               end
            else
               begin
                  UpdateStatus('Client data restore has failed - contact Kingswood');
                  ForceTopMostMessageDlg('Backup restore has failed',mtError,[mbOK],0);
               end;
         end
      else
         begin
            UpdateStatus('Client data restore has been cancelled.');
            Application.ProcessMessages;
         end;
   finally
      Cursor := crHourGlass;
      Enabled := True;
      FProgressBar.Visible := False;
   end;
end;

procedure TfmDataBackup.CopyFilesToDataFolder(ADataDirectory: string);
begin
   //   14/12/16 [V4.2 R5.1] /MK Bug Fix - Only copy the file when it doesn't exist. 
   if ( not(FileExists(IncludeTrailingBackslash(ADataDirectory) + 'Farmgate.def')) ) then
      CopyFile(pChar('C:\Kingsacc\Farmgate.def'),pChar(IncludeTrailingBackslash(ADataDirectory) + 'Farmgate.def'),False);
end;

initialization
  WM_KingswoodData_BackupUpdateScreen := RegisterWindowMessage('WM_KingswoodDataBackupUpdateScreen');

end.
