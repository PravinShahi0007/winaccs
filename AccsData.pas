{
   04/11/11 [V4.1 R0.7] /MK Additional Feature - Adding New Color Field To Store Enterprise Color For Graphs.

   10/11/11 [V4.1 R0.7] /MK Bug Fix - GetExpenseNominalLedgerAccs - Program Was Not Showing Private Expenditures For More Than One Partner.

   07/08/12 [V4.1 R2.1] /MK Change - CheckImportDateFields - New procedure to add fields to Import Dates table where they don't exist.
                                   - SetDatabaseAlias - Created and set database name of UpdateTable on FormCreate.
                                                      - Set database name of AddFieldsQuery on FormCreate.

   01/11/13 [V4.1 R5.5] /MK Additional Feature - New procedure AddBankLinkDefaults to add Bank Link default headings.
                                               - Moved creation of Bank Link default headings from CreateBankCSVDefaultsTable to AddBankLinkDefaults.
                                               - Added AIB Personal and AIB Business default headings for Bank Link.

   02/03/16 [V1.4 R1.9] /MK Additional Feature - AddCoOpRecords - Add two new co-ops (Drinagh and Bandon) that use the Kerry file standard.
                                                                - Used an array to add these extra Co-Ops to the table.
                                                                - Set the UseAsDefault button based on whether a default Co-Op was already selected.
                                               - New property, DefaultCoOpCompany, to get the Default Co-Op company name.

   15/06/16 [V1.4 R3.4] /MK Bug Fix - Removed all field defs within BankCSVTempTableDB component as these field defs were the old ones setup by AB.
                                      These old field defs stopped the Bank Statememt Import screen from opening as fields in the grid were tied to
                                      these old field defs.

   16/09/16 [V4.2 R3.7] /MK Additional Feature - Added new co-op, BarryRoe, that uses the Kerry file standard.
                                               - Dairygold file spec is the same as Kerry - Michael Cloney (Dairygold) / GL.

   24/02/17 [V4.2 R7.1] /MK Additional Feature - New property MailboxExists to check to see if the Mailbox.config file exists in the database.

   19/10/17 [V4.2 R8.8] /MK Incorporated Changes from Andrew (TGM) - Removed fields from CustSuppListingDB field view as fields are added via CreateCustSuppListingTable procedure

   25/10/17 [V4.2 R8.9] /MK Change - OpenAllFiles - Added new fields to the BankCSVDefaultsTable - Brendan Brady.
                                   - CreateBankImportTempTable - Added two extra details fields in the BankCSVTempTable - Brendan Brady.

   02/11/17 [V4.2 R9.1] /MK Additional Feature - AddCoOpRecords - Added Arrabawn and Lisavaird Co-Ops - GL/DOM request.

   13/11/17 [V4.2 R9.2] /MK Additional Feature - AddCoOpRecords - Added Centenary Co-Op - GL request.

   22/01/18 [V4.3 R0.2] /MK Additional Feature - CreateBankImportNLMatch - Created a new table, BankImportNLStore, to store Bank Import Description with the Nominal selected by the user.
                                               - StoreNLAndDescription - Store the nominal and descriptin in the BankImportNLStore table.
                                                                       - If the user allocates a new nominal to the description then edit existing record and store it.
                                               - GetNLNoForBankImportDesc - Function created to get nominal of the description.

   26/09/18 [V4.3 R1.4] /MK Change - Moved the getting/setting of modules and verno keys in the registry to public properties in AccsData.
                                   - Added KRoutines as a use.
                            Additional Feature - Created a public property to bring out the start month and year to a string.

   10/10/18 [V4.3 R1.7] /MK Change - CreateTransactionTable - Added CoOpImport and CoOpComment fields to this procedure.

   19/10/18 [V4.3 R2.5] /MK Additional Feature - New public property to get NomProdRelationship from AccsDefaults table.

   15/11/18 [V4.3 R2.7] /MK Additional Feature - CreatePreferenceDefaults - New preferences to show new features screen for Bank Link, Co Op Link and Accountants Link.

   20/11/18 [V4.3 R2.9] /MK Change - CreateBankImportTempTable - New field, NomFreeText, added to store the "Overwrite of Nominal Description" value.

   04/01/19 [V4.3 R4.0] /MK Additional Feature - CreateBankImportTempTable - Added discount field to Bank Import Temp Table.

   15/01/19 [V4.3 R4.1] /MK Change - CreateBankImportTempTable - Added new fields for new split transaction changes in Bank Link.

   16/09/19 [V4.5 R0.4] /MK Change - New prcoedure, UpdateBankImportNLMatch, to add TxTypeDesc field to BankImportNLStore.
                                   - New function, GetStoredBankLinkInfo, to get TStoredBankLinkInfo from BankImportNLStore.
                                   - StoreNLAndDescription - Use GetStoredBankLinkInfo instead of GetNLNoForBankImportDesc.

   11/11/19 [V4.5 R1.0] /MK Bug Fix - CreateBankImportNLMatch - Add fields to BankImportNLStore if it exists already.

   23/12/19 [V4.5 R1.6] /MK Change - UpdateBankCSVDefaultsTable - Added new fields for new components on uBankCSVConfig.

   25/05/20 [V4.5 R2.1] /MK Additional Feature - Added fields to AccsDefaults - UpdateNo, LastVerUpdate, LastBackup and MaintPromptDate.
                                               - Added properties for these new fields.
                                               - Added procedure CheckNewVersionAvailable which receives a message from KInstaller whether version is up-to-date.
                                               - Added procedure CheckMaintenanceWithKinstaller which recieves a message from KInstaller where the serial number is on maintenance.

   31/07/20 [V4.5 R3.4] /AB Bug fix - added DbiSaveChanges to AllocatedVATDB table AfterPost - possible fix for issues following user having lines go missing from AllocatedVATDB (Ch026)
                                    - found a few other tables in AccsData missing the DbiSaveChanges & updated as well (Ch026)

   18/09/20 [V4.5 R3.8] /MK Change - Created a public property to return the Farmgate serial no.
                                   - UseThisAlias - If the DefaultStatementDirectory is null or it doesn't exist then default to the Desktop.

   18/09/20 [V4.5 R3.9] /MK Additional Feature - AddBankLinkDefaults - Add Danske defaults - George (TGM).                                

   26/11/20 [V4.5 R4.6] /MK Change - CreatePreferenceDefaults - Default new ShowBankLinkFileNotFound pref to True so TfmBankLinkNoFileFound appears before user can press "Don't show this again".

   04/03/21 [V4.5 R5.1] / AB Change - New Table AllocatedVATDBYr1 added for Payment Based MTD - Ch006(P)
                                    - Procedure GatherPreviousYears updated to also copy forward AllocatedVAT table from last year

   10/12/21 [V4.5 R6.3] /MK Bug Fix - LastSLFileDB and LastPLFileDB DatabaseNames were set to Accs and not WinAccsData.                                     

   31/01/22 [V4.5 R6.5] /MK Additional Feature - CreateBankImportNLMatch, UpdateBankImportNLMatch - Added CustSuppNo and CustSuppName fields.
                                               - StoreNLAndDescription, GetStoredBankLinkInfo - Added the store of CustSuppNo and CustSuppName.
}

unit AccsData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Reports,InvoiceReport, params, defsecfl, ImgList, cxEdit,
  cxDBEditRepository, cxEditRepositoryItems, cxStyles, uAccounts,
  uBudgetTypes, AccsUtils, uAccsSettings, uQuantityInput, MSXML2_TLB,
  ComObj, ShellAPI, Types, HHPack, igHHInt, LMDWebHTTPGet, LMDDownload,
  LMDWebConfig, LMDWebDownloadFormUnit, uSysMain, IniFiles, KRoutines,
  ProgramUpdateThread, ProgramMaintenanceCheckThread, uMTDApi;

type
  ErrorMsg = class(Exception);
  TBudgetsOrActual = (BudgetThisYear, LastYearActual, ThisYearActual);

  TVATReturnInfo = record
     Period: string;
     IsPending: boolean;
  end;

  TMTDReconcileResult = (crLoginCredentialMissing, crInvalidLoginCredentials, srUnavailable, srReturnChanged, srNotOnFile, srDuplicateOnFile, srNotSubmitted, srReconcileFailed, srReconciled, srError);
  TMTDReconcile = record
     Result: TMTDReconcileResult;
     DialogMessage:string;
     DialogType: TMsgDlgType;
  end;

  TAccsDataModule = class(TDataModule)
    PrintFile: TTable;
    PrintFilePrinterName: TStringField;
    PrintFilePointSizeSmall: TSmallintField;
    PrintFilePointSizeLarge: TSmallintField;
    PrintFileFontName: TStringField;
    PrintFileLineSpacing: TSmallintField;
    PrintFilePrinterNo: TIntegerField;
    PrintSource: TDataSource;
    AccsDataBase: TDatabase;
    qNominalLedger: TQuery;
    dsqNominalLedger: TDataSource;
    NominalList: TTable;
    PurchaseLedger: TTable;
    dsPurchaseLedger: TDataSource;
    NomMatch: TTable;
    dsImportDefaults: TDataSource;
    ImportDefaults: TTable;
    ImportDefaultsID: TAutoIncField;
    ImportDefaultsCoOpName: TStringField;
    ImportDefaultsUseAsDefault: TBooleanField;
    ImportDefaultsDefaultAccount: TIntegerField;
    ImportDefaultsRecTypeStart: TIntegerField;
    ImportDefaultsRecTypeLen: TIntegerField;
    ImportDefaultsDateStart: TIntegerField;
    ImportDefaultsDateLen: TIntegerField;
    ImportDefaultsAccountStart: TIntegerField;
    ImportDefaultsAccountLen: TIntegerField;
    ImportDefaultsDocketNoStart: TIntegerField;
    ImportDefaultsDocketNoLen: TIntegerField;
    ImportDefaultsDescriptionStart: TIntegerField;
    ImportDefaultsDescriptionLen: TIntegerField;
    ImportDefaultsQuantityLen: TIntegerField;
    ImportDefaultsQuantityDec: TIntegerField;
    ImportDefaultsAmountStart: TIntegerField;
    ImportDefaultsAmountLen: TIntegerField;
    ImportDefaultsAmountDec: TIntegerField;
    ImportDefaultsVATRateStart: TIntegerField;
    ImportDefaultsVATRateLen: TIntegerField;
    ImportDefaultsVATRateDec: TIntegerField;
    ImportDefaultsReferenceStart: TIntegerField;
    ImportDefaultsReferenceLen: TIntegerField;
    ImportDates: TTable;
    dsBudgets: TDataSource;
    dsProducts: TDataSource;
    dsNominalList: TDataSource;
    GenQuery: TQuery;
    ProdsTx: TTable;
    dsProdsTx: TDataSource;
    ProdsTxTemp: TTable;
    dsProdsTxTemp: TDataSource;
    InvoiceNumbers: TTable;
    dsInvoiceNumbers: TDataSource;
    ProformaDB: TTable;
    dsProforma: TDataSource;
    StoredProc1: TStoredProc;
    InvoiceReportTable: TTable;
    InvoiceLayout: TTable;
    dsInvoiceLayout: TDataSource;
    AddFieldsQuery: TQuery;
    ImportDefaultsVATInclusive: TBooleanField;
    ImportDefaultsHeaderString: TStringField;
    ImportDefaultsHeaderDateStart: TIntegerField;
    ImportDefaultsHeaderDateFormat: TStringField;
    ImportDefaultsCustomerNameStart: TIntegerField;
    ImportDefaultsCustomerNameLen: TIntegerField;
    ImportDefaultsSkipString1: TStringField;
    ImportDefaultsSkipString2: TStringField;
    ImportDefaultsSkipString3: TStringField;
    ImportDefaultsDetailString: TStringField;
    ImportDefaultsQuantityStart: TIntegerField;
    Statement: TTable;
    dsStatement: TDataSource;
    SalesLedger: TTable;
    dsSalesLedger: TDataSource;
    NlaccsDB: TTable;
    dsnlaccsdb: TDataSource;
    SlaccsDB: TTable;
    dsslaccsdb: TDataSource;
    dsGroupsDB: TDataSource;
    GroupsDB: TTable;
    SLPLDefaults: TTable;
    NomDefaults: TTable;
    Budgets: TTable;
    BudgetsNominalID: TIntegerField;
    BudgetsAlteredBudget: TBooleanField;
    BudgetsNomName: TStringField;
    BudgetsCheckBudget: TFloatField;
    BudgetsJan: TFloatField;
    BudgetsFeb: TFloatField;
    BudgetsMar: TFloatField;
    BudgetsApr: TFloatField;
    BudgetsMay: TFloatField;
    BudgetsJun: TFloatField;
    BudgetsJul: TFloatField;
    BudgetsAug: TFloatField;
    BudgetsSep: TFloatField;
    BudgetsOct: TFloatField;
    BudgetsNov: TFloatField;
    BudgetsDec: TFloatField;
    BudgetsYearBudget: TFloatField;
    TempBudgetReportDB: TTable;
    TempBudgetReport: TDataSource;
    BudgetReportSQL: TQuery;
    ThisYearTempTableDB: TTable;
    ThisYearTempTable: TDataSource;
    ThisYearTempTableSQL: TQuery;
    Products: TTable;
    TransDB: TTable;
    Trans: TDataSource;
    AnalysisDB: TTable;
    Analysis: TDataSource;
    AnalysisReportTable: TDataSource;
    AnalysisReportTableDB: TTable;
    AnalysisQuery: TQuery;
    AnalysisQueryDS: TDataSource;
    TransQuery: TQuery;
    TransQueryDS: TDataSource;
    InvoiceVatQuery: TQuery;
    InvoiceLinesQuery: TQuery;
    JournalQuery: TQuery;
    TransactionsDB: TTable;
    Transactions: TDataSource;
    SLFileDB: TTable;
    PLFileDB: TTable;
    NLFileDB: TTable;
    SL: TDataSource;
    PL: TDataSource;
    NL: TDataSource;
    NLGroupsDB: TTable;
    NLGroups: TDataSource;
    EntsFileDB: TTable;
    Ents: TDataSource;
    DefaultsDB: TTable;
    Defaults: TDataSource;
    ProductsQuery: TQuery;
    dsproductsquery: TDataSource;
    ProductsTxQuery: TQuery;
    dsProductsTxQuery: TDataSource;
    NlaccsExtDB: TTable;
    dsNlaccsExtDB: TDataSource;
    NewTransactionsDB: TTable;
    OverpaymentQuery: TQuery;
    OverpaymentQueryDS: TDataSource;
    OverpaymentTempDB: TTable;
    OverpaymentTempDS: TDataSource;
    OverpaymentTempDBTotalAmount: TFloatField;
    OverpaymentTempDBOverpaymentRemaining: TFloatField;
    OverpaymentTempDBOverpaymentAmount: TFloatField;
    OverpaymentTempDBTxNo: TIntegerField;
    OverpaymentTempDBTxDate: TDateField;
    OverpaymentTempDBReference: TStringField;
    OverpaymentTempDBTick: TStringField;
    NewTransactions: TDataSource;
    TransMoveQuery: TQuery;
    TransactionsYr1: TDataSource;
    TransactionsYr1DB: TTable;
    TransactionsYr2: TDataSource;
    TransactionsYr2DB: TTable;
    LastNlFileDB: TTable;
    LastNlFile: TDataSource;
    AllocationTempDB: TTable;
    AllocationTemp: TDataSource;
    AllocationTempDBTxID: TIntegerField;
    AllocationTempDBInvDate: TDateField;
    AllocationTempDBInvRef: TStringField;
    AllocationTempDBInvComment: TStringField;
    AllocationTempDBInvTotal: TFloatField;
    AllocationTempDBAmountPaid: TFloatField;
    AllocationTempDBDiscount: TFloatField;
    AllocationTempDBCompleteAllocation: TStringField;
    AllocationTempDBOutstanding: TFloatField;
    FirstTxQuery: TQuery;
    TempVATDB: TTable;
    TempVAT: TDataSource;
    FrontGridQuery: TQuery;
    SQLUpdate: TQuery;
    AllocatedVATDB: TTable;
    AllocatedVAT: TDataSource;
    AllocationTempDBPreviousYear: TStringField;
    ImageList16x16: TImageList;
    cxDefaultEditStyleController: TcxDefaultEditStyleController;
    EditRepository: TcxEditRepository;
    erSuppliersLookup: TcxEditRepositoryLookupComboBoxItem;
    erNominalLookup: TcxEditRepositoryLookupComboBoxItem;
    erCheckBox: TcxEditRepositoryCheckBoxItem;
    erNominalAccountTypes: TcxEditRepositoryComboBoxItem;
    erProductNomsLookup: TcxEditRepositoryLookupComboBoxItem;
    erNominalTypeLookup: TcxEditRepositoryComboBoxItem;
    erBankDBLookup: TcxEditRepositoryLookupComboBoxItem;
    AccsDefaults: TTable;
    AgeOfDebtQuery: TQuery;
    OverpaymentTempDBCreditNoteAmount: TFloatField;
    LedgerReportDB: TTable;
    LedgerReportDS: TDataSource;
    LedgerReportQuery: TQuery;
    CustSuppTempTableDB: TTable;
    DefaultStyleRepository: TcxStyleRepository;
    cxStyleSelected: TcxStyle;
    cxStyleNotSelected: TcxStyle;
    StyleReadOnly: TcxStyle;
    cxStyleOffGrazingPlatform: TcxStyle;
    erCurrencyEditNoSymbol: TcxEditRepositoryCurrencyItem;
    LedgerReportDBBalance: TFloatField;
    LedgerReportDBID: TAutoIncField;
    LedgerReportDBTxDate: TDateField;
    LedgerReportDBTxNo: TIntegerField;
    LedgerReportDBTxType: TStringField;
    LedgerReportDBTxReference: TStringField;
    LedgerReportDBTxDescription: TStringField;
    LedgerReportDBDebit: TFloatField;
    LedgerReportDBCredit: TFloatField;
    LedgerReportDBAccountNoLabel: TStringField;
    LedgerReportDBLineLabel: TStringField;
    LedgerReportDBLastYear: TStringField;
    LedgerReportDBCustomerAddressLabel: TStringField;
    LedgerReportDBStatementLabel: TStringField;
    EnterpriseAnalysisReportDB: TTable;
    EnterpriseAnalysisReportDBID: TAutoIncField;
    EnterpriseAnalysisReportDBCode: TStringField;
    EnterpriseAnalysisReportDBDescription: TStringField;
    EnterpriseAnalysisReportDBMonth_ThisYear: TFloatField;
    EnterpriseAnalysisReportDBMonth_LastYear: TFloatField;
    EnterpriseAnalysisReportDBMonth_Budget: TFloatField;
    EnterpriseAnalysisReportDBYTD_ThisYear: TFloatField;
    EnterpriseAnalysisReportDBYTD_LastYear: TFloatField;
    EnterpriseAnalysisReportDBYTD_Budget: TFloatField;
    EnterpriseAnalysisReportDBAnnual_Budget: TFloatField;
    EnterpriseAnalysisReportDBLineLabel: TStringField;
    EnterpriseAnalysisReportDBBoldLineLabel: TStringField;
    CustSuppListingDB: TTable;
    CustSuppListing: TDataSource;
    CustSuppQuery: TQuery;
    VATReportQuery: TQuery;
    VATReportInvoiceQuery: TQuery;
    ProductsID: TAutoIncField;
    ProductsDefaultPrice: TFloatField;
    ProductsUseDefaultPrice: TBooleanField;
    ProductsDesc1: TStringField;
    ProductsDesc2: TStringField;
    ProductsDesc3: TStringField;
    BankTableDB: TTable;
    TrialBalanceReportDB: TTable;
    TrialBalanceReportDS: TDataSource;
    BankCSVDefaultsDB: TTable;
    BankCSVDefaults: TDataSource;
    BankImportDefaultsDB: TTable;
    BankImportDefaults: TDataSource;
    BankCSVTempTableDB: TTable;
    BankCSVTempTable: TDataSource;
    erBankLookup: TcxEditRepositoryComboBoxItem;
    ImageList28x28: TImageList;
    BudgetExt: TTable;
    dsBudgetExt: TDataSource;
	
    BankAuditTrailDB: TTable;
    BankAuditTrail: TDataSource;
    BankAuditTrailQuery: TQuery;
    BankAuditTrailQueryDS: TDataSource;
    CostPerUnitReportTableDB: TTable;
    CostPerUnitReport: TDataSource;
    CostPerUnitReportQuery: TQuery;
    BankCSVDetailTempTableDB: TTable;
    dsBankCSVDetailTempTableDB: TDataSource;
    cxStyle1: TcxStyle;
    JobCardReport: TDataSource;
    JobCardReportDB: TTable;
    JobCardReportQuery: TQuery;
    HelpSocket: TigAppHelpSocket;
	
    LedgerReportDBBlueLineLabel: TStringField;
    LedgerReportDBLineDate: TDateField;
    LedgerReportDBLineDescription: TStringField;
    LedgerReportDBLineQty: TFloatField;
    LedgerReportDBLineUnitPrice: TFloatField;
    LedgerReportDBLinePrice: TFloatField;
    LedgerReportDBLineVAT: TFloatField;
    LedgerReportDBBlueLineLabel2: TStringField;
    LedgerReportDBLineCredit: TFloatField;
    LedgerReportDBLineDebit: TFloatField;
    LedgerReportDBTotalLinePrice: TFloatField;
    LedgerReportDBTotalLineVAT: TFloatField;
    LedgerReportDBTotalLineCredit: TFloatField;
    LedgerReportDBTotalLineDebit: TFloatField;
    LedgerReportDBBoldBlueLineLabel: TStringField;
    LedgerReportDBGreenLineLabel: TStringField;
    ProductsUnit: TStringField;
    ProductsIsSynchronized: TBooleanField;	
    ProductAllocationDB: TTable;
    dsProductAllocation: TDataSource;
    LedgerReportDBLineType: TStringField;
    LedgerReportDBAccNo: TIntegerField;
    LastSLFile: TDataSource;
    LastSLFileDB: TTable;
    LastPLFile: TDataSource;
    LastPLFileDB: TTable;
    VATReturnDB: TTable;
    VATArchiveDB: TTable;
    VATTotalsArchiveDB: TTable;
    HMRCReceipts: TTable;
    AllocatedVATDBYr1: TTable;
    LedgerReportDBCommentLabel: TStringField;          //Ch006(P)
    procedure BudgetsBeforePost(DataSet: TDataSet);
    procedure BudgetsCalcFields(DataSet: TDataSet);
    procedure BudgetsYearBudgetValidate(Sender: TField);
    procedure AccsDataModuleCreate(Sender: TObject);
    procedure BudgetsBeforeDelete(DataSet: TDataSet);
    procedure BudgetsBeforeInsert(DataSet: TDataSet);
    procedure ProductsoldDesc1Validate(Sender: TField);
    procedure BudgetsAfterPost(DataSet: TDataSet);
    procedure ProductsoldAfterPost(DataSet: TDataSet);
    procedure PrintFileAfterPost(DataSet: TDataSet);
    procedure PurchaseLedgerAfterPost(DataSet: TDataSet);
    procedure NomMatchAfterPost(DataSet: TDataSet);
    procedure ImportDefaultsAfterPost(DataSet: TDataSet);
    procedure ProdsTxAfterPost(DataSet: TDataSet);
    procedure ImportDatesAfterPost(DataSet: TDataSet);
    procedure NominalListAfterPost(DataSet: TDataSet);
    procedure CloseAllFiles;
    procedure OpenAllFiles;
    procedure StatementAfterPost(DataSet: TDataSet);
    procedure BudgetsBeforeEdit(DataSet: TDataSet);
    procedure AllocateBudget;
    procedure AllocateBudgetZeros;
    procedure SLPLDefaultsAfterPost(DataSet: TDataSet);
    procedure NomDefaultsAfterPost(DataSet: TDataSet);
    procedure ProductsAfterPost(DataSet: TDataSet);
    procedure ProductsBeforeDelete(DataSet: TDataSet);
    procedure InvoiceReportTableAfterPost(DataSet: TDataSet);
    procedure InvoiceNumbersAfterPost(DataSet: TDataSet);
    procedure AnalysisDBAfterPost(DataSet: TDataSet);
    procedure ProdsTxTempAfterPost(DataSet: TDataSet);
    procedure ProformaDBAfterPost(DataSet: TDataSet);
    procedure InvoiceLayoutAfterPost(DataSet: TDataSet);
    procedure TransactionsDBAfterPost(DataSet: TDataSet);
    procedure TransactionsDBAfterInsert(DataSet: TDataSet);
    procedure NLGroupsDBAfterPost(DataSet: TDataSet);
    procedure NLFileDBAfterPost(DataSet: TDataSet);
    procedure PLFileDBAfterPost(DataSet: TDataSet);
    procedure SLFileDBAfterPost(DataSet: TDataSet);
    procedure EntsFileDBAfterInsert(DataSet: TDataSet);
    procedure EntsFileDBAfterPost(DataSet: TDataSet);
    procedure CreateSlaccsExportTable;
    procedure SLFileDBAfterInsert(DataSet: TDataSet);
    procedure PLFileDBAfterInsert(DataSet: TDataSet);
    procedure GatherPreviousYears;
    procedure NLFileDBAfterInsert(DataSet: TDataSet);
    procedure CreateAllocatedVATTable;
    procedure CreateOverpaymentTempTable;
    procedure CreateAccsDefaultsTable;
    procedure AddAccsDefaults;
    procedure CustSuppListingDBAfterPost(DataSet: TDataSet);
    procedure CreateBankTable;
    procedure BankTableDBAfterPost(DataSet: TDataSet);
    procedure BankCSVDefaultsDBAfterPost(DataSet: TDataSet);
    procedure BankCSVTempTableDBAfterPost(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure AccsDataBaseAfterConnect(Sender: TObject);
    procedure BudgetExtAfterPost(DataSet: TDataSet);
    procedure BudgetExtBeforePost(DataSet: TDataSet);
    procedure BankCSVDetailTempTableDBAfterPost(DataSet: TDataSet);
    procedure BankCSVDetailTempTableDBNewRecord(DataSet: TDataSet);
    function HelpSocketHTMLHelp(Command: Word; Data: Integer;
      var CallHelp: Boolean): Boolean;
    procedure ProductsBeforePost(DataSet: TDataSet);
    procedure SLFileDBBeforePost(DataSet: TDataSet);
    procedure NLFileDBBeforePost(DataSet: TDataSet);
    procedure EntsFileDBBeforePost(DataSet: TDataSet);
    procedure AnalysisDBBeforePost(DataSet: TDataSet);
    procedure AllocatedVATDBAfterPost(DataSet: TDataSet);                  // Ch026
    procedure VATTotalsArchiveDBAfterPost(DataSet: TDataSet);              // Ch026
    procedure VATReturnDBAfterPost(DataSet: TDataSet);                     // Ch026
    procedure VATArchiveDBAfterPost(DataSet: TDataSet);                    // Ch026
    procedure DefaultsDBAfterPost(DataSet: TDataSet);                      // Ch026
    procedure GroupsDBAfterPost(DataSet: TDataSet);                        // Ch026
    procedure AccsDefaultsAfterPost(DataSet: TDataSet);                    // Ch026
    procedure AllocatedVATDBYr1AfterPost(DataSet: TDataSet);               // Ch026
  private
    { Private declarations }
    FExpenseLineIds: TIntArray;
    FIncomeLineIds: TIntArray;
    StartItem : Integer;        // Item to start reading from the Nominal Ledger for Budgets
    AllocatingBudgets,
    SettingBudgets : Boolean;   // TRUE while inserting Budgets from DOS data

    FBankDatasource : TDataSource;
    FAccounts : TAccounts;
    FDefaultEntCode: string;
    UpdateTable : TTable;

    FJobCardXmlDocument: IXMLDOMDocument;

    FProgramUpdateAvailableThread : TProgramUpdateAvailable;

    FProgramMaintenanceCheckThread : TProgramMaintenanceCheckThread;
    FMTDConfig: TMTDConfig;

    procedure AddRecords;
    procedure SetDatabaseAlias(AliasName: string);
    function  DataDirectory(AliasName : String): string;
    procedure CreatePrinter;
    procedure CreateNomMatch;
    procedure AddCoOpRecords;
    procedure CreateImportDefaults;
    procedure CreateImportDates;
    procedure CreateBudgets;
    procedure UpdateNominalAccount;
    procedure CreateProducts;
    procedure CreateProductsTx;
    procedure CreateProductsTxTemp;
    procedure CreateReports;
    procedure CreateProforma;
    procedure CreateInvoiceNumbers;
    procedure CreateInvoiceReport;
    procedure CreateInvoiceLayout;
    procedure CreateStatement;
    procedure CreateGroupsExportTable;
    procedure CreateSLPLDefaultsTable;
    procedure CreateNomDefaultsTable;
    procedure CreateNlaccsExportTable;
    procedure CreateTransTable; // Trans Dump File!
    procedure CreateAnalysisTable;
    procedure CreateAnalysisReportTable;
    procedure CopyAnalysisDetails;
    procedure CreateSLFileTable; //Paradox SLFile Replacement
    procedure CreatePLFileTable; // Paradox PLFile Replacement
    procedure CreateDatabaseDefaultsTable; // creats table for paradox defaults
    procedure CreateInvoiceAllocationTempTable; // creates table for holding temporary invoice allocation data
    procedure CheckEnterpriseField; // check & repair length of Enterprise Fiedd in trqansactions table
    procedure CreateTempVATTable; // Temporary VAT Report Table
    procedure CreateBankCSVDefaultsTable;  // Bank CSV Import Default Settings Table
    procedure CreateBankImportDefaultsTable; // Bank CSV Import user default settings table

    procedure CheckImportDateFields;

    procedure CheckDatabaseDefaultsTable;
    procedure CreateBankExtTable();
    procedure CreateBudgetExtTable();

    function GetLastImportBank: string;
    procedure SetLastImportBank(const Value: string);

    function GetDefaultStatementDirectory: string;
    procedure SetDefaultStatementDirectory(const Value: string);
    procedure CreateBankCSVDefaultData;

    function GetFirstActiveEnterprisedNominalInRange(AStart, AEnd : Integer) : Integer;
    procedure AddBankLinkDefaults;
    procedure CreateAccSyncDatabase;
    function GetCurrentDatabase: string;
    function GetCurrentDatabasePath: string;
    function GetJobCardXmlDocument: IXMLDOMDocument;
    procedure SetJobCardXmlDocument(const Value: IXMLDOMDocument);

    procedure CreateBankImportTransHash();
    function GetDefaultCoOpCompany: String;

    procedure DeleteBlankCoOpCompanies;

    procedure CreateCostPerUnitTempTable;  // Cost Per Unit Report Temp Table TGM AB 27/09/13

    procedure UpdateAccsDefaultsTable();

    procedure UpdateProductsTable();

    procedure UpdateBankCSVDefaultsTable;

    procedure DbSchemeError(AException : Exception; ATable, AField : string);

    procedure CreateProductAllocationTable;  // Product Allocation Table TGM AB 10/06/16

    procedure CreateEmailTemplatesTable;

    procedure CreateBankImportNLMatch;

    procedure UpdateBankImportNLMatch;

    property IncomeLineIds : TIntArray read FIncomeLineIds;
    property ExpenseLineIds : TIntArray read FExpenseLineIds;
    function GetMailboxExists: Boolean;
    procedure UpdateSLFile;
    function GetRegAccsVerNo: Integer;
    procedure SetRegAccsVerNo(const Value: Integer);
    function GetRegAccsModules: String;
    procedure SetRegAccsModules(const Value: String);
    function GetFinancialYearToStr: String;
    function GetNomProdRelationship: String;
    function GetAPISecret: string;
    procedure SetAPISecret(const Value: string);
    // Ch006 start

    procedure CreateVATReturnTable;
    procedure CreateVATArchiveTable;
    procedure CreateVATTotalsArchiveTable;
    procedure CreateHMRCReceiptTable();

    procedure UpdateVATReturnTable();
    function GetAccsDefaultsLastBackupDate: TDateTime;
    function GetAccsDefaultsLastUpdateDate: TDateTime;
    function GetAccsDefaultsUpdateNo: Integer;
    procedure SetAccsDefaultsLastBackupDate(const Value: TDateTime);
    procedure SetAccsDefaultsLastUpdateDate(const Value: TDateTime);
    procedure SetAccsDefaultsUpdateNo(const Value: Integer);
    function GetAccsDefaultsMaintPromptDate: TDateTime;
    procedure SetAccsDefaultsMaintPromptDate(const Value: TDateTime);
    function GetFarmgateSerialNo: Integer;
    function GetClientVRN: string;
    procedure SetClientVRN(const Value: string);

    procedure LoadMTDConfig();

    // Ch006 end
  public
    { Public declarations }
    FBankQuery : TQuery;

    NomListOK : Boolean;
    DontAllocateAcrossYear : boolean;
    allmonthszero :boolean;
    BudgetCalculator : TBudgetCalculator;
    RestartProgramAfterBackupRestore : Boolean;

    AgeOfDebtSyncRequired : Boolean;
    JobCardDownloadCount : Integer;

    SyncSettingsLoadError : Boolean;

    procedure CreatePreferenceDefaults(const AStoreName : string);
    procedure UseThisAlias(ThisAlias : String);
    procedure GetExpenseNominalLedgerAccs;
    procedure GetAllNominalLedgerAccs;
    procedure GetPurchaseLedgerAccs;
    procedure GetSalesLedgerAccs;
    procedure GetBudgets(BudgetsOrActual : TBudgetsOrActual);
    procedure GetBudgetReportFigures();
    function  FindNoZeroMonths: Boolean;
    Function LinkedToHerd : boolean;
    procedure CreateTempBudgetReportDB;
    procedure CreateThisYearTempTableDB;
    procedure CreateProformaReportTable;
    procedure CreateEntsFileTable;
    procedure CreateTransactionTable; // Paradox Trans Replacement File
    procedure CreateLedgerReportTable; // Temporary Table for new ledger report
    procedure CreateCustSuppTempTable; // Temporary Table for Cust / Supp report

    function GetBankBalance(const ABankName : string) : Double;
    procedure OpenRepositoryData();

    function GetNominalRecord(const ANLNo : Integer) : TQuery;
    function UpdateNominalRecord(const ANLNo : Integer;
      const ABalance, ASTPeriod, ASTYear, ABalanceST : Double): Boolean;
    function GetTransactionCount : Integer;
    //function GetEnterpriseAccounts : TEnterpriseAccounts;
    function Accounts : TAccounts;
    function MaxTransactionDate : TDateTime;

    procedure InitialiseTransPointers;
    procedure DisposeTransPointers;
    procedure CreateEnterpriseAnalysisReportTable; // Temporary Table for new Enterprise Analysis This Year vs Last Report
    procedure CreateCustSuppListingTable; // Temporary Table for Cust / Supp  listing reports
    procedure CreateTrialBalanceReportTable; // Temporary Table for new Trial Balance report
    function FieldExists(FieldName : String) : Boolean;

    function IsEnterpriseInUse(const AEnterpriseName : string) : Boolean;
    function GetEnterpriseCodeByName(const AEnterpriseName : string) : string;
    function GetEnterpriseByCode(const AEnterpriseCode : string) : TEnterpriseAccount;
    function GetEnterpriseCodeByNominalCode(const ANominalCode : string) : string;

    function GetBusinessSummaryAlterName() : string;
    function GetBudgetAlternateName() : string;
    function CostPerUnitReportAlternateName() : string;
    procedure CreateBankImportTempTable; // Bank CSV Import Temp Table for transactions

    procedure FreeAccounts();
    procedure OpenDataLinks;
    procedure UpdateBankDetails(ABankAccount : TBankAccount);

    function GetAdvancedQuantityInput(AEntCode : string) : TQuantityInput;

    // Look for the lowest active nominal account that has an Enterprise specified.
    function GetEnterpriseExpenseStart() : Integer;
    function GetEnterpriseIncomeStart() : Integer;
    function MultipleQuantityHandler(AEnterpriseCode : string;
       const AInQty2, AInQty3: Double; var AOutQty2, AOutQty3: Variant; APoint: TPoint) : Boolean;
    function ExtractStubFromBankDetailLine(const ADetailLine : string) : string;
    function UpdateCompanyId(ACompanyId : string) : Boolean;


    procedure SaveJobCardXmlDocument();
    function GetAppJobCards(const ACustomerId : Integer;
       const AJobCardViewType : TJobCardViewType = vtToBeImported) : TAppJobCards;
    function MarkJobCardAsSeen(const AClientId : string;
       const ADate : TDateTime) : Boolean;

    procedure AddToImportedJobCards(const AJobCardId: Integer);


    procedure CreateJobCardReportTable; // Temporary Table for new Job Card Report   TGM AB 01/05/15

    function GetNominalForSupplierCustomer(const ACustomerSupplierId : Integer;
       const ATransactionType : TTransactionType) : Integer;
    procedure CloseAndUpdate();

    function NewTransactionHash(const ATransactionLine : string ) : string;
    function TransactionHashExists(const ATransactionHash : string ) : Boolean;

    function  CreditAccount (Acc : Integer): Boolean;
    function  SetDOSAmount (Amount : Double; ReverseSign : Boolean): Integer;

    procedure StoreTransactionHash(const ATransactionHash : string );
    procedure HTMLHelp(Context: String);
    procedure DownloadKInstaller();
    function SyncServiceIsAvailable: Boolean;
    function KInstallerIsAvailable: Boolean;

    procedure GetProductUnits(AStrings : TStrings);

    Procedure CreateNLFileTable; // Paradox NLFile Replacement                              // TGM AB 09/12/16 Moved to public
    procedure CreateNLGroupsTable; // Paradox NL Groups File Replacement                    // TGM AB 09/12/16 Moved to public
    procedure AddNLGroups; // Add 999 Blank NLGroup Records                                 // TGM AB 09/12/16 Moved to public
    procedure AddNLCodes; // Add 999 Blank NL Code Records                                  // TGM AB 09/12/16 Moved to public

    procedure EditMailboxSettings;

    function SendEMail(const AToAddress, ASubject, ABody : string; AAttachments : TStringList) : Integer;

    function EmailTemplateExists(ATemplateName : string) : Boolean;
    function CreateTemplate(const ATemplateName : string;
       const ASubject : string = ''; const ABody : string = '') : Boolean;
    function UpdateTemplate(const ATemplateName, ASubject, ABody : string) : Boolean;
    procedure GetTemplate(const ATemplateName : string; var ASubject, ABody : string);
    function GetTemplateNames() : TDynamicStringArray;

    procedure StoreNLAndDescription(const ANLNo, ACustSuppNo : Integer; const ATransactionDesc, ATxType, ACustSuppDesc : string);
    function GetNLNoForBankImportDesc(const ADescription : string) : Integer;

    procedure UpdateCustomerName(ACustomerId : Integer; ACustomerName: string);

    procedure CreateBankAuditTrialTempTable; // Bank Audit Trial Report Temp Table TGM AB 01/03/2013

    function IsVATProcessed(ATxEdit: TxEditType): Boolean;
    procedure StoreHMRCReceipt(const AReceipt: string;
        const ATransactionId: string; const AReceiptProcessed: Boolean);
    function RetrieveHMRCReceipt(const ATransactionId: string) : string;
    function DigitalVATReturnCompleted : Boolean;

    function GetNextTxNo : Integer;

    function GetLastVATReturnInfo: TVATReturnInfo;

    function GetStoredBankLinkInfo (ABankDesc : String) : TStoredBankLinkInfo;

    procedure CheckNewVersionAvailable;

    procedure CheckMaintenanceWithKinstaller;

    function ReconcileLastMTDSubmission(
       const APeriodStart, APeriodEnd: TDateTime; const AVATReturn: TMTDVATReturn) : TMTDReconcile;

    function MTDVATSubmissionReceiptPending(
       const APeriodStart, APeriodEnd: TDateTime): Boolean;
    function PromptAndValidateMTDCredentials() : Boolean;
    function MTDCredentialStorePath: string;

    property DefaultEntCode : string read FDefaultEntCode write FDefaultEntCode;
    property LastImportBank : string read GetLastImportBank write SetLastImportBank;
    property DefaultStatementDirectory : string read GetDefaultStatementDirectory write SetDefaultStatementDirectory;
    property CurrentDatabase : string read GetCurrentDatabase;
    property CurrentDatabasePath : string read GetCurrentDatabasePath;
    property JobCardXmlDocument : IXMLDOMDocument read GetJobCardXmlDocument write SetJobCardXmlDocument;
    property DefaultCoOpCompany : String read GetDefaultCoOpCompany;
    property MailboxExists : Boolean read GetMailboxExists;
    property RegAccsVerNo : Integer read GetRegAccsVerNo write SetRegAccsVerNo;
    property RegAccsModules : String read GetRegAccsModules write SetRegAccsModules;
    property FinancialYearToStr : String read GetFinancialYearToStr;
    property NomProdRelationship : String read GetNomProdRelationship;
    property APISecret: string read GetAPISecret write SetAPISecret;
    // for UK Agents allow the storing & retrieval of Client VAT Registration Number
    property ClientVRN: string read GetClientVRN write SetClientVRN;
    property AccsDefaultsUpdateNo : Integer read GetAccsDefaultsUpdateNo write SetAccsDefaultsUpdateNo;
    property AccsDefaultsLastUpdateDate : TDateTime read GetAccsDefaultsLastUpdateDate write SetAccsDefaultsLastUpdateDate;
    property AccsDefaultsLastBackupDate : TDateTime read GetAccsDefaultsLastBackupDate write SetAccsDefaultsLastBackupDate;
    property AccsDefaultsMaintPromptDate : TDateTime read GetAccsDefaultsMaintPromptDate write SetAccsDefaultsMaintPromptDate;

    //   18/09/20 [V4.5 R3.8] /MK Change - Created a public property to return the Farmgate serial no.
    property FarmgateSerialNo : Integer read GetFarmgateSerialNo;
    property MTDConfig: TMTDConfig read FMTDConfig;
  end;

const
   cDairygold = 'Dairygold';
   cKerry = 'Kerry';
   cGlanbia = 'Glanbia';
   cBarryRoe = 'BarryRoe';
   cDrinagh = 'Drinagh';
   cBandon = 'Bandon';
   cArrabawn = 'Arrabawn';
   cLisavaird = 'Lisavaird';
   cCentenary = 'Centenary';

var
  AccsDataModule: TAccsDataModule;
  origvalue : real;


implementation
uses
    Calcs,
    DbGen,
    Clears,
    Util,
    vars,
    dbcore,
    BDE,
    FileCtrl,
    ubudgets, uallocatebudgets, registry, dataexport, uPreferences,
    uPreferenceConsts,
    TxWrite, uAccsSystem, Global, uTransactionQuantityInput,
    uFarmSyncSettings, Chkcomp, uMailboxHelper, uAccsMessages,
    CredentialsStore, LoginCredentials, uLoginCredentials;


{$R *.DFM}

Function TAccsDataModule.FindNoZeroMonths;
var count:integer;
begin

     // TGM AB 12/06/02 - Checks for zero fields in budgets
     count := 0;
     allmonthszero := false;
     result := true;
     if BudgetsJan.AsFloat*100 = 0  then begin
         result := false;
         inc(count);
     end;
     if BudgetsFeb.AsFloat*100 = 0  then begin
        result := false;
         inc(count);
     end;
     if BudgetsMar.AsFloat*100 = 0  then begin
        result := false;
         inc(count);
     end;
     if BudgetsApr.AsFloat*100 = 0  then begin
        result := false;
         inc(count);
     end;
     if BudgetsMay.AsFloat*100 = 0  then begin
        result := false;
         inc(count);
     end;
     if BudgetsJun.AsFloat*100 = 0  then begin
        result := false;
         inc(count);
     end;
     if BudgetsJul.AsFloat*100 = 0  then begin
        result := false;
         inc(count);
     end;
     if BudgetsAug.AsFloat*100 = 0  then begin
        result := false;
         inc(count);
     end;
     if BudgetsSep.AsFloat*100 = 0  then begin
        result := false;
         inc(count);
     end;
     if BudgetsOct.AsFloat*100 = 0  then begin
        result := false;
         inc(count);
     end;
     if BudgetsNov.AsFloat*100 = 0  then begin
        result := false;
         inc(count);
     end;
     if BudgetsDec.AsFloat*100 = 0  then begin
        result := false;
         inc(count);
     end;
     if count = 12 then allmonthszero := true;


end;

procedure TAccsDataModule.AddRecords;
begin
   with PrintFile do
      begin
         Open;  { The Table component must be OPEN }
         // Add default Records to Table
         Append;
         FieldByName('Printer Name').AsString := 'Laser Printer';
         FieldByName('Point Size Small').AsInteger := 7;
         FieldByName('Point Size Large').AsInteger := 12;
         FieldByName('Line Spacing').AsInteger := 10;
         FieldByName('Font Name').AsString := 'Courier';
         Post;
         Append;
         FieldByName('Printer Name').AsString := 'HP DeskJet';
         FieldByName('Point Size Small').AsInteger := 7;
         FieldByName('Point Size Large').AsInteger := 12;
         FieldByName('Line Spacing').AsInteger := 10;
         FieldByName('Font Name').AsString := 'Courier New';
         Post;
         Append;
         FieldByName('Printer Name').AsString := 'Dot Matrix';
         FieldByName('Point Size Small').AsInteger := 7;
         FieldByName('Point Size Large').AsInteger := 12;
         FieldByName('Line Spacing').AsInteger := 0;
         FieldByName('Font Name').AsString := 'Courier New';
         Post;
      end;
end;

procedure TAccsDataModule.UseThisAlias(ThisAlias : String);
var
   DataDir : String;
   DefaultBrowser : String;
begin
   if not Session.IsAlias(ThisAlias) then
   begin
     DataDir := DataDirectory(ThisAlias);
     Session.AddStandardAlias(ThisAlias, DataDir, 'PARADOX');
     Session.SaveConfigFile;
   end;
   SetDatabaseAlias(ThisAlias);
   // Open the Files
   OpenAllFiles;

   DefaultBrowser := GetDefaultWebBrowser;

   //   18/09/20 [V4.5 R3.8] /MK Change - If the DefaultStatementDirectory is null or it doesn't exist then default to the Desktop.
   //   29/09/20 [V4.5 R3.9] /MK Change - If the DefaultStatementDirectory is null or it doesn't exist then default to the Desktop/Downloads (whichever folder has CSV files).
   if ( DefaultStatementDirectory = '' ) or ( not(DirectoryExists(DefaultStatementDirectory)) ) then
       DefaultStatementDirectory := GetDownloadedCSVDir;
end;

procedure TAccsDataModule.SetDatabaseAlias(AliasName: string);
begin
   Screen.Cursor := crHourGlass;
   try
     AccsDataBase.Close;
     AccsDataBase.AliasName := AliasName;
     AccsDataBase.Open;

     //   07/08/12 [V4.1 R2.1] /MK Additional Feature - Created and set database name of UpdateTable on FormCreate.
     //                                               - Set database name of AddFieldsQuery on FormCreate.
     UpdateTable := TTable.Create(nil);
     UpdateTable.DatabaseName := AliasName;

     AddFieldsQuery.DatabaseName := AliasName;

     Global.AliasName := AliasName;
   finally
     Screen.Cursor := crDefault;
   end;
end;

function TAccsDataModule.DataDirectory(AliasName : String ) : string;
begin
   Result := ExtractFilePath(ParamStr(0));
   Result := ExpandFileName(Result + AliasName);
end;

procedure TAccsDataModule.OpenAllFiles;
var
   filename:string[20];
begin
   try
      if FileExists (AccsDataBase.Directory + 'Printers.db') then
         PrintFile.Open
      else
         CreatePrinter;  // Creates File Opens it and adds 3 default Records
      except
            ShowMessage('Cannot open the Printer File');
   end;
   try
      Filename:='SLPLDefaults';
      if NOT FileExists (AccsDataBase.Directory + SLPLDefaults.TableName + '.db' ) then
         CreateSLPLDefaultsTable;  // Creates File
      try SLPLDefaults.open
      except
      end;

      Filename:='NomDefaults';
      if NOT FileExists (AccsDataBase.Directory + NomDefaults.TableName + '.db' ) then
         CreateNomDefaultsTable;  // Creates File
      try NomDefaults.open
      except
      end;

      Filename:='NomMatch';
      if NOT FileExists (AccsDataBase.Directory + NomMatch.TableName + '.db' ) then
         CreateNomMatch;  // Creates File

      FileName:='ImportDefaults';
      if NOT FileExists (AccsDataBase.Directory + ImportDefaults.TableName + '.db' ) then
         CreateImportDefaults;  // Creates File
      try importdefaults.open
      except
            deletefile(AccsDataBase.Directory + ImportDefaults.TableName + '.db');
            CreateImportDefaults;
      end;
      DeleteBlankCoOpCompanies;
      AddCoOpRecords;

      FileName:='ImportDates';
      if NOT FileExists (AccsDataBase.Directory + ImportDates.TableName + '.db' ) then
         CreateImportDates;  // Creates File

      FileName:='Budgets';
      if NOT FileExists (AccsDataBase.Directory + Budgets.TableName + '.db' ) then
         CreateBudgets;  // Creates File

      FileName:='TempBudgetReport';
      if NOT FileExists (AccsDataBase.Directory + TempBudgetReportDB.TableName + '.db' ) then
         CreateTempBudgetReportDB;

      FileName:='ThisYearTempTable';
      if NOT FileExists (AccsDataBase.Directory + ThisYearTempTableDB.TableName + '.db' ) then
         CreateThisYearTempTableDB;

      FileName:='Products';
      if NOT FileExists (AccsDataBase.Directory + 'Products.db' ) then
         CreateProducts;  // Creates File
      products.databasename:=AccsDataBase.DatabaseName;  // Creates File

      FileName:='ProdsTx';
      if NOT FileExists (AccsDataBase.Directory + ProdsTx.TableName + '.db' ) then
         CreateProductsTx;  // Creates File
      ProdsTx.databasename:=AccsDataBase.DatabaseName;

      FileName:='ProdsTxTemp';
      if NOT FileExists (AccsDataBase.Directory + ProdsTxTemp.TableName + '.db' ) then
         CreateProductsTxTemp;  // Creates File
      ProdsTxTemp.databasename:=AccsDataBase.DatabaseName;

      // TGM AB 12/03/02 Fixes warning of unable to open reports when running via parameters

      if not ((param_type = 'P') or (param_type = 'S')) then begin
                              FileName:='Reports';
                              CreateReports;  // Creates File
                              end;

      // End TGM AB


  {    if not param_start then begin
                              FileName:='Reports';
                              CreateReports;  // Creates File
                              end;}
      FileName:='Proforma';
      if NOT FileExists  (AccsDataBase.Directory + 'proforma.db' ) then
         CreateProforma;
      proformaDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='InvoiceNumbers';
      if NOT FileExists  (AccsDataBase.Directory + 'invoiceNumbers.db' ) then
         CreateInvoiceNumbers;  // Creates File
      InvoiceNumbers.databasename:=AccsDataBase.DatabaseName;

      FileName:='InvoiceReport';
      if NOT FileExists  (AccsDataBase.Directory + '..\InvoiceReport.db' ) then
         CreateInvoiceReport;  // Creates File

      FileName:='InvoiceLayout';
      if NOT FileExists  (AccsDataBase.Directory + 'InvoiceLayout.db' ) then
         CreateInvoiceLayout;  // Creates File
      InvoiceLayout.databasename:=AccsDataBase.DatabaseName;

      FileName:='Statement';
      if NOT FileExists  (AccsDataBase.Directory + '\Statement.db' ) then
         CreateStatement;  // Creates File
      Statement.databasename:=AccsDataBase.DatabaseName;

      FileName:='Groups';
      if NOT FileExists  (AccsDataBase.Directory + '\groups.db' ) then
         CreateGroupsExportTable;  // Creates File
      GroupsDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='Analysis';
      if NOT FileExists  (AccsDataBase.Directory + '\analysis.db' ) then
             begin
             CreateAnalysisTable;  // Creates File
             AnalysisDB.databasename:=AccsDataBase.DatabaseName;
             // OpenFile ( AnalFile, Cash11.xAnl_File );
             // CopyAnalysisDetails - TGM AB Removed as no longer needed with new data
             end;
             AnalysisDB.databasename:=AccsDataBase.DatabaseName;

      Filename:='Defaults';
      if NOT FileExists  (AccsDataBase.Directory + '\databasedefaults.db' ) then
             begin
             CreateDatabaseDefaultsTable;  // Creates File
             // TGM AB need routine to setup defaults here!
             end;
             DefaultsDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='Nlaccs';
      if NOT FileExists  (AccsDataBase.Directory + '\nlaccs.db' ) then
         CreateNlaccsExportTable;  // Creates File
      NlaccsDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='Slaccs';
      if NOT FileExists  (AccsDataBase.Directory + '\slaccs.db' ) then
         CreateSlaccsExportTable;  // Creates File
      slaccsDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='Trans';
      if NOT FileExists  (AccsDataBase.Directory + '\Trans.db' ) then
         CreateTransTable;  // Creates File
      TransDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='Transactions';
      if NOT FileExists  (AccsDataBase.Directory + '\Transactions.db' ) then
         CreateTransactionTable;  // Creates File
      TransactionsDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='SLFile';
      if NOT FileExists  (AccsDataBase.Directory + '\SLFile.db' ) then
         CreateSLFileTable;  // Creates File
      SLFileDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='PLFile';
      if NOT FileExists  (AccsDataBase.Directory + '\PLFile.db' ) then
         CreatePLFileTable;  // Creates File
      PLFileDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='NLFile';
      if NOT FileExists  (AccsDataBase.Directory + '\NLFile.db' ) then begin
         CreateNLFileTable;  // Creates File
         NLFileDB.databasename:=AccsDataBase.DatabaseName;
         AddNLCodes;  // fixes problems with blank data having no records
         end;

      FileName:='NLGroups';
      if NOT FileExists  (AccsDataBase.Directory + '\NLGroups.db' ) then begin
         CreateNLGroupsTable;  // Creates File
         NLGroupsDB.databasename:=AccsDataBase.DatabaseName;
         AddNLGroups;
      end;
      NLGroupsDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='EntsFile';
      if NOT FileExists (AccsDataBase.Directory + '\EntsFile.db' ) then
         CreateEntsFileTable // Creates File
      else
         EntsFileDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='AllocationTempTable';
      if NOT FileExists  (AccsDataBase.Directory + '\AllocationTemp.db' ) then
         CreateInvoiceAllocationTempTable;  // Creates File
      AllocationTempDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='AnalysisReportTable';
      if NOT FileExists  (AccsDataBase.Directory + '\AnalysisReportTable.db' ) then
         CreateAnalysisReportTable;  // Creates File
      AnalysisReportTableDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='TempVATTable';
      if FileExists  (AccsDataBase.Directory + '\TempVAT.db' ) then deletefile (AccsDataBase.Directory + '\TempVAT.db' );
      if NOT FileExists  (AccsDataBase.Directory + '\TempVAT.db' ) then
         CreateTempVATTable;  // Creates File
      TempVATDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='AllocatedVAT';
      if NOT FileExists  (AccsDataBase.Directory + '\AllocatedVAT.db' ) then
         CreateAllocatedVATTable;  // Creates File
      AllocatedVATDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='OverpaymentTemp';
      if FileExists (AccsDataBase.Directory + '\OverpaymentTemp.db' ) then DeleteFile (AccsDataBase.Directory + '\OverpaymentTemp.db' );
 //     if NOT FileExists  (AccsDataBase.Directory + '\OverpaymentTemp.db' ) then
         CreateOverpaymentTempTable;  // Creates File
      OverpaymentTempDB.databasename:=AccsDataBase.DatabaseName;

      FileName:='AccsDefaults';
      if NOT FileExists  (AccsDataBase.Directory + '\AccsDefaults.db' ) then
         CreateAccsDefaultsTable() // Creates File
      else
         UpdateAccsDefaultsTable();
      AccsDefaults.databasename:=AccsDataBase.DatabaseName;
      AddAccsDefaults;

      FileName:='BankTable';
      if NOT FileExists  (AccsDataBase.Directory + '\BankTable.db' ) then
         CreateBankTable; // Creates File
      BankTableDB.databasename:=AccsDataBase.DatabaseName;

      FileName :='BankCSVDefaults';
      if NOT( FileExists(AccsDataBase.Directory + '\BankCSVDefaults.db') ) then
         CreateBankCSVDefaultsTable // Creates File
      //   22/10/12 [V5.1 R0.5] /MK Change - If BankCSVDefaults exists and its empty then
      //                                     delete it and re-create it again with default bank formats.
      else if FileExists(AccsDataBase.Directory + '\BankCSVDefaults.db') then
         begin
            BankCSVDefaultsDB.databasename:=AccsDataBase.DatabaseName;
            BankCSVDefaultsDB.Open;
            if ( BankCSVDefaultsDB.RecordCount = 0 ) then
               begin
                  BankCSVDefaultsDB.Close;
                  DeleteFile(AccsDataBase.Directory + '\BankCSVDefaults.db');
                  CreateBankCSVDefaultsTable;
               end;
            BankCSVDefaultsDB.Close;
            //   25/10/17 [V4.2 R8.9] /MK Change - Added new fields to the BankCSVDefaultsTable - Brendan Brady.
            UpdateBankCSVDefaultsTable;
         end;
      AddBankLinkDefaults;
      BankCSVDefaultsDB.databasename:=AccsDataBase.DatabaseName;

      FileName :='BankImportDefaults';
      if NOT FileExists  (AccsDataBase.Directory + '\BankImportDefaults.db' ) then
         CreateBankImportDefaultsTable; // Creates File
      BankImportDefaultsDB.databasename := AccsDataBase.DatabaseName;
      BankImportDefaultsDB.Open;

      {FileName :='BankCSVTempTable';
      // Its a temp db file always delete and recreate.
      DeleteFile(AccsDataBase.Directory + '\BankCSVTempTable.db');
      CreateBankImportTempTable; // Creates File}

      BankCSVTempTableDB.databasename:=AccsDataBase.DatabaseName;
      BankCSVDetailTempTableDB.databasename:=AccsDataBase.DatabaseName;

      FileName :='BankAuditTrailTempTable';                                                  // TGM AB 01/03/13
      if NOT FileExists  (AccsDataBase.Directory + '\BankAuditTrailTempTable.db' ) then
      CreateBankAuditTrialTempTable; // Creates File
      BankAuditTrailDB.databasename:=AccsDataBase.DatabaseName;

      FileName :='CostPerUnitReportTable';                                                  // TGM AB 27/09/13
      if NOT FileExists  (AccsDataBase.Directory + '\CostPerUnitReportTable.db' ) then
      CreateCostPerUnitTempTable; // Creates File
      CostPerUnitReportTableDB.databasename:=AccsDataBase.DatabaseName;

      FileName :='JobCardReportTable';                                                  // TGM AB 01/05/15
      if NOT FileExists  (AccsDataBase.Directory + '\JobCardReportTable.db' ) then      // TGM AB 01/05/15
      CreateJobCardReportTable; // Creates File                                         // TGM AB 01/05/15
      JobCardReportDB.databasename:=AccsDataBase.DatabaseName;                          // TGM AB 01/05/15

      FileName :='ProductAllocation';                                                   // TGM AB 10/06/16
      if NOT FileExists  (AccsDataBase.Directory + '\ProductAllocation.db' ) then       // TGM AB 10/06/16
      CreateProductAllocationTable; // Creates File                                     // TGM AB 10/06/16     
	  ProductAllocationDB.databasename:=AccsDataBase.DatabaseName;                      // TGM AB 10/06/16

      FileName :='VATReturn';                                                           // Ch006
      //if NOT FileExists  (AccsDataBase.Directory + '\VATReturn.db' ) then               // Ch006
      CreateVATReturnTable; // Creates File                                             // Ch006
      VATReturnDB.databasename:=AccsDataBase.DatabaseName;                              // Ch006

      FileName :='VATArchive';                                                          // Ch006
      if NOT FileExists  (AccsDataBase.Directory + '\VATArchive.db' ) then              // Ch006
      CreateVATArchiveTable; // Creates File                                            // Ch006
      VATArchiveDB.databasename:=AccsDataBase.DatabaseName;                             // Ch006

      FileName :='VATTotalsArchive';                                                    // Ch006
      if NOT FileExists  (AccsDataBase.Directory + '\VATTotalsArchive.db' ) then        // Ch006
      CreateVATTotalsArchiveTable; // Creates File                                      // Ch006
      VATTotalsArchiveDB.databasename:=AccsDataBase.DatabaseName;                       // Ch006

      FileName :='HMRCReceipts';                                                           // Ch006
      if NOT FileExists  (AccsDataBase.Directory + '\HMRCReceipts.db' ) then               // Ch006
      CreateHMRCReceiptTable; // Creates File                                             // Ch006
      VATReturnDB.databasename := AccsDataBase.DatabaseName;                              // Ch006


      CheckEnterpriseField;

      //   07/08/12 [V4.1 R2.1] /MK Change - New procedure to add fields to Import Dates table where they don't exist.
      CheckImportDateFields;

      LastNLFileDB.databasename:=AccsDataBase.DatabaseName;
      TransactionsYr1DB.databasename:=AccsDataBase.DatabaseName;
      TransactionsYr2DB.databasename:=AccsDataBase.DatabaseName;
      OverpaymentQuery.databasename:=AccsDataBase.DatabaseName;
      BankAuditTrailQuery.databasename:=AccsDataBase.DatabaseName;    // TGM AB 15/03/13
      CostPerUnitReportQuery.databasename:=AccsDataBase.DatabaseName;    // TGM AB 01/11/13

    //  FileName:='ProformaReportTable';
    //  if NOT FileExists  (AccsDataBase.Directory + '\ProformaReportTable.db' ) then
    //     CreateProformaReportTable;  // Creates File
    //   ProformaReportTableDB.databasename:=AccsDataBase.DatabaseName;

      CreateAccSyncDatabase();
      CreateBankImportTransHash();
      CreateEmailTemplatesTable();
      CreateBankImportNLMatch();

      UpdateVATReturnTable(); // Support for check on VAT submission's made without HMRC receipt being posted
   except
      //ShowMessage('Cannot open ' + FileName + ' File');
      on E : Exception do
         ShowMessage(e.Message);

   end;

   // SP 09/10/12
   CheckDatabaseDefaultsTable;

   CreateBankExtTable();
   CreateBudgetExtTable();

   UpdateProductsTable();
   UpdateSLFile(); //

end;

procedure TAccsDataModule.CheckEnterpriseField;
begin
    // repair Enterprise field which was accidentally created with length 1 not 4
    accsdatamodule.TransactionsDB.open;

    if TransactionsDB.fieldbyname('Enterprise').DataSize < 4 then begin
       TransactionsDB.close;

       AccsDataModule.AddFieldsQuery.databasename:=AccsDataBase.DatabaseName;

       AccsDataModule.AddFieldsQuery.sql.clear;
       AccsDataModule.AddFieldsQuery.sql.text:='ALTER TABLE Transactions ADD TempEnt CHAR(4)';
       AccsDataModule.AddFieldsQuery.ExecSQL;

       AccsDataModule.AddFieldsQuery.sql.clear;
       AccsDataModule.AddFieldsQuery.sql.text:='UPDATE Transactions SET TempEnt = Enterprise';
       AccsDataModule.AddFieldsQuery.ExecSQL;

       AccsDataModule.AddFieldsQuery.sql.clear;
       AccsDataModule.AddFieldsQuery.sql.text:='ALTER TABLE Transactions DROP Enterprise';
       AccsDataModule.AddFieldsQuery.ExecSQL;

       AccsDataModule.AddFieldsQuery.sql.clear;
       AccsDataModule.AddFieldsQuery.sql.text:='ALTER TABLE Transactions ADD Enterprise CHAR(4)';
       AccsDataModule.AddFieldsQuery.ExecSQL;

       AccsDataModule.AddFieldsQuery.sql.clear;
       AccsDataModule.AddFieldsQuery.sql.text:='UPDATE Transactions SET Enterprise = TempEnt';
       AccsDataModule.AddFieldsQuery.ExecSQL;

       AccsDataModule.AddFieldsQuery.sql.clear;
       AccsDataModule.AddFieldsQuery.sql.text:='ALTER TABLE Transactions DROP TempEnt';
       AccsDataModule.AddFieldsQuery.ExecSQL;

       AccsDataModule.AddFieldsQuery.sql.clear;
    end;
    accsdatamodule.TransactionsDB.close;
end;




procedure TAccsDataModule.CloseAllFiles;
var i: integer;
begin
     for i:= 0 to accsdatamodule.componentcount-1 do
     begin
          if (accsdatamodule.components[i] is TQuery) then
          (accsdatamodule.components[i] as TQuery).close;
     end;
     for i:= 0 to accsdatamodule.componentcount-1 do
     begin
          if (accsdatamodule.components[i] is TDataset) then
          (accsdatamodule.components[i] as Tdataset).close;
     end;
     for i:= 0 to accsdatamodule.componentcount-1 do
     begin
          if (accsdatamodule.components[i] is Ttable) then
          (accsdatamodule.components[i] as Ttable).close;
     end;
     reports.Report.Table.close;

end;

procedure TAccsDataModule.CreateTempVATTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'TempVAT';
            with FieldDefs do
               begin

                  Add('RecID',ftAutoInc,0,FALSE);
                  Add('Label',ftString,255,FALSE);
                  Add('Record',ftInteger,0,FALSE);
                  Add('TxDate',ftDate,0,FALSE);
                  Add('Account',ftString,50,FALSE);
                  Add('Reference',ftString,50,FALSE);
                  Add('Amount',ftfloat,0,FALSE);
                  Add('VAT',ftfloat,0,FALSE);
                  Add('VATCode',ftString,1,FALSE);
                  Add('Description',ftString,50,FALSE);
                  Add('AmountText',ftstring,20,FALSE);
                  Add('VATText',ftstring,20,FALSE);
                  Add('TxID',ftinteger,0,False);
                  Add('PreviousYear',ftstring,1,FALSE);
                  Add('VATBreakdown',ftstring,15,FALSE);        // TGM AB 04/08/17
                  Add('TotalBreakdown',ftstring,15,FALSE);      // TGM AB 04/08/17
                  Add('CodeBreakdown',ftstring,1,FALSE);        // TGM AB 04/08/17
                  Add('DescBreakdown',ftstring,30,FALSE);       // TGM AB 04/08/17
                  Add('VATID',ftinteger,0,False);               // Ch006

               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateStatement;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'Statement';
            with FieldDefs do
               begin

                  Add('ID',ftAutoInc,0,FALSE);
                  Add('StateType',ftString,1,FALSE);      // S - Sales & P - Purchase
                  Add('Name',ftString,30,FALSE);
                  Add('Address1',ftString,35,FALSE);
                  Add('Address2',ftString,35,FALSE);
                  Add('Address3',ftString,35,FALSE);
                  Add('Address4',ftString,35,FALSE);
                  Add('Telephone',ftString,45,FALSE);
                  Add('WebEmail',ftString,45,FALSE);
                  Add('Showheader',ftBoolean,0,FALSE);
                  Add('StatementFrom',ftBoolean,0,FALSE);
                  Add('ShowNetAmount',ftBoolean,0,FALSE);
                  Add('ShowTaxCode',ftBoolean,0,FALSE);
                  Add('ShowTaxAmount',ftBoolean,0,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateTrialBalanceReportTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'TrialBalanceReportTable';
            with FieldDefs do
               begin
       //           Add('ID',ftAutoinc,0,FALSE);
                  Add('RecNo',ftInteger,0,FALSE);
                  Add('Name',ftString,50,FALSE);

                  Add('Curr_Db',ftString,15,FALSE);
                  Add('Curr_Cr',ftString,15,FALSE);

                  Add('Open_Db',ftString,15,FALSE);
                  Add('Open_Cr',ftString,15,FALSE);

                  Add('Mov_Db',ftString,15,FALSE);
                  Add('Mov_Cr',ftString,15,FALSE);

                  Add('Close_Db',ftString,15,FALSE);
                  Add('Close_Cr',ftString,15,FALSE);

                  Add('Labels',ftString,255,FALSE);
                  
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;


procedure TAccsDataModule.CreateLedgerReportTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'LedgerReportTable';
            with FieldDefs do
               begin
                  Add('ID',ftAutoinc,0,FALSE);
                  Add('TxDate',ftDate,0,FALSE);
                  Add('TxNo',ftInteger,0,FALSE);
                  Add('TxType',ftString,5,FALSE);
                  Add('TxReference',ftString,15,FALSE);
                  Add('TxDescription',ftString,33,FALSE);
                  Add('Debit',ftFloat,0,FALSE);
                  Add('Credit',ftFloat,0,FALSE);
                  Add('Balance',ftFloat,0,FALSE);
                  Add('AccountNoLabel',ftString,100,FALSE);
                  Add('LineLabel',ftString,150,FALSE);
                  Add('LastYear',ftString,1,FALSE);
                  Add('CustomerAddressLabel',ftString,100,FALSE);
                  Add('StatementLabel',ftString,100,FALSE);
                  Add('BlueLineLabel',ftString,255,False);      // TGM AB 04/03/16
                  Add('BlueLineLabel2',ftString,255,False);     // TGM AB 04/03/16
                  Add('LineDate',ftDate,0,False);               // TGM AB 04/03/16
                  Add('LineDescription',ftstring,33,False);     // TGM AB 04/03/16
                  Add('LineQty',ftFloat,0,False);               // TGM AB 04/03/16
                  Add('LineUnitPrice',ftFloat,0,False);         // TGM AB 04/03/16
                  Add('LinePrice',ftFloat,0,False);             // TGM AB 04/03/16
                  Add('LineVAT',ftFloat,0,False);               // TGM AB 04/03/16
                  Add('LineCredit',ftFloat,0,False);            // TGM AB 04/03/16
                  Add('LineDebit',ftFloat,0,False);             // TGM AB 04/03/16
                  Add('TotalLinePrice',ftFloat,0,False);        // TGM AB 25/03/16
                  Add('TotalLineVAT',ftFloat,0,False);          // TGM AB 25/03/16
                  Add('TotalLineCredit',ftFloat,0,False);       // TGM AB 25/03/16
                  Add('TotalLineDebit',ftFloat,0,False);        // TGM AB 25/03/16
                  Add('BoldBlueLineLabel',ftString,150,False);  // TGM AB 25/03/16
                  Add('GreenLineLabel',ftString,150,False);     // TGM AB 15/04/16
                  Add('LineType',ftString,2,False);             // TGM AB 02/09/16
                  Add('AccNo',ftInteger,0,FALSE);               // TGM AB 02/09/16
                  Add('CommentLabel',ftString,255,False);       // Ch032
               end;
               
            if (Exists) then DeleteTable;

            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateCustSuppListingTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'CustSuppListingTable';
            with FieldDefs do
               begin
                  Add('ID',ftAutoinc,0,FALSE);
                  Add('Code',ftString,5,FALSE);
                  Add('Name',ftString,30,FALSE);
                  Add('Address1',ftString,30,FALSE);
                  Add('Address2',ftString,30,FALSE);
                  Add('Address3',ftString,30,FALSE);
                  Add('Address4',ftString,30,FALSE);
                  Add('Address5',ftString,30,FALSE);
                  Add('PostCode',ftString,20,FALSE);
                  Add('LineLabel',ftString,255,FALSE);
                  Add('BoldLineLabel',ftString,255,FALSE);
                  Add('Amount1',ftInteger,0,FALSE);
                  Add('Amount2',ftInteger,0,FALSE);
                  Add('PhoneNo1',ftString,30,FALSE);            // TGM AB 16/11/12
                  Add('PhoneNo2',ftString,30,FALSE);            // TGM AB 16/11/12
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateCustSuppTempTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'CustSuppTempTable';
            with FieldDefs do
               begin
                  Add('ID',ftAutoinc,0,FALSE);
                  Add('TxDate',ftDate,0,FALSE);
                  Add('TxNo',ftInteger,0,FALSE);
                  Add('TxType',ftString,5,FALSE);
                  Add('TxReference',ftString,15,FALSE);
                  Add('TxDescription',ftString,33,FALSE);
                  Add('Debit',ftFloat,0,FALSE);
                  Add('Credit',ftFloat,0,FALSE);
                  Add('Balance',ftFloat,0,FALSE);
                  Add('LastYear',ftString,1,FALSE);
                  Add('Discount',ftFloat,0,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateDatabaseDefaultsTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'databasedefaults';
            with FieldDefs do
               begin
                  Add('EntsMax',ftInteger,0,FALSE);
                  Add('EntsUsed',ftInteger,0,FALSE);
                  Add('SLMax',ftInteger,0,FALSE);
                  Add('SLUsed',ftInteger,0,FALSE);
                  Add('PLMax',ftInteger,0,FALSE);
                  Add('PLUsed',ftInteger,0,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;


procedure TAccsDataModule.CreateTransactionTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'Transactions';
            with FieldDefs do
               begin
                  Add('TxNo',ftAutoInc,0,FALSE);
                  Add('TxType',ftInteger,0,FALSE);
                  Add('TxDate',ftDate,0,FALSE);
                  Add('Account',ftInteger,0,FALSE);
                  Add('Reference',ftstring,15,FALSE);    // Extended from 8
                  Add('Descript',ftstring,30,false);     // Extended from 15
                  Add('Quantity',ftfloat,0,false);
                  Add('Product',ftInteger,0,FALSE);
                  Add('Nominal',ftInteger,0,FALSE);
                  Add('Amount',ftfloat,0,false);
                  Add('TaxCode',ftstring,1,false);
                  Add('TaxDisc',ftfloat,0,false);
                  Add('Analysis',ftInteger,0,false);
                  Add('NextDB',Ftinteger,0,false);
                  Add('NextCR',Ftinteger,0,false);
                  Add('NextSP',Ftinteger,0,false);
                  Add('NomAmount',Ftfloat,0,false);
                  Add('DebitAC',Ftinteger,0,false);
                  Add('CreditAC',Ftinteger,0,false);
                  Add('OrigType',Ftinteger,0,false);
                  Add('Enterprise',ftstring,4,false);
                  Add('StubNo',Ftstring,8,false);
                  Add('BankRec',ftstring,1,FALSE);
                  Add('EditStat',ftstring,1,FALSE);
                  Add('AmtPaid',Ftfloat,0,false);
                  Add('Allocated',ftstring,1,FALSE);
                  Add('DueDate',ftDate,0,FALSE);
                  Add('AllocationComplete',ftboolean,0,FALSE);
                  Add('AllocatedVATAmount',Ftfloat,0,false);
                  Add('VATClaimed',Ftfloat,0,false);
                  Add('Overpayment',Ftfloat,0,false);
                  Add('AllocatedToOpening',Ftboolean,0,false);
                  Add('Quantity2',ftfloat,0,false);                // TGM AB 01/02/13
                  Add('Quantity3',ftfloat,0,false);                // TGM AB 01/02/13
                  Add('CoOpImport',ftBoolean,0,false);             // Ch009
                  Add('CoOpComment',ftString,50,false);            // Ch009
                  Add('VATProcessed'ftBoolean,0,false);            // Ch006
                  Add('ReturnID',Ftinteger,0,false);               // Ch006



               end;
            IndexDefs.Add('','TxNo',[ixPrimary, ixUnique]);
            if ( not(Exists) ) then
               CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateEntsFileTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'EntsFile';
            with FieldDefs do
               begin

                  Add('EntNo',ftAutoInc,0,FALSE);
                  Add('EntCode',ftString,4,FALSE);
                  Add('EntName',ftString,20,FALSE);
                  Add('UnitDiv',ftfloat,0,false);
                  Add('UnitText',ftString,15,false);
                  Add('IncFrom',ftInteger,0,FALSE);
                  Add('IncTo',ftInteger,0,FALSE);
                  Add('ExpFrom',ftInteger,0,FALSE);
                  Add('ExpTo',ftInteger,0,FALSE);
                  Add('CosFrom',ftInteger,0,FALSE);
                  Add('CosTo',ftInteger,0,FALSE);
                  Add('Active',ftBoolean,0,False);
                  Add('Quantity2Name',ftString,30,false);   // TGM AB 01/03/13
                  Add('Quantity3Name',ftString,30,false);   // TGM AB 01/03/13
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateSLFileTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'SLFile';
            with FieldDefs do
               begin

                  Add('SLNo',ftAutoInc,0,FALSE);
                  Add('Name',ftString,30,FALSE);
                  Add('Address1',ftString,30,FALSE);
                  Add('Address2',ftString,30,FALSE);
                  Add('Address3',ftString,30,FALSE);
                  Add('Address4',ftString,30,FALSE);
                  Add('BalanceBF',ftFloat,0,FALSE);
                  Add('Balance',ftFloat,0,FALSE);
                  Add('Turnover',ftFloat,0,FALSE);
                  Add('AgeCurr',ftFloat,0,FALSE);
                  Add('Age1',ftFloat,0,FALSE);
                  Add('Age2',ftFloat,0,FALSE);
                  Add('Age3',ftFloat,0,FALSE);
                  Add('NotAlloc',ftFloat,0,FALSE);
                  Add('FirstYear',ftInteger,0,FALSE);
                  Add('FirstTx',ftInteger,0,FALSE);
                  Add('LastTx',ftInteger,0,FALSE);
                  Add('BalanceST',ftFloat,0,FALSE);
                  Add('PayDate',ftDate,0,FALSE);
                  Add('PhoneNo1',ftString,30,FALSE);
                  Add('PhoneNo2',ftString,30,FALSE);
                  Add('FaxNo',ftString,30,FALSE);
                  Add('AreaCode',ftInteger,0,FALSE);
                  Add('PostCode',ftString,20,FALSE);
                  Add('CustRef',ftString,20,FALSE);
                  Add('Contact1',ftString,20,FALSE);
                  Add('Contact2',ftString,20,FALSE);
                  Add('VATNo',ftString,20,FALSE);
                  Add('Comment1',ftString,25,FALSE);
                  Add('Comment2',ftString,25,FALSE);
                  Add('Comment3',ftString,25,FALSE);
                  Add('Address5',ftString,30,FALSE);
                  Add('Email',ftString,50,FALSE);
                  Add('Active',ftboolean,0,FALSE);

               end;
            IndexDefs.Add('','SLNo',[ixPrimary, ixUnique]);
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreatePLFileTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'PLFile';
            with FieldDefs do
               begin

                  Add('PLNo',ftAutoInc,0,FALSE);
                  Add('Name',ftString,30,FALSE);
                  Add('Address1',ftString,30,FALSE);
                  Add('Address2',ftString,30,FALSE);
                  Add('Address3',ftString,30,FALSE);
                  Add('Address4',ftString,30,FALSE);
                  Add('BalanceBF',ftFloat,0,FALSE);
                  Add('Balance',ftFloat,0,FALSE);
                  Add('Turnover',ftFloat,0,FALSE);
                  Add('AgeCurr',ftFloat,0,FALSE);
                  Add('Age1',ftFloat,0,FALSE);
                  Add('Age2',ftFloat,0,FALSE);
                  Add('Age3',ftFloat,0,FALSE);
                  Add('NotAlloc',ftFloat,0,FALSE);
                  Add('FirstYear',ftInteger,0,FALSE);
                  Add('FirstTx',ftInteger,0,FALSE);
                  Add('LastTx',ftInteger,0,FALSE);
                  Add('BalanceST',ftFloat,0,FALSE);
                  Add('PayDate',ftDate,0,FALSE);
                  Add('PhoneNo1',ftString,30,FALSE);
                  Add('PhoneNo2',ftString,30,FALSE);
                  Add('FaxNo',ftString,30,FALSE);
                  Add('AreaCode',ftInteger,0,FALSE);
                  Add('PostCode',ftString,20,FALSE);
                  Add('CustRef',ftString,20,FALSE);
                  Add('Contact1',ftString,20,FALSE);
                  Add('Contact2',ftString,20,FALSE);
                  Add('VATNo',ftString,20,FALSE);
                  Add('Comment1',ftString,25,FALSE);
                  Add('Comment2',ftString,25,FALSE);
                  Add('Comment3',ftString,25,FALSE);
                  Add('Address5',ftString,30,FALSE);
                  Add('Email',ftString,50,FALSE);
                  Add('Active',ftboolean,0,FALSE);
               end;
            IndexDefs.Add('','PLNo',[ixPrimary, ixUnique]);
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateNLFileTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'NLFile';
            with FieldDefs do
               begin

                  Add('NLNo',ftAutoInc,0,FALSE);
                  Add('Name',FtString,30,False);
                  Add('Balance',FtFloat,0,False);
                  Add('STPeriod',FtFloat,0,False);
                  Add('STYear',FtFloat,0,False);
                  Add('RepGroup',FtInteger,0,False);
                  Add('STWeek',FtFloat,0,False);
                  Add('BudgYear',FtFloat,0,False);
                  Add('FirstBank',FtInteger,0,False);
                  Add('FirstTX',FtInteger,0,False);
                  Add('LastTx',FtInteger,0,False);
                  Add('YearTot1',FtFloat,0,False);
                  Add('YearTot2',FtFloat,0,False);
                  Add('YearTot3',FtFloat,0,False);
                  Add('TaxCode',FtString,1,False);
                  Add('RepFlag',FtString,1,False);
                  Add('BalanceST',FtFloat,0,False);
                  Add('Enterprise',FtString,4,False);
                  Add('BudPer01',FtFloat,0,False);
                  Add('BudPer02',FtFloat,0,False);
                  Add('BudPer03',FtFloat,0,False);
                  Add('BudPer04',FtFloat,0,False);
                  Add('BudPer05',FtFloat,0,False);
                  Add('BudPer06',FtFloat,0,False);
                  Add('BudPer07',FtFloat,0,False);
                  Add('BudPer08',FtFloat,0,False);
                  Add('BudPer09',FtFloat,0,False);
                  Add('BudPer10',FtFloat,0,False);
                  Add('BudPer11',FtFloat,0,False);
                  Add('BudPer12',FtFloat,0,False);
                  Add('BudPer13',FtFloat,0,False);
                  Add('ActPer01',FtFloat,0,False);
                  Add('ActPer02',FtFloat,0,False);
                  Add('ActPer03',FtFloat,0,False);
                  Add('ActPer04',FtFloat,0,False);
                  Add('ActPer05',FtFloat,0,False);
                  Add('ActPer06',FtFloat,0,False);
                  Add('ActPer07',FtFloat,0,False);
                  Add('ActPer08',FtFloat,0,False);
                  Add('ActPer09',FtFloat,0,False);
                  Add('ActPer10',FtFloat,0,False);
                  Add('ActPer11',FtFloat,0,False);
                  Add('ActPer12',FtFloat,0,False);
                  Add('ActPer13',FtFloat,0,False);
                  Add('LstPer01',FtFloat,0,False);
                  Add('LstPer02',FtFloat,0,False);
                  Add('LstPer03',FtFloat,0,False);
                  Add('LstPer04',FtFloat,0,False);
                  Add('LstPer05',FtFloat,0,False);
                  Add('LstPer06',FtFloat,0,False);
                  Add('LstPer07',FtFloat,0,False);
                  Add('LstPer08',FtFloat,0,False);
                  Add('LstPer09',FtFloat,0,False);
                  Add('LstPer10',FtFloat,0,False);
                  Add('LstPer11',FtFloat,0,False);
                  Add('LstPer12',FtFloat,0,False);
                  Add('LstPer13',FtFloat,0,False);
                  Add('Active',FtBoolean,0,False);

                  // Fields used in Interim NLAccsExt Table
                  Add('DepRate',ftfloat,0,FALSE);
                  Add('DepAmount',ftfloat,0,FALSE);
                  Add('NominalType',ftString,1,FALSE);
                  Add('Category',ftString,10,FALSE);
                  Add('IsSynchronized',ftBoolean);

               end;
            IndexDefs.Add('','NLNo',[ixPrimary, ixUnique]);
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;



procedure TAccsDataModule.CreatePrinter;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'Printers';
            with FieldDefs do
               begin
                  Add('Printer No',ftAutoInc,0,FALSE);
                  Add('Printer Name',ftString,30,FALSE);
                  Add('Point Size Small',ftSmallInt,0,FALSE);
                  Add('Point Size Large',ftSmallInt,0,FALSE);
                  Add('Line Spacing',ftSmallInt,0,FALSE);
                  Add('Font Name',ftString,30,FALSE);
               end;
            IndexDefs.Add('iPrinterNo','Printer No',[ixPrimary, ixUnique]);
            CreateTable;
         end;
   finally
      MyTable.Free;
      AddRecords;
   end;
end;

procedure TAccsDataModule.CreateNomMatch;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := NomMatch.TableName;
            with FieldDefs do
               begin
                  Add('ID',ftAutoInc,0,FALSE);
                  Add('ExtFileCode',ftString,10,FALSE);
                  Add('NLRecNo',ftInteger,0,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateReports;
var
   MyTable : TTable;
begin
     deletefile('c:\kingsacc\reports.db');
   try
      MyTable := TTable.Create(nil);
       MyTable.DatabaseName:= AccsDataBase.Directory + '..';
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'report.db';
            with FieldDefs do
               begin
                  Add('Section',ftInteger,0,FALSE);
                  Add('F1',ftString,81,FALSE);    // tgm ab 02/05/02 increased to 81 to cater for box label lines on vat reports & Line Length in Landscape reports
                  Add('F2',ftString,55,FALSE);
                  Add('F3',ftString,55,FALSE);
                  Add('F4',ftString,55,FALSE);
                  Add('F5',ftString,55,FALSE);
                  Add('F6',ftString,55,FALSE);
                  Add('F7',ftString,55,FALSE);
                  Add('F8',ftString,55,FALSE);
                  Add('F9',ftString,55,FALSE);   // tgm ab
                  Add('F10',ftString,55,FALSE);  // tgm ab
                  Add('F11',ftString,35,FALSE);
                  Add('F12',ftString,35,FALSE);
                  Add('F13',ftString,35,FALSE);
                  Add('F14',ftString,35,FALSE);
                  Add('F15',ftString,35,FALSE);
                  Add('F16',ftString,35,FALSE);
                  Add('F17',ftString,35,FALSE);
                  Add('F18',ftString,35,FALSE);
                  Add('F19',ftString,50,FALSE); // tgm 12/03/02 increased to 50 to cater for **error** in totals when trial balance doesn't balance
                  Add('F20',ftString,50,FALSE); // tgm AB 02/05/02 increased to 50 to cater for **error** in totals when trial balance doesn't balance
                  Add('F21',ftString,35,FALSE);
                  Add('F22',ftString,35,FALSE);
                  Add('F23',ftString,50,FALSE); // tgm ab 30/4/02 increased to add room for long nominal names in Full Nominal Audit
                  Add('F24',ftString,50,FALSE); // tgm ab 30/4/02 increased to add room for **error** in totals in Full Nominal Audit
                  Add('F25',ftString,35,FALSE);
                  Add('F26',ftString,20,FALSE);
                  Add('F27',ftString,20,FALSE);
                  Add('F28',ftString,20,FALSE);
                  Add('F29',ftString,20,FALSE);
                  Add('F30',ftString,20,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
   // Report.Table.DatabaseName := AccsDataBase.Directory + '..';
   // Report.Query.DatabaseName := AccsDataBase.Directory + '..'; // TGM AB 13/03/02
end;


procedure TAccsDataModule.CreateInvoiceReport;
var
   MyTable : TTable;
begin
     deletefile('c:\kingsacc\InvoiceReport.db');
   try
      MyTable := TTable.Create(nil);
       MyTable.DatabaseName:= AccsDataBase.Directory + '..';
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'InvoiceReport.db';
            with FieldDefs do
               begin
                  Add('Description',ftString,15,FALSE);
                  Add('Ref',ftString,8,FALSE);
                  Add('Quantity',ftString,15,FALSE);
                  Add('Each',ftString,15,FALSE);
                  Add('EachIncVAT',ftString,15,FALSE);
                  Add('TotalExcVAT',ftString,15,FALSE);
                  Add('VAT',ftString,15,FALSE);
                  Add('VAT Rate',ftString,8,FALSE);
                  Add('TotalIncVAT',ftString,15,FALSE);
                  Add('LineDate',ftString,8,FALSE);
                  Add('LineRef',ftString,20,FALSE);
                  Add('Line1',ftString,30,FALSE);
                  Add('Line2',ftString,30,FALSE);
                  Add('Line3',ftString,30,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
   InvoiceReportTable.DatabaseName := AccsDataBase.Directory + '..';
   InvoiceReportTable.TableName := 'InvoiceReport.db';

//   Report.Query.DatabaseName := AccsDataBase.Directory + '..';
end;

procedure TAccsDataModule.CreateProforma;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'proforma.db';
            with FieldDefs do
               begin
                  Add('BatchID',ftInteger,0,FALSE);
                  Add('CustID',ftInteger,0,FALSE);
                  Add('JobDate',ftDate,0,FALSE);
                  Add('Reference',ftString,8,FALSE);
                  Add('Descript',ftString,15,FALSE);
                  Add('Enterprise',ftString,5,FALSE);
                  Add('Nominal',ftInteger,0,FALSE);
                  Add('Quantity',ftString,15,FALSE);
                  Add('Amount',ftString,10,FALSE);
                  Add('TaxCode',ftString,1,FALSE);
                  Add('TaxAmount',ftString,10,FALSE);
                  Add('LineNo',ftInteger,0,FALSE);
                  Add('LineDate',ftDate,0,false);
                  Add('LineRef',ftString,20,false);
                  Add('Desc1',ftString,30,FALSE);
                  Add('Desc2',ftString,30,FALSE);
                  Add('Desc3',ftString,30,FALSE);
                  Add('Comment',ftString,30,FALSE);
                  Add('Proforma',ftBoolean,0,FALSE);
                  Add('Complete',ftBoolean,0,FALSE);
                  Add('ProformaNumber',ftInteger,0,FALSE);
                  Add('QuoteNumber',ftInteger,0,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateInvoiceNumbers;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'InvoiceNumbers.db';
            with FieldDefs do
               begin
                  Add('LastSaleInv',ftInteger,0,FALSE);
                  Add('LastSaleCred',ftInteger,0,FALSE);
                  Add('LastPurchInv',ftInteger,0,FALSE);
                  Add('LastPurchCred',ftInteger,0,FALSE);
               //   Add('LastJobRef',ftInteger,0,FALSE); Removed TGM AB 2/08/02 no longer used
                  Add('LastProforma',ftInteger,0,FALSE);
                  Add('LastQuote',ftInteger,0,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateInvoiceLayout;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'InvoiceLayout.db';
            with FieldDefs do
               begin
                  Add('ID',ftAutoInc,0,False);
                  Add('ReportName',ftString,60,FALSE);
                  Add('Name',ftString,50,FALSE);
                  Add('IncName',ftBoolean,0,False);
                  Add('Address1',ftString,30,FALSE);
                  Add('IncAddress1',ftBoolean,0,False);
                  Add('Address2',ftString,30,FALSE);
                  Add('IncAddress2',ftBoolean,0,False);
                  Add('Address3',ftString,30,FALSE);
                  Add('IncAddress3',ftBoolean,0,False);
                  Add('Address4',ftString,30,FALSE);
                  Add('IncAddress4',ftBoolean,0,False);
                  Add('Address5',ftString,8,FALSE);
                  Add('IncAddress5',ftBoolean,0,False);
                  Add('Tel1',ftString,15,FALSE);
                  Add('IncTel1',ftBoolean,0,False);
                  Add('Tel2',ftString,15,FALSE);
                  Add('IncTel2',ftBoolean,0,False);
                  Add('Fax',ftString,15,FALSE);
                  Add('IncFax',ftBoolean,0,False);
                  Add('Mobile',ftString,15,FALSE);
                  Add('IncMobile',ftBoolean,0,False);
                  Add('Email',ftString,60,FALSE);
                  Add('IncEmail',ftBoolean,0,False);
                  Add('Web',ftString,60,FALSE);
                  Add('IncWeb',ftBoolean,0,False);
                  Add('VATNumber',ftString,30,FALSE);
                  Add('IncVATNumber',ftBoolean,0,False);
                  Add('RemittanceComment',ftString,50,FALSE);
                  Add('IncRemittanceSlip',ftBoolean,0,False);
                  Add('UseLineDate',ftBoolean,0,False);
                  //   22/02/17 [V4.2 R6.4] /MK Change - Add new UseLineReference field.
                  Add('UseLineReference',ftBoolean,0,False);
               end;
            IndexDefs.Add('iInvoiceLayout','ID',[ixPrimary, ixUnique]);
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.AddCoOpRecords;
var
   saKerryTypeCoOps : array [0..7] of String;
   i : Integer;
begin
    try
       with ImportDefaults do
          begin
             Open;
             //   02/03/16 [V4.2 R1.9] /MK Additional Feature - Add two new co-ops (Drinagh and Bandon) that use the Kerry file standard.
             //                                               - Used an array to add these extra Co-Ops to the table.
             //                                               - Set the UseAsDefault button based on whether a default Co-Op was already selected.

             //   16/09/16 [V4.2 R3.7] /MK Additional Feature - Added new co-op, BarryRoe, that uses the Kerry file standard.
             //                                               - Dairygold file spec is the same as Kerry - Michael Cloney (Dairygold) / GL.
             saKerryTypeCoOps[0] := cKerry;
             saKerryTypeCoOps[1] := cDrinagh;
             saKerryTypeCoOps[2] := cBandon;
             saKerryTypeCoOps[3] := cBarryRoe;
             saKerryTypeCoOps[4] := cDairygold;

             //   02/11/17 [V4.2 R9.1] /MK Additional Feature - Added Arrabawn and Lisavaird Co-Ops - GL/DOM request.
             saKerryTypeCoOps[5] := cArrabawn;
             saKerryTypeCoOps[6] := cLisavaird;

             //   13/11/17 [V4.2 R9.2] /MK Additional Feature - Added Centenary Co-Op - GL request.
             saKerryTypeCoOps[7] := cCentenary;

             for i := 0 to Length(saKerryTypeCoOps)-1 do
                begin
                   if ( not(ImportDefaults.Locate('CoOpName',saKerryTypeCoOps[i],[])) ) then
                      begin
                         Append;
                         FieldByName('CoOpName').AsString        := saKerryTypeCoOps[i];
                         FieldByName('UseAsDefault').AsBoolean   := ( Length(DefaultCoOpCompany) = 0 );
                         FieldByName('DefaultAccount').AsInteger := 0;
                      end
                   else
                      Edit;
                      
                   //   16/04/13 [V4.1 R4.7] /MK Change - Added changes for new Kerry File.
                   FieldByName('DefaultAccount').AsInteger   := 0;
                   FieldByName('RecTypeStart').AsInteger     := 1;
                   FieldByName('RecTypeLen').AsInteger       := 1;
                   FieldByName('DateStart').AsInteger        := 23;
                   FieldByName('DateLen').AsInteger          := 11;
                   FieldByName('AccountStart').AsInteger     := 76;
                   FieldByName('AccountLen').AsInteger       := 20;
                   FieldByName('DocketNoStart').AsInteger    := 35;
                   FieldByName('DocketNoLen').AsInteger      := 20;
                   FieldByName('DescriptionStart').AsInteger := 97;
                   FieldByName('DescriptionLen').AsInteger   := 50;
                   FieldByName('QuantityStart').AsInteger    := 165;
                   FieldByName('QuantityLen').AsInteger      := 11;
                   FieldByName('QuantityDec').AsInteger      := 3;
                   FieldByName('AmountStart').AsInteger      := 148;
                   FieldByName('AmountLen').AsInteger        := 11;
                   FieldByName('AmountDec').AsInteger        := 2;
                   FieldByName('VATRateStart').AsInteger     := 160;
                   FieldByName('VATRateLen').AsInteger       := 4;
                   FieldByName('VATRateDec').AsInteger       := 2;
                   FieldByName('VATInclusive').AsBoolean     := True;
                   FieldByName('ReferenceStart').AsInteger   := 0;
                   FieldByName('ReferenceLen').AsInteger     := 0;
                   FieldValues['HeaderString']               := 'H';
                   FieldValues['HeaderDateStart']            := 103;
                   FieldValues['HeaderDateFormat']           := 'DDMMMYYYY';
                   FieldValues['CustomerNameStart']          := 143;
                   FieldValues['CustomerNameLen']            := 50;
                   FieldValues['SkipString1']                := '';
                   FieldValues['SkipString2']                := '';
                   FieldValues['SkipString3']                := '';
                   FieldValues['DetailString']               := 'D';

                   Post;
                end;

             //   16/09/16 [V4.2 R3.7] /MK Additional Feature - Dairygold file spec is the same as Kerry - Michael Cloney (Dairygold) / GL.
             {
             if ( not(ImportDefaults.Locate('CoOpName',cDairyGold,[])) ) then
                begin
                   Append;
                   FieldByName('CoOpName').AsString          := cDairyGold;
                   FieldByName('UseAsDefault').AsBoolean     := ( Length(DefaultCoOpCompany) = 0 );
                   FieldByName('DefaultAccount').AsInteger   := 0;
                end
             else
                Edit;

             FieldByName('RecTypeStart').AsInteger     := 1;
             FieldByName('RecTypeLen').AsInteger       := 1;
             FieldByName('DateStart').AsInteger        := 48;
             FieldByName('DateLen').AsInteger          := 8;
             FieldByName('AccountStart').AsInteger     := 166;
             FieldByName('AccountLen').AsInteger       := 2;
             FieldByName('DocketNoStart').AsInteger    := 37;
             FieldByName('DocketNoLen').AsInteger      := 10;
             FieldByName('DescriptionStart').AsInteger := 57;
             FieldByName('DescriptionLen').AsInteger   := 36;
             FieldByName('QuantityStart').AsInteger    := 94;
             FieldByName('QuantityLen').AsInteger      := 11;
             FieldByName('QuantityDec').AsInteger      := 3;
             FieldByName('AmountStart').AsInteger      := 106;
             FieldByName('AmountLen').AsInteger        := 11;
             FieldByName('AmountDec').AsInteger        := 2;
             FieldByName('VATRateStart').AsInteger     := 118;
             FieldByName('VATRateLen').AsInteger       := 4;
             FieldByName('VATRateDec').AsInteger       := 2;
             FieldByName('VATInclusive').AsBoolean     := True;
             FieldByName('ReferenceStart').AsInteger   := 129;
             FieldByName('ReferenceLen').AsInteger     := 8;
             FieldValues['HeaderString']               := '1';
             FieldValues['HeaderDateStart']            := 75;
             FieldValues['HeaderDateFormat']           := 'YYYYMM';
             FieldValues['CustomerNameStart']          := 0;
             FieldValues['CustomerNameLen']            := 0;
             FieldValues['SkipString1']                := '';
             FieldValues['SkipString2']                := '';
             FieldValues['SkipString3']                := '';
             FieldValues['DetailString']               := '2';

             Post;
             }

             if ( not(ImportDefaults.Locate('CoOpName',cGlanbia,[])) ) then
                begin
                   Append;
                   FieldValues['CoOpName']               := cGlanbia;
                   FieldByName('UseAsDefault').AsBoolean := ( Length(DefaultCoOpCompany) = 0 );
                   FieldValues['DefaultAccount']         := 0;
                end
             else
                Edit;

             FieldValues['RecTypeStart']      := 1;
             FieldValues['RecTypeLen']        := 1;
             FieldValues['DateStart']         := 24;
             FieldValues['DateLen']           := 11;
             FieldValues['AccountStart']      := 78;
             FieldValues['AccountLen']        := 20;
             FieldValues['DocketNoStart']     := 36;
             FieldValues['DocketNoLen']       := 20;
             FieldValues['DescriptionStart']  := 99;
             FieldValues['DescriptionLen']    := 50;
             FieldValues['QuantityStart']     := 168;
             FieldValues['QuantityLen']       := 11;
             FieldValues['QuantityDec']       := 3;
             FieldValues['AmountStart']       := 150;
             FieldValues['AmountLen']         := 11;
             FieldValues['AmountDec']         := 2;
             FieldValues['VATRateStart']      := 163;
             FieldValues['VATRateLen']        := 4;
             FieldValues['VATRateDec']        := 2;
             FieldValues['VATInclusive']      := True;
             FieldValues['ReferenceStart']    := 0;
             FieldValues['ReferenceLen']      := 0;
             FieldValues['HeaderString']      := 'H';
             FieldValues['HeaderDateStart']   := 105;
             FieldValues['HeaderDateFormat']  := 'DDMMMYYYY';
             FieldValues['CustomerNameStart'] := 147;
             FieldValues['CustomerNameLen']   := 50;
             FieldValues['SkipString1']       := 'OPENING BALANCE';
             FieldValues['SkipString2']       := 'CLOSING BALANCE';
             FieldValues['SkipString3']       := 'CASH RECEIVED';
             FieldValues['DetailString']      := 'D';

             Post;

             Close;
          end;
    except
       ShowMessage('Cannot open the Defaults Table');
    end;
end;


procedure TAccsDataModule.CreateProformaReportTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'ProformaReportTable';
               with FieldDefs do
               begin
                  Add('ID',ftAutoInc,0,FALSE);
                  Add('AccountNo',FtInteger,0,False);
                  Add('AccountName',FtString,30,False);
                  Add('Balance',FtFloat,0,False);
                  Add('AgeCurrent',FtFloat,0,False);
                  Add('Age1',FtFloat,0,False);
                  Add('Age2',FtFloat,0,False);
                  Add('Age3',FtFloat,0,False);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;



procedure TAccsDataModule.CreateImportDefaults;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := ImportDefaults.TableName;
            with FieldDefs do
               begin
                  Add('ID',ftAutoInc,0,FALSE);
                  Add('CoOpName',ftString,20,FALSE);
                  Add('UseAsDefault',ftBoolean,0,FALSE);

                  Add('DefaultAccount',ftInteger,0,FALSE);
                  Add('RecTypeStart',ftInteger,0,FALSE);
                  Add('RecTypeLen',ftInteger,0,FALSE);
                  Add('DateStart',ftInteger,0,FALSE);
                  Add('DateLen',ftInteger,0,FALSE);
                  Add('AccountStart',ftInteger,0,FALSE);
                  Add('AccountLen',ftInteger,0,FALSE);
                  Add('DocketNoStart',ftInteger,0,FALSE);
                  Add('DocketNoLen',ftInteger,0,FALSE);
                  Add('DescriptionStart',ftInteger,0,FALSE);
                  Add('DescriptionLen',ftInteger,0,FALSE);
                  Add('QuantityStart',ftInteger,0,FALSE);
                  Add('QuantityLen',ftInteger,0,FALSE);
                  Add('QuantityDec',ftInteger,0,FALSE);
                  Add('AmountStart',ftInteger,0,FALSE);
                  Add('AmountLen',ftInteger,0,FALSE);
                  Add('AmountDec',ftInteger,0,FALSE);
                  Add('VATRateStart',ftInteger,0,FALSE);
                  Add('VATRateLen',ftInteger,0,FALSE);
                  Add('VATRateDec',ftInteger,0,FALSE);
                  Add('VATInclusive',ftBoolean,0,True);
                  Add('ReferenceStart',ftInteger,0,FALSE);
                  Add('ReferenceLen',ftInteger,0,FALSE);
                  Add('HeaderString',ftString,20,FALSE);
                  Add('HeaderDateStart',ftInteger,0,FALSE);
                  Add('HeaderDateFormat',ftString,12,FALSE);
                  Add('CustomerNameStart',ftInteger,0,FALSE);
                  Add('CustomerNameLen',ftInteger,0,FALSE);
                  Add('SkipString1',ftString,25,FALSE);
                  Add('SkipString2',ftString,25,FALSE);
                  Add('SkipString3',ftString,25,FALSE);
                  Add('DetailString',ftString,15,FALSE);

               end;
            IndexDefs.Add('','ID',[ixPrimary, ixUnique]);
            CreateTable;
            //AddCoOpRecords;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateImportDates;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := ImportDates.TableName;
            with FieldDefs do
               begin
                  Add('ID',ftAutoInc,0,FALSE);
                  Add('Importfrom',ftString,15,FALSE);
                  Add('ImportYear',ftInteger,0,FALSE);
                  Add('ImportMonth',ftInteger,0,FALSE);
               end;
            IndexDefs.Add('','ID',[ixPrimary, ixUnique]);
            IndexDefs.Add('iYearMonth','ImportYear;ImportMonth;Importfrom',[ixCaseinsensitive]);
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.GetExpenseNominalLedgerAccs;
var
   RecCounter : Integer;
begin
    try
       with NominalList do
          begin
             Close;
             TableName := 'NomListing';
             FieldDefs.Clear;
             IndexDefs.Clear;
             FieldDefs.Add('ID',ftAutoinc,0,FALSE);
             FieldDefs.Add('Account',ftInteger,0,FALSE);
             FieldDefs.Add('Name',ftString,30,FALSE);
             FieldDefs.Add('Product',ftFloat,0,FALSE);
             FieldDefs.Add('AccType',ftInteger,0,FALSE);
             CreateTable;
             Open;

             SetDB(NlFile);
             RecCounter := 1;
             while ( RecCounter <= db1.DBRECHIGH ) do
                begin
                   READREC( NlFile, RecCounter );
                   dberr;

                   if RECACTIVE(NlFile) then
                      (*
                      if RecCounter in [Cash1.XNOMINCFROM..Cash1.XNOMINCTO,
                                        Cash1.XNOMEXPFROM..Cash1.XNOMEXPTO,
                                        Cash1.XNOMNONFROM..Cash1.XNOMNONTO,
                                        Cash1.XNOMOHFROM..Cash1.XNOMOHTO] then
                      *)

                      //    10/11/11 [V4.1 R0.7] /MK Bug Fix - Program Was Not Showing Private Expenditures For More Than One Partner.
                      if ((RecCounter >= Cash1.XNOMEXPFROM) and (RecCounter <= Cash1.XNOMEXPTO))
                      or ((RecCounter >= Cash1.XNOMOHFROM) and (RecCounter <= Cash1.XNOMOHTO))
                      or ((RecCounter >= Cash1.XNOMPRVEXP) and ( RecCounter <= Cash1.XNOMPRVEXP+Cash11.xno_of_partners)) then
                      // tgm remmed out line below 22/02/02 as it didn't work. in line above, used > instead of >= for OH as 1st OH is Sales Discount and I want to exclude this.  Also XNOMOHTO is depreciation so < leaves this one out also
                      //if ((RecCounter in [Cash1.XNOMEXPFROM .. Cash1.XNOMEXPTO]) or (RecCounter in [Cash1.XNOMOHFROM .. Cash1.XNOMOHTO])) then
                         begin
                            Append;
                            FieldByName('Account').AsInteger := RecCounter;
                            GetItem ( NlFile,1);
                            FieldByName('Name').AsString := CurrStr;
                            GetItem ( NlFile,6);
                            FieldByName('Product').AsFloat := CurrLong;
                            if ( RecCounter in [Cash1.XNOMINCFROM..Cash1.XNOMINCTO] ) or
                               ( RecCounter in [Cash1.XNOMNONFROM..Cash1.XNOMNONTO] ) then
                               FieldByName('AccType').AsInteger := 2
                            else
                               FieldByName('AccType').AsInteger := 1;
                            Post;
                         end;
                   Inc(RecCounter);
                end;
          with qNominalLedger do
             begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT * FROM ' + NominalList.TableName);
                SQL.Add('ORDER BY AccType, Account');
                Open;
             end;
          end;
    except
       on e : Exception do
          begin
             ShowMessage(E.MEssage + ' Cannot Create Nominal Account Listing');
          end;
    end;
end;

procedure TAccsDataModule.GetAllNominalLedgerAccs;
var
   RecCounter : Integer;
begin
    if NOT NomListOK then
       try
          with NominalList do
             begin
                Close;
                TableName := 'NomListing';
                FieldDefs.Clear;
                IndexDefs.Clear;
                FieldDefs.Add('ID',ftAutoinc,0,FALSE);
                FieldDefs.Add('Account',ftInteger,0,FALSE);
                FieldDefs.Add('Name',ftString,30,FALSE);
                FieldDefs.Add('Product',ftFloat,0,FALSE);
                FieldDefs.Add('AccType',ftInteger,0,FALSE);
                CreateTable;
                Open;
                SetDB(NlFile);
                RecCounter := 1;
                while ( RecCounter <= db1.DBRECHIGH ) do
                   begin
                      READREC( NlFile, RecCounter );
                      dberr;
                      if RECACTIVE(NlFile) then
                         begin
                            Append;
                            FieldByName('Account').AsInteger := RecCounter;
                            GetItem ( NlFile,1);
                            FieldByName('Name').AsString := CurrStr;
                            GetItem ( NlFile,6);
                            FieldByName('Product').AsFloat := CurrLong;
                            Post;
                         end;
                      Inc(RecCounter);
                   end;
             end;
          NomListOK := TRUE;
       except
          ShowMessage('Cannot Create Nominal Account Listing');
       end;
end;

procedure TAccsDataModule.GetSalesLedgerAccs;
var
   RecCounter : Integer;
begin
    try
       with SalesLedger do
          begin
             Close;
             TableName := 'SLedger';
             FieldDefs.Clear;
             IndexDefs.Clear;
             FieldDefs.Add('ID',ftAutoinc,0,FALSE);
             FieldDefs.Add('Account',ftInteger,0,FALSE);
             FieldDefs.Add('Name',ftString,30,FALSE);
             CreateTable;
             Open;

             SetDB(SlFile);

             {
             with TQuery.Create(nil) do
                try
                   DatabaseName := SalesLedger.DatabaseName;
                   SQL.Text := 'INSERT INTO SLedger (Account, Name) SELECT SLNo, Name FROM SLFile WHERE SLFile."Active"=TRUE';
                   try
                   ExecSQL;
                   except
                      on e : exception do
                         showmessage(e.message);
                   end;

                finally
                   Free;
                end;
             }

             RecCounter := 1;
             SLFileDB.filter := 'Active = True';
             SLFileDB.filtered := True;
             SLFileDB.First;
             while ( RecCounter <= db1.DBRECHIGH ) do
                begin
      //             if SLFileDB['Active'] = true {recactive(slfile)} then begin
                        Append;
                        FieldByName('Account').AsInteger := SLFileDB['SLNo'];
                        FieldByName('Name').AsString := vartostr(SLFileDB['Name']);
                        post;
     //              end;
                   SLFileDB.next;

                   {READREC( SlFile, RecCounter );
                   dberr;

                   if RECACTIVE(SlFile) then
                      begin
                         GetItem ( SlFile,1);
                         if Length(CurrStr) > 0 then
                            begin
                               Append;
                               FieldByName('Account').AsInteger := RecCounter;
                               FieldByName('Name').AsString := CurrStr;
                               Post;
                            end;
                      end;
                      }

                   Inc(RecCounter);
                end;   // while
             SLFileDB.filtered := false;
             SLFileDB.filter := '';
          end;
    except
       ShowMessage('Cannot Create Sales Account Listing');
    end;
end;



procedure TAccsDataModule.GetPurchaseLedgerAccs;
var
   RecCounter : Integer;
begin
    try
       with PurchaseLedger do
          begin
             Close;
             TableName := 'PLedger';
             FieldDefs.Clear;
             IndexDefs.Clear;
             FieldDefs.Add('ID',ftAutoinc,0,FALSE);
             FieldDefs.Add('Account',ftInteger,0,FALSE);
             FieldDefs.Add('Name',ftString,30,FALSE);
             CreateTable;
             Open;

             SetDB(PlFile);

             {
             with TQuery.Create(nil) do
                try
                   DatabaseName := SalesLedger.DatabaseName;
                   SQL.Text := 'INSERT INTO PLedger (Account, Name) SELECT PLNo, Name FROM PLFile WHERE PLFile."Active" = True';
                   ExecSQL;
                finally
                   Free;
                end;
             }
             
             PLFileDB.filter := 'Active = True';
             PLFileDB.filtered := True;
             PLFileDB.First;
             RecCounter := 1;
             while ( RecCounter <= PLFileDB.RecordCount ) do
                begin

           //        if PLFileDB['Active'] = true {recactive(plfile)} then begin
                        Append;
                        FieldByName('Account').AsInteger := PLFileDB['PLNo'];
                        FieldByName('Name').AsString := vartostr(PLFileDB['Name']);
                        post;
        //           end;
                   PLFileDB.next;

                   {READREC( PlFile, RecCounter );
                   dberr;

                   if RECACTIVE(PlFile) then
                      begin
                         GetItem ( PlFile,1);
                         if Length(CurrStr) > 0 then
                            begin
                               Append;
                               FieldByName('Account').AsInteger := RecCounter;
                               FieldByName('Name').AsString := CurrStr;
                               Post;
                            end;
                      end;  }

                   Inc(RecCounter);
                end;


                PLFileDB.filtered := false;
                PLFileDB.filter := '';

          end;
    except
       ShowMessage('Cannot Create Purchase Account Listing');
    end;
end;

procedure TAccsDataModule.CreateTempBudgetReportDB;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := TempBudgetReportDB.TableName;
            with FieldDefs do
               begin
                  Add('NominalID',ftInteger,0,FALSE);
                  Add('NomName',ftString,30,FALSE);
                  Add('ReportGrp',ftInteger,0,FALSE);
                  Add('GrpName',ftString,30,FALSE);
                  Add('YearBudget',ftFloat,0,FALSE);
                  Add('Jan',ftFloat,0,FALSE);
                  Add('Feb',ftFloat,0,FALSE);
                  Add('Mar',ftFloat,0,FALSE);
                  Add('Apr',ftFloat,0,FALSE);
                  Add('May',ftFloat,0,FALSE);
                  Add('Jun',ftFloat,0,FALSE);
                  Add('Jul',ftFloat,0,FALSE);
                  Add('Aug',ftFloat,0,FALSE);
                  Add('Sep',ftFloat,0,FALSE);
                  Add('Oct',ftFloat,0,FALSE);
                  Add('Nov',ftFloat,0,FALSE);
                  Add('Decem',ftFloat,0,FALSE);
                  Add('AlteredBudget',ftBoolean,0,FALSE);
                  Add('YearActual',ftFloat,0,FALSE);
                  Add('JanActual',ftFloat,0,FALSE);
                  Add('FebActual',ftFloat,0,FALSE);
                  Add('MarActual',ftFloat,0,FALSE);
                  Add('AprActual',ftFloat,0,FALSE);
                  Add('MayActual',ftFloat,0,FALSE);
                  Add('JunActual',ftFloat,0,FALSE);
                  Add('JulActual',ftFloat,0,FALSE);
                  Add('AugActual',ftFloat,0,FALSE);
                  Add('SepActual',ftFloat,0,FALSE);
                  Add('OctActual',ftFloat,0,FALSE);
                  Add('NovActual',ftFloat,0,FALSE);
                  Add('DecActual',ftFloat,0,FALSE);
                  Add('LastYear',ftFloat,0,FALSE);
                  Add('LastJan',ftFloat,0,FALSE);
                  Add('LastFeb',ftFloat,0,FALSE);
                  Add('LastMar',ftFloat,0,FALSE);
                  Add('LastApr',ftFloat,0,FALSE);
                  Add('LastMay',ftFloat,0,FALSE);
                  Add('LastJun',ftFloat,0,FALSE);
                  Add('LastJul',ftFloat,0,FALSE);
                  Add('LastAug',ftFloat,0,FALSE);
                  Add('LastSep',ftFloat,0,FALSE);
                  Add('LastOct',ftFloat,0,FALSE);
                  Add('LastNov',ftFloat,0,FALSE);
                  Add('LastDec',ftFloat,0,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateThisYearTempTableDB;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := ThisYearTempTableDB.TableName;
            with FieldDefs do
               begin
                  Add('Comment',ftString,30,FALSE);
                  Add('RepGroup',ftInteger,0,FALSE);
                  Add('GroupName',ftString,30,FALSE);
                  Add('ThisYear',ftFloat,0,FALSE);
                  Add('Budget',ftFloat,0,FALSE);
                  Add('LastYear',ftFloat,0,FALSE);
                  Add('BudgetVar',ftFloat,0,FALSE);
                  Add('LastYearVar',ftFloat,0,FALSE);

               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateOverpaymentTempTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'OverpaymentTemp.db';
            with FieldDefs do
               begin
                  Add('TxNo',ftInteger,0,FALSE);
                  Add('TxDate',ftDate,0,FALSE);
                  Add('Reference',ftString,15,FALSE);
                  Add('TotalAmount',ftFloat,0,FALSE);
                  Add('OverpaymentRemaining',ftFloat,0,FALSE);
                  Add('OverpaymentAmount',ftFloat,0,FALSE);
                  Add('Tick',ftString,1,FALSE);
                  Add('CreditNoteAmount',ftFloat,0,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateBudgets;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := Budgets.TableName;
            with FieldDefs do
               begin
                  Add('NominalID',ftInteger,0,FALSE);
                  Add('NomName',ftString,30,FALSE);
                  Add('YearBudget',ftFloat,0,FALSE);
                  Add('Jan',ftFloat,0,FALSE);
                  Add('Feb',ftFloat,0,FALSE);
                  Add('Mar',ftFloat,0,FALSE);
                  Add('Apr',ftFloat,0,FALSE);
                  Add('May',ftFloat,0,FALSE);
                  Add('Jun',ftFloat,0,FALSE);
                  Add('Jul',ftFloat,0,FALSE);
                  Add('Aug',ftFloat,0,FALSE);
                  Add('Sep',ftFloat,0,FALSE);
                  Add('Oct',ftFloat,0,FALSE);
                  Add('Nov',ftFloat,0,FALSE);
                  Add('Dec',ftFloat,0,FALSE);
                  Add('AlteredBudget',ftBoolean,0,FALSE);

               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

// Set if the Account needs to have its sign changed
function TAccsDataModule.CreditAccount (Acc : Integer): Boolean;
begin
   RESULT := ( Acc in [Cash1.XNOMLIFROM..Cash1.XNOMLITO,
                       Cash1.XNOMINCFROM..Cash1.XNOMINCTO,
                       Cash1.XNOMNONFROM..Cash1.XNOMNONTO] );
end;

procedure TAccsDataModule.GetBudgets(BudgetsOrActual : TBudgetsOrActual);
var
    LastRec,
    RecCounter : Integer;
    ReverseSign : Boolean;

    // Check to see if the Amount needs to be reversed
    function SetAmount (Amount : Double): Double;
    begin
       if ReverseSign then
          RESULT := 0-Amount / 100
       else
          RESULT := Amount / 100;
    end;

begin
    with Budgets do
       try
          SettingBudgets := TRUE;
          DisableControls; // Disable the visible controls
          Close;
          EmptyTable;  // Clean the Table
          Open;

          SetDB(NlFile);
          // For Budgets stop at First Bank record -1
          if BudgetsOrActual = BudgetThisYear then
             begin
                LastRec := DB1.DBRECHIGH; // Cash1.XBANKMIN-1; Should now include Private Inc/Exp Accounts
                StartItem := 33
             end
          else if BudgetsOrActual = LastYearActual then // All Account for setting last years balances
             begin
                LastRec := DB1.DBRECHIGH;
                StartItem := 65;
             end
          else if ( BudgetsOrActual = ThisYearActual ) then
             begin

             end;

          RecCounter := 1;
          while ( RecCounter <= LastRec ) do
             begin
                READREC( NlFile, RecCounter );
                dberr;

                if RECACTIVE(NlFile) then  // active Record
                   if NOT ExcludeNominal(RecCounter) then  // NOT excluded by No Partners
                      begin
                         ReverseSign := CreditAccount(RecCounter);

                         Append;
                         FieldByName('NominalID').AsInteger := RecCounter;
                         GetItem ( NlFile,1);
                         FieldByName('NomName').AsString := CurrStr;
                         if StartItem=33 then
                            begin
                               GetItem ( NlFile,7);
                               BudgetsYearBudget.DisplayLabel := 'Yearly Budget';
                            end
                         else
                            begin
                               GetItem ( NlFile,17);
                               BudgetsYearBudget.DisplayLabel := 'Total';
                            end;
                         FieldByName('YearBudget').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem);
                         FieldByName('Jan').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+1);
                         FieldByName('Feb').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+2);
                         FieldByName('Mar').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+3);
                         FieldByName('Apr').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+4);
                         FieldByName('May').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+5);
                         FieldByName('Jun').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+6);
                         FieldByName('Jul').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+7);
                         FieldByName('Aug').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+8);
                         FieldByName('Sep').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+9);
                         FieldByName('Oct').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+10);
                         FieldByName('Nov').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+11);
                         FieldByName('Dec').AsFloat := SetAmount(CurrLong);
                         Post;
                      end;
                Inc(RecCounter);
             end;
          First;           // Shift to First Record
          EnableControls;  // Re-enable the visible controls
          SettingBudgets := FALSE;
       except
          EnableControls; // Re-enable the visible controls
          SettingBudgets := FALSE;
          ShowMessage('Cannot Create Nominal Budgets Listing');
       end;
end;

procedure TAccsDataModule.BudgetsBeforePost(DataSet: TDataSet);
var messagestring : string;
begin
    // Check all the Fields total up to the Yearly Budget for this Account
    if NOT SettingBudgets then begin
 //   if Round((BudgetsCheckBudget.AsFloat - BudgetsYearBudget.AsFloat) * 100 ) > 0 then messageString := 'Either increase the year total or decrease one of the individual months by this amount.';
 //   if Round((BudgetsCheckBudget.AsFloat - BudgetsYearBudget.AsFloat) * 100 ) < 0 then messagestring := 'Either decrease the year total or increase one of the individual months by this amount.';
 //   raise ErrorMsg.CreateFmt('Year value & monthly values do not agree for account %s.'+#10#13 +' The difference is ' + FloatToStr(Round((BudgetsCheckBudget.AsFloat - BudgetsYearBudget.AsFloat) * 100 )/100) +#10#13 + messagestring ,[DataSet.FieldByName('NominalID').AsString]);
       if Round((BudgetsCheckBudget.AsFloat - BudgetsYearBudget.AsFloat) * 100 ) <> 0 then begin
          DontAllocateAcrossYear := true;
          BudgetsYearBudget.AsFloat := BudgetsYearBudget.AsFloat + Round(BudgetsCheckBudget.AsFloat - BudgetsYearBudget.AsFloat);
       end;
    end;
end;

procedure TAccsDataModule.BudgetsCalcFields(DataSet: TDataSet);
begin
    if NOT AllocatingBudgets then
       BudgetsCheckBudget.AsFloat :=
                BudgetsJan.AsFloat + BudgetsFeb.AsFloat + BudgetsMar.AsFloat +
                BudgetsApr.AsFloat + BudgetsMay.AsFloat + BudgetsJun.AsFloat +
                BudgetsJul.AsFloat + BudgetsAug.AsFloat + BudgetsSep.AsFloat +
                BudgetsOct.AsFloat + BudgetsNov.AsFloat + BudgetsDec.AsFloat;
end;

procedure TAccsDataModule.AllocateBudgetZeros;
var
   Diff,
   YearlyBudget,
   BudgetChange, MonthlyBudget : Integer;
   ZeroMonthCount : Integer;
   LastZeroMonth : Integer;
begin
// TGM AB 11/06/02 Allocates budgets only to zero months, replaces AllocateBudget
    try
       AllocatingBudgets := TRUE;
       // Convert Budget to Integer value
       YearlyBudget := ROUND(BudgetsYearBudget.AsFloat*100);
       // Calculate the Budget divide by 12
       BudgetChange := ROUND((BudgetsYearBudget.AsFloat*100) - (BudgetsCheckBudget.AsFloat*100));
       if ((BudgetChange < 0) and (BudgetsYearBudget.AsFloat <> 0 )) then begin
                                     AllocatingBudgets := FALSE;
                                     Showmessage('To decrease the Yearly Budget, adjust the individual monthly figures');
                                     exit;

       end
           else begin
                ZeroMonthCount := 0;
                LastZeroMonth := 0;
                Diff := 0;
                if BudgetsJan.AsFloat = 0  then begin
                                                inc(ZeroMonthCount);
                                                LastZeroMonth := 1;
                                                end;
                if BudgetsFeb.AsFloat = 0  then begin
                                                inc(ZeroMonthCount);
                                                LastZeroMonth := 2;
                                                end;
                if BudgetsMar.AsFloat = 0  then begin
                                                inc(ZeroMonthCount);
                                                LastZeroMonth := 3;
                                                end;
                if BudgetsApr.AsFloat = 0  then begin
                                                inc(ZeroMonthCount);
                                                LastZeroMonth := 4;
                                                end;
                if BudgetsMay.AsFloat = 0  then begin
                                                inc(ZeroMonthCount);
                                                LastZeroMonth := 5;
                                                end;
                if BudgetsJun.AsFloat = 0  then begin
                                                inc(ZeroMonthCount);
                                                LastZeroMonth := 6;
                                                end;
                if BudgetsJul.AsFloat = 0  then begin
                                                inc(ZeroMonthCount);
                                                LastZeroMonth := 7;
                                                end;
                if BudgetsAug.AsFloat = 0  then begin
                                                inc(ZeroMonthCount);
                                                LastZeroMonth := 8;
                                                end;
                if BudgetsSep.Asfloat = 0  then begin
                                                inc(ZeroMonthCount);
                                                LastZeroMonth := 9;
                                                end;
                if BudgetsOct.AsFloat = 0  then begin
                                                inc(ZeroMonthCount);
                                                LastZeroMonth := 10;
                                                end;
                if BudgetsNov.AsFloat = 0  then begin
                                                inc(ZeroMonthCount);
                                                LastZeroMonth := 11;
                                                end;
                if BudgetsDec.AsFloat = 0  then begin
                                                inc(ZeroMonthCount);
                                                LastZeroMonth := 12;
                                                end;

                if ZeroMonthCount = 0 then begin
                                            AllocatingBudgets := FALSE;
                                            showmessage('No Zero Value Months - Reverting To Previous Totals');
                                            DontAllocateAcrossYear := true;
                                            BudgetsYearBudget.AsFloat := YearlyBudget/100;
                                            DontAllocateAcrossYear := false;
                                            exit;
                end;
                MonthlyBudget := ROUND((BudgetChange) / ZeroMonthCount);
                Diff := ((BudgetChange) - (MonthlyBudget*ZeroMonthCount));

                if Budgets.state in dsEditModes then begin

                   if BudgetsJan.AsFloat = 0  then begin
                                                   if LastZeroMonth = 1 then BudgetsJan.AsFloat := (MonthlyBudget + Diff)/100
                                                   else BudgetsJan.AsFloat := MonthlyBudget/100;
                                                   end;
                   if BudgetsFeb.AsFloat = 0  then begin
                                                   if LastZeroMonth = 2 then BudgetsFeb.AsFloat := (MonthlyBudget + Diff)/100
                                                   else BudgetsFeb.AsFloat := MonthlyBudget/100;
                                                   end;
                   if BudgetsMar.AsFloat = 0  then begin
                                                   if LastZeroMonth = 3 then BudgetsMar.AsFloat := (MonthlyBudget + Diff)/100
                                                   else BudgetsMar.AsFloat := MonthlyBudget/100;
                                                   end;
                   if BudgetsApr.AsFloat = 0  then begin
                                                   if LastZeroMonth = 4 then BudgetsApr.AsFloat := (MonthlyBudget + Diff)/100
                                                   else BudgetsApr.AsFloat := MonthlyBudget/100;
                                                   end;
                   if BudgetsMay.AsFloat = 0  then begin
                                                   if LastZeroMonth = 5 then BudgetsMay.AsFloat := (MonthlyBudget + Diff)/100
                                                   else BudgetsMay.AsFloat := MonthlyBudget/100;
                                                   end;
                   if BudgetsJun.AsFloat = 0  then begin
                                                   if LastZeroMonth = 6 then BudgetsJun.AsFloat := (MonthlyBudget + Diff)/100
                                                   else BudgetsJun.AsFloat := MonthlyBudget/100;
                                                   end;
                   if BudgetsJul.AsFloat = 0  then begin
                                                   if LastZeroMonth = 7 then BudgetsJul.AsFloat := (MonthlyBudget + Diff)/100
                                                   else BudgetsJul.AsFloat := MonthlyBudget/100;
                                                   end;
                   if BudgetsAug.AsFloat = 0  then begin
                                                   if LastZeroMonth = 8 then BudgetsAug.AsFloat := (MonthlyBudget + Diff)/100
                                                   else BudgetsAug.AsFloat := MonthlyBudget/100;
                                                   end;
                   if BudgetsSep.AsFloat = 0  then begin
                                                   if LastZeroMonth = 9 then BudgetsSep.AsFloat := (MonthlyBudget + Diff)/100
                                                   else BudgetsSep.AsFloat := MonthlyBudget/100;
                                                   end;
                   if BudgetsOct.AsFloat = 0  then begin
                                                   if LastZeroMonth = 10 then BudgetsOct.AsFloat := (MonthlyBudget + Diff)/100
                                                   else BudgetsOct.AsFloat := MonthlyBudget/100;
                                                   end;
                   if BudgetsNov.AsFloat = 0  then begin
                                                   if LastZeroMonth = 11 then BudgetsNov.AsFloat := (MonthlyBudget + Diff)/100
                                                   else BudgetsNov.AsFloat := MonthlyBudget/100;
                                                   end;
                   if BudgetsDec.AsFloat = 0  then begin
                                                   if LastZeroMonth = 12 then BudgetsDec.AsFloat := (MonthlyBudget + Diff)/100
                                                   else BudgetsDec.AsFloat := MonthlyBudget/100;
                                                   end;
                end; //if Budgets.state

          end;  // else begin
       AllocatingBudgets := FALSE;
    except
       AllocatingBudgets := FALSE;
    end;
end;

procedure TAccsDataModule.AllocateBudget;
var
   Diff,
   YearlyBudget,
   MonthlyBudget : Integer;
begin
    try
       AllocatingBudgets := TRUE;
       // Convert Budget to Integer value
       YearlyBudget := ROUND(BudgetsYearBudget.AsFloat*100);
       // Calculate the Budget divide by 12
       MonthlyBudget := ROUND((BudgetsYearBudget.AsFloat*100) / 12);
       // Get the Difference between the Budget and the Monthly Budget by 12
       Diff := ( YearlyBudget-(MonthlyBudget*12));
       if Budgets.state in dsEditModes then
          begin
             BudgetsJan.AsFloat := MonthlyBudget / 100;
             BudgetsFeb.AsFloat := MonthlyBudget / 100;
             BudgetsMar.AsFloat := MonthlyBudget / 100;
             BudgetsApr.AsFloat := MonthlyBudget / 100;
             BudgetsMay.AsFloat := MonthlyBudget / 100;
             BudgetsJun.AsFloat := MonthlyBudget / 100;
             BudgetsJul.AsFloat := MonthlyBudget / 100;
             BudgetsAug.AsFloat := MonthlyBudget / 100;
             BudgetsSep.AsFloat := MonthlyBudget / 100;
             BudgetsOct.AsFloat := MonthlyBudget / 100;
             BudgetsNov.AsFloat := MonthlyBudget / 100;
             BudgetsDec.AsFloat := (MonthlyBudget+Diff) / 100;
          end;
       // UpdateNominalAccount;
       AllocatingBudgets := FALSE;
    except
       AllocatingBudgets := FALSE;
    end;
end;

procedure TAccsDataModule.BudgetsYearBudgetValidate(Sender: TField);

begin
    // check you are not load the records
    if not DontAllocateAcrossYear then
    if ((not SettingBudgets) and (Round((BudgetsCheckBudget.AsFloat - BudgetsYearBudget.AsFloat) * 100 ) <> 0 ))then begin

       if ((FindNoZeroMonths = false) and (not allmonthszero)) then begin
       // show panel on budgets screen
          try Application.CreateForm(TFAllocateBudgets, FAllocateBudgets);
              fAllocateBudgets.ShowModal
          except FAllocateBudgets.ShowModal;
          end;
          fAllocateBudgets.BudgetRG.ItemIndex := 0;
       end
          else begin
                    if MessageDLG('Allocate this total to the months of the Year?',mtInformation,[mbNo,mbYes],0) = mrYes then AllocateBudget
                       else showmessage('Year Total reverting to original value.' + #10#13 + #10#13 + 'Year Total will automatically be recalculated when the individual month values are changed.');
          end;

    end; // if not Dont.....
    DontAllocateAcrossYear :=false;
end;

// Check to see if the Amount needs to be reversed
function TAccsDataModule.SetDOSAmount (Amount : Double; ReverseSign : Boolean): Integer;
begin
    if ReverseSign then
       RESULT := 0-Round(Amount * 100)
    else
       RESULT := Round(Amount * 100);
end;

// Update the DOS Nominal Accounts Budgets
procedure TAccsDataModule.UpdateNominalAccount;
var
    ReverseSign : Boolean;
begin
    try
       SetDB(NlFile);
       READREC( NlFile, BudgetsNominalID.AsInteger );
       dberr;

       if RECACTIVE(NlFile) then
          begin
             ReverseSign := CreditAccount(BudgetsNominalID.AsInteger);
             SetItem;
             CurrLong := SetDOSAmount(BudgetsYearBudget.AsFloat, ReverseSign);
             if StartItem = 33 then
                PutItem ( NlFile,7)
             else
                PutItem ( NlFile,17);
             SetItem;
             CurrLong := SetDOSAmount(BudgetsJan.AsFloat, ReverseSign);
             PutItem ( NlFile,StartItem);
             SetItem;
             CurrLong := SetDOSAmount(BudgetsFeb.AsFloat, ReverseSign);
             PutItem ( NlFile,StartItem+1);
             SetItem;
             CurrLong := SetDOSAmount(BudgetsMar.AsFloat, ReverseSign);
             PutItem ( NlFile,StartItem+2);
             SetItem;
             CurrLong := SetDOSAmount(BudgetsApr.AsFloat, ReverseSign);
             PutItem ( NlFile,StartItem+3);
             SetItem;
             CurrLong := SetDOSAmount(BudgetsMay.AsFloat, ReverseSign);
             PutItem ( NlFile,StartItem+4);
             SetItem;
             CurrLong := SetDOSAmount(BudgetsJun.AsFloat, ReverseSign);
             PutItem ( NlFile,StartItem+5);
             SetItem;
             CurrLong := SetDOSAmount(BudgetsJul.AsFloat, ReverseSign);
             PutItem ( NlFile,StartItem+6);
             SetItem;
             CurrLong := SetDOSAmount(BudgetsAug.AsFloat, ReverseSign);
             PutItem ( NlFile,StartItem+7);
             SetItem;
             CurrLong := SetDOSAmount(BudgetsSep.AsFloat, ReverseSign);
             PutItem ( NlFile,StartItem+8);
             SetItem;
             CurrLong := SetDOSAmount(BudgetsOct.AsFloat, ReverseSign);
             PutItem ( NlFile,StartItem+9);
             SetItem;
             CurrLong := SetDOSAmount(BudgetsNov.AsFloat, ReverseSign);
             PutItem ( NlFile,StartItem+10);
             SetItem;
             CurrLong := SetDOSAmount(BudgetsDec.AsFloat, ReverseSign);
             PutItem ( NlFile,StartItem+11);
             ReWriteRec(NlFile, BudgetsNominalID.AsInteger);
          end;
    except
        ShowMessage('Cannot Update Budget for ' + BudgetsNominalID.AsString);
    end;
end;

procedure TAccsDataModule.AccsDataModuleCreate(Sender: TObject);
var
   FileLocation : String;
begin
   // Initialise the Variables

   AllocatingBudgets := FALSE;
   SettingBudgets    := FALSE;
   NomListOK         := FALSE;

   FDefaultEntCode := '';

   // SP for TGM Contacts vs Accounts locking issues.
   // Exclude until further notice.
   {
   Session.NetFileDir := ExtractFilePath(ParamStr(0)) + 'NET';
   if not DirectoryExists(Session.NetFileDir) then
      CreateDir(Session.NetFileDir);

   Session.PrivateDir := ExtractFilePath(ParamStr(0)) + 'PRIV';
   if not DirectoryExists(Session.PrivateDir) then
      CreateDir(Session.PrivateDir);
   }

   RestartProgramAfterBackupRestore := false; // will be set to true if restored database is not the current database path. (accountants only)

   SetLength(FIncomeLineIds,4);
   FIncomeLineIds[0] := SalesInvoiceLineId;
   FIncomeLineIds[1] := SalesReceiptLineId;
   FIncomeLineIds[2] := SalesCreditNoteLineId;
   FIncomeLineIds[3] := CashBookIncomeHeaderLineId;

   SetLength(FExpenseLineIds,4);
   FExpenseLineIds[0] := PurchaseInvoiceLineId;
   FExpenseLineIds[1] := PurchasePaymentLineId;
   FExpenseLineIds[2] := PurchaseCreditNoteLineId;
   FExpenseLineIds[3] := CashBookExpenseHeaderLineId;

   AccsDataModule.AgeOfDebtSyncRequired := False;

   SyncSettingsLoadError := False;

   // SP 20/12/2017
   JobCardDownloadCount := 0;

   // SP 24/06/2021 :-%
   LoadMTDConfig();
end;

procedure TAccsDataModule.BudgetsBeforeDelete(DataSet: TDataSet);
begin
    // Call Abort to Stop Records being deleted
    SysUtils.Abort;
end;

procedure TAccsDataModule.BudgetsBeforeInsert(DataSet: TDataSet);
begin
    // Call Abort to Stop Records being added
    if NOT SettingBudgets then
       SysUtils.Abort;
end;

procedure TAccsDataModule.CreateProducts;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'Products';
            with FieldDefs do
               begin
                  Add('ID',ftAutoInc,0,FALSE);  // Use Item 6 (ST-WEEK) as Link to products
                  Add('DefaultPrice',ftFloat,0,FALSE);
                  Add('UseDefaultPrice',ftBoolean,0,FALSE);
                  Add('LineDate',ftDate,0,false);
                  Add('LineRef',ftString,20,false);
                  Add('Desc1',ftString,30,FALSE);
                  Add('Desc2',ftString,30,FALSE);
                  Add('Desc3',ftString,30,FALSE);
                  // Acre, Tonne, Hour etc.
                  Add('Unit',ftString,25,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateProductsTx;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := ProdsTx.TableName;
            with FieldDefs do
               begin
                  Add('TxNo',ftInteger,0,FALSE);   // Points to the TRansaction File Record Number
                  Add('LineNo',ftInteger,0,FALSE); // Points to the Line of the Grid
                  Add('ProductID',ftInteger,0,false);
                  Add('LineDate',ftDate,0,false);
                  Add('LineRef',ftString,20,false);
                  Add('Desc1',ftString,30,FALSE);
                  Add('Desc2',ftString,30,FALSE);
                  Add('Desc3',ftString,30,FALSE);
                  // Acre, Tonne, Hour etc.
                  Add('Unit',ftString,25,FALSE);                  
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

// clone of the Products Tx file holds the info for editing before post to
// ProdsTx.db
procedure TAccsDataModule.CreateProductsTxTemp;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := ProdsTxTemp.TableName;
            with FieldDefs do
               begin
                  Add('TxNo',ftInteger,0,FALSE);   // Points to the TRansaction File Record Number
                  Add('LineNo',ftInteger,0,FALSE); // Points to the Line of the Grid
                  Add('ProductID',ftInteger,0,false);
                  Add('LineDate',ftDate,0,false);
                  Add('LineRef',ftString,20,false);
                  Add('Desc1',ftString,30,FALSE);
                  Add('Desc2',ftString,30,FALSE);
                  Add('Desc3',ftString,30,FALSE);
                  // Acre, Tonne, Hour etc.
                  Add('Unit',ftString,25,FALSE);

               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.ProductsoldDesc1Validate(Sender: TField);
begin

     if (Sender as TField).IsNull then
        raise ErrorMsg.CreateFmt('You must enter this Description',[nil])
     else
        begin
           with GenQuery do
              begin
                 SQL.Clear;
                 SQL.Add('SELECT Desc1 FROM ' + Products.TableName);
                 SQL.Add('WHERE UPPER(Desc1) = "' + UPPERCASE((Sender as TField).AsString) + '"');
                 if NOT ( dsProducts.DataSet.FieldByName('ID').IsNull ) then
                    SQL.Add('AND ID <> ' + dsProducts.DataSet.FieldByName('ID').AsString);
                 Open;
              end;
           if GenQuery.RecordCount > 0 then
              raise ErrorMsg.CreateFmt('Description %s is already in use',[(Sender as TField).AsString]);
        end;

end;

procedure TAccsDataModule.BudgetsAfterPost(DataSet: TDataSet);
begin
   UpdateNominalAccount;  // Update the DOS data files with the Budget info.
   DbiSaveChanges(Budgets.Handle);
end;

procedure TAccsDataModule.ProductsoldAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(Products.Handle);
end;

procedure TAccsDataModule.PrintFileAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(PrintFile.Handle);
end;

procedure TAccsDataModule.PurchaseLedgerAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(PurchaseLedger.Handle);
end;

procedure TAccsDataModule.NomMatchAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(NomMatch.Handle);
end;

procedure TAccsDataModule.ImportDefaultsAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(ImportDefaults.Handle);
end;

procedure TAccsDataModule.ProdsTxAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(ProdsTx.Handle);
end;

procedure TAccsDataModule.ImportDatesAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(ImportDates.Handle);
end;

procedure TAccsDataModule.NominalListAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(NominalList.Handle);
end;

procedure TAccsDataModule.StatementAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(Statement.Handle);
end;

procedure TAccsDataModule.BudgetsBeforeEdit(DataSet: TDataSet);
begin
     origvalue:=budgetsYearBudget.asfloat;
end;

procedure TAccsDataModule.CreateGroupsExportTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'groups';
            with FieldDefs do
               begin
                  Add('GroupNo',ftInteger,0,FALSE);
                  Add('GroupDesc',ftString,30,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateNLGroupsTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'NLGroups';
            with FieldDefs do
               begin
                  Add('GroupNo',ftAutoinc,0,FALSE);
                  Add('GroupDesc',ftString,30,FALSE);
                  Add('Active',ftBoolean,0,FALSE);
               end;
            IndexDefs.Add('','GroupNo',[ixPrimary, ixUnique]);
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;


procedure TAccsDataModule.CreateAnalysisTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'Analysis';
            with FieldDefs do
               begin
                  Add('Number',ftInteger,0,FALSE);
                  Add('Description',ftString,30,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;


procedure TAccsDataModule.CreateSLPLDefaultsTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'SLPLDefaults';
            with FieldDefs do
               begin
                  Add('SLPLCode',ftInteger,0,FALSE);
                  Add('SLPLType',ftString,1,FALSE);
                  Add('Comment',ftString,30,FALSE);
                  Add('Ent',ftString,4,false);
                  Add('Nominal',ftInteger,0,false);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;


procedure TAccsDataModule.CreateNomDefaultsTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'NomDefaults';
            with FieldDefs do
               begin
                  Add('Nominal',ftInteger,0,false);
                  Add('SLPLCode',ftInteger,0,FALSE);
                  Add('SLPLType',ftString,1,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;




procedure TAccsDataModule.CreateNLaccsExportTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'nlaccs';
            with FieldDefs do
               begin
                  Add('ID',ftInteger,0,FALSE);
                  Add('Name',ftString,30,FALSE);
                  Add('Balance',ftfloat,0,FALSE);
                  Add('StPeriod',ftfloat,0,FALSE);
                  Add('StYear',ftfloat,0,FALSE);
                  Add('RepGroup',ftInteger,0,FALSE);
                  Add('StWeek',ftfloat,0,FALSE);
                  Add('BudgYear',ftfloat,0,FALSE);
                  Add('FirstBank',ftInteger,0,FALSE);
                  Add('FirstTx',ftInteger,0,FALSE);
                  Add('LastTx',ftInteger,0,FALSE);
                  Add('YearTot1',ftfloat,0,FALSE);
                  Add('YearTot2',ftfloat,0,FALSE);
                  Add('YearTot3',ftfloat,0,FALSE);
                  Add('TaxCode',ftString,1,FALSE);
                  Add('RepFlag',ftString,1,FALSE);
                  Add('BalanceSt',ftfloat,0,FALSE);
                  Add('Enterprise',ftString,4,FALSE);
                  Add('DepRate',ftfloat,0,FALSE);
                  Add('DepAmount',ftfloat,0,FALSE);
                  Add('Category',ftString,10,FALSE);
                  Add('NominalType',ftString,1,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;



procedure TAccsDataModule.CreateSLaccsExportTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'slaccs';
            with FieldDefs do
               begin
                  Add('ID',ftInteger,0,FALSE);
                  Add('Name',ftString,30,FALSE);
                  Add('Address1',ftString,30,FALSE);
                  Add('Address2',ftString,30,FALSE);
                  Add('Address3',ftString,30,FALSE);
                  Add('Address4',ftString,30,FALSE);
                  Add('BalanceBf',ftfloat,0,FALSE);
                  Add('Balance',ftfloat,0,FALSE);
                  Add('Turnover',ftfloat,0,FALSE);
                  Add('AgeCurr',ftfloat,0,FALSE);
                  Add('Age1',ftfloat,0,FALSE);
                  Add('Age2',ftfloat,0,FALSE);
                  Add('Age3',ftfloat,0,FALSE);
                  Add('NotAlloc',ftfloat,0,FALSE);
                  Add('FirstYear',ftInteger,0,FALSE);
                  Add('FirstTx',ftInteger,0,FALSE);
                  Add('LastTx',ftInteger,0,FALSE);
                  Add('BalanceSt',ftfloat,0,FALSE);
                  Add('PayDate',ftdate,0,FALSE);
                  Add('PhoneNo1',ftString,30,FALSE);
                  Add('PhoneNo2',ftString,30,FALSE);
                  Add('FaxNo',ftString,30,FALSE);
                  Add('AreaCode',ftInteger,0,FALSE);
                  Add('PostCode',ftString,20,FALSE);
                  Add('CustRef',ftString,20,FALSE);
                  Add('Contact1',ftString,20,FALSE);
                  Add('Contact2',ftString,20,FALSE);
                  Add('VatNo',ftString,20,FALSE);
                  Add('Comment1',ftString,25,FALSE);
                  Add('Comment2',ftString,25,FALSE);
                  Add('Comment3',ftString,25,FALSE);
                  Add('Address5',ftString,30,FALSE);
                  Add('Email',ftString,50,FALSE);

               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

function TAccsDataModule.LinkedToHerd : boolean;
var
   registry : TRegistry;
begin
   result := true;

   // This function can be used as a flag to only show the nominal type boxes in a system linked to the herd!
//   registry:=Tregistry.Create;
//   Registry.OpenKey('Software\Kingswood\Winherd\DataImport', True);
//   if lowercase(Registry.ReadString('DataImport')) = 'true' then result := true;
//   if fileexists('c:\kingswood herd management\winherd.exe') then result := true;
//   registry.free;
end;

procedure TAccsDataModule.GetBudgetReportFigures();
var
    LastRec,
    RecCounter : Integer;
    ReverseSign : Boolean;

    // Check to see if the Amount needs to be reversed
    function SetAmount (Amount : Double): Double;
    begin
       if ReverseSign then
          RESULT := 0-Amount / 100
       else
          RESULT := Amount / 100;
    end;

begin
    with TempBudgetReportDB do
       try
       //   SettingBudgets := TRUE;
          DisableControls; // Disable the visible controls
          Close;
          EmptyTable;  // Clean the Table
          Open;

          SetDB(NlFile);
          // For Budgets stop at First Bank record -1
          //LastRec := Cash1.XBANKMIN-1;

          // Updated by SP 23/05/2011 to include Private Income and Private Expenditure accounts (GL)
          LastRec := Cash1.xnomtax-1;



          StartItem := 33;  // first monthly record in NL file

          RecCounter := 1;
          while ( RecCounter <= LastRec ) do
             begin
                READREC( NlFile, RecCounter );
                dberr;

                if RECACTIVE(NlFile) then  // active Record
                   if NOT ExcludeNominal(RecCounter) then  // NOT excluded by No Partners
                      begin
                         ReverseSign := CreditAccount(RecCounter);

                         Append;
                         FieldByName('NominalID').AsInteger := RecCounter;
                         GetItem ( NlFile,1);
                         FieldByName('NomName').AsString := CurrStr;
                         GetItem ( NlFile,5);
                         FieldByName('ReportGrp').AsInteger := currint;

                         try  ReadTables ( NLFile, currint, CurrStr );
                              FieldByName('Grpname').AsString := currstr;
                         except
                         end;

                         GetItem ( NlFile,7);
                         FieldByName('YearBudget').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,2);
                         FieldByName('YearActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,17);
                         FieldByName('LastYear').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem);
                         FieldByName('Jan').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+1);
                         FieldByName('Feb').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+2);
                         FieldByName('Mar').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+3);
                         FieldByName('Apr').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+4);
                         FieldByName('May').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+5);
                         FieldByName('Jun').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+6);
                         FieldByName('Jul').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+7);
                         FieldByName('Aug').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+8);
                         FieldByName('Sep').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+9);
                         FieldByName('Oct').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+10);
                         FieldByName('Nov').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+11);
                         FieldByName('Decem').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,33);
                         FieldByName('JanActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,34);
                         FieldByName('FebActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,35);
                         FieldByName('MarActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,36);
                         FieldByName('AprActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,37);
                         FieldByName('MayActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,38);
                         FieldByName('JunActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,39);
                         FieldByName('JulActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,40);
                         FieldByName('AugActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,41);
                         FieldByName('SepActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,42);
                         FieldByName('OctActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,43);
                         FieldByName('NovActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,44);
                         FieldByName('DecActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,65);
                         FieldByName('LastJan').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,66);
                         FieldByName('LastFeb').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,67);
                         FieldByName('LastMar').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,68);
                         FieldByName('LastApr').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,69);
                         FieldByName('LastMay').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,70);
                         FieldByName('LastJun').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,71);
                         FieldByName('LastJul').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,72);
                         FieldByName('LastAug').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,73);
                         FieldByName('LastSep').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,74);
                         FieldByName('LastOct').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,75);
                         FieldByName('LastNov').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,76);
                         FieldByName('LastDec').AsFloat := SetAmount(CurrLong);
                         Post;
                      end;
                Inc(RecCounter);
             end;
          First;           // Shift to First Record
          EnableControls;  // Re-enable the visible controls
       except
          EnableControls; // Re-enable the visible controls
          ShowMessage('Cannot Create Nominal Budgets/Balances Listing');
       end;
end;

(*
procedure TAccsDataModule.GetBudgetReportFigures;
var
    LastRec,
    RecCounter : Integer;
    ReverseSign : Boolean;

    // Check to see if the Amount needs to be reversed
    function SetAmount (Amount : Double): Double;
    begin
       if ReverseSign then
          RESULT := 0-Amount / 100
       else
          RESULT := Amount / 100;
    end;

begin
    with TempBudgetReportDB do
       try
       //   SettingBudgets := TRUE;
          DisableControls; // Disable the visible controls
          Close;
          EmptyTable;  // Clean the Table
          Open;

          SetDB(NlFile);
          // For Budgets stop at First Bank record -1
          LastRec := Cash1.XBANKMIN-1;

          // Updated by SP 23/05/2011 to include Private Income and Private Expenditure accounts (GL)
          LastRec := Cash1.xnomtax-1;



          StartItem := 33;  // first monthly record in NL file

          RecCounter := 1;
          while ( RecCounter <= LastRec ) do
             begin
                READREC( NlFile, RecCounter );
                dberr;

                if RECACTIVE(NlFile) then  // active Record
                   if NOT ExcludeNominal(RecCounter, False) then  // NOT excluded by No Partners
                      begin
                         ReverseSign := CreditAccount(RecCounter);

                         Append;
                         FieldByName('NominalID').AsInteger := RecCounter;
                         GetItem ( NlFile,1);
                         FieldByName('NomName').AsString := CurrStr;
                         GetItem ( NlFile,5);
                         FieldByName('ReportGrp').AsInteger := currint;

                         try  ReadTables ( NLFile, currint, CurrStr );
                              FieldByName('Grpname').AsString := currstr;
                         except
                         end;

                         GetItem ( NlFile,7);
                         FieldByName('YearBudget').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,2);
                         FieldByName('YearActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,17);
                         FieldByName('LastYear').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem);
                         FieldByName('Jan').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+1);
                         FieldByName('Feb').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+2);
                         FieldByName('Mar').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+3);
                         FieldByName('Apr').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+4);
                         FieldByName('May').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+5);
                         FieldByName('Jun').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+6);
                         FieldByName('Jul').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+7);
                         FieldByName('Aug').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+8);
                         FieldByName('Sep').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+9);
                         FieldByName('Oct').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+10);
                         FieldByName('Nov').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,StartItem+11);
                         FieldByName('Decem').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,33);
                         FieldByName('JanActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,34);
                         FieldByName('FebActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,35);
                         FieldByName('MarActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,36);
                         FieldByName('AprActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,37);
                         FieldByName('MayActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,38);
                         FieldByName('JunActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,39);
                         FieldByName('JulActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,40);
                         FieldByName('AugActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,41);
                         FieldByName('SepActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,42);
                         FieldByName('OctActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,43);
                         FieldByName('NovActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,44);
                         FieldByName('DecActual').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,65);
                         FieldByName('LastJan').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,66);
                         FieldByName('LastFeb').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,67);
                         FieldByName('LastMar').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,68);
                         FieldByName('LastApr').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,69);
                         FieldByName('LastMay').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,70);
                         FieldByName('LastJun').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,71);
                         FieldByName('LastJul').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,72);
                         FieldByName('LastAug').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,73);
                         FieldByName('LastSep').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,74);
                         FieldByName('LastOct').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,75);
                         FieldByName('LastNov').AsFloat := SetAmount(CurrLong);
                         GetItem ( NlFile,76);
                         FieldByName('LastDec').AsFloat := SetAmount(CurrLong);
                         Post;
                      end;
                Inc(RecCounter);
             end;
          First;           // Shift to First Record
          EnableControls;  // Re-enable the visible controls
       except
          EnableControls; // Re-enable the visible controls
          ShowMessage('Cannot Create Nominal Budgets/Balances Listing');
       end;
end;
*)


procedure TAccsDataModule.SLPLDefaultsAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(SLPLDefaults.Handle);
end;

procedure TAccsDataModule.NomDefaultsAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(NomDefaults.Handle);
end;

procedure TAccsDataModule.ProductsAfterPost(DataSet: TDataSet);
begin
     DbiSaveChanges(Products.Handle);
end;

procedure TAccsDataModule.ProductsBeforeDelete(DataSet: TDataSet);
begin
     if NominalList.Active then
        if NominalList.Locate('Product',DataSet.FieldByName('ID').AsInteger,[] ) then
           raise ErrorMsg.CreateFmt('Cannot Delete - Product %s is in use',[DataSet.FieldByName('Desc1').AsString]);
end;

procedure TAccsDataModule.CreateTransTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'Trans';
            with FieldDefs do
               begin
                  Add('ID',ftInteger,0,FALSE);
                  Add('TxType',ftInteger,0,FALSE);
                  Add('TxDate',ftDate,0,FALSE);
                  Add('Account',ftInteger,0,FALSE);
                  Add('Reference',ftstring,8,FALSE);
                  Add('Descript',ftstring,15,false);
                  Add('Quantity',ftfloat,0,false);
                  Add('Product',ftInteger,0,FALSE);
                  Add('Nominal',ftInteger,0,FALSE);
                  Add('Amount',ftfloat,0,false);
                  Add('TaxCode',ftstring,1,false);
                  Add('TaxDisc',ftfloat,0,false);
                  Add('Analysis',ftInteger,0,false);
                  Add('NextDB',Ftinteger,0,false);
                  Add('NextCR',Ftinteger,0,false);
                  Add('NextSP',Ftinteger,0,false);
                  Add('NomAmount',Ftfloat,0,false);
                  Add('DebitAC',Ftinteger,0,false);
                  Add('CreditAC',Ftinteger,0,false);
                  Add('OrigType',Ftinteger,0,false);
                  Add('Enterprise',ftstring,4,false);
                  Add('StubNo',Ftstring,8,false);
                  Add('BankRec',ftstring,1,FALSE);
                  Add('EditStat',ftstring,1,FALSE);
                  Add('AmtPaid',Ftfloat,0,false);
                  Add('Allocated',ftstring,1,FALSE);
                  Add('DueDate',ftDate,0,FALSE);
                  Add('AllocationComplete',ftboolean,0,FALSE);
                  Add('AllocatedVATAmount',ftfloat,0,false);
                  Add('VATClaimed',Ftfloat,0,false);
                end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateAnalysisReportTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'AnalysisReportTable';
            with FieldDefs do
               begin
                  Add('ID',ftInteger,0,FALSE);
                  Add('Comment',ftstring,30,FALSE);
                  Add('TxDate',ftDate,0,FALSE);
                  Add('Account',ftInteger,0,FALSE);
                  Add('Reference',ftstring,8,FALSE);
                  Add('Descript',ftstring,15,false);
                  Add('Quantity',ftfloat,0,false);
                  Add('Product',ftInteger,0,FALSE);
                  Add('Nominal',ftInteger,0,FALSE);
                  Add('NominalName',ftString,30,FALSE);
                  Add('Amount',ftfloat,0,false);
                  Add('TaxDisc',ftfloat,0,false);
                  Add('Analysis',ftInteger,0,false);
                  Add('OrigType',Ftinteger,0,false);
                  Add('Enterprise',ftstring,0,false);
                  Add('CustSupp',ftstring,30,FALSE);
                end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateJobCardReportTable;       // TGM AB 01/05/15 begin
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'JobCardReportTable';
            with FieldDefs do
               begin
                  Add('Customer',ftInteger,0,FALSE);
                  Add('CName',ftstring,30,FALSE);
                  Add('JDate',ftDate,0,FALSE);
                  Add('Reference',ftstring,8,FALSE);
                  Add('Comment',ftstring,30,false);
                  Add('Amount',ftfloat,0,false);
                  Add('VATAmount',ftfloat,0,false);
                  Add('TotalAmount',ftfloat,0,false);
                end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;                                                        // TGM AB 01/05/15 end

procedure TAccsdatamodule.CopyAnalysisDetails;
var
   recno : integer;
begin

       Accsdatamodule.AnalysisDB.Close;
       Accsdatamodule.AnalysisDB.EmptyTable;
       Accsdatamodule.AnalysisDB.Open;
       Accsdatamodule.AnalysisDB.append;
       Accsdatamodule.AnalysisDB.FieldValues['Number'] := 0;
       Accsdatamodule.AnalysisDB.FieldValues['Description'] := 'Default Code';
       Accsdatamodule.AnalysisDB.post;
       SETDB (Analfile);
       For RECNO:= 1 TO DB1.DBRECHIGH DO
               BEGIN
                  ReadRec ( Analfile, Recno );
                  getItem ( Analfile, 2 );
                  if currstr <> '' then begin
                     Accsdatamodule.AnalysisDB.Append;
                     Accsdatamodule.AnalysisDB.FieldValues['Number'] := recno; //i;
                     Accsdatamodule.AnalysisDB.FieldValues['Description'] := currstr;
                     Accsdatamodule.AnalysisDB.post;
                  end;
           end;
       Accsdatamodule.AnalysisDB.close;
end;


procedure TAccsDataModule.InvoiceReportTableAfterPost(DataSet: TDataSet);
begin
     DbiSaveChanges(InvoiceReportTable.Handle);
end;

procedure TAccsDataModule.InvoiceNumbersAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(InvoiceNumbers.Handle);
end;

procedure TAccsDataModule.AnalysisDBAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(AnalysisDB.Handle);
end;

procedure TAccsDataModule.ProdsTxTempAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(ProdsTxTemp.Handle);
end;

procedure TAccsDataModule.ProformaDBAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(ProformaDB.Handle);
end;

procedure TAccsDataModule.InvoiceLayoutAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(InvoiceLayout.Handle);
end;

procedure TAccsDataModule.TransactionsDBAfterPost(DataSet: TDataSet);
begin
     DbiSaveChanges(TransactionsDB.Handle);
end;

procedure TAccsDataModule.TransactionsDBAfterInsert(DataSet: TDataSet);
begin
     // TGM AB adds 0's etc to the trans file fields where required, eliminates the need to reset
     // them throughout the program when writing a transaction

     TransactionsDB['Quantity'] := 0;
     TransactionsDB['Product'] := 0;
     TransactionsDB['Account'] := 0;    // Added later TGM AB
     TransactionsDB['Nominal'] := 0;
     TransactionsDB['Analysis'] := 0;
     TransactionsDB['NextDB'] := 0;
     TransactionsDB['NextCR'] := 0;
     TransactionsDB['NextSP'] := 0;
     TransactionsDB['DebitAC'] := 0;
     TransactionsDB['CreditAC'] := 0;
     TransactionsDB['OrigType'] := 0;
     TransactionsDB['Stubno'] := '00000000';
     TransactionsDB['AmtPaid'] := 0.00;
     TransactionsDB['NomAmount'] := 0.00;
     TransactionsDB['Amount'] := 0.00;
     TransactionsDB['TaxDisc'] := 0.00;
     TransactionsDB['TaxDisc'] := 0.00;
     TransactionsDB['BankRec'] := 'U';

     TransactionsDB['Quantity2'] := 0;      // TGM AB 08/02/13
     TransactionsDB['Quantity3'] := 0;      // TGM AB 08/02/13

     DbiSaveChanges(TransactionsDB.Handle);

end;

procedure TAccsdatamodule.AddNLGroups;
var
   i : integer;
begin
    Accsdatamodule.NLGroupsDB.open;
    if Accsdatamodule.NLGroupsDB.RecordCount = 0 then begin
        for i:= 1 to 999 do begin
            Accsdatamodule.NLGroupsDB.append;
            Accsdatamodule.NLGroupsDB['Active'] := False;

            // need to allocate control account codes
            if i = cash1.XNOMTAX then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'V-A-T Control';
               Accsdatamodule.NLGroupsDB['Active'] := True;
            end;
            if i = cash1.XNOMPRVINC then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Income';
               Accsdatamodule.NLGroupsDB['Active'] := True;
            end;
            if ((i = cash1.XNOMPRVINC + 1) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 1)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Income 2';
               Accsdatamodule.NLGroupsDB['Active'] := True;              // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 2) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 2)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Income 3';
               Accsdatamodule.NLGroupsDB['Active'] := True;               // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 3) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 3)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Income 4';
               Accsdatamodule.NLGroupsDB['Active'] := True;                // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 4) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 4)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Income 5';
               Accsdatamodule.NLGroupsDB['Active'] := True;               // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 5) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 5)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Income 6';
               Accsdatamodule.NLGroupsDB['Active'] := True;               // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 6) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 6)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Income 7';
               Accsdatamodule.NLGroupsDB['Active'] := True;              // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 7) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 7)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Income 8';
               Accsdatamodule.NLGroupsDB['Active'] := True;              // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 8) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 8)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Income 9';
               Accsdatamodule.NLGroupsDB['Active'] := True;             // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 9) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 9)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Income 10';
               Accsdatamodule.NLGroupsDB['Active'] := True;               // TGM AB 09/12/16
            end;
            if i = cash1.XNOMPRVEXP then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Expenditure';
               Accsdatamodule.NLGroupsDB['Active'] := True;
            end;
            if ((i = cash1.XNOMPRVEXP + 1) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 1)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Expenditure 2';
               Accsdatamodule.NLGroupsDB['Active'] := True;         // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 2) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 2)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Expenditure 3';
               Accsdatamodule.NLGroupsDB['Active'] := True;        // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 3) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 3)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Expenditure 4';
               Accsdatamodule.NLGroupsDB['Active'] := True;       // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 4) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 4)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Expenditure 5';
               Accsdatamodule.NLGroupsDB['Active'] := True;              // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 5) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 5)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Expenditure 6';
               Accsdatamodule.NLGroupsDB['Active'] := True;             // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 6) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 6)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Expenditure 7';
               Accsdatamodule.NLGroupsDB['Active'] := True;             // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 7) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 7)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Expenditure 8';
               Accsdatamodule.NLGroupsDB['Active'] := True;                 // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 8) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 8)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Expenditure 9';
               Accsdatamodule.NLGroupsDB['Active'] := True;                  // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 9) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 9)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Private Expenditure 10';
               Accsdatamodule.NLGroupsDB['Active'] := True;                  // TGM AB 09/12/16
            end;
            if i = cash1.XNOMDEBTOR then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Debtors Control';
               Accsdatamodule.NLGroupsDB['Active'] := True;
            end;
            if i = cash1.XNOMCREDIT then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Creditors Control';
               Accsdatamodule.NLGroupsDB['Active'] := True;
            end;
            if i = cash1.XNOMSLDISC then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Sales Discounts';
               Accsdatamodule.NLGroupsDB['Active'] := True;
            end;
            if i = cash1.XNOMPLDISC then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Purchase Discounts';
               Accsdatamodule.NLGroupsDB['Active'] := True;
            end;
            if i = cash1.XNOMPROFIT then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'P/L Brought Forward';
               Accsdatamodule.NLGroupsDB['Active'] := True;
            end;
            if ((i = cash1.XNOMPROFIT + 1) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 1)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'P/L Brought Forward 2';
               Accsdatamodule.NLGroupsDB['Active'] := True;         // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 2) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 2)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'P/L Brought Forward 3';
               Accsdatamodule.NLGroupsDB['Active'] := True;       // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 3) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 3)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'P/L Brought Forward 4';
               Accsdatamodule.NLGroupsDB['Active'] := True;       // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 4) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 4)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'P/L Brought Forward 5';
               Accsdatamodule.NLGroupsDB['Active'] := True;      // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 5) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 5)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'P/L Brought Forward 6';
               Accsdatamodule.NLGroupsDB['Active'] := True;        // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 6) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 6)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'P/L Brought Forward 7';
               Accsdatamodule.NLGroupsDB['Active'] := True;         // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 7) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 7)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'P/L Brought Forward 8';
               Accsdatamodule.NLGroupsDB['Active'] := True;         // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 8) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 8)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'P/L Brought Forward 9';
               Accsdatamodule.NLGroupsDB['Active'] := True;          // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 9) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 9)) then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'P/L Brought Forward 10';
               Accsdatamodule.NLGroupsDB['Active'] := True;           // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Opening Net Worth';
               Accsdatamodule.NLGroupsDB['Active'] := True;
            end;
            if i = cash1.XNOMOPEN + 1 then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Opening Net Worth 2';
               Accsdatamodule.NLGroupsDB['Active'] := True;             // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 2 then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Opening Net Worth 3';
               Accsdatamodule.NLGroupsDB['Active'] := True;              // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 3 then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Opening Net Worth 4';
               Accsdatamodule.NLGroupsDB['Active'] := True;              // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 4 then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Opening Net Worth 5';
               Accsdatamodule.NLGroupsDB['Active'] := True;           // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 5 then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Opening Net Worth 6';
               Accsdatamodule.NLGroupsDB['Active'] := True;         // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 6 then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Opening Net Worth 7';
               Accsdatamodule.NLGroupsDB['Active'] := True;          // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 7 then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Opening Net Worth 8';
               Accsdatamodule.NLGroupsDB['Active'] := True;        // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 8 then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Opening Net Worth 9';
               Accsdatamodule.NLGroupsDB['Active'] := True;             // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 9 then begin
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Opening Net Worth 10';
               Accsdatamodule.NLGroupsDB['Active'] := True;          // TGM AB 09/12/16
            end;

            if i = cash1.XNOMDEPREC then begin                                                        // TGM AB 09/12/16
               Accsdatamodule.NLGroupsDB['GroupDesc'] := 'Depreciation';                              // TGM AB 09/12/16
               Accsdatamodule.NLGroupsDB['Active'] := True;                                           // TGM AB 09/12/16
            end;                                                                                      // TGM AB 09/12/16

            Accsdatamodule.NLGroupsDB.post;
        end;
    end;
    Accsdatamodule.NLGroupsDB.close;
end;

procedure TAccsdatamodule.AddNLCodes;
var
   i : integer;
begin
    Accsdatamodule.NLFileDB.open;
    if Accsdatamodule.NLFileDB.RecordCount = 0 then begin
        for i:= 1 to 999 do begin
            Accsdatamodule.NLFileDB.append;
            Accsdatamodule.NLFileDB['Active'] := False;
            // need to allocate control account codes
            if i = cash1.XNOMTAX then begin
               Accsdatamodule.NLFileDB['Name'] := 'V-A-T Control';
               Accsdatamodule.NLFileDB['Active'] := True;
               Accsdatamodule.NLFileDB['RepGroup'] := i;
            end;
            if i = cash1.XNOMPRVINC then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Income';
               Accsdatamodule.NLFileDB['Active'] := True;
               Accsdatamodule.NLFileDB['RepGroup'] := i;
            end;
            if ((i = cash1.XNOMPRVINC + 1) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 1)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Income 2';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;       // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 2) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 2)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Income 3';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;      // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 3) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 3)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Income 4';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;       // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 4) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 4)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Income 5';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;        // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 5) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 5)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Income 6';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;          // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 6) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 6)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Income 7';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;      // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 7) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 7)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Income 8';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;       // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 8) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 8)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Income 9';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;          // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVINC + 9) and (cash1.XNOMPRVEXP > cash1.XNOMPRVINC + 9)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Income 10';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;        // TGM AB 09/12/16
            end;
            if i = cash1.XNOMPRVEXP then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Expenditure';
               Accsdatamodule.NLFileDB['Active'] := True;
               Accsdatamodule.NLFileDB['RepGroup'] := i;
            end;
            if ((i = cash1.XNOMPRVEXP + 1) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 1)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Expenditure 2';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;         // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 2) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 2)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Expenditure 3';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;        // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 3) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 3)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Expenditure 4';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;          // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 4) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 4)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Expenditure 5';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;        // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 5) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 5)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Expenditure 6';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;            // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 6) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 6)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Expenditure 7';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;             // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 7) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 7)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Expenditure 8';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;               // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 8) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 8)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Expenditure 9';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;                // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPRVEXP + 9) and (cash1.XNOMTAX > cash1.XNOMPRVEXP + 9)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'Private Expenditure 10';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;                 // TGM AB 09/12/16
            end;
            if i = cash1.XNOMDEBTOR then begin
               Accsdatamodule.NLFileDB['Name'] := 'Debtors Control';
               Accsdatamodule.NLFileDB['Active'] := True;
               Accsdatamodule.NLFileDB['RepGroup'] := i;
            end;
            if i = cash1.XNOMCREDIT then begin
               Accsdatamodule.NLFileDB['Name'] := 'Creditors Control';
               Accsdatamodule.NLFileDB['Active'] := True;
               Accsdatamodule.NLFileDB['RepGroup'] := i;
            end;
            if i = cash1.XNOMSLDISC then begin
               Accsdatamodule.NLFileDB['Name'] := 'Sales Discounts';
               Accsdatamodule.NLFileDB['Active'] := True;
               Accsdatamodule.NLFileDB['RepGroup'] := i;
            end;
            if i = cash1.XNOMPLDISC then begin
               Accsdatamodule.NLFileDB['Name'] := 'Purchase Discounts';
               Accsdatamodule.NLFileDB['Active'] := True;
               Accsdatamodule.NLFileDB['RepGroup'] := i;
            end;
            if i = cash1.XNOMPROFIT then begin
               Accsdatamodule.NLFileDB['Name'] := 'P/L Brought Forward';
               Accsdatamodule.NLFileDB['Active'] := True;
               Accsdatamodule.NLFileDB['RepGroup'] := i;
            end;
            if ((i = cash1.XNOMPROFIT + 1) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 1)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'P/L Brought Forward 2';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;      // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 2) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 2)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'P/L Brought Forward 3';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;      // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 3) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 3)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'P/L Brought Forward 4';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;       // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 4) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 4)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'P/L Brought Forward 5';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;         // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 5) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 5)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'P/L Brought Forward 6';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;         // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 6) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 6)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'P/L Brought Forward 7';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;         // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 7) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 7)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'P/L Brought Forward 8';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;        // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 8) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 8)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'P/L Brought Forward 9';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;          // TGM AB 09/12/16
            end;
            if ((i = cash1.XNOMPROFIT + 9) and (cash1.XNOMOPEN > cash1.XNOMPROFIT + 9)) then begin
               Accsdatamodule.NLFileDB['Name'] := 'P/L Brought Forward 10';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;           // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN then begin
               Accsdatamodule.NLFileDB['Name'] := 'Opening Net Worth';
               Accsdatamodule.NLFileDB['Active'] := True;
               Accsdatamodule.NLFileDB['RepGroup'] := i;
            end;
            if i = cash1.XNOMOPEN + 1 then begin
               Accsdatamodule.NLFileDB['Name'] := 'Opening Net Worth 2';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;         // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 2 then begin
               Accsdatamodule.NLFileDB['Name'] := 'Opening Net Worth 3';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;          // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 3 then begin
               Accsdatamodule.NLFileDB['Name'] := 'Opening Net Worth 4';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;          // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 4 then begin
               Accsdatamodule.NLFileDB['Name'] := 'Opening Net Worth 5';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;          // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 5 then begin
               Accsdatamodule.NLFileDB['Name'] := 'Opening Net Worth 6';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;          // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 6 then begin
               Accsdatamodule.NLFileDB['Name'] := 'Opening Net Worth 7';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;          // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 7 then begin
               Accsdatamodule.NLFileDB['Name'] := 'Opening Net Worth 8';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;         // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 8 then begin
               Accsdatamodule.NLFileDB['Name'] := 'Opening Net Worth 9';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;          // TGM AB 09/12/16
            end;
            if i = cash1.XNOMOPEN + 9 then begin
               Accsdatamodule.NLFileDB['Name'] := 'Opening Net Worth 10';
               Accsdatamodule.NLFileDB['RepGroup'] := i;
               Accsdatamodule.NLFileDB['Active'] := True;           // TGM AB 09/12/16
            end;
            if i = cash1.XNOMDEPREC then begin                                                        // TGM AB 09/12/16
               Accsdatamodule.NLFileDB['Name'] := 'Depreciation';                                     // TGM AB 09/12/16
               Accsdatamodule.NLFileDB['RepGroup'] := i;                                              // TGM AB 09/12/16
               Accsdatamodule.NLFileDB['Active'] := True;                                             // TGM AB 09/12/16
            end;                                                                                      // TGM AB 09/12/16
            Accsdatamodule.NLFileDB.post;
        end;
    end;
    Accsdatamodule.NLFileDB.close;
end;

procedure TAccsDataModule.NLGroupsDBAfterPost(DataSet: TDataSet);
begin
     DbiSaveChanges(NLGroupsDB.Handle);
end;

procedure TAccsDataModule.NLFileDBAfterPost(DataSet: TDataSet);
begin
     DbiSaveChanges(NLFileDB.Handle);
end;

procedure TAccsDataModule.PLFileDBAfterPost(DataSet: TDataSet);
begin
     DbiSaveChanges(PLFileDB.Handle);
end;

procedure TAccsDataModule.SLFileDBAfterPost(DataSet: TDataSet);
begin
     DbiSaveChanges(SLFileDB.Handle);
end;

procedure TAccsDataModule.EntsFileDBAfterInsert(DataSet: TDataSet);
begin
     EntsFileDB['Entcode'] := '';
     EntsFileDB['EntName'] := '';
     EntsFileDB['UnitDiv'] := 0;
     EntsFileDB['UnitText'] := '';
     EntsFileDB['IncFrom'] := 0;
     EntsFileDB['IncTo'] := 0;
     EntsFileDB['ExpFrom'] := 0;
     EntsFileDB['ExpTo'] := 0;
     EntsFileDB['CosFrom'] := 0;
     EntsFileDB['CosTo'] := 0;

end;

procedure TAccsDataModule.EntsFileDBAfterPost(DataSet: TDataSet);
begin
     DbiSaveChanges(EntsFileDB.Handle);
end;

procedure TAccsDataModule.SLFileDBAfterInsert(DataSet: TDataSet);
begin
     SLFileDB['BalanceBF'] := '0.00';
     SLFileDB['Balance'] := '0.00';
     SLFileDB['Turnover'] := '0.00';
     SLFileDB['AgeCurr'] := '0.00';
     SLFileDB['Age1'] := '0.00';
     SLFileDB['Age2'] := '0.00';
     SLFileDB['Age3'] := '0.00';
     SLFileDB['NotAlloc'] := '0.00';
     SLFileDB['FirstYear'] := '0';
     SLFileDB['FirstTx'] := '0';
     SLFileDB['LastTx'] := '0';
     SLFileDB['BalanceST'] := '0.00';
     SLFileDB['AreaCode'] := '0';
end;

procedure TAccsDataModule.PLFileDBAfterInsert(DataSet: TDataSet);
begin
     PLFileDB['BalanceBF'] := '0.00';
     PLFileDB['Balance'] := '0.00';
     PLFileDB['Turnover'] := '0.00';
     PLFileDB['AgeCurr'] := '0.00';
     PLFileDB['Age1'] := '0.00';
     PLFileDB['Age2'] := '0.00';
     PLFileDB['Age3'] := '0.00';
     PLFileDB['NotAlloc'] := '0.00';
     PLFileDB['FirstYear'] := '0';
     PLFileDB['FirstTx'] := '0';
     PLFileDB['LastTx'] := '0';
     PLFileDB['BalanceST'] := '0.00';
     PLFileDB['AreaCode'] := '0';
end;

procedure TAccsDataModule.GatherPreviousYears;
var
        tempint: integer;
        datadir : string;
begin
// Gather Up Previous Year Files and copy into current year folder
        tempint := Cash1.xFinYear;

// previous year (year-1);
        dec(tempint);
        if not fileexists('c:\kingsacc\' + RFarmGate.pLocation[2] + '\year-1.db') then begin
           DataDir := Copy ( RFarmGate.pLocation[2],1,3) + IntToStr(Tempint);
           if fileexists('c:\kingsacc\' + datadir + '\transactions.db') then begin
                copyfile(pchar('c:\kingsacc\' + datadir + '\transactions.db'),pchar('c:\kingsacc\' + vartostr(RFarmGate.pLocation[2]) + '\year-1.db'),true);
                copyfile(pchar('c:\kingsacc\' + datadir + '\transactions.px'),pchar('c:\kingsacc\' + vartostr(RFarmGate.pLocation[2]) + '\year-1.px'),true);
           end;
        end;
        if not fileexists('c:\kingsacc\' + RFarmGate.pLocation[2] + '\nlfile-1.db') then begin
           DataDir := Copy ( RFarmGate.pLocation[2],1,3) + IntToStr(Tempint);
           if fileexists('c:\kingsacc\' + datadir + '\nlfile.db') then begin
                copyfile(pchar('c:\kingsacc\' + datadir + '\nlfile.db'),pchar('c:\kingsacc\' + vartostr(RFarmGate.pLocation[2]) + '\nlfile-1.db'),true);
                copyfile(pchar('c:\kingsacc\' + datadir + '\nlfile.px'),pchar('c:\kingsacc\' + vartostr(RFarmGate.pLocation[2]) + '\nlfile-1.px'),true);
           end;
        end;

        // TGM AB 18/10/16 - Bring forward SLFile & PLFile for Ledger / Statement Reporting

        if not fileexists('c:\kingsacc\' + RFarmGate.pLocation[2] + '\slfile-1.db') then begin
           DataDir := Copy ( RFarmGate.pLocation[2],1,3) + IntToStr(Tempint);
           if fileexists('c:\kingsacc\' + datadir + '\slfile.db') then begin
                copyfile(pchar('c:\kingsacc\' + datadir + '\slfile.db'),pchar('c:\kingsacc\' + vartostr(RFarmGate.pLocation[2]) + '\slfile-1.db'),true);
                copyfile(pchar('c:\kingsacc\' + datadir + '\slfile.px'),pchar('c:\kingsacc\' + vartostr(RFarmGate.pLocation[2]) + '\slfile-1.px'),true);
           end;
        end;

        if not fileexists('c:\kingsacc\' + RFarmGate.pLocation[2] + '\plfile-1.db') then begin
           DataDir := Copy ( RFarmGate.pLocation[2],1,3) + IntToStr(Tempint);
           if fileexists('c:\kingsacc\' + datadir + '\plfile.db') then begin
                copyfile(pchar('c:\kingsacc\' + datadir + '\plfile.db'),pchar('c:\kingsacc\' + vartostr(RFarmGate.pLocation[2]) + '\plfile-1.db'),true);
                copyfile(pchar('c:\kingsacc\' + datadir + '\plfile.px'),pchar('c:\kingsacc\' + vartostr(RFarmGate.pLocation[2]) + '\plfile-1.px'),true);
           end;
        end;

        // end TGM AB 18/10/16

        // TGM AB 21/10/16 - Bring forward ProductsTx for Ledger / Statement Reporting

                if not fileexists('c:\kingsacc\' + RFarmGate.pLocation[2] + '\ProductsTx-1.db') then begin
           DataDir := Copy ( RFarmGate.pLocation[2],1,3) + IntToStr(Tempint);
           if fileexists('c:\kingsacc\' + datadir + '\ProductsTx.db') then begin
                copyfile(pchar('c:\kingsacc\' + datadir + '\ProductsTx.db'),pchar('c:\kingsacc\' + vartostr(RFarmGate.pLocation[2]) + '\ProductsTx-1.db'),true);
           end;
        end;

        // end TGM AB 21/10/16

// 2 years ago (year-2);
        dec(tempint);
        if not fileexists('c:\kingsacc\' + RFarmGate.pLocation[2] + '\year-2.db') then begin
           DataDir := Copy ( RFarmGate.pLocation[2],1,3) + IntToStr(Tempint);
           if fileexists('c:\kingsacc\' + datadir + '\transactions.db') then begin
                copyfile(pchar('c:\kingsacc\' + datadir + '\transactions.db'),pchar('c:\kingsacc\' + vartostr(RFarmGate.pLocation[2]) + '\year-2.db'),true);
                copyfile(pchar('c:\kingsacc\' + datadir + '\transactions.px'),pchar('c:\kingsacc\' + vartostr(RFarmGate.pLocation[2]) + '\year-2.px'),true);
           end;
        end;

        // Ch006(P) - Bring forward AllocatedVAT for MTD
        tempint := Cash1.xFinYear;
        dec(tempint);   // move to last year
        if not fileexists('c:\kingsacc\' + RFarmGate.pLocation[2] + '\AllocatedVAT-1.db') then begin
           DataDir := Copy ( RFarmGate.pLocation[2],1,3) + IntToStr(Tempint);
           if fileexists('c:\kingsacc\' + datadir + '\AllocatedVAT.db') then begin
                copyfile(pchar('c:\kingsacc\' + datadir + '\AllocatedVAT.db'),pchar('c:\kingsacc\' + vartostr(RFarmGate.pLocation[2]) + '\AllocatedVAT-1.db'),true);
           end;
        end;
        // end Ch006(P)

end;

procedure TAccsDataModule.NLFileDBAfterInsert(DataSet: TDataSet);
begin
                  NLFileDB['Balance'] := '0.00';
                  NLFileDB['STPeriod'] := '0.00';
                  NLFileDB['STYear'] := '0.00';
                  NLFileDB['RepGroup'] := '0';
                  NLFileDB['STWeek'] := '0.00';
                  NLFileDB['BudgYear'] := '0.00';
                  NLFileDB['FirstBank'] := 0;
                  NLFileDB['FirstTX'] := 0;
                  NLFileDB['LastTx'] := 0;
                  NLFileDB['YearTot1'] := '0.00';
                  NLFileDB['YearTot2'] := '0.00';
                  NLFileDB['YearTot3'] := '0.00';
            //      Add('TaxCode',FtString,1,False);
            //      Add('RepFlag',FtString,1,False);
                  NLFileDB['BalanceST'] := '0.00';
            //      Add('Enterprise',FtString,4,False);
                  NLFileDB['BudPer01'] := '0.00';
                  NLFileDB['BudPer02'] := '0.00';
                  NLFileDB['BudPer03'] := '0.00';
                  NLFileDB['BudPer04'] := '0.00';
                  NLFileDB['BudPer05'] := '0.00';
                  NLFileDB['BudPer06'] := '0.00';
                  NLFileDB['BudPer07'] := '0.00';
                  NLFileDB['BudPer08'] := '0.00';
                  NLFileDB['BudPer09'] := '0.00';
                  NLFileDB['BudPer10'] := '0.00';
                  NLFileDB['BudPer11'] := '0.00';
                  NLFileDB['BudPer12'] := '0.00';
                  NLFileDB['BudPer13'] := '0.00';

                  NLFileDB['ActPer01'] := '0.00';
                  NLFileDB['ActPer02'] := '0.00';
                  NLFileDB['ActPer03'] := '0.00';
                  NLFileDB['ActPer04'] := '0.00';
                  NLFileDB['ActPer05'] := '0.00';
                  NLFileDB['ActPer06'] := '0.00';
                  NLFileDB['ActPer07'] := '0.00';
                  NLFileDB['ActPer08'] := '0.00';
                  NLFileDB['ActPer09'] := '0.00';
                  NLFileDB['ActPer10'] := '0.00';
                  NLFileDB['ActPer11'] := '0.00';
                  NLFileDB['ActPer12'] := '0.00';
                  NLFileDB['ActPer13'] := '0.00';

                  NLFileDB['LstPer01'] := '0.00';
                  NLFileDB['LstPer02'] := '0.00';
                  NLFileDB['LstPer03'] := '0.00';
                  NLFileDB['LstPer04'] := '0.00';
                  NLFileDB['LstPer05'] := '0.00';
                  NLFileDB['LstPer06'] := '0.00';
                  NLFileDB['LstPer07'] := '0.00';
                  NLFileDB['LstPer08'] := '0.00';
                  NLFileDB['LstPer09'] := '0.00';
                  NLFileDB['LstPer10'] := '0.00';
                  NLFileDB['LstPer11'] := '0.00';
                  NLFileDB['LstPer12'] := '0.00';
                  NLFileDB['LstPer13'] := '0.00';
end;

procedure TAccsDataModule.CreateInvoiceAllocationTempTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'AllocationTemp';
               with FieldDefs do
               begin
                  Add('TxID',ftInteger,0,FALSE);
                  Add('InvDate',FtDate,0,False);
                  Add('InvRef',FtString,15,False);
                  Add('InvComment',FtString,30,False);
                  Add('InvTotal',FtFloat,0,False);
                  Add('Outstanding',FtFloat,0,False);
                  Add('AmountPaid',FtFloat,0,False);
                  Add('Discount',FtFloat,0,False);
                  Add('CompleteAllocation',FtString,0,False);
                  Add('PreviousYear',FtString,1,False);

               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;


procedure TAccsDataModule.CreateAllocatedVATTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'AllocatedVAT';
            with FieldDefs do
               begin
                  Add('PaymentID',ftInteger,0,FALSE);
                  Add('InvoiceID',ftInteger,0,FALSE);
                  Add('Amount',ftfloat,0,false);
                  Add('VAT',ftfloat,0,false);
                  Add('TotalAmount',ftfloat,0,false);
                  Add('PreviousYear',ftBoolean,0,false);
                  Add('AllocatedDate',ftDate,0,false);
                  Add('CreditNote',ftBoolean,0,false);
                  Add('VATProcessed',ftBoolean,0,false);           // Ch006(P)
                  Add('ReturnID',ftInteger,0,FALSE);               // Ch006(P)
                end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreatePreferenceDefaults(const AStoreName : string);
var
   reg : TRegistry;
   IsCashBook : Boolean;
begin
   if not DirectoryExists(ApplicationPath + AStoreName) then Exit;

   IsCashBook := (AccsSystem.SystemType = stCashbook);

   if Preferences = nil then
      Preferences := TPreferences.Create(UPPERCASE(AStoreName));

   if not Preferences.PreferenceExists(cPref_EnableTransGridColumnGrouping) then
      Preferences.ValueAsBoolean[cPref_EnableTransGridColumnGrouping] := True;

   if not Preferences.PreferenceExists(cPref_EnableSLPLDefaults) then
      begin
         Reg := Tregistry.Create; // write old keys to new keys
         try
            if Reg.OpenKey('Software\Kingswood\Kingsacc\SLPLDefaults', True) then
               begin
                  Preferences.ValueAsBoolean[cPref_EnableSLPLDefaults] := (Reg.ReadString('SLPLDefaults') = 'True') ;
               end
            else
               Preferences.ValueAsBoolean[cPref_EnableSLPLDefaults] := False;
         finally
            FreeAndNil(Reg);
         end;
      end;

   if not Preferences.PreferenceExists(cPref_EnableInvoiceAllocation) then
      begin
         Reg := Tregistry.Create; // write old keys to new keys
         try
            if Reg.OpenKey('Software\Kingswood\Kingsacc\InvoiceAllocation', True) then
               begin
                  Preferences.ValueAsBoolean[cPref_EnableInvoiceAllocation] := (Reg.ReadString('InvoiceAllocation') = 'True') ;
               end
            else
               Preferences.ValueAsBoolean[cPref_EnableInvoiceAllocation] := False;
         finally
            FreeAndNil(Reg);
         end;
      end;

   if not Preferences.PreferenceExists(cPref_EnableCoOpImport) then
      begin
         Reg := Tregistry.Create; // write old keys to new keys
         try
            if Reg.OpenKey('Software\Kingswood\Kingsacc\UseImport', True) then
               begin
                  Preferences.ValueAsBoolean[cPref_EnableCoOpImport] := (Reg.ReadString('UseImport') = 'True') ;
               end
            else
               Preferences.ValueAsBoolean[cPref_EnableCoOpImport] := False;
         finally
            FreeAndNil(Reg);
         end;
      end;

   if not Preferences.PreferenceExists(cPref_ShowStubNoColumn) then
      Preferences.ValueAsBoolean[cPref_ShowStubNoColumn] := True;

   if not Preferences.PreferenceExists(cPref_ShowCustomerColumn) then
      Preferences.ValueAsBoolean[cPref_ShowCustomerColumn] := True;

   if not Preferences.PreferenceExists(cPref_ShowSupplierColumn) then
      Preferences.ValueAsBoolean[cPref_ShowSupplierColumn] := True;

   if not Preferences.PreferenceExists(cPref_ShowQuantityColumn) then
      Preferences.ValueAsBoolean[cPref_ShowQuantityColumn] := True;

   if not Preferences.PreferenceExists(cPref_ShowCommentColumn) then
      // 07/04/2014 - Updated to hide the Comment column by default - Requested by GL.
      Preferences.ValueAsBoolean[cPref_ShowCommentColumn] := False;

   if not Preferences.PreferenceExists(cPref_ShowAnalysisCodeColumn) then
      Preferences.ValueAsBoolean[cPref_ShowAnalysisCodeColumn] := False;

   if not Preferences.PreferenceExists(cPref_ShowKeyReportsMenu) then
      begin
         Preferences.ValueAsBoolean[cPref_ShowKeyReportsMenu] := IsCashBook;
      end;

   if not Preferences.PreferenceExists(cPref_AllowNominalLedgerAccess) then
      begin
         // SP 22/11/2012 at request of GL access to the Nominal Ledger
         // should be preference dependant. if the system is a cashbook
         // version default value to false barring access (cPref_AllowNominalLedgerAccess = false)
         // The preference can be toggled by going into Main>System>Preferences
         Preferences.ValueAsBoolean[cPref_AllowNominalLedgerAccess] := not IsCashBook;
      end;

   if not Preferences.PreferenceExists(cPref_AutoEntSelect) then
      begin
         // SP 18/06/2013 at request of GL/MK.
         // During Simple transaction entry, allow the user to select a Nominal Account
         // then the program should auto pre-fill the associated Ent Code for that
         // Nominal Account into the transaction grid.
         Preferences.ValueAsBoolean[cPref_AutoEntSelect] := IsCashBook;
      end;

   if ( not(Preferences.PreferenceExists(cPref_AllowFreeTextForNominalDescriptionColumn)) ) then
      Preferences.ValueAsBoolean[cPref_AllowFreeTextForNominalDescriptionColumn] := False;

   if ( not(Preferences.PreferenceExists(cPref_JobCard_SyncOnOpen)) ) then
      Preferences.ValueAsBoolean[cPref_JobCard_SyncOnOpen] := True;

   if ( not(Preferences.PreferenceExists(cPref_AgeOfDebt_AgedBy_Month)) ) then
      Preferences.ValueAsInteger[cPref_AgeOfDebt_AgedBy_Month] := 1;  // By one month

   if ( not(Preferences.PreferenceExists(cPref_ShowKingswoodAccsAppInfo)) ) then
      Preferences.ValueAsBoolean[cPref_ShowKingswoodAccsAppInfo] := ( (not(TfmFarmSyncSettings.SyncConfigured(CurrentDatabase))) and
                                                                      (AccsSystem.SystemType = stCashbook) );

   //   15/11/18 [V4.3 R2.7] /MK Additional Feature - New preferences to show new features screen for Bank Link, Co Op Link and Accountants Link.
   if ( not(Preferences.PreferenceExists(cPref_ShowBankLinkFeatures)) ) then
      Preferences.ValueAsBoolean[cPref_ShowBankLinkFeatures] := True;
   if ( not(Preferences.PreferenceExists(cPref_ShowCoOpLinkFeatures)) ) then
      Preferences.ValueAsBoolean[cPref_ShowCoOpLinkFeatures] := True;
   if ( not(Preferences.PreferenceExists(cPref_ShowAccountantLinkFeatures)) ) then
      Preferences.ValueAsBoolean[cPref_ShowAccountantLinkFeatures] := True;

   if ( not(Preferences.PreferenceExists(cPref_JobCard_SyncOnOpen)) ) then
      Preferences.ValueAsBoolean[cPref_JobCard_SyncOnOpen] := True;
   if ( not(Preferences.PreferenceExists(cPref_OutputAgeOfDebtOnSync)) ) then
      Preferences.ValueAsBoolean[cPref_OutputAgeOfDebtOnSync] := True;
   if ( not(Preferences.PreferenceExists(cPref_OutputExtendedStatementOnSync)) ) then
      Preferences.ValueAsBoolean[cPref_OutputExtendedStatementOnSync] := True;
   if ( not(Preferences.PreferenceExists(cPref_DownloadJobCardOncePerSession)) ) then
      Preferences.ValueAsBoolean[cPref_DownloadJobCardOncePerSession] := False;
   if ( not(Preferences.PreferenceExists(cPref_OutputJobCardRptOnSync)) ) then
      Preferences.ValueAsBoolean[cPref_OutputJobCardRptOnSync] := False;
   if ( not(Preferences.PreferenceExists(cPref_ProformaRptOnSync)) ) then
      Preferences.ValueAsBoolean[cPref_ProformaRptOnSync] := False;

   if ( not(Preferences.PreferenceExists(cPref_ShowSalePurchGridMainGrid)) ) then
      Preferences.ValueAsBoolean[cPref_ShowSalePurchGridMainGrid] := False;

   //   26/11/20 [V4.5 R4.6] /MK Change - Default new ShowBankLinkFileNotFound pref to True so TfmBankLinkNoFileFound appears before user can press "Don't show this again".
   if ( not(Preferences.PreferenceExists(cPref_ShowBankLinkFileNotFound)) ) then
      Preferences.ValueAsBoolean[cPref_ShowBankLinkFileNotFound] := True;
end;

function TAccsDataModule.GetBankBalance(const ABankName: string): Double;
{Var
   ArrPos,
   NomRec : Integer;
   AccountRanges  : TAccRange;
begin
   Result := 0;
   AccountRanges[1] := Cash1.xBankMin;
   AccountRanges[2] := Cash1.xBankMax;
   ArrPos := 1;
   NomRec := AccountRanges[1];
   SetDb ( NlFile );
   Repeat
         ReadRec ( NlFile, NomRec );
         dberr;
         If Recactive ( NlFile ) And ( NOT ExcludeNominal ( NomRec )) Then
            Begin
                 GetItem ( NlFile, 1 );
                 if CurrStr = ABankName then
                    begin
                       GetItem ( NlFile, 2 );
                       LongStr ( CurrLong, CurrStr, 'L' );

                       Result := StrToFloat(CurrStr);
                       Break;
                    end;
                 Inc ( ArrPos );
            End;
         Inc ( NomRec );
   until ( NomRec > AccountRanges[2] ) Or ( NomRec = 0 );
   Dec ( ArrPos );}

begin
   Result := 0;
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT Balance FROM NLFile WHERE Name=:Name');
         Params[0].AsString := ABankName;
         Open;
         try
            First;
            Result := Fields[0].AsFloat;
         finally
            Close;
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.AddAccsDefaults;
begin
    try
       with AccsDefaults do
          begin
             Open;
             if not accsDataModule.AccsDefaults.Locate('Defaults','1',[]) then begin
                Append;
                FieldByName('Defaults').AsInteger := 1;
                FieldByName('InvSum_NumberBlankLines').AsInteger   := 15;
                Post;
             end;

             // SP 21/06/2016
             // NomProdRelationship Possible values include 'One To One' and 'One to Many'.
             // Default to One to One as this was the first type of relationship created in the program.
             if (FieldByName('NomProdRelationship').IsNull) then
                begin
                   Edit;
                   FieldByName('NomProdRelationship').AsString   := cNomProdRelationship_OnetoMany;
                   Post;
                end;
          end;
    except
       ShowMessage('Cannot open the Defaults Table');
    end;
end;

procedure TAccsDataModule.CreateAccsDefaultsTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'AccsDefaults';
            with FieldDefs do
               begin
                  Add('Defaults',ftInteger,0,FALSE);
                  Add('InvSum_UsePrePrinted',ftBoolean,0,FALSE);
                  Add('InvSum_NumberBlankLines',ftInteger,0,FALSE);
                  Add('InvSum_DoubleSpacing',ftBoolean,0,FALSE);
                  Add('NomProdRelationship',ftString,15);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

function TAccsDataModule.GetNominalRecord(const ANLNo: Integer): TQuery;
begin
   Result := TQuery.Create(nil);
   with Result do
      try
         DatabaseName := 'WinAccsData';
         SQL.Clear;
         SQL.Add('SELECT * FROM NLFile ');
         SQL.Add('WHERE (NLNo =:NLNo)');
         Params[0].AsInteger := ANLNo;
         Open;
      finally
      end;
end;

function TAccsDataModule.UpdateNominalRecord(const ANLNo: Integer;
  const ABalance, ASTPeriod, ASTYear, ABalanceST : Double): Boolean;
begin
   Result := False;
   with TQuery.Create(nil) do
      try
         DatabaseName := 'WinAccsData';
         SQL.Clear;
         SQL.Add('UPDATE NLFile ');
         SQL.Add('SET Balance=:Balance, STPeriod=:STPeriod, STYear=:STYear, BalanceST=:ABalanceST ');
         SQL.Add('WHERE (NLNo =:NLNo)');
         Params[0].AsFloat := ABalance;
         Params[1].AsFloat := ASTPeriod;
         Params[2].AsFloat := ASTYear;
         Params[3].AsFloat := ABalanceST;
         Params[4].AsInteger := ANLNo;
         ExecSQL;
         Result := True;
      finally
         Free;
      end;
end;

function TAccsDataModule.GetTransactionCount: Integer;
begin
   Result := 0 ;
   with TQuery.Create(nil) do
      try
         DatabaseName := 'WinAccsData';
         SQL.Clear;
         SQL.Add('SELECT COUNT(TxNo) FROM Transactions');
         Open;
         try
            First;
            Result := Fields[0].AsInteger;
         finally
            Close;
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.DisposeTransPointers;
var
   PCount : Integer;
begin
   // clear & reset pointers
   for PCount := 1 to MaxTx do
      begin
         if TxHold[PCount] <> nil then
            begin
               Dispose ( TxHold[PCount] );
               TxHold[PCount] := nil;
            end;
      end;

   for PCount := 1 to MaxNom do
      begin
         if NomHold[PCount] <> nil then
            begin
               Dispose ( NomHold[PCount] );
               NomHold[PCount] := nil;
            end;
      end;

end;

procedure TAccsDataModule.InitialiseTransPointers;
var
   PCount : Integer;
begin
   // initialise the pointers etc required for writing a transaction
   for PCount := 1 to MaxTx do
      begin
         New ( TxHold[PCount] );
         FillChar( TxHold[PCount]^, SizeOf(TxHold[PCount]^),chr(0));
      end;

   for PCount := 1 to MaxNom do
      begin
         New ( NomHold[PCount] );
         FillChar ( NomHold[PCount]^, SizeOf(NomHold[PCount]^),chr(0));
      end;

end;

procedure TAccsDataModule.CreateEnterpriseAnalysisReportTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'EnterpriseAnalysisReportTable';
            with FieldDefs do
               begin
                  Add('ID',ftAutoinc,0,FALSE);
                  Add('Code',ftString,5,FALSE);
                  Add('Description',ftString,30,FALSE);
                  Add('Month_ThisYear',ftFloat,0,FALSE);
                  Add('Month_LastYear',ftFloat,0,FALSE);
                  Add('Month_Budget',ftFloat,0,FALSE);
                  Add('YTD_ThisYear',ftFloat,0,FALSE);
                  Add('YTD_LastYear',ftFloat,0,FALSE);
                  Add('YTD_Budget',ftFloat,0,FALSE);
                  Add('Annual_Budget',ftFloat,0,FALSE);
                  Add('LineLabel',ftString,255,FALSE);
                  Add('BoldLineLabel',ftString,255,FALSE);
               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

function TAccsDataModule.MaxTransactionDate: TDateTime;
begin
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT MAX(TxDate) FROM Transactions');
         Open;
         try
            First;
            Result := Fields[0].AsDateTime;
         finally
            Close;
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.CustSuppListingDBAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(CustSuppListingDB.Handle);
end;

function TAccsDataModule.FieldExists(FieldName : String) : Boolean;
begin
   Result := False;
   try
      try
         UpdateTable.Active := True;
         Result := UpdateTable.FieldDefs.IndexOf(FieldName) > -1; // Make sure the field doesn't exist
      except
         on e : Exception do
            ShowMessage(e.message);
      end;
   finally
      UpdateTable.Active := False;
   end;
end;

procedure TAccsDataModule.CreateBankTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'BankTable';
            with FieldDefs do
               begin
                  Add('BankCode',ftInteger,0,FALSE);
                  Add('Balance',ftfloat,0,false);
                end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateBankCSVDefaultsTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'BankCSVDefaults';
            try
               with FieldDefs do
                  begin
                     Add('ID',ftAutoInc,0,FALSE);
                     Add('BankName',ftString,30,false);
                     Add('Delimiter',ftString,10,false);
                     Add('HeaderLines',ftString,10,false);
                     Add('DateFieldNo',ftInteger,0,false);
                     Add('DetailFieldNo',ftInteger,0,false);
                     Add('ExtraDetailField1No',ftInteger,0,false);
                     Add('ExtraDetailField2No',ftInteger,0,false);
                     Add('DebitFieldNo',ftInteger,0,false);
                     Add('CreditFieldNo',ftInteger,0,false);
                     Add('BalanceFieldNo',ftInteger,0,false);
                     Add('ChequeIdentifier',ftString,20,false);
                     Add('LodgementIdentifier',ftString,20,false);
                     Add('Fieldcount',ftInteger,0,false);
                   end;
               CreateTable;
            finally
               Close;
            end;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.AddBankLinkDefaults;
var
   MyTable : TTable;
begin
   MyTable := TTable.Create(nil);
   MyTable.DatabaseName := AccsDataBase.DatabaseName;
   with MyTable do
      try
         TableName := 'BankCSVDefaults';
         Open;

         // Add default for BOI
         if ( not(Locate('BankName','Bank Of Ireland',[])) ) then
            try
               Append;
               FieldByName('BankName').AsString := 'Bank Of Ireland';
               FieldByName('Delimiter').AsString := ',';

               FieldByName('HeaderLines').AsString := '1';
               FieldByName('DateFieldNo').AsInteger := 1;
               FieldByName('DetailFieldNo').AsInteger := 2;
               FieldByName('DebitFieldNo').AsInteger := 3;
               FieldByName('CreditFieldNo').AsInteger := 4;
               FieldByName('BalanceFieldNo').AsInteger := 5;
               FieldByName('ChequeIdentifier').AsString := 'CHQ';
               FieldByName('LodgementIdentifier').AsString := 'LDG';
               Post;
            except
               Cancel
            end;

         // Add default for Ulster Bank
         if ( not(Locate('BankName','Ulster Bank',[])) ) then
            try
               Append;
               FieldByName('BankName').AsString := 'Ulster Bank';
               FieldByName('Delimiter').AsString := ',';

               FieldByName('HeaderLines').AsString := '1';
               FieldByName('DateFieldNo').AsInteger := 10;
               FieldByName('DetailFieldNo').AsInteger := 11;
               FieldByName('DebitFieldNo').AsInteger := 17;
               FieldByName('CreditFieldNo').AsInteger := 18;
               // No Balance field for ROI Ulster Bank files.
               FieldByName('BalanceFieldNo').Clear;
               FieldByName('ChequeIdentifier').AsString := 'CHQ';
               FieldByName('LodgementIdentifier').AsString := 'LDG';
               Post;
            except
               Cancel;
            end;

         // Add default for Acc Bank
         if ( not(Locate('BankName','ACC Bank',[])) ) then
            try
               Append;
               FieldByName('BankName').AsString := 'ACC Bank';
               FieldByName('Delimiter').AsString := ',';

               FieldByName('HeaderLines').AsString := '11';
               FieldByName('DateFieldNo').AsInteger := 1;
               FieldByName('DetailFieldNo').AsInteger := 3;
               FieldByName('DebitFieldNo').AsInteger := 4;
               FieldByName('CreditFieldNo').AsInteger := 5;
               FieldByName('BalanceFieldNo').AsInteger := 6;
               FieldByName('ChequeIdentifier').AsString := 'CHEQUE';
               FieldByName('LodgementIdentifier').AsString := 'LDG';
               Post;
            except
               Cancel;
            end;

         // Add default for AIB Personal
         if ( not(Locate('BankName','AIB Personal',[])) ) then
            try
               Append;
               FieldByName('BankName').AsString := 'AIB Personal';
               FieldByName('Delimiter').AsString := ',';

               FieldByName('HeaderLines').AsString := '1';
               FieldByName('DateFieldNo').AsInteger := 2;
               FieldByName('DetailFieldNo').AsInteger := 3;
               FieldByName('DebitFieldNo').AsInteger := 4;
               FieldByName('CreditFieldNo').AsInteger := 5;
               FieldByName('BalanceFieldNo').AsInteger := 6;
               FieldByName('ChequeIdentifier').AsString := 'CHEQUE';
               FieldByName('LodgementIdentifier').AsString := 'LDG';
               Post;
            except
               Cancel;
            end;

         // Add default for AIB Business
         if ( not(Locate('BankName','AIB Business',[])) ) then
            try
               Append;
               FieldByName('BankName').AsString := 'AIB Business';
               FieldByName('Delimiter').AsString := ',';

               FieldByName('HeaderLines').AsString := '1';
               FieldByName('DateFieldNo').AsInteger := 1;
               FieldByName('DetailFieldNo').AsInteger := 4;
               FieldByName('DebitFieldNo').AsInteger := 6;
               FieldByName('CreditFieldNo').AsInteger := 7;
               FieldByName('BalanceFieldNo').AsInteger := 8;
               FieldByName('ChequeIdentifier').AsString := 'CHEQUE';
               FieldByName('LodgementIdentifier').AsString := 'LDG';
               Post;
            except
               Cancel;
            end;

         // Add default for Danske
         if ( not(Locate('BankName','Danske',[])) ) then
            try
               Append;
               FieldByName('BankName').AsString := 'Danske';
               FieldByName('Delimiter').AsString := ',';

               FieldByName('HeaderLines').AsString := '1';
               FieldByName('DateFieldNo').AsInteger := 1;
               FieldByName('DetailFieldNo').AsInteger := 2;
               FieldByName('DebitFieldNo').AsInteger := 3;
               FieldByName('CreditFieldNo').AsInteger := 0;
               FieldByName('BalanceFieldNo').AsInteger := 4;
               FieldByName('ChequeIdentifier').AsString := 'CHQ';
               FieldByName('LodgementIdentifier').AsString := 'BGC';
               Post;
            except
               Cancel;
            end;

         // Add default for Danske eSafeID
         if ( not(Locate('BankName','Danske eSafeID',[])) ) then
            try
               Append;
               FieldByName('BankName').AsString := 'Danske eSafeID';
               FieldByName('Delimiter').AsString := ',';

               FieldByName('HeaderLines').AsString := '1';
               FieldByName('DateFieldNo').AsInteger := 1;
               FieldByName('DetailFieldNo').AsInteger := 3;
               FieldByName('DebitFieldNo').AsInteger := 5;
               FieldByName('CreditFieldNo').AsInteger := 0;
               FieldByName('BalanceFieldNo').AsInteger := 6;
               FieldByName('ChequeIdentifier').AsString := 'CHQ';
               FieldByName('LodgementIdentifier').AsString := 'BGC';
               Post;
            except
               Cancel;
            end;
   finally
      Close;
      Free;
   end;
end;

procedure TAccsDataModule.CreateBankImportTempTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            TableName := 'BankCSVTempTable';
            if Exists then DeleteTable;
            with FieldDefs do
               begin
                  Clear;
                  Add('Id',ftAutoInc);
                  Add('TransactionType',ftString,30,false);
                  Add('Import',ftBoolean);
                  Add('TxDate',ftdate,0,false);
                  Add('Details',ftString,30,false);

                  //   25/10/17 [V4.2 R8.9] /MK Change - Added two extra details fields in the BankCSVTempTable - Brendan Brady.
                  Add('Details1',ftString,30,false);
                  Add('Details2',ftString,30,false);

                  Add('StubNumber',ftString,8,false);
                  Add('Expenditure',ftFloat,0,false);
                  Add('Income',ftFloat,0,false);
                  Add('Amount',ftFloat,0,false);
                  //   04/01/19 [V4.3 R4.0] /MK Additional Feature - Added discount field to Bank Import Temp Table.
                  Add('Discount',ftFloat,0,false);
                  Add('OriginalAmount',ftFloat,0,false); // Keeps the original amount so we can reference it again later
                  Add('IncomeOrExpense',ftString,8);

                  Add('Enterprise',ftString,4,false);
                  Add('NomCode',ftInteger,0,false);
                  Add('NomName',ftString,40);
                  Add('VATCode',ftString,1,false);
                  Add('CustSupp',ftInteger,0,false);
                  Add('CustSuppName',ftString,50,false);
                  Add('Analysis',ftInteger,0,false);

                  Add('IsMultiLineTransaction',ftBoolean);
                  //   15/01/19 [V4.3 R4.1] /MK Change - Added new fields for new split transaction changes in Bank Link.
                  Add('IsSplitTransaction',ftBoolean);
                  Add('SplitTransID',ftInteger);

                  Add('Quantity1',ftFloat);
                  Add('Quantity2',ftFloat);
                  Add('Quantity3',ftFloat);

                  Add('Hash',ftString,255);

                  //   20/11/18 [V4.3 R2.9] /MK Change - New field, NomFreeText, added to store the "Overwrite of Nominal Description" value.
                  Add('NomFreeText',ftString,30,False);
                end;
            CreateTable;

            // SP 28/01/2015 This temp table will store multi line transactions
            // that have been created as part of the Bank Import

            DatabaseName := AccsDataBase.DatabaseName;
            TableName := 'BankCSVDetailTempTable';
            if Exists then DeleteTable;
            with FieldDefs do
               begin
                  Clear;
                  Add('LineId',ftAutoInc);
                  Add('TransactionId',ftInteger);
                  Add('TransactionType',ftString,30,false);
                  Add('Import',ftBoolean);
                  Add('TxDate',ftdate,0,false);
                  Add('Details',ftString,30,false);
                  Add('StubNumber',ftString,8,false);
                  Add('Expenditure',ftFloat,0,false);
                  Add('Income',ftFloat,0,false);
                  Add('Amount',ftCurrency,0,false);
                  Add('IncomeOrExpense',ftString,8);
                  Add('Enterprise',ftString,4,false);
                  Add('NomCode',ftInteger,0,false);
                  Add('NomName',ftString,40);
                  Add('VATCode',ftString,1,false);
                  Add('CustSupp',ftInteger,0,false);
                  Add('CustSuppName',ftString,50,false);
                  Add('Analysis',ftInteger,0,false);

                  Add('Quantity1',ftFloat);
                  Add('Quantity2',ftFloat);
                  Add('Quantity3',ftFloat);

                end;

                with IndexDefs do
                   begin
                      Clear;
                      Add('pkLineId','LineId',[ixPrimary,ixUnique]);
                      Add('ixTransactionId','TransactionId',[ixCaseInsensitive]);
                   end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateBankImportDefaultsTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'BankImportDefaults';
            with FieldDefs do
               begin
                  Add('ID',ftAutoInc,0,FALSE);
                  Add('BankAccount',ftinteger,0,false);
                  Add('DefaultBankFileID',ftString,0,false);
                  Add('DefaultPath',ftString,255,false);
                end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateBankAuditTrialTempTable; // TGM AB 01/03/2013
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'BankAuditTrailTempTable';
            with FieldDefs do
               begin
                  Add('ID',ftAutoInc,0,FALSE);
                  Add('Account',ftinteger,0,false);
                  Add('LabelText',ftstring,255,false);
                  Add('StubNumber',ftstring,8,false);
                  Add('TxNo',ftinteger,0,false);
                  Add('MultiTx',ftstring,1,false);
                  Add('MultiTxNo',ftinteger,0,false);
                  Add('Receipt',ftFloat,0,false);
                  Add('Payment',ftFloat,0,false);
                  Add('LineReceipt',ftFloat,0,false);
                  Add('LinePayment',ftFloat,0,false);
           //       Add('ReceiptString',ftString,15,false);
           //       Add('PaymentString',ftString,15,false);
          //        Add('LineReceiptString',ftString,15,false);
          //        Add('LinePaymentString',ftString,15,false);
                  Add('StubDate',ftDateTime,0,false);
                  Add('LineDate',ftDateTime,0,false);
                  Add('Status',ftstring,30,false);
                  Add('CustSupp',ftstring,50,false);
                  Add('CommentDesc',ftstring,50,false);
                  Add('RunStatementBal',ftFloat,0,false);
                  Add('RunStatementBalString',ftString,15,false);
                  Add('ToBeDeleted',ftBoolean,0,false);  // TGM AB 13/11/17
                end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateCostPerUnitTempTable; // TGM AB 27/09/2013
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'CostPerUnitReportTable';
            with FieldDefs do
               begin
                  Add('ID',ftAutoInc,0,FALSE);
                  Add('NomCode',ftinteger,0,false);
                  Add('NomName',ftstring,50,false);
                  Add('NumberField1',ftfloat,0,false);
                  Add('NumberField2',ftfloat,0,false);
                  Add('NumberField3',ftfloat,0,false);
                  Add('NumberField4',ftfloat,0,false);
                  Add('NumberField5',ftfloat,0,false);
                  Add('NumberField6',ftfloat,0,false);
                  Add('NumberField1Bold',ftfloat,0,false);
                  Add('NumberField2Bold',ftfloat,0,false);
                  Add('NumberField3Bold',ftfloat,0,false);
                  Add('NumberField4Bold',ftfloat,0,false);
                  Add('NumberField5Bold',ftfloat,0,false);
                  Add('NumberField6Bold',ftfloat,0,false);
                  Add('Label',ftstring,255,false);
                  Add('HighLightLabel',ftstring,255,false);
                  Add('Title',ftstring,255,false);

                end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.BankTableDBAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(CustSuppListingDB.Handle);
end;

function TAccsDataModule.IsEnterpriseInUse(const AEnterpriseName : string) : Boolean;
begin
   with TQuery.Create(nil) do
   try
      // At the time of writing this code, the maximum length of
      // any of the enterprises was 12. Therefore we need to copy
      // enterprise name 1 to 12 of the Enterprisename field because
      // there is trailing numbers contained in each ent. name  that
      // cause issues when trying to match the ent. name ??
      DatabaseName := AccsDataModule.AccsDataBase.DatabaseName;
      SQL.Clear;
      SQL.Add('SELECT Count(E.EntName)');
      SQL.Add('FROM '+ AccsDataModule.EntsFileDb.TableName+' E ');
      SQL.Add('WHERE UPPER(TRIM(SUBSTRING(E.EntName FROM 1 FOR 12))) = :EntName');
      SQL.Add('AND (E."Active" = True)');
      Params[0].AsString := Uppercase(AEnterpriseName);
      Open;

      First;
      try
         Result := Fields[0].AsInteger>0;
      finally
         Close;
      end;
   finally
      Free;
   end;
end;

function TAccsDataModule.GetEnterpriseCodeByName(
  const AEnterpriseName: string): string;
begin
   with TQuery.Create(nil) do
   try
      DatabaseName := AccsDataModule.AccsDataBase.DatabaseName;
      SQL.Clear;
      SQL.Add('SELECT E.EntCode');
      SQL.Add('FROM '+ AccsDataModule.EntsFileDb.TableName+' E ');
      SQL.Add('WHERE UPPER(TRIM(SUBSTRING(E.EntName FROM 1 FOR 12))) = :EntName');
      SQL.Add('AND (E."Active" = True)');
      Params[0].AsString := Uppercase(AEnterpriseName);
      Open;

      First;
      try
         Result := Fields[0].AsString;
      finally
         Close;
      end;
   finally
      Free;
   end;
end;

function TAccsDataModule.GetBusinessSummaryAlterName: string;
begin
    if (AccsSystem.SystemType = stCashbook) then
       Result := 'Farm Summary'
    else
       Result := 'Business Summary';
end;

function TAccsDataModule.GetBudgetAlternateName: string;
begin
   if (AccsSystem.SystemType = stCashbook) then
      Result := 'Farm Budget'
   else
      Result := 'Budget'
end;

function TAccsDataModule.CostPerUnitReportAlternateName: string;
var
   InUse : Boolean;
begin
   InUse := IsEnterpriseInUse(cDairyEnterpriseName);
   if (InUse) then
      result := 'Dairy Enterprise Cost/Litre'
   else
      result := 'Enterprise Cost Per Unit';
end;

procedure TAccsDataModule.BankCSVDefaultsDBAfterPost(DataSet: TDataSet);
begin
   DbiSaveChanges(BankCSVDefaultsDB.Handle);
end;

// New procedure to add missing fields from ImportDates table. These fields are needed
// when the CoOp import screen checks to see if the file has been read in already. These fields
// are currently only added when the ImportDates table is created.
procedure TAccsDataModule.CheckImportDateFields;
begin
   UpdateTable.TableName := ImportDates.TableName;
   if ( not(FieldExists('Importfrom')) ) then
      try
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD Importfrom CHAR(15)';
         AddFieldsQuery.ExecSQL;
      except
         on E : Exception do
            ShowMessage(e.message);
      end;

   if ( not(FieldExists('ImportYear')) ) then
      begin
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD ImportYear Integer';
         AddFieldsQuery.ExecSQL;
      end;

   if ( not(FieldExists('ImportMonth')) ) then
      begin
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD ImportMonth Integer';
         AddFieldsQuery.ExecSQL;
      end;
end;

procedure TAccsDataModule.BankCSVTempTableDBAfterPost(DataSet: TDataSet);
begin
    DBiSaveChanges(BankCSVTempTableDB.handle);
end;

procedure TAccsDataModule.CheckDatabaseDefaultsTable;
begin
   UpdateTable.TableName := 'DatabaseDefaults';
   if ( not(FieldExists('LastImportBank')) ) then
      try
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD LastImportBank CHAR(50)';
         AddFieldsQuery.ExecSQL;
      except
         on e : exception do
            MessageDlg(E.Message + ' - Error updating "'+  UpdateTable.TableName +'" table schema. Field "LastImportBank" could not be created.',mtError,[mbOK],0);
      end;

   if ( not(FieldExists('DefaultStatementDirectory')) ) then
      try
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD DefaultStatementDirectory CHAR(100)';
         AddFieldsQuery.ExecSQL;
      except
         MessageDlg('Error updating "'+  UpdateTable.TableName +'" table schema. Field "DefaultStatementDirectory" could not be created.',mtError,[mbOK],0);
      end;

   if ( not(FieldExists('APISecret')) ) then
      try
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD APISecret CHAR(50)';
         AddFieldsQuery.ExecSQL;
      except
         MessageDlg('Error updating "'+  UpdateTable.TableName +'" table schema. Field "APISecret" could not be created.',mtError,[mbOK],0);
      end;

      // Ch015
      if ( not(FieldExists('PreviousVATMarked')) ) then
      try
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD PreviousVATMarked Boolean';
         AddFieldsQuery.ExecSQL;
      except
         MessageDlg('Error updating "'+  UpdateTable.TableName +'" table schema. Field "PreviousVATMarked" could not be created.',mtError,[mbOK],0);
      end;

      if ( not(FieldExists('FirstReturnCompleted')) ) then
      try
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD FirstReturnCompleted Boolean';
         AddFieldsQuery.ExecSQL;
      except
         MessageDlg('Error updating "'+  UpdateTable.TableName +'" table schema. Field "FirstReturnCompleted" could not be created.',mtError,[mbOK],0);
      end;
      // Ch015 end

      if ( not(FieldExists('ClientVRN')) ) then
      try
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD ClientVRN CHAR(18)';
         AddFieldsQuery.ExecSQL;
      except
         MessageDlg('Error updating "'+  UpdateTable.TableName +'" table schema. Field "ClientVRN" could not be created.',mtError,[mbOK],0);
      end;
end;

function TAccsDataModule.GetLastImportBank: string;
var
   DefaultBankAccount : TBankAccount;
begin
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.AliasName;
         SQL.Clear;
         SQL.Add('SELECT LastImportBank FROM DatabaseDefaults');
         Open;
         try
            First;
            Result := Fields[0].AsString;

            if (Result = '') then
               begin
                  DefaultBankAccount := Accounts.BankAccounts.First;
                  if (DefaultBankAccount <> nil) then
                     Result := DefaultBankAccount.Name;
               end;
         finally
            Close;
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.SetLastImportBank(const Value: string);
begin
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.AliasName;
         SQL.Clear;
         SQL.Add('UPDATE DatabaseDefaults SET LastImportBank =:Value ');
         Params[0].AsString := Value;
         try
            ExecSQL;
         except
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.CreateBankExtTable;
var
   MyTable : TTable;
begin
   MyTable := TTable.Create(nil);
   with MyTable do
   try
      try
         DatabaseName := AccsDataBase.DatabaseName;
         TableName := 'BankExt';

         if Exists then Exit;

         with FieldDefs do
            begin
               Clear;
               Add('BankId',ftInteger);
               Add('BankFileFormat',ftInteger);
             end;
         IndexDefs.Clear;
         CreateTable;
      except
         MessageDlg('Error creating table "'+ TableName +'".',mtError,[mbOK],0);
      end;
   finally
      MyTable.Free;
   end;
end;

function TAccsDataModule.GetDefaultStatementDirectory: string;
begin
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.AliasName;
         SQL.Clear;
         SQL.Add('SELECT DefaultStatementDirectory FROM DatabaseDefaults');
         Open;
         try
            First;
            Result := Fields[0].AsString;
         finally
            Close;
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.SetDefaultStatementDirectory(
  const Value: string);
begin
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.AliasName;
         SQL.Clear;
         SQL.Add('UPDATE DatabaseDefaults SET DefaultStatementDirectory =:Value ');
         Params[0].AsString := Value;
         try
            ExecSQL;
         except
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.OpenRepositoryData;
var
   i : Integer;
   BankAccount : TBankAccount;
begin
   // load Banks into repository
   erBankLookup.Properties.Items.Clear;
   for i := 0 to Accounts.BankAccounts.Count-1 do
      begin
         BankAccount := Accounts.BankAccounts[i];
         erBankLookup.Properties.Items.Add(BankAccount.Name);
      end;
end;

procedure TAccsDataModule.DataModuleDestroy(Sender: TObject);
begin
   if FAccounts <> nil then
      FreeAndNil(FAccounts);
   if Assigned(FJobCardXmlDocument) then
      FJobCardXmlDocument := nil;
end;

function TAccsDataModule.Accounts: TAccounts;
var
   AliasName : string;
begin
   AliasName := AccsDataBase.AliasName;
   if not AccsDataBase.Connected then
      AccsDataBase.Connected := True;
   if FAccounts = nil then
      FAccounts := TAccounts.Create(AccsDataBase.AliasName);
   Result := FAccounts;
end;

procedure TAccsDataModule.FreeAccounts;
begin
   if FAccounts <> nil then
      FreeAndNil(FAccounts);
end;

procedure TAccsDataModule.OpenDataLinks;
begin
   OpenRepositoryData();
end;

procedure TAccsDataModule.UpdateBankDetails(ABankAccount: TBankAccount);
begin
   with TTable.Create(nil) do
      try
         DatabaseName := Global.AliasName;
         TableName := 'BankExt';
         Open;
         try
            First;

            try
               if not Locate('BankId', ABankAccount.Id, []) then
                  begin
                     Append;
                     FieldByName('BankId').AsInteger := ABankAccount.Id;
                  end
               else
                  Edit;

               FieldByName('BankFileFormat').AsInteger := ABankAccount.BankFileFormat;
               Post;
            except
               Cancel;
            end;
            DbiSaveChanges(Handle);
         finally
            Close;
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.CreateBankCSVDefaultData;
begin
end;

procedure TAccsDataModule.AccsDataBaseAfterConnect(Sender: TObject);
begin
   if AccsSettings = nil then
      AccsSettings := TAccsSettings.Create(ExtractDirFromPath(AccsDataBase.Directory))
   else
      AccsSettings.DatabaseName := ExtractDirFromPath(AccsDataBase.Directory);
end;

procedure TAccsDataModule.CreateBudgetExtTable;
var
   MyTable : TTable;
begin
   MyTable := TTable.Create(nil);
   with MyTable do
   try
      try
         DatabaseName := AccsDataBase.DatabaseName;
         TableName := 'BudgetExt';

         if Exists then Exit;

         with FieldDefs do
            begin
               Clear;
               Add('BudgetYear',ftInteger);
               Add('DiaryNotes',ftMemo);
               Add('DiaryNotesLastUpdated',ftDateTime);
            end;
         IndexDefs.Clear;
         IndexDefs.Add('','BudgetYear',[ixPrimary, ixUnique]);

         CreateTable;
      except
         MessageDlg('Error creating table "'+ TableName +'".',mtError,[mbOK],0);
      end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.BudgetExtAfterPost(DataSet: TDataSet);
begin
   DBISaveChanges(BudgetExt.Handle);
end;

procedure TAccsDataModule.BudgetExtBeforePost(DataSet: TDataSet);
begin
   BudgetExt.FieldByName('DiaryNotesLastUpdated').AsDateTime := Now();
end;

function TAccsDataModule.GetAdvancedQuantityInput(
  AEntCode: string): TQuantityInput;
begin
   with TQuery.Create(nil) do
   try
      DatabaseName := AccsDataModule.AccsDataBase.DatabaseName;
      SQL.Clear;
      SQL.Add('SELECT E.Quantity2Name, E.Quantity3Name ');
      SQL.Add('FROM '+ AccsDataModule.EntsFileDb.TableName+' E ');
      SQL.Add('WHERE UPPER(E.EntCode) =:EntName');
      SQL.Add('AND (E."Active" = True)');
      Params[0].AsString := Uppercase(AEntCode);
      Open;

      First;
      try
         if ((Length(Trim(Fields[0].AsString)) <= 0) and (Length(Trim(Fields[1].AsString)) <=0)) then
            Exit;

         Result := TQuantityInput.Create;
         Result.Heading2 := Trim(Fields[0].AsString);
         Result.Heading3 := Trim(Fields[1].AsString);
      finally
         Close;
      end;
   finally
      Free;
   end;
end;

function TAccsDataModule.GetEnterpriseByCode(
  const AEnterpriseCode: string): TEnterpriseAccount;
begin
   Result := nil;
   with TQuery.Create(nil) do
   try
      DatabaseName := AccsDataModule.AccsDataBase.DatabaseName;
      SQL.Clear;
      SQL.Add('SELECT E.*');
      SQL.Add('FROM '+ AccsDataModule.EntsFileDb.TableName+' E');
      SQL.Add('WHERE UPPER(TRIM(E.EntCode)) = :EntName');
      SQL.Add('AND (E."Active" = True)');
      Params[0].AsString := Uppercase(AEnterpriseCode);
      Open;

      if (RecordCount=0) then Exit;

      First;
      try
         Result := TEnterpriseAccount.Create;
         Result.Code := FieldByName('EntCode').AsString;
         Result.Name := FieldByName('EntName').AsString;
         Result.DefaultUnitTotal := FieldByName('UnitDiv').AsFloat;
         Result.DefaultUnitDescription := FieldByName('UnitText').AsString;
      finally
         Close;
      end;
   finally
      Free;
   end;
end;

function TAccsDataModule.GetEnterpriseCodeByNominalCode(
   const ANominalCode : string) : string;
var
   NominalAccount : TNominalAccount;
begin
   Result := '';
   if (Length(Trim(ANominalCode))=0) then Exit;

   try
      NominalAccount := Accounts.GetNominalAccount(StrToInt(ANominalCode));
      if (NominalAccount <> nil) then
         Result := NominalAccount.EntCode;
   except
      raise Exception.Create('Invalid argument');
   end;
end;

function TAccsDataModule.GetEnterpriseExpenseStart: Integer;
begin
   Result := GetFirstActiveEnterprisedNominalInRange(201, 400); // 201 - 400 being the enterprise expense range.
   if (Result = 0) then Result := 201;
end;

function TAccsDataModule.GetEnterpriseIncomeStart: Integer;
begin
   Result := GetFirstActiveEnterprisedNominalInRange(1, 200); // 1 - 200 being the enterprise income range.
   if (Result = 0) then Result := 1;
end;

function TAccsDataModule.GetFirstActiveEnterprisedNominalInRange(AStart,
  AEnd: Integer): Integer;
begin
   Result := 0;
    with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataModule.AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT MIN(N.NLNo)');
         SQL.Add('FROM NLFIle N');
         SQL.Add('WHERE (N.NLNo BETWEEN :AStart AND :AEnd)');
         SQL.Add('AND (N."Active" = True)');
         SQL.Add('AND ((N.Enterprise IS NOT NULL) OR (N.Enterprise <> ""))');
         Params[0].AsInteger := AStart;
         Params[1].AsInteger := AEnd;

         Open;
         if (RecordCount>0) then
         try
            First;
            Result := Fields[0].AsInteger;
         finally
            Close;
         end;
      finally
         Free;
      end;
end;
procedure TAccsDataModule.BankCSVDetailTempTableDBAfterPost(
  DataSet: TDataSet);
begin
    DBiSaveChanges(BankCSVDetailTempTableDB.handle);
end;

procedure TAccsDataModule.BankCSVDetailTempTableDBNewRecord(
  DataSet: TDataSet);
begin
   BankCSVDetailTempTableDB.FieldByName('VATCode').AsString := 'Z';
end;

function TAccsDataModule.MultipleQuantityHandler(AEnterpriseCode: string;
  const AInQty2, AInQty3: Double; var AOutQty2, AOutQty3: Variant; APoint: TPoint) : Boolean;
var
  QuantityInput : TQuantityInput;
begin
   AOutQty2 := System.Null;
   AOutQty3 := System.Null;

   Result := False;
   if (Length(AEnterpriseCode) <= 0) then
      begin
         MessageDlg('You must select an Enterprise Code before adjusting quantities.',mtWarning,[mbOK],0);
         Exit;
      end;

   QuantityInput := AccsDataModule.GetAdvancedQuantityInput(AEnterpriseCode);
   if (QuantityInput = nil) then
      begin
         MessageDlg(Format('You have not specified extra quantity fields for enterprise ''%s''.'+cCRLFx2+
                           'Go to Setup > Enterprises and enter values for the Quantity 2/3 fields.',[AEnterpriseCode]),mtWarning,[mbOK],0);
         Exit;
      end;

   try
      if (QuantityInput.Quantity2Enabled) then
         QuantityInput.Quantity2 := AInQty2;

      if (QuantityInput.Quantity3Enabled) then
         QuantityInput.Quantity3 := AInQty3;

      if not (TfmTransactionQuantityInput.ShowAt(QuantityInput,APoint.x, APoint.y)) then Exit;

      if (QuantityInput.Quantity2Enabled) then
         AOutQty2 := QuantityInput.Quantity2;

      if (QuantityInput.Quantity3Enabled) then
         AOutQty3 := QuantityInput.Quantity3;
      Result := True;
   finally
      FreeAndNil(QuantityInput);
   end;
end;

function TAccsDataModule.ExtractStubFromBankDetailLine(
  const ADetailLine: string): string;
var
   i, len : Integer;
   StrArray : TStringArray;
begin
   Result := '';
   if Length(Trim(ADetailLine)) = 0 then Exit;
   try
      StrArray := SplitString(ADetailLine,' ');
      len := length(StrArray);
      for i := 0 to len-1 do
         if IsNumeric(StrArray[i]) then
            begin
               Result := Trim(StrArray[i]);
               Break;
            end;
   except
   end;
end;

procedure TAccsDataModule.CreateAccSyncDatabase;
var
   i : Integer;
const
   Tables : array [0..5] of string = ('EntsFile', 'NLFile', 'Products', 'SLFile', 'PLFile', 'Analysis');
begin
   for i := 0 to Length(Tables)-1 do
      begin
         UpdateTable.TableName := Tables[i];
         if ( not(FieldExists('IsSynchronized')) ) then
            begin
               AddFieldsQuery.SQL.Text := 'ALTER TABLE '+Tables[i]+' ADD IsSynchronized Boolean';
               AddFieldsQuery.ExecSQL;
            end;
      end;


   UpdateTable.TableName := Tables[0];
   if ( not(FieldExists('JobCardEnabled')) ) then
      begin
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD JobCardEnabled Boolean';
         AddFieldsQuery.ExecSQL;
         AddFieldsQuery.SQL.Text := 'UPDATE '+UpdateTable.TableName+' SET JobCardEnabled = False';
         AddFieldsQuery.ExecSQL;
      end;

   UpdateTable.TableName := 'AccsSync';
   if not UpdateTable.Exists then
      begin
         UpdateTable.FieldDefs.Clear;
         UpdateTable.FieldDefs.Add('CompanyName', ftString, 80);
         UpdateTable.FieldDefs.Add('CompanyId', ftString, 80);
         UpdateTable.CreateTable;

         UpdateTable.Open;
         try
            UpdateTable.Edit;
            UpdateTable.FieldByName('CompanyName').AsString := Uppercase(CurrentDatabase);
            UpdateTable.Post;
            DbiSaveChanges(UpdateTable.Handle);
         finally
            UpdateTable.Close;
         end;
      end;
end;

function TAccsDataModule.GetCurrentDatabase: string;
begin
   Result := ExtractDirFromPath(ExcludeTrailingBackslash(AccsDataModule.AccsDataBase.Directory));
end;

function TAccsDataModule.UpdateCompanyId(ACompanyId: string) : Boolean;
begin
   Result := False;
   UpdateTable.Close;
   UpdateTable.TableName := 'AccsSync';
   UpdateTable.Open;
   try
      UpdateTable.First;
      UpdateTable.Edit;
      if UpdateTable.FieldByName('CompanyName').AsString <> Uppercase(CurrentDatabase) then
         UpdateTable.FieldByName('CompanyId').AsString := ''
      else
         begin
            Result := True;
            UpdateTable.FieldByName('CompanyId').AsString := ACompanyId;
         end;
      UpdateTable.Post;
      DbiSaveChanges(UpdateTable.Handle);
   finally
      UpdateTable.Close;
   end;
end;

function TAccsDataModule.GetCurrentDatabasePath: string;
begin
   Result := AccsDataModule.AccsDataBase.Directory;
end;

function TAccsDataModule.GetJobCardXmlDocument: IXMLDOMDocument;
var
   FileName : string;
begin
   if (FJobCardXmlDocument = nil) then
      try
         Screen.Cursor := crHourGlass;

         FileName := IncludeTrailingBackslash(CurrentDatabasePath) + 'JobCards.xml';
         if (not FileExists(FileName)) then Exit;

         try
            FJobCardXmlDocument := CreateOleObject('MSXML2.DOMDocument') as IXMLDOMDocument;
         except
            raise Exception.Create('Error creating MSXML2.DOMDocument. Please contact Kingswood.');
         end;
         FJobCardXmlDocument.load(IncludeTrailingBackslash(CurrentDatabasePath) + 'JobCards.xml');
      finally
         Screen.Cursor := crDefault;
      end;

   Result := FJobCardXmlDocument;
end;

procedure TAccsDataModule.SetJobCardXmlDocument(
  const Value: IXMLDOMDocument);
begin
   FJobCardXmlDocument := Value;
end;

procedure TAccsDataModule.SaveJobCardXmlDocument;
var
   FileName : string;
begin
   if (FJobCardXmlDocument <> nil) then
      begin
         FileName := IncludeTrailingBackslash(CurrentDatabasePath) + 'JobCards.xml';
         FJobCardXmlDocument.save(FileName);
      end;
end;

function TAccsDataModule.GetAppJobCards(const ACustomerId : Integer;
  const AJobCardViewType : TJobCardViewType): TAppJobCards;
var
   QueryString : string;
   i : Integer;
   JobNodes : IXMLDOMNodeList;
   JobNode, ChildNode, Node : IXMLDOMNode;
   JobCard : TAppJobCard;
begin
   Result := TAppJobCards.create;

   if (JobCardXmlDocument = nil) then
      begin
         Result := nil;
         Exit;
      end;

   QueryString := './jobCard[./customer/id = "'+IntToStr(ACustomerId)+'"';
   if (AJobCardViewType = vtToBeImported) then
      QueryString := QueryString + ' && importedOn = ""]'
   else if (AJobCardViewType = vtImported) then
      QueryString := QueryString + ' && importedOn != ""]';

   JobNodes := JobCardXmlDocument.documentElement
                                  .selectNodes(QueryString);

   if ((not Assigned(JobNodes)) or (JobNodes.length = 0)) then Exit;

   try
      for i := 0 to JobNodes.Length-1 do
         begin
            Application.ProcessMessages;

            JobCard := TAppJobCard.Create;

            JobNode := JobNodes.item[i];

            Node := JobNode.selectSingleNode('jobCardId');
            if Assigned(Node) then
               try
                  JobCard.JobCardId := StrToInt(Node.text);
               except
               end;

            Node := JobNode.selectSingleNode('operator');
            if Assigned(Node) then
               JobCard.Operator.Name := Node.text;

            Node := JobNode.selectSingleNode('customer');
            if Assigned(Node) then
               begin
                  ChildNode := Node.selectSingleNode('id');
                  if Assigned(ChildNode) then
                     try
                        JobCard.Customer.Id := StrToInt(ChildNode.text);
                     except
                     end;
                  ChildNode := Node.selectSingleNode('name');
                  if Assigned(ChildNode) then
                     JobCard.Customer.Name := ChildNode.text;
               end;

            Node := JobNode.selectSingleNode('activity');
            if Assigned(Node) then
               begin
                  ChildNode := Node.selectSingleNode('id');
                  if Assigned(ChildNode) then
                     try
                        JobCard.Activity.Id := StrToInt(ChildNode.text);
                     except
                     end;
                  ChildNode := Node.selectSingleNode('name');
                  if Assigned(ChildNode) then
                     JobCard.Activity.Name := ChildNode.text;
               end;

            Node := JobNode.selectSingleNode('product1');
            if Assigned(Node) then
               begin
                  ChildNode := Node.selectSingleNode('id');
                  if Assigned(ChildNode) then
                     try
                        JobCard.Product1.Id := StrToInt(ChildNode.text);
                     except
                     end;
                  ChildNode := Node.selectSingleNode('name');
                  if Assigned(ChildNode) then
                     JobCard.Product1.Name := ChildNode.text;
               end;

            Node := JobNode.selectSingleNode('unit');
            if Assigned(Node) then
               JobCard.UnitType := Node.text;

            Node := JobNode.selectSingleNode('quantity');
            if Assigned(Node) then
               JobCard.Quantity := StrToFloat(Node.text);

            Node := JobNode.selectSingleNode('startDate');
            if Assigned(Node) then
               try
                  JobCard.StartDateTime := StrToDateTime(Node.text);
               except
               end;

            Node := JobNode.selectSingleNode('finishDate');
            if Assigned(Node) then
               try
                  JobCard.FinishDateTime := StrToDateTime(Node.text);
               except
               end;

            Node := JobNode.selectSingleNode('comment');
            if Assigned(Node) then
               JobCard.Comment := Node.text;

            Node := JobNode.selectSingleNode('jobReference');
            if Assigned(Node) then
               JobCard.JobReference := Node.text;

            Node := JobNode.selectSingleNode('syncDate');
            if Assigned(Node) then
               try
                  JobCard.UploadDateTime := StrToDateTime(Node.text);
               except
               end;

            Node := JobNode.selectSingleNode('clientJobCardId');
            if Assigned(Node) then
               JobCard.ClientId := Node.text;

            Node := JobNode.selectSingleNode('importedOn');
            if Assigned(Node) then
               try
                  if Node.text <> '' then
                     JobCard.ImportDate := StrToDateTime(Node.text);
               except
               end;

            Result.Add( JobCard );
         end;
   finally
      JobNode := nil;
      ChildNode := nil;
      Node := nil;
   end;
end;

function TAccsDataModule.MarkJobCardAsSeen(const AClientId : string;
   const ADate : TDateTime) : Boolean;
var
   QueryString : string;
   i : Integer;
   JobNodes : IXMLDOMNodeList;
   JobNode, ChildNode, Node : IXMLDOMNode;
begin
   Result := False;

   if (JobCardXmlDocument = nil) then Exit;

   QueryString := Format('./jobCard[clientJobCardId = "%s"]',[AClientId]);

   JobNodes := JobCardXmlDocument.documentElement
                                 .selectNodes(QueryString);

   for i := 0 to JobNodes.Length-1 do
      begin
         JobNode := JobNodes[i];
         ChildNode := JobNode.selectSingleNode('importedOn');
         if not Assigned(ChildNode) then Exit;
         ChildNode.text := FormatDateTime('dd/mm/yy hh:nn', ADate);

         Result := True;
      end;
end;

function TAccsDataModule.GetNominalForSupplierCustomer(
  const ACustomerSupplierId: Integer;
  const ATransactionType: TTransactionType): Integer;
var
   NoOfNominals : Integer;
begin
   Result := 0;
   if (ACustomerSupplierId<=0) or ((ATransactionType<>ttIncome) And (ATransactionType<>ttExpense)) then Exit;

   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT DISTINCT(Nominal) ');
         SQL.Add('FROM Transactions          ');
         SQL.Add('WHERE (TxType = 9 )        ');
         if (ATransactionType=ttIncome) then
            SQL.Add('AND (OrigType IN '+ IntArrayToSQLInString(IncomeLineIds)+')')
         else
            SQL.Add('AND (OrigType IN '+ IntArrayToSQLInString(ExpenseLineIds)+')');
         SQL.Add('AND (Account = '+ IntToStr(ACustomerSupplierId) +')            ');
         Open;
         try
            First;
            NoOfNominals := RecordCount;
            if (NoOfNominals = 1) then
               Result := Fields[0].AsInteger;
         finally
            Close;
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.CloseAndUpdate;
begin
   FCheckName.ExitButton.Click;
   ShellExecute(0, 'open', 'C:\Kingsacc\kinstaller.exe', pChar('accs '+IntToStr(PSysLongToDelphi ( Cash11.serial_no ))), nil, SW_SHOWNORMAL);
end;

procedure TAccsDataModule.CreateBankImportTransHash;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            TableName := 'BankImportTransHash';
            if Exists then Exit;

            FieldDefs.Clear;
            IndexDefs.Clear;

            with FieldDefs do
               begin
                  Add('Id',ftAutoInc);
                  Add('Hash',ftString,255);
               end;

            IndexDefs.Add('iId','Id',[ixPrimary, ixUnique]);
            IndexDefs.Add('iHash','Hash',[ixUnique, ixCaseInsensitive]);
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

function TAccsDataModule.NewTransactionHash(const ATransactionLine: string): string;
begin
   Result := StripAllNomNumAlpha(ATransactionLine);
end;

procedure TAccsDataModule.StoreTransactionHash(const ATransactionHash: string);
begin
   if TransactionHashExists(ATransactionHash) then Exit;

   with TQuery.Create(nil) do
   try
      DatabaseName := AccsDataBase.DatabaseName;
      SQL.Clear;
      SQL.Add('INSERT INTO BankImportTransHash (Hash) VALUES (:Hash)');
      Params[0].AsString := ATransactionHash;
      ExecSQL;
   finally
      Free;
   end;
end;

function TAccsDataModule.TransactionHashExists(const ATransactionHash: string): Boolean;
begin
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT COUNT(*) FROM BankImportTransHash WHERE (Hash=:Hash)');
         Params[0].AsString := ATransactionHash;
         Open;
         try
            Result := Fields[0].AsInteger > 0;
         finally
            Close;
         end;
      finally
         Free;
      end;
end;

function TAccsDataModule.HelpSocketHTMLHelp(Command: Word; Data: Integer;
  var CallHelp: Boolean): Boolean;
begin
   CallHelp := True;
end;

procedure TAccsDataModule.HTMLHelp(Context: String);
var
   HF: string;
begin
   try
      // get & assign current directory as file path
      SetCurrentDir(ExtractFilePath(ParamStr(0)));
      HF := ExtractFilePath(ParamStr(0))+'AccountsHelp.chm';
      if ( not(FileExists(HF)) ) then
         begin
            MessageDlg('The Kingswood Accounts Help File does not exist.'+#13#10+
                       'Click New Version and download Kingswood Accounts Help.',mtError,[mbOK],0);
            Exit;
         end
      else
         begin
            if (Application.HelpFile <> HF) then
               begin
                  HelpSocket.CloseAll;
                  Application.HelpFile := HF;
               end;
            HelpSocket.HTMLHelpCommand(HH_DISPLAY_TOPIC,LongInt(PChar(Context)));

            // try open page, else open contents
            if (HelpSocket.HHShowTopicByName(Context,False)=0) then
               ShellExecute(Application.Handle,'Open',PChar(HF),nil,nil,SW_SHOWMAXIMIZED);
         end;
   except
      MessageDlg('Error Executing Help Function. Contact Kingswood.',mtConfirmation,[mbOK],0);
   end;

end;

procedure TAccsDataModule.DownloadKInstaller;
var
   GetkInstaller : TLMDWebHTTPGet;
   LMDWebDownload : TLMDWebDownload;
begin
   if not IsNetConnected then Exit;

   GetkInstaller := TLMDWebHTTPGet.Create(nil);
   with GetkInstaller do
      try
         URL := 'http://www.kingswood.ie/download/winherd/kinstaller.exe';
         DownloadDir := 'C:\Kingsacc\';
         DestinationName := 'kinstaller.exe';
         InteractiveProcess;
      finally
         Free;
      end;
end;

function TAccsDataModule.KInstallerIsAvailable: Boolean;
begin
   Result := FileExists('C:\Kingsacc\KInstaller.exe');
end;

function TAccsDataModule.SyncServiceIsAvailable: Boolean;
begin
   Result := FileExists('C:\Kingsacc\Services\FarmSync.exe');
end;

function TAccsDataModule.GetDefaultCoOpCompany: String;
begin
   Result := '';
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.AliasName;
         SQL.Clear;
         SQL.Add('SELECT CoOpName');
         SQL.Add('FROM '+ImportDefaults.TableName+'');
         SQL.Add('WHERE UseAsDefault = TRUE');
         try
            Open;
            if ( RecordCount = 0 ) then Exit;
            First;
            Result := Fields[0].AsString;
         except
            on e : Exception do
               ShowMessage(e.Message);
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.DeleteBlankCoOpCompanies;
begin
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.AliasName;
         SQL.Clear;
         SQL.Add('DELETE');
         SQL.Add('FROM '+ImportDefaults.TableName+'');
         SQL.Add('WHERE ( (CoOpName = "") OR (CoOpName IS NULL) )');
         try
            ExecSQL;
         except
            on e : Exception do
               ShowMessage(e.Message);
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.UpdateAccsDefaultsTable;
begin
   UpdateTable.TableName := 'AccsDefaults';

   if ( not(FieldExists('NomProdRelationship')) ) then
      try
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD NomProdRelationship CHAR(15)';
         AddFieldsQuery.ExecSQL;
      except
         on e : exception do
            DbSchemeError(e, UpdateTable.TableName, 'NomProdRelationship');
      end;

   if ( not(FieldExists('UpdateNo')) ) then
      try
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD UpdateNo INTEGER';
         AddFieldsQuery.ExecSQL;
      except
         on e : exception do
            DbSchemeError(e, UpdateTable.TableName, 'UpdateNo');
      end;

   if ( not(FieldExists('LastVerUpdate')) ) then
      try
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD LastVerUpdate TIMESTAMP';
         AddFieldsQuery.ExecSQL;
      except
         on e : exception do
            DbSchemeError(e, UpdateTable.TableName, 'LastVerUpdate');
      end;

   if ( not(FieldExists('LastBackup')) ) then
      try
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD LastBackup TIMESTAMP';
         AddFieldsQuery.ExecSQL;

         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'UPDATE '+UpdateTable.TableName+' SET LastBackup = :Now';
         AddFieldsQuery.Params[0].AsDateTime := Now;
         AddFieldsQuery.ExecSQL;
      except
         on e : exception do
            DbSchemeError(e, UpdateTable.TableName, 'LastBackup');
      end;

   if ( not(FieldExists('MaintPromptDate')) ) then
      try
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD MaintPromptDate TIMESTAMP';
         AddFieldsQuery.ExecSQL;
      except
         on e : exception do
            DbSchemeError(e, UpdateTable.TableName, 'LastBackup');
      end;
end;

procedure TAccsDataModule.DbSchemeError(AException : Exception; ATable, AField : string);
begin
   // TODO: log error to file
   MessageDlg(AException.Message +
              Format(' - Error updating %s table schema. Field %s could not be created.',
                       [ATable,AField]),mtError,[mbOK],0);
end;

// SP 22/06/2016
procedure TAccsDataModule.UpdateProductsTable;
var
   FieldName : string;
begin
   FieldName := 'Unit';
   UpdateTable.TableName := 'Products';
   if (not(FieldExists(FieldName))) then
      try
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD '+ FieldName +' CHAR(25)';
         AddFieldsQuery.ExecSQL;

         AddFieldsQuery.SQL.Text := 'UPDATE '+UpdateTable.TableName+' SET '+ FieldName +' = ''OTHER''';
         AddFieldsQuery.ExecSQL;
      except
         on e : exception do
            DbSchemeError(e, UpdateTable.TableName, FieldName);
      end;

{  SP 22/06/2016

   For the time being, we'll retrieve the Product Unit directly from the products table
   It should not be stored seperately in the transaction file.

   UpdateTable.TableName := 'ProductsTx';
   if (not(FieldExists(FieldName))) then
      try
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD '+ FieldName +' CHAR(25)';
         AddFieldsQuery.ExecSQL;
      except
         on e : exception do
            DbSchemeError(e, UpdateTable.TableName, FieldName);
      end;

   UpdateTable.TableName := 'ProdTxTemp';
   if ( not(FieldExists(FieldName)) ) then
      try
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD '+ FieldName +' CHAR(25)';
         AddFieldsQuery.ExecSQL;
      except
         on e : exception do
            DbSchemeError(e, UpdateTable.TableName, FieldName);
      end;
      }
end;


// SP 12/04/2018
procedure TAccsDataModule.UpdateSLFile;
var
   FieldName : string;
begin
   UpdateTable.TableName := 'SLFile';

   FieldName := 'Formerly';
   if (not(FieldExists(FieldName))) then
      try
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD '+ FieldName +' CHAR(30)';
         AddFieldsQuery.ExecSQL;
      except
         on e : exception do
            DbSchemeError(e, UpdateTable.TableName, FieldName);
      end;
end;


// SP 22/06/2016 - Source for product units
procedure TAccsDataModule.GetProductUnits(AStrings : TStrings);
var
   i : Integer;
begin
   AStrings.Clear;
   for i := 0 to Length(ProductUnitTypes)-1 do
      AStrings.Add(ProductUnitTypes[i]);
end;

procedure TAccsDataModule.ProductsBeforePost(DataSet: TDataSet);
begin
   Products.FieldByName('IsSynchronized').AsBoolean := False; 
end;

procedure TAccsDataModule.SLFileDBBeforePost(DataSet: TDataSet);
begin
   SLFileDB.FieldByName('IsSynchronized').AsBoolean := False;
end;

procedure TAccsDataModule.NLFileDBBeforePost(DataSet: TDataSet);
begin
   NLFileDB.FieldByName('IsSynchronized').AsBoolean := False;
end;

procedure TAccsDataModule.EntsFileDBBeforePost(DataSet: TDataSet);
begin
   EntsFileDB.FieldByName('IsSynchronized').AsBoolean := False;
end;

procedure TAccsDataModule.AnalysisDBBeforePost(DataSet: TDataSet);
begin
   AnalysisDB.FieldByName('IsSynchronized').AsBoolean := False;
end;

procedure TAccsDataModule.CreateProductAllocationTable; // TGM AB 10/06/2016
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'ProductAllocation';
            with FieldDefs do
               begin
                  Add('NLNo',ftinteger,0,false);
                  Add('ProductID',ftinteger,0,false);

                end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.EditMailboxSettings;
begin
   SetCurrentDir(ApplicationPath);
   if not FileExists( IncludeTrailingBackslash(ApplicationPath)+ KingswoodMailBoxDLL) then
      begin
         MessageDlg(cKingswoodMailBoxDLLNotFound,mtError,[mbOk],0);
         Exit;
      end;

   DLLHandle := LoadLibrary(KingswoodMailBoxDLL);
   if DLLHandle = 0 then
      begin
         MessageDlg(cKingswoodMailBoxDLLUnableToLoad,mtError,[mbOk],0);
         Exit;
      end;

   try
     @EMailLoginSetting := GetProcAddress(DLLHandle, 'EMailLoginSetting');
     if @EMailLoginSetting <> nil then
        EMailLoginSetting(PAnsiChar(CurrentDatabasePath))
     else
        MessageDlg(Format(cKingswoodMailBoxDLLCallToFunctionFailed,['EMailLoginSetting']),mtError,[mbOk],0);
   finally
      FreeLibrary(DLLHandle);
   end;
end;

function TAccsDataModule.SendEMail(const AToAddress, ASubject,
  ABody: string; AAttachments: TStringList): Integer;
var
   i : Integer;
   AttachmentNames : string;
begin
   if not IsNetConnected then
      begin
         MessageDlg(cINTERNET_CONNECTION_NOT_ESTABLISHED,mtError,[mbOK],0);
         Exit;
      end;

   if not FileExists( IncludeTrailingBackslash(ApplicationPath)+ KingswoodMailBoxDLL) then
      begin
         MessageDlg(cKingswoodMailBoxDLLNotFound,mtError,[mbOk],0);
         Exit;
      end;

   SetCurrentDir(ApplicationPath);
   DLLHandle := LoadLibrary(KingswoodMailBoxDLL);
   if DLLHandle = 0 then
      begin
         MessageDlg(cKingswoodMailBoxDLLUnableToLoad,mtError,[mbOk],0);
         Exit;
      end;

   @SendMail2 := GetProcAddress(DLLHandle, 'SendMail2');
   if @SendMail2 = nil then
      begin
         MessageDlg(Format(cKingswoodMailBoxDLLCallToFunctionFailed,['SendMail2']),mtError,[mbOk],0);
         Exit;
      end;

   if ((AAttachments <> nil) and (AAttachments.Count>0)) then
      begin
         for i := 0 to AAttachments.Count-1 do
            begin
               if (i = 0) then
                  AttachmentNames := AAttachments[i]
               else
                  AttachmentNames := AttachmentNames + ';'+AAttachments[i];
            end;
      end;
   try
      Result := SendMail2(PChar(AToAddress), PChar(ASubject), PChar(ABody), PChar(AttachmentNames), PChar(CurrentDatabasePath));
   finally
      FreeLibrary(DLLHandle);
   end;
end;

procedure TAccsDataModule.CreateEmailTemplatesTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            TableName := 'EmailTemplates';
            if Exists then Exit;

            FieldDefs.Clear;
            IndexDefs.Clear;
            with FieldDefs do
               begin
                  Add('TemplateName',ftString,80,true);
                  Add('EmailSubject',ftString,50);
                  Add('EmailBody',ftMemo);
               end;

            IndexDefs.Clear;
            IndexDefs.Add('uxTemplateName','TemplateName',[ixPrimary, ixUnique]);

            try
               CreateTable;

               CreateTemplate('Sample', '[Your Company Name] - Invoice Attached',
               'Dear Customer,' + #13#10 + #13#10 +
               'Please find attached invoice for recent product/service delivered.'+ #13#10 + #13#10 + #13#10 +
               'Best regards,' + #13#10 + #13#10 +
               '[Your Company Name]');

               
            except
               MessageDlg('Error creating EmailTemplates.db',mtError,[mbOk],0);
            end;
         end;
   finally
      MyTable.Free;
   end;
end;

function TAccsDataModule.EmailTemplateExists(
  ATemplateName: string): Boolean;
begin
   Result := false;
   if Length(Trim(ATemplateName)) <= 0 then Exit;

   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT TemplateName FROM EmailTemplates WHERE TemplateName=:ATemplateName');
         Params[0].AsString := ATemplateName;
         Open;
         try
            Result := RecordCount>0;
         finally
            Close;
         end;
      finally
         Free;
      end;
end;

function TAccsDataModule.CreateTemplate(const ATemplateName : string;
   const ASubject : string = ''; const ABody : string = '') : Boolean;
var
   MyTable : TTable;
begin
   Result := False;
   try
   try

      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            TableName := 'EmailTemplates';
            if not Exists then Exit;

            MyTable.Active := True;

            MyTable.Append;
            MyTable.FieldByName('TemplateName').AsString := ATemplateName;
            if Length(Trim(ASubject)) > 0 then
               MyTable.FieldByName('EmailSubject').AsString := ASubject;
            if Length(Trim(ABody)) > 0 then
               MyTable.FieldByName('EmailBody').AsString := ABody;
            MyTable.Post;

            Result := True;
         end;
   except
   end;
   finally
      MyTable.Free;
   end;
end;

function TAccsDataModule.UpdateTemplate(const ATemplateName,
   ASubject, ABody : string) : Boolean;
var
   MyTable : TTable;
begin
   Result := False;
   try
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            TableName := 'EmailTemplates';
            if not Exists then Exit;

            MyTable.Active := True;

            if (MyTable.Locate('TemplateName', ATemplateName, [loCaseInsensitive])) then
               begin
                  MyTable.Edit;
                  MyTable.FieldByName('EmailSubject').AsString := ASubject;
                  MyTable.FieldByName('EmailBody').AsString := ABody;
                  MyTable.Post;

                  DbiSaveChanges(MyTable.Handle);

                  Result := True;
               end;
         end;
   except

   end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.GetTemplate(const ATemplateName: string;
  var ASubject, ABody: string);
var
   MyTable : TTable;
begin
   ASubject := '';
   ABody := '';

   if Length(Trim(ATemplateName)) = 0 then Exit;

   try
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            TableName := 'EmailTemplates';
            if not Exists then Exit;

            MyTable.Active := True;

            if (MyTable.Locate('TemplateName', ATemplateName, [loCaseInsensitive])) then
               begin
                  ASubject := MyTable.FieldByName('EmailSubject').AsString;
                  ABody := MyTable.FieldByName('EmailBody').AsString;
               end;
         end;
   except
   end;
   finally
      MyTable.Free;
   end;
end;

function TAccsDataModule.GetTemplateNames: TDynamicStringArray;
var
   MyTable : TTable;
   i : Integer;
begin
   SetLength(Result, 0);
   try
      try
         i := 0;
         MyTable := TTable.Create(nil);
         MyTable.DatabaseName := AccsDataBase.DatabaseName;
         with MyTable do
            begin
               TableName := 'EmailTemplates';
               if not Exists then Exit;
               MyTable.Active := True;
               SetLength(Result, MyTable.RecordCount);
               while not MyTable.eof do
                  begin
                     Result[i] := MyTable.FieldByName('TemplateName').AsString;
                     MyTable.Next;
                     Inc(i);
                  end;
            end;
      except
      end;
   finally
      MyTable.Free;
   end;
end;

function TAccsDataModule.GetMailboxExists: Boolean;
begin
   Result := False;
   Result := FileExists(IncludeTrailingBackslash(CurrentDatabasePath)+'mailbox.config');
end;

procedure TAccsDataModule.UpdateBankCSVDefaultsTable;
begin
   UpdateTable.TableName := 'BankCSVDefaults';
   if ( not(FieldExists('ExtraDetailField1No')) ) then
      try
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD ExtraDetailField1No INTEGER';
         AddFieldsQuery.ExecSQL;

         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'UPDATE '+UpdateTable.TableName+' SET ExtraDetailField1No = 0';
         AddFieldsQuery.ExecSQL;

         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD ExtraDetailField2No INTEGER';
         AddFieldsQuery.ExecSQL;

         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'UPDATE '+UpdateTable.TableName+' SET ExtraDetailField2No = 0';
         AddFieldsQuery.ExecSQL;
      except
         on e : exception do
            DbSchemeError(e, UpdateTable.TableName, 'ExtraDetailField1No');
      end;

   //   23/12/19 [V4.5 R1.6] /MK Change - Added new fields for new components on uBankCSVConfig.
   if ( not(FieldExists('AllowDebCredIndicCol')) ) then
      try
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD AllowDebCredIndicCol BOOLEAN';
         AddFieldsQuery.ExecSQL;

         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'UPDATE '+UpdateTable.TableName+' SET AllowDebCredIndicCol = False';
         AddFieldsQuery.ExecSQL;

         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD DebCredIndicCol INTEGER';
         AddFieldsQuery.ExecSQL;

         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Text := 'UPDATE '+UpdateTable.TableName+' SET DebCredIndicCol = 0';
         AddFieldsQuery.ExecSQL;
      except
         on e : exception do
            DbSchemeError(e, UpdateTable.TableName, 'AllowDebCredIndicCol');
      end;
end;

procedure TAccsDataModule.CreateBankImportNLMatch;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            TableName := 'BankImportNLStore';

            //   11/11/19 [V4.5 R1.0] /MK Bug Fix - Add fields to BankImportNLStore if it exists already.
            if Exists then
               begin
                  UpdateBankImportNLMatch;
                  Exit;
               end;

            FieldDefs.Clear;
            IndexDefs.Clear;

            with FieldDefs do
               begin
                  Add('Id',ftAutoInc);
                  Add('Description',ftString,255);
                  Add('NLNo',ftInteger);
                  Add('TxTypeDesc',ftString,30);
                  Add('CustSuppNo',ftInteger);
                  Add('CustSuppDesc',ftString,30);
               end;

            IndexDefs.Add('iId','Id',[ixPrimary, ixUnique]);
            IndexDefs.Add('iDescription','Description',[ixUnique, ixCaseInsensitive]);
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.StoreNLAndDescription(const ANLNo, ACustSuppNo : Integer; const ATransactionDesc, ATxType, ACustSuppDesc: string);
var
   iExistNLNo : Integer;
   BankLinkInfo : TStoredBankLinkInfo;
begin
   if ( Length(ATransactionDesc) = 0 ) then Exit;
   if ( UpperCase(ATransactionDesc) = 'CHEQUE' ) or ( UpperCase(ATransactionDesc) = 'CHQ' ) then Exit;

   BankLinkInfo := GetStoredBankLinkInfo(ATransactionDesc);
   try
      if ( BankLinkInfo.NominalID > 0 ) or ( BankLinkInfo.CustSuppNo > 0 ) then
         begin
            with TQuery.Create(nil) do
               try
                  DatabaseName := AccsDataBase.DatabaseName;
                  SQL.Clear;
                  SQL.Add('UPDATE BankImportNLStore');
                  SQL.Add('SET NLNo = :NLNo, TxTypeDesc = :TxType, CustSuppNo = :CustSuppNo, CustSuppDesc = :CustSuppDesc');
                  SQL.Add('WHERE Description = :TransDesc');
                  Params[0].AsInteger := ANLNo;
                  Params[1].AsString := ATxType;
                  Params[2].AsInteger := ACustSuppNo;
                  Params[3].AsString := ACustSuppDesc;
                  Params[4].AsString := ATransactionDesc;
                  try
                     ExecSQL;
                  except
                     on e : Exception do
                        ShowMessage(e.Message);
                  end;
               finally
                  Free;
               end;
         end
      else
         begin
            with TQuery.Create(nil) do
               try
                  DatabaseName := AccsDataBase.DatabaseName;
                  SQL.Clear;
                  SQL.Add('INSERT INTO BankImportNLStore (Description, NLNo, TxTypeDesc, CustSuppNo, CustSuppDesc)');
                  SQL.Add('VALUES (:TransactionDesc, :NLNo, :TxType, :CustSuppNo, :CustSuppDesc)');
                  Params[0].AsString := ATransactionDesc;
                  Params[1].AsInteger := ANLNo;
                  Params[2].AsString := ATxType;
                  Params[3].AsInteger := ACustSuppNo;
                  Params[4].AsString := ACustSuppDesc;
                  ExecSQL;
               finally
                  Free;
               end;
         end;
   finally
      if ( BankLinkInfo <> nil ) then
        FreeAndNil(BankLinkInfo);
   end;
end;

function TAccsDataModule.GetNLNoForBankImportDesc(const ADescription: string): Integer;
begin
   Result := 0;
   if ( Length(ADescription) = 0 ) then Exit;
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT NLNo FROM BankImportNLStore WHERE (Description = :TransDesc)');
         Params[0].AsString := ADescription;
         Open;
         try
            try
               Result := Fields[0].AsInteger;
            except
               on e : Exception do
                  ShowMessage(e.Message);
            end;
         finally
            Close;
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.UpdateCustomerName(ACustomerId: Integer;
  ACustomerName: string);
var
   AccountName : string;
begin
   if ( Length(ACustomerName) = 0 ) then Exit;

   AccountName := GetAccountName(SLFile, ACustomerId, 1);
   if AnsiCompareStr(AccountName, ACustomerName) <> 0 then
      begin
         AccsDataBase.TransIsolation :=  tiDirtyRead;
         try
         if (AccsDataBase.InTransaction) then
            AccsDataBase.Rollback;

         AccsDataBase.StartTransaction;
         with TQuery.Create(nil) do
            try
               DatabaseName := AccsDataBase.DatabaseName;
               try
                  SQL.Clear;
                  SQL.Add('UPDATE SLFile SET Formerly = Name WHERE (SLNo = :ASLNo)');
                  Params[0].AsInteger := ACustomerId;
                  ExecSQL;

                  SQL.Clear;
                  SQL.Add('UPDATE SLFile SET Name = :AName WHERE (SLNo = :SLNo)');
                  Params[0].AsString := ACustomerName;
                  Params[1].AsInteger := ACustomerId;
                  ExecSQL;

                  AccsDataBase.Commit;

                  SLFileDB.Close;
                  SLFileDB.Open;

                  PostMessage(FindWindow(PChar('TCashBookForm'), PChar('Job Cards')), WM_CUSTOMER_NAME_CHANGED,0,0);

               except
                  AccsDataBase.Rollback;
               end;
            finally
               Free;
            end;
         finally
            AccsDataBase.TransIsolation :=  tiReadCommitted;
         end;
      end;
end;

function TAccsDataModule.GetRegAccsVerNo: Integer;
var
   Reg : TRegistry;
begin
   Result := 0;
   Reg := TRegistry.Create();
   try
      try
         Reg.RootKey := HKEY_USERS;
         Reg.OpenKey('.DEFAULT\Software\Kingswood\Kingsacc', True);
         if ( Reg.ValueExists('VerNo') ) then
            Result := StrToInt(Reg.ReadString('VerNo'));
      except
      end;
   finally
      if ( Reg <> nil ) then
         begin
            Reg.CloseKey;
            Reg.Free;
         end;
   end;
end;

procedure TAccsDataModule.SetRegAccsVerNo(const Value: Integer);
var
   Reg : TRegistry;
begin
   Reg := TRegistry.Create();
   try
      try
         Reg.RootKey := HKEY_USERS;
         Reg.OpenKey('.DEFAULT\Software\Kingswood\Kingsacc', True);
         Reg.WriteString('VerNo',IntToStr(Value));
      except
      end;
   finally
      if ( Reg <> nil ) then
         begin
            Reg.CloseKey;
            Reg.Free;
         end;
   end;
end;

function TAccsDataModule.GetRegAccsModules: String;
var
   Reg : TRegistry;
begin
   Reg := TRegistry.Create();
   try
      try
         Reg.RootKey := HKEY_USERS;
         Reg.OpenKey('.DEFAULT\Software\Kingswood\Kingsacc', True);
         if ( Reg.ValueExists('Modules') ) then
            Result := Reg.ReadString('Modules');
      except
      end;
   finally
      if ( Reg <> nil ) then
         begin
            Reg.CloseKey;
            Reg.Free;
         end;
   end;
end;

procedure TAccsDataModule.SetRegAccsModules(const Value: String);
var
   Reg : TRegistry;
begin
   Reg := TRegistry.Create();
   try
      try
         Reg.RootKey := HKEY_USERS;
         Reg.OpenKey('.DEFAULT\Software\Kingswood\Kingsacc', True);
         Reg.WriteString('Modules',Value);
      except
      end;
   finally
      if ( Reg <> nil ) then
         begin
            Reg.CloseKey;
            Reg.Free;
         end;
   end;
end;

function TAccsDataModule.GetFinancialYearToStr: String;
begin
   Result := GetMonthShortNameFromMonthIndex(Cash1.XFINMONTH) + ' ' + IntToStr(Cash1.XFinYear);
end;

function TAccsDataModule.GetNomProdRelationship: String;
begin
   with TQuery.Create(nil) do
      try
         try
            DatabaseName := AccsDataBase.AliasName;
            SQL.Add('SELECT NomProdRelationship FROM AccsDefaults ');
            Open;
            First;
            Result := Fields[0].AsString;
         except
            Result := 'Unknown';
         end;
      finally
         Free;
      end;
end;

// Ch006 - new tables to support Digital VAT

procedure TAccsDataModule.CreateVATReturnTable;
var
   MyTable : TTable;
   HasRecords: Boolean;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            TableName := 'VATReturn';
            if Exists then
               begin
                  Active := True;
                  // An early version of VATReturn table was released without the field TransactionId.
                  // Code below attempts to detect the existence of TransactionId. If found, exit early,
                  // otherwise, attempt to delete and recreate table.
                  if (FindField('TransactionId')=nil) then // old style table, delete and allow recreate
                     begin
                        Active := False;
                        DeleteTable;
                     end
                  else
                     begin
                        Active := False;
                        Exit; // table exists and has the expected field definition
                     end;
               end;
            FieldDefs.Clear;
            IndexDefs.Clear;
            with FieldDefs do
               begin
                  Add('ReturnID',ftAutoInc,0,FALSE);
                  Add('UKReturn',ftboolean,0,false);
                  Add('FinYear',ftstring,4,false);
                  Add('ReturnStartDate',ftdatetime,0,false);
                  Add('ReturnEndDate',ftdatetime,0,false);
                  Add('DisplayString',ftstring,23,false);
                  Add('TransactionId',ftstring,40,false);

                  Add('IRLReturn',ftboolean,0,false);
                  Add('ReturnDate',ftdatetime,0,false);

                  Add('Box1',ftfloat,0,false);
                  Add('Box2',ftfloat,0,false);
                  Add('Box3',ftfloat,0,false);
                  Add('Box4',ftfloat,0,false);
                  Add('Box5',ftfloat,0,false);
                  Add('Box6',ftfloat,0,false);
                  Add('Box7',ftfloat,0,false);
                  Add('Box8',ftfloat,0,false);
                  Add('Box9',ftfloat,0,false);
                  
                  Add('SubmissionDate',ftdatetime,0,false);
                  Add('SubmissionComplete',ftboolean,0,false);
                  Add('SubmissionReference',ftstring,256,false);

                  // 11/03/2019 - SP
                  Add('HMRCProcessingTimeStamp',ftString,40);
                  Add('HMRCPaymentIndicator',ftString,12);
                  Add('HMRCBundleNumber',ftString,40);

                  Add('SubmitAttempted',ftBoolean);
                  Add('SubmitAttemptDate',ftDateTime);


                end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;


procedure TAccsDataModule.CreateVATArchiveTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'VATArchive';
            with FieldDefs do
               begin

                  Add('RecID',ftAutoInc,0,FALSE);
                  Add('Label',ftString,255,FALSE);
                  Add('Record',ftInteger,0,FALSE);
                  Add('TxDate',ftDate,0,FALSE);
                  Add('Account',ftString,50,FALSE);
                  Add('Reference',ftString,50,FALSE);
                  Add('Amount',ftfloat,0,FALSE);
                  Add('VAT',ftfloat,0,FALSE);
                  Add('VATCode',ftString,1,FALSE);
                  Add('Description',ftString,50,FALSE);
                  Add('AmountText',ftstring,20,FALSE);
                  Add('VATText',ftstring,20,FALSE);
                  Add('TxID',ftinteger,0,False);
                  Add('PreviousYear',ftstring,1,FALSE);
                  Add('VATBreakdown',ftstring,15,FALSE);
                  Add('TotalBreakdown',ftstring,15,FALSE);
                  Add('CodeBreakdown',ftstring,1,FALSE);
                  Add('DescBreakdown',ftstring,30,FALSE);
                  Add('VATID',ftinteger,0,False);

               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.CreateVATTotalsArchiveTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'VATTotalsArchive';
            with FieldDefs do
               begin

                  Add('ReturnID',ftInteger,0,False);
                  Add('VATCode',ftstring,1,FALSE);
                  Add('VATRate',ftstring,15,FALSE);
                  Add('SalesNetAmount',ftfloat,0,FALSE);
                  Add('SalesVATAmount',ftfloat,0,FALSE);
                  Add('PurchNetAmount',ftfloat,0,FALSE);
                  Add('PurchVATAmount',ftfloat,0,FALSE);

               end;
            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

// end Ch006

function TAccsDataModule.GetAPISecret: string;
begin
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.AliasName;
         SQL.Clear;
         SQL.Add('SELECT APISecret FROM DatabaseDefaults');
         Open;
         try
            First;
            Result := Lowercase(Fields[0].AsString);
         finally
            Close;
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.SetAPISecret(const Value: string);
begin
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.AliasName;
         SQL.Clear;
         SQL.Add('UPDATE DatabaseDefaults SET APISecret =:Value ');
         Params[0].AsString := Lowercase(Value);
         try
            ExecSQL;
         except
         end;
      finally
         Free;
      end;
end;

function TAccsDataModule.IsVATProcessed(
  ATxEdit: TxEditType): Boolean;
begin
   with TQuery.create(nil) do
      try
         DatabaseName := accsdatamodule.AccsDataBase.databasename;
         SQL.Add('SELECT * FROM Transactions WHERE VATProcessed = ''True'' AND TxNo >= ' + VarToStr(ATxEdit.TransF) + ' and TxNo <= ' + VarToStr(ATxEdit.TransT));
         Open;

         Result := RecordCount>0;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.CreateHMRCReceiptTable;
var
   MyTable : TTable;
begin
   try
      MyTable := TTable.Create(nil);
      MyTable.DatabaseName := AccsDataBase.DatabaseName;
      with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'HMRCReceipts';
            with FieldDefs do
               begin
                  Clear;
                  Add('TransactionId',ftString,40,FALSE);
                  Add('Result',ftString,12,false);
                  Add('Receipt',ftMemo);
                  Add('CreatedOn',ftDateTime);
               end;
            IndexDefs.Clear;
            IndexDefs.Add('','TransactionId',[ixPrimary, ixUnique]);

            CreateTable;
         end;
   finally
      MyTable.Free;
   end;
end;

procedure TAccsDataModule.StoreHMRCReceipt(const AReceipt: string;
   const ATransactionId: string; const AReceiptProcessed: Boolean);
var
   Result : string;
begin
   if AReceiptProcessed then
      Result := 'Success'
   else
      Result := 'Error';
   with TTable.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         TableName := 'HMRCReceipts';
         Active := True;

         Append;
         try
            FieldByName('TransactionId').AsString := ATransactionId;
            FieldByName('Result').AsString := Result;
            FieldByName('Receipt').AsString := AReceipt;
            FieldByName('CreatedOn').AsDateTime := now();
            Post;
         except
            Cancel;
         end;
         DbiSaveChanges(Handle);
      finally
         Free;
      end;
end;

function TAccsDataModule.RetrieveHMRCReceipt(
  const ATransactionId: string): string;
begin
   with TQuery.create(nil) do
      try
         DatabaseName := accsdatamodule.AccsDataBase.databasename;
         SQL.Add('SELECT Receipt FROM HMRCReceipts WHERE TransactionId = :TransactionId');
         Params[0].AsString := ATransactionId;
         Open;

         Result := Fields[0].AsString;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.AddToImportedJobCards(const AJobCardId: Integer);
var
   XDoc : IXMLDOMDocument;
   XRootNode,
   XJobNode,
   XChildNode : IXMLDOMNode;
   FileName : string;
begin
   if (AJobCardId <= 0) then Exit;
   
   Screen.Cursor := crHourGlass;
   try
      FileName := IncludeTrailingBackslash(AccsDataModule.CurrentDatabasePath) + 'JobCards_Imported.xml';
      XDoc := CreateOleObject('MSXML2.DOMDocument') as IXMLDOMDocument;
      if (not FileExists(FileName)) then
         begin
            XDoc.appendChild(XDoc.createProcessingInstruction('xml', 'version="1.0" encoding="UTF-8"'));

            XRootNode := XDoc.createElement('jobCards');
            XDoc.appendChild(XRootNode);
         end
      else
         begin
            XDoc.load(FileName);
            XRootNode := XDoc.selectSingleNode('jobCards');
         end;

       XJobNode := XDoc.createElement('jobCard');

       XChildNode := XDoc.createElement('jobCardId');
       XChildNode.Set_text(IntToStr(AJobCardId));

       XJobNode.appendChild(XChildNode);

       XRootNode.appendChild(XJobNode);

       XDoc.save(FileName);
   finally
      XDoc := nil;
      XRootNode := nil;
      XChildNode := nil;
      Screen.Cursor := crDefault;
   end;

end;

function TAccsDataModule.DigitalVATReturnCompleted: Boolean;
begin
   Result := False;
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT COUNT(TransactionId)');
         SQL.Add('FROM VATReturn');
         SQL.Add('WHERE TransactionId IS NOT NULL');
         Open;
         Result := Fields[0].AsInteger>0;
      finally
         Free;
      end;
end;

function TAccsDataModule.GetNextTxNo: Integer;
begin
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT Max(TxNo)');
         SQL.Add('FROM Transactions');
         try
            Open;
            Result := Fields[0].AsInteger + 1;
         except
            on e : Exception do
               ShowDebugMessage(e.Message);
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.UpdateBankImportNLMatch;
begin
   UpdateTable.TableName := 'BankImportNLStore';
   if ( not(FieldExists('TxTypeDesc')) ) then
      begin
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Add('ALTER TABLE '+UpdateTable.TableName+ ' ADD TxTypeDesc CHAR(30)');
         AddFieldsQuery.ExecSQL;
      end;
   if ( not(FieldExists('CustSuppNo')) ) then
      begin
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Add('ALTER TABLE '+UpdateTable.TableName+ ' ADD CustSuppNo INTEGER');
         AddFieldsQuery.ExecSQL;
      end;
   if ( not(FieldExists('CustSuppDesc')) ) then
      begin
         AddFieldsQuery.SQL.Clear;
         AddFieldsQuery.SQL.Add('ALTER TABLE '+UpdateTable.TableName+ ' ADD CustSuppDesc CHAR(30)');
         AddFieldsQuery.ExecSQL;
      end;
end;

function TAccsDataModule.GetStoredBankLinkInfo(ABankDesc: String): TStoredBankLinkInfo;
begin
   Result := nil;
   if ( Length(ABankDesc) = 0 ) then Exit;
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT NLNo, TxTypeDesc, CustSuppDesc, CustSuppNo');
         SQL.Add('FROM BankImportNLStore');
         SQL.Add('WHERE (Description = :TransDesc)');
         Params[0].AsString := ABankDesc;
         Open;
         try
            try
               Result := TStoredBankLinkInfo.Create();
               Result.NominalID := Fields[0].AsInteger;
               Result.TxTypeDesc := Fields[1].AsString;
               Result.CustSupDesc := Fields[2].AsString;
               Result.CustSuppNo := Fields[3].AsInteger;
            except
               on e : Exception do
                  ShowMessage(e.Message);
            end;
         finally
            Close;
         end;
      finally
         Free;
      end;
end;

// SP 26/09/19 Returns the submission date of last VAT return if the Bundke Number is empty.
function TAccsDataModule.GetLastVATReturnInfo: TVATReturnInfo;
begin
   Result.IsPending := False;
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT ReturnID, DisplayString, SubmitAttemptDate');
         SQL.Add('FROM VATReturn');
         SQL.Add('WHERE ((HMRCBundleNumber IS NULL) OR (TRIM(HMRCBundleNumber) = '''')) AND (SubmitAttempted = True)');
         SQL.Add('ORDER BY ReturnID Desc');
         try
            Open;
            if (RecordCount>0) then
               begin
                  First;
                  Result.IsPending := True;
                  Result.Period := FieldByName('DisplayString').AsString;
               end;
         except
            on e : Exception do
               ShowDebugMessage(e.Message);
         end;
      finally
         Free;
      end;
end;


procedure TAccsDataModule.UpdateVATReturnTable;
var
   FieldName : string;
begin
   UpdateTable.TableName := 'VATReturn';

   FieldName := 'SubmitAttempted';
   if (not(FieldExists(FieldName))) then
      try
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD '+ FieldName + ' Boolean';
         AddFieldsQuery.ExecSQL;

         AddFieldsQuery.SQL.Text := 'UPDATE '+UpdateTable.TableName+' SET '+ FieldName +' = True WHERE (HMRCBundleNumber IS NOT NULL)';
         AddFieldsQuery.ExecSQL;
      except
         on e : exception do
            DbSchemeError(e, UpdateTable.TableName, FieldName);
      end;

   FieldName := 'SubmitAttemptDate';
   if (not(FieldExists(FieldName))) then
      try
         AddFieldsQuery.SQL.Text := 'ALTER TABLE '+UpdateTable.TableName+' ADD '+ FieldName + ' Date';
         AddFieldsQuery.ExecSQL;

         AddFieldsQuery.SQL.Text := 'UPDATE '+UpdateTable.TableName+' SET '+ FieldName +' = SubmissionDate WHERE SubmitAttempted = True';
         AddFieldsQuery.ExecSQL;
      except
         on e : exception do
            DbSchemeError(e, UpdateTable.TableName, FieldName);
      end;
end;

function TAccsDataModule.GetAccsDefaultsLastBackupDate: TDateTime;
begin
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT LastBackup');
         SQL.Add('FROM AccsDefaults');
         try
            Open;
            if ( RecordCount > 0 ) then
               Result := Fields[0].AsDateTime;
         except
            on e : Exception do
               ShowDebugMessage(e.Message);
         end;
      finally
         Free;
      end;
end;

function TAccsDataModule.GetAccsDefaultsLastUpdateDate: TDateTime;
begin
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT LastVerUpdate');
         SQL.Add('FROM AccsDefaults');
         try
            Open;
            if ( RecordCount > 0 ) then
               Result := Fields[0].AsDateTime;
         except
            on e : Exception do
               ShowDebugMessage(e.Message);
         end;
      finally
         Free;
      end;
end;

function TAccsDataModule.GetAccsDefaultsUpdateNo: Integer;
begin
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT UpdateNo');
         SQL.Add('FROM AccsDefaults');
         try
            Open;
            if ( RecordCount > 0 ) then
               Result := Fields[0].AsInteger;
         except
            on e : Exception do
               ShowDebugMessage(e.Message);
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.SetAccsDefaultsLastBackupDate(const Value: TDateTime);
begin
   if ( Value = 0 ) then Exit;
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('UPDATE AccsDefaults');
         SQL.Add('SET LastBackup = :LastBackup');
         try
            Params[0].AsDateTime := Value;
            ExecSQL;
         except
            on e : Exception do
               ShowDebugMessage(e.Message);
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.SetAccsDefaultsLastUpdateDate(const Value: TDateTime);
begin
   if ( Value = 0 ) then Exit;
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('UPDATE AccsDefaults');
         SQL.Add('SET LastVerUpdate = :LastVerUpdate');
         try
            Params[0].AsDateTime := Value;
            ExecSQL;
         except
            on e : Exception do
               ShowDebugMessage(e.Message);
         end;
      finally
         Free;
      end;
end;

function TAccsDataModule.GetAccsDefaultsMaintPromptDate: TDateTime;
begin
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT UpdateNo');
         SQL.Add('FROM MaintPromptDate');
         try
            Open;
            if ( RecordCount > 0 ) then
               Result := Fields[0].AsDateTime;
         except
            on e : Exception do
               ShowDebugMessage(e.Message);
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.SetAccsDefaultsMaintPromptDate(const Value: TDateTime);
begin
   if ( Value = 0 ) then Exit;
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('UPDATE AccsDefaults');
         SQL.Add('SET MaintPromptDate = :MaintPromptDate');
         try
            Params[0].AsDateTime := Value;
            ExecSQL;
         except
            on e : Exception do
               ShowDebugMessage(e.Message);
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.SetAccsDefaultsUpdateNo(const Value: Integer);
begin
   if ( Value = 0 ) then Exit;
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('UPDATE AccsDefaults');
         SQL.Add('SET UpdateNo = :UpdateNo');
         try
            Params[0].AsInteger := Value;
            ExecSQL;
         except
            on e : Exception do
               ShowDebugMessage(e.Message);
         end;
      finally
         Free;
      end;
end;

procedure TAccsDataModule.CheckNewVersionAvailable;
var
   v1, v2, v3, v4: Word;
begin
   if ( FileExists(ApplicationPath + 'KInstaller.exe') ) then
      begin
         GetApplicationBuildInfo(ApplicationPath + 'KInstaller.exe', v1, v2, v3,v4);
         // silent check for new version included in V1.9
         if ( v1 <> 1 ) or (( v1 = 1) and ( V2 >= 9 )) then
            begin
               FProgramUpdateAvailableThread := TProgramUpdateAvailable.Create(True);
               FProgramUpdateAvailableThread.AppName := 'Kingswood Accounts';
               FProgramUpdateAvailableThread.AppVersion := StrToInt(ShortVerNo);
               FProgramUpdateAvailableThread.Resume;
            end;
      end;
end;

procedure TAccsDataModule.CheckMaintenanceWithKinstaller;
var
   v1, v2, v3, v4: Word;
begin
   if ( FileExists(ApplicationPath + 'KInstaller.exe') ) then
      begin
         GetApplicationBuildInfo(ApplicationPath + 'KInstaller.exe', v1, v2, v3,v4);
         // silent check for maintenance included in V1.9
         if ( v1 <> 1 ) or (( v1 = 1) and ( V2 >= 9 )) and (IsNetConnected) then
            begin
               FProgramMaintenanceCheckThread := TProgramMaintenanceCheckThread.Create(PSysLongToDelphi(Cash11.serial_no),True);
               FProgramMaintenanceCheckThread.Resume;
            end;
      end;
end;

procedure TAccsDataModule.AllocatedVATDBAfterPost(DataSet: TDataSet);       //Ch026
begin
        DbiSaveChanges(AllocatedVATDB.Handle);
end;

procedure TAccsDataModule.VATTotalsArchiveDBAfterPost(DataSet: TDataSet);   //Ch026
begin
        DbiSaveChanges(VATTotalsArchiveDB.Handle);
end;

procedure TAccsDataModule.VATReturnDBAfterPost(DataSet: TDataSet);          //Ch026
begin
        DbiSaveChanges(VATReturnDB.Handle);
end;

procedure TAccsDataModule.VATArchiveDBAfterPost(DataSet: TDataSet);         //Ch026
begin
        DbiSaveChanges(VATArchiveDB.Handle);
end;

procedure TAccsDataModule.DefaultsDBAfterPost(DataSet: TDataSet);           //Ch026
begin
        DbiSaveChanges(DefaultsDB.Handle);
end;

procedure TAccsDataModule.GroupsDBAfterPost(DataSet: TDataSet);             //Ch026
begin
        DbiSaveChanges(GroupsDB.Handle);
end;

procedure TAccsDataModule.AccsDefaultsAfterPost(DataSet: TDataSet);         //Ch026
begin
        DbiSaveChanges(AccsDefaults.Handle);
end;

function TAccsDataModule.GetFarmgateSerialNo: Integer;
begin
   Result := PSysLongToDelphi ( RFarmGate.PSerial );
end;

function TAccsDataModule.ReconcileLastMTDSubmission(
  const APeriodStart, APeriodEnd: TDateTime; const AVATReturn: TMTDVATReturn) : TMTDReconcile;
var
   Api: TMTDApi;
   Credentials: TLoginCredentials;
   Receipts: TMTDVATReceipts;
   Receipt: TMTDVATReceipt;
   i : Integer;
   VatReturnChanged: Boolean;
   PeriodStart: TDateTime;
   PeriodEnd: TDateTime;
   ErrorMessage: string;
   ClientVatNumber: string;
begin
  Receipt := nil;
  SetLength(Receipts, 0);
  VatReturnChanged := False;
  VATReturnDB.close();
   try
      //Credentials := TLoginCredentials.create('254312584','s6f6a6n3');
      Credentials := TCredentialsStore.Load(AccsDataModule.MTDCredentialStorePath);
      if ( Credentials = nil ) then
         begin
            Result.Result := crLoginCredentialMissing;
            Result.DialogMessage := 'Your Kingswood MTD Login credentials have not been entered - contact TGM.';
            Result.DialogType := mtWarning;
            Exit;
         end;

      try
         Api := TMTDApi.create(Credentials,AccsDataModule.MTDConfig);
         if (MTDConfig.IsAgent) then
            begin
               // Ensure we download the VAT number were not already present in database
               if (ClientVRN='') then
                  begin
                      ClientVatNumber := Api.GetClientVRN(AccsDataModule.APISecret);
                      if (ClientVatNumber='') then
                         begin
                            MessageDlg('VAT return exiting early, unable to download your client details - contact Kingswood.', mtError, [mbOK], 0);
                            Exit;
                         end;
                      ClientVRN := ClientVatNumber;
                  end;
            end;

         Receipts := Api.GetReceipts(ClientVRN);
         if (Api.LastError<>'') then
            begin
               Result.Result := srError;
               result.DialogMessage := Api.LastError;
               Result.DialogType := mtError;

               Exit;
            end;
      finally
         FreeAndNil(Api);
         FreeAndNil(Credentials);
      end;

      if (Receipts = nil) or (Length(Receipts) = 0) then
         begin
            Result.Result := srUnavailable;
            Exit;
         end;

      // Get a match on receipts by comparing the periodStart & periodEnd
      for i := 0 to Length(Receipts)-1 do
         begin
            PeriodStart := ServerDateToDateTime(Receipts[i].PeriodStart);
            PeriodEnd := ServerDateToDateTime(Receipts[i].PeriodEnd);

           // ShowMessage(Receipts[i].ProcessingDate);
           if (PeriodStart  = APeriodStart) and
              (PeriodEnd = APeriodEnd) then
           begin
              Receipt := Receipts[i];
              break;
           end;
         end;

      if (Receipt = nil) then
         begin
            Result.Result := srNotSubmitted;
            Exit;
         end;

      // Do the submitted figures correlate with arg AVATReturn
      VatReturnChanged :=
         not((Receipt.VATReturn.VATDueSales = AVATReturn.VATDueSales) and
         (Receipt.VATReturn.VATDueAcquisitions = AVATReturn.VATDueAcquisitions) and
         (Receipt.VATReturn.TotalVATDue = AVATReturn.TotalVATDue) and
         (Receipt.VATReturn.VATReclaimedCurrPeriod = AVATReturn.VATReclaimedCurrPeriod) and
         (Receipt.VATReturn.NetVATDue = AVATReturn.NetVATDue) and
         (Receipt.VATReturn.TotalValueSalesExVAT = AVATReturn.TotalValueSalesExVAT) and
         (Receipt.VATReturn.TotalValuePurchasesExVAT = AVATReturn.TotalValuePurchasesExVAT) and
         (Receipt.VATReturn.TotalValueGoodsSuppliedExVAT = AVATReturn.TotalValueGoodsSuppliedExVAT) and
         (Receipt.VATReturn.TotalAcquisitionsExVAT = AVATReturn.TotalAcquisitionsExVAT));
       if VatReturnChanged then
         begin
            Result.Result := srReturnChanged;
            Result.DialogMessage := 'There is a discrepancy between the figures previously submitted ' +cCRLF +
                        'to HMRC for this period and the figures currently being submitted - contact TGM.';
            Result.DialogType := mtError;
            Exit;
         end;

       // this match confirms that no transactions have been created/modified for specified period.
       // We are clear to reconcile
       with TQuery.Create(nil) do
         try
           DatabaseName := AccsDataBase.DatabaseName;
           SQL.Clear;
           SQL.Add('SELECT * FROM VATReturn');
           SQL.Add('WHERE (ReturnStartDate = :ReturnStartDate');
           SQL.Add('  AND ReturnEndDate = :ReturnEndDate)');

           Params[0].AsDateTime := PeriodStart;
           Params[1].AsDateTime := PeriodEnd;
           Open;
           if (IsEmpty) then
              begin
                 Result.Result := srNotOnFile;
                 Result.DialogMessage := 'VAT return information missing from database';
                 Result.DialogType := mtError;
                 Exit;
              end;
           if (RecordCount>1) then
              begin
                 Result.Result := srDuplicateOnFile;
                 Result.DialogMessage := 'Duplicate submission held on file - contact TGM.';
                 Result.DialogType := mtError;
                 Exit;
              end;
         finally
           Free;
         end;

      // ok we have a match
      with TQuery.Create(nil) do
        try
          DatabaseName := AccsDataBase.DatabaseName;
          SQL.Clear;
          SQL.Add('UPDATE VATReturn                    ');
          SQL.Add('SET TransactionId = :TransactionId, ');
          SQL.Add('    Box1 = :Box1,                   ');
          SQL.Add('    Box2 = :Box2,                   ');
          SQL.Add('    Box3 = :Box3,                   ');
          SQL.Add('    Box4 = :Box4,                   ');
          SQL.Add('    Box5 = :Box5,                   ');
          SQL.Add('    Box6 = :Box6,                   ');
          SQL.Add('    Box7 = :Box7,                   ');
          SQL.Add('    Box8 = :Box8,                   ');
          SQL.Add('    Box9 = :Box9,                   ');
          SQL.Add('    HMRCProcessingTimeStamp = :HMRCProcessingTimeStamp,');
          SQL.Add('    HMRCPaymentIndicator = :HMRCPaymentIndicator,      ');
          SQL.Add('    HMRCBundleNumber = :HMRCBundleNumber,              ');
          SQL.Add('    SubmissionDate = :SubmissionDate,                  ');
          SQL.Add('    SubmissionComplete = :SubmissionComplete,          ');
          SQL.Add('    SubmissionReference = :BundleNumber                ');
          SQL.Add('WHERE (ReturnStartDate = :ReturnStartDate              ');
          SQL.Add('AND   ReturnEndDate = :ReturnEndDate)                  ');

          Params[0].AsString := Receipt.TransactionId;
          Params[1].AsFloat := Receipt.VATReturn.VATDueSales;
          Params[2].AsFloat := Receipt.VATReturn.VATDueAcquisitions;
          Params[3].AsFloat := Receipt.VATReturn.TotalVATDue;
          Params[4].AsFloat := Receipt.VATReturn.VATReclaimedCurrPeriod;
          Params[5].AsFloat := Receipt.VATReturn.NetVATDue;
          Params[6].AsFloat := Receipt.VATReturn.TotalValueSalesExVAT;
          Params[7].AsFloat := Receipt.VATReturn.TotalValuePurchasesExVAT;
          Params[8].AsFloat := Receipt.VATReturn.TotalValueGoodsSuppliedExVAT;
          Params[9].AsFloat := Receipt.VATReturn.TotalAcquisitionsExVAT;
          Params[10].AsString := Receipt.ProcessingDate;
          Params[11].AsString := Receipt.PaymentIndicator;
          Params[12].AsString := Receipt.BundleNumber;
          Params[13].AsDateTime := StrToDate(Receipt.SubmissionDate);
          Params[14].AsBoolean := True;
          Params[15].Value := Receipt.BundleNumber;
          Params[16].AsDateTime := PeriodStart;
          Params[17].AsDateTime := PeriodEnd;
          try
             ExecSQL;
             Result.Result := srReconciled;
             Result.DialogMessage := 'A VAT return for this period was previously submitted to HMRC.'+cCRLFx2 +
                       'Click OK to finalise VAT Return in Kingswood Accounts.';
             Result.DialogType := mtInformation;
          except
             on e: Exception do
                begin
                   Result.Result := srReconcileFailed;
                   Result.DialogMessage := 'An internal error occurred while processing your VAT return - contact TGM.';
                   Result.DialogType := mtError;
                end;
          end;
        finally
          Free;
        end;
    finally
       VATReturnDB.open();
       for i := 0 to Length(Receipts)-1 do Receipts[i].Free;
         SetLength(Receipts, 0);
    end;
end;

function TAccsDataModule.MTDVATSubmissionReceiptPending(
   const APeriodStart, APeriodEnd: TDateTime): Boolean;
begin
   with TQuery.Create(nil) do
     try
       DatabaseName := AccsDataBase.DatabaseName;
       SQL.Clear;
       SQL.Add('SELECT * FROM VATReturn');
       SQL.Add('WHERE (SubmitAttempted = True) ');
       SQL.Add('AND   (HMRCBundleNumber IS NULL) ');
       SQL.Add('AND   ((ReturnStartDate = :ReturnStartDate');
       SQL.Add('  AND ReturnEndDate = :ReturnEndDate))');
       Params[0].AsDateTime := APeriodStart;
       Params[1].AsDateTime := APeriodEnd;
       Open;
       Result := RecordCount=1;
     finally
       Free;
     end;
end;

procedure TAccsDataModule.AllocatedVATDBYr1AfterPost(DataSet: TDataSet);    //Ch006(P)
begin
   DbiSaveChanges(AllocatedVATDBYr1.Handle);
end;

function TAccsDataModule.GetClientVRN: string;
begin
   with TQuery.Create(nil) do
   try
      DatabaseName := AccsDataBase.AliasName;
      SQL.Clear;
      SQL.Add('SELECT ClientVRN FROM DatabaseDefaults');
      Open;
      try
         First;
         Result := Lowercase(Fields[0].AsString);
      finally
         Close;
      end;
   finally
      Free;
   end;
end;

procedure TAccsDataModule.SetClientVRN(const Value: string);
begin
   with TQuery.Create(nil) do
   try
      DatabaseName := AccsDataBase.AliasName;
      SQL.Clear;
      SQL.Add('UPDATE DatabaseDefaults SET ClientVRN =:Value ');
      Params[0].AsString := UPPERCASE(Value);
      try
         ExecSQL;
      except
      end;
   finally
      Free;
   end;
end;

procedure TAccsDataModule.LoadMTDConfig;
   procedure Init();
   begin
      FMTDConfig.IsAgent := False;
      FMTDConfig.WebUrl := 'https://www.kingswoodfarm.ie/accounts/mtd';
      FMTDConfig.ApiUrl := FMTDConfig.WebUrl + '/api';
   end;
var
   sl: TStringList;
   FileName: string;
begin
   Init();

   FileName := ExtractFilePath(Application.ExeName) + 'mtd_params.txt';
   if not (FileExists(FileName)) then Exit;

   sl := TStringList.Create;
   try
      try
         sl.LoadFromFile(FileName);
         if (sl.IndexOfName('WEB_URL')>-1) then
           begin
              FMTDConfig.WebUrl := sl.Values['WEB_URL'];
              FMTDConfig.ApiUrl := FMTDConfig.WebUrl + '/api';
           end;
         FMTDConfig.IsAgent := (sl.IndexOfName('AGENT')>-1) and (Lowercase(sl.Values['AGENT']) = 'true');
      except
         Init();
      end;
   finally
      FreeAndNil(sl);
   end;
end;


function TAccsDataModule.PromptAndValidateMTDCredentials: Boolean;
var
   MTDCredentials: TLoginCredentials;
   MTDApi : TMTDApi;
   StorePath: string;
begin
   Result := False;

   StorePath := MTDCredentialStorePath;

   MTDCredentials := TfmLoginCredentials.Show(StorePath);
   if (MTDCredentials=nil) then Exit;
   Screen.Cursor := crHourGlass;
   MTDApi := TMTDApi.create(MTDCredentials,FMTDConfig);
   try                                          
      //   20/10/20 [V4.5 R4.4] /MK Bug Fix - Result of MTDApi.ValidateCredentials() was being returned as reverse.
      Result := ( MTDApi.ValidateCredentials() );
      if ( not(Result) ) then Exit;
      Result := TCredentialsStore.Save(MTDCredentials,StorePath);
   finally
      Screen.Cursor := crDefault;
      MTDApi.Free;
      MTDCredentials.Free;
   end;
end;

function TAccsDataModule.MTDCredentialStorePath: string;
begin
   Result := IfThenElse(FMTDConfig.IsAgent, ApplicationPath, DatabasePath);
end;

end.
