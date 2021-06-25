{
   15/05/14 [V4.1 R7.1] /MK Bug Fix - Program was not saving the Payment Based Vat tick.

   23/11/15 [V4.2 R1.4] /MK Additional Feature - Added Andrew TGM changes to show Payment Based Vat Report &
                                                 whether VAT is on Sales, Purchases or Both.

   24/11/15 [V4.2 R1.4] /MK Change - Do not show CurrencyBox ever - GL request.

   02/03/16 [V4.2 R1.9] /MK Additional Feature - Added new hint to "Allow Overwrite of Nominal Description" preference from GL text.
                                               - Remember default hint delay time and set it to 10 seconds when the form activates
                                                 and set it back to the default time when the form closes.

   14/05/18 [V4.2 R0.8] /MK Change - Changed the term Farm Sync to App Sync - more appropriate to contractors - GL request.                                                 

   16/09/19 [V4.5 R0.4] /MK Bug Fix - FormActivate - Only show "Auto Enterprise Selection" preference is Enterprise module exists.

   14/10/20 [V4.5 R4.3] /MK Change - actMTDUsernameAndPasswordExecute - Changed prompt, validate and store of Username and Password to new AccsUtils function.

   15/10/20 [V4.5 R4.3] /MK Change - Changed Kingswood support phone number and address - GL request.
}

unit uSysMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uBaseForm, cxVGrid, cxInplaceContainer, Db, StdCtrls, dxmdaset, cxStyles,
  cxContainer, cxEdit, cxGroupBox, cxPC, ActnList, dxBar, dxBarExtItems,
  cxControls, dxStatusBar, cxCheckBox, cxProgressBar, Buttons, jpeg,
  ComCtrls, ExtCtrls, Mask, cxButtons, cxTextEdit,uAccsMessages, cxLabel,
  cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxClasses,
  cxGridLevel, cxGrid, cxEditRepositoryItems, cxRadioGroup,
  dxGDIPlusClasses;

type
  TfmSysMain = class(TBaseForm)
    PageControl: TcxPageControl;
    tsPreferences: TcxTabSheet;
    tsAccountsSettings: TcxTabSheet;
    tsOwnerInformation: TcxTabSheet;
    cxGroupBox1: TcxGroupBox;
    cxStyleRepository1: TcxStyleRepository;
    cxStyleCategory: TcxStyle;
    vgPreferences: TcxVerticalGrid;
    vgcrTransactionInput: TcxCategoryRow;
    vgerUseSimpleLayout: TcxEditorRow;
    vgcrDataImport: TcxCategoryRow;
    vgerUseCoOpImport: TcxEditorRow;
    vgcrMiscellaneous: TcxCategoryRow;
    vgerAutoCompleteCommentNominal: TcxEditorRow;
    vgerUseLastDescriptionAsComment: TcxEditorRow;
    vgerEnableTransactionGridColumnGrouping: TcxEditorRow;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    CurrentMonth: TLabel;
    FinancialLabel: TLabel;
    CompanyEdit: TcxTextEdit;
    YearEdit: TcxTextEdit;
    MonthEdit: TcxTextEdit;
    StartEdit: TcxTextEdit;
    AltEdit: TcxTextEdit;
    CurrencyBox: TGroupBox;
    Label13: TLabel;
    Label20: TLabel;
    Label14: TLabel;
    Label21: TLabel;
    PuntImage: TImage;
    EuroImage: TImage;
    EuroConverter: TMaskEdit;
    EuroToPunt: TMaskEdit;
    CurrencyGroup: TRadioGroup;
    TabControl1: TTabControl;
    PasswordGroup: TGroupBox;
    LPassOld: TLabel;
    LPassNew: TLabel;
    LPassConfirm: TLabel;
    Label4: TLabel;
    PasswordUse: TcxCheckBox;
    PassOld: TcxTextEdit;
    PassConfirm: TcxTextEdit;
    PassNew: TcxTextEdit;
    ConfirmPassOld: TcxTextEdit;
    PeriodEnd: TGroupBox;
    Label22: TLabel;
    ResetNomCheck: TcxCheckBox;
    ResetSalesCheck: TcxCheckBox;
    ResetPurchCheck: TcxCheckBox;
    RetainTxCheck: TcxCheckBox;
    GroupBox1: TGroupBox;
    Label17: TLabel;
    Label6: TLabel;
    Label16: TLabel;
    lEmailTo: TLabel;
    Label19: TLabel;
    Label23: TLabel;
    lWebsite: TLabel;
    SerialNumber: TLabel;
    Label26: TLabel;
    Ownerlbl: TLabel;
    Image8: TImage;
    tsMaintenance: TcxTabSheet;
    cxGroupBox2: TcxGroupBox;
    btnDataIntegrityCheck: TcxButton;
    actDataIntegrityCheck: TAction;
    actRegisterProgram: TAction;
    btnRegisterProgram: TcxButton;
    TempEdit: TEdit;
    vgerPreferencesStubNoColumn: TcxEditorRow;
    vgerPreferencesCustomerColumn: TcxEditorRow;
    vgerPreferencesSupplierColumn: TcxEditorRow;
    vgerPreferencesQuantity: TcxEditorRow;
    vgerPreferencesComment: TcxEditorRow;
    vgerPreferencesHideOptionalColumns: TcxEditorRow;
    cxStyle1: TcxStyle;
    vgerPreferencesAnalysisCodeColumn: TcxEditorRow;
    vgerPreferencesAllowNominalLedgerAccess: TcxEditorRow;
    vgerUseAutoEntSelect: TcxEditorRow;
    vgPreferencesAllowFreeTextForNominalDescription: TcxEditorRow;
    tsFarmSync: TcxTabSheet;
    cxGroupBox3: TcxGroupBox;
    SyncSettingsBtn: TcxButton;
    actSyncSettings: TAction;
    cxButton1: TcxButton;
    actResetSyncFlags: TAction;
    teCompanyId: TcxTextEdit;
    btnUpdateCompanyId: TcxButton;
    cxLabel1: TcxLabel;
    actUpdateCompanyId: TAction;
    cbSyncWhenJobCardOpens: TcxCheckBox;
    JobCardActiveEntGridLevel: TcxGridLevel;
    JobCardActiveEntGrid: TcxGrid;
    cxLabel2: TcxLabel;
    JobCardActiveEntGridTableView: TcxGridTableView;
    JobCardActiveEntGridTableViewEnterpriseName: TcxGridColumn;
    JobCardActiveEntGridTableViewUse: TcxGridColumn;
    JobCardActiveEntGridTableViewId: TcxGridColumn;
    cxButton2: TcxButton;
    actFullSync: TAction;
    PreferencesEditRepos: TcxEditRepository;
    erPayVatOptionsRG: TcxEditRepositoryRadioGroupItem;
    gbVat: TGroupBox;
    PaymentVatCB: TcxCheckBox;
    rgSalesOrPurchOrBothVat: TcxRadioGroup;
    AgeByLabel: TLabel;
    AgeByCombo: TComboBox;
    cbOutputAgeOfDebtOnSync: TcxCheckBox;
    cbOutputExtStatementOnSync: TcxCheckBox;
    btnEmailSettings: TcxButton;
    actEmailSettings: TAction;
    cxButton3: TcxButton;
    actEmailTemplates: TAction;
    cbDownloadJobCardOncePerSession: TcxCheckBox;
    cbOutputJobCardRptOnSync: TcxCheckBox;
    cbOutputProformaRptOnSync: TcxCheckBox;
    btnEnterMTDSecret: TcxButton;
    actEnterKingswoodMTDClientCode: TAction;
    lMTDCodeEntered: TLabel;
    vgPreferencesUseSalePurchInvGrids: TcxEditorRow;
    MTDUsernameAndPasswordButton: TcxButton;
    actMTDUsernameAndPassword: TAction;
    procedure actSave2Execute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lEmailToClick(Sender: TObject);
    procedure lWebsiteClick(Sender: TObject);
    procedure lEmailToMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lWebsiteMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure actDataIntegrityCheckExecute(Sender: TObject);
    procedure actRegisterProgramExecute(Sender: TObject);
    procedure InvoiceAllocCBClick(Sender: TObject);
    procedure PasswordUseClick(Sender: TObject);
    procedure RetainTxCheckClick(Sender: TObject);
    procedure CurrencyGroupClick(Sender: TObject);
    procedure YearEditExit(Sender: TObject);
    procedure AltEditExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StartEditChange(Sender: TObject);
    procedure MonthEditChange(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure ConfirmPassOldKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OnEditChanged(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure MonthEditPropertiesChange(Sender: TObject);
    procedure vgPreferencesEditValueChanged(Sender: TObject;
      ARowProperties: TcxCustomEditorRowProperties);
    procedure actSyncSettingsExecute(Sender: TObject);
    procedure actResetSyncFlagsExecute(Sender: TObject);
    procedure actUpdateCompanyIdUpdate(Sender: TObject);
    procedure actUpdateCompanyIdExecute(Sender: TObject);
    procedure JobCardActiveEntGridTableViewUsePropertiesEditValueChanged(
      Sender: TObject);
    procedure actFullSyncExecute(Sender: TObject);
    procedure PaymentVatCBPropertiesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actEmailSettingsExecute(Sender: TObject);
    procedure actEmailTemplatesExecute(Sender: TObject);
    procedure cbDownloadJobCardOncePerSessionPropertiesChange(
      Sender: TObject);
    procedure actEnterKingswoodMTDClientCodeExecute(Sender: TObject);
    procedure actMTDUsernameAndPasswordExecute(Sender: TObject);
  private
    { Private declarations }
    FFormShowing : Boolean;
    FDefaultHintDelay : Integer;
    procedure LoadControlValues;
    procedure SaveControlValues;
    procedure CheckFinancialMonths (Sender : TObject);
    procedure EnablePreferenceOptions();
    procedure LoadJobCardSyncInfo;
  public
    { Public declarations }
    class procedure ShowSysMain;
  end;

  procedure MonthNames (Sender : TObject);

var
  fmSysMain: TfmSysMain;
  MonthStr : ShortString;
  MonthNo : Integer;
  datachanged : boolean;

implementation

uses AccsData, uPreferences, uPreferenceConsts,
    ShellAPI,
    init,
    DefSecFl,
    filed,
    dbcore,
    util,
    dbgen,
    vars,
    types,
    clears,
    calcs,
    MainUnit,
    FullAudit,
    uRegisterForm,
    uKingsCC,
    Registry, uAccsSystem, AccsUtils, uFarmSyncSettings, uAccsSync, uAccounts,
    uEmailTemplates,
    CredentialsStore,
    LoginCredentials,
    uLoginCredentials,
    uMTDApi;



{$R *.DFM}

{ TfmSysMain }

procedure MonthNames (Sender : TObject);
begin
     If monthno = 1 Then MonthStr := 'January'
     Else If monthno = 2 Then MonthStr := 'February'
     Else If monthno = 3 Then MonthStr := 'March'
     Else If monthno = 4 Then MonthStr := 'April'
     Else If monthno = 5 Then MonthStr := 'May'
     Else If monthno = 6 Then MonthStr := 'June'
     Else If monthno = 7 Then MonthStr := 'July'
     Else If monthno = 8 Then MonthStr := 'August'
     Else If monthno = 9 Then MonthStr := 'September'
     Else If monthno = 10 Then MonthStr := 'October'
     Else If monthno = 11 Then MonthStr := 'November'
     Else If monthno = 12 Then MonthStr := 'December'
     Else
         Begin
              (Sender as TEdit).Text := '';
              (Sender as TEdit).SetFocus;
              MonthStr := '';
         End;
end;

procedure TfmSysMain.LoadControlValues;
var
   Value : Integer;
begin
   with Preferences do
      begin
         //InvoiceAllocCB.Checked := ValueAsBoolean[cPref_EnableInvoiceAllocation];
         vgerAutoCompleteCommentNominal.Properties.Value := ValueAsBoolean[cPref_EnableSLPLDefaults];
         vgerUseCoOpImport.Properties.Value := ValueAsBoolean[cPref_EnableCoOpImport];
         vgerEnableTransactionGridColumnGrouping.Properties.Value := ValueAsBoolean[cPref_EnableTransGridColumnGrouping];
         vgerUseAutoEntSelect.Properties.Value := ValueAsBoolean[cPref_AutoEntSelect];

         vgerPreferencesStubNoColumn.Properties.Value := ValueAsBoolean[cPref_ShowStubNoColumn];
         vgerPreferencesCustomerColumn.Properties.Value := ValueAsBoolean[cPref_ShowCustomerColumn];
         vgerPreferencesSupplierColumn.Properties.Value := ValueAsBoolean[cPref_ShowSupplierColumn];
         vgerPreferencesQuantity.Properties.Value := ValueAsBoolean[cPref_ShowQuantityColumn];
         vgerPreferencesComment.Properties.Value := ValueAsBoolean[cPref_ShowCommentColumn];
         vgerPreferencesAnalysisCodeColumn.Properties.Value := ValueAsBoolean[cPref_ShowAnalysisCodeColumn];
         vgerPreferencesAllowNominalLedgerAccess.Properties.Value := ValueAsBoolean[cPref_AllowNominalLedgerAccess];
         vgPreferencesAllowFreeTextForNominalDescription.Properties.Value := ValueAsBoolean[cPref_AllowFreeTextForNominalDescriptionColumn];

         vgPreferencesUseSalePurchInvGrids.Properties.Value := ValueAsBoolean[cPref_ShowSalePurchGridMainGrid];

         // Show vgerPreferencesHideOptionalColumns as checked if no columns are being displayed.
         vgerPreferencesHideOptionalColumns.Properties.Value :=
             ( not vgerPreferencesStubNoColumn.Properties.Value ) and
             ( not vgerPreferencesCustomerColumn.Properties.Value ) and
             ( not vgerPreferencesSupplierColumn.Properties.Value ) and
             ( not vgerPreferencesQuantity.Properties.Value ) and
             ( not vgerPreferencesComment.Properties.Value ) and
             ( not vgerPreferencesAnalysisCodeColumn.Properties.Value);

         cbSyncWhenJobCardOpens.Checked := Preferences.ValueAsBoolean[cPref_JobCard_SyncOnOpen];

         Value := Preferences.ValueAsInteger[cPref_AgeOfDebt_AgedBy_Month];
         case Value of
           1 : AgeByCombo.ItemIndex := 0;
           2 : AgeByCombo.ItemIndex := 1;
           3 : AgeByCombo.ItemIndex := 2;
           6 : AgeByCombo.ItemIndex := 3;
           9 : AgeByCombo.ItemIndex := 4;
           12 : AgeByCombo.ItemIndex := 5;
         end;

         cbOutputAgeOfDebtOnSync.Checked := Preferences.ValueAsBoolean[cPref_OutputAgeOfDebtOnSync];
         cbOutputExtStatementOnSync.Checked := Preferences.ValueAsBoolean[cPref_OutputExtendedStatementOnSync];
         cbDownloadJobCardOncePerSession.Checked := Preferences.ValueAsBoolean[cPref_DownloadJobCardOncePerSession];

         cbOutputJobCardRptOnSync.Checked := Preferences.ValueAsBoolean[cPref_OutputJobCardRptOnSync];
         cbOutputProformaRptOnSync.Checked := Preferences.ValueAsBoolean[cPref_ProformaRptOnSync];
      end;
end;

procedure TfmSysMain.SaveControlValues;
var
   Value : Integer;
begin
   with Preferences do
      begin
         ValueAsBoolean[cPref_EnableSLPLDefaults] := vgerAutoCompleteCommentNominal.Properties.Value;
         ValueAsBoolean[cPref_EnableCoOpImport] := vgerUseCoOpImport.Properties.Value;
         ValueAsBoolean[cPref_EnableTransGridColumnGrouping] := vgerEnableTransactionGridColumnGrouping.Properties.Value;
         //ValueAsBoolean[cPref_EnableInvoiceAllocation] := InvoiceAllocCB.Checked;
         ValueAsBoolean[cPref_EnableInvoiceAllocation] := cash2.XAllocation;

         // Simple Entry Transaction Grid Column Visibility
         ValueAsBoolean[cPref_ShowStubNoColumn] := vgerPreferencesStubNoColumn.Properties.Value;
         ValueAsBoolean[cPref_ShowCustomerColumn] := vgerPreferencesCustomerColumn.Properties.Value;
         ValueAsBoolean[cPref_ShowSupplierColumn] := vgerPreferencesSupplierColumn.Properties.Value;
         ValueAsBoolean[cPref_ShowQuantityColumn] := vgerPreferencesQuantity.Properties.Value;
         ValueAsBoolean[cPref_ShowCommentColumn] := vgerPreferencesComment.Properties.Value;
         ValueAsBoolean[cPref_ShowAnalysisCodeColumn] := vgerPreferencesAnalysisCodeColumn.Properties.Value;
         ValueAsBoolean[cPref_AllowNominalLedgerAccess] := vgerPreferencesAllowNominalLedgerAccess.Properties.Value;
         ValueAsBoolean[cPref_AutoEntSelect] := vgerUseAutoEntSelect.Properties.Value;
         ValueAsBoolean[cPref_AllowFreeTextForNominalDescriptionColumn] := vgPreferencesAllowFreeTextForNominalDescription.Properties.Value;

         ValueAsBoolean[cPref_ShowSalePurchGridMainGrid] := vgPreferencesUseSalePurchInvGrids.Properties.Value;

         Preferences.ValueAsBoolean[cPref_JobCard_SyncOnOpen] := cbSyncWhenJobCardOpens.Checked;

         case AgeByCombo.ItemIndex of
           0 : Value := 1;
           1 : Value := 2;
           2 : Value := 3;
           3 : Value := 6;
           4 : Value := 9;
           5 : Value := 12;
         end;
         Preferences.ValueAsInteger[cPref_AgeOfDebt_AgedBy_Month] := Value;

         Preferences.ValueAsBoolean[cPref_OutputAgeOfDebtOnSync] := cbOutputAgeOfDebtOnSync.Checked;
         Preferences.ValueAsBoolean[cPref_OutputExtendedStatementOnSync] := cbOutputExtStatementOnSync.Checked;
         // SP 20/12/2017 - Suggestion by Dairy Direct
         Preferences.ValueAsBoolean[cPref_DownloadJobCardOncePerSession] := cbDownloadJobCardOncePerSession.Checked;

         Preferences.ValueAsBoolean[cPref_OutputJobCardRptOnSync] := cbOutputJobCardRptOnSync.Checked;
         Preferences.ValueAsBoolean[cPref_ProformaRptOnSync] := cbOutputProformaRptOnSync.Checked;

         PostMessage(FMainScreen.Handle,WM_GRIDCOLUMNLAYOUTCHANGED,0,0);
      end;
end;

class procedure TfmSysMain.ShowSysMain;
begin
   with TfmSysMain.create(nil) do
      try
         LoadControlValues;
         ShowModal;
      finally
         Free;
      end;
end;

procedure TfmSysMain.actSave2Execute(Sender: TObject);
var
   Str1,Str2 : ShortString;
begin
   inherited;
   SaveControlValues;
   Str1 := '';
   Str2 := '';

    If Not((Companyedit.Text = '') or (YearEdit.Text = '') or
           (MonthEdit.Text = '') or (StartEdit.Text = '') or (AltEdit.Text = '' )) then
           Begin
                Cash1.Xcompany := CompanyEdit.Text;
                Cash1.XFinYear := StrToInt(YearEdit.Text);
                Cash1.Xmonthno := StrToInt(MonthEdit.Text);
                Cash1.xfinMonth := StrToInt(StartEdit.Text);
                Cash2.Xentupper := (AltEdit.Text);
                Cash2.Xentlower := (TempEdit.Text);
                Cash1.xKeepTran := RetainTxCheck.Checked;
                Cash1.xResetNom := ResetNomCheck.Checked;
                cash1.XSimple := vgerUseSimpleLayout.Properties.Value;
                Cash11.xResetSales := ResetSalesCheck.Checked;
                Cash11.xResetPurchases := ResetPurchCheck.Checked;
                Cash11.xUseLastNomDesc := vgerUseLastDescriptionAsComment.Properties.Value;
                Str1 := PassOld.Text;
                Str2 := PassConfirm.Text;
                SlimAll( Str1 );
                SlimAll( Str2 );
                if Length(PassNew.text) > 0 then
                if PassNew.Text = PassConfirm.Text then
                   begin
                        PADRIGHT(Str2,SizeOf(Cash2.xPassword[2]));
                        Cash2.XPASSWORD[2] := Copy(Str2,1,SizeOf(Cash2.xPassword[2])); // Pass confirm
                        DefWrite(1);
                        Cash11.xp_words := PasswordUse.Checked;
                        DefWrite(11);
                   end
                else
                    MessageDlg('Password incorrect. Please input again.', mtInformation,[mbOK],0);

                if CurrencyBox.Visible = True Then //For Euro Conversion
                   begin
                        Cash11.xSaveAsEuro := (CurrencyGroup.ItemIndex = 1);
                        Cash11.xEuroConverter := StrToFloat(EuroConverter.Text);
                        DefWrite(11);
                   end;
                if PassOld.text = ConfirmPassOld.text then Cash11.xp_words := PasswordUse.Checked;
                if not PasswordUse.Checked then Cash2.XPASSWORD[2] := '      ';

                // TGM AB 12/06/15
                if ( rgSalesOrPurchOrBothVat.ItemIndex = 2 ) then
                   begin
                      cash11.xSalesPaymentVAT := 'Y';
                      cash11.xPurchPaymentVAT := 'Y';
                   end
                 else if ( rgSalesOrPurchOrBothVat.ItemIndex = 1 ) then
                    begin
                       cash11.xSalesPaymentVAT := 'N';
                       cash11.xPurchPaymentVAT := 'Y';
                    end
                 else
                    begin
                       cash11.xSalesPaymentVAT := 'Y';
                       cash11.xPurchPaymentVAT := 'N';
                    end;

                //   15/05/14 [V4.1 R7.1] /MK Bug Fix - Program was not saving the tick.
                cash2.XPaymentVAT := PaymentVatCB.Checked;

                Defwrite(0);
                Defwrite(1);
                DefWrite(11);
                Close;
           End
    Else
         Begin
              MessageDlg('Incomplete system settings.', mtInformation,[mbOk], 0);
              CompanyEdit.SetFocus;
         End;
   FMainScreen.SetupInterface;
end;

procedure TfmSysMain.FormActivate(Sender: TObject);
var
   vEuroConverter : Shortstring;
   TempPassOld : string;
   i : integer;
begin
  inherited;
     // Hide the Period end options
     FDefaultHintDelay := Application.HintHidePause;
     Application.HintHidePause := 10000;
     PeriodEnd.Hide;
     MonthNo := 0;
     vEuroConverter := '';

 //    GroupBox1.Hide;
//     ClientHeight := 358; // TGM AB was 320
//     Image4.Visible := False;
     If ( Cash2.XCOUNTRY = 2 ) then begin
        CurrencyGroup.items[0]:='IR£';
        Label21.Caption:='IR£';
     end else begin
          CurrencyGroup.items[0]:='Stg£';
          Label21.Caption:='Stg£';
     end;

//        CurrencyBox.Show;
//     Else
//        CurrencyBox.Hide;

     If Cash1.xCashBook Then
        Begin
             ResetSalesCheck.Hide;
             ResetPurchCheck.Hide;
             //cbUseLastDesc.Hide;
             vgerUseLastDescriptionAsComment.Visible := False;
        End
     else
        Begin
             vgerUseLastDescriptionAsComment.Visible := True;
             //cbUseLastDesc.Show;
             ResetSalesCheck.Show;
             ResetPurchCheck.Show;
             ResetSalesCheck.Checked := Cash11.xResetSales;
             ResetPurchCheck.Checked := Cash11.xResetPurchases;
        End;

     gbVat.Visible := ( (not(cash1.xcashbook)) and (cash2.XAllocation) and (not(cash11.XUse_Vat)) );
     PaymentVATCB.checked := cash2.XPaymentVAT;
     rgSalesOrPurchOrBothVat.Visible := PaymentVATCB.checked;
     if ( (cash11.xSalesPaymentVAT = 'Y') and (cash11.xPurchPaymentVAT = 'Y')) then
        rgSalesOrPurchOrBothVat.ItemIndex := 2
     else if ( (cash11.xSalesPaymentVAT = 'Y') and (cash11.xPurchPaymentVAT = 'N') ) then
        rgSalesOrPurchOrBothVat.ItemIndex := 0
     else if ( (cash11.xSalesPaymentVAT = 'N') and (cash11.xPurchPaymentVAT = 'Y') ) then
        rgSalesOrPurchOrBothVat.ItemIndex := 1
     else
        rgSalesOrPurchOrBothVat.ItemIndex := 2;

     vgerUseLastDescriptionAsComment.Properties.Value := Cash11.xUseLastNomDesc;
//     cbUseLastDesc.Checked := Cash11.xUseLastNomDesc;
     RetainTxCheck.Checked := Cash1.xKeepTran;
     ResetNomCheck.Checked := Cash1.xResetNom;
     CompanyEdit.Text := Cash1.XCOMPANY;
//     cbsimpleview.checked := Cash1.XSimple;
     vgerUseSimpleLayout.Properties.Value := Cash1.XSimple;

     vgcrTransactionInput.Visible := (AccsSystem.SystemType = stCashbook);

     //   16/09/19 [V4.5 R0.4] /MK Bug Fix - Only show "Auto Enterprise Selection" preference is Enterprise module exists. 
     vgerUseAutoEntSelect.Visible := soEnterprises in AccsSystem.SystemOptions;

     YearEdit.Text := IntToStr(Cash1.xfinyear);
     MonthEdit.Text := IntToStr(Cash1.Xmonthno);
     StartEdit.Text := IntToStr(Cash1.xfinMonth);
     AltEdit.Text := Cash2.xentupper;
     PassOld.text := '';
     ConfirmPassOld.Text := '';
     PassNew.text := '';
     PassConfirm.Text := '';
     TempPassOld := Cash2.XPASSWORD[2];
     for i := 1 to length(TempPassOld) do begin
         if TempPassOld[i] <> ' ' then PassOld.Text := PassOld.text + TempPassOld[i];
     end;
 //    MoreBtn.Caption := 'Mor&e';
     If NOT Cash11.xSaveAsEuro Then
        CurrencyGroup.ItemIndex := 0 // IRL
     Else
        CurrencyGroup.ItemIndex := 1; // EURO
     DoubleToStr ( Cash11.xEuroConverter, vEuroConverter, '%1.6f', False, False, 0, False );
     EuroConverter.Text := vEuroConverter; //StFrom;
     if Length(PassOld.text) > 0 then  PasswordUse.Checked := Cash11.xp_words
        else PasswordUse.Checked := false;

     PasswordUse.OnClick( Sender );
     try SerialNumber.caption := 'Serial Number: - ' + vartostr(PSysLongToDelphi ( Cash11.serial_no ));
     except SerialNumber.caption := 'Serial Number: - Error';
     end;
     try OwnerLbl.caption := 'Registered Owner: - ' + Cash1.xcompany;
     except OwnerLbl.caption := 'Registered Owner: - Error';
     end;

     If PasswordUse.checked = false then begin
        PassOld.Enabled := false;
        ConfirmPassOld.enabled := false;
        PassNew.enabled := true;
        PassConfirm.enabled := true;
        PasswordUse.enabled := true;
        PassOld.Style.Color := ClBtnFace;
        ConfirmPassOld.Style.color := ClBtnFace;
        PassNew.Style.Color := ClBtnFace;
        PassConfirm.Style.Color := ClBtnFace;

     end else begin
         PassNew.enabled := false;
         PassConfirm.enabled := false;
         PasswordUse.enabled := false;
         PassOld.Enabled := true;
         ConfirmPassOld.enabled := true;
         PassOld.Style.Color := ClWindow;
         ConfirmPassOld.Style.color := ClWindow;
         PassNew.Style.Color := ClBtnFace;
         PassConfirm.Style.Color := ClBtnFace;

     end;
     DataChanged := false;
     PageControl.ActivePage := tsPreferences;

   CheckFinancialMonths(MonthEdit);
   CheckFinancialMonths(StartEdit);

   EnablePreferenceOptions;

   FFormShowing := True;
   OnActivate := nil;
end;

procedure TfmSysMain.actHelpExecute(Sender: TObject);
begin
  inherited;
  Application.HelpContext(195);
end;

procedure TfmSysMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
    // Shows the Period end Options
    if ( Shift = [ssCTRL,ssShift] ) and ( Char(Key) in ['P','p'] ) then
       PeriodEnd.Show;
end;

procedure TfmSysMain.lEmailToClick(Sender: TObject);
begin
  inherited;
  ShellExecute(Self.Handle,'open','mailto:info@kingswood.ie',nil,nil,SW_SHOWNORMAL);

end;

procedure TfmSysMain.lWebsiteClick(Sender: TObject);
begin
  inherited;
  ShellExecute(Self.Handle,'open','http://www.kingswood.ie/',nil,nil,SW_SHOWNORMAL);

end;

procedure TfmSysMain.lEmailToMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
     LWebSite.Font.Color := clblue;
     LWebSite.Font.Style := [];
     Cursor := crHandPoint;
     lEmailTo.Font.Color := clRed;
     lEmailTo.Font.Style := [fsUnderline];
end;

procedure TfmSysMain.lWebsiteMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
     lEmailTo.Font.Color := clblue;
     lEmailTo.Font.Style := [];
     Cursor := crHandPoint;
     LWebSite.Font.Color := clRed;
     LWebSite.Font.Style := [fsUnderline];
end;

procedure TfmSysMain.GroupBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
     if ( Cursor <> crDefault ) then
        begin
           Cursor := crDefault;
           LEmailTo.Font.Color := clblue;
           LEmailTo.Font.Style := [];
           LWebSite.Font.Color := clblue;
           LWebSite.Font.Style := [];
        end;
end;

procedure TfmSysMain.actDataIntegrityCheckExecute(Sender: TObject);
begin
  inherited;
     Auditfiles.OnShow(self);
     Auditfiles.OnActivate(self);
     Auditfiles.checkbtnClick(self);
end;

procedure TfmSysMain.actRegisterProgramExecute(Sender: TObject);
begin
  inherited;
        RegistrationForm.AccRun := True;
        RegistrationForm.ShowModal;
end;

procedure TfmSysMain.InvoiceAllocCBClick(Sender: TObject);
begin
  inherited;
        //if InvoiceAllocCB.checked then PaymentVATCB.Show
        if cash2.XAllocation then PaymentVATCB.Show
        else PaymentVATCB.hide;
end;

procedure TfmSysMain.PasswordUseClick(Sender: TObject);
begin
  inherited;
     if FFormShowing then
        dataChanged := true;
     If PasswordUse.Checked Then
        Begin
             If length(PassOld.text) > 0 then begin
                PassOld.Enabled := True;
                ConfirmPassOld.enabled := true;
                PassOld.Style.Color := ClWindow;
                ConfirmPassOld.Style.color := ClWindow;
                PassNew.Style.Color := ClWindow;
                PassConfirm.Style.Color := ClWindow;

             end else begin
                PassOld.Enabled := false;
                ConfirmPassOld.enabled := false;
                PassOld.Style.Color := ClBtnFace;
                ConfirmPassOld.Style.color := ClBtnFace;
                PassNew.Style.Color := ClWindow;
                PassConfirm.Style.Color := ClWindow;
             end;
             PassNew.Style.Color := ClWindow;
             PassConfirm.Style.Color := ClWindow;
        End
     Else
        Begin
             PassOld.Enabled := False;
             PassNew.Enabled := False;
             PassConfirm.Enabled := False;
             PassOld.Style.Color := CLBtnFace;
             PassNew.Style.Color := CLBtnFace;
             PassConfirm.Style.Color := CLBtnFace;
             ConfirmPassOld.Style.color := ClBtnFace;
        End;

end;

procedure TfmSysMain.RetainTxCheckClick(Sender: TObject);
begin
  inherited;
     If (RetainTxCheck.Checked = False) Then
        Begin
             ResetNomCheck.Enabled := False;
             ResetSalesCheck.Enabled := False;
             ResetPurchCheck.Enabled := False;
        End
     Else
         Begin
             ResetNomCheck.Enabled := True;
             ResetSalesCheck.Enabled := True;
             ResetPurchCheck.Enabled := True;
         End;
end;

procedure TfmSysMain.CurrencyGroupClick(Sender: TObject);
begin
  inherited;
     if FFormShowing then
     dataChanged := true;
    If ( CurrencyGroup.ItemIndex = 0 ) Then
       Begin
            if Cash2.XCOUNTRY = 2 then CurrencyBox.Caption := 'Punt Currency'
                else CurrencyBox.Caption := 'Sterling Currency';
            EuroImage.hide;
            PuntImage.Show;
       End
    Else
       Begin
            CurrencyBox.Caption := 'EURO Currency';
            PuntImage.Hide;
            EuroImage.Show;
       End;
end;

procedure TfmSysMain.YearEditExit(Sender: TObject);
var
   Int : Integer;
begin
   inherited;
   If Numeric (Yearedit.Text) then
      Begin
           Int := StrToInt(YearEdit.Text);
           If Not((Int > 1989) AND (Int < 2501)) Then
           YearEdit.SetFocus;
      End
   Else
       YearEdit.SetFocus;

end;

procedure TfmSysMain.AltEditExit(Sender: TObject);
begin
  inherited;
  TempEdit.Text := AltEdit.Text;

end;

procedure TfmSysMain.FormShow(Sender: TObject);
Var
   St : ShortString;
   Doub : Double;
   registry:Tregistry;
   UseImport:string;
   keystring:string;
begin
   inherited;
   if ukingscc.UseKACC then
      begin
         Registry := TRegistry.Create;
         Registry.OpenKey('Software\Kingswood\kacc', True);
         Keystring := Registry.ReadString('Authorisation Key');
         Registry.Free;

         if ( keystring <> '' ) then
            actRegisterProgram.visible := False;
      end
   else
      actRegisterProgram.visible := False;

   tsFarmSync.TabVisible := AccsDataModule.SyncServiceIsAvailable;
   if (tsFarmSync.TabVisible) then
      LoadJobCardSyncInfo();

   actMTDUsernameAndPassword.Visible := ( (AccsSystem.Region = 'UK') and (not(cash11.XUse_Vat)) );

   if ( AccsSystem.Region = 'UK' ) then
      begin
         actEnterKingswoodMTDClientCode.Visible := ( (actMTDUsernameAndPassword.Visible) and (Length(AccsDataModule.APISecret) = 0) );
         lMTDCodeEntered.Visible := ( (actMTDUsernameAndPassword.Visible) and (not(actEnterKingswoodMTDClientCode.Visible)) );
      end
   else
      begin
         actEnterKingswoodMTDClientCode.Visible := False;
         lMTDCodeEntered.Visible := False;
      end;

end;

procedure TfmSysMain.StartEditChange(Sender: TObject);
begin
  inherited;
  CheckFinancialMonths(Sender);
end;

procedure TfmSysMain.MonthEditChange(Sender: TObject);
begin
  inherited;
  CheckFinancialMonths(Sender);
end;

procedure TfmSysMain.actExitExecute(Sender: TObject);
begin
  inherited;
  If ( Datachanged ) and ( MessageDlg('Do you wish to save System Changes ?', mtInformation, [mbYes, mbNo], 0) = mrYes) then
     actSave2.Execute;
  Close;
end;

procedure TfmSysMain.ConfirmPassOldKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
     If ((Uppercase(PassOld.text) = Uppercase(ConFirmPassOld.text)) or (Uppercase(ConFirmPassOld.text) = 'SILVER')) then begin
        PassNew.enabled := true;
        PassConfirm.enabled := True;
        PasswordUse.enabled := true;
        PassNew.Style.Color := ClWindow;
        PassConfirm.Style.Color := ClWindow;

     end else begin
        PassNew.enabled := false;
        PassConfirm.enabled := false;
        PasswordUse.enabled := false;
        PassNew.Style.Color := ClBtnFace;
        PassConfirm.Style.Color := ClBtnFace;
     end;
end;

procedure TfmSysMain.OnEditChanged(Sender: TObject);
begin
   if FFormShowing then
      DataChanged := true;
end;

procedure TfmSysMain.FormCreate(Sender: TObject);
begin
   FFormShowing := False;
   Position := poDesktopCenter;
   CheckFinancialMonths(MonthEdit);
   CheckFinancialMonths(StartEdit);
   tsFarmSync.TabVisible := TfmFarmSyncSettings.SyncServiceIsAvailable;
end;

procedure TfmSysMain.CheckFinancialMonths(Sender : TObject);
begin
   if (Sender is TcxTextEdit) then
      begin
         if FFormShowing then
            DataChanged := True;

         if ((Sender as TcxTextEdit).Name = 'MonthEdit') then
            begin
               If Numeric (MonthEdit.Text) Then
                  Begin
                       MonthNo := StrToInt(monthEdit.Text);
                       MonthNames(Sender);
                       CurrentMonth.Caption := MonthStr;
                       CurrentMonth.refresh;
                  End;
            end
         else if ((Sender as TcxTextEdit).Name = 'StartEdit') then
            begin
               If Numeric (StartEdit.Text) Then
                  Begin
                       MonthNo := StrToInt(StartEdit.Text);
                       MonthNames(Sender);
                       FinancialLabel.Caption := MonthStr;
                       FinancialLabel.refresh;
                  End;
            end;
      end;
end;

procedure TfmSysMain.MonthEditPropertiesChange(Sender: TObject);
begin
   inherited;
   CheckFinancialMonths(Sender);
end;

procedure TfmSysMain.EnablePreferenceOptions;
begin
   vgerPreferencesHideOptionalColumns.Visible := vgerUseSimpleLayout.Properties.Value;
   // Do not show option columns expanded if it is checked.
   vgerPreferencesHideOptionalColumns.Expanded := not vgerPreferencesHideOptionalColumns.Properties.Value;
   vgPreferencesUseSalePurchInvGrids.Visible := ( not(cash1.xcashbook) ) and ( not(cash11.XSimpleVAT) );
end;

procedure TfmSysMain.vgPreferencesEditValueChanged(Sender: TObject;
  ARowProperties: TcxCustomEditorRowProperties);
begin
   inherited;
   if ARowProperties.Caption = 'Hide All Optional Columns' then
      begin
         vgerPreferencesStubNoColumn.Properties.Value := not ARowProperties.Values[0];
         vgerPreferencesCustomerColumn.Properties.Value := not ARowProperties.Values[0];
         vgerPreferencesSupplierColumn.Properties.Value := not ARowProperties.Values[0];
         vgerPreferencesQuantity.Properties.Value := not ARowProperties.Values[0];
         vgerPreferencesComment.Properties.Value := not ARowProperties.Values[0];
         vgerPreferencesAnalysisCodeColumn.Properties.Value := not ARowProperties.Values[0];
      end
   else if ARowProperties.Caption = 'Allow Free Text Entry For Nominal Description' then
      begin
         if (ARowProperties.Values[0]) then
            MessageDlg('Allow Free Text Entry For Nominal Description IS ACTIVE',mtInformation,[mbOK],0);
      end;
   EnablePreferenceOptions;
   if FFormShowing then
      DataChanged := true;
end;

procedure TfmSysMain.actSyncSettingsExecute(Sender: TObject);
begin
  inherited;
  TfmFarmSyncSettings.UpdateSettings();
  uAccsSync.InvokeFarmSyncProgram(Handle,'-e -a "'+ AccsDataModule.CurrentDatabase +'"');
end;

procedure TfmSysMain.actResetSyncFlagsExecute(Sender: TObject);
begin
  inherited;
  uAccsSync.ResetSyncFlags(true, AccsDataModule.CurrentDatabase);
end;

procedure TfmSysMain.actUpdateCompanyIdUpdate(Sender: TObject);
begin
  inherited;
  actUpdateCompanyId.Enabled := Trim(teCompanyId.Text)<>'';
end;

procedure TfmSysMain.actUpdateCompanyIdExecute(Sender: TObject);
begin
  inherited;
  if not AccsDataModule.UpdateCompanyId(teCompanyId.Text) then
     MessageDlg('Failed to update company details.' + cCRLFx2 +
                'For help with this problem please contact Kingswood support (01) 4599491/info@kingswood.ie.',mtError,[mbOK],0)
  else
     begin
        teCompanyId.Text := '';
        MessageDlg('Update successful.',mtInformation,[mbOK],0);
     end;
end;

procedure TfmSysMain.LoadJobCardSyncInfo;
var
  i : Integer;
  EnterpriseAccount : TEnterpriseAccount;
begin
  inherited;
  with JobCardActiveEntGridTableView.DataController do
     begin
        RecordCount := 0;
        for i := 0 to AccsDataModule.Accounts.EnterpriseAccounts.Count-1 do
           begin
              EnterpriseAccount := AccsDataModule.Accounts.EnterpriseAccounts[i];

              if (Length(Trim(EnterpriseAccount.Name))=0) then continue;

              RecordCount := RecordCount+1;

              Values[RecordCount-1, JobCardActiveEntGridTableViewId.Index] :=
                 EnterpriseAccount.Id;
              Values[RecordCount-1, JobCardActiveEntGridTableViewEnterpriseName.Index] :=
                 EnterpriseAccount.Name;
              Values[RecordCount-1, JobCardActiveEntGridTableViewUse.Index] :=
                 EnterpriseAccount.JobCardEnabled;
           end;
     end;
end;

procedure TfmSysMain.JobCardActiveEntGridTableViewUsePropertiesEditValueChanged(
  Sender: TObject);
var
  EnterpriseAccount : TEnterpriseAccount;
  Id : Variant;
begin
   inherited;
   if (JobCardActiveEntGridTableView.DataController.FocusedRecordIndex<0) then Exit;

   Id := JobCardActiveEntGridTableView.DataController.Values[
                 JobCardActiveEntGridTableView.DataController.FocusedRecordIndex, JobCardActiveEntGridTableViewId.Index];
   if (VarIsNullOrEmpty(Id)) then Exit;

   EnterpriseAccount := AccsDataModule.Accounts.EnterpriseAccounts.GetEnterpriseAccount(Id);
   if (EnterpriseAccount = nil) then Exit;

   EnterpriseAccount.JobCardEnabled := JobCardActiveEntGridTableView.DataController.Values[
                 JobCardActiveEntGridTableView.DataController.FocusedRecordIndex, JobCardActiveEntGridTableViewUse.Index];

    if AccsDataModule.Accounts.EnterpriseAccounts.Update(EnterpriseAccount) then
       uAccsSync.ResetSyncFlags(false, AccsDataModule.CurrentDatabase)
    else
       MessageDlg('Update failed',mtError,[mbOK],0);
end;

procedure TfmSysMain.actFullSyncExecute(Sender: TObject);
begin
  inherited;
   AccsDataModule.JobCardXmlDocument := nil;

   // -jsfs - JobCard Full Sync, retrieve's all job cards created within past 3 months of today
   uAccsSync.InvokeFarmSyncProgram(Handle,'-s -a "'+ AccsDataModule.CurrentDatabase +'" -jcfs -aod -es -jcrpt -prorpt');
end;

procedure TfmSysMain.PaymentVatCBPropertiesChange(Sender: TObject);
begin
   inherited;
   if ( FFormShowing ) then
      DataChanged := true;
   rgSalesOrPurchOrBothVat.Visible := PaymentVatCB.Checked;
end;

procedure TfmSysMain.FormDestroy(Sender: TObject);
begin
   inherited;
   if ( FDefaultHintDelay > 0 ) then
      Application.HintHidePause := FDefaultHintDelay;
end;

procedure TfmSysMain.actEmailSettingsExecute(Sender: TObject);
begin
  inherited;
  AccsDataModule.EditMailboxSettings;
end;

procedure TfmSysMain.actEmailTemplatesExecute(Sender: TObject);
begin
  inherited;
  TfmEmailTemplates.ShowTheForm(TEditing);
end;

procedure TfmSysMain.cbDownloadJobCardOncePerSessionPropertiesChange(
  Sender: TObject);
begin
  inherited;
  AccsDataModule.JobCardDownloadCount := 0;
end;

procedure TfmSysMain.actEnterKingswoodMTDClientCodeExecute(
  Sender: TObject);
var
  Value: string;
begin
  inherited;
  if (Length(AccsDataModule.APISecret)>0) or
     (AccsSystem.Region<>'UK') then Exit;

  if not InputQuery('Code supplied by Kingswood', 'Client Code:', Value) then Exit;

  Value := Trim(Value);
  if (Length(Value)=0) then Exit;

  // Sample: 51C0567DFA664D36BD1642AE00F8FFA1
  if ClientSecretIsValid(Value) then
     begin
        AccsDataModule.APISecret := Value;
        actEnterKingswoodMTDClientCode.Visible := False;
        lMTDCodeEntered.Visible := True;
        MessageDlg('Code successfully saved.',mtInformation,[mbOK],0);
     end
  else
     MessageDlg('The value entered is not expected format.',mtWarning,[mbOK],0);
end;

procedure TfmSysMain.actMTDUsernameAndPasswordExecute(Sender: TObject);
begin
   //   14/10/20 [V4.5 R4.3] /MK Change - Changed prompt, validate and store of Username and Password to new AccsUtils function.
   if AccsDataModule.PromptAndValidateMTDCredentials() then
      MessageDlg('Login credentials successfully stored.',mtInformation,[mbok],0)
   else
      MessageDlg('An error occurred while storing information.',mtError,[mbOK],0);
end;

end.
