program Winaccs;

{%File 'ChangeLog.txt'}

uses
  Windows,
  Forms,
  Classes,
  Dialogs,
  registry,
  Sysutils,
  cxFormats,
  Calcs in 'CALCS.PAS',
  Clears in 'CLEARS.PAS',
  Util in 'DBASE.PAS',
  DefSecFl in 'DEFSECFL.PAS',
  DbCore in 'DBCORE.PAS',
  DbGen in 'DBGEN.PAS',
  Filed in 'FILED.PAS',
  Vars in 'VARS.PAS',
  Types in 'TYPES.PAS',
  Params in 'PARAMS.PAS',
  AbortPrg in 'AbortPrg.pas',
  Openfl in 'OPENFL.PAS',
  Sprepa in 'SPREPA.PAS',
  Init in 'INIT.PAS',
  DBRPT in 'DBRPT.PAS',
  Chkcomp in 'CHKCOMP.PAS' {FCheckName},
  Cashbook in 'CASHBOOK.PAS' {CashBookForm},
  TxWrite in 'TXWRITE.PAS',
  NomReps in 'NomReps.pas',
  Nsrep11 in 'NSREP11.PAS',
  Nsprint in 'NSPRINT.PAS',
  uprintout in 'uprintout.pas',
  Vat in 'VAT.PAS' {FVat},
  Backgnd in 'BACKGND.PAS' {BackGndForm},
  Jour in 'JOUR.PAS' {Journals},
  Jnltype in 'JNLTYPE.PAS' {FJnlType},
  Entreps in 'ENTREPS.PAS' {EntCostPerUnit},
  Rcslist in 'RCSLIST.PAS' {CustSuppListing},
  sortit in 'sortit.pas',
  Nomrpt in 'NOMRPT.PAS' {NominalReportForm},
  Totaltx in 'TOTALTX.PAS',
  Casha in 'CASHA.PAS',
  Rcsinv in 'RCSINV.PAS' {CustSuppInvListing},
  Cashflow in 'CASHFLOW.PAS' {CashFlowReportsForm},
  Audit in 'AUDIT.PAS',
  Bankrec in 'BANKREC.PAS' {BankRecForm},
  STMREP in 'STMREP.PAS',
  Bankact in 'BANKACT.PAS' {BankActivities},
  Othform in 'OTHFORM.PAS' {OthersForm},
  Newclass in 'NEWCLASS.PAS',
  Stat in 'STAT.PAS' {StatementForm},
  Printset in 'PRINTSET.PAS' {PrintForm},
  Addrec in 'ADDREC.PAS' {AddRecForm},
  Calcamt in 'CALCAMT.PAS' {calcamtForm},
  YearArch in 'yeararch.pas',
  Uyearend in 'Uyearend.pas' {YearEndForm},
  Umonth in 'Umonth.pas' {MonthEndForm},
  PYEnd in 'PYEnd.pas',
  CleartxUnit in 'CleartxUnit.pas' {CleartxForm},
  AccsData in 'AccsData.pas' {AccsDataModule: TDataModule},
  NewRepUnit in 'NewRepUnit.pas' {NewRepForm},
  uSuppDownload in 'uSuppDownload.pas' {fSuppDownload},
  uSetUpProducts in 'uSetUpProducts.pas' {fSetUpProducts},
  reports in 'reports.pas' {Report: TQuickRep},
  reportdefs in 'reportdefs.pas',
  InvoiceReport in 'InvoiceReport.pas' {InvoiceReportForm: TQuickRep},
  Documentation in 'Documentation.pas',
  InvoicePrint in 'InvoicePrint.pas' {InvoicePrintForm},
  InvoiceLayout in 'InvoiceLayout.pas' {InvoiceLayoutForm},
  startparameters in 'startup_parameters.pas',
  FullAudit in 'FullAudit.pas' {AuditFiles},
  uStatementSetup in 'uStatementSetup.pas' {FormStatementSetup},
  uBackup in 'uBackup.pas' {BackupForm},
  uAllocateBudgets in 'uAllocateBudgets.pas' {fallocatebudgets},
  ULoadJobs in 'ULoadJobs.pas' {FLoadJobs},
  DataExport in 'DataExport.pas',
  JobCardReports in 'JobCardReports.pas' {JobCardReportForm},
  BudgetReportForm in 'BudgetReportForm.pas' {BudgetReport: TQuickRep},
  SetupBudgetReports in 'SetupBudgetReports.pas' {SetupBudgetReportsForm},
  CalculateMonths in 'CalculateMonths.pas',
  ThisYearReport in 'ThisYearReport.pas' {ThisYearReportForm: TQuickRep},
  SequenceNumbers in 'SequenceNumbers.pas' {SequenceNumbersForm},
  AnalysisReports in 'AnalysisReports.pas' {AnalysisReport: TQuickRep},
  uSetupAnalysis in 'uSetupAnalysis.pas' {SetupAnalysisForm},
  ChequeJournal in 'ChequeJournal.pas' {ChequeJournalForm},
  ParadoxNotes in 'ParadoxNotes.pas',
  Dataconvert in 'Dataconvert.pas',
  SystemDefinition in 'SystemDefinition.pas' {SystemDefinitionForm},
  password in 'password.pas' {PasswordForm},
  uKingsCC in 'uKingsCC.pas',
  uRegisterForm in 'uRegisterForm.pas' {RegistrationForm},
  NewListing in 'NewListing.PAS' {NewListBox},
  MAINUNIT in 'MAINUNIT.PAS' {FMainScreen},
  csvexport in 'csvexport.pas' {CSVExportForm},
  uvatreps in 'uvatreps.pas',
  uVATAuditTrailReport in 'uVATAuditTrailReport.pas' {QuickRep1: TQuickRep},
  uVatAuditReport in 'uVatAuditReport.pas' {VatAuditReport: TQuickRep},
  uVatReport in 'uVatReport.pas' {VatReport: TQuickRep},
  uNIVatReport in 'uNIVatReport.pas' {NIVatReport: TQuickRep},
  ToDoList in 'ToDoList.pas',
  uSupplierDownload in 'uSupplierDownload.pas' {fmSupplierDownload},
  uCoOpSelect in 'uCoOpSelect.pas' {fmCoOpSelect},
  uSupplierDownloadDateWarning in 'uSupplierDownloadDateWarning.pas' {fmSupplierDownloadDateWarning},
  uChequeJournal in 'uChequeJournal.pas' {fmChequeJournal},
  uSysMain in 'uSysMain.pas' {fmSysMain},
  uPreferences in 'uPreferences.pas',
  uPreferenceConsts in 'uPreferenceConsts.pas',
  uBudgets in 'uBudgets.pas' {fmBudgets},
  uSetup in 'uSetup.pas' {fmAccountSetup},
  AccsUtils in 'AccsUtils.pas',
  Setup in 'SETUP.PAS' {SetUpAccounts},
  AccsResources in 'AccsResources.pas',
  UAgeOfDebtReport in 'UAgeOfDebtReport.pas' {u: TQuickRep},
  uLedgerReport in 'uLedgerReport.pas' {LedgerReport: TQuickRep},
  uSetupWizard in 'uSetupWizard.pas' {fmSetupWizard},
  uAccounts in 'uAccounts.pas',
  uBudgetTypes in 'uBudgetTypes.pas',
  uBaseForm in 'uBaseForm.pas' {BaseForm},
  uReportBaseForm in 'uReportBaseForm.pas' {fmReportBaseForm},
  uBudgetReport in 'uBudgetReport.pas' {fmBudgetReport},
  uAccsSystem in 'uAccsSystem.pas',
  uEnterpriseAnalysisThisYearVsLast in 'uEnterpriseAnalysisThisYearVsLast.pas' {EnterpriseAnalysisThisYearVsLast: TQuickRep},
  uCustSuppListing in 'uCustSuppListing.pas' {CustSuppListingReport: TQuickRep},
  uEnterpriseAnalysisByChart in 'uEnterpriseAnalysisByChart.pas' {fmEnterpriseAnalysisByChart},
  uEnterpriseLineSeriesData in 'uEnterpriseLineSeriesData.pas',
  uReports in 'uReports.pas' {fmReports},
  uReportMenu in 'uReportMenu.pas',
  uBankCSVConfig in 'uBankCSVConfig.pas' {BankCSVConfigForm},
  uBankFileSelector in 'uBankFileSelector.pas' {fmBankFileSelector},
  uBankFileSelectorSettings in 'uBankFileSelectorSettings.pas' {fmBankFileSelectorSettings},
  uBankFileFormatSelector in 'uBankFileFormatSelector.pas' {fmBankFileFormatSelector},
  Global in 'Global.pas',
  uBankImport in 'uBankImport.pas' {fmBankImport},
  uPreferencesStore in 'uPreferencesStore.pas',
  uTrialBalanceReport in 'uTrialBalanceReport.pas' {TrialBalanceReport: TQuickRep},
  uKingswoodAccountantController in 'uKingswoodAccountantController.pas',
  uAccountantDownloadHelper in 'uAccountantDownloadHelper.pas',
  uAccountantLink in 'uAccountantLink.pas' {fmAccountantLink},
  uAccsSettings in 'uAccsSettings.pas',
  uTransactionQuantityInput in 'uTransactionQuantityInput.pas' {fmTransactionQuantityInput},
  uQuantityInput in 'uQuantityInput.pas',
  uFarmGateWrapper in 'uFarmGateWrapper.pas',
  uTransactionNominalFreeTextDescriptionInput in 'uTransactionNominalFreeTextDescriptionInput.pas' {fmTransactionNominalFreeTextDescriptionInput},
  CostPerUnit in 'CostPerUnit.pas' {CostPerUnitReport: TQuickRep},
  CostPerUnitSummary in 'CostPerUnitSummary.pas' {CostPerUnitSummaryReport: TQuickRep},
  uEnterpriseSetup in 'uEnterpriseSetup.pas' {EnterpriseSetup},
  uBankMultiLineTransEdit in 'uBankMultiLineTransEdit.pas' {BankMultiLineTransEditForm},
  uParser in 'uParser.pas',
  uAccsMessages in 'uAccsMessages.pas',
  uAccsSync in 'uAccsSync.pas',
  uFarmSyncSettings in 'uFarmSyncSettings.pas',
  JobCardViewer in 'JobCardViewer.pas' {JobCardViewerForm},
  uJobCardCustomerListing in 'uJobCardCustomerListing.pas' {fmJobCardCustomerListing},
  uProductListing in 'uProductListing.pas' {ProductListingForm},
  JobCardReportSetup in 'JobCardReportSetup.pas' {JobCardReportSetupForm},
  uAccountsHelp in 'uAccountsHelp.pas',
  QRExportHelper in '..\..\..\Common\QRExportHelper.pas',
  Def in '..\..\..\Common\Def.pas',
  uIntList in '..\..\..\Common\uIntList.pas',
  uConnect in '..\..\..\Common\uConnect.pas' {fmDialupConnect},
  ChkDebug in '..\..\..\Common\ChkDebug.pas',
  cxUtils in '..\..\..\Common\cxUtils.pas',
  DCPCryptManagement in '..\..\..\Common\DCPCryptManagement.pas',
  uOnlineBackupHelper in '..\..\..\Common\uOnlineBackupHelper.pas',
  uDataBackup in 'uDataBackup.pas' {fmDataBackup},
  uBackupDevice in '..\..\..\Common\uBackupDevice.pas' {BackupDevice},
  uDownloadValidation in '..\..\..\Common\uDownloadValidation.pas',
  UserMsgConst in '..\..\..\Common\UserMsgConst.pas',
  uDataRestoreConfirm in '..\..\..\Common\uDataRestoreConfirm.pas' {fmDataRestoreConfirm},
  uKingswoodAccessControllerBase in '..\..\..\Common\uKingswoodAccessControllerBase.pas',
  uFileEncrypt in '..\..\..\Common\uFileEncrypt.pas',
  Drawing in '..\..\..\Common\Drawing.pas',
  UYearEndTransWarning in 'UYearEndTransWarning.pas' {FYearEndTransWarning},
  uPaymentVAT in 'uPaymentVAT.pas',
  MSXML2_TLB in 'MSXML2_TLB.pas',
  XMLExport in 'XMLExport.pas',
  uFarmGateEditForm in 'uFarmGateEditForm.pas' {fmFarmGateEditForm},
  uKingswoodAppInfo in 'uKingswoodAppInfo.pas' {fmKingswoodAppInfo},
  uMailboxHelper in 'uMailboxHelper.pas',
  uEmailTemplates in 'uEmailTemplates.pas' {fmEmailTemplates},
  LangUnit in 'Lang\Language\langunit.pas',
  uEmailEntityInfo in 'uEmailEntityInfo.pas',
  uPaymentVATReport in 'uPaymentVATReport.pas' {PaymentVATReport: TQuickRep},
  uEmailAttachments in 'uEmailAttachments.pas' {fmEmailAttachments},
  UNominalSetUp in 'UNominalSetUp.pas',
  uBankAuditTrailReport in 'uBankAuditTrailReport.pas' {BankAuditTrialReport: TQuickRep},
  uEditAssocItem in 'uEditAssocItem.pas' {fmEditAssocItem},
  uDefImgStore in '..\..\..\Common\uDefImgStore.pas' {fmDefImgStore},
  uAccsNewFeatures in 'uAccsNewFeatures.pas' {fmAccsNewFeatures},
  uVATSubmissionReportForm in 'uVATSubmissionReportForm.pas' {VATSubmissionReportForm},
  UVATSetup in 'UVATSetup.pas' {VATSetupForm},
  uDigitalVATForm in 'uDigitalVATForm.pas' {DigitalVATForm},
  DigitalVAT in 'DigitalVAT.pas',
  MD5 in 'MD5.pas',
  MD5Convert in 'MD5Convert.pas',
  uAccsTransaction in 'uAccsTransaction.pas',
  uSimpleSaleInvoiceFrame in 'uSimpleSaleInvoiceFrame.pas' {SimpleSaleInvoiceFrame: TFrame},
  uSimplePurchaseInvoiceFrame in 'uSimplePurchaseInvoiceFrame.pas' {SimplePurchaseInvoiceFrame: TFrame},
  SimpleAccsDataModule in 'SimpleAccsDataModule.pas' {SimpleAccsData: TDataModule},
  uSimpleInvoiceBaseFrame in 'uSimpleInvoiceBaseFrame.pas' {SimpleInvoiceBaseFrame: TFrame},
  ABChangeRegister in 'ABChangeRegister.pas',
  ProgramUpdateThread in '..\..\..\Common\ProgramUpdateThread.pas',
  ProgramMaintenanceCheckThread in '..\..\..\Common\ProgramMaintenanceCheckThread.pas',
  uMTDApi in 'uMTDApi.pas',
  JSON in 'JSON.pas',
  LoginCredentials in 'LoginCredentials.pas',
  uLoginCredentials in 'uLoginCredentials.pas' {fmLoginCredentials},
  HTTP in 'HTTP.pas',
  CredentialsStore in 'CredentialsStore.pas',
  uRestoreToNewCompanyName in 'uRestoreToNewCompanyName.pas' {fmRestoreToNewCompanyName},
  uBankLinkNoFileFound in 'uBankLinkNoFileFound.pas' {fmBankLinkNoFileFound},
  uReviewFarmFinances in 'uReviewFarmFinances.pas' {fmReviewFarmFinances},
  Win7 in '..\..\..\Common\Win7.pas',
  uWinOS in '..\..\..\Common\uWinOS.pas',
  uCallToExternalProgram in '..\..\..\Common\uCallToExternalProgram.pas',
  KRoutines in '..\..\..\..\Common\KRoutines.pas',
  uApplicationLog in 'uApplicationLog.pas';

// TGM AB 04/06/15

{$R *.RES}
{ 08/03/12 [V5.0 R4.1] - Program Is Now Dependent On qrpdflib.dll. }
{$R qrpdflib.RES}
{$R dataconvert.RES}
{$R Winaccs.REC}
{$R openssl.RES}


var
   TheRegistry : TRegistry;
   i : Integer;
   StartupParams : TStringList;
   NoOfParams : Integer;
   //MTDApi: TMTDApi;
   //MTDCredentials: TLoginCredentials;
begin
   NoOfParams := ParamCount();
   if (NoOfParams <= 1) then
      begin
         {Attempt to create a named mutex}
         CreateMutex(nil, false, 'Kingswood Accounts Version 4');
         {if it failed then there is another instance}
         if ( GetLastError = ERROR_ALREADY_EXISTS ) then
            begin
               {Send all windows our custom message - only our other}
               {instance will recognise it, and restore itself}
               SendMessage(HWND_BROADCAST,RegisterWindowMessage('Kingswood Accounts Version 4'),0,0);
               {Lets quit}
               Halt(0);
            end;
      end;

   Application.Initialize;
   //shortdateformat :=  'dd/mm/yy';
  {MTDCredentials := TLoginCredentials.create('','');
  MTDApi := TMTDApi.create(MTDCredentials);
  MTDApi.GetReceipt('D3E7C10F-63F2-4891-AA42-2A98562DC6EC');
  Exit;}
  
   DateSeparator := '/';
   ShortDateFormat := 'dd/MM/yy';
   LongDateFormat := 'dd MMMM yyyy';
   //CurrencyString := '€';
   cxFormatController.BeginUpdate;
   cxFormatController.UseDelphiDateTimeFormats := True;
   // change other settings of the cxFormatController...
   cxFormatController.EndUpdate;
   cxFormatController.GetFormats;
   cxFormatController.NotifyListeners;

   ShowWindow(Application.Handle, SW_RESTORE);

   Application.Title := 'Kingswood Accounts';
   Application.HelpFile := 'AccountsHelp.chm';
   ExtractResourceFiles;

   if ((ParamCount() > 1) and ((ParamStr(1) = '-o') or (ParamStr(1) = '-i'))) then
      begin
         // {-o = output data for sync purposes
         StartupParams := TStringList.Create();
         for i := 0 to ParamCount do
            StartupParams.Add(ParamStr(i));

         try
            //CreateLogEntry('Startup params initialised','C:\Kingsacc\Services\log.txt');
            Application.CreateForm(TAccsDataModule, AccsDataModule);
  Application.CreateForm(TFCheckName, FCheckName);
  Application.CreateForm(TCustSuppListing, CustSuppListing);
  Application.CreateForm(TLedgerReport, LedgerReport);
  Application.CreateForm(TAuditFiles, AuditFiles);
  Application.CreateForm(TPaymentVATReport, PaymentVATReport);
  Application.CreateForm(TBankAuditTrialReport, BankAuditTrialReport);
  AccsDataModule.CreatePreferenceDefaults(ParamStr(2));
            //CreateLogEntry('Pref initialised','C:\Kingsacc\Services\log.txt');
            Sync(StartupParams);
            //CreateLogEntry('Sync completed.','C:\Kingsacc\Services\log.txt');
         finally
            FreeAndNil(CustSuppListing);
            FreeAndNil(FCheckName);
            FreeAndNil(LedgerReport);
            FreeAndNil(AccsDataModule);
            FreeAndNil(AuditFiles);
         end;
      end
   else if ( paramcount > 0 ) then
      begin
         // TGM AB 12/03/02 The forms created below are the essentical ones required to start the accounts
         Application.CreateForm(TAccsDataModule, AccsDataModule);
         Application.CreateForm(TSimpleAccsData, SimpleAccsData);
         Application.CreateForm(TBackGndForm, BackGndForm);
         Application.CreateForm(TFCheckName, FCheckName);
         Application.CreateForm(TAuditFiles, AuditFiles);
         Application.CreateForm(TNewListBox, NewListBox);
         Application.CreateForm(TCustSuppListing, CustSuppListing);
         Application.CreateForm(TCustSuppInvListing, CustSuppInvListing);
         Application.CreateForm(TAddRecForm, AddRecForm);
         Application.CreateForm(TcalcamtForm, calcamtForm);
         Application.CreateForm(TCleartxForm, CleartxForm);
         Application.CreateForm(TFormStatementSetup, FormStatementSetup);
         Application.CreateForm(TBackupForm, BackupForm);
         Application.CreateForm(Tfallocatebudgets, fallocatebudgets);
         Application.CreateForm(TFLoadJobs, FLoadJobs);
         Application.CreateForm(TJobCardReportForm, JobCardReportForm);
         Application.CreateForm(TSetupBudgetReportsForm, SetupBudgetReportsForm);
         Application.CreateForm(TRegistrationForm, RegistrationForm);
         Application.CreateForm(TFMainScreen, FMainScreen);
         Application.CreateForm(TCSVExportForm, CSVExportForm);
         Application.CreateForm(TQuickRep1, QuickRep1);
         Application.CreateForm(TVatReport, VatReport);
         Application.CreateForm(TNIVatReport, NIVatReport);
         Application.CreateForm(TLedgerReport, LedgerReport);
         startparameters.checkparams;
         FCheckName.CheckForNewFields;
         if ( param_type = 'NL' ) then
            begin
               // next 2 lines avoid having to sohw the mainscreen
               FMainscreen.FormShow(FMainscreen);
               FMainscreen.FormActivate(FMainscreen);
               Dataexport.ProcessNLFile(nil);
               Dataexport.ProcessGroups;
               application.terminate;
            end;
         if ( param_type = 'SL' ) then
            begin
               FMainscreen.FormShow(FMainscreen);        // next 2 lines avoid having to sohw the mainscreen
               FMainscreen.FormActivate(FMainscreen);
               Dataexport.ProcessSLFile(nil);
               application.terminate;
            end;
         // Sale
         if ( param_type = 'S' ) then
            begin
               BackGndForm.visible := true;
               application.processmessages;
               Application.CreateForm(TfSetUpProducts, fSetUpProducts);
               Application.CreateForm(TReport, Report);
               Application.CreateForm(TInvoiceReportForm, InvoiceReportForm);
               Application.CreateForm(TInvoicePrintForm, InvoicePrintForm);
               Application.CreateForm(TFMainScreen, FMainScreen);
               Application.CreateForm(TFVat, FVat);
               Application.CreateForm(TJournals, Journals);
               Application.CreateForm(TFJnlType, FJnlType);
               Application.CreateForm(TNominalReportForm, NominalReportForm);
               Application.CreateForm(TOthersForm, OthersForm);
               Application.CreateForm(TStatementForm, StatementForm);
               Application.CreateForm(TCashFlowReportsForm, CashFlowReportsForm);
               Application.CreateForm(TPrintForm, PrintForm);
               Application.CreateForm(TYearEndForm, YearEndForm);
               Application.CreateForm(TMonthEndForm, MonthEndForm);
               Application.CreateForm(TNewRepForm, NewRepForm);
               Application.CreateForm(TEntCostPerUnit, EntCostPerUnit);
               FMainscreen.FormShow(FMainscreen);        // next 2 lines avoid having to sohw the mainscreen
               FMainscreen.FormActivate(FMainscreen);
               if ( Cash1.XCASHBOOK ) then
                  begin
                     TheRegistry:=Tregistry.Create;
                     TheRegistry.OpenKey('Software\Kingswood\Kingsacc\SimpleLayout', True);
                     if ( TheRegistry.ReadString('SimpleLayout') = 'True' ) then
                        FMainscreen.ShowModal
                     else
                        FMainScreen.actCashbook.Execute;
                     TheRegistry.Free;
                     Application.processmessages;
                     FCheckname.free;
                  end
               else
                  begin
                     FMainScreen.actSales.Execute;
                     FCheckname.free;
                  end;
            end;
         // purchase
         if ( param_type = 'P' ) then
            begin
               BackGndForm.visible := true;
               application.processmessages;
               Application.CreateForm(TfSetUpProducts, fSetUpProducts);
               Application.CreateForm(TReport, Report);
               Application.CreateForm(TInvoiceReportForm, InvoiceReportForm);
               Application.CreateForm(TInvoicePrintForm, InvoicePrintForm);
               Application.CreateForm(TFMainScreen, FMainScreen);
               Application.CreateForm(TFVat, FVat);
               Application.CreateForm(TJournals, Journals);
               Application.CreateForm(TFJnlType, FJnlType);
               Application.CreateForm(TNominalReportForm, NominalReportForm);
               Application.CreateForm(TOthersForm, OthersForm);
               Application.CreateForm(TStatementForm, StatementForm);
               Application.CreateForm(TCashFlowReportsForm, CashFlowReportsForm);
               Application.CreateForm(TPrintForm, PrintForm);
               Application.CreateForm(TYearEndForm, YearEndForm);
               Application.CreateForm(TMonthEndForm, MonthEndForm);
               Application.CreateForm(TNewRepForm, NewRepForm);
               Application.CreateForm(TEntCostPerUnit, EntCostPerUnit);
               // next 2 lines avoid having to sohw the mainscreen
               FMainscreen.FormShow(FMainscreen);
               FMainscreen.FormActivate(FMainscreen);
               if Cash1.XCASHBOOK then
                  begin
                     TheRegistry:=Tregistry.Create;
                     TheRegistry.OpenKey('Software\Kingswood\Kingsacc\SimpleLayout', True);
                     if ( TheRegistry.ReadString('SimpleLayout') = 'True' ) then
                        FMainscreen.ShowModal
                     else
                        FMainScreen.actCashbook.Execute;
                     TheRegistry.Free;
                     Application.processmessages;
                     FCheckname.free;
                  end
               else
                  begin
                     FMainScreen.actPurchase.Execute;
                     FCheckname.free;
                  end;
            end;
         if ( param_type = 'M' ) then
            begin
               // creats the remaining forms
               BackGndForm.visible := true;
               application.processmessages;
               Application.CreateForm(TfSetUpProducts, fSetUpProducts);
               Application.CreateForm(TReport, Report);
               Application.CreateForm(TInvoiceReportForm, InvoiceReportForm);
               Application.CreateForm(TInvoicePrintForm, InvoicePrintForm);
               Application.CreateForm(TFMainScreen, FMainScreen);
               Application.CreateForm(TFVat, FVat);
               Application.CreateForm(TJournals, Journals);
               Application.CreateForm(TFJnlType, FJnlType);
               Application.CreateForm(TNominalReportForm, NominalReportForm);
               Application.CreateForm(TOthersForm, OthersForm);
               Application.CreateForm(TStatementForm, StatementForm);
               Application.CreateForm(TCashFlowReportsForm, CashFlowReportsForm);
               Application.CreateForm(TPrintForm, PrintForm);
               Application.CreateForm(TYearEndForm, YearEndForm);
               Application.CreateForm(TMonthEndForm, MonthEndForm);
               Application.CreateForm(TNewRepForm, NewRepForm);
               Application.CreateForm(TEntCostPerUnit, EntCostPerUnit);
               // shows mainscreen modal
               FMainscreen.Showmodal;
               FCheckname.free;
            end;
         if ( param_type = 'R' ) then
            begin
               // creats the remaining forms
               BackGndForm.visible := true;
               application.processmessages;
               Application.CreateForm(TfSetUpProducts, fSetUpProducts);
               Application.CreateForm(TReport, Report);
               Application.CreateForm(TInvoiceReportForm, InvoiceReportForm);
               Application.CreateForm(TInvoicePrintForm, InvoicePrintForm);
               Application.CreateForm(TFMainScreen, FMainScreen);
               Application.CreateForm(TFVat, FVat);
               Application.CreateForm(TJournals, Journals);
               Application.CreateForm(TFJnlType, FJnlType);
               Application.CreateForm(TNominalReportForm, NominalReportForm);
               Application.CreateForm(TOthersForm, OthersForm);
               Application.CreateForm(TStatementForm, StatementForm);
               Application.CreateForm(TCashFlowReportsForm, CashFlowReportsForm);
               Application.CreateForm(TPrintForm, PrintForm);
               Application.CreateForm(TYearEndForm, YearEndForm);
               Application.CreateForm(TMonthEndForm, MonthEndForm);
               Application.CreateForm(TNewRepForm, NewRepForm);
               Application.CreateForm(TEntCostPerUnit, EntCostPerUnit);
               Application.CreateForm(TVatAuditReport, VatAuditReport);
               FMainscreen.OnShow(FMainscreen);
               FMainscreen.OnActivate(FMainscreen);
               // shows the report form modal
               Newrepform.showmodal;
               FCheckname.free;
            end;
         if ( param_type = 'C' ) then
            begin
               // creats the remaining forms
               BackGndForm.visible := true;
               application.processmessages;
               Application.CreateForm(TfSetUpProducts, fSetUpProducts);
               Application.CreateForm(TReport, Report);
               Application.CreateForm(TInvoiceReportForm, InvoiceReportForm);
               Application.CreateForm(TInvoicePrintForm, InvoicePrintForm);
               FCheckName.Show;
               FCheckName.Update;
               Application.CreateForm(TFMainScreen, FMainScreen);
               Application.CreateForm(TFVat, FVat);
               Application.CreateForm(TJournals, Journals);
               Application.CreateForm(TFJnlType, FJnlType);
               Application.CreateForm(TNominalReportForm, NominalReportForm);
               Application.CreateForm(TOthersForm, OthersForm);
               Application.CreateForm(TStatementForm, StatementForm);
               Application.CreateForm(TCashFlowReportsForm, CashFlowReportsForm);
               Application.CreateForm(TPrintForm, PrintForm);
               Application.CreateForm(TYearEndForm, YearEndForm);
               Application.CreateForm(TMonthEndForm, MonthEndForm);
               Application.CreateForm(TNewRepForm, NewRepForm);
               Application.CreateForm(TEntCostPerUnit, EntCostPerUnit);
            end;
        application.run;
      end
      // End TGM AB
   else
      begin
         Application.CreateForm(TAccsDataModule, AccsDataModule);
         Application.CreateForm(TSimpleAccsData, SimpleAccsData);
         Application.CreateForm(TBackGndForm, BackGndForm);
         BackGndForm.visible := true;
         application.processmessages;
         Application.CreateForm(TFCheckName, FCheckName);
         Application.CreateForm(TReport, Report);
         Application.CreateForm(TInvoiceReportForm, InvoiceReportForm);
         FCheckName.Show;
         FCheckName.Update;
         Application.CreateForm(TFMainScreen, FMainScreen);
         Application.CreateForm(TNewListBox, NewListBox);
         Application.CreateForm(TfSetUpProducts, fSetUpProducts);
         Application.CreateForm(TFVat, FVat);
         Application.CreateForm(TJournals, Journals);
         Application.CreateForm(TFJnlType, FJnlType);
         Application.CreateForm(TNominalReportForm, NominalReportForm);
         Application.CreateForm(TCustSuppListing, CustSuppListing);
         Application.CreateForm(TCustSuppInvListing, CustSuppInvListing);
         Application.CreateForm(TOthersForm, OthersForm);
         Application.CreateForm(TStatementForm, StatementForm);
         Application.CreateForm(TCashFlowReportsForm, CashFlowReportsForm);
         Application.CreateForm(TPrintForm, PrintForm);
         Application.CreateForm(TAddRecForm, AddRecForm);
         Application.CreateForm(TcalcamtForm, calcamtForm);
         Application.CreateForm(TYearEndForm, YearEndForm);
         Application.CreateForm(TMonthEndForm, MonthEndForm);
         Application.CreateForm(TCleartxForm, CleartxForm);
         Application.CreateForm(TAuditFiles, AuditFiles);
         Application.CreateForm(TNewRepForm, NewRepForm);
         Application.CreateForm(TEntCostPerUnit, EntCostPerUnit);
         Application.CreateForm(TRegistrationForm, RegistrationForm);
         Application.CreateForm(TCSVExportForm, CSVExportForm);
         Application.CreateForm(TLedgerReport, LedgerReport);
         Application.Run;
      end;

end.
