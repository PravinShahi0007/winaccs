{
   12/04/11 [V4.0 R3.3] /MK Additional Feature - Added In Check For CheckNominals On Save of Cashbook Transaction.

   17/01/12 [V4.1 R1.2] /MK Change - TransactionEdit - If IsCashBookTrans Then Load Data To Grid. If Not Show Cashbook Or BankAct Form.

   07/08/14 [V4.1 R7.4] /MK Bug Fix - CheckVATForChanges - Only calculate VAT if CheckIt is True.

   24/11/14 [V4.1 R7.6] /MK Bug Fix - SetupInterface - Check for SLPLDefaults in new uPrefences key not old key.
                            Change - btnCoOpImport/btnCoopImport3OnClick - Changed to bSuppDownloadClick.
                                   - btnCoOpImport - Changed button kind from drop-down to standard.
                                                     Above changes made because payment button added to Co-Op screen to allow customers
                                                     with more than one supplier to enter payment - GL/Martin Murphy(7745) request.

   02/03/16 [V4.1 R1.9] /MK Additional Feature - Incorporated Andrew's (TGM) changes to show the Co-Op comment column.

   02/03/16 [V4.2 R3.5] /MK Additional Feature - LoadTransactionGrid - Show Customer/Supplier info in grid if transaction is Co-Op Payment - James Walsh (7919)

   22/03/17 [V4.2 R7.2] /MK Bug Fix - LoadTransactionGrid - cmboCustomer and cmboSupplier were given the same listing instead of seperate listings - reported by Tom Doran
                                    - SearchGrid - Along with the fix where the cmboCustomers only contains Customers and cmboSuppliers only contains Suppliers
                                                   this new set of code will assign the type of transactions that are associated to whatever cmbo is being searched on.

   25/10/17 [V4.2 R8.9] /MK Bug Fix - FormKeyDown - If pressing tab in last column program was trying to setfocus on btnAddAnotherLine but this button
                                                    is not showing when editing a transaction. SetFocus on Save button if AddAnotherLine is not showing - Mary Parsons.

   02/11/17 [V4.2 R9.0] /MK Bug Fix - FormClose - Only check for AgeOfDebtSyncRequired if SyncConfigured.

   26/09/18 [V4.3 R1.4] /MK Change - ChangesBeforeRegVerCheck - New procedure that allows checks and actions to be taken before the version in the registry is created/set.
                                   - If the registry version number is less 4314 then turn the SyncInfo promo screen back on (depending on modules and App status).
                                   - UpdateModules - Moved the getting/setting of modules and verno keys in the registry to public properties in AccsData.

   18/10/18 [V4.3 R2.5] /MK Additional Feature - ChangesBeforeRegVerCheck - Run the UpdatePLFigures and UpdateSLFigures procedures to fix any aging issues caused by a bug
                                                                            in the V4.3 R1.4 version (fixed in V4.3 R1.5) so that aging is not replicated in each age field
                                                                            in the Setup screen.

   30/10/18 [V4.3 R2.5] /MK Change - ChangesBeforeRegVerCheck - As the Types.Invoicer is now based on module then remove the invoice file from database to stop previous versions from working.

   15/11/18 [V4.3 R2.7] /MK Additional Feature - FormActivate - Show the New Features screen.

   16/11/18 [V4.3 R2.8] /MK Bug Fix - RowOK - Don't allow a zero nominal code to be saved - Scott Mernagh.

   11/12/18 [V4.3 R3.0] /MK Change - ChangesBeforeRegVerCheck - If the invoice file exists then delete the file and assign the invoicer module if Cash.SerialNo is in new Types.SerialNosWithInvoicerMod string array.

   28/08/19 [V4.5 R0.3] /MK Bug Fix - actSystemExecute - Don't allow open of System screen if data entered into Sale/Purch Invoice grids as Access Violation would appear because grids can be turned on/off in System.
                            Change - SetupInterface - MTD VAT and Year End page now visible for all UK Customers not just Simple Vat users.

   30/08/19 [V4.5 R0.3] /MK Change - Changed caption of actOther to Year End/Other if no Vat Module or Year End/Vat if Vat Module.
                                   - SetupInterface - Reports page only relevant to Irish users that don't have Simple Vat on.
                            Additional Feature - SetupInterface - New reports tab can be available for Ledger NI only or Irish customers with either Simple Vat or Invoicer module.

   02/09/19 [V4.5 R0.3] /MK Change - If Ireland then in VAT/Year End show Summary Vat Report and Detailed Vat Report instead of MTD and Submissions - GL request.

   20/09/19 [V4.5 R0.5] /MK Change - LoadTransaction - Only allow Sales and Purchase invoices to be viewed in new Grids - TGM request.
                            Additional Feature - Added TeamViewer icon to the bottom task bar on the transaction screen which opens TeamViewer like Kingswood Herd/Fields.

   06/11/19 [V4.5 R0.9] /MK Bug Fix - MenuBarExecute - Only give prompt if Sale/Purchase Invoice preference is ticked and tab is SaleInvoice or Purchase Invoice and field in grid is filled - Milo Murphy.

   25/05/20 [V4.5 R2.1] /MK Additional Feature - FormClose - Added prompt for backup where backup date is more than 30 days ago.
                                               - FormActivate - Added check for new version similar to what Kingswood Fields does.
                                                              - Added check if customer is on maintenance.
                                               - UpdateModules - Store new version number and date downloaded in AccsDefaults table.
                                               - ChangesBeforeRegVerCheck - Store the version number in the AccsDefaults table.

   26/05/20 [V4.5 R2.1] /MK Bug Fix - FormCreate - Don't show sync button if not SyncConfigured.

   29/09/20 [V4.5 R3.9] /MK Change - BankFileImportTimerTimer - If the user is not an accountant and their in ROI then, if CSV files don't
                                                                exist in DefaultStatementDirectory then show new TfmBankLinkNoFileFound form.

   06/10/20 [V4.5 R4.2] /MK Change - actMTDVatExecute - MTD users need to enter in their Username and Password before submitting VAT Return.

   14/10/20 [V4.5 R4.3] /MK Change - actMTDVatExecute - After the prompt for Username and Password, store this info so the prompt doesn't keep appearing.

   19/10/20 [V4.5 R4.4] /MK Change - imgTeamViewerClick - If Irish customer then show installed TeamViewer, if UK customer then show TGM TeamViewer URL.

   20/10/20 [V4.5 R4.5] /MK Change - Changed the word log in credentials on the prompt that appears to Username and Password - TGM request. 

   13/11/20 [V4.5 R4.6] /MK Change - FormActivate - Don't show BankLinkTimer anmymore instead show BankLink select file screen and then show AppInfo and NewFeatures screen.
                                   - Bold the company name in the status bar - TGM request.    

   26/11/20 [V4.5 R4.6] /MK Change - ShowBankLink - Only show TfmBankLinkNoFileFound if user hasn't ticked "Don't show this again".

   16/12/20 [V4.5 R4.7] /MK Additional Feature - Added the Bank Audit Trail to the reports page.
                                               - Increased the height of the More Reports hyperlink so that it would stand out.
}

unit Mainunit;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,  printers,
  FileCtrl, Grids, ExtCtrls, ComCtrls, ToolWin, Gauges, Adgrad,Registry,
  Menus, RXCtrls, RxLogin, jpeg, Mask, ToolEdit, dxPSCore, dxPScxCommon,
  dxPScxGridLnk, ActnList, dxBar, dxBarExtItems, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, cxButtons, cxStyles,
  cxcurrencyEdit, cxContainer, cxEdit, cxGroupBox, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox,
  cxLabel, cxButtonEdit, cxCalendar, cxGraphics, cxDataStorage, cxCustomData,
  cxDateNavigator, Db, dxmdaset, cxCheckListBox, cxDBLookupComboBox,
  cxLookAndFeels, dxDockControl, dxDockPanel, dxStatusBar, cxSplitter, cxPC,
  cxHyperLinkEdit, types, cxHint, uAccsMessages, uKingswoodAppInfo,
  uAccsNewFeatures, KRoutines, uSimpleSaleInvoiceFrame,
  uSimplePurchaseInvoiceFrame, uSimpleInvoiceBaseFrame, cxImage,
  uCallToExternalProgram, dxCntner, dxInspct, dxOI, uBankLinkNoFileFound,
  CredentialsStore, LogInCredentials;

const

  LeftPos        = 512;
  TopPos         = 132{128};
  OrigHeight     = 485;
  OrigGridTop    = 194{184};
  cPanel1        = 14;
  cPanel2        = 130;
  cPanel3        = 246;
  cPanel4        = 362;
  cPanel5        = 478;
  cPanel6        = 594;
  cMoveWarning = 'You are about to exit "%s", any changes will be lost!' +cCRLFx2 + 'Are you sure you want to continue?';
  cMoveError = 'Please complete or cancel your "%s" grid transaction before clicking this button.';

type
  TLedgerType = (ltCustomer, ltSupplier);

  TBreakTCXGridSite = Class(TcxGridSite);

  TFMainScreen = class(TForm)
    pMenuButtonPanel: TPanel;
    btnPurchaseGroup: TcxButton;
    btnSalesGroup: TcxButton;
    btnBankActions: TcxButton;
    btnCashbookGroup: TcxButton;
    btnOtherGroup: TcxButton;
    btnCoOpImport: TcxButton;
    pSimpleLayout: TPanel;
    dxBarManager: TdxBarManager;
    blbExit: TdxBarLargeButton;
    blbSetup: TdxBarLargeButton;
    blbReport: TdxBarLargeButton;
    dxBarLargeButton3: TdxBarLargeButton;
    dxBarLargeButton1: TdxBarLargeButton;
    bsFiller: TdxBarStatic;
    bbHelp: TdxBarButton;
    bbSearchTransaction: TdxBarButton;
    bbClearSearch: TdxBarButton;
    bsiFile: TdxBarSubItem;
    bbPrintPreview: TdxBarButton;
    TopToolbarActionList: TActionList;
    actExit: TAction;
    actSetup: TAction;
    actReport: TAction;
    actBackup: TAction;
    actSystem: TAction;
    BottomToolbarActionList: TActionList;
    actHelp: TAction;
    actSearchTransactions: TAction;
    actClearSearch: TAction;
    actPrint: TAction;
    MenuIconsActionList: TActionList;
    actSales: TAction;
    actPurchase: TAction;
    actBank: TAction;
    actOther: TAction;
    actCashbook: TAction;
    actCoOpImport: TAction;
    dxComponentPrinter: TdxComponentPrinter;
    dxTransactionGridPrinterLink: TdxGridReportLink;
    pmCoopImport: TPopupMenu;
    ReadDisk1: TMenuItem;
    EnterPaymentBtn: TMenuItem;
    Timer1: TTimer;
    dxComponentPrinter1: TdxComponentPrinter;
    cxStyleRepository: TcxStyleRepository;
    cxStyleGroupByBox: TcxStyle;
    ProgressPanel: TPanel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    BarStatic1: TdxBarStatic;
    dxTransactionGridPrinter: TdxGridReportLink;
    actSaveCBInput: TAction;
    actCancelCBEInput: TAction;
    actAddAnotherLine: TAction;
    BarControlProgressBar: TdxBarControlContainerItem;
    ProgressBar: TProgressBar;
    dxBarControlContainerItemSearchPanel: TdxBarControlContainerItem;
    cxLookAndFeelController: TcxLookAndFeelController;
    cxStyleRepository1: TcxStyleRepository;
    cxStyleFocused: TcxStyle;
    cxStyleNormal: TcxStyle;
    actSearchGrid: TAction;
    blbHelp: TdxBarLargeButton;
    dxBarLargeButton2: TdxBarLargeButton;
    dxBarLargeButton4: TdxBarLargeButton;
    dxBarLargeButton5: TdxBarLargeButton;
    StatusBar: TdxStatusBar;
    pCBEEntry: TPanel;
    gbCBEHeaderPanel: TcxGroupBox;
    TransTypeLabel: TLabel;
    cxLabel1: TcxLabel;
    cbTransTypeGroup: TcxComboBox;
    cxLabel2: TcxLabel;
    beBankAccount: TcxButtonEdit;
    InputTransGrid: TcxGrid;
    InputTransGridTableView: TcxGridTableView;
    InputTransGridLevel: TcxGridLevel;
    pSimpleLayoutActions: TPanel;
    CBENextLineSepBevel: TBevel;
    btnAddAnotherLine: TcxButton;
    btnSaveCBE: TcxButton;
    btnCancelCBE: TcxButton;
    btnDeleteLine: TcxButton;
    actDeleteLine: TAction;
    cxLabel11: TcxLabel;
    ceBankBalance: TcxCurrencyEdit;
    cxStyleCBEntryHeader: TcxStyle;
    WizardTimer: TTimer;
    actBudgets: TAction;
    blbBudgets: TdxBarLargeButton;
    blbViewManual: TdxBarLargeButton;
    actViewManual: TAction;
    cxStyleCBEntryRow: TcxStyle;
    cxStyleTransGridHeader: TcxStyle;
    cxStyleTransGridRow: TcxStyle;
    dxBarLargeButton6: TdxBarLargeButton;
    actBusinessSummary: TAction;
    blbBusinessSummary: TdxBarLargeButton;
    ViewPageControl: TcxPageControl;
    tsAccountActions: TcxTabSheet;
    tsTransactionGridView: TcxTabSheet;
    pTransactionGrid: TPanel;
    pTransctionGridHeader: TPanel;
    TransactionGrid: TcxGrid;
    TransactionGridTableView: TcxGridTableView;
    TransactionGridLevel: TcxGridLevel;
    tsReports: TcxTabSheet;
    lEditTransactionHelperText: TcxLabel;
    dxBarDockControlTransactionToolbar: TdxBarDockControl;
    bcciTransactionActions: TdxBarControlContainerItem;
    dxBarDockControlSearchToolBar: TdxBarDockControl;
    SearchPanel: TPanel;
    btnSearch: TcxButton;
    btnSearchCancel: TcxButton;
    btnHelp: TcxButton;
    ceSearchTransNo: TcxCurrencyEdit;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    deSearchTransactionFrom: TcxDateEdit;
    deSearchTransactionTo: TcxDateEdit;
    ceVATDiscount: TcxCurrencyEdit;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    teSearchReference: TcxTextEdit;
    teSearchCommentOrStub: TcxTextEdit;
    cxLabel8: TcxLabel;
    ceSearchAmount: TcxCurrencyEdit;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    teSearchDescription: TcxTextEdit;
    lCustomer: TcxLabel;
    lSupplier: TcxLabel;
    cbSearchTransactionTypes: TcxCheckListBox;
    cxLabel13: TcxLabel;
    cmboCustomer: TcxComboBox;
    cmboSupplier: TcxComboBox;
    Panel2: TPanel;
    actNavigateFirst: TAction;
    actNavigatePrevious: TAction;
    actNavigationNext: TAction;
    actNavigateLast: TAction;
    pTransactionActions: TPanel;
    Label1: TLabel;
    lRecNo: TLabel;
    cxButton3: TcxButton;
    cxButton4: TcxButton;
    cxButton5: TcxButton;
    cxButton6: TcxButton;
    pCashBookMenu: TPanel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel6: TBevel;
    lGrassMeasurementDesc: TcxLabel;
    btnBankFileImport: TcxButton;
    lBankStatementImportHeader: TcxLabel;
    cxLabel14: TcxLabel;
    btnOtherBankFacilities: TcxButton;
    lStateHeader: TcxLabel;
    cxLabel16: TcxLabel;
    lbFeedWedgeDesc: TcxLabel;
    lFeedWedgeHeader: TcxLabel;
    cxLabel27: TcxLabel;
    btnSilageHarvesting: TcxButton;
    cxLabel28: TcxLabel;
    btnCoopImport3: TcxButton;
    cxLabel33: TcxLabel;
    btnGrassBudgets: TcxButton;
    cxLabel34: TcxLabel;
    GrassReportsDescriptionLabel: TcxLabel;
    pmBankFileOptions: TPopupMenu;
    mi: TMenuItem;
    TabMenuActions: TActionList;
    actBankFileSelectorSettings: TAction;
    actBankFileImport: TAction;
    cxButton7: TcxButton;
    actEnterNewTransaction: TAction;
    pReports: TPanel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    cxLabel15: TcxLabel;
    cxButton8: TcxButton;
    cxLabel17: TcxLabel;
    cxLabel18: TcxLabel;
    cxButton9: TcxButton;
    lInterYearComparisonHeader: TcxLabel;
    cxButton10: TcxButton;
    lFarmBudgetHeader: TcxLabel;
    cxLabel23: TcxLabel;
    cxButton11: TcxButton;
    lFarmSummaryHeader: TcxLabel;
    cxLabel25: TcxLabel;
    cxButton12: TcxButton;
    lDairyEnterpriseHeader: TcxLabel;
    cxLabel35: TcxLabel;
    cxButton14: TcxButton;
    lTrialBalanceHeader: TcxLabel;
    cxLabel39: TcxLabel;
    btnYearEndOther: TcxButton;
    ReportsActionList: TActionList;
    actProfitAndLossRpt: TAction;
    actInterYearComparisionRpt: TAction;
    actDairyEnterpriseRpt: TAction;
    actTrialBalanceRpt: TAction;
    actFarmSummaryRpt: TAction;
    actFarmBudgetRpt: TAction;
    AccountActionsActionList: TActionList;
    actBankStatementImportAccountAction: TAction;
    actBankFacilitiesAccountAction: TAction;
    actCoOpImportAccountAction: TAction;
    actYearEndOtherAccountAccount: TAction;
    lMoreReports: TcxLabel;
    BankFileImportTimer: TTimer;
    ransactionGridTableViewColumn1: TcxGridColumn;
    blbListings: TdxBarLargeButton;
    pmListings: TdxBarPopupMenu;
    bbNominalAccountListing: TdxBarButton;
    bbEnterpriseListing: TdxBarButton;
    dxBarControlContainerItem1: TdxBarControlContainerItem;
    pClearSearchContainer: TPanel;
    ClearSearchBtn: TRxSpeedButton;
    cxStyleFilterRow: TcxStyle;
    dxBarButton1: TdxBarButton;
    blbSync: TdxBarLargeButton;
    actSync: TAction;
    dxBarLargeButton8: TdxBarLargeButton;
    actNewVersion: TAction;
    tsSalesInvoice: TcxTabSheet;
    tsPurchaseInvoice: TcxTabSheet;
    SimplePurchaseInvoiceFrame: TSimplePurchaseInvoiceFrame;
    SimpleSaleInvoiceFrame: TSimpleSaleInvoiceFrame;
    tsMTDVatYearEnd: TcxTabSheet;
    SimpleVatPanel: TPanel;
    cxLabel12: TcxLabel;
    btnSimpleVatYE: TcxButton;
    lSimpleVatVatYE: TcxLabel;
    lSimpleVatVatInfo: TcxLabel;
    btnSimpleVatVATMTD: TcxButton;
    lSimpleVatVatHead: TcxLabel;
    SepHeadPanel: TPanel;
    bvMTDYEFirstBreak: TBevel;
    bvMTDYESecondBreak: TBevel;
    lMTDSubmissions: TcxLabel;
    lMTDSubmissionsDetail: TcxLabel;
    btnMTDSubmissions: TcxButton;
    lMTDYESendRecAccData: TcxLabel;
    lMTDYESendRecAccDataInfo: TcxLabel;
    btnMTDVATSendRecAccData: TcxButton;
    pmMTDVATYESendRecAccs: TPopupMenu;
    SendDataToAccontant1: TMenuItem;
    ReceiveDataFromAccountant1: TMenuItem;
    tsSimpleVatReports: TcxTabSheet;
    pSimpleVatReports: TPanel;
    bvSimpleVatFirst: TBevel;
    bvSimpleVatSecond: TBevel;
    cxLabel30: TcxLabel;
    btnTransactionReport: TcxButton;
    lTransactionReport: TcxLabel;
    cxLabel32: TcxLabel;
    cxButton17: TcxButton;
    cxLabel36: TcxLabel;
    lNIReportMoreReps: TcxLabel;
    actVatReport: TAction;
    lVatReportHead: TcxLabel;
    lSimpleVatVatRptInfo: TcxLabel;
    btnSimpleVatVatRpt: TcxButton;
    actTransactionReport: TAction;
    actNomAuditTrail: TAction;
    lNomAuditTrailHead: TcxLabel;
    lNomAuditTrailDetail: TcxLabel;
    cxButton2: TcxButton;
    actMTDVat: TAction;
    actStandVatRpt: TAction;
    bvSimpleVatThird: TBevel;
    bvSimpleVatFourth: TBevel;
    lSimpleVatAgeofDebtHead: TcxLabel;
    lSimpleVatAgeofDebtDetail: TcxLabel;
    btnSimpleVatAgeofDebt: TcxButton;
    lSimpleVatProfLossHead: TcxLabel;
    lSimpleVatProfLossDetail: TcxLabel;
    btnSimpleVatProfLoss: TcxButton;
    actAgeOfDebt: TAction;
    pmSimpleVatAgeOfDebt: TPopupMenu;
    pmiCustomerAgeOfDebt: TMenuItem;
    pmiSupplierAgeOfDebt: TMenuItem;
    pTeamViewer: TPanel;
    bccTeamViewer: TdxBarControlContainerItem;
    imgTeamViewer: TcxImage;
    Bevel1: TBevel;
    lBankAuditTrail: TcxLabel;
    lBankAuditTrailDetail: TcxLabel;
    cxButton1: TcxButton;
    actBankAuditTrail: TAction;
    Panel1: TPanel;
    Bevel5: TBevel;
    Bevel9: TBevel;
    Bevel12: TBevel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    cxLabel19: TcxLabel;
    cxButton13: TcxButton;
    cxLabel20: TcxLabel;
    cxLabel21: TcxLabel;
    cxButton15: TcxButton;
    cxLabel22: TcxLabel;
    cxButton16: TcxButton;
    cxLabel24: TcxLabel;
    cxLabel26: TcxLabel;
    cxButton18: TcxButton;
    cxLabel29: TcxLabel;
    cxLabel31: TcxLabel;
    cxButton19: TcxButton;
    cxLabel37: TcxLabel;
    cxLabel38: TcxLabel;
    cxButton20: TcxButton;
    cxLabel40: TcxLabel;
    cxLabel41: TcxLabel;
    cxLabel42: TcxLabel;
    cxLabel43: TcxLabel;
    cxLabel44: TcxLabel;
    cxButton21: TcxButton;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bSuppDownloadClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BankListBtnClick(Sender: TObject);
    procedure BankButton2Click(Sender: TObject);
    procedure OtherButton2Click(Sender: TObject);
    procedure BankAccountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function IsVatCodeInclusive(RowNumber : Integer): Boolean;
    procedure bBudgetsClick(Sender: TObject);
    procedure EnterPaymentBtnClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actClearSearchExecute(Sender: TObject);
    procedure actSearchTransactionsExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actSalesExecute(Sender: TObject);
    procedure actPurchaseExecute(Sender: TObject);
    procedure actBankExecute(Sender: TObject);
    procedure actOtherExecute(Sender: TObject);
    procedure actCashbookExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actSetupExecute(Sender: TObject);
    procedure actReportExecute(Sender: TObject);
    procedure actBackupExecute(Sender: TObject);
    procedure actSystemExecute(Sender: TObject);
    procedure TransactionGridTableViewDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EntButtonEditClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure IncomeExpenseButtonEditClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure CustomerButtonEditClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure SupplierButtonEditClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure QuantityButtonEditClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure InputTransGridExit(Sender: TObject);
    procedure VATCodeButtonEditClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure AnalysisCodeClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure CBGridDateOnInitPopup(Sender: TObject);
    procedure actSaveCBInputExecute(Sender: TObject);
    procedure actCancelCBEInputExecute(Sender: TObject);
    procedure InputTransGridTableViewFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure InputTransGridTableViewCellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure InputTransGridTableViewKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure InputTransGridTableViewMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure InputTransGridTableViewInitEdit(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
    procedure MyInputGridCellDoubleClick(Sender : TObject);
    procedure MyInputGridDateOnCloseUp(Sender : TObject);
    procedure beBankAccountPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure beBankAccountDblClick(Sender: TObject);
    procedure beBankAccountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actAddAnotherLineExecute(Sender: TObject);
    procedure cbTransTypeGroupPropertiesChange(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure actSearchGridExecute(Sender: TObject);
    procedure cmboCustomerPropertiesChange(Sender: TObject);
    procedure cmboSupplierPropertiesChange(Sender: TObject);
    procedure teSearchDescriptionPropertiesChange(Sender: TObject);
    procedure btnSearchCancelClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure InputTransGridTableViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure DoFocusNextItem(var Message:TMessage); message WM_FOCUSNEXTITEM;
    procedure DoLoadTransactionData(var Message:TMessage); message WM_LOADTRANSACTIONDATA;
    procedure actDeleteLineExecute(Sender: TObject);
    procedure actDeleteLineUpdate(Sender: TObject);
    procedure InputTransGridTableViewEditing(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      var AAllow: Boolean);
    procedure btnCoOpImportClick(Sender: TObject);
    procedure beBankAccountPropertiesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WizardTimerTimer(Sender: TObject);
    procedure actBudgetsExecute(Sender: TObject);
    procedure InputTransGridTableViewEditChanged(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
    procedure actViewManualExecute(Sender: TObject);
    procedure dxBarLargeButton6Click(Sender: TObject);
    procedure actBusinessSummaryExecute(Sender: TObject);
    procedure TransactionGridTableViewFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure InputTransGridEnter(Sender: TObject);
    procedure ViewPageControlDrawTabEx(AControl: TcxCustomTabControl;
      ATab: TcxTab; Font: TFont);
    procedure actNavigateFirstExecute(Sender: TObject);
    procedure actNavigateFirstUpdate(Sender: TObject);
    procedure actNavigatePreviousExecute(Sender: TObject);
    procedure actNavigatePreviousUpdate(Sender: TObject);
    procedure actNavigationNextExecute(Sender: TObject);
    procedure actNavigationNextUpdate(Sender: TObject);
    procedure actNavigateLastExecute(Sender: TObject);
    procedure actNavigateLastUpdate(Sender: TObject);
    procedure ViewPageControlPageChanging(Sender: TObject;
      NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure actBankFileSelectorSettingsExecute(Sender: TObject);
    procedure actBankFileImportExecute(Sender: TObject);
    procedure TransactionGridTableViewCanFocusRecord(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      var AAllow: Boolean);
    procedure TransactionGridTableViewCanSelectRecord(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      var AAllow: Boolean);
    procedure InputTransGridTableViewEditValueChanged(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
    procedure actEnterNewTransactionExecute(Sender: TObject);
    procedure InputTransGridTableViewEditKeyUp(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure btnCoopImport3Click(Sender: TObject);
    procedure actProfitAndLossRptExecute(Sender: TObject);
    procedure actInterYearComparisionRptExecute(Sender: TObject);
    procedure actDairyEnterpriseRptExecute(Sender: TObject);
    procedure actFarmSummaryRptExecute(Sender: TObject);
    procedure actFarmBudgetRptExecute(Sender: TObject);
    procedure actTrialBalanceRptExecute(Sender: TObject);
    procedure actBankStatementImportAccountActionExecute(Sender: TObject);
    procedure actCoOpImportAccountActionExecute(Sender: TObject);
    procedure actYearEndOtherAccountAccountExecute(Sender: TObject);
    procedure actBankFacilitiesAccountActionExecute(Sender: TObject);
    procedure lMoreReportsClick(Sender: TObject);
    procedure lMoreReportsMouseEnter(Sender: TObject);
    procedure lMoreReportsMouseLeave(Sender: TObject);
    procedure pReportsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BankFileImportTimerTimer(Sender: TObject);
    procedure ViewPageControlResize(Sender: TObject);
    procedure InputTransGridTableViewEditKeyPress(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Char);
    procedure pSimpleLayoutActionsEnter(Sender: TObject);
    procedure gbCBEHeaderPanelEnter(Sender: TObject);
    procedure pSimpleLayoutActionsMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure pCBEEntryMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TransactionGridMouseLeave(Sender: TObject);
    procedure InputTransGridResize(Sender: TObject);
    procedure bbNominalAccountListingClick(Sender: TObject);
    procedure bbEnterpriseListingClick(Sender: TObject);
    procedure blbListingsClick(Sender: TObject);
    procedure actSyncExecute(Sender: TObject);
    procedure actNewVersionExecute(Sender: TObject);
    procedure tsPurchaseInvoiceShow(Sender: TObject);
    procedure tsSalesInvoiceShow(Sender: TObject);
    procedure btnSimpleVatYEClick(Sender: TObject);
    procedure tsMTDVatYearEndShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actCoOpImportExecute(Sender: TObject);
    procedure SendDataToAccontant1Click(Sender: TObject);
    procedure ReceiveDataFromAccountant1Click(Sender: TObject);
    procedure btnMTDVATSendRecAccDataClick(Sender: TObject);
    procedure actVatReportExecute(Sender: TObject);
    procedure actTransactionReportExecute(Sender: TObject);
    procedure actNomAuditTrailExecute(Sender: TObject);
    procedure tsSimpleVatReportsShow(Sender: TObject);
    procedure actMTDVatExecute(Sender: TObject);
    procedure actStandVatRptExecute(Sender: TObject);
    procedure actAgeOfDebtExecute(Sender: TObject);
    procedure pmiCustomerAgeOfDebtClick(Sender: TObject);
    procedure pmiSupplierAgeOfDebtClick(Sender: TObject);
    procedure imgTeamViewerClick(Sender: TObject);
    procedure actBankAuditTrailExecute(Sender: TObject);
  private
    function GetInputGridRecordCount: Integer;
    function GetIsEditingCashbookTransaction: Boolean;
    procedure SetInputGridInEditState(const Value: Boolean);
    function GetUsingSimpleLayout: Boolean;
    function GetCashbookTransactionType: TTransactionType;
    procedure GridControlKeyPress(Sender: TObject; var Key: Char);

    procedure CBEVATCodeOnChange(Sender: TObject);
    procedure CBEAmountOnChange(Sender: TObject);
    procedure ChangesBeforeRegVerCheck;
    function MenuBarCanExecute : Boolean;
    procedure DownloadNewVersion(AShowPrompt : Boolean);
    procedure PromptForMaintenace;
    procedure UpdateYearOnStatusBar;
    procedure ShowBankLink;
  private
    cxGridColumn : TcxCustomGridTableItem;
    TempVar : Variant;
    FRegistry : TRegistry;
    FFormShowing : Boolean;
    FGridDesigning : Boolean;
    FPSimpleLayoutOrigHeight : Integer;
    FSupplierCustomerUserText : string;
    FCBEDate : TDateTime;
    FCBELastNominalAccount : string;

    FLastCBENom : string;

    FInputGridInEditState : Boolean;
    FLastSelectedRowIndex : Integer;

    FHintStyleController: TcxHintStyleController;

    FCalculatingVAT : Boolean;

    FLedgerType : TLedgerType;

    function CopyTransactionDetails : boolean;
    function LoadTransactionDetails : boolean;
    Procedure CheckVATForChanges();
    procedure TransactionEdit;
    Function RowOK (Row : LongInt) : Integer;
    Procedure CheckNumericColumns(const ARowIndex : Integer);
    procedure setvals;
    procedure UpdateModules;

    procedure CloseGracefully;
    procedure LoadPreferences;
    procedure SetupTransactionGrid;
    procedure SetupCBEntryGrid;
    procedure FocusItem(AIndex : Integer);
    procedure ClearInputGrid;
    procedure SetupSimpleLayout;
    function GetInputGridCell(Index: Integer): Variant;
    function GetTransGridCell(Index: Integer): Variant;
    procedure SetInputGridCell(Index: Integer; const Value: Variant);
    procedure SetTransGridCell(Index: Integer; const Value: Variant);
    function GetInputGridRecordIndex: Integer;

    procedure SetupSearchDefaults;
    procedure ShowSearchBar(const AShow : Boolean);
    procedure SearchGrid;
    procedure ClearSearch;
    procedure ClearSearchFields;

    procedure PositionMenuButtons;

    procedure AddAnotherLine;
    procedure DeleteLine;

    procedure InitialiseTransPointers;
    procedure DisposeTransPointers;

    function Transaction_RowCount : Integer;

    procedure NotifyCustomerSupplierChange;

    procedure CheckCBRowOK;

    function CalcInputGridWidth : Integer;
    function InputGridTotalColumnWidth : Integer;
    procedure SetInputGridHeight;

    procedure CBEItemOnChange(Sender: TObject);
    procedure InputTransGridTableViewCBEDatePropertiesInitPopup(
      Sender: TObject);
    procedure InputTransGridTableViewNomDescEditValueChanged(
      Sender: TObject);
    procedure InputTransGridTableViewCBEDateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure DoResetNomValue(var Message:TMessage); message WM_RESETNOMVALUE;
    procedure OnGridColumnLayoutChanged();
    procedure DefaultHandler(var Message); override;
    procedure WMEraseBackground(var Message:TMessage); message WM_ERASEBKGND;

    function IsCBEEntryGridHorizontalScrollBarVisible : Boolean;
    function IsCBEEntryGridVerticalScrollBarVisible : Boolean;
    function GetCBEEntryDefaultHeight : Integer;

    function IsLastColumn(View : TcxGridTableView; Item : TcxCustomGridTableItem) : Boolean;

    procedure ThisOnEditValueChanged(Sender: TObject);
    procedure ThisOnChanged(Sender: TObject);

    procedure LoadTransaction();
    procedure ViewTransaction();
    procedure CenterMenuPanel(APanel : TPanel);
    procedure ResetCashbookTransaction(const AConfirmCancel : Boolean);

    function InputTransGridIsEmpty : Boolean;
    function GetCBEAnalysisCode : string;

    procedure InvokeCoOpImportPopup();
    procedure InvokeNominalSelector();

    procedure CheckCashbookEntryGridState();

    procedure CBENominalAccountAfterChange();
    function VarHasValue(Value : Variant) : Boolean;

    procedure EnableCBEActions();

    procedure ShowHint(const AHintTitle, AHintText : string;
       var APoint : TPoint);
    procedure HideHint();

    procedure EditCBEQuantities(APoint : TPoint);

    procedure EditNominalFreeTextDescription();overload;
    procedure EditNominalFreeTextDescription(APoint : TPoint);overload;

    procedure CopyCellValueToAllLines(const AColIndex : Integer; const AValue : Variant);
    function GetIsIncomeOrExpense : TTransactionType;
    procedure LoadDefaultNominalForCustomerSupplier(AId : Integer);

    procedure CheckCustomerSupplierAgeOfDebt;

    property InputGridCell[Index : Integer] : Variant read GetInputGridCell write SetInputGridCell;
    property InputGridRecordIndex : Integer read GetInputGridRecordIndex;
    property TransGridCell[Index : Integer] : Variant read GetTransGridCell write SetTransGridCell;
    property InputGridRecordCount : Integer read GetInputGridRecordCount;
    property IsEditingCashbookTransaction : Boolean read GetIsEditingCashbookTransaction;

    property InputGridInEditState : Boolean read FInputGridInEditState write SetInputGridInEditState;
    property UsingSimpleLayout : Boolean read GetUsingSimpleLayout;
    property CashbookTransactionType : TTransactionType read GetCashbookTransactionType;

    property IsIncomeOrExpense : TTransactionType read GetIsIncomeOrExpense; // (ttIncome, ttExpense);

  public
    // tv = TableView

    // Transaction Grid
    tvTxNoIndex, tvDateIndex, tvRefIndex, tvCommentStubNoIndex, tvVATorDiscountIndex,
    tvAmountIndex, tvCustomerSupplierIndex, tvTransTypeIndex, tvJourTransIndex, tvEditingIndex,
    tvTxTypeIndex, tvOrigTypeIndex, tvNominalIndex, tvAnalysisCode, tvCoOpComment : Integer;

    // Cashbook Entry i.e. Simple Layout Grid
    tvCBEDateIndex, tvCBEEntIndex, tvCBENomDescIndex, tvCBEStubIndex,
    tvCBECustSuppIndex, tvCBEQtyIndex,
    tvCBEAmtIndex, tvCBEVATIndex, tvCBEVATCodeIndex, tvCBERefIndex, tvCBENomIndex,
    tvCBEAnalysisCode,

    tvCBEQuantity2, tvCBEQuantity3, tvCBENomFreeEntryDescIndex, tvCBEVatCalculatedIndex : integer;

    procedure LoadTransactionGrid;
    procedure SetupInterface;


  end;

procedure QuickSort(var AButtonArray : array of TcxButton; ALo, AHi: Integer);

Var
  FMainScreen: TFMainScreen;

  // New Variables added by TGM AB 23/07/02 for simple data entry
  VatCalculated: array[1..2] of Boolean;
  DateCol : integer;
  EntCol : integer;
  NomCol : integer;
  StubCol : integer;
  CustSuppCol : integer;
  QtyCol : integer;
  AmtCol : integer;
  VatCol : integer;
  VatCodeCol : integer;
  RefCol : integer;
  Nomaccount, custsuppaccount, bankaccountnumber : shortstring;
  BadCol : LongInt;
  InclusiveVatRate : Real;

  // SP 29/04/2015 - Bug Fix - Remove UseDefaults requested by GL because defaulting Supplier/Customer should not be implemented
  //                           for the simple entry system.
//  UseDefaults : boolean;
  justadded : boolean;

  WM_KINGSWOOD_FARMSYNC_MARKASSYNCHRONIZED : DWORD;
  WM_KINGSWOOD_FARMSYNC_ERRORINSYNCPROCESS : DWORD;
  WM_KINGSWOOD_FARMSYNC_LOGINFAILED : DWORD;

  WM_KAccountsUpdateAvailable : DWord;
  WM_KAccountsNotOnMainteance : DWord;

  // End TGM AB
const
   cFieldReadError = 'Field "%s" has an unexpected value - contact Kingswood';
   cTransGridIniFile = 'transgrid.ini';

   cDefaultCBEGridRowHeight = 26;
   cDefaultCBEGridFooterHeight = 26;

Implementation
Uses
    Accsdata, Init, KMessage, Filed, Params, ShellApi, DefSecFl, DbCore, util, dbgen, vars,
    clears, abortprg, calcs, LangUnit, ChkComp, MainRpts, CashBook, BankAct, NewListing, FullAudit,
    uSuppDownLoad, CleartxUnit, NewRepUnit, UBackup, TxWrite, uBudgets, DataExport,
    CalculateMonths, dataconvert, Systemdefinition, password, cxFilter, cxFormats,
    uPreferences, uPreferenceConsts, uSupplierDownload, uSysMain, uSetup, Othform, Setup,
    UNominalSetUp, AccsUtils, uSetupWizard, uEnterpriseAnalysisByChart,
    uBankFileSelector, uAccounts, uBankFileSelectorSettings, uSetupAnalysis,
    AccsResources, cxGridCustomPopupMenu, uDataBackup,
    uKingswoodAccountantController, uAccountantDownloadHelper,
    DCPCryptManagement, uTransactionQuantityInput, uQuantityInput, uAccsSystem,
    uTransactionNominalFreeTextDescriptionInput, uAccsSync, uFarmSyncSettings,
    uBankImport, uFarmGateEditForm, uPreferencesStore, uEmailAttachments,
    SimpleAccsDataModule, uAccsTransaction, Uyearend, uDigitalVATForm,
    uVATSubmissionReportForm, reportdefs, Nomrpt, Rcslist;

{$R *.DFM}

Procedure TFMainScreen.LoadTransactionGrid;
Var
   TypeDesc : ShortString{[20]};
   StubOrComment,
   EditStat : ShortString;
   RowGrid,
   RecCount,
   TxType,
   OrigType,
   FillCount,
   TxHigh, TxNo, i : Integer;
   FirstTx, TempInt : Integer; //smallint
   TempStr : string;
   MyTxType : Integer;
   BankID : Integer;
var
   nGridRow : Integer; // to be used with TransactionGridTableView.Values[]
   BankName : string;
   BankAccount : TBankAccount;
   AnalysisCode : TAnalysisCode;
begin
   cmboCustomer.Properties.Items.Clear;
   cmboSupplier.Properties.Items.Clear;

   SetDb ( TxFile );
   TxHigh := Accsdatamodule.TransactionsDB.RecordCount;

   RecCount := TxHigh;
   FirstTx := FullAudit.AuditFiles.FirstTxThisYear;

   AccsDataModule.FrontGridQuery.open;
   TxHigh := Accsdatamodule.FrontGridQuery.RecordCount;

   BarControlProgressBar.Control := ProgressBar;
   BarControlProgressBar.Visible := ivAlways;
   ProgressBar.Max := TxHigh;
   ProgressBar.Position := 0;
   ProgressBar.Step := 1;

   TypeDesc := '';

   TransactionGridTableView.DataController.RecordCount := 0;

   // SP 15/01/2009 nGridRow to be used with TransactionGridTableView.Values[]
   nGridRow := 0;
   // SP 15/01/2009 Introduction of TransactionGridTableView.
   TransactionGridTableView.DataController.BeginUpdate;
   try

   try
      Accsdatamodule.FrontGridQuery.Last;
      //For i := TxHigh downto 1 do begin
      BankID := 0;
      while not Accsdatamodule.FrontGridQuery.Bof do
         begin
            TxNo := Accsdatamodule.FrontGridQuery['TxNo'];

            MyTxType := Accsdatamodule.FrontGridQuery['TxType'];
            if ( MyTxType in  [16, 12, 6] )then
               BankID := Accsdatamodule.FrontGridQuery['Nominal'];

            TxNo := Accsdatamodule.FrontGridQuery['TxNo'];
            if (( RecCount > 0 ) and (TxNo >= FirstTX))Then
               Begin
                  EditStat := ' ';
                  StubOrComment := '';
                  Tempstr := vartostr(Accsdatamodule.FrontGridQuery['EditStat']);
                  If (length(TempStr) > 0) then
                     try
                        Editstat[1] := tempstr[1];
                     except
                     end;

                  if not (EditStat[1] In ['E','R']) then
                     begin
                        TxType := Accsdatamodule.FrontGridQuery['TxType'];
                        OrigType := Accsdatamodule.FrontGridQuery['OrigType'];

                        if ( EditStat[1] In ['E','R','I','P'] ) then
                           TypeDesc := '';

                        If ( TypeDesc = '' ) And ( NOT ( EditStat[1] In ['E','R','I','P'] )) Then
                           begin
                              StubOrComment := '';
                              If ( TxType = 12 ) And ( OrigType = 11 ) Then { Cash Income }
                                 TypeDesc := ReadLang ( 21, CurrLang )
                              Else If ( TxType = 16 ) And ( OrigType = 15 ) Then { Cash Expend }
                                 TypeDesc := ReadLang ( 22, CurrLang )
                              Else If ( TxType In [{0,}9] ) And ( OrigType = 1 ) Then { Sales Inv }
                                 TypeDesc := ReadLang ( 15, CurrLang )

                              //TGM AB added this line to fix problem with sorted grid displaying blank details

                              Else If ( TxType In [1] ) And ( OrigType = 1 ) Then { Sales Inv }
                                 TypeDesc := ReadLang ( 15, CurrLang )
                              Else If ( TxType In [5] ) And ( OrigType = 5 ) Then { Purchase Inv }
                                 TypeDesc := ReadLang ( 18, CurrLang )
                              Else If ( TxType = 15 ) And ( OrigType = 15 ) Then { Cash Expend }
                                 TypeDesc := ReadLang ( 22, CurrLang )
                              Else If ( TxType = 11 ) And ( OrigType = 11 ) Then { Cash Income }
                                 TypeDesc := ReadLang ( 21, CurrLang )
                              Else If ( TxType In [7] ) And ( OrigType = 7 ) Then { Purchase Credit Note }
                                 TypeDesc := ReadLang ( 47, CurrLang )
                              Else If ( TxType In [3] ) And ( OrigType = 3 ) Then { Sales Credit Note }
                                 TypeDesc := ReadLang ( 46, CurrLang )

                              // TGM AB End

                              Else If ( TxType In [2{,9}] ) And ( OrigType = 2 ) Then { Sales Receipt }
                                 TypeDesc := ReadLang ( 16, CurrLang )
                              Else If ( TxType = 2 ) And ( OrigType = 1 ) Then { Cash Sales }
                                 TypeDesc := ReadLang ( 17, CurrLang )
                              Else If ( TxType In [{0,}9] ) And ( OrigType = 3 ) Then { Sales Credit Note }
                                 TypeDesc := ReadLang ( 46, CurrLang )
                              Else If ( TxType In [{0,}9] ) And ( OrigType = 5 ) Then { Purchase Inv }
                                 TypeDesc := ReadLang ( 18, CurrLang )
                              Else If ( TxType In [6{,9}] ) And ( OrigType = 6 ) Then { Purchase Payment }
                                 TypeDesc := ReadLang ( 19, CurrLang )
                              Else If ( TxType = 6 ) And ( OrigType = 5 ) Then { Cash Purchase }
                                 TypeDesc := ReadLang ( 20, CurrLang )
                              Else If ( TxType In [{0,}9] ) And ( OrigType = 7 ) Then { Purchase Credit Note }
                                 TypeDesc := ReadLang ( 47, CurrLang )
                              Else If ( TxType = 9 ) And ( OrigType = 0 ) Then
                                 TypeDesc := ReadLang ( 152, CurrLang );

                              If (( TxType = 2 ) And ( OrigType = 2 )) Or
                                 (( TxType = 2 ) And ( OrigType = 1 )) Or
                                 (( TxType = 6 ) And ( OrigType = 6 )) Or
                                 (( TxType = 6 ) And ( OrigType = 5 )) Then
                                 Begin
                                   StubOrComment := Accsdatamodule.FrontGridQuery['StubNo'];
                                 End;
                            end;

                            if ( NOT ( EditStat[1] In ['E','R','I','P'] )) And
                               ((( TxType In [1,2,3,5,6,7,11,15] ) And
                                 ( OrigType = TxType )) Or
                               (( TxType = 9 ) And ( OrigType = 0 )) Or
                               (( TxType = 0 ) And ( OrigType In [4,8] ))) then
                              begin
                                 TransactionGridTableView.DataController.RecordCount := TransactionGridTableView.DataController.RecordCount+1;
                                 TransactionGridTableView.DataController.Values[nGridRow, tvTxTypeIndex] := TxType;
                                 TransactionGridTableView.DataController.Values[nGridRow, tvOrigTypeIndex] := OrigType;

                                 if ( TxType = 9 ) And ( OrigType = 0 ) Then
                                    begin
                                       TransactionGridTableView.DataController.Values[nGridRow, tvJourTransIndex] := 'J';
                                    end
                                 else
                                    begin
                                       TransactionGridTableView.DataController.Values[nGridRow, tvJourTransIndex] := 'N';
                                    end;

                                 if ( RecCount <= Cash1.xLastTx ) Then
                                    TransactionGridTableView.DataController.Values[nGridRow, tvEditingIndex] := 'F'
                                 else
                                    TransactionGridTableView.DataController.Values[nGridRow, tvEditingIndex] := 'T';

                                  // Tx No
                                  TransactionGridTableView.DataController.Values[nGridRow, tvTxNoIndex] := IntToStr ( TxNo );
                                  // Date
                                  TransactionGridTableView.DataController.Values[nGridRow, tvDateIndex] := Accsdatamodule.FrontGridQuery.FieldByName('TxDate').AsDateTime;
                                  // Ref
                                  TransactionGridTableView.DataController.Values[nGridRow, tvRefIndex] := Accsdatamodule.FrontGridQuery.FieldByName('Reference').AsString;

                                  //Nominal Acc - used to identify what bank was used in transaction
                                  if ( MyTxType in [15, 11, 6] ) then
                                     begin
                                        if ( BankID>0 ) then
                                           begin
                                              BankAccount := AccsDataModule.Accounts.BankAccounts.GetBankAccount(BankID);
                                              if (BankAccount <> nil) then
                                                 TransactionGridTableView.DataController.Values[nGridRow, tvNominalIndex] := BankAccount.Name;
                                              BankID := 0;
                                           end;
                                     end;

                                  if StubOrComment <> '' then
                                     TransactionGridTableView.DataController.Values[nGridRow, tvCommentStubNoIndex] := StubOrComment
                                  else
                                     begin
                                        Tempstr := '';
                                        if ( TxType = 11 ) Or ( TxType = 15 ) then
                                           Tempstr := Accsdatamodule.FrontGridQuery['StubNo']
                                        else
                                           Tempstr := vartostr(Accsdatamodule.FrontGridQuery['Descript']);

                                        // CommentStubNo
                                        TransactionGridTableView.DataController.Values[nGridRow, tvCommentStubNoIndex] := Tempstr;
                                      end;

                                  // Customer/Supplier
                                  TempStr := '';
                                  TempInt := 0;
                                  if ( TxType = 11 ) Or ( TxType = 15 ) then
                                     Tempstr := vartostr(Accsdatamodule.FrontGridQuery['Descript'])
                                  else if ( not(Cash1.xCashBook) ) then
                                     begin
                                        //   22/03/17 [V4.2 R7.2] /MK Bug Fix - cmboCustomer and cmboSupplier were given the same listing instead of seperate listings - reported by Tom Doran
                                        TempInt := Accsdatamodule.FrontGridQuery['Account'];
                                        if TxType in [1..3] then
                                           begin
                                              TempStr := GetSLPLAccountName ( SlFile, TempInt);
                                              if ( Length(TempStr) > 0 ) then
                                                 if ( cmboCustomer.Properties.Items.IndexOf(TempStr) = -1 ) then
                                                    cmboCustomer.Properties.Items.Add(TempStr);
                                           end
                                        else if TxType in [5..7] then
                                           begin
                                              TempStr := GetSLPLAccountName ( PlFile, TempInt);
                                              if ( Length(TempStr) > 0 ) then
                                                 if ( cmboSupplier.Properties.Items.IndexOf(TempStr) = -1 ) then
                                                    cmboSupplier.Properties.Items.Add(TempStr);
                                           end
                                        else
                                           Tempstr := vartostr(Accsdatamodule.FrontGridQuery['Descript']);
                                     end;
                                  TransactionGridTableView.DataController.Values[nGridRow, tvCustomerSupplierIndex] := TempStr;

                                  //   02/03/16 [V4.1 R1.9] /MK Additional Feature - Incorporated Andrew's (TGM) changes to show the Co-Op comment column.
                                  //   TGM AB 05/02/16 Added lines below to update grid with correct data for Co-Op Import Transactions
                                  if ( Accsdatamodule.FrontGridQuery['CoOpImport'] = True ) then
                                     begin
                                        Tempstr := '';
                                        Tempstr := vartostr(Accsdatamodule.FrontGridQuery['CoOpComment']);
                                        if ( Length(TempStr) > 0 ) then
                                           TransactionGridTableView.DataController.Values[nGridRow, tvCoOpComment] := TempStr;

                                        Tempstr := '';
                                        TempInt := 0;
                                        TempInt := Accsdatamodule.FrontGridQuery['Account'];
                                        if ( TempInt > 0 ) then
                                           begin
                                              TempStr := GetSLPLAccountName ( PlFile, TempInt);     // Customer / Supplier Column
                                              if ( Length(TempStr) > 0 ) then
                                                 TransactionGridTableView.DataController.Values[nGridRow, tvCustomerSupplierIndex] := TempStr;
                                           end;
                                     end;
                                  // end 05/02/16

                                  //   02/03/16 [V4.2 R3.5] /MK Additional Feature - Show Customer/Supplier info in grid if transaction is Co-Op Payment - James Walsh (7919)
                                  if ( Preferences.ValueAsBoolean[cPref_EnableCoOpImport] ) then
                                     if ( Cash1.XCASHBOOK ) then
                                        if ( TxType = 6 ) then
                                           begin
                                              Tempstr := '';
                                              TempInt := 0;
                                              TempInt := Accsdatamodule.FrontGridQuery['Account'];
                                              if ( TempInt > 0 ) then
                                                 begin
                                                    TempStr := GetSLPLAccountName ( PlFile, TempInt);     // Customer / Supplier Column
                                                    if ( Length(TempStr) > 0 ) then
                                                       TransactionGridTableView.DataController.Values[nGridRow, tvCustomerSupplierIndex] := TempStr;
                                                 end;
                                           end;

                                  currlong := (accsdatamodule.FrontGridQuery['Amount'] * 100);
                                  If TxType In [3,7] Then CurrLong := 0-CurrLong;
                                  LongStr ( CurrLong, CurrStr, 'L' );
                                  Slimright ( CurrStr );
                                  // Amount
                                  TransactionGridTableView.DataController.Values[nGridRow, tvAmountIndex] := CurrStr;

                                  Currstr := vartostr(accsdatamodule.FrontGridQuery['TaxCode']);
                                  SlimAll ( CurrStr );
                                  If ( CurrStr <> '*' ) Then
                                     Begin
                                        currlong := (accsdatamodule.FrontGridQuery['TaxDisc'] * 100);
                                        LongStr ( CurrLong, CurrStr, 'L' );
                                        SlimRight ( CurrStr );
                                     End
                                  Else
                                     Begin
                                        CurrLong := 0;
                                        LongStr ( CurrLong, CurrStr, 'L' );
                                        SlimRight ( CurrStr );
                                     End;
                                  // VAT
                                  TransactionGridTableView.DataController.Values[nGridRow, tvVATorDiscountIndex] := CurrStr;

                                  // Trans Type
                                  TransactionGridTableView.DataController.Values[nGridRow, tvTransTypeIndex] := TypeDesc;

                                  if RecCount <= Cash1.xLastTx Then
                                     begin
                                        // Editing
                                        TransactionGridTableView.DataController.Values[nGridRow, tvEditingIndex] := 'F';
                                     end
                                  else
                                     begin
                                        // Editing
                                        TransactionGridTableView.DataController.Values[nGridRow, tvEditingIndex] := 'T';
                                     end;
{
                                  AnalysisCode := AccsDataModule.Accounts.AnalysisCodes.GetAnalysisCode(
                                                        Accsdatamodule.FrontGridQuery.FieldByName('Analysis').AsString);

                                  if (AnalysisCode <> nil) then
                                     TransactionGridTableView.DataController.Values[nGridRow, tvAnalysisCode] := AnalysisCode.Name;
}
                                  TypeDesc := '';

                                  Inc( nGridRow );
                              end;
                     end;
                  Dec ( RecCount );
                  if not(RecCount = 0) then accsdatamodule.FrontGridQuery.prior;
               end
            else
               accsdatamodule.FrontGridQuery.prior;

         ProgressBar.StepIt;
      end; // For i := //Until (RecCount = 0);
   except
      on e : exception do
         ShowMessage( IntTostr(TxNo) + ' - ' +e.Message );
   end;

   finally
      TransactionGridTableView.ApplyBestFit( TransactionGridTableView.Items[tvRefIndex] );
      TransactionGridTableView.ApplyBestFit( TransactionGridTableView.Items[tvCustomerSupplierIndex] );
      TransactionGridTableView.ApplyBestFit( TransactionGridTableView.Items[tvCommentStubNoIndex] );

      BarControlProgressBar.Visible := ivNever;
      AccsDataModule.FrontGridQuery.close;
      TransactionGridTableView.DataController.EndUpdate;

      {
      if ( cmboCustomer.Properties.Items.Count > 0 ) then
         cmboSupplier.Properties.Items.Assign(cmboCustomer.Properties.Items);
      }
      ceBankBalance.Value := AccsDataModule.GetBankBalance(beBankAccount.Text);

      UpdateYearOnStatusBar;
   end;
End;

Procedure TFMainScreen.FormActivate(Sender: TObject);
var
   VatArrPos : Integer;
begin
   HideHint();
   OnActivate := nil;

   //   25/05/20 [V4.5 R2.1] /MK Additional Feature - Added check if customer is on maintenance.
   AccsDataModule.CheckMaintenanceWithKinstaller;

   //   25/05/20 [V4.5 R2.1] /MK Additional Feature - Added check for new version similar to what Kingswood Fields does.
   AccsDataModule.CheckNewVersionAvailable;

   FFormShowing := True;
   // TGM AB - fix to set Private Inc / Private Exp to vat code 0
   ReadRec(NlFile,cash1.xnomprvinc);
   IF Recactive(NlFile) THEN BEGIN
        GetItem(NlFile,20);
        if Currstr = '' then begin
           if ( NewListBox.CheckVAT ('0',VATArrPos)) then Currstr := '0'
              else Currstr := 'Z';
        PutStr (NlFile,CurrStr, 20 );
        Rewriterec(NlFile,cash1.xnomprvinc);
        end;
   end;
   ReadRec(NlFile,cash1.xnomprvexp);
   IF Recactive(NlFile) THEN BEGIN
        GetItem(NlFile,20);
        if Currstr = '' then begin
           if ( NewListBox.CheckVAT ('0',VATArrPos)) then Currstr := '0'
              else Currstr := 'Z';
        PutStr (NlFile,CurrStr, 20 );
        Rewriterec(NlFile,cash1.xnomprvexp);
        end;
   end;

    if cash1.xyearend = true then begin
        application.messagebox('You have selected an Archive Set of Accounts. Any changes or additions made here will NOT be reflected in your Current Year''s Accounts.','Warning - Archive Data Selected', MB_OK or MB_ICONWARNING);   // TGM AB 14/10/16
    end;


    // trial balance check TGM AB 26/02/02

 {   if firstrun then begin
       if FCheckName.TrialbalanceOK = false then Showmessage('Data Integrity Test Indicates the Trial Balance does not balance, Please Contact Kingswood For Help');
       firstrun:=false;
       end;
 }
//    fullaudit.AuditFiles.Show;
//    fullaudit.AuditFiles.CheckData(nil);
//    fullaudit.AuditFiles.Free;

   ceBankBalance.Value := AccsDataModule.GetBankBalance(beBankAccount.Text);
   LoadPreferences;

   WizardTimer.Enabled := True;

   CenterMenuPanel(pCashBookMenu);
   CenterMenuPanel(pReports);
   CenterMenuPanel(SimpleVatPanel);
   CenterMenuPanel(pSimpleVatReports);

   // *** As of version 4.1.2.0 When in Simple Entry mode, if focus is set to any
   // *** record on the TransactionGrid the details of selected transaction
   // *** will be automatically loaded into the InputTransGrid.
   // *** We DO NOT want this to happen when the user enters program for the first time.
   // *** The InputTransGrid should be empty and ready for entry of new cashbook transaction.
   if not UsingSimpleLayout then
      begin
         if (TransactionGridTableView.DataController.RecordCount > 0) then
             TransactionGridTableView.DataController.FocusedRowIndex := 0;
      end
   else
      begin
         FLastSelectedRowIndex := -1;

         // 26/11/2012 SP - Removed code which sets the simple grid state to inserting.
         // The code was removed because any action in the program required cancelling of
         // the entry grid transaction before proceeding to next action. This caused issues
         // when user simply wanted to check a report, or existing transaction and not enter
         // a new transaction.

         // Invoke the EnterTransaction action which will ready the InputTransGrid for new
         // cashbook transaction.
         // actEnterNewTransaction.Execute;

      end;

   //   26/05/20 [V4.5 R2.1] /MK Bug Fix - Don't show sync button if not SyncConfigured.
   blbSync.Visible := ivAlways;
   actSync.Visible := TfmFarmSyncSettings.SyncConfigured(AccsDataModule.CurrentDatabase);
   if ( not(actSync.Visible) ) then
      blbSync.Visible := ivNever;

   //   13/11/20 [V4.5 R4.6] /MK Change - Don't show BankLinkTimer anmymore instead show BankLink select file screen and then show AppInfo and NewFeatures screen.
   ShowBankLink;

   if ( ParamCount = 0 ) then
      begin
         if ( not(TfmFarmSyncSettings.SyncConfigured(AccsDataModule.CurrentDatabase)) ) then
            if ( Preferences.ValueAsBoolean[cPref_ShowKingswoodAccsAppInfo] ) then
               if ( not(cash1.Xcashbook) and not(cash11.XUse_Vat) and not(cash11.XSimpleVAT) ) then
                  TfmKingswoodAppInfo.ShowTheForm;

         //   15/11/18 [V4.3 R2.7] /MK Additional Feature - Show the New Features screen.
         if ( (Preferences.ValueAsBoolean[cPref_ShowBankLinkFeatures]) or
              (Preferences.ValueAsBoolean[cPref_ShowCoOpLinkFeatures]) or
              (Preferences.ValueAsBoolean[cPref_ShowAccountantLinkFeatures]) ) and
              ( not(cash11.XSimpleVAT) ) then
               TfmAccsNewFeatures.ShowTheForm;
      end;
end;

procedure TFMainScreen.FormDeactivate(Sender: TObject);
begin
    // tgm removed all this code and put it into form close instead as having problems when
    // previewing invoicereport.  Preview invoicereport is a modal call and this seems to deactivate
    // the other windows currently in a showmodal state.  Thus the deactivate event code is called

    (*
    ChkComp.FCheckName.Show;
    try accsdata.accsdatamodule.PrintFile.close;
    except
    end;
    (*
    CloseAll;
    { Close all farmgate Databases }

    CloseLang;
    *)
   HideHint();
end;

procedure TFMainScreen.FormShow(Sender: TObject);
var
   tempStr : ShortString;
   isBefore : Boolean;
   registry:Tregistry;
   i : Integer;
begin
   NOTIFY_TRANSACTION_WRITE_SUCCESS := True;
   actDeleteLine.Visible := False;

   pSimpleLayout.Visible := False;

    Caption := 'Kingswood Windows Accounts';

    // TGM AB 23/07/02 added next 4 lines to allow taskber to be shown along with mainscreen

    // TGM AB setup simplifed input screen & initialise the relevant variables
    {
     Taken out by Shane 22/11/2012 - SetupInterface must be called for all start types.

     The SetupInterface method was not being invoked if user came from the Herd Program, but
     was being invoked if running accounts standalone. This caused UI to be
     displayed differently under both scenarios

    if param_start then
       begin
          if ((cash1.xcashbook) and (Param_type[1] in ['M','P','S'])) then
             SetupInterface;
       end
    else
       SetupInterface; }
    // Shane 22/11/2012
    SetupInterface;

    Custsuppaccount := '';
    FSupplierCustomerUserText := '';

    // end tgm ab

    // Do checks pre registry version number change.
    ChangesBeforeRegVerCheck;

    UpdateModules;

    StatusBar.Panels.Items[0].Text := 'Kingswood Computing Ltd. | KAW '+ Verno;
    StatusBar.Panels.Items[3].Text := 'Company Name - ' + Cash1.XCompany;

    OpenLang;
    ChkComp.FCheckName.Hide;

    { Code to Fill the Transaction Grid }
    PROG := TxFillGrid;
    CloseAll(MaxDatabases);
    If Not OpenAll Then
       AbortProgram ('Error Opening Database Files - Contact Kingswood');

    // TGM AB 25/07/02 next 2 lines fill in the default bank into the simplified input screen
    // has to be done at this point as the tables have only been opened above.
    //BankAccount.text := GetAccountName ( NLFile, Cash1.XLASTBANK,1);
    beBankAccount.Text := GetAccountName ( NLFile, Cash1.XLASTBANK,1);
    BankAccountNumber := IntToStr(Cash1.XLASTBANK);

   SetupSearchDefaults;

   btnCashbookGroup.Visible := not Cash11.xuse_inc_exp;

   btnSalesGroup.Visible := not Cash1.xCashBook;
   btnPurchaseGroup.Visible := not Cash1.xCashBook;
   EnterpaymentBtn.Visible := Cash1.xCashBook;

   PositionMenuButtons;
   AccsDataModule.OpenDataLinks; // this call should ideally be placed in AccsDataModule.Create Method
                                 // but the AccsDataModule.create method is not invoked until after load
                                 // transaction grid is completed.
   LoadTransactionGrid;

   FPSimpleLayoutOrigHeight := pSimpleLayout.Height;
   FFormShowing := True;

   FCBEDate := Date;

   ViewPageControl.ActivePageIndex := 0;
   ViewPageControl.OnPageChanging := ViewPageControlPageChanging;
end;

procedure TFMainScreen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   OrigVAT,
   TmpStr : ShortString;
   Handled: Boolean;
begin
   Handled := False;
   if (ViewPageControl.ActivePageIndex = tsSalesInvoice.PageIndex) then
       begin
          SimpleSaleInvoiceFrame.HandleKeyDownEvent(Sender, Key, Shift,Handled);
          Exit;
       end
   else if (ViewPageControl.ActivePageIndex = tsPurchaseInvoice.PageIndex) then
       begin
          SimplePurchaseInvoiceFrame.HandleKeyDownEvent(Sender, Key, Shift,Handled);
          Exit;
       end;
       
   if InputTransGrid.IsFocused then
      begin
         if Key = VK_F2 Then    { F2 Pressed }
            begin

               if InputTransGridTableView.Controller.FocusedItem = nil then
                  Exit;

               if InputTransGridTableView.Controller.FocusedItem.Index = tvCBEDateIndex then
                  begin   { Date Column }
                     //ShowMessage('Invoke Date Editor');
                  end
               else if InputTransGridTableView.Controller.FocusedItem.Index = tvCBECustSuppIndex then
                  begin
                     If cbTransTypeGroup.ItemIndex = 1 then
                        NewListBox.ListIt ( Sender, Suppliers, 'S' )
                     else
                        NewListBox.ListIt ( Sender, Customers, 'C' );

                     If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
                        begin
                           InputGridCell[tvCBECustSuppIndex] := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ),1);
                           custsuppaccount := NewListBox.ListInfo.ReturnValue;
                           justadded := true;
                           NotifyCustomerSupplierChange;
                        end;
                  end
               else if (not cash11.xuse_enterprise) and (InputTransGridTableView.Controller.FocusedItem.Index = tvCBEEntIndex) then
                  begin
                     NewListBox.ListIt ( Sender, Enterprise, 'E' );   { Enterprise Accounts }
                     If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
                        begin
                           InputGridCell[tvCBEEntIndex] := NewListBox.ListInfo.ReturnValue;
                           InputGridCell[tvCBEQuantity2] := 0;
                           InputGridCell[tvCBEQuantity3] := 0;
                           PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBEEntIndex+1,0);
                        end;
                  end
               else if InputTransGridTableView.Controller.FocusedItem.Index = tvCBEVATCodeIndex then
                  begin
                     TempVar := InputGridCell[tvCBEVATCodeIndex];
                     if not VarIsNull(TempVar) then
                        begin
                           OrigVAT := TempVar;
                           SlimAll ( OrigVAT );
                        end;
                     NewListBox.ListIt ( Sender, Vat, 'V' );   { VAT Rates }
                     If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
                        begin
                           InputGridCell[tvCBEVATCodeIndex] := NewListBox.ListInfo.ReturnValue;
                           PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBEVATCodeIndex+1,0);
                           TempVar := InputGridCell[tvCBEVATCodeIndex];
                           if not VarIsNull(TempVar) then
                              begin
                                 TmpStr := TempVar;
                              end;
                        end;
                  end
               else if (not cash11.xuse_enterprise) and (InputTransGridTableView.Controller.FocusedItem.Index = tvCBENomDescIndex) then
                  IncomeExpenseButtonEditClick(nil,0);
              Key := 0;
            End  // if F2 ....
         else if ( Key = VK_TAB ) then
            begin
               if InputTransGridTableView.Controller.FocusedItem = nil then
                  Exit;

               //   25/10/17 [V4.2 R8.9] /MK Bug Fix - If pressing tab in last column program was trying to setfocus on btnAddAnotherLine but this button
               //                                      is not showing when editing a transaction. SetFocus on Save button if AddAnotherLine is not showing - Mary Parsons. 
               if ( IsLastColumn(InputTransGridTableView, InputTransGridTableView.Controller.FocusedItem) ) then
                  begin
                     if ( btnAddAnotherLine.Visible ) then
                        btnAddAnotherLine.SetFocus
                     else if ( btnSaveCBE.Visible ) then
                        btnSaveCBE.SetFocus;
                  end
               else
                  PostMessage(Handle, WM_FOCUSNEXTITEM, -1,0);

               Key := 0;
            end
         else if Key = VK_RETURN then
            begin
               if InputTransGridTableView.Controller.FocusedItem = nil then
                  Exit;

               if (not cash11.xuse_enterprise) and (InputTransGridTableView.Controller.FocusedItem.Index = tvCBEEntIndex) then
                  EntButtonEditClick(nil,0);

               if InputTransGridTableView.Controller.FocusedItem.Index = tvCBENomDescIndex then
                  IncomeExpenseButtonEditClick(nil,0);

               if InputTransGridTableView.Controller.FocusedItem.Index = tvCBEVATCodeIndex then
                  VATCodeButtonEditClick(nil,0);

               if InputTransGridTableView.Controller.FocusedItem.Index = tvCBECustSuppIndex then
                  begin
                     if UPPERCASE(InputTransGridTableView.Controller.FocusedItem.Caption) = 'SUPPLIER' then
                        SupplierButtonEditClick(nil,0)
                     else
                        CustomerButtonEditClick(nil,0);
                  end;

               if InputTransGridTableView.Controller.FocusedItem.Index = tvCBEAnalysisCode then
                  begin
                     InputGridCell[tvCBEAnalysisCode] := GetCBEAnalysisCode();
                  end;

               Key := 0;
            end
      end;


     If Key = VK_F1 Then
        Application.HelpContext(222);

     If Key = VK_F3 Then
        Begin
           actClearSearch.Enabled := False;
           actSearchTransactions.Execute;
           actSearchTransactions.Enabled := False;
        End;

     If (SHIFT = [ssCtrl,ssShift]) AND (Key = VK_F4) Then Showmessage('Configurator Not Available In Winaccs V3');
     If (SHIFT = [ssCtrl,ssShift]) AND (Key = VK_F6) Then
        CleartxForm.ShowModal;
     If (SHIFT = [ssCtrl,ssShift]) AND (Key = VK_F5) Then
        AuditFiles.ShowModal;
     If (SHIFT = [ssCtrl,ssShift]) AND (Key = VK_F7) Then begin
            if PSysLongToDelphi ( RFarmGate.PSerial ) < 1000 then begin
               try Application.CreateForm(TPasswordForm, PasswordForm);
                PasswordForm.showmodal;
                if ansilowercase(PasswordForm.Password) = 'cobalt' then begin
                   try Application.CreateForm(TSystemDefinitionForm, SystemDefinitionForm);
                   except
                   end;
                   SystemDefinitionForm.ShowModal;
                end else showmessage('Incorrect Password Entered');
               except
               end;
            end;
        end;

     if (SHIFT = [ssCtrl,ssShift]) and (Key = VK_F8) then
        begin
           Application.CreateForm(TPasswordForm, PasswordForm);
           PasswordForm.showmodal;
           if ansilowercase(PasswordForm.Password) = 'cobalt' then
              try
                 Application.CreateForm(TfmFarmGateEditForm, fmFarmGateEditForm);
                 fmFarmGateEditForm.ShowModal;
              finally
                 FreeAndNil(fmFarmGateEditForm);
              end
           else
              MessageDlg('Incorrect Password Entered',mtError,[mbOK],0);
        end;
end;

procedure TFMainScreen.bSuppDownloadClick(Sender: TObject);
begin
   { uSuppDownload.ShowTheForm; }
   TfmSupplierDownload.ShowSupplierDownload;
end;

procedure TFMainScreen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   HideHint();

   //   25/05/20 [V4.3 R2.1] /MK Change - Added prompt for backup where backup date is more than 30 days ago.
   if ( AccsDataModule.AccsDefaultsLastBackupDate > 0 ) and ( (AccsDataModule.AccsDefaultsLastBackupDate + 30) < Date ) then
      begin
         if MessageDLG('It is ' + FloatToStrF(Date() - AccsDataModule.AccsDefaultsLastBackupDate, ffFixed, 4 , 0 ) + ' Days since you took a Backup' + #13#10 +
                       'Do you want to take one now',mtWarning,[mbYes,mbNo],0) = mrYes then
            actBackup.Execute;
            Update;
      end;

   CheckCashbookEntryGridState();

   CloseGracefully;

   ClearInputGrid;

   OnActivate := FormActivate;

   if not param_start then
      begin
         ChkComp.FCheckName.Show;
         try
         accsdata.accsdatamodule.PrintFile.close;
         except
         end;
       (*
       CloseAll;               { Close all farmgate Databases }
       *)
        CloseLang;
        //   02/11/17 [V4.2 R9.0] /MK Bug Fix - Only check for AgeOfDebtSyncRequired if SyncConfigured.
        if ( TfmFarmSyncSettings.SyncConfigured(AccsDataModule.CurrentDatabase) ) then
           if AccsDataModule.AgeOfDebtSyncRequired then
              begin
                 if (Application.MessageBox(PChar('Your account information has changed.'+#13#10+#13#10+
                                                  'Do you want to Sync with the Kingswood Server now?'),
                                                  'Kingswood Accounts', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON1) = IDYES) then
                    actSync.Execute();
              end;
      end
   else
     begin
        Application.terminate;
     end;

   ViewPageControl.OnPageChanging := nil;
end;

procedure TFMainScreen.BankListBtnClick(Sender: TObject);
begin
      NewListBox.ListIt ( Sender, Banks, 'N' );
      If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then begin
         BankAccountnumber := NewListBox.ListInfo.ReturnValue;
         beBankAccount.Text := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ),1);
      end;
end;

procedure TFMainScreen.SetupInterface;
var
   registry:Tregistry;
   SimpleView:string;
begin
   
   pSimpleLayout.Visible := False;
   pMenuButtonPanel.Visible := False;
   SepHeadPanel.Visible := False;
   tsTransactionGridView.TabVisible := True;
   actReport.Enabled := True;

   blbViewManual.Visible := ivAlways;
   if ( Cash11.XSimpleVAT ) then
      blbViewManual.Visible := ivNever;

   bbEnterpriseListing.Visible := ivAlways;
   if ( Cash11.xUse_Enterprise ) then
      bbEnterpriseListing.Visible := ivNever;

   //   28/08/19 [V4.5 R0.3] /MK Change - MTD VAT and Year End page now visible for all UK Customers not just Simple Vat users.
   tsMTDVatYearEnd.TabVisible := ( Cash11.XSimpleVAT ) or ( not(cash11.XUse_Vat) ) and ( not cash1.xcashbook );
   if ( not cash11.XUse_Vat ) then
      begin
         if ( cash2.xcountry = 1 ) then
            tsMTDVatYearEnd.Caption := 'MTD VAT/Year End'
         else
            tsMTDVatYearEnd.Caption := 'VAT/Year End';
      end
   else
      tsMTDVatYearEnd.Caption := 'Year End';

   //   30/08/19 [V4.5 R0.3] /MK Additional Feature - New reports tab can be available for NI only or Irish customers with either Simple Vat or Invoicer module.
   if ( cash2.XCOUNTRY = 1 ) then
      tsSimpleVatReports.TabVisible := ( cash2.xcountry = 1 ) and ( not cash11.XUse_Vat ) and ( not cash1.xcashbook )
   else
      tsSimpleVatReports.TabVisible := ( (not cash11.XUse_Vat) and (Cash11.XSimpleVAT) ) or ( cash2.XWININV );

   //   30/08/19 [V4.5 R0.3] /MK Change - Reports page only relevant to Irish users that don't have Simple Vat on.
   tsReports.TabVisible := ( not(tsSimpleVatReports.TabVisible) ) and ( cash2.XCOUNTRY <> 1 );

   tsAccountActions.TabVisible := False;

   tsSalesInvoice.TabVisible := False;
   tsPurchaseInvoice.TabVisible := False;

   blbBusinessSummary.Visible := ivNever; // not being used on toolbar anymore
   blbBudgets.Visible := ivAlways; // not being used on toolbar anymore

   if (cash1.xcashbook) then // Cashbook mode.
      begin
         tsSalesInvoice.TabVisible := False;
         tsPurchaseInvoice.TabVisible := False;
         tsAccountActions.TabVisible := True;
         if (cash1.XSimple) then // Simple Entry mode
            begin
//               blbBudgets.Visible := ivNever;

               SetupCBEntryGrid;
               pSimpleLayout.Height := 200;
               pSimpleLayout.Visible := True;
            end
         else
            begin
               pSimpleLayout.Visible := False;
               pMenuButtonPanel.Visible := True;
            end;

//         blbBusinessSummary.Visible := ivNever;
      end
   else
      begin
         pSimpleLayout.Visible := False;
         pMenuButtonPanel.Visible := not(Cash11.XSimpleVAT);
         SepHeadPanel.Visible := not(pMenuButtonPanel.Visible);
         actReport.Enabled := not(Cash11.XSimpleVAT);
         tsSalesInvoice.TabVisible := ( (Cash11.XSimpleVAT) or (Preferences.ValueAsBoolean[cPref_ShowSalePurchGridMainGrid]) );
         tsPurchaseInvoice.TabVisible := tsSalesInvoice.TabVisible;
//         blbBudgets.Visible := ivAlways;
//         blbBusinessSummary.Visible := ivAlways;
      end;

   actBusinessSummary.Caption := AccsDataModule.GetBusinessSummaryAlterName;
   lFarmSummaryHeader.Caption := actBusinessSummary.Caption;
   actBudgets.Caption := AccsDataModule.GetBudgetAlternateName;
   lDairyEnterpriseHeader.Caption := AccsDataModule.CostPerUnitReportAlternateName;

   btnOtherBankFacilities.Caption := '';
   btnYearEndOther.Caption := '';
   btnBankFileImport.Caption := '';
   btnCoopImport3.Caption := '';

   ReportsActionList.Images := AccsDataModule.ImageList28x28;

   {
   Registry := Tregistry.Create;
   try
      Registry.OpenKey('Software\Kingswood\Kingsacc\SLPLDefaults', True);
      if Registry.ReadString('SLPLDefaults') = 'True' then
         UseDefaults := true
      else
         UseDefaults := false;
   finally
      Registry.Free;
   end;
   }
   //   24/11/14 [V4.1 R7.6] /MK Bug Fix - Check for SLPLDefaults in new uPrefences key not old key.

   // SP 29/04/2015 - Bug Fix - Remove UseDefaults requested by GL because defaulting Supplier/Customer should not be implemented
   //                           for the simple entry system.
   //UseDefaults := Preferences.PreferenceExists(cPref_EnableSLPLDefaults);

   actClearSearch.Enabled := True;
   actSearchTransactions.Enabled := True;

   actHelp.Visible := (AccsSystem.SystemType <> stCashbook);

   if ( not cash11.XUse_Vat ) then
      actOther.Caption := 'Year End/VAT'
   else
      actOther.Caption := 'Year End/Other';
end;

procedure TFMainScreen.BankButton2Click(Sender: TObject);
begin
    if GEditing then showmessage ('Please Complete Editing The Current Transaction Before Moving On')
    else actBank.Execute;
end;

procedure TFMainScreen.OtherButton2Click(Sender: TObject);
begin
     if GEditing then showmessage ('Please Complete Editing The Current Transaction Before Moving On')
     else actOther.Execute;
end;

function TFMainscreen.CopyTransactionDetails : boolean;
var
   i : Integer;
   tempstr : shortstring;
   templocation : integer;
begin

   Result := true;
   if not GEditing then Initvals;

   with InputTransGridTableView.DataController do
      begin
         for i := 0 to RecordCount-1 do
            begin
               FocusedRecordIndex := i; // NB Position the row pointer.

               TempVar := InputGridCell[tvCBECustSuppIndex];
               if not VarIsNull(TempVar) then
                  ZComm[1] := TempVar;

               ZBank[1] := StrToInt(BankAccountNumber);
               Cash1.XLASTBANK := StrToInt(BankAccountNumber);
               try
                  TempVar := InputGridCell[tvCBEStubIndex];
                  if not VarIsNull(TempVar) then
                     ZStub[1] := TempVar
                  else
                     ZStub[1] := 0;
               except
                  ZStub[1] := 0;
               end;

               TempVar := InputGridCell[tvCBEDateIndex];
               if not VarIsNull(TempVar) then
                  ZTxDate[1] := KDateToInt(FormatDateTime(TDateFormat, TempVar));

               if not cash11.xuse_enterprise then
                  begin
                     TempVar := InputGridCell[tvCBEEntIndex];
                     if not VarIsNull(TempVar) then
                        begin
                           tempstr := TempVar;
                           slimall(tempstr);
                           zEnt[1,FocusedRecordIndex+1] := tempstr;
                        end;
                  end;

               zUse[1,FocusedRecordIndex+1] := True;
               zGen[1,FocusedRecordIndex+1] := strtoint(InputGridCell[tvCBENomIndex]);
               if length(CustSuppAccount) > 0 then ZAccount[1] := strtoint(CustsuppAccount);

               TempVar := InputGridCell[tvCBENomDescIndex];
               if not VarIsNull(TempVar) then
                  begin
                     tempstr := TempVar;
                     slimall(tempstr);
                     zDesc[1,FocusedRecordIndex+1] := tempstr;
                  end;

               if Preferences.ValueAsBoolean[cPref_AllowFreeTextForNominalDescriptionColumn] then
                  begin
                     TempVar := InputGridCell[tvCBENomFreeEntryDescIndex];
                     if not VarIsNull(TempVar) then
                        begin
                           tempstr := TempVar;
                           slimall(tempstr);
                           zDesc[1,FocusedRecordIndex+1] := tempstr;
                        end;
                  end;

               TempVar := InputGridCell[tvCBEQtyIndex];
               if not VarIsNull(TempVar) then
                  begin
                     tempstr := TempVar;
                     slimall(tempstr);
                     try
                        TempStr := FormatFloat(cDefaultCurrencyFormat, StrToFloat(TempStr));
                     except
                        TempStr := cEmptyCurrencyValue;
                     end;
                     StrLong(TempStr,ZQty[1,FocusedRecordIndex+1]);
                  end;

               TempVar := InputGridCell[tvCBEQuantity2];
               if not VarIsNull(TempVar) then
                  begin
                     tempstr := TempVar;
                     slimall(tempstr);
                     try
                        TempStr := FormatFloat(cDefaultCurrencyFormat, StrToFloat(TempStr));
                     except
                        TempStr := cEmptyCurrencyValue;
                     end;
                     StrLong(TempStr,ZQTY2[1,FocusedRecordIndex+1]);
                  end;

               TempVar := InputGridCell[tvCBEQuantity3];
               if not VarIsNull(TempVar) then
                  begin
                     tempstr := TempVar;
                     slimall(tempstr);
                     try
                        TempStr := FormatFloat(cDefaultCurrencyFormat, StrToFloat(TempStr));
                     except
                        TempStr := cEmptyCurrencyValue;
                     end;
                     StrLong(TempStr,ZQTY3[1,FocusedRecordIndex+1]);
                  end;

               TempVar := InputGridCell[tvCBEAmtIndex];
               if not VarIsNull(TempVar) then
                  begin
                     tempstr := TempVar;


                     try
                        TempStr := FormatFloat(cDefaultCurrencyFormat, StrToFloat(TempStr));
                        if ( TempStr<>'' ) and ( TempStr[1] = '-' ) then
                           TempStr := Copy(TempStr, 2, MaxInt) + '-';
                     except
                        TempStr := cEmptyCurrencyValue;
                     end;
                     StrLong(tempstr,ZAmt[1,FocusedRecordIndex+1]);
                  end;

               TempVar := InputGridCell[tvCBERefIndex];
               if not VarIsNull(TempVar) then
                  ZRef[1] := TempVar;

               if not cash11.Xuse_vat then
                  begin
                     TempVar := InputGridCell[tvCBEVATCodeIndex];
                     if not VarIsNull(TempVar) then
                        ZTax[1,FocusedRecordIndex+1] := TempVar;

                     TempVar := InputGridCell[tvCBEVATIndex];
                     if not VarIsNull(TempVar) then
                        begin
                           tempstr := TempVar;
                           try
                              TempStr := FormatFloat(cDefaultCurrencyFormat, StrToFloat(TempStr));
                              if ( TempStr<>'' ) and ( TempStr[1] = '-' ) then
                                 TempStr := Copy(TempStr, 2, MaxInt) + '-';
                           except
                              TempStr := cEmptyCurrencyValue;
                           end;
                           StrLong(tempstr,ZTaxAmt[1,FocusedRecordIndex+1]);
                        end
                  end
               else
                  begin
                     if (not GEditing) then
                        ZTax[1,FocusedRecordIndex+1] := 'Z';
                  end;

               TempVar := InputGridCell[tvCBEAnalysisCode];
               if (not VarIsNull(TempVar)) and (TempVar <> '') then
                  zAnalysis[1,FocusedRecordIndex+1] := TempVar
               else
                  zAnalysis[1,FocusedRecordIndex+1] := 0;
            end;
      end;
   CheckEnd;
end;

function TFMainscreen.LoadtransactionDetails : boolean;
          // TGM AB 07/08/02 this function loads simplfied transaction details into the
          // inputgrid (Editing)
var
   RecordIndex : integer; // inputgrid row
   tempstr : shortstring;
   templong : long;
   templocation : integer;
   nRowCount : Integer;
begin

   Result := True;
   nRowCount := Transaction_RowCount;
   if ( nRowCount > 0 )  then
      InputTransGrid.Height := GetCBEEntryDefaultHeight;

   if PROG = CASHINC then
      cbTransTypeGroup.ItemIndex := 0
   else
      cbTransTypeGroup.ItemIndex := 1;

   with InputTransGridTableView.DataController do
      try
         RecordCount := nRowCount;

         for RecordIndex := 0 to nRowCount-1 do
            begin
               FocusedRecordIndex := RecordIndex;


               InputGridCell[tvCBECustSuppIndex] := ZComm[1];
               BankAccountNumber := IntToStr(ZBank[1]);
               beBankAccount.Text := GetAccountName ( NLFile, ZBank[1],1);

               Tempstr := IntToStr(ZStub[1]);
               PadZero ( TempStr, 8 );
               InputGridCell[tvCBEStubIndex] := Tempstr;

               KDateToStr ( zTxDate[1], TempStr );
               InputGridCell[tvCBEDateIndex] := Tempstr;

               if not cash11.xuse_enterprise then begin
                  InputGridCell[tvCBEEntIndex] := zEnt[1,RecordIndex+1];
               end;

               CustSuppAccount := IntToStr(ZAccount[1]);

               InputGridCell[tvCBENomIndex] := IntToStr(zGen[1,RecordIndex+1]);
               InputGridCell[tvCBENomDescIndex] := zDesc[1,RecordIndex+1];

               // We need to store the orginal Nom Desc just in case we need to restore it
               // due to an invalid nominal selection during edit.
               InputGridCell[tvCBENomFreeEntryDescIndex] := InputGridCell[tvCBENomDescIndex];

               LongStr(ZQty[1,RecordIndex+1],tempstr,'L');
               InputGridCell[tvCBEQtyIndex] := tempstr;

               LongStr(ZQty2[1,RecordIndex+1],tempstr,'L');
               InputGridCell[tvCBEQuantity2] := tempstr;

               LongStr(ZQty3[1,RecordIndex+1],tempstr,'L');
               InputGridCell[tvCBEQuantity3] := tempstr;

               LongStr(ZAmt[1,RecordIndex+1],tempstr,'L');
               InputGridCell[tvCBEAmtIndex] := tempstr;

               InputGridCell[tvCBEVATCodeIndex] := ZTax[1,RecordIndex+1];
               InputGridCell[tvCBERefIndex] := ZRef[1];
               if not cash11.Xuse_vat then
                  begin
                     LongStr(ZTaxAmt[1,RecordIndex+1], Tempstr,'L');
                     InputGridCell[tvCBEVATIndex] := tempstr;
                  end;

               InputGridCell[tvCBEAnalysisCode] := zAnalysis[1,RecordIndex+1];
            end;
      finally
         SetInputGridHeight();
         FocusedRecordIndex := 0;
      end;
end;

Procedure TFMainScreen.CheckVATForChanges();
Var
   ThisRow : Integer;
   TempVATCode,
   TempVAT,
   TempStr,
   TempLong,
   TempAmt    : ShortString;
   NomAmt,
   VatAmt     : Long;
   VatArrPos  : Integer;
   IsExclusive,
   Allowed    : Boolean;
   Row : integer;
   nFocusedRecordIndex : Integer;
   ss : ShortString;
   Value : Variant;
Begin   // BEGIN CheckVATForChanges

   TempVATCode := '';
   NomAmt := 0;
   VATAmt := 0;

   with InputTransGridTableView.DataController do
      begin
         PostEditingData();

         nFocusedRecordIndex := FocusedRecordIndex+1;
         if ( tvCBEVATCodeIndex>-1 ) then
            begin
               TempVar := InputGridCell[tvCBEVATCodeIndex];
               if not VarIsNull(TempVar) then
                  begin
                     TempVATCode := TempVar;
                     SlimAll ( TempVATCode );
                  end;
            end;

         if ( tvCBEAmtIndex > -1 ) then
            begin
               TempVar := InputGridCell[tvCBEAmtIndex];
               if not VarIsNull(TempVar) then
                  begin
                     TempAMT := VarToStr(TempVar);
                     ChangeToLong ( TempAMT );
                     SlimAll ( TempAMT );
                     StrLong ( TempAMT, NomAmt );
                  end;
            end;

         if ( tvCBEVATIndex > -1 ) then
            begin
               TempVar := InputGridCell[tvCBEVATIndex];
               if not VarIsNull(TempVar) then
                  begin
                     TempVAT := TempVar;
                     SlimAll ( TempVAT );
                     StrLong ( TempVAT, VATAmt );
                  end;
            end;

         Allowed := TRUE;
         // If you are editing the Transaction and the Code has been changed
         if (( GEditing ) and( ZTAXAMT[2,nFocusedRecordIndex] = 0 ) and ( TempVATCode <> ZTAX[2,nFocusedRecordIndex] )) then
             begin
                if (( ZTAX[2,nFocusedRecordIndex] = Cash1.XTAXIDS[0] ) And ( Cash2.xCountry = 2 )) Or
                   ((( ZTAX[2,nFocusedRecordIndex] = Cash1.XTAXIDS[0] ) Or
                     ( ZTAX[2,nFocusedRecordIndex] = Cash1.XTAXIDS[1] )) And
                     ( Cash2.XCOUNTRY = 1 )) then
                     Allowed := TRUE
                else
                   Allowed := FALSE;
             end;

          if NOT Allowed then
             begin
                if ( tvCBEVATCodeIndex > -1 ) then
                    InputGridCell[tvCBEVATCodeIndex] := ZTAX[2,nFocusedRecordIndex];
                MessageDLG('Cannot alter this VAT code - zero the transaction and re-enter a NEW transaction',mtWarning,[mbOK],0);
             end
          else
             begin
                if ((TempVATCode = '') or ( TempVATCode = 'Z' )) then
                   begin
                      if ( tvCBEVATIndex > -1 ) then
                         InputGridCell[tvCBEVATIndex] := 0;
                      Exit;
                   end;

                if ( NewListBox.CheckVAT ( TempVATCode, VATArrPos )) then
                   begin
                      NewListBox.CalcTax ( VATArrpos, TempStr, VatAmt, NomAmt, IsExclusive );
                      LongStr ( VatAmt, TempLong, 'L' );
                      InputGridCell[tvCBEVATIndex] := TempLong;
                      LongStr ( NomAmt, TempLong, 'L' );
                      if ( NomAmt <> 0 ) then
                         InputGridCell[tvCBEAmtIndex] := TempLong;
                   end;
                InputGridCell[tvCBEVatCalculatedIndex] := 'true';
             end;
      end;
end; // END CheckVATForChanges

function TFMainscreen.RowOK (Row : LongInt) : Integer;
var
   Nominal, Amount, VAT, VATCode, DateCell : Integer;
begin
   Result    := -1;
   TempVar := InputTransGridTableView.DataController.Values[ Row, tvCBEDateIndex ];
   if VarIsNull(TempVar) then
      Result := tvCBEDateIndex
   else if TestGridCell( TempVar ) then
      Result := tvCBEDateIndex;

   if Result <> -1 then Exit;

   TempVar := InputTransGridTableView.DataController.Values[ Row, tvCBENomIndex ];
   if VarIsNull(TempVar) then
      Result := tvCBENomIndex
   //   16/11/18 [V4.3 R2.8] /MK Bug Fix - Don't allow a zero nominal code to be saved - Scott Mernagh.
   else if ( TempVar = '0' ) then
      Result := tvCBENomIndex
   else if TestGridCell( TempVar ) Then
      Result := tvCBENomIndex;

   if Result <> -1 then Exit;

   TempVar := InputTransGridTableView.DataController.Values[ Row, tvCBEAmtIndex ];
   if VarIsNull(TempVar) then
      Result := tvCBEAmtIndex
   else if TestGridCell( TempVar ) Then
      Result := tvCBEAmtIndex;

   if Result <> -1 then Exit;

   if (not cash11.Xuse_vat) then
      begin
         TempVar := InputTransGridTableView.DataController.Values[ Row, tvCBEVATCodeIndex ];
         if VarIsNull(TempVar) then
            Result := tvCBEVATCodeIndex
         else if TestGridCell( TempVar ) then
            Result := tvCBEVATCodeIndex;

         if Result <> -1 then Exit;

         TempVar := InputTransGridTableView.DataController.Values[ Row, tvCBEVATIndex ];
         if VarIsNull(TempVar) then
            Result := tvCBEVATIndex
         else if  TestGridCell( TempVar ) then
            Result := tvCBEVATIndex;

         if Result <> -1 then Exit;
      end;
   //RowOK := ( Nominal ) And ( Amount ) And ( VAT ) And ( VATCode ) And ( DateCell );
end;


procedure TFMainScreen.BankAccountKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if Key = VK_F2 then BankListBtnClick(self);
end;

procedure TFMainScreen.TransactionEdit;
var
   i, rowcount : integer;
   NoPresented : Boolean;
   VatUsed : boolean;
   TxNo : Integer;
   IsCashBookTrans : boolean;
begin
   gbCBEHeaderPanel.Caption := 'Enter Cashbook Transaction';

   // load the transactions into the variables ready to be read out
   If ( TxEditRec.TransF{CurrTrans} > 0 ) {And ( Editing )} Then
      begin
         RowCount := 0;
         VatUsed  := False;
         InitialiseTransPointers;
         try
            Initvals;

            // Set Temp Bool to TRUE
            NoPresented := LoadTrans;  // Load the transaction

            if (AccsDataModule.IsVATProcessed(TxEditRec)) then
               MessageDlg('The VAT on this transaction has been processed.',mtWarning,[mbOk],0);

            if NOT NoPresented then
               begin
                  ShowMessage('Transaction presented - You must unpresent it before editing');
                  GEditing := False;
                  Exit;
               end;

            RowCount := Transaction_RowCount;

            if cash11.xuse_vat then
               for I:= 1 to 100 do
                  if ((lowercase(zTax[1,i]) <> 'z') and (lowercase(zTax[1,i]) <> ' ')) then
                     begin
                        VatUsed := True;
                        Break;
                     end;

            TempVar := TransGridCell[tvEditingIndex];
            if not VarIsNull(TempVar) then
               actSaveCBInput.Enabled := ( TempVar = 'T' )
            else
               begin
                  MessageDlg(Format(cFieldReadError,['Journal Transaction']),mtError,[mbOK],0);
                  Exit;
               end;

            //   17/01/12 [V4.1 R1.2] /MK Change - TransactionEdit - If IsCashBookTrans Then Load Data To Grid. If Not Show Cashbook Or BankAct Form.
            IsCashBookTrans := (TxWrite.EDType in [11,15]);

            if ( (not VatUsed) and (RowCount > 0) and (IsCashBookTrans) ) then
               begin
                  LoadTransactionDetails;             // fill in simple grid

                  TempVar := TransGridCell[tvTxNoIndex];
                  if not VarIsNull(TempVar) then
                     begin
                        TxNo := TempVar;
                        gbCBEHeaderPanel.Caption := Format('Editing Cashbook Transaction - [%d]', [TxNo]);
                     end;
               end
            else
               begin
                  try
                     Application.CreateForm(TCashBookForm, CashBookForm );
                     CashBook.CashBookForm.Save.Enabled := actSaveCBInput.Enabled;
                     CashBook.CashBookForm.ShowModal;
                  except
                     MessageDlg('Error creating Cashbook Form - close program and reboot.',mtError,[mbOK],0);
                  end;
               end;

            try
               InputTransGrid.SetFocus;
               if (InputTransGridTableView.DataController.RecordCount > 0) then
                  begin
                     InputTransGridTableView.DataController.FocusedRowIndex := 0;
                     InputTransGridTableView.Controller.FocusedColumnIndex := 0;
                  end;
            except
            end;

         finally
            //if ( IsCashBookTrans ) then
            DisposeTransPointers;
         end;  // rowcount = 1
   end; // if transf ...
end;

function TFMainScreen.IsVatCodeInclusive(RowNumber : Integer): Boolean;
var
   vatcode : string[1];
   vat_type : char;
   i: integer;
begin
   result := false;
   InclusiveVatRate := 0;

   if ( tvCBEVATCodeIndex > -1 ) then
      begin
         TempVar := InputTransGridTableView.DataController.Values[RowNumber, tvCBEVATCodeIndex];
         if not VarIsNull(TempVar) then
            begin
               vatcode := copy(TempVar,1,1);
               for i:= 0 to 9 do begin
                   if Cash1.xtaxids[i] = vatcode then begin
                                                 vat_type := Cash2.xtaxTypes[i];
                                                 InclusiveVatRate := (Cash1.xTaxRates[i] / 100);
                                                 end;
               end;
               if vat_type = 'I' then result := true;
           end;
      end;
end;

Procedure TFMainscreen.CheckNumericColumns(const ARowIndex : Integer);
var
   TempStr : ShortString;
begin

   if InputTransGridTableView.DataController.FocusedRecordIndex <> ARowIndex then
      InputTransGridTableView.DataController.FocusedRecordIndex := ARowIndex;

   TempVar := InputGridCell[tvCBEQtyIndex];
   if not VarIsNull(TempVar) then
      begin
         TempStr := TempVar;
         if TempStr <> '' then
            begin
               SlimAll ( TempStr );
               try
                  ChangeToLong ( TempStr );
               except
                  TempStr := '';
               end;
               InputGridCell[tvCBEQtyIndex] := TempStr;
            end
      end;

   TempVar := InputGridCell[tvCBEAmtIndex];
   if not VarIsNull(TempVar) then
      begin
         TempStr := TempVar;
         if TempStr <> '' then
            begin
               SlimAll ( TempStr );
               try
                  ChangeToLong ( TempStr );
               except
                  TempStr := '';
               end;
               InputGridCell[tvCBEAmtIndex] := TempStr;
            end;
      end;

   if ( tvCBEVATIndex > -1 ) then
      begin
         TempVar := InputGridCell[tvCBEVATIndex];
         if not VarIsNull(TempVar) then
            begin
               TempStr := TempVar;
               if TempStr <> '' then
                  begin
                     SlimAll ( TempStr );
                     try
                        ChangeToLong ( TempStr );
                     except
                        TempStr := '';
                     end;
                     InputGridCell[tvCBEVATIndex] := Tempstr;
                  end;
            end;
      end;

end;

procedure TFMainScreen.bBudgetsClick(Sender: TObject);
begin
   TfmBudgets.ShowBudget;
end;

Procedure TFMainScreen.SETVALS;
Begin
End;

procedure TFMainScreen.EnterPaymentBtnClick(Sender: TObject);
var
   SupplierID : Integer;
begin
     // cashbook payment routine
     SupplierID := 0;
     AccsDataModule.GetPurchaseLedgerAccs;
     AccsDatamodule.PurchaseLedger.open;
     AccsDataModule.ImportDefaults.Open;
     if not AccsDataModule.ImportDefaults.Locate('UseAsDefault',TRUE,[]) then begin
         showmessage('No CoOp Selected. Please Use Select CoOp under Read Disk to select your CoOp');
     end
        else begin
                  If AccsDataModule.PurchaseLedger.locate('Account',accsDataModule.Importdefaults['DefaultAccount'],[]) then begin
                  SupplierID := accsdatamodule.purchaseLedger['Account'];
                  end;
                  if SupplierID = 0 then begin
                     showmessage('No CoOp Selected. Please Use Select CoOp under Read Disk to select your CoOp');
                  end
                     else begin
                          try Application.CreateForm(TCashBookForm, CashBookForm );
                          except
                          end;
                          CashBookForm.SalesPurchDB := PLFile;
                          CashBookForm.Save.Enabled := True;
                          CashbookForm.CashbookImportPayment := True;
                          GEditing := False;
                          PROG := PURCHTX;
                          ACT := 3;

                          CashbookForm.CustSuppCode.text := vartostr(SupplierID);
                          CashbookForm.CustSuppCode.enabled := False;
                          CashbookForm.Listaccounts.visible := False;
                          CashbookForm.SalesPurchaseGroup.visible := False;
                          Cashbookform.caption := 'Entering CoOp Payments';
                          CashBookForm.Showmodal;
                          CashbookForm.CashbookImportPayment := False;
                  end;
        end;
end;

procedure TFMainScreen.Button4Click(Sender: TObject);
begin
      if cash11.xbilling = false then begin
                                      cash11.Xbilling := true;
                                      end
        else begin
             cash11.xbilling := false;
             end;
      defwrite(11);
      setupinterface;

end;

procedure TFMainScreen.UpdateModules;
var
    Modules : String[6];
    iCurVerNo : Integer;
    {
    6 Binary Digits, 1 - On, 0 - Off
    1 - Cashbook
    2 - Ents
    3 - Vat
    4 - Ledgers
    5 - Billing
    6 - Invoicer
    }
begin
    if uppercase(RFarmGate.PLocation[2]) <> 'DEMO' then
       begin
          Modules := '000000';
          if cash1.Xcashbook = true then Modules[1] := '1';
          if cash11.Xuse_enterprise = false then Modules[2] := '1';
          if cash11.XUse_Vat = false then Modules[3] := '1';
          if Cash1.xcashbook = false  then Modules[4] := '1';
          if cash11.xbilling = false then Modules[5] := '1';
          if ((cash2.XWININV = true) or (Invoicer)) then Modules[6] := '1';
          AccsDataModule.RegAccsModules := Modules;

          iCurVerNo := 0;
          iCurVerNo := StrToInt(ShortVerNo);
          if ( (AccsDataModule.RegAccsVerNo = 0) or ((AccsDataModule.RegAccsVerNo > 0) and (iCurVerNo > 0)) ) and
             ( AccsDataModule.RegAccsVerNo < iCurVerNo ) then
                begin
                   AccsDataModule.RegAccsVerNo := StrToInt(ShortVerNo);
                   //   25/05/20 [V4.5 R2.1] /MK Additional Feature - Store new version number and date downloaded in AccsDefaults table. 
                   AccsDataModule.AccsDefaultsUpdateNo := StrToInt(ShortVerNo);
                   AccsDataModule.AccsDefaultsLastUpdateDate := Now;
                end;
       end;
end;

procedure TFMainScreen.SetupTransactionGrid;
var
   cxDataSummaryItem : TcxDataSummaryItem;
begin
   tvTxNoIndex := -1;
   tvDateIndex := -1;
   tvRefIndex :=  -1;
   tvCommentStubNoIndex := -1;
   tvVATorDiscountIndex := -1;
   tvAmountIndex := -1;
   tvCustomerSupplierIndex := -1;
   tvTransTypeIndex := -1;
   tvJourTransIndex := -1;
   tvEditingIndex := -1;
   tvCoOpComment := -1;

   with TransactionGridTableView do
      begin
         DataController.Options := [dcoAnsiSort, dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoFocusTopRowAfterSorting, dcoImmediatePost];

         OptionsCustomize.ColumnMoving := False;
         OptionsCustomize.ColumnsQuickCustomization := False;

         OptionsData.CancelOnExit := False;
         OptionsData.Deleting := False;
         OptionsData.DeletingConfirmation := False;
         OptionsData.Editing := False;
         OptionsData.Inserting := False;

         OptionsSelection.CellSelect := False;

         OptionsView.HeaderHeight := 42;
         OptionsView.DataRowHeight := 24;
         OptionsView.Footer := False;
         OptionsView.GridLines := glHorizontal;
         OptionsView.Indicator := True;

         Styles.GroupByBox := cxStyleGroupByBox;

         ClearItems;

         with CreateColumn do
            begin
               Caption := 'TX No.';
               Name := 'TxNo';
               DataBinding.ValueTypeClass := TcxIntegerValueType;
               HeaderAlignmentHorz := taCenter;
               HeaderAlignmentVert := vaCenter;
               PropertiesClass := TcxTextEditProperties;
               with TcxTextEditProperties(Properties) do
                  begin
                     Alignment.Vert := taVCenter;
                  end;
               Width := 85;
               tvTxNoIndex := Index;
               Visible := True;
               Hidden := False;
               Styles.Content := cxStyleTransGridRow;
               Options.Filtering := False;
            end;

         with CreateColumn do
            begin
               Caption := 'Date';
               Name := 'Date';
               DataBinding.ValueTypeClass := TcxDateTimeValueType;
               HeaderAlignmentHorz := taCenter;
               HeaderAlignmentVert := vaCenter;
               PropertiesClass := TcxTextEditProperties;
               with TcxDateEditProperties(Properties) do
                  begin
                     Alignment.Vert := taVCenter;
                  end;
               Width := 95;
               tvDateIndex := Index;
               Styles.Content := cxStyleTransGridRow;
            end;

         with CreateColumn do
            begin
               if cash1.XCASHBOOK then
                  begin
                     Caption := 'Stub No.';
                     Width := 95;
                     //Visible := Preferences.ValueAsBoolean[cPref_ShowStubNoColumn];
                  end
               else
                  begin
                     Width := 165;
                     Caption := 'Comment / Stub No.';
                  end;
               Name := 'CommentStubNo';
               DataBinding.ValueTypeClass := TcxStringValueType;
               HeaderAlignmentHorz := taCenter;
               HeaderAlignmentVert := vaCenter;
               PropertiesClass := TcxTextEditProperties;
               with TcxTextEditProperties(Properties) do
                  begin
                     Alignment.Vert := taVCenter;
                  end;

               tvCommentStubNoIndex := Index;
               Styles.Content := cxStyleTransGridRow;
            end;

         with CreateColumn do
            begin
               Caption := 'Customer / Supplier';
               Name := 'CustomerSupplier';
               DataBinding.ValueTypeClass := TcxStringValueType;
               HeaderAlignmentHorz := taCenter;
               HeaderAlignmentVert := vaCenter;
               PropertiesClass := TcxTextEditProperties;
               with TcxTextEditProperties(Properties) do
                  begin
                     Alignment.Vert := taVCenter;
                  end;
               Width := 210;

               tvCustomerSupplierIndex := Index;
               Styles.Content := cxStyleTransGridRow;
            end;

         with CreateColumn do
            begin
               if cash1.XCASHBOOK then
                  begin
                     Caption := 'Comment'; // changed, as cashbook users cannot relate to Reference Column should be left in Ledgers - at request of GL 1/3/2010
                     Width := 210;
                  end
              else
                 begin
                    Caption := 'Reference';
                    Width := 125;
                 end;
               Name := 'Ref';
               DataBinding.ValueTypeClass := TcxStringValueType;
               HeaderAlignmentHorz := taCenter;
               HeaderAlignmentVert := vaCenter;
               PropertiesClass := TcxTextEditProperties;
               with TcxTextEditProperties(Properties) do
                  begin
                     Alignment.Vert := taVCenter;
                  end;

               tvRefIndex := Index;
               Styles.Content := cxStyleTransGridRow;
            end;

         with CreateColumn do
            begin
               Caption := 'Amount';
               Name := 'Amount';
               DataBinding.ValueTypeClass := TcxFloatValueType;
               HeaderAlignmentHorz := taCenter;
               HeaderAlignmentVert := vaCenter;
               Width := 95;

               PropertiesClass := TcxCurrencyEditProperties;
               with TcxCurrencyEditProperties(Properties) do
                  begin
                     DisplayFormat := cDefaultCurrencyFormat;
                     Alignment.Horz := {taCenter }taRightJustify;
                     Alignment.Vert := taVCenter;
                  end;
               tvAmountIndex := Index;
               Styles.Content := cxStyleTransGridRow;
            end;

         with CreateColumn do
            begin
               Caption := 'VAT /'+ cCRLF + 'Discount';
               Name := 'VATorDiscount';
               DataBinding.ValueTypeClass := TcxFloatValueType;
               HeaderAlignmentHorz := taCenter;
               HeaderAlignmentVert := vaCenter;
               Width := 95;

               PropertiesClass := TcxCurrencyEditProperties;
               with TcxCurrencyEditProperties(Properties) do // typecast to Currency edit, to set Display format.
                  begin
                     DisplayFormat := cDefaultCurrencyFormat;
                     Alignment.Horz := {taCenter }taRightJustify;
                     Alignment.Vert := taVCenter;
                  end;
               tvVATorDiscountIndex := Index;
               Visible := True;
               Hidden := False;
               Styles.Content := cxStyleTransGridRow;
            end;

         with CreateColumn do
            begin
               HeaderAlignmentHorz := taCenter;
               HeaderAlignmentVert := vaCenter;
               Caption := 'Bank Account';
               Name := 'NominalName';
               DataBinding.ValueTypeClass := TcxStringValueType;
               PropertiesClass := TcxTextEditProperties;
               with TcxTextEditProperties(Properties) do
                  begin
                     Alignment.Vert := taVCenter;
                  end;
               Width := 150;
               Hidden := False;
               Visible := True;
               tvNominalIndex := Index;
               Styles.Content := cxStyleTransGridRow;
            end;

         with CreateColumn do
            begin
               Caption := 'Trans Type';
               Name := 'TransType';
               DataBinding.ValueTypeClass := TcxStringValueType;
               HeaderAlignmentHorz := taCenter;
               HeaderAlignmentVert := vaCenter;
               PropertiesClass := TcxTextEditProperties;
               with TcxTextEditProperties(Properties) do
                  begin
                     Alignment.Vert := taVCenter;
                  end;
               Width := 165;

               tvTransTypeIndex := Index;
               Visible := True;
               Styles.Content := cxStyleTransGridRow;
            end;
{
         with CreateColumn do
            begin
               Caption := 'Analysis Code';
               Name := 'Analysis';
               DataBinding.ValueTypeClass := TcxStringValueType;
               HeaderAlignmentHorz := taCenter;
               HeaderAlignmentVert := vaCenter;
               PropertiesClass := TcxTextEditProperties;
               with TcxTextEditProperties(Properties) do
                  begin
                     Alignment.Vert := taVCenter;
                  end;
               Width := 125;

               tvAnalysisCode := Index;
               Visible := True;
               Styles.Content := cxStyleTransGridRow;
            end;
}

         with CreateColumn do
            begin
               Name := 'CoOpComment';
               Caption := 'Co-Op Comment';
               DataBinding.ValueTypeClass := TcxStringValueType;
               HeaderAlignmentHorz := taCenter;
               HeaderAlignmentVert := vaCenter;
               PropertiesClass := TcxTextEditProperties;
               with TcxTextEditProperties(Properties) do
                  begin
                     Alignment.Vert := taVCenter;
                  end;
               Width := 125;
               Hidden := False;
               tvCoOpComment := Index;
               Styles.Content := cxStyleTransGridRow;
            end;

         with CreateColumn do
            begin
               Name := 'JourTrans';
               DataBinding.ValueTypeClass := TcxStringValueType;
               Width := 0;
               Hidden := True;
               Visible := False;
               tvJourTransIndex := Index;
               Styles.Content := cxStyleTransGridRow;
            end;

         with CreateColumn do
            begin
               Name := 'Editing';
               DataBinding.ValueTypeClass := TcxStringValueType;
               Width := 0;
               Hidden := True;
               Visible := False;
               tvEditingIndex := Index;
               Styles.Content := cxStyleTransGridRow;
            end;

         with CreateColumn do
            begin
               Name := 'TxType';
               DataBinding.ValueTypeClass := TcxIntegerValueType;
               Width := 0;
               Hidden := True;
               Visible := False;
               tvTxTypeIndex := Index;
               Styles.Content := cxStyleTransGridRow;
            end;

         with CreateColumn do
            begin
               Name := 'OrigType';
               DataBinding.ValueTypeClass := TcxIntegerValueType;
               Width := 0;
               Hidden := True;
               Visible := False;
               tvOrigTypeIndex := Index;
               Styles.Content := cxStyleTransGridRow;
            end;

         cxDataSummaryItem := TransactionGridTableView.DataController.Summary.FooterSummaryItems.Add;
         with ( cxDataSummaryItem as TcxGridTableSummaryItem ) do
            begin
               Format := 'Total: #';
               Kind := skCount;
               Column := TcxGridColumn(TransactionGridTableView.FindItemByID(tvTxNoIndex));
               Font.Name := 'Segoe UI';
               Font.Size := 9;
            end;
          //  end;
      end;

{   if FileExists( IncludeTrailingBackslash( AppDir ) + cTransGridIniFile) then
      begin
         TransactionGridTableView.RestoreFromIniFile(IncludeTrailingBackslash( AppDir ) + cTransGridIniFile);
      end;
}
end;

procedure TFMainScreen.actPrintExecute(Sender: TObject);
begin
   if not(dxTransactionGridPrinterLink.PreviewExists) then
      dxTransactionGridPrinterLink.Preview;
end;

procedure TFMainScreen.actClearSearchExecute(Sender: TObject);
begin
   ShowSearchBar(False);
   ClearSearch;
end;

procedure TFMainScreen.actSearchTransactionsExecute(Sender: TObject);
begin
   ShowSearchbar(True);
end;

procedure TFMainScreen.actHelpExecute(Sender: TObject);
begin
   Application.HelpContext(222);
end;

procedure TFMainScreen.actSalesExecute(Sender: TObject);
begin
   if ( not(MenuBarCanExecute) ) then SysUtils.Abort;
   Application.CreateForm(TCashBookForm, CashBookForm );
   CashBook.CashBookForm.SalesPurchDB := SLFile;
   CashBook.CashBookForm.Save.Enabled := True;
   GEditing := False;
   PROG := SALESTX;
   ACT := 1;       { Invoice }
   CashBookForm.ShowModal;
end;

procedure TFMainScreen.actPurchaseExecute(Sender: TObject);
begin
   if ( not(MenuBarCanExecute) ) then SysUtils.Abort;
   Application.CreateForm(TCashBookForm, CashBookForm );
   CashBook.CashBookForm.SalesPurchDB := PLFile;
   CashBook.CashBookForm.Save.Enabled := True;
   GEditing := False;
   PROG := PURCHTX;
   ACT := 1;       { Invoice }
   CashBookForm.ShowModal;
end;

procedure TFMainScreen.actBankExecute(Sender: TObject);
begin
   if ( not(MenuBarCanExecute) ) then SysUtils.Abort;
   Application.CreateForm(TBankActivities, BankActivities );
   GEditing := False;
   BankAct.BankActivities.ShowModal;
end;

procedure TFMainScreen.actOtherExecute(Sender: TObject);
begin
   if ( not(MenuBarCanExecute) ) then SysUtils.Abort;
   GEditing := False;
   OthForm.OthersForm.ShowModal;
end;

procedure TFMainScreen.actCashbookExecute(Sender: TObject);
begin
   if ( not(MenuBarCanExecute) ) then SysUtils.Abort;
   Application.CreateForm(TCashBookForm, CashBookForm );
   CashBook.CashBookForm.SalesPurchDB := 0;
   CashBook.CashBookForm.Save.Enabled := True;
   GEditing := False;
//     PROG := CASHINC;
   PROG := CASHEXP;
     // TGM AB 19/02/02 If statement added below, used to specify transaction
   // Type (income or Expenditure) when using parameters

   if param_start then begin
                       if param_type = 'P' then begin
                                                PROG := CASHEXP;
                                                end;
                       if param_type = 'S' then begin
                                                PROG := CASHINC;
                                                end;
                       end;
   ACT  := 0;
   CashBookForm.ShowModal;

end;

procedure TFMainScreen.actExitExecute(Sender: TObject);
begin
   Close;
end;

procedure TFMainScreen.CloseGracefully;
var
    SearchRec : TSearchRec;
    SearchResult : boolean;
    FileCount,i : integer;
    Position : real;
    SPosition : string;
begin
 //     DataExport.CompleteExport;
   FFormShowing := False;
   accsdatamodule.CloseAllFiles;
   FileCount := 1;
   i := 1;
   If FCheckName.Networked then begin // network
      ProgressPanel.visible := true;
      FindFirst('c:\kingsacc\' + FCheckName.CheckCompanyName.Text + '\*.*', faAnyFile, SearchRec); // NETWORK
      repeat
            Inc(FileCount);
      until (FindNext(SearchRec) <> 0);

      FindFirst('c:\kingsacc\' + FCheckName.CheckCompanyName.Text + '\*.*', faAnyFile, SearchRec); // NETWORK
      repeat
            copyFile(PChar('c:\kingsacc\' + FCheckName.CheckCompanyName.Text +'\' + SearchRec.Name), PChar(FCheckName.NetworkPath +'\' + FCheckName.CheckCompanyName.Text +'\' + SearchRec.Name), False);
            ProgressBar1.Max := 100;
            Position:= i/FileCount*100;
            Str(Position :0:0,SPosition);
            Progressbar1.Position := StrToInt(SPosition);
            application.processmessages;
            inc(i);

      until (FindNext(SearchRec) <> 0);
      Progressbar1.Position := StrToInt(SPosition);
      Application.Terminate;
   end;

   if (param_start = true) then
      application.terminate
   else
      Close; // TGM AB 13/03/02
end;

procedure TFMainScreen.actSetupExecute(Sender: TObject);
begin
   CheckCashbookEntryGridState();

   { Create the SetUpAccounts Form }
   Application.CreateForm(TSetUpAccounts, SetUpAccounts);
   SetUpAccounts.ShowModal;
   ceBankBalance.Value := AccsDataModule.GetBankBalance(beBankAccount.Text);
   AccsDataModule.Accounts.Refresh;
end;

procedure TFMainScreen.actReportExecute(Sender: TObject);
begin
   CheckCashbookEntryGridState();
   
   // next line sets the lines per page - the main procedures which build the reports use this to determine when to stick in a new page
   // header.
   RFarmGate.PLINESPAGE[1] := 62;
   NewRepForm.ShowModal;
end;

procedure TFMainScreen.actBackupExecute(Sender: TObject);
var
   iFarmgateSerial : LongInt;
begin
   CheckCashbookEntryGridState();
   iFarmgateSerial := PSysLongToDelphi ( RFarmGate.PSerial );
   TfmDataBackup.Execute(daBackup,iFarmgateSerial);
   if AccsDataModule.RestartProgramAfterBackupRestore then Exit;
   LoadTransactionGrid();
end;

procedure TFMainScreen.actSystemExecute(Sender: TObject);
var
   bActiveSalePurchInvs : Boolean;
   sPageName : String;
begin
   HideHint();

   CheckCashbookEntryGridState();

   //   28/08/19 [V4.5 R0.3] /MK Bug Fix - Don't allow open of System screen if data entered into Sale/Purch Invoice grids as Access Violation would appear because grids can be turned on/off in System.
   if ( ViewPageControl.ActivePageIndex = tsSalesInvoice.PageIndex ) or
      ( ViewPageControl.ActivePageIndex = tsPurchaseInvoice.PageIndex ) then
      begin
         if ( ViewPageControl.ActivePageIndex = tsSalesInvoice.PageIndex ) then
            begin
               sPageName := 'Sales';
               bActiveSalePurchInvs := ( SimpleSaleInvoiceFrame.ChangesPending );
            end
         else if ( ViewPageControl.ActivePageIndex = tsPurchaseInvoice.PageIndex ) then
            begin
               sPageName := 'Purchase';
               bActiveSalePurchInvs := ( SimplePurchaseInvoiceFrame.ChangesPending );
            end;
         if ( bActiveSalePurchInvs ) then
            begin
               MessageDlg(Format('Please complete the %s invoice(s) before opening the Settings screen.',[sPageName]),mtError,[mbOK],0);
               Exit;
            end;
      end;

   TfmSysMain.ShowSysMain;

   LoadPreferences;

   UpdateYearOnStatusBar;
end;

procedure TFMainScreen.TransactionGridTableViewDblClick(Sender: TObject);
var
  P: TPoint;
  AHitTest: TcxCustomGridHitTest;
begin
  if (Sender = nil) then Exit;

  GetCursorPos(P);
  P := TcxGridSite(Sender).ScreenToClient(P);
  AHitTest := TcxGridSite(Sender).GridView.ViewInfo.GetHitTest(P);
  if AHitTest is TcxGridRecordHitTest then  //check if double click occurs on grid record
     LoadTransaction();
end;

procedure TFMainScreen.FormCreate(Sender: TObject);
begin
   DoubleBuffered := true;

   FFormShowing := False;
   MainScreenHandle := Handle;

   SetupTransactionGrid;
   ShowSearchBar(False);

   tsAccountActions.Color := clWindow;
   tsReports.Color := clWindow;
   tsMTDVatYearEnd.Color := clWindow;
   tsSimpleVatReports.Color := clWindow;

   FCalculatingVAT := True;

   FGridDesigning := False;
   ProgressBar.Visible := False;
   ProgressBar.Height := 36;
   dxTransactionGridPrinterLink.Component := TransactionGrid;
   cxGridColumn := nil;

   if beBankAccount.Properties.Buttons[0] <> nil then
      begin
         beBankAccount.Properties.Buttons[0].Kind := bkGlyph;
         AccsDataModule.ImageList16x16.GetBitmap(1, beBankAccount.Properties.Buttons[0].Glyph);
      end;

   actDeleteLine.Visible := False;
   dxBarManager.Bars[2].DockControl := dxBarDockControlSearchToolbar;
   dxBarManager.Bars[2].DockedDockControl := dxBarDockControlSearchToolbar;
   bcciTransactionActions.Control := pTransactionActions;
end;

procedure TFMainScreen.LoadPreferences;
begin
   { Transaction Grid - Column Grouping }
//   bPref_Value := Preferences.ValueAsBoolean[cPref_EnableTransGridColumnGrouping];
//   TransactionGridTableView.OptionsCustomize.ColumnGrouping := bPref_Value;
//   TransactionGridTableView.OptionsView.GroupByBox := bPref_Value;
   try
      if cash1.XCASHBOOK then
         begin
            TransactionGridTableView.Columns[tvCommentStubNoIndex].Visible := Preferences.ValueAsBoolean[cPref_ShowStubNoColumn];
            TransactionGridTableView.Columns[tvRefIndex].Visible := Preferences.ValueAsBoolean[cPref_ShowCommentColumn];
            InputTransGridTableView.Columns[tvCBERefIndex].Visible := Preferences.ValueAsBoolean[cPref_ShowCommentColumn];

            if (CashbookTransactionType = ttIncome) then
               begin
                  TransactionGridTableView.Columns[tvCustomerSupplierIndex].Visible := Preferences.ValueAsBoolean[cPref_ShowCustomerColumn];
                  InputTransGridTableView.Columns[tvCBECustSuppIndex].Visible := Preferences.ValueAsBoolean[cPref_ShowCustomerColumn];
               end
            else if (CashbookTransactionType = ttExpense) then
               begin
                  TransactionGridTableView.Columns[tvCustomerSupplierIndex].Visible := Preferences.ValueAsBoolean[cPref_ShowSupplierColumn];
                  InputTransGridTableView.Columns[tvCBECustSuppIndex].Visible := Preferences.ValueAsBoolean[cPref_ShowSupplierColumn];
               end;

            InputTransGridTableView.Columns[tvCBEStubIndex].Visible := Preferences.ValueAsBoolean[cPref_ShowStubNoColumn];
            InputTransGridTableView.Columns[tvCBEAnalysisCode].Visible := Preferences.ValueAsBoolean[cPref_ShowAnalysisCodeColumn];
            InputTransGridTableView.Columns[tvCBEQtyIndex].Visible := Preferences.ValueAsBoolean[cPref_ShowQuantityColumn];
         end
      else
         TransactionGridTableView.Columns[tvCustomerSupplierIndex].Visible := True;

      TransactionGridTableView.Columns[tvCoOpComment].Visible := Preferences.ValueAsBoolean[cPref_EnableCoOpImport];
   except
   end;

   TransactionGridTableView.OptionsCustomize.ColumnGrouping := False;
   TransactionGridTableView.OptionsView.GroupByBox := False;

   btnCoOpImport.Visible := Preferences.ValueAsBoolean[cPref_EnableCoOpImport];
   InputTransGrid.Width := CalcInputGridWidth;
   PositionMenuButtons;
end;

procedure TFMainScreen.SetupCBEntryGrid;
var
   columnIndex, i, gridwidth : integer;
   Tmpstr : Shortstring;

   Bitmap : TBitmap;
   cxDataSummaryItem : TcxDataSummaryItem;

   EditButton : TcxEditButton;
   IncomeExpenseCol, EntCol : TcxGridColumn;
begin
   FGridDesigning := True;
   try
      InputTransGrid.BeginUpdate;

      pMenuButtonPanel.Visible := False;// ensure pMenuButtonPanel is hidden if alternative pSingleLineEntry is visible.

      cbTransTypeGroup.ItemIndex := 1; // default to Purchases
      cbTransTypeGroupPropertiesChange(cbTransTypeGroup); // initialises the program (cashinc / cashexp) fixed bug with first transaction
                                                          // not being initilised to any program
      Prog := CashExp;

      tvCBEDateIndex := -1;
      tvCBEEntIndex := -1;
      tvCBENomDescIndex := -1;
      tvCBEStubIndex := -1;
      tvCBECustSuppIndex := -1;
      tvCBEQtyIndex := -1;
      tvCBEAmtIndex := -1;
      tvCBEVATIndex := -1;
      tvCBEVATCodeIndex := -1;
      tvCBERefIndex := -1;
      tvCBENomIndex := -1;
      tvCBEQuantity2 := -1;
      tvCBEQuantity3 := -1;
      tvCBENomFreeEntryDescIndex := -1;

      with InputTransGridTableView do
         begin
            DataController.Options := [dcoAnsiSort, dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoFocusTopRowAfterSorting, dcoImmediatePost];

            OptionsCustomize.ColumnHiding := False;
            OptionsCustomize.ColumnsQuickCustomization := False;
            OptionsCustomize.ColumnFiltering := False;
            OptionsCustomize.ColumnSorting := False;


            OptionsData.CancelOnExit := False;
            OptionsData.Deleting := False;
            OptionsData.DeletingConfirmation := False;
            OptionsData.Editing := True;
            OptionsData.Inserting := True;

            OptionsSelection.CellSelect := True;

            OptionsView.DataRowHeight := cDefaultCBEGridRowHeight;
            OptionsView.Footer := True;
            OptionsView.GridLines := glBoth;
            OptionsView.HeaderHeight := 26;
            OptionsView.Indicator := True;
            OptionsView.GroupByBox := False;
            OptionsView.ShowEditButtons := gsebNever;

            Styles.GroupByBox := nil;


            ClearItems;


            with CreateColumn do
               begin
                  Caption := 'Date';
                  Name := 'InputDate';
                  DataBinding.ValueTypeClass := TcxDateTimeValueType;
                  HeaderAlignmentHorz := taCenter;
                  HeaderAlignmentVert := vaCenter;
                  Width := 125;
                  PropertiesClass := TcxDateEditProperties;
                  with TcxDateEditProperties(Properties) do
                     begin
                        Alignment.Vert := taVCenter;
                        ImmediatePost := True;
                        SaveTime := False;
                        ShowTime := False;
                        DisplayFormat := 'dd/MM/yy';
                        EditFormat := 'dd/MM/yy';
                        PostPopupValueOnTab := True;
                        UseDisplayFormatWhenEditing := True;

                        AccsDataModule.ImageList16x16.GetBitmap(11, Buttons[0].Glyph);
                        OnCloseUp := MyInputGridDateOnCloseUp;
                        OnEditValueChanged := ThisOnEditValueChanged;

                        OnInitPopup := InputTransGridTableViewCBEDatePropertiesInitPopup;
                        OnKeyDown := InputTransGridTableViewCBEDateKeyDown;
                        Styles.Content := cxStyleCBEntryRow;
                        Name := 'CBEDateEdit';
                     end;
                  tvCBEDateIndex := Index;

               end;

           with CreateColumn do
              begin

                 Caption := 'Stub No.';
                 Name := 'StubNo';
                 DataBinding.ValueTypeClass := TcxStringValueType;
                 HeaderAlignmentHorz := taCenter;
                 HeaderAlignmentVert := vaCenter;
                 Width := 75;
                 tvCBEStubIndex := Index;
//                 Visible := Preferences.ValueAsBoolean[cPref_ShowStubNoColumn];
                        Styles.Content := cxStyleCBEntryRow;
               PropertiesClass := TcxTextEditProperties;
               with TcxTextEditProperties(Properties) do
                  begin
                     Alignment.Vert := taVCenter;
                     OnEditValueChanged := ThisOnEditValueChanged;
                  end;
              end;

            with CreateColumn do
               begin
                  Caption := 'Supplier';
                  Name := 'CustSupp';
                  DataBinding.ValueTypeClass := TcxStringValueType;
                  HeaderAlignmentHorz := taCenter;
                  HeaderAlignmentVert := vaCenter;
                  Width := 160;
                  tvCBECustSuppIndex := Index;
                  PropertiesClass := TcxButtonEditProperties;

                  with TcxButtonEditProperties(Properties) do
                     begin
                        Alignment.Vert := taVCenter;
                        if Caption = 'Supplier' then
                           begin
                              OnButtonClick := SupplierButtonEditClick;
//                              Visible := Preferences.ValueAsBoolean[cPref_ShowSupplierColumn];
                           end
                        else
                           begin
                              OnButtonClick := CustomerButtonEditClick;
//                              Visible := Preferences.ValueAsBoolean[cPref_ShowCustomerColumn];
                           end;

                        OnChange := CBEItemOnChange;
                        OnEditValueChanged := ThisOnEditValueChanged;
                        Buttons[0].Kind := bkGlyph;
                        AccsDataModule.ImageList16x16.GetBitmap(1, Buttons[0].Glyph);
                        Styles.Content := cxStyleCBEntryRow;
                     end;
               end;

//            if not cash11.Xuse_Vat then
//               begin
               with CreateColumn do
                  begin
                     if cash1.XCASHBOOK then
                        begin
                           Caption := 'Comment'; // changed, as cashbook users cannot relate to Reference Column should be left in Ledgers - at request of GL 1/3/2010
//                           Visible := Preferences.ValueAsBoolean[cPref_ShowCommentColumn];
                        end
                     else
                        Caption := 'Reference';
                     Name := 'Reference';
                     DataBinding.ValueTypeClass := TcxStringValueType;
                     HeaderAlignmentHorz := taCenter;
                     HeaderAlignmentVert := vaCenter;

                     Width := 90;
                     tvCBERefIndex := Index;
                        Styles.Content := cxStyleCBEntryRow;
                     PropertiesClass := TcxTextEditProperties;
                     with TcxTextEditProperties(Properties) do
                        begin
                           Alignment.Vert := taVCenter;
                           if (Cash1.XCASHBOOK) then
                              OnEditValueChanged := ThisOnEditValueChanged
                           else
                              OnEditValueChanged := nil;
                           MaxLength := 15; // this is a database constraint!
                        end;
                  end;
//               end;


           IncomeExpenseCol := CreateColumn;
           with IncomeExpenseCol do
              begin
                 Caption := 'Expense Account';
                 Name := 'ExpenseIncome';  // was Nom by default
                 DataBinding.ValueTypeClass := TcxStringValueType;
                 HeaderAlignmentHorz := taCenter;
                 HeaderAlignmentVert := vaCenter;
                 Width := 210;
                 PropertiesClass := TcxButtonEditProperties;
                 with TcxButtonEditProperties(Properties) do
                    begin
                       OnButtonClick := IncomeExpenseButtonEditClick;
                       Buttons[0].Kind := bkGlyph;
                       AccsDataModule.ImageList16x16.GetBitmap(1, Buttons[0].Glyph);
                       OnChange := InputTransGridTableViewNomDescEditValueChanged;
                       Styles.Content := cxStyleCBEntryRow;
                       Alignment.Vert := taVCenter;
                    end;
                 tvCBENomDescIndex := Index;
              end;

            if not cash11.Xuse_enterprise then
               begin
                  EntCol := CreateColumn;
                  with EntCol do
                     begin
                        Caption := 'Enterprise';
                        Name := 'Ent';
                        DataBinding.ValueTypeClass := TcxStringValueType;
                        HeaderAlignmentHorz := taCenter;
                        HeaderAlignmentVert := vaCenter;
                        Width := 70;
                        PropertiesClass := TcxButtonEditProperties;
                        with TcxButtonEditProperties(Properties) do
                           begin
                              Alignment.Vert := taVCenter;
                              OnButtonClick := EntButtonEditClick;
                              Buttons[0].Kind := bkGlyph;
                              AccsDataModule.ImageList16x16.GetBitmap(1, Buttons[0].Glyph);
                              Styles.Content := cxStyleCBEntryRow;
                              OnKeyPress := GridControlKeyPress;
                           end;
                        tvCBEEntIndex := Index;
                     end;

                 // do we need to swap column order around??
                 if (not Preferences.ValueAsBoolean[cPref_AutoEntSelect]) then
                    begin
                       Dec(tvCBEEntIndex);
                       EntCol.Index := tvCBEEntIndex;

                       Inc(tvCBENomDescIndex);
                       IncomeExpenseCol.Index := tvCBENomDescIndex;
                    end;
               end;

           with CreateColumn do
              begin
                 Caption := 'Quantity';
                 Name := 'Qty';
                 DataBinding.ValueTypeClass := TcxFloatValueType;
                 PropertiesClass := TcxCurrencyEditProperties;
                 with TcxCurrencyEditProperties(Properties) do
                    begin
                       Alignment.Horz := taRightJustify;
                       Alignment.Vert := taVCenter;
                       DisplayFormat := cDefaultCurrencyFormat;
                       Styles.Content := cxStyleCBEntryRow;
                       EditButton := Buttons.Add;
                       EditButton.Kind := bkEllipsis;
                       OnButtonClick := QuantityButtonEditClick;
                    end;
                 HeaderAlignmentHorz := taCenter;
                 HeaderAlignmentVert := vaCenter;
                 Width := 75;
                 tvCBEQtyIndex := Index;

//                 Visible := Preferences.ValueAsBoolean[cPref_ShowQuantityColumn];
              end;

           with CreateColumn do
              begin
                 Caption := 'Amount';
                 Name := 'InputAmount';
                 DataBinding.ValueTypeClass := TcxFloatValueType;
                 PropertiesClass := TcxCurrencyEditProperties;
                 with TcxCurrencyEditProperties(Properties) do
                    begin
                       Alignment.Horz := taRightJustify;
                       Alignment.Vert := taVCenter;
                       DisplayFormat := cDefaultCurrencyFormat;
                       Styles.Content := cxStyleCBEntryRow;
                       OnEditValueChanged :=  CBEAmountOnChange;
                    end;
                 HeaderAlignmentHorz := taCenter;
                 HeaderAlignmentVert := vaCenter;
                 Width := 75;
                 tvCBEAmtIndex := Index;
              end;

           with CreateColumn do
              begin
                 Caption := 'VAT Code';
                 Name := 'VATCode';
                 DataBinding.ValueTypeClass := TcxStringValueType;
                 HeaderAlignmentHorz := taCenter;
                 HeaderAlignmentVert := vaCenter;
                 Width := 75;
                 PropertiesClass := TcxButtonEditProperties;
                 with TcxButtonEditProperties(Properties) do
                    begin
                       Alignment.Vert := taVCenter;
                       OnButtonClick := VATCodeButtonEditClick;
                       OnEditValueChanged := CBEVATCodeOnChange;
                       Buttons[0].Kind := bkGlyph;
                       AccsDataModule.ImageList16x16.GetBitmap(1, Buttons[0].Glyph);
                       Styles.Content := cxStyleCBEntryRow;
                    end;
                 tvCBEVATCodeIndex := Index;
                 if cash11.Xuse_Vat then
                    begin
                       Visible := False;
                       Hidden := True;
                    end;
              end;

//           if not cash11.Xuse_Vat then
//              begin
              with CreateColumn do
                 begin
                    Caption := 'VAT Amt';
                    Name := 'VATAmount';
                    DataBinding.ValueTypeClass := TcxFloatValueType;
                    PropertiesClass := TcxCurrencyEditProperties;
                    with TcxCurrencyEditProperties(Properties) do
                       begin
                          Alignment.Vert := taVCenter;
                          Alignment.Horz := taRightJustify;
                          DisplayFormat := cDefaultCurrencyFormat;
                          Styles.Content := cxStyleCBEntryRow;
                       end;
                    HeaderAlignmentHorz := taCenter;
                    HeaderAlignmentVert := vaCenter;
                    Width := 75;

                    tvCBEVATIndex := Index;
                    if cash11.Xuse_Vat then
                       begin
                          Visible := False;
                          Hidden := True;
                       end;
                 end;
//              end;

           with CreateColumn do
              begin
                 Caption := 'NomAcc';
                 Name := 'NomAcc';
                 DataBinding.ValueTypeClass := TcxStringValueType;
                 tvCBENomIndex := Index;
                 Visible := False;
                 Hidden := True;
              end;

           with CreateColumn do
              begin
                 Caption := 'Analysis';
                 Name := 'AnalysisCode';
                 DataBinding.ValueTypeClass := TcxStringValueType;
                 HeaderAlignmentHorz := taCenter;
                 HeaderAlignmentVert := vaCenter;
                 Width := 80;
                 PropertiesClass := TcxButtonEditProperties;
                 with TcxButtonEditProperties(Properties) do
                    begin
                       OnButtonClick := AnalysisCodeClick;
                       Buttons[0].Kind := bkGlyph;
                       AccsDataModule.ImageList16x16.GetBitmap(1, Buttons[0].Glyph);
                       OnChange := InputTransGridTableViewNomDescEditValueChanged;
                       Styles.Content := cxStyleCBEntryRow;
                       Alignment.Vert := taVCenter;
                    end;
                 tvCBEAnalysisCode := Index;
              end;

           with CreateColumn do
              begin
                 Name := 'Quantity2';
                 DataBinding.ValueTypeClass := TcxFloatValueType;
                 tvCBEQuantity2 := Index;
                 Visible := False;
                 Hidden := True;
              end;

           with CreateColumn do
              begin
                 Name := 'Quantity3';
                 DataBinding.ValueTypeClass := TcxFloatValueType;
                 tvCBEQuantity3 := Index;
                 Visible := False;
                 Hidden := True;
              end;

           with CreateColumn do
              begin
                 Name := 'CBENomFreeEntryDesc';
                 DataBinding.ValueTypeClass := TcxStringValueType;
                 tvCBENomFreeEntryDescIndex := Index;
                 Visible := False;
                 Hidden := True;
              end;

           with CreateColumn do
              begin
                 Name := 'CBEVatCalculated';
                 DataBinding.ValueTypeClass := TcxStringValueType;
                 tvCBEVatCalculatedIndex := Index;
                 Visible := False;
                 Hidden := True;
              end;


           cxDataSummaryItem := InputTransGridTableView.DataController.Summary.FooterSummaryItems.Add;
           with ( cxDataSummaryItem as TcxGridTableSummaryItem ) do
              begin
                 Format := 'Total:';
                 Kind := skCount;
                 Column := TcxGridColumn(InputTransGridTableView.FindItemByID(tvCBEDateIndex));
                 Font.Name := 'Segoe UI';
                 Font.Size := 9;

              end;

           cxDataSummaryItem := InputTransGridTableView.DataController.Summary.FooterSummaryItems.Add;
           with ( cxDataSummaryItem as TcxGridTableSummaryItem ) do
              begin
                 Format := '#.00';
                 Kind := skSum;
                 Column := TcxGridColumn(InputTransGridTableView.FindItemByID(tvCBEQtyIndex));
                 Font.Name := 'Segoe UI';
                 Font.Size := 9;
              end;

           cxDataSummaryItem := InputTransGridTableView.DataController.Summary.FooterSummaryItems.Add;
           with ( cxDataSummaryItem as TcxGridTableSummaryItem ) do
              begin
                 Format := '#.00';
                 Kind := skSum;
                 Column := TcxGridColumn(InputTransGridTableView.FindItemByID(tvCBEAmtIndex));
                 Font.Name := 'Segoe UI';
                 Font.Size := 9;
              end;

           if not cash11.Xuse_Vat then
              begin
                 cxDataSummaryItem := InputTransGridTableView.DataController.Summary.FooterSummaryItems.Add;
                 with ( cxDataSummaryItem as TcxGridTableSummaryItem ) do
                    begin
                       Format := '#.00';
                       Kind := skSum;
                       Column := TcxGridColumn(InputTransGridTableView.FindItemByID(tvCBEVATIndex));
                       Font.Name := 'Segoe UI';
                       Font.Size := 9;
                    end;
              end;

            DataController.RecordCount := 1;
            try
               SetFocus;
               OnFocusedItemChanged   := nil;
               Controller.FocusedItem := InputTransGridTableView.FindItemByName('InputDate');
               OnFocusedItemChanged   := InputTransGridTableViewFocusedItemChanged;
            except
            end;

            // Update height of InputTransGrid
            SetInputGridHeight();
         end;
   finally
      InputTransGrid.EndUpdate;
      LoadPreferences;
      FGridDesigning := False;
   end;
end;


procedure TFMainScreen.EntButtonEditClick(Sender: TObject;
  AButtonIndex: Integer);
begin
   // invoke search for ent
   CheckNumericColumns(InputTransGridTableView.DataController.FocusedRecordIndex);
   NewListBox.ListIt ( Sender, Enterprise, 'E' );
   if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
      begin
         InputGridCell[tvCBEEntIndex] := NewListBox.ListInfo.ReturnValue;
         InputGridCell[tvCBEQuantity2] := 0;
         InputGridCell[tvCBEQuantity3] := 0;
         PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBENomDescIndex,0);
      end;
end;

procedure TFMainScreen.IncomeExpenseButtonEditClick(Sender: TObject;
  AButtonIndex: Integer);
var
   Point : TPoint;
begin
   if (Sender is TcxTextEdit) then
      (Sender as TcxTextEdit).PostEditValue;

   {GetCursorPos(Point);
   Point := ScreenToClient(ClientToScreen(Point));
   // try to align to left,bottom of cell
   Point.x := Point.x - 65;
   Point.y := Point.y + cDefaultCBEGridRowHeight;}

   Point.x := -1;
   Point.y := -1;
   try
      Point := InputTransGrid.ClientToScreen(InputTransGridTableView.Controller.FocusedItem.FocusedCellViewInfo.EditBounds.BottomRight);
   except
   end;

   // invoke search for ExpenseIncome
   CheckNumericColumns(InputTransGridTableView.DataController.FocusedRecordIndex);

   InvokeNominalSelector();

   if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
      begin
         InputGridCell[tvCBENomIndex] := NewListBox.ListInfo.ReturnValue; // Nom Acc Id.
         InputGridCell[tvCBENomDescIndex] := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ), 1 );

          EditNominalFreeTextDescription(Point);

         if (Preferences.ValueAsBoolean[cPref_AutoEntSelect]) then
            InputGridCell[tvCBEEntIndex] := AccsDataModule.GetEnterpriseCodeByNominalCode(NewListBox.ListInfo.ReturnValue);

         if ( tvCBEVATCodeIndex > -1 ) then
            begin
               InputGridCell[tvCBEVATCodeIndex] := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ),20);
               CheckVATForChanges();
            end;

         // SP 29/04/2015 - Bug Fix - Remove UseDefaults requested by GL because defaulting Supplier/Customer should not be implemented
         //                           for the simple entry system.
         {if (UseDefaults and not GEditing) then
            begin
               AccsDataModule.NomDefaults.Open;
               try
                  if ((cbTransTypeGroup.ItemIndex = 0) and (AccsDataModule.NomDefaults.locate('Nominal;SLPLType',VarArrayOf([NewListBox.ListInfo.ReturnValue,'S']),[]))) then
                     begin // sales
                        try
                           custsuppaccount := varToStr(AccsDataModule.NomDefaults['SLPLCode']);
                           //InputGrid.Cells[Custsuppcol, 1] := GetAccountName (SLFile,StrToInt(custSuppAccount),1);
                           InputGridCell[tvCBECustSuppIndex] := GetAccountName (SLFile,StrToInt(custSuppAccount),1);
                           NotifyCustomerSupplierChange;
                        except
                        end;
                     end;
                  if ((cbTransTypeGroup.ItemIndex = 1) and  (AccsDataModule.NomDefaults.locate('Nominal;SLPLType',VarArrayOf([NewListBox.ListInfo.ReturnValue,'P']),[]))) then
                     begin // purchase
                        try
                           custsuppaccount := VarToStr(AccsDataModule.NomDefaults['SLPLCode']);
                           //InputGrid.Cells[Custsuppcol, 1] := GetAccountName (PLFile, StrToInt(custSuppAccount),1);
                           InputGridCell[tvCBECustSuppIndex] := GetAccountName (PLFile, StrToInt(custSuppAccount),1);
                           NotifyCustomerSupplierChange;
                        except
                        end;
                     end;
               finally
                  AccsDataModule.NomDefaults.Close;
               end;
            end;}
      end;

   if not VarIsNull(InputGridCell[tvCBENomIndex]) then
      begin
         PostMessage(Handle, WM_FOCUSNEXTITEM, -1, 0);
      end;
end;

procedure TFMainScreen.CustomerButtonEditClick(Sender: TObject;
  AButtonIndex: Integer);
var
   DefaultNominalId : Integer;
   NominalAccount : TNominalAccount;
begin
   CheckNumericColumns(InputTransGridTableView.DataController.FocusedRecordIndex);
   NewListBox.ListIt ( Sender, Customers, 'C' );
   if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
      begin
         InputGridCell[tvCBECustSuppIndex] := GetAccountName( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ),1);
         custsuppaccount := NewListBox.ListInfo.ReturnValue;

         LoadDefaultNominalForCustomerSupplier(StrToInt ( NewListBox.ListInfo.ReturnValue ));
         NotifyCustomerSupplierChange;
         PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBECustSuppIndex+1,0);
      end;
end;

procedure TFMainScreen.SupplierButtonEditClick(Sender: TObject;
  AButtonIndex: Integer);
begin
   CheckNumericColumns(InputTransGridTableView.DataController.FocusedRecordIndex);
   NewListBox.ListIt ( Sender, Suppliers, 'S' );
   if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
      begin
         InputGridCell[tvCBECustSuppIndex] := GetAccountName( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ),1);
         custsuppaccount := NewListBox.ListInfo.ReturnValue;

         LoadDefaultNominalForCustomerSupplier(StrToInt ( NewListBox.ListInfo.ReturnValue ));

         NotifyCustomerSupplierChange;
         PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBECustSuppIndex+1,0);
      end;
end;


procedure TFMainScreen.InputTransGridExit(Sender: TObject);
Var TempArrPos  : Integer;
    TestVATCode : ShortString;
    TempStr : ShortString;
begin
   if ( tvCBEVATCodeIndex > -1 ) then
      begin
         TempVar := InputGridCell[tvCBEVATCodeIndex];
         if not VarIsNull(TempVar) then
            begin
               TestVATCode := TempVar;
               SlimAll ( TestVATCode );
               if Length(TestVATCode) > 0 then
                  begin
                     if ( NOT NewListBox.CheckVAT ( TestVATCode, TempArrPos )) then
                        begin
                           InputTransGrid.SetFocus;
                           MessageDLG(TestVATCode + ' is not a Valid VAT Code',mtinformation,[mbOk],0);
                        end;
                  end;
            end;
      end;

   if ( tvCBENomDescIndex > -1 ) then
      begin
         if ( InputTransGridTableView.Controller.FocusedItem <> nil ) and
            ( InputTransGridTableView.Controller.FocusedItemIndex = tvCBENomDescIndex ) then
         PostMessage(Handle, WM_FOCUSNEXTITEM, InputTransGridTableView.Controller.FocusedItemIndex+1,0);
      end;

   // Check if Amount values need to be converted to negative value for contra purposes

   if (tvCBEAmtIndex > -1) then
      begin
         TempVar := InputGridCell[tvCBEAmtIndex];
         if VarIsNull(TempVar) then Exit;

         TempStr := TempVar;
         SlimAll ( TempStr );
         if Length ( TempStr ) = 0 then Exit;

         if NOT (( Length ( TempStr ) = 1 ) And ( TempStr = '-' )) Then
            begin
               if not ChangeToLong ( TempStr ) then Exit;

               if VarIsNull(InputGridCell[tvCBENomIndex]) then Exit;

               TempStr := NewListBox.NegitiveFlag ( InputGridCell[tvCBENomIndex] , TempStr );
               InputGridCell[tvCBEAmtIndex] := TempStr;
            end;
      end;
end;

procedure TFMainScreen.VATCodeButtonEditClick(Sender: TObject;
  AButtonIndex: Integer);
var
   OrigVat : shortstring;
begin
   CheckNumericColumns(InputTransGridTableView.DataController.FocusedRecordIndex);

   if tvCBEVATCodeIndex > -1 then
      begin
         TempVar := InputGridCell[tvCBEVATCodeIndex];
         if not VarIsNull(TempVar) then
            begin
               OrigVAT := TempVar;
               SlimAll ( OrigVAT );
            end;
         NewListBox.ListIt ( Sender, Vat, 'V' );   { VAT Rates }
         If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
            begin
               InputGridCell[tvCBEVATCodeIndex] := NewListBox.ListInfo.ReturnValue;
               TempVar := InputGridCell[tvCBEVATCodeIndex];
               CheckVATForChanges();
            end;
         PostMessage(Handle, WM_FOCUSNEXTITEM, InputTransGridTableView.Controller.FocusedItemIndex+1,0);
      end;
end;

procedure TFMainScreen.CBGridDateOnInitPopup(Sender: TObject);
begin
   CheckNumericColumns(InputTransGridTableView.DataController.FocusedRecordIndex);
end;

procedure TFMainScreen.actSaveCBInputExecute(Sender: TObject);
var
   PCount, i : integer;
   ErrText : string;
   ErrorColIndex : Integer;
   AllRowsOK : Boolean;
   ItemValue : Variant;
begin

   if InputTransGridTableView.Controller.FocusedItem.Index = tvCBEVATIndex then
      PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBEVATIndex+1,0);


      // SP 29/04/2015 - Bug Fix - Remove UseDefaults requested by GL because defaulting Supplier/Customer should not be implemented
      //                           for the simple entry system.
      { If UseDefaults then begin
                accsdatamodule.NomDefaults.open;
                try if ((cbTransTypeGroup.Itemindex = 0) and  (accsdatamodule.NomDefaults.locate('Nominal;SLPLType',VarArrayOf([InputGridCell[tvCBENomIndex],'S']),[])))
                then begin
                     accsdatamodule.NomDefaults.edit;
                     accsdatamodule.NomDefaults['SLPLCode'] :=StrToInt(CustSuppAccount);
                     accsdatamodule.NomDefaults.post;
                end;
                except
                end;
                try if ((cbTransTypeGroup.ItemIndex = 0) and  (not accsdatamodule.NomDefaults.locate('Nominal;SLPLType',VarArrayOf([InputGridCell[tvCBENomIndex],'S']),[])))
                then begin
                     accsdatamodule.NomDefaults.append;
                     accsdatamodule.NomDefaults['Nominal'] := InputGridCell[tvCBENomIndex];
                     accsdatamodule.NomDefaults['SLPLCode'] :=StrToInt(CustSuppAccount);
                     accsdatamodule.NomDefaults['SLPLType'] := 'S';
                     accsdatamodule.NomDefaults.post;
                end;
                except
                end;
                try if ((cbTransTypeGroup.Itemindex = 1) and  (accsdatamodule.NomDefaults.locate('Nominal;SLPLType',VarArrayOf([InputGridCell[tvCBENomIndex],'P']),[])))
                then begin
                     accsdatamodule.NomDefaults.edit;
                     accsdatamodule.NomDefaults['SLPLCode'] :=StrToInt(CustSuppAccount);
                     accsdatamodule.NomDefaults.post;

                end;
                except
                end;
                try if ((cbTransTypeGroup.Itemindex = 1) and  (not accsdatamodule.NomDefaults.locate('Nominal;SLPLType',VarArrayOf([InputGridCell[tvCBENomIndex],'P']),[])))
                then begin
                     accsdatamodule.NomDefaults.append;
                     accsdatamodule.NomDefaults['Nominal'] := InputGridCell[tvCBENomIndex];
                     accsdatamodule.NomDefaults['SLPLCode'] :=StrToInt(CustSuppAccount);
                     accsdatamodule.NomDefaults['SLPLType'] := 'P';
                     accsdatamodule.NomDefaults.post;
                end;
                except
                end;
                accsdatamodule.NomDefaults.close;
          end;}

   AllRowsOK := True;
   { Ensure all data rows have correct values }
   for i := 0 to InputTransGridTableView.DataController.RecordCount-1 do
      begin
         CheckNumericColumns(i);
         ErrorColIndex := RowOK(i);
         if ( ErrorColIndex > -1 ) then
            begin
               if ErrorColIndex = tvCBENomIndex then
                  begin
                     if ( cbTransTypeGroup.ItemIndex = 0 ) then
                        ErrText := 'Income Account'
                     else if ( cbTransTypeGroup.ItemIndex = 1 ) then
                        ErrText := 'Expense Account'
                     else
                        ErrText := 'Unknown Field';
                  end
               else if ErrorColIndex = tvCBEAmtIndex then
                  ErrText := 'Amount'
               else if ErrorColIndex = tvCBEVATCodeIndex then
                  ErrText := 'VAT Code'
               else if ErrorColIndex = tvCBEVATIndex then
                  ErrText := 'VAT Amount'
               else if ErrorColIndex = tvCBEDateIndex then
                  ErrText := 'Date'
               else
                  ErrText := 'UnKnown Field';
               AllRowsOK := False;
               MessageDlg('Unable to save transaction "'+ErrText+'" must have a correct value.',mtError,[mbOK], 0);
               Break;
            end;
      end;

   if AllRowsOK then
      begin
         gbCBEHeaderPanel.Caption := 'Enter Cashbook Transaction';

         InitialiseTransPointers;
         try
            if CopyTransactionDetails then
               begin
                  if cbTransTypeGroup.ItemIndex = 1 then
                     prog := cashexp
                  else
                     prog := cashinc;

                  act := 0;
                  if CheckNominals = 0 then
                     begin
                        if GEditing then
                           begin
                              if (AccsDataModule.IsVATProcessed(TxEditRec)) then
                                 begin
                                    MessageDlg('Transaction cannot be edited. The VAT on this transaction has been processed.',mtWarning,[mbOk],0);
                                    Exit;
                                 end;

                              WriteTransactions( 2, 0, 0, FALSE );
                              WriteTransactions( 1, 0, 0, FALSE );
                              ResetPointers ( Self );
                              GEditing :=false;
                              //   TxGrid.enabled := true;
                              actClearSearch.Enabled := True;
                              actSearchTransactions.Enabled := True;
                              LoadTransactionGrid;
                           end
                        else
                           begin
                              ItemValue := InputGridCell[tvCBEDateIndex];
                              if not VarIsNull(ItemValue) then
                                 begin
                                    FCBEDate := ItemValue;
                                 end;

                              if (not cash11.xuse_enterprise) then
                                 begin
                                    ItemValue := InputGridCell[tvCBEEntIndex];
                                    if not VarIsNull(ItemValue) then
                                       begin
                                          AccsDataModule.DefaultEntCode := VarToStr(ItemValue);
                                       end;
                                 end;

                              WriteTransactions( 1, 0, 0, FALSE );
                              GEditing :=false;
                           end;
                        AccsDataModule.AgeOfDebtSyncRequired := True;
                     end
                  else
                     begin
                        MessageDlg('Invalid Nominal Code - ' + vartostr(Checknominals),mtError,[mbOK],0);
                        Exit;
                     end;
               end;
            InputGridInEditState := False;
         finally
            DisposeTransPointers;
            // clear input grid
            ClearInputGrid;
            custsuppaccount := '';
            FSupplierCustomerUserText := '';
         end;
      end
   else
      MessageDlg('An error has occurred. The transaction could not be saved.',mtError,[mbOK], 0);
   ceBankBalance.Value := AccsDataModule.GetBankBalance(beBankAccount.Text);
end;

procedure TFMainScreen.actCancelCBEInputExecute(Sender: TObject);
begin
   ResetCashbookTransaction(True);
   // revert back to viewing the details of the focused transaction 

   if (FLastSelectedRowIndex > -1) then
      begin
         TransactionGridTableView.DataController.FocusedRowIndex := FLastSelectedRowIndex;
         ViewTransaction;
      end
{   else
      ShowDebugMessage('actCancelCBEInputExecute() => FLastSelectedRowIndex <= -1');}
end;

procedure TFMainScreen.FocusItem(AIndex : Integer);
var
   NextItem : TcxCustomGridTableItem;
begin
   if InputTransGrid.FocusedView = InputTransGridTableView then
      begin
         if (AIndex <= InputTransGridTableView.ColumnCount-1) then
            begin
               if AIndex = -1 then
                  InputTransGridTableView.Controller.FocusNextItem(InputTransGridTableView.Controller.FocusedItemIndex, True, True, True)
               else
                  begin
                     NextItem := InputTransGridTableView.FindItemByID(AIndex);
                     if ((NextItem <> nil) and (NextItem.Visible)) then
                        begin
                           InputTransGridTableView.Controller.FocusedItem := InputTransGridTableView.FindItemByID(AIndex)
                        end
                     else
                        InputTransGridTableView.Controller.FocusNextItem(InputTransGridTableView.Controller.FocusedItemIndex, True, True, True)
                  end;
               if (InputTransGridTableView.Controller.FocusedItem <> nil) then
                  InputTransGridTableView.Controller.EditingController.EditingItem := InputTransGridTableView.Controller.FocusedItem;
            end;
      end;
end;

procedure TFMainScreen.DoFocusNextItem(var Message: TMessage);
begin
   if Message.Msg = WM_FOCUSNEXTITEM then
      FocusItem(Message.WParam);
end;

procedure TFMainScreen.InputTransGridTableViewFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
var
   nRecNo     : Integer;
   {
   NewVATAmt,
   NewVAT,
   NewAmt,
   }
   ErrText,
   TempVATStr,
   TempName,
   TempStr   : ShortString;
   VatArrPos : Integer;
   BadCol    : LongInt;
   Templong : long;
   TempAmount, TempVatAmount : LONG;

   TestDate : ShortString;
   DateBefore : Boolean;

   AccRange : TAccRange;

   EntValue : Variant;

   AccName : string;

   NominalAccount : TNominalAccount;
   DefaultNominalId : Integer;
   TransType : TTransactionType;
   CustomerSupplierId : Integer;

   procedure FocusNomDescColumn;
   begin
      if ( cbTransTypeGroup.ItemIndex = 1 ) then
         MessageDlg('No Expense Account has been selected.' + cCRLFx2 +
                    'Please select a valid Expense Account.',mtWarning,[mbOk],0)
      else
         MessageDlg('No Income Account has been selected.' + cCRLFx2 +
                    'Please select a valid Income Account.',mtWarning,[mbOk],0);
      PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBENomDescIndex, 0);
   end;

begin
   if ( not FFormShowing ) or ( FGridDesigning ) then exit;
   CheckNumericColumns(InputTransGridTableView.DataController.FocusedRecordIndex);

   if ((AFocusedItem <> nil) and (AFocusedItem.Index <> tvCBEDateIndex)) then
      begin
         TempVar := InputGridCell[tvCBEDateIndex];
         if not VarIsNull(TempVar) then
            begin
               TestDate := FormatDateTime(ShortDateFormat, TempVar);

               if not( DateValid(TestDate, TDateFormat )) then
                  begin
                     MessageDlg('You must enter a valid transaction date.',mtWarning,[mbOK],0); //Showmessage('No valid Transaction Date has been entered!');
                     PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBEDateIndex,0);
                     Exit;
                  end;
            end;
      end;

   if (( AFocusedItem <> nil ) and (AFocusedItem.Index = tvCBEStubIndex)) then
      begin
         TempVar := InputGridCell[tvCBEStubIndex];
         if VarIsNull(TempVar) or (Trim(TempVar)='') then
            begin
               if cbTransTypeGroup.ItemIndex = 0 then
                  TempLong := PSysLongToDelphi ( Cash1.xRecStub )
               else
                  TempLong := PSysLongToDelphi ( cash1.xPayStub);
               InputGridCell[tvCBEStubIndex] := IntToStr(Templong);
               //if not VarIsNull(InputGridCell[tvCBEStubIndex]) then
               //   PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBEStubIndex+1,0);
            end;
      end;

   if (( APrevFocusedItem <> nil ) and ( APrevFocusedItem.Index = tvCBECustSuppIndex )) then
      begin

         if ( IsNumeric( FSupplierCustomerUserText ) ) then
            begin
               CustomerSupplierId := StrToInt(FSupplierCustomerUserText);

               if cbTransTypeGroup.ItemIndex = 1 then
                  AccName := GetAccountName ( PLFile, CustomerSupplierId, 1)
               else
                  AccName := GetAccountName ( SLFile, CustomerSupplierId, 1);
               if ( Trim(AccName) <> '' ) then
                  begin
                     InputGridCell[tvCBECustSuppIndex] := AccName;
                     custsuppaccount := FSupplierCustomerUserText;
                     justadded := true;
                     NotifyCustomerSupplierChange;
                  end
               else
                  begin
                     custsuppaccount := '';
                     FSupplierCustomerUserText := '';
                     InputGridCell[tvCBECustSuppIndex] := '';
                     PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBECustSuppIndex,0);

                     if cbTransTypeGroup.ItemIndex = 1 then
                        MessageDlg(Format('Supplier Account No: [%s] was not found.',[FSupplierCustomerUserText]),mtWarning,[mbOK],0)
                     else
                        MessageDlg(Format('Customer Account No: [%s] was not found.',[FSupplierCustomerUserText]),mtWarning,[mbOK],0);
                  end;

               LoadDefaultNominalForCustomerSupplier(CustomerSupplierId);
            end;
      end;

   if (( APrevFocusedItem <> nil ) and (APrevFocusedItem.Index = tvCBEDateIndex)) then
      begin
         if cbTransTypeGroup.ItemIndex = 0 then
            Prog := CashInc
         else
            Prog := CashExp;
         // TGM AB Date Validation Check

         TestDate := '';
         TempVar := APrevFocusedItem.EditValue;

         if VarIsNull(TempVar) then
            begin
               TempVar := FCBEDate;
               InputGridCell[tvCBEDateIndex] := TempVar;
               InputTransGridTableView.DataController.PostEditingData;
               //MessageDlg('You must enter a valid transaction date',mtWarning,[mbOK],0);
            end;

         TestDate := FormatDateTime(ShortDateFormat, TempVar);
         if not( DateValid(TestDate, TDateFormat )) then
            begin
               MessageDlg('You must enter a valid transaction date',mtWarning,[mbOK],0); //Showmessage('No valid Transaction Date has been entered!');
            end
         else if NOT CheckDateRange ( TestDate, True, DateBefore, True ) Then
            begin
               APrevFocusedItem.EditValue := TestDate;
            end;

         // Entering Date, assume its a new record. Insert AccsDataModule.DefaultEntCode if EntCode is empty
         if (not cash11.xuse_enterprise) then
            begin
               EntValue := InputGridCell[tvCBEEntIndex];
               if (( ( VarIsNull(EntValue) ) or ( VarIsEmpty(EntValue) ) ) and
                   ( AccsDataModule.DefaultEntCode <> '' ) and
                   (not Preferences.ValueAsBoolean[cPref_AutoEntSelect])) then

               // SP 29/04/2015 - Bug Fix
               // A problem became apparent when the grid column layout changed due to new preference options.
               // If the cPref_AutoEntSelect is set to true the Enterprise column will appear after the Nominal column.
               // If this happens we should not recall the default enterprise code as it will have been preset (where applicable)
               // via the Nominal selection.
                  begin
                     InputGridCell[tvCBEEntIndex] := AccsDataModule.DefaultEntCode;
                     InputGridCell[tvCBEQuantity2] := 0;
                     InputGridCell[tvCBEQuantity3] := 0;
                  end;
            end;
      end;

{
   // removed by SP 17/06/2013 - Due to change defaulting ENT code to that of selected NominalAccount.EntCode

   if (( APrevFocusedItem <> nil ) and (not cash11.xuse_enterprise) and (APrevFocusedItem.Index = tvCBEEntIndex)) then
      begin
         TempVar := APrevFocusedItem.EditValue;
         if not VarIsNull(TempVar) then
            begin
               TempStr := TempVar;
               SlimAll ( TempStr );
               if Length ( TempStr ) > 0 then
                  begin
                     if NOT CheckEnt ( TempStr, nRecNo ) Then
                        begin
                           //ShowMessage('CanSelect=False <<--- ');
                           //CanSelect := False;
                           PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBEEntIndex,0);
                        end;
                  end;
            end;
      end;}

   if (( APrevFocusedItem <> nil ) and (APrevFocusedItem.Index = tvCBENomDescIndex)) then
      begin
         TempVar := InputGridCell[tvCBENomIndex];
         if VarIsNull(TempVar) or ( Trim(TempVar) = '') then
            begin
               TempVar := InputGridCell[tvCBENomDescIndex];
               if not VarIsNull(TempVar) then
                  begin
                     TempStr := TempVar;
                     SlimAll ( TempStr );
                     if Numeric ( TempStr ) Then
                        begin
                           InputGridCell[tvCBENomIndex] := TempStr;
                           // SP 18/06/2013
                           if (Preferences.ValueAsBoolean[cPref_AutoEntSelect]) then
                              InputGridCell[tvCBEEntIndex] := AccsDataModule.GetEnterpriseCodeByNominalCode(TempStr);
                        end;
                  end;
            end;

         if not VarIsNull(TempVar) then
            begin
               TempStr := TempVar;
               SlimAll ( TempStr );

               TempVar := APrevFocusedItem.EditValue;
               if not VarIsNull(TempVar) then
                  begin
                     TempName := TempVar;
                     SlimAll ( TempName );
                     if Numeric ( TempStr ) Then
                        begin
                           // Its important not to reset the nominal description if we are editing, as the user
                           // might have entered a custom description via the "Allow
                           if (Length ( TempName ) <> 0) and (not GEditing) then
                              APrevFocusedItem.EditValue := GetAccountName ( NlFile, StrToInt ( TempStr ), 1 );

                           if not cash11.Xuse_enterprise then
                              begin

                                 if ( tvCBEVATCodeIndex > -1 ) then
                                    begin
                                       TempVar := InputGridCell[tvCBEVATCodeIndex];
                                       if not VarIsNull(TempVar) then
                                          begin
                                             TempVATStr := TempVar;
                                             SlimAll ( TempVATStr );
                                          end;
                                       if Length ( TempVATStr ) = 0 then
                                          InputGridCell[tvCBEVATCodeIndex] := GetAccountName ( NlFile, StrToInt ( TempStr ), 20 );
                                    end;
                             end; // if not vat
                        end;
                  end;
            end
         else
            begin
               TempVar := InputGridCell[tvCBENomDescIndex];
               if not VarIsNull(TempVar) then
                  begin
                     TempStr := TempVar;
                     SlimAll ( TempStr );
                     if Numeric ( TempStr ) Then
                        begin

                        end;

                     TempVar := APrevFocusedItem.EditValue;
                     if not VarIsNull(TempVar) then
                        begin
                           TempName := TempVar;
                           SlimAll ( TempName );
                           if Numeric ( TempStr ) Then
                              begin
                                 if Length ( TempName ) = 0 then
                                    APrevFocusedItem.EditValue := GetAccountName ( NlFile, StrToInt ( TempStr ), 1 );
                                 if not cash11.Xuse_enterprise then
                                    begin

                                       if ( tvCBEVATCodeIndex > -1 ) then
                                          begin
                                             TempVar := InputGridCell[tvCBEVATCodeIndex];
                                             if not VarIsNull(TempVar) then
                                                begin
                                                   TempVATStr := TempVar;
                                                   SlimAll ( TempVATStr );
                                                end;
                                             if Length ( TempVATStr ) = 0 then
                                                InputGridCell[tvCBEVATCodeIndex] := GetAccountName ( NlFile, StrToInt ( TempStr ), 20 );
                                          end;
                                   end; // if not vat
                              end;
                        end;
                  end;
            end;
         FCBELastNominalAccount := VarToStr(InputGridCell[tvCBENomDescIndex]);
         CBENominalAccountAfterChange();
      end;

   if (( APrevFocusedItem <> nil ) and (APrevFocusedItem.Index = tvCBEQtyIndex)) then
      begin
         TempVar := APrevFocusedItem.EditValue;
         if not VarIsNull(TempVar) then
            begin
               TempStr := TempVar;
               SlimAll ( TempStr );
               if Length ( TempStr ) > 0 then
                  if NOT ChangeToLong ( TempStr ) then
                     begin
                        //ShowMessage('CanSelect=False <<--- ');
                        //CanSelect := False;
                        PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBEQtyIndex,0);
                     end
                  else
                     APrevFocusedItem.EditValue := TempStr;
            end;
         {if VarIsNull(InputGridCell[tvCBENomIndex]) then
            FocusNomDescColumn;}

      end;


         TempVar := InputGridCell[tvCBEAmtIndex];
         if not VarIsNull(TempVar) then
            begin
               TempStr := TempVar;
               SlimAll ( TempStr );
               if Length ( TempStr ) > 0 then
                  { Check for minus sign and no numbers begin entered }
                  if NOT (( Length ( TempStr ) = 1 ) And ( TempStr = '-' )) Then
                     begin
                        if NOT ChangeToLong ( TempStr ) then
                           begin
                              //ShowMessage('CanSelect=False <<--- ');
                              //CanSelect := False;
                              InputGridCell[tvCBEAmtIndex] := '0';
                              PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBEAmtIndex,0);
                           end
                        else
                            begin
                               if not VarIsNull(InputGridCell[tvCBENomIndex]) then
                                  begin
                                     TempStr := NewListBox.NegitiveFlag ( InputGridCell[tvCBENomIndex] , TempStr );
                                     InputGridCell[tvCBEAmtIndex] := TempStr;
                                  end;
                            end;

                     end;
            end;

   if (( APrevFocusedItem <> nil ) and (APrevFocusedItem.Index = tvCBEVATCodeIndex)) then
      begin
         TempVar := APrevFocusedItem.EditValue;
         if not VarIsNull(TempVar) then
            begin
               TempStr := TempVar;
               SlimAll ( TempStr );
               if Length(TempStr) > 0 then
                  begin
                     if ( NOT NewListBox.CheckVAT ( TempStr, VATArrPos )) then
                        begin
                           //ShowMessage('CanSelect=False <<--- ');
                           //CanSelect := False;
                           //APrevFocusedItem.EditValue := ' ';
                           APrevFocusedItem.EditValue := Null;
                        end;
                  end;
               {if VarIsNull(InputGridCell[tvCBENomIndex]) then
                  FocusNomDescColumn;}
            end;
      end;


   if (( APrevFocusedItem <> nil ) and (APrevFocusedItem.Index = tvCBEVATIndex)) then
      begin
         TempVar := APrevFocusedItem.EditValue;
         if not VarIsNull(TempVar) then
            begin
               TempStr := TempVar;
               SlimAll ( TempStr );
               if Length ( TempStr ) > 0 then
                { Check for minus sign and no numbers begin entered
                if NOT (( Length ( TempStr ) = 1 ) And ( TempStr = '-' )) Then
                }
                   begin
                      if NOT ChangeToLong ( TempStr ) then
                         begin
                            //ShowMessage('CanSelect=False <<--- ');
                            //CanSelect := False;
                            APrevFocusedItem.EditValue := '0';
                         end;
                   end;
            end;
         {if VarIsNull(InputGridCell[tvCBENomIndex]) then
            FocusNomDescColumn;}
      end;

//   If ( not GEditing ) and (( APrevFocusedItem <> nil ) and (APrevFocusedItem.Index = tvCBENomDescIndex)) then
   If (( APrevFocusedItem <> nil ) and (APrevFocusedItem.Index = tvCBENomDescIndex)) then
      begin
         if (not cash11.xuse_enterprise) then
            begin
               TempVar := InputGridCell[tvCBEEntIndex];
               if not VarIsNull(TempVar) then
                  begin
                     AccRange := GetEntRanges ( TempVar );
                     if VarIsNull(InputGridCell[tvCBENomIndex]) or NOT NewListBox.CheckNom ( InputGridCell[tvCBENomIndex], AccRange ) then
                        PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBEEntIndex,0)
                     else
                        begin
                           TempVar := InputGridCell[tvCBEAmtIndex];
                           if not VarIsNull(TempVar) then
                              InputGridCell[tvCBEAmtIndex] := NewListBox.NegitiveFlag ( InputGridCell[tvCBENomIndex], TempVar );

                          // if we have auto selected a non empty Ent code,
                          // just skip to next input field, otherwise focus the ent code field
                           if (Preferences.ValueAsBoolean[cPref_AutoEntSelect]) then
                               PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBEEntIndex+1,0)
                        end;
                  end;
            end;
      end;
end;

procedure TFMainScreen.InputTransGridTableViewCellDblClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
var
   OrigVAT,
   TmpStr : ShortString;
   Point : TPoint;
begin
   if FGridDesigning then Exit;

   Point.x := -1;
   Point.y := -1;
   try
      Point := InputTransGrid.ClientToScreen(InputTransGridTableView.Controller.FocusedItem.FocusedCellViewInfo.EditBounds.BottomRight);
   except
   end;

   if (not cash11.xuse_enterprise) then
      begin
         if ACellViewInfo.Item.Index = tvCBEEntIndex then  { Enterprise Column }
            begin
               NewListBox.ListIt ( Sender, Enterprise, 'E' );   { Enterprise Accounts }
               if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
                  begin
                     InputGridCell[ACellViewInfo.Item.Index] := NewListBox.ListInfo.ReturnValue;
                     FocusItem(tvCBEEntIndex+1);
                  end;
            end;
      end;


   if ACellViewInfo.Item.Index = tvCBEVATCodeIndex then   { VAT Code Column }
      begin
         TempVar := InputGridCell[ACellViewInfo.Item.Index];
         if not VarIsNull(TempVar) then
            begin
               OrigVAT := TempVar;
               SlimAll ( OrigVAT );
            end;
         NewListBox.ListIt ( Sender, Vat, 'V' );   { VAT Rates }
         if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
            begin
               InputGridCell[ACellViewInfo.Item.Index] := NewListBox.ListInfo.ReturnValue;
               TempVar := InputGridCell[ACellViewInfo.Item.Index];
               FocusItem(tvCBEVATCodeIndex+1);
               CheckVATForChanges();
            end;
      end;

   if ACellViewInfo.Item.Index = tvCBECustSuppIndex then  {customer / supplier column}
      begin
         // only allow edit if recordIndex = 0

         if InputTransGridTableView.DataController.FocusedRecordIndex = 0 then
            begin
               if cbTransTypeGroup.ItemIndex = 1 then
                  NewListBox.ListIt ( Sender, Suppliers, 'S' )
               else
                  NewListBox.ListIt ( Sender, Customers, 'C' );

               if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
                  begin
                     InputGridCell[ACellViewInfo.Item.Index] := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ),1);
                     custsuppaccount := NewListBox.ListInfo.ReturnValue;
                     NotifyCustomerSupplierChange;
                     PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBECustSuppIndex+1,0);
                 end;
            end;
      end;

   if ACellViewInfo.Item.Index = tvCBENomDescIndex then { Nominal Ledger Column }
      begin
         if (not cash11.xuse_enterprise) then
            begin
               InvokeNominalSelector();
               if Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
                  begin
                     InputGridCell[tvCBENomIndex] := NewListBox.ListInfo.ReturnValue;
                     InputGridCell[ACellViewInfo.Item.Index] := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ), 1 );
                     if (Preferences.ValueAsBoolean[cPref_AutoEntSelect]) then
                        InputGridCell[tvCBEEntIndex] := AccsDataModule.GetEnterpriseCodeByNominalCode(NewListBox.ListInfo.ReturnValue);

                     EditNominalFreeTextDescription(Point);

                     TmpStr := VarToStr(InputGridCell[ACellViewInfo.Item.Index]);
                     SlimAll ( TmpStr );
                     if Length ( TmpStr ) = 0 Then
                        begin
                           InputGridCell[tvCBEVATCodeIndex] := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ), 20 );
                           CheckVATForChanges();
                        end;
                     FocusItem(tvCBENomDescIndex+1);
                  end;
            end;
      end;

   if ACellViewInfo.Item.Index = tvCBEVATCodeIndex then { VAT Code Column }
      begin
         TempVar := InputGridCell[ACellViewInfo.Item.Index];
         if not VarIsNull(TempVar) then
            begin
               OrigVAT := TempVar;
               SlimAll ( OrigVAT );
            end;
         NewListBox.ListIt ( Sender, Vat, 'V' );   { VAT Rates }
         if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
            begin
               InputGridCell[ACellViewInfo.Item.Index] := NewListBox.ListInfo.ReturnValue;
               CheckVATForChanges();
               FocusItem(tvCBEVATCodeIndex+1);
            end;
      end;
end;

procedure TFMainScreen.InputTransGridTableViewKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  Edit: TcxCustomEdit;
  NewValue: Variant;
  AccName : string;
  Point : TPoint;
begin
   if FGridDesigning then Exit;
   if (ViewPageControl.ActivePageIndex = tsSalesInvoice.PageIndex) then
       begin
          SimpleSaleInvoiceFrame.HandleKeyUpEvent(Sender, Key, Shift);
          Exit;
       end
   else if (ViewPageControl.ActivePageIndex = tsPurchaseInvoice.PageIndex) then
       begin
          SimplePurchaseInvoiceFrame.HandleKeyUpEvent(Sender, Key, Shift);
          Exit;
       end;

   if InputTransGridTableView.Controller.FocusedItem = nil then Exit;

   try
      Point := InputTransGrid.ClientToScreen(InputTransGridTableView.Controller.FocusedItem.FocusedCellViewInfo.EditBounds.BottomRight);
   except
      Point.x := -1;
      Point.y := -1; 
   end;


   if ( Key = VK_LEFT ) and ( InputTransGridTableView.Controller.FocusedItem.Index > tvCBEDateIndex ) then
      begin
         PostMessage(Handle, WM_FOCUSNEXTITEM, InputTransGridTableView.Controller.FocusedItem.Index-1,0);
      end
   else if ( Key = VK_RIGHT ) then
      begin
         PostMessage(Handle, WM_FOCUSNEXTITEM, InputTransGridTableView.Controller.FocusedItem.Index+1,0);
      end
   else if ( Key = VK_RETURN ) and ( InputTransGridTableView.Controller.FocusedItem.Index = tvCBEDateIndex ) then
      begin

      end
   {else if ( Key = VK_DOWN ) then
      begin
         actNewLine.Execute; ???
      end}
   else
      begin
         with InputTransGridTableView do
            begin
               if Controller.FocusedItem.Index = tvCBECustSuppIndex then { Customer / Supplier Column }
                  begin
                     if (( not IsNumeric( FSupplierCustomerUserText ) ) and ( FSupplierCustomerUserText <> '') and (justadded = false)) then
                        begin
                           NewListBox.InitialSearchFieldText := FSupplierCustomerUserText;
                           FSupplierCustomerUserText := '';

                           If cbTransTypeGroup.ItemIndex = 1 then
                              NewListBox.ListIt ( Sender, Suppliers, 'S' )
                           else
                              NewListBox.ListIt ( Sender, Customers, 'C' );

                           if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
                              begin
                                 AccName := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ),1);
                                 InputGridCell[tvCBECustSuppIndex] := AccName;
                                 custsuppaccount := NewListBox.ListInfo.ReturnValue;
                                 LoadDefaultNominalForCustomerSupplier(StrToInt ( NewListBox.ListInfo.ReturnValue ));

                                 justadded := true;
                                 NotifyCustomerSupplierChange;

                                 PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBECustSuppIndex+1,0)
                              end
                           else
                              begin
                                 InputGridCell[tvCBECustSuppIndex] := '';
                                 showmessage('Please choose from the drop down list of Customers / Suppliers.')
                              end;
                        end
                     else
                        justadded := false;
                  end
               else if Controller.FocusedItem.Index = tvCBENomDescIndex then { Nominal Ledger Column }
                  begin
                     if (( not Numeric( VarToStr(InputGridCell[tvCBENomDescIndex]) ) ) and ( VarToStr(InputGridCell[tvCBENomDescIndex]) <> '') and (justadded = false) and (not cash11.xuse_enterprise))  then
                        begin
                           NewListBox.InitialSearchFieldText := VarToStr(InputGridCell[tvCBENomDescIndex]);

                           InvokeNominalSelector();

                           if Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
                              begin
                                 justadded := True;
                                 InputGridCell[tvCBENomIndex] := NewListBox.ListInfo.ReturnValue;
                                 AccName := Trim(GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ), 1 ));
                                 InputGridCell[tvCBENomDescIndex] := AccName;

                                 EditNominalFreeTextDescription(Point);

                                 if ( tvCBEVATCodeIndex > -1 ) then
                                    begin
                                       InputGridCell[tvCBEVATCodeIndex] := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ),20);
                                       CheckVATForChanges();
                                    end;

                                 if (Preferences.ValueAsBoolean[cPref_AutoEntSelect]) then
                                    InputGridCell[tvCBEEntIndex] := AccsDataModule.GetEnterpriseCodeByNominalCode(NewListBox.ListInfo.ReturnValue);
                              end;
                        end
                     else
                        justadded := False;
                  end;
               {else if Controller.FocusedItem.Index = tvCBEAnalysisCode then
                  begin
                     InputGridCell[tvCBEAnalysisCode] := GetCBEAnalysisCode();
                  end;}
            end;
      end;
end;

procedure TFMainScreen.InputTransGridTableViewMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   if FGridDesigning then Exit;

//     CBInputTrans.MouseToCell(X, Y, Column, Row);
//     if ((Column = EntCol) or (Column = NomCol) or (column = VatCodeCol) or (column = CustSuppCol)) then  InputGrid.Hint := ReadLang(148, CurrLang)


end;

procedure TFMainScreen.InputTransGridTableViewInitEdit(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit);
var
   TempLong : long;
begin
   if FGridDesigning then Exit;

   HideHint();

   InputGridInEditState := True;

   if not Assigned(AEdit.OnDblClick) then
      AEdit.OnDblClick := MyInputGridCellDoubleClick;

   if not (GEditing) then
      begin
         if (AEdit is TcxDateEdit) then
            begin
               // this has not be tested
               {TempVar := InputGridCell[tvCBEDateIndex];
               if (VarIsNull(AEdit.EditValue)) then
                  begin
                     AEdit.EditValue := Cash11.default_date;
                     AEdit.EditModified := True;
                  end;}
               if (VarIsNull(AEdit.EditValue)) then
                  begin
                     //if FCBEDate > 0 then
                     //   AEdit.EditValue := FCBEDate
                     //else
                        AEdit.EditValue := Cash11.default_date;
                     AEdit.EditModified := True;
                     AEdit.PostEditValue;
                     InputGridCell[tvCBEDateIndex] := AEdit.EditValue;
                  end;
            end;
      end;

   if (( AItem <> nil ) and (AItem.Index = tvCBEStubIndex)) then
      begin
         TempVar := AItem.EditValue;
         if VarIsNull(TempVar) or (Trim(TempVar)='') then
            begin
               if cbTransTypeGroup.ItemIndex = 0 then
                  TempLong := PSysLongToDelphi ( Cash1.xRecStub )
               else
                  TempLong := PSysLongToDelphi ( cash1.xPayStub);
               AItem.EditValue := IntToStr(Templong);
               //if not VarIsNull(AItem.EditValue) then
               //PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBEStubIndex+1,0);
            end;
      end;

   if (( AItem <> nil ) and (AItem.Index = tvCBEQtyIndex)) then
      begin
         (AEdit as TcxCurrencyEdit).Properties.Buttons[0].Visible :=
                 ((not(VarIsNullOrEmpty(InputGridCell[tvCBEEntIndex]))) and
                 (AccsDataModule.GetAdvancedQuantityInput(InputGridCell[tvCBEEntIndex]) <> nil));
      end;
end;

procedure TFMainScreen.MyInputGridCellDoubleClick(Sender: TObject);
var
   OrigVAT,
   TmpStr : ShortString;

   NextItem : Integer;
   Point : TPoint;
begin
   Point.x := -1;
   Point.y := -1;

   with InputTransGridTableView do
      begin
         if Controller.FocusedItem <> nil then
            begin
               try
                  Point := InputTransGrid.ClientToScreen(InputTransGridTableView.Controller.FocusedItem.FocusedCellViewInfo.EditBounds.BottomRight);
               except
               end;

               if (not cash11.xuse_enterprise) and (Controller.FocusedItem.Index = tvCBEEntIndex) then  { Enterprise Column }
                  begin
                     NewListBox.ListIt ( Sender, Enterprise, 'E' );   { Enterprise Accounts }
                     if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
                        begin
                           InputGridCell[Controller.FocusedItem.Index] := NewListBox.ListInfo.ReturnValue;
                           NextItem := tvCBEEntIndex+1;
                        end;
                  end;


               if Controller.FocusedItem.Index = tvCBEVATCodeIndex then   { VAT Code Column }
                  begin
                     TempVar := InputGridCell[Controller.FocusedItem.Index];
                     if not VarIsNull(TempVar) then
                        begin
                           OrigVAT := TempVar;
                           SlimAll ( OrigVAT );
                        end;

                      NewListBox.ListIt ( Sender, Vat, 'V' );   { VAT Rates }
                      if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
                         begin
                            InputGridCell[Controller.FocusedItem.Index] := NewListBox.ListInfo.ReturnValue;
                            TempVar := InputGridCell[Controller.FocusedItem.Index];
                            CheckVATForChanges();
                            NextItem := tvCBEVATCodeIndex+1;
                         end;
                  end;

               if Controller.FocusedItem.Index = tvCBECustSuppIndex then  {customer / supplier column}
                  begin
                     if cbTransTypeGroup.ItemIndex = 1 then
                        NewListBox.ListIt ( Sender, Suppliers, 'S' )
                     else
                        NewListBox.ListIt ( Sender, Customers, 'C' );

                     if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
                        begin
                           InputGridCell[Controller.FocusedItem.Index] := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ),1);
                           custsuppaccount := NewListBox.ListInfo.ReturnValue;
                           NotifyCustomerSupplierChange;
                           PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBECustSuppIndex+1,0);
                       end;
                  end;

               if Controller.FocusedItem.Index = tvCBENomDescIndex then { Nominal Ledger Column }
                  begin
                     if (not cash11.xuse_enterprise) then
                        begin
                           InvokeNominalSelector();

                           if Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
                              begin
                                 InputGridCell[tvCBENomIndex] := NewListBox.ListInfo.ReturnValue;
                                 InputGridCell[Controller.FocusedItem.Index] := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ), 1 );
                                 if (Preferences.ValueAsBoolean[cPref_AutoEntSelect]) then
                                    InputGridCell[tvCBEEntIndex] := AccsDataModule.GetEnterpriseCodeByNominalCode(NewListBox.ListInfo.ReturnValue);

                                 EditNominalFreeTextDescription(Point);

                                 TmpStr := VarToStr(InputGridCell[Controller.FocusedItem.Index]);
                                 SlimAll ( TmpStr );
                                 if Length ( TmpStr ) = 0 Then
                                    begin
                                       InputGridCell[tvCBEVATCodeIndex] := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ), 20 );
                                       CheckVATForChanges();
                                    end;
                                 NextItem := tvCBENomDescIndex+1;
                              end;
                        end;
                  end;

               if Controller.FocusedItem.Index = tvCBEVATCodeIndex then { VAT Code Column }
                  // not sure why this has to be called twice
                  begin
                     TempVar := InputGridCell[Controller.FocusedItem.Index];
                     if not VarIsNull(TempVar) then
                        begin
                           OrigVAT := TempVar;
                           SlimAll ( OrigVAT );
                        end;
                     NewListBox.ListIt ( Sender, Vat, 'V' );   { VAT Rates }
                     if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
                        begin
                           InputGridCell[Controller.FocusedItem.Index] := NewListBox.ListInfo.ReturnValue;
                           CheckVATForChanges();
                           NextItem := tvCBEVATCodeIndex+1;
                        end;
                  end;

               if Controller.FocusedItem.Index = tvCBEAnalysisCode then
                  begin
                     InputGridCell[tvCBEAnalysisCode] := GetCBEAnalysisCode();
                  end;

               if (Controller.FocusedItem.Index = tvCBEQtyIndex) then
                  EditCBEQuantities(Point);
         end;
      end;

   FocusItem(NextItem);
end;

procedure TFMainScreen.beBankAccountPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
   case AButtonIndex of
      0 : begin
             NewListBox.ListIt ( Sender, Banks, 'N' );
             if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
                begin
                   BankAccountnumber := NewListBox.ListInfo.ReturnValue;
                   beBankAccount.text := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ),1);
                end;
          end;
   end;
end;

procedure TFMainScreen.beBankAccountDblClick(Sender: TObject);
begin
   beBankAccountPropertiesButtonClick(Sender, 0);
end;

procedure TFMainScreen.beBankAccountKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_F2 then
      beBankAccountPropertiesButtonClick(Sender,0);
end;

procedure TFMainScreen.MyInputGridDateOnCloseUp(Sender: TObject);
begin
   // CheckNumericColumns(InputTransGridTableView.DataController.FocusedRecordIndex);
   if (Sender is TcxDateEdit) then
      (Sender as TcxDateEdit).PostEditValue;
end;

procedure TFMainScreen.ClearInputGrid;
var
   i, j : Integer;
begin
   InputGridInEditState := False;
   gbCBEHeaderPanel.Caption := 'Enter Cashbook Transaction';

   InputTransGridTableView.DataController.BeginFullUpdate;
   try
      InputTransGridTableView.DataController.RecordCount := 0;
      InputTransGridTableView.OptionsView.Footer := False;
      InputTransGridTableView.DataController.RecordCount := 1;
   finally
      InputTransGridTableView.DataController.EndFullUpdate;
      SetInputGridHeight();
      PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBEDateIndex,0);
   end;
end;

procedure TFMainScreen.actAddAnotherLineExecute(Sender: TObject);
begin
   AddAnotherLine;
end;

procedure TFMainScreen.cbTransTypeGroupPropertiesChange(Sender: TObject);
var
   i : integer;
begin
   if cbTransTypeGroup.ItemIndex = 0 then
      begin
         cxGridColumn := InputTransGridTableView.FindItemByName('CustSupp');
         if cxGridColumn <> nil then
            begin
               cxGridColumn.Caption := 'Customer';
               TcxButtonEditProperties(cxGridColumn.Properties).OnButtonClick := CustomerButtonEditClick;
            end;

         cxGridColumn := InputTransGridTableView.FindItemByName('ExpenseIncome');
         if cxGridColumn <> nil then
            cxGridColumn.Caption := 'Income Account';

         Prog := CashInc;
         TransTypeLabel.Caption := '(Entering Sales)';
      end
   else
      begin
         cxGridColumn := InputTransGridTableView.FindItemByName('CustSupp');
         if cxGridColumn <> nil then
            begin
               cxGridColumn.Caption := 'Supplier';
               TcxButtonEditProperties(cxGridColumn.Properties).OnButtonClick := SupplierButtonEditClick;
            end;

         cxGridColumn := InputTransGridTableView.FindItemByName('ExpenseIncome');
         if cxGridColumn <> nil then
            cxGridColumn.Caption := 'Expense Account';

           Prog := CashExp;
           TransTypeLabel.Caption := '(Entering Purchases)';
        end;
  LoadPreferences;
  ClearInputGrid;
  custsuppaccount := '';
  FSupplierCustomerUserText := '';
end;

function TFMainScreen.GetInputGridCell(Index: Integer): Variant;
begin
   Result := varNull;
   if Index > -1 then
      Result := InputTransGridTableView.DataController.Values[InputTransGridTableView.DataController.FocusedRecordIndex, Index];
end;

function TFMainScreen.GetTransGridCell(Index: Integer): Variant;
begin
   Result := NULL;
   if Index > -1 then
      Result := TransactionGridTableView.DataController.Values[TransactionGridTableView.DataController.FocusedRecordIndex, Index];
end;

procedure TFMainScreen.SetInputGridCell(Index: Integer;
  const Value: Variant);
begin
   InputTransGridTableView.DataController
      .Values[InputTransGridTableView.DataController.FocusedRecordIndex, Index]
         := Value;
end;

procedure TFMainScreen.SetTransGridCell(Index: Integer;
  const Value: Variant);
begin
   TransactionGridTableView.DataController
      .Values[TransactionGridTableView.DataController.FocusedRecordIndex, Index]
         := Value;
end;

function TFMainScreen.GetInputGridRecordIndex: Integer;
begin
   Result := InputTransGridTableView.DataController.FocusedRecordIndex;
end;

procedure TFMainScreen.SetupSimpleLayout;
begin

end;

procedure TFMainScreen.SetupSearchDefaults;
begin
   with cbSearchTransactionTypes.Items do
      begin
         BeginUpdate;
         try
            Clear;
            if not Cash1.XCASHBOOK Then
               begin
                  with Add do
                    begin
                       Text := (ReadLang(15, CurrLang)); //Sales Invoice
                       Checked := False;
                    end;
                  with Add do
                    begin
                       Text := (ReadLang(17, CurrLang)); //Sales Cash Sale
                       Checked := False;
                    end;
                  with Add do
                    begin
                       Text := (ReadLang(16, CurrLang)); //Sales Reciept
                       Checked := False;
                    end;
                  with Add do
                    begin
                       Text := (ReadLang(46, CurrLang)); //Sales Credit Note
                       Checked := False;
                    end;
                  with Add do
                    begin
                       Text := (ReadLang(18, CurrLang)); //Purchase Invoice
                       Checked := False;
                    end;
                  with Add do
                    begin
                       Text := (ReadLang(115, CurrLang)); //Purchase Cash Purchase
                       Checked := False;
                    end;
                  with Add do
                    begin
                       Text := (ReadLang(19, CurrLang));//Purchase Payment
                       Checked := False;
                    end;
                  with Add do
                    begin
                       Text := (ReadLang(47, CurrLang));//Purchase Credit Note
                       Checked := False;
                    end;
                  with Add do
                    begin
                       Text := (ReadLang(152, CurrLang));//Others
                       Checked := False;
                    end;
                  with Add do
                    begin
                       Text := (ReadLang(21, CurrLang)); //Cashbook Income
                       Checked := False;
                    end;
                  with Add do
                    begin
                       Text := (ReadLang(22, CurrLang)); //Cashbook Expenditure
                       Checked := False;
                    end;
               end
            else
               begin
                  with Add do
                    begin
                       Text := (ReadLang(152, CurrLang)); //Others
                       Checked := False;
                    end;
                  with Add do
                    begin
                       Text := (ReadLang(21, CurrLang)); //Cashbook Income
                       Checked := False;
                    end;
                  with Add do
                    begin
                       Text := (ReadLang(22, CurrLang)); //Cashbook Expenditure
                       Checked := False;
                    end;
               end;
       finally
          EndUpdate;
       end;
    end;

   if not Cash1.XCASHBOOK Then
      begin
         lCustomer.Visible := True;
         lSupplier.Visible := True;
         cmboCustomer.Visible := True;
         cmboSupplier.Visible := True;
      end
   else
      begin
         lCustomer.Visible := False;
         lSupplier.Visible := False;
         cmboCustomer.Visible := False;
         cmboSupplier.Visible := False;
      end;
end;

procedure TFMainScreen.btnHelpClick(Sender: TObject);
begin
   Application.HelpContext(194);
end;

procedure TFMainScreen.ShowSearchBar(const AShow: Boolean);
begin
   if (AShow) then
      begin
         // clear down existing editing transaction if any.
         ResetCashbookTransaction(IsEditingCashbookTransaction);
      end;

   dxBarManager.LockUpdate := True;
   TransactionGrid.BeginUpdate;
   dxBarControlContainerItemSearchPanel.Control := SearchPanel;
   dxBarManager.Bars[3].Visible := AShow;
   TransactionGrid.EndUpdate;
   dxBarManager.LockUpdate := False;

   if AShow then
      begin
         // If the user is searching the grid via custom search box then
         // we should not allow the filter bar to be shown
         TransactionGridTableView.FilterBox.Visible := fvNever;

         SearchPanel.Font.Name := 'Tahoma';
         SearchPanel.Font.Size := 8;
         SearchPanel.Visible := True;
         SearchPanel.Width := Width-10;
         if ceSearchTransNo.CanFocus then
            ceSearchTransNo.SetFocus;
      end
   else
      begin
         // If the user is searching the grid via custom search box then
         // we should not allow the filter bar to be shown
         TransactionGridTableView.FilterBox.Visible := fvNonEmpty;
      end;

end;

procedure TFMainScreen.SearchGrid;
var
   ItemList: TcxFilterCriteriaItemList;
   i, j : Integer;
begin
   Screen.Cursor := crHourGlass;
   try
      with TransactionGridTableView.DataController do
         try
            Filter.BeginUpdate;
            Filter.Active := False;
            Filter.Clear;
            Filter.Root.Clear;

            ceSearchTransNo.PostEditValue;
            deSearchTransactionFrom.PostEditValue;
            deSearchTransactionTo.PostEditValue;
            teSearchReference.PostEditValue;
            teSearchCommentOrStub.PostEditValue;
            ceVATDiscount.PostEditValue;
            ceSearchAmount.PostEditValue;

            if ceSearchTransNo.Value > 0 then
               Filter.Root.AddItem( GetItem(tvTxNoIndex), foEqual, ceSearchTransNo.Value, FormatFloat('#', ceSearchTransNo.Value));
            if deSearchTransactionFrom.Date > 0 then
               Filter.Root.AddItem( GetItem(tvDateIndex), foGreaterEqual, deSearchTransactionFrom.Date,deSearchTransactionFrom.Text);
            if deSearchTransactionTo.Date > 0 then
               Filter.Root.AddItem( GetItem(tvDateIndex), foLessEqual, deSearchTransactionTo.Date,deSearchTransactionTo.Text);
            if Trim(teSearchReference.Text) <> '' then
               Filter.Root.AddItem( GetItem(tvRefIndex), foLike, '%'+teSearchReference.Text+'%',teSearchReference.Text);
            if Trim(teSearchCommentOrStub.Text) <> '' then
               Filter.Root.AddItem( GetItem(tvCommentStubNoIndex), foLike, '%'+teSearchCommentOrStub.Text+'%',teSearchCommentOrStub.Text);
            if ceVATDiscount.Value > 0 then
               Filter.Root.AddItem( GetItem(tvVATorDiscountIndex), foEqual, ceVATDiscount.Value,
                   FormatFloat(ceVATDiscount.Properties.DisplayFormat, ceVATDiscount.Value));
            if ceSearchAmount.Value > 0 then
               Filter.Root.AddItem( GetItem(tvAmountIndex), foEqual, ceSearchAmount.Value,
                   FormatFloat(ceSearchAmount.Properties.DisplayFormat, ceSearchAmount.Value));
            if (Trim(cmboCustomer.Text) <> '') then
               begin
                  if cmboCustomer.Properties.Items.IndexOf(Trim(cmboCustomer.Text)) = -1 then
                     Filter.Root.AddItem( GetItem(tvCustomerSupplierIndex), foLike, '%'+Trim(cmboCustomer.Text)+'%',Trim(cmboCustomer.Text))
                  else
                     Filter.Root.AddItem( GetItem(tvCustomerSupplierIndex), foEqual, Trim(cmboCustomer.Text),Trim(cmboCustomer.Text));
               end
            else if (Trim(cmboSupplier.Text) <> '') then
               begin
                  if cmboSupplier.Properties.Items.IndexOf(Trim(cmboSupplier.Text)) = -1 then
                     Filter.Root.AddItem( GetItem(tvCustomerSupplierIndex), foLike, '%'+Trim(cmboSupplier.Text)+'%',Trim(cmboSupplier.Text))
                  else
                     Filter.Root.AddItem( GetItem(tvCustomerSupplierIndex), foEqual, Trim(cmboSupplier.Text),Trim(cmboSupplier.Text));
               end
            else if (Trim(teSearchDescription.Text) <> '') then
               begin
                  Filter.Root.AddItem( GetItem(tvCustomerSupplierIndex), foLike, '%'+Trim(teSearchDescription.Text)+'%',Trim(teSearchDescription.Text));
               end;

            //   22/03/17 [V5.6 R6.7] /MK Bug Fix - Along with the fix where the cmboCustomers only contains Customers and cmboSuppliers only contains Suppliers
            //                                      this new set of code will assign the type of transactions that are associated to whatever cmbo is being searched on.
            ItemList := nil;
            if ( ItemList = nil ) then
               begin
                  if ( Length(cmboCustomer.Text) > 0 ) then
                     for i := 0 to cbSearchTransactionTypes.Count-1 do
                        begin
                           if ItemList = nil then
                              ItemList := Filter.Root.AddItemList(fboOr);
                           for j := Low(SalesTxDescTypes) to High(SalesTxDescTypes) do
                              if ( cbSearchTransactionTypes.Items[i].Text = ReadLang(SalesTxDescTypes[j], CurrLang) ) then
                                 ItemList.AddItem(GetItem(tvTransTypeIndex),foEqual,cbSearchTransactionTypes.Items[i].Text,cbSearchTransactionTypes.Items[i].Text);
                        end;
                  if ( Length(cmboSupplier.Text) > 0 ) then
                     for i := 0 to cbSearchTransactionTypes.Count-1 do
                        begin
                           if ItemList = nil then
                              ItemList := Filter.Root.AddItemList(fboOr);
                           for j := Low(PurchaseTxDescTypes) to High(PurchaseTxDescTypes) do
                              if ( cbSearchTransactionTypes.Items[i].Text = ReadLang(PurchaseTxDescTypes[j], CurrLang) ) then
                                 ItemList.AddItem(GetItem(tvTransTypeIndex),foEqual,cbSearchTransactionTypes.Items[i].Text,cbSearchTransactionTypes.Items[i].Text);
                        end;
               end;

            for i := 0 to cbSearchTransactionTypes.Count-1 do
               begin
                  if cbSearchTransactionTypes.Items[i].Checked then
                     begin
                        if ItemList = nil then
                           ItemList := Filter.Root.AddItemList(fboOr);
                        ItemList.AddItem(GetItem(tvTransTypeIndex),foEqual,cbSearchTransactionTypes.Items[i].Text,cbSearchTransactionTypes.Items[i].Text);
                     end;
               end;

         finally
            if ( Filter.Root.Count > 0 ) then
               begin
                  Filter.Active := True;
                  ShowSearchBar(False);
                  if ( TransactionGridTableView.DataController.FilteredRecordCount <= 0 ) then
                     begin
                        MessageDlg('No search results have been found.',mtInformation,[mbOK],0);
                        ClearSearch;
                     end
                  else
                     begin
                        ClearSearchBtn.Font.Color := clRed;
                        ClearSearchBtn.Font.Name := 'Segoe UI';
                        ClearSearchBtn.Font.Style := [fsBold, fsItalic];
                        ClearSearchBtn.Invalidate;
                        TransactionGridTableView.Controller.FocusedRowIndex := 0;
                        TransactionGrid.SetFocus;
                     end;
               end
            else
               MessageDlg('No search criteria has been entered.',mtWarning,[mbOK],0);
            Filter.EndUpdate;
         end;
   finally
      Screen.Cursor := crDefault;
   end;
end;

procedure TFMainScreen.actSearchGridExecute(Sender: TObject);
begin
   SearchGrid;
end;

procedure TFMainScreen.ClearSearchFields;
var
   i : Integer;
begin
   ceSearchTransNo.EditValue := Null;
   deSearchTransactionFrom.EditValue := Null;
   deSearchTransactionTo.EditValue := Null;
   ceVATDiscount.EditValue := Null;
   teSearchReference.EditValue := Null;
   teSearchCommentOrStub.EditValue := Null;
   ceSearchAmount.EditValue := Null;
   teSearchDescription.EditValue := Null;
   cmboCustomer.EditValue := Null;
   cmboSupplier.EditValue := Null;
   for i := 0 to cbSearchTransactionTypes.Count-1 do
      cbSearchTransactionTypes.Items[i].Checked := False;
end;

procedure TFMainScreen.ClearSearch;
begin
   with TransactionGridTableView.DataController do
      begin
         Filter.Active := False;
         Filter.Clear;
         Filter.Root.Clear;
      end;
   ClearSearchFields;
   ClearSearchBtn.Font.Color := clBlack;
   ClearSearchBtn.Font.Name := 'Segoe UI';
   ClearSearchBtn.Font.Style := [];
   ClearSearchBtn.Invalidate;
end;

procedure TFMainScreen.cmboCustomerPropertiesChange(Sender: TObject);
var
   i : Integer;
begin
   teSearchDescription.Text := '';
   cmboSupplier.Text := '';
end;

procedure TFMainScreen.cmboSupplierPropertiesChange(Sender: TObject);
var
   i : Integer;
begin
   teSearchDescription.Text := '';
   cmboCustomer.Text := '';
end;

procedure TFMainScreen.teSearchDescriptionPropertiesChange(
  Sender: TObject);
begin
   cmboSupplier.Text := '';
   cmboCustomer.Text := '';
end;

procedure TFMainScreen.btnSearchCancelClick(Sender: TObject);
begin
   actClearSearch.execute;
end;

procedure TFMainScreen.PositionMenuButtons;
const
   cMenuButtonPositions : array [0..5] of Integer = (14,130,246,362,478,594);
var
   i : Integer;
   ButtonArray : array of TcxButton;
begin
   btnSalesGroup.Width := 110;
   btnPurchaseGroup.Width := 110;
   btnBankActions.Width := 110;
   btnOtherGroup.Width := 110;
   btnCashbookGroup.Width := 110;
   btnCoOpImport.Width := 110;

   SetLength(ButtonArray,0);
   for i := 0 to pMenuButtonPanel.ControlCount-1 do
      begin
         if (pMenuButtonPanel.Controls[i] is TcxButton) then
            if (pMenuButtonPanel.Controls[i] as TcxButton).Visible then
               begin
                  SetLength(ButtonArray, Length(ButtonArray)+1);
                  ButtonArray[Length(ButtonArray)-1] := (pMenuButtonPanel.Controls[i] as TcxButton);
               end;
      end;

   if Length(ButtonArray) > 0 then
      begin
         QuickSort(ButtonArray,Low(ButtonArray),High(ButtonArray));
         for i := Low(ButtonArray) to High(ButtonArray) do
            begin
               ButtonArray[i].Left := cMenuButtonPositions[i];
            end;
      end;
end;

procedure QuickSort(var AButtonArray : array of TcxButton; ALo, AHi: Integer);
var
  Lo, Hi,  Pivot: Integer; Button: TcxButton;
begin
   Lo := ALo;
   Hi := AHi;
   Pivot := AButtonArray[(Lo + Hi) div 2].Tag;
  repeat
    while AButtonArray[Lo].Tag < Pivot do Inc(Lo) ;
    while AButtonArray[Hi].Tag > Pivot do Dec(Hi) ;
    if Lo <= Hi then
    begin
      Button := AButtonArray[Lo];
      AButtonArray[Lo] := AButtonArray[Hi];
      AButtonArray[Hi] := Button;
      Inc(Lo) ;
      Dec(Hi) ;
    end;
  until Lo > Hi;
  if Hi > ALo then QuickSort(AButtonArray, ALo, Hi) ;
  if Lo < AHi then QuickSort(AButtonArray, Lo, AHi) ;
end;

procedure TFMainScreen.FormResize(Sender: TObject);
begin
   if (Width < 762) then
      Width := 762
   else if (Height < 580) then
      Height := 580;
   CenterMenuPanel(pCashBookMenu);
   InputTransGrid.Width := CalcInputGridWidth;
end;

procedure TFMainScreen.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
   if (NewWidth < 762) then
      Resize := False
   else if (NewHeight < 580) and ( Resize ) then
      Resize := False;
end;

procedure TFMainScreen.AddAnotherLine;
begin
   CheckCBRowOK;
   InputGridInEditState := True;

   with InputTransGridTableView.DataController do
      begin
         RecordCount := RecordCount+1;
         FocusedRecordIndex := RecordCount-1;
         Values[FocusedRecordIndex, tvCBEDateIndex ] := Values[FocusedRecordIndex-1, tvCBEDateIndex ];
         Values[FocusedRecordIndex, tvCBEStubIndex ] := Values[FocusedRecordIndex-1, tvCBEStubIndex ];
         Values[FocusedRecordIndex, tvCommentStubNoIndex ] := Values[FocusedRecordIndex-1, tvCommentStubNoIndex ];
         Values[FocusedRecordIndex, tvCBECustSuppIndex ] := Values[FocusedRecordIndex-1, tvCBECustSuppIndex ];
         Values[FocusedRecordIndex, tvCBERefIndex ] := Values[FocusedRecordIndex-1, tvCBERefIndex ];

         // SP 19/06/2015 - (GL) we no longer want to default the Ent Code value as the nominal
         // column will precede the Ent column ( as per Preference cPref_AutoEntSelect ) therefore
         // the Ent column value is auto selected when the nominal column value changes
         { SP 19/06/2015 - if (not cash11.xuse_enterprise) then
            Values[FocusedRecordIndex, tvCBEEntIndex ] := Values[FocusedRecordIndex-1, tvCBEEntIndex ];}
      end;

   // Adjust height of InputTransGrid if possible.
   SetInputGridHeight();
   InputTransGrid.SetFocus;

   EnableCBEActions();
   if (tvCBENomDescIndex > -1) then
      PostMessage(Handle, WM_FOCUSNEXTITEM, tvCBENomDescIndex,0);
end;

procedure TFMainScreen.DeleteLine;
begin
   if ( InputTransGridTableView.DataController.RecordCount <= 1 ) then
      begin
         MessageDlg('There must be a minimum of 1 line per transaction.',mtInformation,[mbOK],0);
      end
   else if InputTransGridTableView.DataController.FocusedRecordIndex <= -1 then
      MessageDlg('No line has been selected for deletion.',mtWarning,[mbOK],0)
   else if MessageDlg('Are you sure you want to remove this line?',mtConfirmation,[mbYes,mbNo],0) = idYes then
      begin
         InputTransGridTableView.DataController.DeleteRecord(InputTransGridTableView.DataController.FocusedRecordIndex);
         SetInputGridHeight();
      end;

   EnableCBEActions();
end;

procedure TFMainScreen.InputTransGridTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
   if ( AItem <> nil ) and ( ARecord <> nil ) then
      begin
         AStyle := cxStyleNormal;
         if ( ARecord.Focused ) and ( AItem.Focused )then
            AStyle := cxStyleFocused;
      end;
end;

procedure TFMainScreen.DisposeTransPointers;
begin
   // clear & reset pointers
   AccsDataModule.DisposeTransPointers;
end;

procedure TFMainScreen.InitialiseTransPointers;
begin
   // initialise the pointers etc required for writing a transaction
   AccsDataModule.InitialiseTransPointers;
end;

function TFMainScreen.Transaction_RowCount: Integer;
var
   i : Integer;
begin
   Result := 0;
   for I := 1 to 100 do if zGen[1,i] <> 0 then Inc(Result);
end;

procedure TFMainScreen.DoLoadTransactionData(var Message: TMessage);
begin
   if Message.Msg = WM_LOADTRANSACTIONDATA then
      LoadTransactionGrid;
end;

procedure TFMainScreen.actDeleteLineExecute(Sender: TObject);
begin
   DeleteLine;
end;

procedure TFMainScreen.actDeleteLineUpdate(Sender: TObject);
begin
   actDeleteLine.Enabled := btnDeleteLine.Visible and InputGridInEditState;
end;

procedure TFMainScreen.InputTransGridTableViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
var
   RecordIndex : Integer;
begin
   if (AItem.Index in ([tvCBEDateIndex, tvCBECustSuppIndex,tvCBEStubIndex,tvCommentStubNoIndex,tvCBERefIndex])) then
      begin
         // prevent user from editing the customer/supplier for any record other than the first.
         AAllow := InputTransGridTableView.DataController.FocusedRecordIndex = 0;
      end;
end;

procedure TFMainScreen.NotifyCustomerSupplierChange;
var
   CustSuppValue : Variant;
   i : Integer;
begin
   with InputTransGridTableView.DataController do
      begin
         // ensure each record displays the same supplier/customer as first record.
         if ( RecordCount > 1 ) then
            begin
               CustSuppValue := Values[0, tvCBECustSuppIndex];
               if not VarIsNull(CustSuppValue) then
                  begin
                     for i := 1 to RecordCount-1 do
                        begin
                           Values[i, tvCBECustSuppIndex] := CustSuppValue;
                        end;
                  end;
            end;
      end;
end;

procedure TFMainScreen.CheckCBRowOK;
var
   ErrorColIndex : Integer;
   ErrText : String;
begin
   { Ensure all data rows have correct values }
   ErrorColIndex := RowOK(InputTransGridTableView.DataController.RecordCount-1);
   if ( ErrorColIndex > -1 ) then
      begin
         if ErrorColIndex = tvCBENomIndex then
            ErrText := 'Nominal Code'
         else if ErrorColIndex = tvCBEAmtIndex then
            ErrText := 'Amount'
         else if ErrorColIndex = tvCBEVATCodeIndex then
            ErrText := 'VAT Code'
         else if ErrorColIndex = tvCBEVATIndex then
            ErrText := 'VAT Amount'
         else if ErrorColIndex = tvCBEDateIndex then
            ErrText := 'Date'
         {else if ErrorColIndex = tvCBEDateIndex then
            ErrText := 'Date'
         else if ErrorColIndex = tvCBEDateIndex then
            ErrText := 'Date'}
         else
            ErrText := 'UnKnown Field';
         MessageDlg('Unable to add another line. '+#13#10+#13#10+'"'+ErrText+'" must have a value.',mtError,[mbOK], 0);
         Abort;
      end;
end;

procedure TFMainScreen.btnCoOpImportClick(Sender: TObject);
begin
  InvokeCoOpImportPopup();
end;

procedure TFMainScreen.beBankAccountPropertiesChange(Sender: TObject);
begin
   ceBankBalance.Value := AccsDataModule.GetBankBalance(beBankAccount.Text);
end;

procedure TFMainScreen.FormDestroy(Sender: TObject);
begin
   HideHint();
   if TransactionGridTableView.Columns[0] <> nil then // ensure atleast 1 column is present before saving
      begin
         TransactionGridTableView.StoreToIniFile( IncludeTrailingBackslash( ApplicationPath ) + cTransGridIniFile);
      end;
end;

procedure TFMainScreen.CBEItemOnChange(Sender: TObject);
var
  Edit: TcxCustomEdit;
  NewValue: Variant;
begin
   if FGridDesigning then Exit;

   Edit := Sender as TcxCustomEdit;
   NewValue := Edit.EditingValue;

   if ( InputTransGridTableView.Controller.FocusedItem <> nil ) and
      ( InputTransGridTableView.Controller.FocusedItem.Index = tvCBECustSuppIndex ) then
      FSupplierCustomerUserText := Trim(VarToStr(NewValue));
end;

procedure TFMainScreen.InputTransGridTableViewCBEDatePropertiesInitPopup(
  Sender: TObject);
begin
//   if FCBEDate <= 0 then
//      FCBEDate := Date;
//   (Sender as TcxDateEdit).Date := FCBEDate;
end;

function TFMainScreen.CalcInputGridWidth: Integer;
var
   ColIndex, TotalColumnWidth : Integer;
   MaxWidthDeterminedByScreenWidth : Integer;
begin
   TotalColumnWidth := 0;
   for ColIndex := 0 to InputTransGridTableView.ColumnCount-1 do
      begin
         if InputTransGridTableView.Columns[ColIndex].Visible then
             TotalColumnWidth := TotalColumnWidth + InputTransGridTableView.Columns[ColIndex].Width;
      end;
   Result := TotalColumnWidth + 16;

   if (IsCBEEntryGridVerticalScrollBarVisible) then
      Result := Result + 24;


   MaxWidthDeterminedByScreenWidth := Round(pCBEEntry.Width * 0.85);

   if (Result > MaxWidthDeterminedByScreenWidth) then
       Result := MaxWidthDeterminedByScreenWidth;
end;

procedure TFMainScreen.SetInputGridHeight;
var
   NewHeight : Integer;
   InitialGridHeight : Integer;
begin
   NewHeight := InputTransGrid.Height;
   InputTransGrid.BeginUpdate;
   try
   if (InputTransGridTableView.DataController.RecordCount > 1) then
      begin
         InputTransGridTableView.OptionsView.Footer := True;

         // Check if we have enough space available to increase the InputTransGrid height by cDefaultCBEGridRowHeight value
         if (ViewPageControl.Height > (ViewPageControl.Constraints.MinHeight + cDefaultCBEGridRowHeight)) then
             begin
                InitialGridHeight := GetCBEEntryDefaultHeight();

                NewHeight := InitialGridHeight +
                             ((InputTransGridTableView.DataController.RecordCount - 1) * cDefaultCBEGridRowHeight) +
                             cDefaultCBEGridFooterHeight;
             end
         else
            // Re-calc the grid width this point because the vertical scroll bar will have become visible
            InputTransGrid.Width := CalcInputGridWidth();
      end
   else
      begin
         InputTransGridTableView.OptionsView.Footer := False;
         NewHeight := GetCBEEntryDefaultHeight();
      end;

   //if IsCBEEntryGridHorizontalScrollBarVisible then
   //   NewHeight := NewHeight + 22;

   if (InputTransGrid.Height <> NewHeight) then
      InputTransGrid.Height := NewHeight;

   // 85 = InputTransGrid.Top
   // 64 = Bottom of InputGrid to bottom of pCBEEntry
   pSimpleLayout.Height := 85 + InputTransGrid.Height + 64;
   finally
      InputTransGrid.EndUpdate;
   end;
end;

procedure TFMainScreen.WizardTimerTimer(Sender: TObject);
begin
   WizardTimer.Enabled := False;
   TfmSetupWizard.ShowIfRequired;
   ceBankBalance.Value := AccsDataModule.GetBankBalance(beBankAccount.Text);
end;

procedure TFMainScreen.actBudgetsExecute(Sender: TObject);
begin
   CheckCashbookEntryGridState();
   TfmBudgets.ShowBudget;
end;

procedure TFMainScreen.InputTransGridTableViewEditChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
var
   TempValue : Variant;
begin
   if (AItem = nil) then Exit;

   // We should reset the tvCBENomIndex to null when the tvCBENomDescIndex changes and
   // is null/empty or Nominal Code is being typed.
   if (AItem.Index = tvCBENomDescIndex) then
      begin
         TempValue := AItem.EditValue;
         if (VarIsNull(TempValue)) or

        // Reset tvCBENomIndex to null if user is typing in nominal code (e.g 401)
        // rather than description "SALES DISCOUNTS"
        // when tvCBENomDescIndex is exited, the correct tvCBENomIndex value will be re-fetched
           ((not VarIsNull(TempValue)) and IsNumeric(TempValue)) then
         SendMessage(Handle, WM_RESETNOMVALUE, 0, 0);
      end;
end;

procedure TFMainScreen.DoResetNomValue(var Message: TMessage);
var
   ctrl :  TcxButtonEdit;
begin
  if Message.Msg = WM_RESETNOMVALUE then
      begin
         InputGridCell[tvCBENomIndex] := '';
         InputGridCell[tvCBENomFreeEntryDescIndex] := '';

         ctrl := InputTransGridTableView.Controller.EditingController.Edit as TcxButtonEdit;
         if ctrl <> nil then
            begin
               ctrl.SelStart := Length(ctrl.Text);
            end;
      end;
end;

procedure TFMainScreen.InputTransGridTableViewNomDescEditValueChanged(
  Sender: TObject);
begin
   TcxButtonEdit(Sender).PostEditValue;
end;

procedure TFMainScreen.InputTransGridTableViewCBEDateKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin

   if ( Key = VK_RETURN ) then
      begin

         if ( Sender is TcxDateEdit ) then
            begin

               (Sender as TcxDateEdit). PopupWindow.Popup( InputTransGrid );

            end;


      end;
end;

procedure TFMainScreen.actViewManualExecute(Sender: TObject);
begin
   ShellExecute(Handle, 'open', 'http://www.kingswood.ie/download/kwaccsmanual.pdf', nil, nil, SW_SHOWNORMAL);
end;

function TFMainScreen.GetCBEEntryDefaultHeight: Integer;
begin
   if (IsCBEEntryGridHorizontalScrollBarVisible) then
      Result:= 76
   else
      Result := 54;
end;

procedure TFMainScreen.dxBarLargeButton6Click(Sender: TObject);
begin
   with TfmEnterpriseAnalysisByChart.Create(nil) do
      try
          ShowModal;
      finally
         Free;
      end;
end;

procedure TFMainScreen.actBusinessSummaryExecute(Sender: TObject);
begin
   CheckCashbookEntryGridState();

   TfmEnterpriseAnalysisByChart.ShowSummary();
end;

function TFMainScreen.IsLastColumn(View: TcxGridTableView;
  Item: TcxCustomGridTableItem): Boolean;
begin
   Result := (Item.Index = View.VisibleItems[View.VisibleItemCount-1].Index);
end;

procedure TFMainScreen.ThisOnChanged(Sender: TObject);
begin
   //
   ShowMessage('OnChanged');
end;

procedure TFMainScreen.ThisOnEditValueChanged(Sender: TObject);
var
   IsMultiLine : Boolean;
   EditValue : Variant;
   cxCustomEdit : TcxCustomEdit;
begin
   if (Sender = nil) then Exit;

   if (InputTransGridTableView.Controller.EditingItem = nil ) then Exit;

   if (GEditing) then
      begin
         cxCustomEdit := InputTransGridTableView.Controller.EditingController.Edit as TcxCustomEdit;
         if (cxCustomEdit = nil) then Exit;

         cxCustomEdit.PostEditValue;

         IsMultiLine := InputTransGridTableView.DataController.RecordCount > 1;
         if (InputTransGridTableView.Controller.EditingItem.Index in [tvCBEDateIndex,tvCBEStubIndex,tvCBECustSuppIndex,tvCBERefIndex]) then
            begin
               if (IsMultiLine) then
                  begin
                     // Do not change the first line
                     EditValue := InputGridCell[InputTransGridTableView.Controller.EditingItem.Index];
                     //if ((not VarIsNull(EditValue)) and (EditValue > 0)) then
                     CopyCellValueToAllLines(InputTransGridTableView.Controller.EditingItem.Index, EditValue);
                  end;
            end;
      end;
end;

procedure TFMainScreen.LoadTransaction;
Var
   Counter : Integer;
   Invoice: TInvoice;
   IsPurchSaleInv : Boolean;
begin
  if not GEditing then begin
     { Initialise the Transaction edit record }
     Screen.Cursor := crHourGlass;
     try
        Initialize_TxEditRec;

        if TransactionGridTableView.DataController.RecordCount <= 0 then // No Transactions Available
           MessageDLG('No Transactions available',mtinformation,[mbOK],0)
        else
           begin
              with TransactionGridTableView.DataController do
                 begin

                    TempVar := TransGridCell[tvJourTransIndex];

                    if not VarIsNull(TempVar) then
                       begin
                          if ( TempVar = 'J' ) then { Journal RECORDS }
                             begin
                                GEditing := True;
                                with TxEditRec Do
                                   begin
                                      TempVar := TransGridCell[tvTxNoIndex];
                                      if not VarIsNull(TempVar) then
                                         begin
                                            TransF    := TempVar;
                                            TransT    := 0;
                                            TransType := '  ';
                                            NoRecs    := 0;
                                            TxRow     := FocusedRecordIndex; //TxGrid.Row;
                                         end
                                      else
                                         begin
                                            GEditing := False;
                                            MessageDlg('Invalid value for field "TX No"',mtError,[mbOk],0);
                                            SysUtils.Abort;
                                         end;
                                   end;

                                SetInputGridHeight();

                                TempVar := TransGridCell[tvEditingIndex];
                                //BankAct.BankActivities.Save.Enabled := ( Copy ( TxGrid.Cells[8,TxGrid.Row],1,1 ) = 'T');
                                if not VarIsNull(TempVar) then
                                   begin
                                      Application.CreateForm(TBankActivities, BankActivities );
                                      BankAct.BankActivities.Save.Enabled := (TempVar = 'T');
                                      BankAct.BankActivities.ShowModal;
                                   end
                                else
                                   MessageDlg(Format(cFieldReadError,['Editing']),mtError,[mbOK],0);
                             end
                          else
                             begin
                                // 07/08/02 TGM AB Moved Application.CreateForm(TCashBookForm, CashBookForm );
                                GEditing := True;
                                with TxEditRec Do
                                   begin
                                      TempVar := TransGridCell[tvTxNoIndex];
                                      if not VarIsNull(TempVar) then
                                         begin
                                            TransF    := TempVar;
                                            TransT    := 0;
                                            //TransType := '  ';
                                            //TransType := TxGrid.Cells[7,TxGrid.Row];
                                            TransType := TransGridCell[tvTransTypeIndex];
                                            NoRecs    := 0;
                                            TxRow     := FocusedRecordIndex; //TxGrid.Row;
                                         end
                                      else
                                         begin
                                            GEditing := False;
                                            MessageDlg('Invalid value for field "TX No"',mtError,[mbOk],0);
                                            SysUtils.Abort;
                                         end;
                                   end;

                                // TGM AB 06/08/02 - edited the following lines to allow for simple winaccs environment
                                if ( pSimpleLayout.Visible = True ) then
                                   begin
                                      TransactionEdit;
                                   end
                                else
                                   begin
                                      SetInputGridHeight();

                                      TempVar := TransGridCell[tvEditingIndex];
                                      //CashBook.CashBookForm.Save.Enabled := ( Copy ( TxGrid.Cells[8,TxGrid.Row],1,1 ) = 'T');
                                      if not VarIsNull(TempVar) then
                                         begin
                                            //   20/09/19 [V4.5 R0.5] /MK Change - Only allow Sales and Purchase invoices to be viewed in new Grids - TGM request.
                                            if ( Preferences.ValueAsBoolean[cPref_ShowSalePurchGridMainGrid] ) and
                                               ( (UpperCase(TxEditRec.TransType) = 'SALES INVOICE') or
                                                 (UpperCase(TxEditRec.TransType) = 'PURCHASE INVOICE') ) and
                                               ( MessageDlg('Use the new layout?.',mtConfirmation,[mbYes,mbNo],0) = mrYes ) then
                                               begin
                                                  Invoice := SimpleAccsData.GetInvoice(TxEditRec.TransF);
                                                  if (Invoice is TPurchaseInvoice) then
                                                     begin
                                                        ViewPageControl.ActivePage := tsPurchaseInvoice;
                                                        SimplePurchaseInvoiceFrame.EditInvoice(Invoice);
                                                     end
                                                  else
                                                     begin
                                                        ViewPageControl.ActivePage := tsSalesInvoice;
                                                        SimpleSaleInvoiceFrame.EditInvoice(Invoice);
                                                     end;
                                               end
                                            else
                                               begin
                                                  Application.CreateForm(TCashBookForm, CashBookForm );
                                                  CashBook.CashBookForm.Save.Enabled := (TempVar = 'T');
                                                  CashBook.CashBookForm.ShowModal;
                                               end;
                                         end
                                      else
                                         MessageDlg(Format(cFieldReadError,['Editing']),mtError,[mbOK],0);
                                   end;
                             end;
                       end;
                 end;
           end
     finally
        Screen.Cursor := crDefault;
     end;
  end
  else  // end if not editing
     begin
        if MessageDlg('Do you want to cancel any edits for the current transaction?'+#13#10+#13#10+
                      'All edits since last save will be lost, are you sure?',mtConfirmation,[mbYes,mbNo],0) = idYes then
           begin
              GEditing := False;
              ClearInputGrid;
              LoadTransaction();
           end;
     end;
  ceBankBalance.Value := AccsDataModule.GetBankBalance(beBankAccount.Text);
end;

procedure TFMainScreen.ViewTransaction;
var
   i, rowcount : integer;
   NoPresented : Boolean;
   VatUsed : boolean;
   TxNo : Integer;
   IsCashBookTrans : boolean;
   Point : TPoint;
   TransType : Variant;
begin
   ClearInputGrid;

   Initialize_TxEditRec;

   // No Transactions Available
   if TransactionGridTableView.DataController.RecordCount <= 0 then Exit;

   // Only allow viewing of transaction when in SimpleEntry mode.
   if not (pSimpleLayout.Visible) then
      begin
         lEditTransactionHelperText.Visible := True;
         Exit;
      end;

   if GEditing then Exit;

   Screen.Cursor := crHourGlass;
   try
      Point.x := InputTransGrid.ClientBounds.Left + 10;
      Point.y := InputTransGrid.ClientBounds.Bottom;
      Point := InputTransGrid.ClientToScreen(Point);


      with TransactionGridTableView.DataController do
         begin
            TempVar := TransGridCell[tvJourTransIndex];
            if ((not VarIsNull(TempVar)) and ( TempVar = 'J' )) then
               begin
                  ShowHint('Information', 'This transaction is a journal entry.' +
                                           cCRLF +'Journal entries can only be edited by double clicking the transaction grid.', Point);
                  Exit; // do nothing for Journal Transaction
               end;

            with TxEditRec Do
               begin
                  TempVar := TransGridCell[tvTxNoIndex];
                  if not VarIsNull(TempVar) then
                     begin
                        TransF    := TempVar;
                        TransT    := 0;
                        TransType := TransGridCell[tvTransTypeIndex];
                        NoRecs    := 0;
                        TxRow     := FocusedRecordIndex; //TxGrid.Row;
                     end;
               end;
         end;

         // load the transactions into the variables ready to be read out
         if ( TxEditRec.TransF <= 0 ) then Exit;

         RowCount := 0;
         VatUsed  := False;
         InitialiseTransPointers;
         try
            Initvals;

            // Set Temp Bool to TRUE
            NoPresented := LoadTrans;  // Load the transaction

            if NOT NoPresented then
               begin
                  ShowHint('Information', 'This transaction has been presented. Presented transactions cannot be edited.', Point);
                  Exit;
               end;

            RowCount := Transaction_RowCount;

            if cash11.xuse_vat then
               for I:= 1 to 100 do
                  if ((lowercase(zTax[1,i]) <> 'z') and (lowercase(zTax[1,i]) <> ' ')) then
                     begin
                        VatUsed := True;
                        Break;
                     end;

            TempVar := TransGridCell[tvEditingIndex];
            if not VarIsNull(TempVar) then
               actSaveCBInput.Enabled := ( TempVar = 'T' )
            else
               Exit;

            //   17/01/12 [V4.1 R1.2] /MK Change - TransactionEdit - If IsCashBookTrans Then Load Data To Grid. If Not Show Cashbook Or BankAct Form.
            IsCashBookTrans := (TxWrite.EDType in [11,15]);

            if ((not VatUsed) and (RowCount > 0) and (IsCashBookTrans) ) then
               begin
                  LoadTransactionDetails;             // fill in simple grid

                  TempVar := TransGridCell[tvTxNoIndex];
                  if not VarIsNull(TempVar) then
                     begin
                        TxNo := TempVar;
                        gbCBEHeaderPanel.Caption := Format('Editing Cashbook Transaction - [%d]', [TxNo]);
                     end;

                  lEditTransactionHelperText.Visible := False;
               end
            else
               begin
                  lEditTransactionHelperText.Visible := True;

                  TransType := TransGridCell[tvTransTypeIndex];
                  if VarIsNull(TransType) then
                     TransType := 'Ledger';

                  ShowHint('Information', Format('This is a %s transaction.  '+
                                                  cCRLF +'%s transactions can only be edited by double clicking the transaction grid.',[TransType,TransType]), Point);
               end;

            InputGridInEditState := False;
         finally
            DisposeTransPointers;
         end;
   finally
      Screen.Cursor := crDefault;
   end;
end;

procedure TFMainScreen.TransactionGridTableViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
   HideHint();
   if (AFocusedRecord <> nil) then
      begin
         ViewTransaction;
         FLastSelectedRowIndex := TransactionGridTableView.DataController.FocusedRowIndex;
      end;
end;

procedure TFMainScreen.InputTransGridEnter(Sender: TObject);
begin
   HideHint();
   
   // When the transaction grid record changes, where applicable
   // the transaction details are preloaded into InputGrid. In doing
   // this ensure the GEditing flag is set to True when entering
   // the InputGrid grid

   if (not GEditing) and (TxEditRec.TransF > 0) and (InputGridRecordCount>0) then
      GEditing := True;
end;

function TFMainScreen.GetInputGridRecordCount: Integer;
begin
   Result := InputTransGridTableView.DataController.RecordCount;
end;

procedure TFMainScreen.CenterMenuPanel(APanel: TPanel);
begin
   if APanel.Parent = nil then exit;

   if (APanel.Width < APanel.Parent.Width) then
      APanel.Left := (( APanel.Parent.Width  Div 2 ) - (APanel.Width Div 2))
   else
      begin
         APanel.Align := alClient;
         exit;
      end;

   if (APanel.Height < APanel.Parent.Height) then
      APanel.Top := (( APanel.Parent.Height  Div 2 ) - (APanel.Height Div 2));
end;

procedure TFMainScreen.ViewPageControlDrawTabEx(
  AControl: TcxCustomTabControl; ATab: TcxTab; Font: TFont);
begin
   Font.Style := [fsBold];
   if ( ATab.Index = ViewPageControl.ActivePageIndex) then
      begin
         ATab.Color := clWhite;
         Font.Color := clGreen;
      end
   else
      begin
         ATab.Color := 536870912;
         Font.Color := clBlack;
      end;
   if (ViewPageControl.ActivePage = tsSalesInvoice) then
      SimpleSaleInvoiceFrame.SaleInvHeadBevel.Width := SimpleSaleInvoiceFrame.SalesInvoiceGrid.Width
   else if (ViewPageControl.ActivePage = tsPurchaseInvoice) then
      SimplePurchaseInvoiceFrame.PurchInvHeadBevel.Width := SimplePurchaseInvoiceFrame.PurchaseInvoiceGrid.Width;
end;

procedure TFMainScreen.actNavigateFirstExecute(Sender: TObject);
begin
   TransactionGridTableView.DataController.FocusedRowIndex := 0;
end;

procedure TFMainScreen.actNavigateFirstUpdate(Sender: TObject);
begin
   actNavigateFirst.Enabled :=
         (TransactionGridTableView.DataController.RecordCount>0) and
         (TransactionGridTableView.DataController.FocusedRowIndex <> 0);
end;

procedure TFMainScreen.actNavigatePreviousExecute(Sender: TObject);
begin
   TransactionGridTableView.DataController.FocusedRowIndex := TransactionGridTableView.DataController.FocusedRowIndex-1;
end;

procedure TFMainScreen.actNavigatePreviousUpdate(Sender: TObject);
begin
   actNavigatePrevious.Enabled :=
         (TransactionGridTableView.DataController.RecordCount>0) and
         (TransactionGridTableView.DataController.FocusedRowIndex > 0);
end;

procedure TFMainScreen.actNavigationNextExecute(Sender: TObject);
begin
   if TransactionGridTableView.DataController.FocusedRowIndex < TransactionGridTableView.DataController.RecordCount-1 then
      TransactionGridTableView.DataController.FocusedRowIndex := TransactionGridTableView.DataController.FocusedRowIndex+1;
end;

procedure TFMainScreen.actNavigationNextUpdate(Sender: TObject);
begin
   actNavigationNext.Enabled :=
         (TransactionGridTableView.DataController.RecordCount>-1) and
         (TransactionGridTableView.DataController.FocusedRowIndex < TransactionGridTableView.DataController.RecordCount-1);
end;

procedure TFMainScreen.actNavigateLastExecute(Sender: TObject);
begin
   if TransactionGridTableView.DataController.FocusedRowIndex < TransactionGridTableView.DataController.RecordCount-1 then
      TransactionGridTableView.DataController.FocusedRowIndex := TransactionGridTableView.DataController.RecordCount-1;
end;

procedure TFMainScreen.actNavigateLastUpdate(Sender: TObject);
begin
   actNavigateLast.Enabled  :=
         (TransactionGridTableView.DataController.RecordCount>-1) and
         (TransactionGridTableView.DataController.FocusedRowIndex < TransactionGridTableView.DataController.RecordCount-1);
end;

procedure TFMainScreen.ResetCashbookTransaction(const AConfirmCancel : Boolean);
begin
   if (AConfirmCancel) and
      (MessageDlg('Are you sure you wish to cancel without saving any changes?',
           mtInformation, [mbYes, mbNo], 0) = mrNo) then Exit;


   ClearInputGrid;

//   if GEditing then begin
                 actClearSearch.Enabled := True;
                 actSearchTransactions.Enabled := True;
                 GEditing := false;
                 InitVals;
                 With TxEditRec Do
                      Begin
                           TransF := 0;
                           TransT := 0;
                           TransType := '  ';
                           NoRecs    := 0;
                 End;
                 ReFresh;
                 //LoadTransactionGrid;
   //end;
   custsuppaccount := '';
   FSupplierCustomerUserText := '';

   actSaveCBInput.Enabled := True;
   SetInputGridHeight();
   TransactionGridTableView.DataController.FocusedRowIndex := -1;
end;

function TFMainScreen.GetIsEditingCashbookTransaction: Boolean;
begin
   // When the transaction grid record changes, where applicable
   // the transaction details are preloaded into InputGrid. In doing
   // this ensure the GEditing flag is set to True when entering
   // the InputGrid grid

   Result := (GEditing) and (TxEditRec.TransF > 0) and (InputGridRecordCount>0);
end;

procedure TFMainScreen.ViewPageControlPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
begin
   HideHint();
   pTransactionActions.Visible := False;

   if (ViewPageControl.ActivePage = tsSalesInvoice) then
      begin
         if SimpleSaleInvoiceFrame.ChangesPending() and
            (MessageDlg(Format(cMoveWarning,[tsSalesInvoice.Caption]),mtWarning,[mbYes,mbNo],0)= mrNo) then
               AllowChange := False
            else
               SimpleSaleInvoiceFrame.Initialize();
         SimpleSaleInvoiceFrame.SaleInvHeadBevel.Width := SimpleSaleInvoiceFrame.SalesInvoiceGrid.Width;
      end
   else if (ViewPageControl.ActivePage = tsPurchaseInvoice) then
      begin
         if SimplePurchaseInvoiceFrame.ChangesPending() and
            (MessageDlg(Format(cMoveWarning,[tsPurchaseInvoice.Caption]),mtWarning,[mbYes,mbNo],0)= mrNo) then
               AllowChange := False
            else
               SimplePurchaseInvoiceFrame.Initialize();
         SimplePurchaseInvoiceFrame.PurchInvHeadBevel.Width := SimplePurchaseInvoiceFrame.PurchaseInvoiceGrid.Width;
      end;

   if (AllowChange) then
      begin
         if (NewPage = tsAccountActions) then
            begin
               CenterMenuPanel(pCashBookMenu);
            end
         else if (NewPage = tsTransactionGridView) then
            begin
               bcciTransactionActions.Control := pTransactionActions;
               pTransactionActions.Visible := True;
            end;
      end;
end;

procedure TFMainScreen.actBankFileSelectorSettingsExecute(Sender: TObject);
begin
   TfmBankFileSelectorSettings.ShowSettings;
end;

procedure TFMainScreen.actBankFileImportExecute(Sender: TObject);
begin
   TfmBankFileSelector.ShowBankFileSelector(false);
end;

procedure TFMainScreen.TransactionGridTableViewCanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
   if (ARecord <> nil) then
      begin
         if (InputGridInEditState) and (not InputTransGridIsEmpty) then
            begin
               AAllow := False;
               {'Please complete editing of transaction before moving to another transaction.'}
               MessageDlg(Msg_00001,mtError,[mbOK],0);
            end;
      end;
end;

procedure TFMainScreen.TransactionGridTableViewCanSelectRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
   if (ARecord <> nil) then
      begin
         if (InputGridInEditState) and (not InputTransGridIsEmpty) then
            begin
               AAllow := False;
               {'Please complete editing of transaction before moving to another transaction.'}
               MessageDlg(Msg_00001,mtError,[mbOK],0);
            end;
      end;
end;

procedure TFMainScreen.InputTransGridTableViewEditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
   InputGridInEditState := True;
end;

procedure TFMainScreen.SetInputGridInEditState(const Value: Boolean);
begin
   FInputGridInEditState := Value;

   EnableCBEActions();
end;

procedure TFMainScreen.actEnterNewTransactionExecute(Sender: TObject);
begin
   HideHint();
   ResetCashbookTransaction(False);

   InputGridInEditState := True;
   InputGridCell[tvCBEDateIndex] := FCBEDate;
   InputGridCell[tvCBEVatCalculatedIndex] := 'false';
end;

procedure TFMainScreen.InputTransGridTableViewEditKeyUp(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
   InputGridInEditState := True;
end;

function TFMainScreen.GetUsingSimpleLayout: Boolean;
begin
   Result := pSimpleLayout.Visible;
end;

function TFMainScreen.InputTransGridIsEmpty: Boolean;
var
   i, j : Integer;
begin
   Result := True;
   for i := 0 to InputTransGridTableView.DataController.RecordCount-1 do
      for j := 0 to InputTransGridTableView.ColumnCount-1 do
         if not VarIsNull(InputTransGridTableView.DataController.Values[i,j]) then
            begin
               Result := False;
               Break;
            end;
end;

procedure TFMainScreen.AnalysisCodeClick(Sender: TObject;
  AButtonIndex: Integer);
begin
   InputGridCell[tvCBEAnalysisCode] := GetCBEAnalysisCode();
end;

function TFMainScreen.GetCBEAnalysisCode: string;
begin
   CheckNumericColumns(InputTransGridTableView.DataController.FocusedRecordIndex);
   Application.CreateForm(TSetupAnalysisForm, SetupAnalysisForm);
                          SetupAnalysisForm.ShowWindow(1);
   Result := Setupanalysisform.selectedcode;
end;

procedure TFMainScreen.btnCoopImport3Click(Sender: TObject);
begin
   InvokeCoOpImportPopup();
end;

procedure TFMainScreen.InvokeCoOpImportPopup;
var
   pt : TPoint;
begin
   getCursorPos(pt);
   pmCoopImport.Popup(pt.x,pt.y);
end;

procedure TFMainScreen.actProfitAndLossRptExecute(Sender: TObject);
begin
   CheckCashbookEntryGridState();

   if (NewRepForm = nil) then Exit;

   (Sender as TAction).Enabled := False;
   try
      if (NewRepForm <> nil) then
         NewRepForm.ProfitAndLossBtnClick(NewRepForm.ProfitAndLossBtn);
   finally
      (Sender as TAction).Enabled := True;
   end;
end;

procedure TFMainScreen.actInterYearComparisionRptExecute(Sender: TObject);
begin
   CheckCashbookEntryGridState();

   if (NewRepForm = nil) then Exit;

   (Sender as TAction).Enabled := False;
   try
      if (AccsDataModule.IsEnterpriseInUse(cDairyEnterpriseName)) then
         NewRepForm.ThisYearVsPreviousYears1Click(NewRepForm.ThisYearVsPreviousYears1)
      else
         NewRepForm.miEntSummaryThisYrVslast3YrClick(NewRepForm.miEntSummaryThisYrVslast3Yr);
   finally
      (Sender as TAction).Enabled := True;
   end;
end;

procedure TFMainScreen.actDairyEnterpriseRptExecute(Sender: TObject);
begin
   CheckCashbookEntryGridState();

   if (NewRepForm = nil) then Exit;

   (Sender as TAction).Enabled := False;
   try
       NewRepForm.CostPerUnitBtnClick(NewRepForm.CostPerUnitBtn);
   finally
      (Sender as TAction).Enabled := True;
   end;
end;

procedure TFMainScreen.actFarmSummaryRptExecute(Sender: TObject);
begin
   CheckCashbookEntryGridState();

   if (NewRepForm = nil) then Exit;

   (Sender as TAction).Enabled := False;
   try
      TfmEnterpriseAnalysisByChart.ShowSummary();
   finally
      (Sender as TAction).Enabled := True;
   end;
end;

procedure TFMainScreen.actFarmBudgetRptExecute(Sender: TObject);
begin
   CheckCashbookEntryGridState();

   if (NewRepForm = nil) then Exit;

   (Sender as TAction).Enabled := False;
   try
      TfmBudgets.ShowBudget;
   finally
      (Sender as TAction).Enabled := True;
   end;
end;

procedure TFMainScreen.actTrialBalanceRptExecute(Sender: TObject);
begin
   CheckCashbookEntryGridState();

   if (NewRepForm = nil) then Exit;

   (Sender as TAction).Enabled := False;
   try
       NewRepForm.TrialBalBtnClick(NewRepForm.TrialBalBtn);
   finally
      (Sender as TAction).Enabled := True;
   end;
end;

procedure TFMainScreen.actBankStatementImportAccountActionExecute(Sender: TObject);
begin
   CheckCashbookEntryGridState();
   if not TfmBankFileSelector.ShowBankFileSelector(false) then
      // no files found, load bank import screen allow the file to be loaded via file dialog
      TfmBankImport.RunImport;
end;

procedure TFMainScreen.actCoOpImportAccountActionExecute(Sender: TObject);
begin
   CheckCashbookEntryGridState();
   InvokeCoOpImportPopup();
end;

procedure TFMainScreen.actYearEndOtherAccountAccountExecute(
  Sender: TObject);
begin
   CheckCashbookEntryGridState();
   GEditing := False;
   OthForm.OthersForm.ShowModal;
end;

procedure TFMainScreen.actBankFacilitiesAccountActionExecute(
  Sender: TObject);
begin
   CheckCashbookEntryGridState();
   actBank.Execute;
end;

procedure TFMainScreen.lMoreReportsClick(Sender: TObject);
begin
   CheckCashbookEntryGridState();
   NewRepForm.DisableKeyReportsInvocation := True;
   NewRepForm.ShowModal;
end;

procedure TFMainScreen.lMoreReportsMouseEnter(Sender: TObject);
begin
   lMoreReports.Style.TextColor := clRed;
end;

procedure TFMainScreen.lMoreReportsMouseLeave(Sender: TObject);
begin
   lMoreReports.Style.TextColor := clBlue;
end;

procedure TFMainScreen.pReportsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   lMoreReports.Style.TextColor := clBlue;
end;

procedure TFMainScreen.BankFileImportTimerTimer(Sender: TObject);
var
   bShowBankFileSelectorSettings : Boolean;
begin
   BankFileImportTimer.Enabled := False;
end;

procedure TFMainScreen.CheckCashbookEntryGridState;
begin
   if (InputGridInEditState) and (not InputTransGridIsEmpty) then
      begin
         {'Please complete editing of transaction before moving to another transaction.'}
//         ResetCashbookTransaction(True);
         MessageDlg(Msg_00001,mtError,[mbOK],0);
         Abort;
      end;
end;

function TFMainScreen.GetCashbookTransactionType: TTransactionType;
begin
   if ( cbTransTypeGroup.ItemIndex = 0 ) then
      Result := ttIncome
   else if ( cbTransTypeGroup.ItemIndex = 1 ) then
      Result := ttExpense
   else
      Result := ttOther;
end;

procedure TFMainScreen.InvokeNominalSelector;
begin
   if (CashbookTransactionType = ttExpense) then
      PROG := CASHEXP
   else
      PROG := CASHINC;

   if ((Preferences.ValueAsBoolean[cPref_AutoEntSelect]) and (VarIsNullOrEmpty(InputGridCell[tvCBEEntIndex]))) then
      begin
         // SP 18/06/2013
         // Removed 09/02/2015 requested by GL use same logic as BankImport.
         if (CashbookTransactionType = ttExpense) then
            NewListBox.ListIt ( nil, AllNoms, 'N', IntToStr(AccsDataModule.GetEnterpriseExpenseStart()) ) // << default to Non Enterprise Expense range start
         else
            NewListBox.ListIt ( nil, AllNoms, 'N', IntToStr(AccsDataModule.GetEnterpriseIncomeStart()) ); // << default to Non Enterprise Income range start
    end
   else
      begin
         if not cash11.xuse_enterprise then
            begin
               NewListBox.ListInfo.Ent := VarToStr(InputGridCell[tvCBEEntIndex]);
               SlimAll ( NewListBox.ListInfo.Ent );
            end;

         if (Length(Trim(NewListBox.ListInfo.Ent)) > 0) then
            NewListBox.ListIt ( nil, EntRange, 'N' )   { Nominal Ledger Accounts }
         else
            begin
               if Prog = CASHEXP then
                  NewListBox.ListIt ( nil, OverheadsToLiab, 'N' )   // was overheads
               else if Prog = CASHINC then
                  NewListBox.ListIt ( nil, NonEntToLiab, 'N' );
            end;
      end;
end;

procedure TFMainScreen.ViewPageControlResize(Sender: TObject);
begin
   CenterMenuPanel(pCashBookMenu);
   CenterMenuPanel(pReports);
   CenterMenuPanel(SimpleVatPanel);
   CenterMenuPanel(pSimpleVatReports);
end;

procedure TFMainScreen.GridControlKeyPress(Sender: TObject; var Key: Char);
begin
   Key := System.UpCase(Key);
end;

procedure TFMainScreen.InputTransGridTableViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
var
   CellValue : Variant;
begin
   CellValue := null;
   if ( AItem.Index = tvCBEEntIndex) then
      begin
         CellValue := InputTransGridTableView.DataController.Values[InputTransGridTableView.DataController.FocusedRecordIndex, tvCBEEntIndex];
         if VarIsNull(CellValue) then
            Key := System.UpCase(Key); // only convert 1st char to uppercase.
      end;
end;

procedure TFMainScreen.CBENominalAccountAfterChange;
var
   NominalAccount : TNominalAccount;
begin
   if GEditing then Exit;

   // At this point if the Nom column contains a value we should check if the Ent column also
   // contains a value (by user input), if not populate it automatically.
   // THIS SHOULD ONLY BE DONE IF MODE IS ADDING - NOT EDITING.
   TempVar := InputGridCell[tvCBEEntIndex];
   if VarIsNull(TempVar) then
      begin
         TempVar := InputGridCell[tvCBENomIndex];
         if ( (not VarIsNull(TempVar)) and (Trim(TempVar) <> '') ) then
            begin
               NominalAccount := AccsDataModule.Accounts.GetNominalAccount(TempVar);
               if (NominalAccount <> nil) then
                  begin
                     InputGridCell[tvCBEEntIndex] := NominalAccount.EntCode;
                     InputGridCell[tvCBEQuantity2] := 0;
                     InputGridCell[tvCBEQuantity3] := 0;
                  end;
            end;
      end;
end;

function TFMainScreen.VarHasValue(Value : Variant) : Boolean;
begin
   Result := False;
   if VarIsNull(Value) then Exit;

  case (VarType(Value)) of
     varDouble,
     varSmallint,
     varInteger,
     varSingle,
     varCurrency : Result := True;
     varDate : Result := Value > 0;
     varString : Result := (Length(Trim(Value))>0);
  end;
end;

function TFMainScreen.InputGridTotalColumnWidth: Integer;
var
   ColIndex, TotalColumnWidth : Integer;
begin
   TotalColumnWidth := 0;
   for ColIndex := 0 to InputTransGridTableView.ColumnCount-1 do
      begin
         if InputTransGridTableView.Columns[ColIndex].Visible then
            TotalColumnWidth := TotalColumnWidth + InputTransGridTableView.Columns[ColIndex].Width;
      end;
end;

function TFMainScreen.IsCBEEntryGridHorizontalScrollBarVisible: Boolean;
begin
   Result := TBreakTCXGridSite(InputTransGridTableView.Site).HScrollBarVisible
end;

function TFMainScreen.IsCBEEntryGridVerticalScrollBarVisible: Boolean;
begin
   Result := TBreakTCXGridSite(InputTransGridTableView.Site).VScrollBarVisible
end;

procedure TFMainScreen.EnableCBEActions;
var
   IsMultiLineTransaction : Boolean;
begin
  if (InputGridInEditState) then // If grid is in edit mode due to GEditing or New Transaction
     begin
        actEnterNewTransaction.Visible := False;
        // If editing existing transaction, do not allow user to
        // add/remove transaction lines, only edit of existing transline(s)
        if (GEditing) then
           begin
              actAddAnotherLine.Visible := False;
              actDeleteLine.Visible := False;
              CBENextLineSepBevel.Visible := False;
              btnSaveCBE.Left := 8;
              btnCancelCBE.Left := 88;
           end
        else
           begin
              // user is entering new transaction, show/hide actions
              actAddAnotherLine.Visible := True;
              CBENextLineSepBevel.Visible := True;
              IsMultiLineTransaction := (InputTransGridTableView.DataController.RecordCount > 1);
              if IsMultiLineTransaction then
                 begin
                    btnDeleteLine.Left := 151;
                    actDeleteLine.Visible := True;
                    CBENextLineSepBevel.Left := 270;
                    btnSaveCBE.Left := 280;
                    btnCancelCBE.Left := 360;
                 end
              else
                 begin
                    CBENextLineSepBevel.Left := 151;
                    actDeleteLine.Visible := False;
                    btnSaveCBE.Left := 161;
                    btnCancelCBE.Left := 241;
                 end;
           end;
        actSaveCBInput.Visible := True;
        actCancelCBEInput.Visible := True;
     end
  else
     begin
        actEnterNewTransaction.Visible := True;
        actSaveCBInput.Visible := False;
        actCancelCBEInput.Visible := False;
        actAddAnotherLine.Visible := False;
        btnDeleteLine.Visible := False;
        CBENextLineSepBevel.Visible := False;
     end;
end;

procedure TFMainScreen.HideHint;
begin
   if (FHintStyleController <> nil) then
      begin
         FHintStyleController.HideHint;
         FreeAndNil(FHintStyleController);
      end;
end;

procedure TFMainScreen.ShowHint(const AHintTitle, AHintText : string;
   var APoint : TPoint);
begin
   HideHint();
   FHintStyleController := TcxHintStyleController.Create(nil);
   FHintStyleController.HintStyle.Standard := False;
   FHintStyleController.HintStyle.Color := $00C6FFFF;
   FHintStyleController.HintStyle.IconType := cxhiInformation;
   FHintStyleController.HintStyle.Animate :=cxhaSlideFromLeft;
   FHintStyleController.HintStyle.AnimationDelay := 50;
   FHintStyleController.HintStyle.CallOutPosition := cxbpLeftTop;
   FHintStyleController.HintStyle.CaptionFont.Name := 'Segoe UI';
   FHintStyleController.HintStyle.CaptionFont.Size := 12;
   FHintStyleController.HintStyle.CaptionFont.Style := [fsBold];
   FHintStyleController.HintStyle.CaptionFont.Color := clWindowText;
   FHintStyleController.HintStyle.Font := FHintStyleController.HintStyle.CaptionFont;
   FHintStyleController.HintStyle.Font.Size := 10;
   FHintStyleController.HintStyle.Rounded := True;
   FHintStyleController.HintStyle.RoundRadius := 26;
   FHintStyleController.ShowHint(APoint.x, APoint.y, AHintTitle, AHintText);
end;

procedure TFMainScreen.pSimpleLayoutActionsEnter(Sender: TObject);
begin
   HideHint();
end;

procedure TFMainScreen.gbCBEHeaderPanelEnter(Sender: TObject);
begin
HideHint();
end;

procedure TFMainScreen.pSimpleLayoutActionsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   HideHint();
end;

procedure TFMainScreen.pCBEEntryMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   HideHint();
end;

procedure TFMainScreen.TransactionGridMouseLeave(Sender: TObject);
begin
   HideHint;
end;

procedure TFMainScreen.CopyCellValueToAllLines(const AColIndex : Integer; const AValue : Variant);
var
   i : Integer;
begin
   // Remember, do not change the first line
   for i := 1 to InputTransGridTableView.DataController.RecordCount-1 do
      InputTransGridTableView.DataController.Values[i, AColIndex] := AValue;
end;

procedure TFMainScreen.QuantityButtonEditClick(Sender: TObject;
  AButtonIndex: Integer);
var
   Point : TPoint;
begin
   if (Sender is TcxCurrencyEdit) then
      (Sender as TcxCurrencyEdit).PostEditValue;

   GetCursorPos(Point);
   Point := ScreenToClient(ClientToScreen(Point));
   // try to align to left,bottom of cell
   Point.x := Point.x - 65;
   Point.y := Point.y + cDefaultCBEGridRowHeight;
   EditCBEQuantities(Point);
end;

procedure TFMainScreen.InputTransGridResize(Sender: TObject);
begin
   SetInputGridHeight;
end;

procedure TFMainScreen.EditCBEQuantities(APoint : TPoint);
var
   Qty2, Qty3 : Variant;
begin
   // Post any edits to the quantity before opening the multiple quantity window
   InputTransGridTableView.DataController.PostEditingData;

   if AccsDatamodule.MultipleQuantityHandler(VarToStr(InputGridCell[tvCBEEntIndex]),
              VarToDouble(InputGridCell[tvCBEQuantity2]),
              VarToDouble(InputGridCell[tvCBEQuantity3]),
              Qty2, Qty3,APoint) then
      begin
         if not VarIsNullOrEmpty(Qty2) then
            InputGridCell[tvCBEQuantity2] := Qty2;

         if not VarIsNullOrEmpty(Qty3) then
            InputGridCell[tvCBEQuantity3] := Qty3;
      end;
end;

procedure TFMainScreen.bbNominalAccountListingClick(Sender: TObject);
begin
   SetUpAccounts.NominalAccounts1Click(nil);
end;

procedure TFMainScreen.bbEnterpriseListingClick(Sender: TObject);
begin
   SetUpAccounts.EnterpriseReportClick(nil);
end;

procedure TFMainScreen.blbListingsClick(Sender: TObject);
var
   pt : TPoint;
begin
   getCursorPos(pt);
   pmListings.Popup(pt.x,pt.y);
end;

procedure TFMainScreen.EditNominalFreeTextDescription(APoint: TPoint);
var
  NominalCode : string;
  NominalDescription : string;
begin
   if not Preferences.ValueAsBoolean[cPref_AllowFreeTextForNominalDescriptionColumn] then Exit;

   NominalCode := VarToStr(InputGridCell[tvCBENomIndex]);
   if (Length(Trim(NominalCode)) <= 0) then Exit;

   NominalDescription := VarToStr(InputGridCell[tvCBENomDescIndex]);

   if (APoint.x > -1) and (APoint.y > -1) then
      InputGridCell[tvCBENomFreeEntryDescIndex] :=
            TfmTransactionNominalFreeTextDescriptionInput.GetTextAt(NominalDescription,APoint.x, APoint.y)
   else
      InputGridCell[tvCBENomFreeEntryDescIndex] :=
            TfmTransactionNominalFreeTextDescriptionInput.GetText(NominalDescription);
end;

procedure TFMainScreen.EditNominalFreeTextDescription;
begin
   EditNominalFreeTextDescription(Point(-1,-1));
end;

procedure TFMainScreen.OnGridColumnLayoutChanged();
begin
   TransactionGridTableView.ApplyBestFit( TransactionGridTableView.Items[tvRefIndex] );
   TransactionGridTableView.ApplyBestFit( TransactionGridTableView.Items[tvCustomerSupplierIndex] );
   TransactionGridTableView.ApplyBestFit( TransactionGridTableView.Items[tvCommentStubNoIndex] );
end;

procedure TFMainScreen.DefaultHandler(var Message);
begin
with TMessage(Message) do
  begin
    if (Msg = WM_GRIDCOLUMNLAYOUTCHANGED) then
       begin
          OnGridColumnLayoutChanged();
       end
    else if (Msg = WM_KINGSWOOD_FARMSYNC_MARKASSYNCHRONIZED) then
       begin
          TAccsSync.MarkAsSynchronized(AccsDataModule.CurrentDatabasePath);
       end
    else if (Msg = WM_KINGSWOOD_FARMSYNC_ERRORINSYNCPROCESS) then
       begin
          _MessageDlg('Error''s have occurred during the Farm Sync operation - please contact Kingswood support.',mtError,[mbOK],0);
       end
    else if (Msg = WM_KINGSWOOD_FARMSYNC_LOGINFAILED) then
       begin
          _MessageDlg('Farm Sync login has failed. Click System > Farm Sync to re-enter your username & password.',mtError,[mbOK],0);
       end
    else if (Msg = WM_KAccountsUpdateAvailable ) then
       begin
          if MessageDlg('A new version of Kingswood Accounts is available, do you want to begin download now?',mtConfirmation,[mbYes,mbNo],0) = idYes then
             DownloadNewVersion(False);
       end
    else if (Msg = WM_KAccountsNotOnMainteance ) then
       PromptForMaintenace
    else
       inherited DefaultHandler(Message);
  end;
end;

// Prevents screen flicker when screen is re-sized.
procedure TFMainScreen.WMEraseBackground(var Message: TMessage);
begin
   Message.Result := 1;
end;

procedure TFMainScreen.CBEAmountOnChange(Sender: TObject);
begin
   CheckVATForChanges();
end;

procedure TFMainScreen.CBEVATCodeOnChange(Sender: TObject);
begin
   CheckVATForChanges();
end;

procedure TFMainScreen.actSyncExecute(Sender: TObject);
var
  SyncParams : string;
begin
   if not actSync.Visible then Exit;

   AccsDataModule.JobCardXmlDocument := nil;

   // -jsfs - JobCard Full Sync, retrieve's all job cards in past 3 months
   SyncParams := '-s -a "'+ AccsDataModule.CurrentDatabase +'" -jcfs';
   if (Preferences.ValueAsBoolean[cPref_OutputAgeOfDebtOnSync]) then
      SyncParams := SyncParams + ' -aod';
   if (Preferences.ValueAsBoolean[cPref_OutputExtendedStatementOnSync]) then
      SyncParams := SyncParams + ' -es';
   if (Preferences.ValueAsBoolean[cPref_OutputJobCardRptOnSync]) then
      SyncParams := SyncParams + ' -jcrpt';
   if (Preferences.ValueAsBoolean[cPref_ProformaRptOnSync]) then
      SyncParams := SyncParams + ' -prorpt';

   uAccsSync.InvokeFarmSyncProgram(Handle, SyncParams);
end;

function TFMainScreen.GetIsIncomeOrExpense : TTransactionType;
begin
   if cbTransTypeGroup.ItemIndex = 1 then
      Result := ttExpense
   else
      Result := ttIncome;
end;

// SP - 22/06/2015 - Default the nominal from customer/supplier value (where applicable)
procedure TFMainScreen.LoadDefaultNominalForCustomerSupplier(AId: Integer);
var
   DefaultNominalId : Integer;
   NominalAccount : TNominalAccount;
begin
   if not VarIsNull(InputGridCell[tvCBENomIndex]) then Exit;

   DefaultNominalId := AccsDataModule.GetNominalForSupplierCustomer(AId,IsIncomeOrExpense);
   if (DefaultNominalID <= 0) then Exit;

   NominalAccount := AccsDatamodule.Accounts.GetNominalAccount(DefaultNominalId);
   if (NominalAccount<> nil) then
      begin
         InputGridCell[tvCBENomIndex] := NominalAccount.Id;
         InputGridCell[tvCBENomDescIndex] := NominalAccount.Name;
         if (Preferences.ValueAsBoolean[cPref_AutoEntSelect]) then
            InputGridCell[tvCBEEntIndex] := NominalAccount.EntCode;
      end;
end;

procedure TFMainScreen.actNewVersionExecute(Sender: TObject);
begin
   DownloadNewVersion(True);
end;

procedure TFMainScreen.ChangesBeforeRegVerCheck;
var
   iCurVerNo : Integer;
   iCashSerialNo : Integer;
begin
   try
      iCurVerNo := 0;
      iCurVerNo := StrToInt(ShortVerNo);
      if ( AccsDataModule.RegAccsVerNo > 0 ) then
         begin
            if ( iCurVerNo = 4314 ) and ( AccsDataModule.RegAccsVerNo < iCurVerNo ) then
               Preferences.ValueAsBoolean[cPref_ShowKingswoodAccsAppInfo] := ( (not(TfmFarmSyncSettings.SyncConfigured(AccsDataModule.CurrentDatabase))) and
                                                                               (not(cash1.Xcashbook) and not(cash11.XUse_Vat)) );

            //   18/10/18 [V4.3 R2.5] /MK Additional Feature - Run the UpdatePLFigures and UpdateSLFigures procedures to fix any aging issues caused by a bug
            //                                                 in the V4.3 R1.4 version (fixed in V4.3 R1.5) so that aging is not replicated in each age field
            //                                                 in the Setup screen.
            if ( iCurVerNo = 4325 ) and ( AccsDataModule.RegAccsVerNo < iCurVerNo ) then
               begin
                  if ( not(cash1.Xcashbook) ) then
                     try
                        Screen.Cursor := crHourGlass;
                        CalculateMonths.UpdateSLFigures(Date, 0);
                        CalculateMonths.UpdatePLFigures(Date, 0);
                     finally
                        Screen.Cursor := crDefault;
                     end;
               end;

            //   30/10/18 [V4.3 R2.5] /MK Change - As the Types.Invoicer is now based on module then remove the invoice file from database to stop previous versions from working.
            //   11/12/18 [V4.3 R3.0] /MK Change - If the invoice file exists then delete the file and assign the invoicer module if Cash.SerialNo is in new Types.SerialNosWithInvoicerMod string array.
            if ( not(Cash2.XWININV) ) and ( FileExists(AccsDataModule.AccsDataBase.Directory + 'invoice') ) then
               try
                  DeleteFile(PChar(AccsDataModule.AccsDataBase.Directory+'invoice'));
                  iCashSerialNo := PSysLongToDelphi(Cash11.serial_no);
                  TSystemDefinitionForm.SaveInvoicerModule(iCashSerialNo,InArray(IntToStr(iCashSerialNo),SerialNosWithInvoicerMod));
               except
                  MessageDlg('Unable to update invoicer module. Contact Kingswood.',mtError,[mbOK],0);
               end;

            //   25/05/20 [V4.5 R2.1] /MK Additional Feature - Store the version number in the AccsDefaults table.
            AccsDataModule.AccsDefaultsUpdateNo := StrToInt(ShortVerNo);

         end;
   except
   end;
end;

procedure TFMainScreen.tsPurchaseInvoiceShow(Sender: TObject);
begin
   SimplePurchaseInvoiceFrame.FrameOnShow(Sender);
end;

procedure TFMainScreen.tsSalesInvoiceShow(Sender: TObject);
begin
   SimpleSaleInvoiceFrame.FrameOnShow(Sender);
end;

procedure TFMainScreen.btnSimpleVatYEClick(Sender: TObject);
begin
   YearEndForm.ShowModal;
end;

procedure TFMainScreen.tsMTDVatYearEndShow(Sender: TObject);
begin
   if cash2.xcountry = 1 then
      begin
         lSimpleVatVatHead.Caption := 'MTD VAT';
         lSimpleVatVatInfo.Caption := 'Submit a VAT Return to the HMRC via the Kingswood MTD Link.';
         btnSimpleVatVATMTD.Action := actMTDVat;
         lMTDSubmissions.Caption := 'MTD VAT Submissions';
         lMTDSubmissionsDetail.Caption := 'Look at MTD VAT Submissions.';
      end
   else
      begin
         lSimpleVatVatHead.Caption := 'VAT Summary Report';
         lSimpleVatVatInfo.Caption := 'Print off a summary VAT Report.';
         btnSimpleVatVATMTD.Action := actStandVatRpt;
         lMTDSubmissions.Caption := 'VAT Audit Trail Report';
         lMTDSubmissionsDetail.Caption := 'Print off a detailed VAT Report.';
      end;

   lSimpleVatVatHead.Visible := not cash11.XUse_Vat;
   lSimpleVatVatInfo.Visible := lSimpleVatVatHead.Visible;
   btnSimpleVatVATMTD.Visible := lSimpleVatVatHead.Visible;

   bvMTDYEFirstBreak.Visible := ( lSimpleVatVatHead.Visible ) and ( not(Cash11.XSimpleVAT) );
   lMTDSubmissions.Visible := bvMTDYEFirstBreak.Visible;
   lMTDSubmissionsDetail.Visible := bvMTDYEFirstBreak.Visible;
   btnMTDSubmissions.Visible := bvMTDYEFirstBreak.Visible;
   bvMTDYESecondBreak.Visible := bvMTDYEFirstBreak.Visible;
   lMTDYESendRecAccData.Visible := bvMTDYEFirstBreak.Visible;
   lMTDYESendRecAccDataInfo.Visible := bvMTDYEFirstBreak.Visible;
   btnMTDVATSendRecAccData.Visible := bvMTDYEFirstBreak.Visible;
end;

procedure TFMainScreen.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
   sPageName : String;
begin
   if ( ViewPageControl.ActivePageIndex = tsSalesInvoice.PageIndex ) or
      ( ViewPageControl.ActivePageIndex = tsPurchaseInvoice.PageIndex ) then
      begin
         if ( ViewPageControl.ActivePageIndex = tsSalesInvoice.PageIndex ) then
            begin
               sPageName := 'Sales Invoice';
               CanClose := ( not(SimpleSaleInvoiceFrame.ChangesPending) );
            end
         else if ( ViewPageControl.ActivePageIndex = tsPurchaseInvoice.PageIndex ) then
            begin
               sPageName := 'Purchase Invoice';
               CanClose := ( not(SimplePurchaseInvoiceFrame.ChangesPending) );
            end;
         if ( not(CanClose) ) then
            CanClose := ( MessageDlg(Format(cMoveWarning,[sPageName]),mtWarning,[mbYes,mbNo],0) = mrYes );
      end;
end;

procedure TFMainScreen.actCoOpImportExecute(Sender: TObject);
begin
   { uSuppDownload.ShowTheForm; }
   if ( not(MenuBarCanExecute) ) then SysUtils.Abort;
   TfmSupplierDownload.ShowSupplierDownload;
end;

function TFMainScreen.MenuBarCanExecute: Boolean;
var
   sPageName : String;
begin
   //   06/11/19 [V4.5 R0.9] /MK Bug Fix - Only give prompt if Sale/Purchase Invoice preference is ticked and tab is SaleInvoice or Purchase Invoice and field in grid is filled - Milo Murphy.
   Result := ( not(Preferences.ValueAsBoolean[cPref_ShowSalePurchGridMainGrid]) ) or
             ( not(ViewPageControl.ActivePageIndex in [tsSalesInvoice.PageIndex, tsPurchaseInvoice.PageIndex]) );
   if ( Result ) then Exit;

   if ( ViewPageControl.ActivePageIndex = tsSalesInvoice.PageIndex ) then
      begin
         sPageName := 'Sales Invoice';
         Result := ( not(SimpleSaleInvoiceFrame.ChangesPending) );
      end
   else if ( ViewPageControl.ActivePageIndex = tsPurchaseInvoice.PageIndex ) then
      begin
         sPageName := 'Purchase Invoice';
         Result := ( not(SimplePurchaseInvoiceFrame.ChangesPending) );
      end;
   if ( not(Result) ) then
      MessageDlg(Format(cMoveError,[sPageName]),mtError,[mbOK],0);
end;

procedure TFMainScreen.SendDataToAccontant1Click(Sender: TObject);
begin
   if not (KAC.Active) then
      TfmDataBackup.Execute(daSendToAccountant)
   else
      MessageDlg('This feature is unavailable.',mtWarning,[mbOK],0)
end;

procedure TFMainScreen.ReceiveDataFromAccountant1Click(Sender: TObject);
begin
   if not (KAC.Active) then
      TfmDataBackup.Execute(daReceiveFromAccountant)
   else
      MessageDlg('This feature is unavailable.',mtWarning,[mbOK],0);
end;

procedure TFMainScreen.btnMTDVATSendRecAccDataClick(Sender: TObject);
var
   pt : TPoint;
begin
   getCursorPos(pt);
   pmMTDVATYESendRecAccs.Popup(pt.x,pt.y);
end;

procedure TFMainScreen.actVatReportExecute(Sender: TObject);
begin
   if ( cash2.xcountry = 1 ) then
      TVATSubmissionReportForm.ShowTheForm(vtFromReports)
   else
      begin
         SetupReport(rpVatReport);
         if ActiveControl.Name = 'btnSimpleVatVatRpt' then
            NominalReportForm.MainGridVatSumChecked := False
         else
            NominalReportForm.MainGridVatSumChecked := True;
         NewRepForm.DataBase := NlFile;
         NominalReportForm.SetNominalReportForm(VatReport);
         NominalReportForm.ShowModal;
      end;
end;

procedure TFMainScreen.actTransactionReportExecute(Sender: TObject);
begin
   SetupReport(rpTransactionReport);
   PROG := AnnBud;
   NewRepForm.DataBase := NlFile;
   NominalReportForm.SetNominalReportForm(TxList);
   NominalReportForm.ShowModal;
end;

procedure TFMainScreen.actNomAuditTrailExecute(Sender: TObject);
begin
   SetupReport(rpFullNominalAuditTrail);
   PROG := AnnBud;
   NewRepForm.DataBase := NlFile;
   NominalReportForm.SetNominalReportForm(FullNomAudit);
   NominalReportForm.ShowModal;
end;

procedure TFMainScreen.tsSimpleVatReportsShow(Sender: TObject);
begin
   lNIReportMoreReps.Visible := ( not(cash11.XSimpleVAT) );

   if cash2.xcountry = 1 then
      begin
         lVatReportHead.Caption := 'MTD VAT Submissions';
         lSimpleVatVatRptInfo.Caption := 'Look at MTD VAT Submissions.'

      end
   else
      begin
         lVatReportHead.Caption := 'VAT Summary Report';
         lSimpleVatVatRptInfo.Caption := 'Print off a VAT Summary Report.';
      end;

   bvSimpleVatThird.Visible := ( not(cash11.XSimpleVAT) );
   lSimpleVatProfLossHead.Visible := bvSimpleVatThird.Visible;
   lSimpleVatProfLossDetail.Visible := bvSimpleVatThird.Visible;
   btnSimpleVatProfLoss.Visible := bvSimpleVatThird.Visible;
   bvSimpleVatFourth.Visible := bvSimpleVatThird.Visible;
   lSimpleVatAgeofDebtHead.Visible := bvSimpleVatThird.Visible;
   lSimpleVatAgeofDebtDetail.Visible := bvSimpleVatThird.Visible;
   btnSimpleVatAgeofDebt.Visible := bvSimpleVatThird.Visible;
end;

procedure TFMainScreen.actMTDVatExecute(Sender: TObject);
var
   LoginCredentials: TLoginCredentials;
begin
   if ( cash2.xcountry = 1 ) then
      begin
         //   06/10/20 [V4.5 R4.2] /MK Change - MTD users need to enter in their Username and Password before submitting VAT Return.
         LoginCredentials := TCredentialsStore.Load(AccsDataModule.MTDCredentialStorePath);
         if ( LoginCredentials = nil ) then
            begin
               MessageDlg('Your Kingswood MTD Username and Password must be entered before proceding with the VAT Return.',mtWarning,[mbOK],0);
               //   14/10/20 [V4.5 R4.3] /MK Change - After the prompt for Username and Password, store this info so the prompt doesn't keep appearing.
               if AccsDataModule.PromptAndValidateMTDCredentials() then
                  MessageDlg('Login credentials successfully stored.',mtInformation,[mbok],0)
               else
                  MessageDlg('An error occurred while storing information.',mtError,[mbOK],0);
            end;

         LoginCredentials := TCredentialsStore.Load(AccsDataModule.MTDCredentialStorePath);
         if ( LoginCredentials = nil ) then Exit;
         
         if ( not(bool(DigitalVATForm)) ) then
            Application.CreateForm(TDigitalVATForm,DigitalVATForm);
         DigitalVATForm.Show;
      end
   else
      begin
         SetupReport(rpVatReport);
         NewRepForm.DataBase := NlFile;
         NominalReportForm.MainGridVatSumChecked := False;
         NominalReportForm.SetNominalReportForm(VatReport);
         NominalReportForm.ShowModal;
      end;
end;

procedure TFMainScreen.actStandVatRptExecute(Sender: TObject);
begin
   SetupReport(rpVatReport);
   NominalReportForm.MainGridVatSumChecked := False;
   NominalReportForm.SetNominalReportForm(VatReport);
   NominalReportForm.ShowModal;
end;

procedure TFMainScreen.actAgeOfDebtExecute(Sender: TObject);
var
   pt : TPoint;
begin
   getCursorPos(pt);
   pmSimpleVatAgeOfDebt.Popup(pt.x,pt.y);
end;

procedure TFMainScreen.pmiCustomerAgeOfDebtClick(Sender: TObject);
begin
   SetupReport(rpCustomerAgeOfDebt);
   if CustSuppListing <> nil then
      try
         FreeAndNil(CustSuppListing);
      except
      end;
   Application.CreateForm(TCustSuppListing, CustSuppListing);
   FLedgerType := ltCustomer;
   CheckCustomerSupplierAgeOfDebt;
   Act := 2;
   CustSuppListing.Caption := 'Age Of Debt';{ + ' - ' + st;}
   CustSuppListing.ShowModal;
end;

procedure TFMainScreen.pmiSupplierAgeOfDebtClick(Sender: TObject);
begin
   SetupReport(rpSupplierAgeOfDebt);
   if CustSuppListing <> nil then
      try
         FreeAndNil(CustSuppListing);
      except
      end;
   Application.CreateForm(TCustSuppListing, CustSuppListing);
   FLedgerType := ltSupplier;
   CheckCustomerSupplierAgeOfDebt;
   Act := 2;
   CustSuppListing.Caption := 'Age Of Debt';{ + ' - ' + st;}
   CustSuppListing.ShowModal;
end;

procedure TFMainScreen.CheckCustomerSupplierAgeOfDebt;
begin
   if ( FLedgerType = ltCustomer ) then
      begin
         PROG := CustRep;
         NewRepForm.CustRadio.Checked := True;
         NewRepForm.SuppRadio.Checked := False;
         NewRepForm.DataBase := SLFile;
         CustSuppListing.RepType := Customer;
      end
   else
      begin
         PROG := SUPPrep;
         NewRepForm.CustRadio.Checked := False;
         NewRepForm.SuppRadio.Checked := True;
         NewRepForm.DataBase := PLFile;
         CustSuppListing.RepType := Supplier;
      end;
end;

procedure TFMainScreen.imgTeamViewerClick(Sender: TObject);
var
   AccsCountry : TAccsCashbookCountry;
begin
   with TCallPrograms.Create do
     try
        if ( AccsSystem.Region = 'UK' ) then
           AccsCountry := ctUK
        else
           AccsCountry := ctIreland;
        CallAccsTeamViewer(AccsCountry);
     finally
        Free;
     end;
end;

procedure TFMainScreen.DownloadNewVersion(AShowPrompt : Boolean);
begin
   CheckCashbookEntryGridState();

   if (not AccsDataModule.KInstallerIsAvailable()) then
      begin
         AccsDataModule.DownloadKInstaller();
      end
   else
      begin
         if AShowPrompt then
            if MessageDlg('You are about to check for updates, are you sure you want to continue?',mtConfirmation,[mbYes,mbNo],0) = idNo then Exit;
      end;
   ResetCashbookTransaction(False);
   Close;
   AccsDataModule.CloseAndUpdate;
end;

procedure TFMainScreen.PromptForMaintenace;
begin
   AccsDataModule.AccsDefaultsMaintPromptDate := Now;
   if ( cash2.xcountry = 2 ) then
      MessageDlg('Your Kingswood annual support is due for renewal.'+ #13 +
                 'Please contact Kingswood Computing at +353 (0)1 4596677 or email to info@kingswood.ie',mtWarning,[mbOK],0)
   else
      MessageDlg('Your Kingswood annual support is due for renewal.'+ #13 +
                 'Please contact TGM Software at 028-92-689681 or email to info@tgmsoftware.com',mtWarning,[mbOK],0);
end;

procedure TFMainScreen.UpdateYearOnStatusBar;
var
   TempTime : String;
   st : Shortstring;
begin
   if ( Cash1.xmonthno < cash1.xfinmonth ) then
      st := (Monthname [Cash1.xmonthno]) + ' ' + Inttostr(cash1.xfinyear+1)
   else
      st := (Monthname [Cash1.xmonthno]) + ' ' + Inttostr(cash1.xfinyear);
   DateTimeToString ( TempTime,'dddd, mmmm d, yyyy, hh:mm AM/PM' , Date + Time );
   StatusBar.Panels.Items[2].Text := TempTime;
   StatusBar.Panels.Items[1].Text := 'Financial Date: ' + st;
end;

procedure TFMainScreen.ShowBankLink;
var
   bShowBankFileSelectorSettings : Boolean;
begin
   if ( not(TfmBankFileSelector.ShowBankFileSelector) ) then
      begin
         bShowBankFileSelectorSettings := False;
         //   29/09/20 [V4.5 R3.9] /MK Change - If the user is not an accountant and their in ROI then, if CSV files don't exist in DefaultStatementDirectory then show new TfmBankLinkNoFileFound form.
         //   26/11/20 [V4.5 R4.6] /MK Change - Only show TfmBankLinkNoFileFound if user hasn't ticked "Don't show this again".
         if ( not(IsAccountant(AccsDataModule.FarmgateSerialNo)) ) and ( AccsSystem.Region = 'ROI' ) and
            ( Preferences.ValueAsBoolean[cPref_ShowBankLinkFileNotFound] ) then
            if ( Length(AccsDataModule.DefaultStatementDirectory) > 0 ) then
               begin
                  TfmBankLinkNoFileFound.ShowTheForm(bShowBankFileSelectorSettings);
                  if ( bShowBankFileSelectorSettings ) then
                     BankFileImportTimer.Enabled := True;
               end;
      end;
end;

procedure TFMainScreen.actBankAuditTrailExecute(Sender: TObject);
begin
   SetupReport(rpBankAuditTrail);
   PROG := AnnBud;
   NewRepForm.DataBase := NlFile;
   NominalReportForm.SetNominalReportForm(BankAudit);
   NominalReportForm.ShowModal;
end;

initialization
  // update for windows 7.
  DateSeparator := '/';
  ShortDateFormat := 'dd/mm/yy';
  cxFormatController.BeginUpdate;
  cxFormatController.UseDelphiDateTimeFormats := True;
  // change other settings of the cxFormatController...
  cxFormatController.EndUpdate;
  cxFormatController.GetFormats;
  cxFormatController.NotifyListeners;

  WM_KINGSWOOD_FARMSYNC_MARKASSYNCHRONIZED := RegisterWindowMessage('WM_KINGSWOOD_FARMSYNC_MARKASSYNCHRONIZED');
  WM_KINGSWOOD_FARMSYNC_ERRORINSYNCPROCESS := RegisterWindowMessage('WM_KINGSWOOD_FARMSYNC_ERRORINSYNCPROCESS');
  WM_KINGSWOOD_FARMSYNC_LOGINFAILED := RegisterWindowMessage('WM_KINGSWOOD_FARMSYNC_ACCS_LOGINFAILED');
  WM_KAccountsUpdateAvailable := RegisterWindowMessage('WM_KAccountsUpdateAvailable');
  WM_KAccountsNotOnMainteance := RegisterWindowMessage('WM_KAccountsNotOnMainteance');

end.
