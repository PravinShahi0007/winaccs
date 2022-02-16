//   08/02/22 [V4.5 R6.5] /MK Bug Fix - SyncConfigured - If we can't load the SyncSettings file then return the result as false and exit.
//                                    - FarmSyncSettings.Create - If we can't load the first node from SyncSettings then this would indicate the file is empty so set
//                                                                AccsDataModule.SyncSettingsLoadError which deletes the file in MainUnit.FormActivate.

unit uFarmSyncSettings;

interface
uses
   Windows, SysUtils, Classes, MSXML2_TLB, ComObj, ShellAPI,
   db, dbTables, Dialogs;

type
  TfmFarmSyncSettings = class
  private
    FDataPath : string;

    Document : IXMLDOMDocument;
    RootNode, SettingsNode : IXMLDOMNode;
    CompaniesNode : IXMLDOMNodeList;
    CompanyNode, Attribute,ChildNode, OptionsNode, TempNode: IXMLDOMNode;

    SettingsDirectory : string;
    SettingsFileName :string;

    { Private declarations }

    procedure WriteSettings();
    procedure UpdateSyncRequirement(const ACompanyName : string);

    procedure AddCompany(const ACompanyName : string);
    function GetCompanyNode(const ACompanyName : string): IXMLDOMNode; 

    procedure CreateLogEntry(LogEntry : string);
  public
    { Public declarations }
    constructor create;
    destructor destroy;override;
    class procedure UpdateSettings();
    class procedure EnforceSyncRequirement(const ACompanyName : string);
    class function SyncOnProgramStartup(const ACompanyName : string) : Boolean;
    class function SyncServiceIsAvailable : Boolean;
    class function SyncConfigured(const ACompanyName : String) : Boolean;
  end;

implementation
uses
  FileCtrl, AccsUtils, AccsData;

const
   LogFileName = 'C:\Kingsacc\Services\log.txt';
   ServiceFileName = 'C:\Kingsacc\Services\FarmSync.exe';
   SyncSettingsFileName = 'C:\Kingsacc\Services\SyncSettings.xml';

{ TfmFarmSyncSettings }

procedure TfmFarmSyncSettings.AddCompany(const ACompanyName : string);
begin
   if (Trim(ACompanyName) ='') then
      begin
         CreateLogEntry('Parameter value expected but not supplied.');
         Exit;
      end;

   CompanyNode := GetCompanyNode(ACompanyName);

   if (CompanyNode <> nil) then
       Exit;

   CompanyNode := Document.createElement('company');

   Attribute := Document.createAttribute('name');
   Attribute.Set_text(ACompanyName);
   CompanyNode.attributes.setNamedItem(Attribute);

   ChildNode := Document.createElement('syncRequired');
   ChildNode.Set_text('true');
   CompanyNode.appendChild(ChildNode);

   ChildNode := Document.createElement('lastSyncDate');
   CompanyNode.appendChild(ChildNode);

   ChildNode := Document.createElement('sendTimeOut');
   ChildNode.Set_text('5');
   CompanyNode.appendChild(ChildNode);

   ChildNode := Document.createElement('receiveTimeOut');
   ChildNode.Set_text('5');
   CompanyNode.appendChild(ChildNode);

   OptionsNode := Document.createElement('options');

   ChildNode := Document.createElement('syncOnProgramStartup');
   ChildNode.Set_text('true');
   OptionsNode.appendChild(ChildNode);

   ChildNode := Document.createElement('showSummaryAfterSync');
   ChildNode.Set_text('true');
   OptionsNode.appendChild(ChildNode);

   ChildNode := Document.createElement('storeCredentialsInPlainText');
   ChildNode.Set_text('true');
   OptionsNode.appendChild(ChildNode);

   CompanyNode.appendChild(OptionsNode);

   SettingsNode.appendChild(CompanyNode);
end;

constructor TfmFarmSyncSettings.create;
begin
   Document := nil;
   RootNode  := nil;
   SettingsNode := nil;
   CompanyNode := nil;
   Attribute := nil;
   ChildNode := nil;

   SettingsDirectory := 'C:\Kingsacc\Services';

   try
      Document := CreateOleObject('MSXML2.DOMDocument') as IXMLDOMDocument;
   except
      raise Exception.Create('Error creating MSXML2.DOMDocument. Please contact Kingswood.');
   end;

   if not (FileExists(SettingsDirectory + '\SyncSettings.xml')) then
      begin
         Document.appendChild(Document.createProcessingInstruction('xml', 'version="1.0" encoding="utf-8"'));
         RootNode := Document.createElement('farmSync'); // Create Root Node
         Document.appendChild(RootNode);

         SettingsNode := Document.createElement('settings');
         RootNode.appendChild(SettingsNode);
      end
   else
      begin
         Document.load(SettingsDirectory + '\SyncSettings.xml');
         RootNode := Document.selectSingleNode('farmSync');
         //   08/02/22 [V4.5 R6.5] /MK Bug Fix - If we can't load the first node from SyncSettings then this would indicate the file is empty so set
         //                                      AccsDataModule.SyncSettingsLoadError which deletes the file in MainUnit.FormActivate.
         try
            SettingsNode := RootNode.selectSingleNode('settings');
         except
            AccsDataModule.SyncSettingsLoadError := True;
         end;
         CompaniesNode := Document.getElementsByTagName('company');
      end;
end;

destructor TfmFarmSyncSettings.destroy;
begin
  inherited;
   Document := nil;
   RootNode  := nil;
   SettingsNode := nil;
   ChildNode := nil;
end;

class procedure TfmFarmSyncSettings.EnforceSyncRequirement(const ACompanyName: string);
var
   FarmSyncSettings : TfmFarmSyncSettings;
begin
{   if not FileExists(ServiceFileName) then Exit;

   FarmSyncSettings := TfmFarmSyncSettings.create;
   FarmSyncSettings.SyncType := ASyncType;
   FarmSyncSettings.UpdateSyncRequirement(ADatabaseName,AFarmId);
   FreeAndNil(FarmSyncSettings);  }
end;

function TfmFarmSyncSettings.GetCompanyNode(const ACompanyName : string): IXMLDOMNode;
var
   i : Integer;
   DatabaseName : string;
begin
   Result := nil;

   if (Document = nil) then Exit;
   CompaniesNode := Document.getElementsByTagName('company');
   if (CompaniesNode = nil) or (CompaniesNode.length <= 0) then Exit;
   for i := 0 to CompaniesNode.length-1 do
      begin
         CompanyNode := CompaniesNode.Get_item(i);
         if (CompanyNode <> nil) then
            begin
               ChildNode := CompanyNode.attributes.getNamedItem('name');
               if (ChildNode <> nil) then
                  begin
                     DatabaseName := UPPERCASE(ChildNode.Get_text);
                     if UPPERCASE(DatabaseName) = UPPERCASE(ACompanyName) then
                        begin
                           Result := CompanyNode;
                           Break;
                        end;
                  end;
            end;
      end;
end;

procedure TfmFarmSyncSettings.WriteSettings;
var
   i : Integer;
   Databases : TStringList;
   CurrentDatabase : string;
begin
   CurrentDatabase := Uppercase(AccsDataModule.CurrentDatabase);
   FileCtrl.ForceDirectories(SettingsDirectory);

   Databases := TStringList.Create;
   try
      AccsUtils.GetDatabases(Databases);
      for i := 0 to Databases.Count-1 do
         begin
            if (Uppercase(Databases[i]) = UpperCase(CurrentDatabase)) then
               AddCompany(Databases[i]);
         end;
   try
      Document.Save(SettingsDirectory + '\SyncSettings.xml');
   except
      on e : exception do
         begin
            CreateLogEntry('WriteSettings() '+e.Message);
         end;
   end;
   finally
      FreeAndNil(Databases);
   end;
end;

procedure TfmFarmSyncSettings.CreateLogEntry(LogEntry: string);
begin
   LogEntry := Format('[START: %s]',[FormatDateTime('dd/MM/yyyy hh:nn',Now)]) + #13#10 + #13#10 +
               LogEntry + #13#10 + #13#10 +
               '[END]' + #13#10 + #13#10;

   InsertAllText(LogEntry, 'C:\Kingsacc\Services\log.txt');
end;

class procedure TfmFarmSyncSettings.UpdateSettings();
var
   FarmSyncSettings : TfmFarmSyncSettings;
begin
   if ( not(FileExists(ServiceFileName)) ) then Exit;
   FarmSyncSettings := TfmFarmSyncSettings.create;
   FarmSyncSettings.WriteSettings;
   FreeAndNil(FarmSyncSettings);
end;

class function TfmFarmSyncSettings.SyncServiceIsAvailable: Boolean;
begin
   Result := FileExists(ServiceFileName);
end;

class function TfmFarmSyncSettings.SyncConfigured(const ACompanyName : String): Boolean;
var
   tempNode, pData, uData : IXMLDOMNode;
   FarmSyncSettings : TfmFarmSyncSettings;
begin
   Result := False;
   if ( AccsDataModule.SyncSettingsLoadError ) then Exit;
   try
      //   08/02/22 [V4.5 R6.5] /MK Bug Fix - If we can't load the SyncSettings file then return the result as false and exit.
      if not FileExists(ServiceFileName) then Exit;

      FarmSyncSettings := TfmFarmSyncSettings.create;
      with FarmSyncSettings do
        try
           tempNode := FarmSyncSettings.GetCompanyNode(ACompanyName);

           if ( TempNode = nil ) then Exit;

           pData := TempNode.selectSingleNode('pData');
           uData := TempNode.selectSingleNode('uData');
           if (((uData <> nil) and (Trim(uData.Text) <>'')) and
               ((pData <> nil) and (Trim(pData.Text) <>''))) then
              Result := True;
        finally
           FreeAndNil(FarmSyncSettings);
        end;
   except
      Result := False;
   end;
end;

class function TfmFarmSyncSettings.SyncOnProgramStartup(const ACompanyName: string): Boolean;
begin
//
end;

procedure TfmFarmSyncSettings.UpdateSyncRequirement(const ACompanyName: string);
begin
//
end;

end.
