{
   12/09/11 [V4.1 R0.2] /MK Bug Fix - AllocateToInvoices - Added Check If AllocationTempDB Is Open - To Fix On Closed Dataset Error.

   17/01/12 [V4.1 R1.2] /MK Change - FormDeactivate - Old Dispose Pointers Code Not Setting TxHold/NomHold To Nil.

   28/04/14 [V4.1 R6.1] /MK Bug Fix - JobCardsClick, ProformaClic, QuoteClick - Hide Panel1 and then show Panel1 on Exit Task.

   01/05/14 [V4.1 R6.1] /MK Change - Andrew (TGM) Cashbook.dfm loaded into code as order of Andrew's dfm differs from
                                     our own dfm. Original Panel1.Hide or Panel1.Show code removed.

   24/11/14 [V4.1 R7.6] /MK Bug Fix - Check for SLPLDefaults in new uPrefences key not old key.

   20/11/15 - Minor Bug Fix on allocation grid where certain key presses didn't update total at bottom - AB

   19/06/15 & 12/06/15 - Implemented new auto-allocate function - AB.

   26/08/16 - New functionality to auto-fill enterprise code if the user only has 1 enterprise - AB.

   02/12/16 [V4.2 R4.5] /MK Bug Fix - CheckForSingleEnterprise - If a blank enterprise existed the program would give an invalid type conversion error.
                            Change - New functionality to bring up Extra Details Panel in non-invoicer systems to allow selection of product and hence default price - AB.

   04/01/17 [V4.2 R5.3] /SP Bug fix - Do not default to single enterprise if the user is using the job card app

   09/04/18 [V4.3 R0.6] /MK Change - AddJobToCard - If Product Description Line 2 has data and JobCardApp.Comment1 has data then make Detail Line 3 JobCardApp.Comment1.
                            Additional Feature - AddJobToCard - If Detail Line 3 does not have data then do check for JobCardApp.Comment2 same as JobCardApp.Comment1.

   31/07/18 [V4.3 R1.1] /MK Incorporated Changes from Andrew (TGM) - BankAccountExit - Check validation for Bank Account number.  

   19/10/18 [V4.3 R2.5] /MK Bug Fix - CheckForSingleEnterprise - Changed from SyncIsAvailable to SyncConfigured as everyone is getting the sync program but only
                                                                 those that have the JobCard would have the SyncConfigured.

   18/11/19 [V4.5 R1.1] /MK Bug Fix - LoadJobCardClick - Don't exit if CustomerId is not -1 as it can come from the TfmJobCardCustomerListing.

   06/03/20 [V4.5 R1.8] /MK Bug Fix - ProformaPanel - Set the top to zero as it was appearing over delete option - John Joe Murphy.

   03/08/20 [V4.5 R3.5?] /AB Bug Fix - Added check, prompts etc to stop users from deleting lines when editing a transaction (prompts when trying to save or also print an invoice)   
}

unit Cashbook;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Grids, StdCtrls, Buttons, ExtCtrls, Mask, quickrpt,
  Qrctrls, ComCtrls, Adgrad, DBCtrls, RXLookup, printers, Db, DBTables, Registry,
  ToolEdit, RXDBCtrl, types, DBGrids, Menus, uPreferences, uPreferenceConsts,
  cxButtons;

type
  TCashBookForm = class(TForm)
    BankNameLabel: TLabel;
    CustSuppCodeLabel: TLabel;
    CustSuppCode: TEdit;
    BankAccount: TEdit;
    BankAccountLabel: TLabel;
    SalesPurchaseGroup: TGroupBox;
    Invoice: TRadioButton;
    PaymentReceipt: TRadioButton;
    CashInvoice: TRadioButton;
    CreditNote: TRadioButton;
    CashBookGroup: TGroupBox;
    Income: TRadioButton;
    Expenditure: TRadioButton;
    CustSuppNameLabel: TLabel;
    CustSuppAdd1Label: TLabel;
    CustSuppAdd3Label: TLabel;
    CustSuppAdd2Label: TLabel;
    AgedPanel: TPanel;
    CurrBalLabel: TLabel;
    AgedCurrLabel: TLabel;
    Aged1Label: TLabel;
    Aged2Label: TLabel;
    Aged3Label: TLabel;
    CurrentBal: TEdit;
    AgedCurr: TEdit;
    Aged1: TEdit;
    Aged2: TEdit;
    Aged3: TEdit;
    DetailGrid: TStringGrid;
    BankBalance: TEdit;
    BankBalanceLabel: TLabel;
    StubNoLabel: TLabel;
    StubNo: TEdit;
    Comment: TEdit;
    CommentLabel: TLabel;
    ReferenceLabel: TLabel;
    Reference: TEdit;
    DateLabel: TLabel;
    DiscountLabel: TLabel;
    AmtReceivedLabel: TLabel;
    AmtReceived: TEdit;
    Discount: TEdit;
    PayRecPanel: TPanel;
    Panel1: TPanel;
    ListAccounts: TSpeedButton;
    CustSuppTrans: TPanel;
    CustSuppFrom: TEdit;
    CustSuppTo: TEdit;
    CustSuppAmount: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ToSalesRadio: TRadioButton;
    ToPurchaseRadio: TRadioButton;
    CustFromF2: TSpeedButton;
    CustToF2: TSpeedButton;
    TotalsPanel: TPanel;
    TotalLessVAT: TEdit;
    TotalVAT: TEdit;
    TotalAmt: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    F6Button: TBitBtn;
    TxDate: TMaskEdit;
    DateSearch: TDateTimePicker;
    BankListAcc: TSpeedButton;
    PromptLine: TStatusBar;
    ExitButton: TBitBtn;
    Save: TBitBtn;
    Help: TBitBtn;
    pCustSuppBals: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    eFromName: TEdit;
    eFromBal: TEdit;
    eToName: TEdit;
    eToBal: TEdit;
    pExtraDesc: TPanel;
    dbeDesc1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    cbProducts: TRxDBLookupCombo;
    Label12: TLabel;
    AdrockGradientFill1: TAdrockGradientFill;
    Query1: TQuery;
    EuroPanel: TPanel;
    TotalLessVATEuro: TEdit;
    TotalVATEuro: TEdit;
    TotalAMTEuro: TEdit;
    Query1BatchID: TIntegerField;
    VATPanel: TPanel;
    Changetaskspanel: TPanel;
    ChangeTask: TBitBtn;
    PrintInvoice: TBitBtn;
    JobCardPanel: TPanel;
    NewJobCard: TBitBtn;
    LoadJobCard: TBitBtn;
    SaveAsJobCard: TBitBtn;
    JobCardExit: TBitBtn;
    PrintasProforma: TBitBtn;
    PrintAsInvoice: TBitBtn;
    ProformaPanel: TPanel;
    BitBtn5: TBitBtn;
    ProformaExit: TBitBtn;
    NewProforma: TBitBtn;
    PrintProforma: TBitBtn;
    PrintProformaAsInvoice: TBitBtn;
    LoadProforma: TBitBtn;
    SaveasProforma: TBitBtn;
    Invoicing: TBitBtn;
    Proforma: TBitBtn;
    Jobcards: TBitBtn;
    Ledger: TBitBtn;
    reportsql: TQuery;
    ReportSQLds: TDataSource;
    ReportsPanel: TPanel;
    ReportsButton: TButton;
    AddRemoveProducts: TBitBtn;
    SelectCustomer: TBitBtn;
    DeleteProforma: TBitBtn;
    DeleteJobCard: TBitBtn;
    LineRef: TDBEdit;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Quote: TBitBtn;
    CustSuppAdd4Label: TLabel;
    CustSuppAreaCodeLabel: TLabel;
    CustSuppCommentLabel: TLabel;
    LineDatePicker: TDateTimePicker;
    LineDate: TDBEdit;
    meLineDate: TMaskEdit;
    InvoiceAllocationPanel: TPanel;
    AllocAmount: TEdit;
    Label15: TLabel;
    AllocDiscount: TEdit;
    Label16: TLabel;
    AllocationGrid: TDBGrid;
    BalancePanel: TPanel;
    Label17: TLabel;
    BalanceLabel: TLabel;
    Panel2: TPanel;
    ThisYearBtn: TBitBtn;
    UnallocatedBtn: TBitBtn;
    OpeningBalanceBtn: TBitBtn;
    IncludeLastYearCB: TCheckBox;
    OverpaymentsBtn: TBitBtn;
    CustSuppAdd5Label: TLabel;
    PaymentQuery: TQuery;
    ExtraQtysBtn: TButton;
    ExtraQtysPanel: TPanel;
    GroupBox1: TGroupBox;
    SaveQtysBtn: TButton;
    ClearQtysBtn: TButton;
    Qty2Label: TLabel;
    Qty3Label: TLabel;
    Qty2: TEdit;
    Qty3: TEdit;
    JobCardImportButton: TcxButton;
    // SP 29/05/2015
    productsEdit: TEdit;
    closeExtraDescButton: TButton;
    Label18: TLabel;
    AutoAllocateBtn: TButton;
    AutoAllocateAmount: TEdit;
    Procedure CheckVATForChanges(CheckIt: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure BankAccountEnter(Sender: TObject);
    procedure BankAccountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DetailGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DetailGridDrawCell(Sender: TObject; Col, Row: Longint;
      Rect: TRect; State: TGridDrawState);
    procedure DetailGridSetEditText(Sender: TObject; ACol, ARow: Longint;
      const Value: String);
    procedure DetailGridSelectCell(Sender: TObject; Col, Row: Longint;
      var CanSelect: Boolean);
    procedure BankAccountExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CustSuppCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CustSuppCodeEnter(Sender: TObject);
    procedure CustSuppCodeExit(Sender: TObject);
    procedure ToSalesRadioClick(Sender: TObject);
    procedure InvoiceClick(Sender: TObject);
    procedure CashInvoiceClick(Sender: TObject);
    procedure PaymentReceiptClick(Sender: TObject);
    procedure CreditNoteClick(Sender: TObject);
    procedure IncomeClick(Sender: TObject);
    procedure ExpenditureClick(Sender: TObject);
    procedure AddRemoveProductsClick(Sender: TObject);
    procedure AmtReceivedExit(Sender: TObject);
    procedure DiscountExit(Sender: TObject);
    procedure ListAccountsClick(Sender: TObject);
    procedure DetailGridDblClick(Sender: TObject);
    procedure CustSuppCodeDblClick(Sender: TObject);
    procedure BankAccountDblClick(Sender: TObject);
    procedure StubNoExit(Sender: TObject);
    procedure ToPurchaseRadioClick(Sender: TObject);
    procedure CustSuppAmountExit(Sender: TObject);
    procedure CustSuppFromDblClick(Sender: TObject);
    procedure CustSuppToDblClick(Sender: TObject);
    procedure CustSuppToExit(Sender: TObject);
    procedure DetailGridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure F6ButtonClick(Sender: TObject);
    procedure AmtReceivedKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CommentKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaymentReceiptKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PaymentReceiptMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TxDateExit(Sender: TObject);
    procedure DateSearchCloseUp(Sender: TObject);
    procedure DateSearchDropDown(Sender: TObject);
    procedure BankListAccClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CustSuppToKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CustSuppFromKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CustSuppAmountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DiscountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure HelpClick(Sender: TObject);
    procedure DetailGridClick(Sender: TObject);
    procedure DetailGridExit(Sender: TObject);
    procedure TxDateEnter(Sender: TObject);
    procedure CustSuppCodeChange(Sender: TObject);
    procedure CustSuppFromExit(Sender: TObject);
    procedure CustSuppFromEnter(Sender: TObject);
    procedure CustSuppToEnter(Sender: TObject);
    procedure CustSuppAmountChange(Sender: TObject);
    procedure AmtReceivedChange(Sender: TObject);
    procedure DiscountChange(Sender: TObject);
    procedure DetailGridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure DetailGridGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure pExtraDescExit(Sender: TObject);
    procedure DBEdit3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ReportsButtonClick(Sender: TObject);
    procedure closeExtraDescButtonClick(Sender: TObject);
    procedure SaveJobCards(BatchId : Integer; CardType :String);
    procedure LoadJobCards(BatchID : string; CardType : char);
    procedure TotalLessVATChange(Sender: TObject);
    procedure TotalVATChange(Sender: TObject);
    procedure TotalAmtChange(Sender: TObject);
    procedure SetupColumns(Sender: TObject);
    procedure LoadJobCardClick(Sender: TObject);
    procedure ChangeTaskClick(Sender: TObject);
    procedure LedgerClick(Sender: TObject);
    procedure InvoicingClick(Sender: TObject);
    procedure PrintInvoices(Sender: TObject);
    procedure JobcardsClick(Sender: TObject);
    procedure NewJobCardClick(Sender: TObject);
    procedure SaveAsJobCardClick(Sender: TObject);
    procedure PrintasProformaClick(Sender: TObject);
    procedure PrintAsInvoiceClick(Sender: TObject);
    procedure ProformaClick(Sender: TObject);
    procedure JobCardExitClick(Sender: TObject);
    procedure ProformaExitClick(Sender: TObject);
    procedure NewProformaClick(Sender: TObject);
    procedure PrintProformaClick(Sender: TObject);
    procedure PrintProformaAsInvoiceClick(Sender: TObject);
    procedure LoadProformaClick(Sender: TObject);
    procedure SaveasProformaClick(Sender: TObject);
    procedure PrintInvoiceClick(Sender: TObject);
    procedure SelectCustomerClick(Sender: TObject);
    procedure DeleteProformaClick(Sender: TObject);
    procedure DeleteJobCardClick(Sender: TObject);
    Procedure SetUpScreen ( Prog, Act : Integer );
    procedure cbProductsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure QuoteClick(Sender: TObject);
    procedure ReferenceDblClick(Sender: TObject);
    procedure cbProductsCloseUp(Sender: TObject);
    procedure LineDatePickerCloseUp(Sender: TObject);
    procedure meLineDateExit(Sender: TObject);
    procedure LineDatePickerDropDown(Sender: TObject);
    procedure meLineDateChange(Sender: TObject);
    procedure LineDateChange(Sender: TObject);
    procedure CommentKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AmtReceivedClick(Sender: TObject);
    procedure AmtReceivedMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SimpleAllocationClick(Sender: TObject);
    procedure AllocationGridColExit(Sender: TObject);
    procedure OpeningBalanceBtnClick(Sender: TObject);
    procedure OverPaymentBtnClick(Sender: TObject);
    procedure ThisYearBtnClick(Sender: TObject);
    procedure UnallocatedBtnClick(Sender: TObject);
    procedure IncludeLastYearCBClick(Sender: TObject);
    procedure OverpaymentsBtnClick(Sender: TObject);
    procedure EditAllocatedTransaction(TxID :Integer; TxType : String);
    procedure ExtraQtysBtnClick(Sender: TObject);
    procedure ClearQtysBtnClick(Sender: TObject);
    procedure ExtraQtysPanelExit(Sender: TObject);
    procedure Qty3Exit(Sender: TObject);
    procedure Qty2Exit(Sender: TObject);
    procedure SaveQtysBtnClick(Sender: TObject);

    // SP
    procedure JobCardImportButtonClick(Sender: TObject);

    // SP 29/05/2015
    procedure productsEditEnter(Sender: TObject);

    procedure AutoAllocateAmountExit(Sender: TObject);    // TGM AB 19/06/15
    procedure AutoAllocateBtnClick(Sender: TObject);      // TGM AB 19/06/15

    procedure AllocationGridExit(Sender: TObject);
    procedure SearchProductsBtnClick(Sender: TObject);     // TGM AB 20/11/15

  private
    { Private declarations }
    ThisAmount,
    ThisDiscount,
    CustSuppAged1,
    ThisBankBalance,
    CustSuppBalance,
    FromBalance,
    ToBalance   : LONGINT;
    AccountName : string;
    FIsLoadingInvoice : Boolean;
    FChooseDifferentCustomer : Boolean;
    Procedure ReBuildScreen;
    Procedure CallCalcAmt;
    procedure GetExtraDetails(Showpanel : boolean);

    procedure DefaultHandler(var Message); override;

    procedure WMCopyData(var Msg : TWMCopyData); message WM_COPYDATA;
    procedure UpdateCustomerName();
  protected
    CodeCalculated : packed array [1..MaxGridLines] of String;  // TENFOUND
    AmtCalculated : packed array [1..MaxGridLines] of String;
    VATCalculated : packed array [1..MaxGridLines] of Boolean;
    // VATCalculated : Boolean;
    function GetIsVATCalculated ( Index : Integer ) : Boolean;
    procedure SetIsVATCalculated ( Index  : Integer; Value : Boolean );
    function GetIsAmtChanged ( Index : Integer ) : String;
    procedure SetIsAmtChanged ( Index  : Integer; Value : String );
    function GetIsCodeChanged ( Index : Integer ) : String;
    procedure SetIsCodeChanged ( Index  : Integer; Value : String );
    procedure BlankOrigVals;
    procedure CalculateAmount(Sender: TObject);
    procedure CalculateUnitCost(Rowcount : Integer; UpdateVat : boolean);

    // Import Job from App
    procedure AddJobToCard(AJobCardRecord : TJobCardRecord);

    function NextRowIndex : Integer;
  public
    { Public declarations }
    DefaultProduct,
    SalesPurchDB,
    CurrTrans : Integer;
    valuereturned : boolean;
    CashbookImportPayment : boolean;
    property IsVATCalculated[Index : Integer] : Boolean read GetIsVatCalculated write SetIsVATCalculated;
    property IsAmtChanged[Index : Integer] : String read GetIsAmtChanged write SetIsAmtchanged;
    property IsCodeChanged[Index : Integer] : String read GetIsCodeChanged write SetIsCodechanged;
//    function Invoicer: Boolean;
    function IsVatCodeInclusive(RowNumber : Integer): Boolean;
    procedure CreateNewJobCard(CustomerNo : String);
    function FindHighestJobCardNumber : Integer;
    function GridFilledIn : Boolean;
    procedure ClearTheScreen(Sender: TObject);
    procedure DisableTheScreen(Sender: TObject);
    procedure EnableTheScreen(Sender: TObject);
    function GetRefNumber : integer;
    procedure GetUnAllocatedInvoices(CustSuppID : integer;OverpaymentLine : boolean);
    procedure TotalAllocationAmounts;
    procedure AllocateToInvoices(PaymentTx : Integer);
    procedure MarkInvoiceComplete(TxID : integer;CashTrans : boolean;LastYear : boolean);
    procedure GetUnAllocatedInvoicesPreviousYear(CustSuppID : integer);
    procedure AllocateToOpeningBalance(TxID : integer);
    Function GatherEnterpriseQtyFields(EnterpriseCode : string) : boolean;
    procedure CheckForSingleEnterprise;                                           // TGM AB 26/08/16
    function CheckForDefaultProduct(NominalCode : String) : boolean;              // TGM AB 06/01/17
    Function IsNumber(s:String): Boolean;                                         // TGM AB 04/08/17

  end;

var
  NegitiveValue : Boolean;
  LastCol,
  LastRow       : Integer;
  looper        : longint;
  CashBookForm  : TCashBookForm;
  EditingJobCard: boolean;
  OldReference : string;
  _BatchID : integer;
  _SaveCancelled : boolean;
  GridOK : Boolean;
  PreviousYearTxs : Boolean;

implementation
Uses
    pickdate,
    LangUnit,
    DbGen,
    Filed,
    Calcs,
    Util,
    Vars,
    //types,
    Clears,
    DbCore,
    MainUnit,
    TxWrite,
    newListing,
    Calcamt,
    DefSecFl,
    InvoiceReport,
    AccsData, InvoicePrint, ULoadJobs, JobCardReports, uSetUpProducts, DataExport,
    uSetupAnalysis, Backgnd, uOverpayment, JobCardViewer, AccsUtils,
    uAccsMessages, uAccounts, uAccsSync, uFarmSyncSettings,
    uJobCardCustomerListing,
    // SP 29/05/2015
    uProductListing,
    JobCardReportSetup;

Const
     SalesPurchaseCode = 60;     { code to identify the Unentered Item on Screen }
     BankCode = 70;
     F7Prompt = 'F7 to add extra details';

type
   TVatArray = record
      Amt : LongInt;
      VatCode : String[1];
      VatAmt : LongInt;
   end;

Var
//   OrigVals : packed array [1..3,1..10] of TVatArray;
   OldAmt,
   NewAmt,
   OldVATAmt,
   NewVATAmt,
   NewVAT,
   OldVAT : String;
   EntCol, NomCol, DesCol, DetailCol, QtyCol, EachCol, AmtCol, VCodeCol, VAmtCol, ANCol : integer;
   justadded : boolean;
   JobCardOpen : boolean;
   JobCardNumber : Integer;
   ProformaOpen : boolean;
   QuoteOpen : boolean;
   ProformaNumber : Integer;
   QuoteNumber : Integer;
   invoiceNumber : integer; // holds current invoice or proforma invoice number
   TaskNumber : Integer;  (* this holds number for current task 0 - No Task Choosen (initial value)
                                                                1 - Ledger
                                                                2 - Invoice Printing
                                                                3 - Job Cards
                                                                4 - Proforma Invoices
                                                                5 - Quotes

                            *)
   Cust_suppcode: integer; // holds customer / supplier number in cashbook system
   Qty2Name, Qty3Name : String;
   Qty2Active, Qty3Active : Boolean;
   QTY2Values	      : ARRAY [1..MaxGridLines] OF LONG;
   QTY3Values	      : ARRAY [1..MaxGridLines] OF LONG;
   TxLine : integer; // TGM AB 01/01/15 Holds the value of the current line on the grid for the qty2/3 values
   SingleEnterprise : Boolean;  // TGM AB 26/08/16 True for enterprise system only has 1 enterprise
   SingleEnterpriseCode : String;   // TGM AB 26/08/16 holds code for single enterprise in single enterprise data
   TempCol : integer;   // TGM AB 02/12/16


{$R *.DFM}

//Ch027

Function CheckEditedGridLinesOK : Boolean;
var
        i : integer;
        RowOK : boolean;
begin

    Result := True;
    RowOK := True;

    if GEditing then begin

        //check each line on the grid for a blank line

        for i:= 1 to CashbookForm.Detailgrid.RowCount-1 do begin        // grid starts at 0,0 (1st line headings)

                if ((trim(CashbookForm.detailgrid.cells[NomCol,i]) = '')
                   and (trim(CashbookForm.detailgrid.cells[AmtCol,i]) = '')
                       and (trim(CashbookForm.detailgrid.cells[VCodeCol,i]) = '')
                           and (trim(CashbookForm.detailgrid.cells[VAmtCol,i]) = '')) then RowOK := False;
        end;

    end;  // GEditing

    Result := RowOK;

    if result = false then showmessage('Blank Line(s) found in this transaction - edited transactions cannot be saved with blank lines. Please zeroise the affected lines instead of deleting before continuing.');



end;

//Ch027 end

function TCashBookForm.IsNumber(s:String): Boolean;                // TGM AB 04/08/17
var
        num: Extended;
begin
   Result:=True;
   try
     num:= StrToFloat(s)
   except
       Result:=False;
   end;
end;

procedure TCashBookForm.SetupColumns(Sender : TObject);
begin
 // if (Invoicer) then begin
  if Tasknumber in [2..5] then begin
                             F6Button.hide; // hides quantity button
                             Detailgrid.left := 1; // WAS 6 TENFOUND
                             Detailgrid.Width := 790; // WAS 785 TENFOUND
                             Detailgrid.colcount := 10;
                             EntCol := 0;
                             Detailgrid.ColWidths[EntCol] := 34;
                             NomCol := 1;
                             Detailgrid.ColWidths[NomCol] := 34;
                             DesCol := 2;
                             Detailgrid.ColWidths[DesCol] := 131;
                             DetailCol := 3;
                             Detailgrid.ColWidths[DetailCol] := 146;
                             QtyCol := 4;
                             Detailgrid.ColWidths[QtyCol] := 80;
                             EachCol := 5;
                             Detailgrid.ColWidths[EachCol] := 73;
                             AmtCol := 6;
                             Detailgrid.ColWidths[AmtCol] := 85;
                             VCodeCol := 7;
                             Detailgrid.ColWidths[VCodeCol] := 42;
                             VAmtCol := 8;
                             Detailgrid.ColWidths[VAmtCol] := 70;
                             ANCol := 9;
                             Detailgrid.ColWidths[ANCol] := 65;
                             VatPanel.visible := true;
     end
        else begin
                F6Button.show; // shows quantity button
                Detailgrid.left := 70;  // was 75 TENFOUND;
                Detailgrid.Width := 639; // WAS 625 TENFOUND
                Detailgrid.colcount := 8;
                EntCol := 0;
                Detailgrid.ColWidths[EntCol] := 36;
                NomCol := 1;
                Detailgrid.ColWidths[NomCol] := 36;
                DesCol := 2;
                Detailgrid.ColWidths[DesCol] := 131;
                QtyCol := 3;
                Detailgrid.ColWidths[QtyCol] := 86;
                AmtCol := 4;
                Detailgrid.ColWidths[AmtCol] := 85;
                VCodeCol := 5;
                Detailgrid.ColWidths[VCodeCol] := 82;
                VAmtCol := 6;
                Detailgrid.ColWidths[VAmtCol] := 93;
                ANCol := 7;
                Detailgrid.ColWidths[ANCol] := 60; // was 63
                Eachcol := 20; // any number bigger than the total no of columns used (avoids any random number!);
                DetailCol := 21;
                TempCol := 22;  // TGM AB 02/12/16
                VatPanel.visible := false;
           end;

     OpenLang;

     with DetailGrid do
         begin
              Cells[EntCol,0] := ReadLang ( 27, CurrLang ); { Ents }
              Cells[NomCol,0] := ReadLang ( 28, CurrLang ); { Nom }
              Cells[DesCol,0] := ReadLang ( 29, CurrLang ); { Description }
              Cells[QtyCol,0] := ReadLang ( 30, CurrLang ); { Quantity }
              Cells[AmtCol,0] := ReadLang ( 31, CurrLang ); { Amount }
              if tasknumber in [2..4] then Cells[VCodeCol,0] := 'Code'
                 else   Cells[VCodeCol,0] := ReadLang ( 32, CurrLang ); { Vat-Code }
              if tasknumber in [2..4] then Cells[VAmtCol,0] := 'Amount'
                 else  Cells[VAmtCol,0] := ReadLang ( 33, CurrLang ); { Vat-Amount }
              Cells[ANCol,0] := ReadLang ( 34, CurrLang ); { Analysis }
              Cells[EachCol,0] := 'Each'; // TGM AB 10/06/02 - label for new each column
              Cells[DetailCol,0] := 'Details'; // TGM AB 18/06/02
         end;
end;

function TCashbookForm.GetRefNumber: integer;
begin
     result := 0;
     if not accsdatamodule.InvoiceNumbers.active then accsdatamodule.InvoiceNumbers.open;
     accsdatamodule.InvoiceNumbers.first;
     begin
             case tasknumber of
             2: begin if invoice.Checked then
                try invoiceNumber:= (accsdatamodule.InvoiceNumbers['lastSaleInv'] + 1);
                except
                      invoiceNumber:=1;
                end;
                if creditnote.Checked then
                try invoiceNumber:= (accsdatamodule.InvoiceNumbers['lastSaleCred'] + 1);
                except
                      invoiceNumber:=1;
                end;
                if cashinvoice.Checked then
                try invoiceNumber:= (accsdatamodule.InvoiceNumbers['lastSaleInv'] + 1);
                except
                      invoiceNumber:=1;
                end;
                result := invoicenumber;
             end;
             3: begin
                try JobCardNumber:= (accsdatamodule.InvoiceNumbers['lastJobCard'] + 1);
                except
                      JobCardNumber:=1;
                end;
                result := JobCardNumber;
             end;

             4: begin
                try ProformaNumber:= (accsdatamodule.InvoiceNumbers['lastProforma'] + 1);
                except
                      ProformaNumber:=1;
                end;
                result := ProformaNumber;
             end;
             5: begin
                try QuoteNumber:= (accsdatamodule.InvoiceNumbers['lastQuote'] + 1);
                except
                      QuoteNumber:=1;
                end;
                result := QuoteNumber;
             end;
             end;
     end;

end;

function TCashBookForm.GetIsVATCalculated(Index : Integer) : Boolean;
begin
    Result := VATCalculated[Index];
end;

procedure TCashBookForm.SetIsVATCalculated(Index : Integer; Value : Boolean);
begin
    if Value <> VATCalculated[index] then
       VATCalculated[index] := Value;
end;

function TCashBookForm.GetIsAmtChanged(Index : Integer) : String;
begin
    Result := AmtCalculated[Index];
end;

procedure TCashBookForm.SetIsAmtchanged(Index : Integer; Value : String);
begin
    if Value <> AmtCalculated[index] then
       AmtCalculated[index] := Value;
end;

function TCashBookForm.GetIsCodeChanged(Index : Integer) : String;
begin
    Result := CodeCalculated[Index];
end;

procedure TCashBookForm.SetIsCodeChanged(Index : Integer; Value : String);
begin
//    if Value <> CodeCalculated[index] then
    if detailgrid.cells[VCodeCol,index] <> CodeCalculated[index] then
       begin
          CodeCalculated[index] := Value;
          IsVATCalculated[index] := FALSE;
       end;
end;

Procedure TCashBookForm.CheckVATForChanges(CheckIt: Boolean);
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
Begin   // BEGIN CheckVATForChanges
   if LastCol > 0 then
      ThisRow := LastRow
   else
      ThisRow := 1;

   TempVATCode := DetailGrid.Cells[VCodeCol, Thisrow];
   SlimAll ( TempVATCode );
   TempAMT := DetailGrid.Cells[AmtCol, Thisrow];
   SlimAll ( TempAMT );
   StrLong ( TempAMT, NomAmt );
   TempVAT := DetailGrid.Cells[VAmtCol, Thisrow];
   SlimAll ( TempVAT );
   StrLong ( TempVAT, VATAmt );

   Allowed := TRUE;
   // If you are editing the Transaction and the Code has been changed
   if (( GEditing ) And
       ( ZTAXAMT[2,ThisRow] = 0 ) And
       ( TempVATCode <> ZTAX[2,ThisRow] )) then
       begin
          if (( ZTAX[2,ThisRow] = Cash1.XTAXIDS[0] ) And ( Cash2.xCountry = 2 ))  Or    (*                                     // Ch035
             ((( ZTAX[2,ThisRow] = Cash1.XTAXIDS[0] ) Or                                                                       // Ch035
               ( ZTAX[2,ThisRow] = Cash1.XTAXIDS[1] )) And  *)                                                                 // Ch035
               ( Cash2.XCOUNTRY = 1 ) (*)*) then                                                                               // Ch035
               Allowed := TRUE
          else
             Allowed := FALSE;
       end;

   if NOT Allowed then
      begin
         DetailGrid.Cells[VCodeCol,ThisRow] := ZTAX[2,ThisRow];
         MessageDLG('Cannot alter this VAT code - zero the transaction and re-enter a NEW transaction',mtWarning,[mbOK],0);
      end
   else
      { Only check if there is a VAT CODE and there is not amount already in the space }
      if (( NOT IsVATCalculated[ThisRow] ) And ( NomAmt <> 0 )) then
      // if (( Length(TempVATCode) > 0 ) and ( VatAmt = 0 )) or CheckIt then
         begin
              if ( NewListBox.CheckVAT ( TempVATCode, VATArrPos )) then
               begin
                  NewListBox.CalcTax ( VATArrpos, TempStr, VatAmt, NomAmt, IsExclusive );
                  LongStr ( VatAmt, TempLong, 'L' );
                  DetailGrid.Cells[VAmtCol, ThisRow] := TempLong;
                  LongStr ( NomAmt, TempLong, 'L' );
                  if ( NomAmt <> 0 ) then
                     DetailGrid.Cells[AmtCol, ThisRow] := TempLong;
                  //if VatAmt <> 0 then
                     IsVATCalculated[ThisRow] := TRUE;
                     // the line below was causing the problems with the Inclusive VAR being calculated twice
                     CodeCalculated[ThisRow] := DetailGrid.Cells[VCodeCol, ThisRow];
               end;
         end;
end; // END CheckVATForChanges

Procedure TCashBookForm.ReBuildScreen;
Var
   NoOfItems,
   ItemCount : Integer;
   TempStr   : ShortString;
Begin
     NoOfItems := 0;
     Case PROG Of
          CASHINC,
          CASHEXP : Begin
                         SalesPurchDb := 0;
                         // TGM AB 09/08/02 - loading cust/supp code
                         Cust_suppcode := (ZAccount[1]);
                         // end TGM AB
                         BankAccount.Text := IntToStr ( zbank[1] );
                         KDateToStr ( zTxDate[1], TempStr );
                         TxDate.Text := TempStr;
//                         DateMask.Text := TempStr;
                         Reference.Text := zRef[1];
                         Comment.Text := zComm[1];
                         Str ( zStub[1], Tempstr );
                         PadZero ( TempStr, 8 );
                         StubNo.Text := TempStr;
                         For ItemCount := 1 To MaxGridLines Do  // TENFOUND
                             Begin
                                  If ( zGen[1,ItemCount] <> 0 ) Then
                                     Begin
                                          Inc ( NoOfItems );
                                          DetailGrid.Cells[EntCol,NoOfItems] := zEnt[1,ItemCount];
                                          DetailGrid.Cells[NomCol,NoOfItems] := IntToStr ( zGen[1,ItemCount] );
                                          DetailGrid.Cells[DesCol,NoOfItems] := zDesc[1,ItemCount];
                                          LongStr ( zQty[1,NoOfItems], TempStr, 'L' );
                                          DetailGrid.Cells[QtyCol,NoOfItems] := TempStr;
                                          LongStr ( zAmt[1,NoOfItems], TempStr, 'L' );
                                          DetailGrid.Cells[AmtCol,NoOfItems] := TempStr;
                                          DetailGrid.Cells[VCodeCol,NoOfItems] := zTax[1,ItemCount];
                                          LongStr ( zTaxAmt[1,NoOfItems], TempStr, 'L' );
                                          DetailGrid.Cells[VAmtCol,NoOfItems] := TempStr;
                                          DetailGrid.Cells[ANCol,NoOfItems] := IntToStr ( zAnalysis[1,ItemCount] );
                                     End;
                             End;
                         DetailGrid.RowCount := NoOfItems+1;
                         // Set the Totals for the Transaction
                         LongStr ( zTotAmt[1], TempStr, 'L' );
                         TotalLessVat.Text := TempStr;
                         LongStr ( zTotTax[1], TempStr, 'L' );
                         TotalVat.Text := TempStr;
                         LongStr ( zTotTax[1]+zTotAmt[1], TempStr, 'L' );
                         TotalAmt.Text := TempStr;
                    End;
          PURCHTX,
          SALESTX : Begin
                         If PROG = SALESTX Then
                            SalesPurchDb := SlFile
                         Else
                             SalesPurchDb := PlFile;
                         CustSuppCode.Text := IntToStr ( zAccount[1] );
                         KDateToStr ( zTxDate[1], TempStr  );
                         TxDate.Text := TempStr;
//                         DateMask.Text := TempStr;
                         Reference.Text := zRef[1];
                         Comment.Text := zComm[1];
                         If ( ACT = 2 ) Then   { Cash Sale/Purchase }
                            Begin
                                 StubNo.Text := IntToStr ( Zstub[1] );
                                 BankAccount.Text := IntToStr ( zBank[1] );
                            End;

                         If ( ACT <> 3 ) Then   { Only 1 line for Receipt/Payment }
                           Begin
                             For ItemCount := 1 To MaxGridLines Do  // TENFOUND
                                Begin
                                  If ( zGen[1,ItemCount] <> 0 ) Then
                                     Begin
                                          Inc ( NoOfItems );
                                          DetailGrid.Cells[EntCol,NoOfItems] := zEnt[1,ItemCount];
                                          DetailGrid.Cells[NomCol,NoOfItems] := IntToStr ( zGen[1,ItemCount] );
                                          DetailGrid.Cells[DesCol,NoOfItems] := zDesc[1,ItemCount];
                                          LongStr ( zQty[1,NoOfItems], TempStr, 'L' );
                                          DetailGrid.Cells[QtyCol,NoOfItems] := TempStr;
                                          LongStr ( zAmt[1,NoOfItems], TempStr, 'L' );
                                          DetailGrid.Cells[AmtCol,NoOfItems] := TempStr;
                                          DetailGrid.Cells[VCodeCol,NoOfItems] := zTax[1,ItemCount];
                                          LongStr ( zTaxAmt[1,NoOfItems], TempStr, 'L' );
                                          DetailGrid.Cells[VAmtCol,NoOfItems] := TempStr;
                                          DetailGrid.Cells[ANCol,NoOfItems] := IntToStr ( zAnalysis[1,ItemCount] );

                                          // TGM AB 19/12/14 Add extra quantites into ProdsTxTemp Table


                                          // TGM AB End
                                     End;
                                End;
                           End
                         Else
                             Begin
                                  Inc ( NoOfItems );
                                  BankAccount.Text := IntToStr ( zbank[1] );
                                  StubNo.Text := IntToStr ( Zstub[1] );
                                  LongStr ( zAmt[1,NoOfItems], TempStr, 'L' );
                                  AmtReceived.Text := TempStr;
                                  LongStr ( zdiscount[1], TempStr, 'L' );
                                  Discount.Text := TempStr;
                                  If zDiscount[1] = 0 Then // TGM AB Editing Zero Discount disabled here
                                     Discount.Enabled := False
                                  Else
                                      Discount.Enabled := True;

                                  // TGM AB Code to check for blank discount line and enable discount box


                                  Accsdatamodule.TransactionsDB.Locate('TxNo',TxEditRec.TransF,[]);      // TGM AB 09/11/12
                                  Accsdatamodule.TransactionsDB.Next;
                                  If ((Prog = SalesTX) and (Accsdatamodule.TransactionsDB['TxType'] = 9) and (Accsdatamodule.TransactionsDB['OrigType'] = 2))
                                     then Discount.Enabled := True;
                                  If ((Prog = PurchTX) and (Accsdatamodule.TransactionsDB['TxType'] = 9) and (Accsdatamodule.TransactionsDB['OrigType'] = 6))
                                     then Discount.Enabled := True;
                                  Accsdatamodule.TransactionsDB.Prior;

                             End;

                         DetailGrid.RowCount := NoOfItems+1;
                         // Set the Totals for the Transaction
                         LongStr ( zTotAmt[1], TempStr, 'L' );
                         TotalLessVat.Text := TempStr;
                         LongStr ( zTotTax[1], TempStr, 'L' );
                         TotalVat.Text := TempStr;
                         LongStr ( zTotTax[1]+zTotAmt[1], TempStr, 'L' );
                         TotalAmt.Text := TempStr;
                    End;
     End;
End;

procedure TCashBookForm.BlankOrigVals;
var ArrOneCount : Integer;
    TempStr : ShortString;
begin
   for ArrOneCount := 1 to MaxGridLines do  // TENFOUND
      begin
         if ( zGen[1,ArrOneCount] <> 0 ) Then
            begin
               LongStr ( zAmt[1,ArrOneCount], TempStr, 'L' );
               IsAmtChanged[ArrOnecount] := TempStr;
               IsCodeChanged[ArrOnecount] := zTax[1,ArrOneCount];
               // Must be called after IsCodeChanged when editing ONLY
               IsVATCalculated[ArrOnecount] := TRUE;
            end
         else
            begin
               IsVATCalculated[ArrOnecount] := FALSE;
               IsAmtChanged[ArrOnecount] := '';
               IsCodeChanged[ArrOnecount] := '';
            end;
      end;

   // Blank out the array that hold the original value for vat amt, vat code and vat amt
   (*
   for ArrOneCount := 1 to 3 do
      for ArrTwoCount := 1 to 10 do
         begin
            OrigVals[ArrOneCount,ArrTwoCount].Amt := 0;
            OrigVals[ArrOneCount,ArrTwoCount].VatAmt := 0;
            OrigVals[ArrOneCount,ArrTwoCount].VatCode := '';
         end;
   *)
end;

procedure TCashBookForm.FormActivate(Sender: TObject);
Var
   NoPresented : Boolean;
   PCount, i, rowcount : Integer;
   j : integer; //TGM AB 01/01/15
   MyQuery : TQuery;       // Ch006
 //  IsAllocated, IsInVATReturn : Boolean;   // Ch0XX

begin
     // try and open the Products Tables
    if invoicer then begin
       AccsDataModule.GetPurchaseLedgerAccs;
       AccsDatamodule.PurchaseLedger.open;
       AccsDataModule.GetSalesLedgerAccs;
       AccsDatamodule.SalesLedger.open;
    end;

     try
        DefaultProduct := 0;
        pExtraDesc.Hide;
        // GM removed line below to prevent error on non billing system - editing purchase invoice gave error message
        // as nomlisting couldn't be opened.
        //if NOT Cash11.xBilling then
           with AccsDataModule do
              begin
                 ProdsTx.Open;
                 Products.Open;
                 // TG added line below to fix bug in invoicer where changeing from one company name to another ended up with
                 // blank entries on invoice
                 AccsDataModule.GetAllNominalLedgerAccs;
                 NominalList.Open;
                 // if NOT Editing then clear the Temp Table
                 if NOT GEditing then
                    begin
                       ProdsTxTemp.Close;
                       ProdsTxTemp.EmptyTable;
                    end;
                 ProdsTxTemp.Open;
             end;
     except
        ShowMessage('Error occurred opening one of: ProdsTx, Products, NominalList');
     end;
     TotalLessVATEuro.text:='';
     TotalAmtEuro.Text:='';
     TotalVATEuro.text:='';
     BankAccount.Text := IntToStr ( Cash1.xLastBank );
     TxDate.Text := Cash11.Default_Date;{XDate}
     if not cashbookimportpayment then Caption := 'Cashbook';{ + ' - ' + st;}
     DateSearch.Date := KStrToDate ( Cash11.Default_Date );
     LineDatePicker.Date := KStrToDate ( Cash11.Default_Date ); // TGM AB
     DateLabel.Caption := ReadLang ( 7, CurrLang ); {Date}
     ReferenceLabel.Caption := ReadLang ( 36, CurrLang );
     StubNoLabel.Caption := ReadLang ( 38, CurrLang ); {Date}
     DateLabel.Caption := ReadLang ( 7, CurrLang ); {Date}
     Save.Caption      := ReadLang ( 26, CurrLang ); { Save }

     OldVAT := '';
     OldAmt := '';
     OldVATAmt := '';
     Cust_suppcode := 0; // TGM AB 09/08/02


     //FMainScreen.Hide;
     CashBookForm.Hide;

     ThisAmount := 0;     // Amount received or Paid.
     ThisDiscount := 0;   // Amount of Discount Give.

     // TGM AB 01/01/15 - Clear the Qty2/Qty3 arrays

     for j:= 1 to MaxGridLines do begin
         QTY2Values[j] := 0;
         QTY3Values[j] := 0;
     end;

     if NOT GEditing Then
        Case PROG Of
          CASHINC,
          CASHEXP : Begin
                      CashBook.CashBookForm.SalesPurchDB := 0;
                      SetUpScreen ( PROG, ACT );
                    End;
          SALESTX : Begin
                      CashBook.CashBookForm.SalesPurchDB := SlFile;
                      SetUpScreen ( PROG, ACT );
                      CustSuppCode.Text := '';
                    End;
          PURCHTX : Begin
                      CashBook.CashBookForm.SalesPurchDB := PlFile;
                      SetUpScreen ( PROG, ACT );
                      if not CashbookImportPayment then CustSuppCode.Text := '';
                    End;
        End;
     Mask.DefaultBlank := ' ';
     Mask.MaskNoSave := '0';
     looper := 0;
     LastCol := -1;
     LastRow := -1;

     For PCount := 1 To MaxTx Do
         New ( TxHold[PCount] );
     For PCount := 1 To MaxNom Do
         New ( NomHold[PCount] );
     { Initialise the Pointer Variable }
     For PCount := 1 To MaxTx Do
         FillChar ( TxHold[PCount]^, SizeOf(TxHold[PCount]^),chr(0));
     For PCount := 1 To MaxNom Do
         FillChar ( NomHold[PCount]^, SizeOf(NomHold[PCount]^),chr(0));

     OpenLang;
     CashBookForm.ExitButton.Caption := ReadLang ( 1, CurrLang );

     DetailGrid.RowCount := MaxGridLines + 1; // TENFOUND  WAS 11
     DetailGrid.FixedRows := 1;

     with DetailGrid do
         begin
              Cells[EntCol,0] := ReadLang ( 27, CurrLang ); { Ents }
              Cells[NomCol,0] := ReadLang ( 28, CurrLang ); { Nom }
              Cells[DesCol,0] := ReadLang ( 29, CurrLang ); { Description }
              Cells[QtyCol,0] := ReadLang ( 30, CurrLang ); { Quantity }
              Cells[AmtCol,0] := ReadLang ( 31, CurrLang ); { Amount }
              if tasknumber in [2..4] then Cells[VCodeCol,0] := 'Code'
                 else   Cells[VCodeCol,0] := ReadLang ( 32, CurrLang ); { Vat-Code }
              if tasknumber in [2..4] then Cells[VAmtCol,0] := 'Amount'
                 else  Cells[VAmtCol,0] := ReadLang ( 33, CurrLang ); { Vat-Amount }
              Cells[ANCol,0] := ReadLang ( 34, CurrLang ); { Analysis }
              Cells[EachCol,0] := 'Each'; // TGM AB 10/06/02 - label for new each column
              Cells[DetailCol,0] := 'Details'; // TGM AB 18/06/02
         end;

     CashBookForm.Visible := True;

     // Initialize the Vat Array
     BlankOrigVals;

     If ( TxEditRec.TransF{CurrTrans} > 0 ) {And ( Editing )} Then
        begin
           // Set Temp Bool to TRUE
           NoPresented := TRUE;
           // If the Button hasn't already been disabled - Load Transaction
           // TEST result for Presented cheques
           if Save.Enabled then
              begin
                 NoPresented := LoadTrans;  // Load the Info
                 Save.Enabled := NoPresented;
              end
           else
              LoadTrans;  // Load the Info
           ReBuildScreen;
           SetUpScreen ( PROG, ACT );

           // TGM AB 13/06/02 - Next few Lines calculate the each amount and fills it in as well as gatherig the details column
           application.processmessages;
           if detailgrid.visible then for Rowcount := 1 to MaxGridLines + 1 do begin // TENFOUND WAS 11
                                                                 calculateUnitCost(Rowcount,false);
                                                                 end;

           txdate.SetFocus;

           // detail lines
           if detailgrid.visible then begin
              for i := 1 to detailgrid.RowCount-1 do begin
                         detailgrid.row:= i;
                         getextradetails(false);
              end;
           end;

           if custsuppcode.visible then custsuppcode.setfocus
              else bankaccount.setfocus;

         //  Detailgrid.row := 1;

           // End TGM AB


     (*
     //Ch0XX starts here

        IsAllocated := false;
        IsInVATReturn := false;

        // check for presented comes from above - NoPresented = false then stop editing

        // check for being included in VAT Return

        // Check to see if transaction has been presented in a VAT Return / Closed Period


               MyQuery := TQuery.create(self);
               Myquery.DatabaseName := accsdatamodule.AccsDataBase.databasename;
               MyQuery.SQL.clear;
               MyQuery.SQL.add ('Select * From Transactions where VATProcessed = ''True'' and TxNo >= ' + vartostr(TxEditRec.TransF) + ' and TxNo <= ' + vartostr(TxEditRec.TransT));
               MyQuery.open;

               if MyQuery.recordcount > 0 then IsInVATReturn := True;

               MyQuery.close;
               MyQuery.free;


        // check to see if transaction has been allocated

          if (cash2.xAllocation) then begin

           // invoices

           SetDB(TxFile);
           ReadRec ( TxFile, TxEditRec.TransF );
           getitem(TxFile,1);
           if ((prog = SalesTX) and (currint = 1)) or ((prog = PurchTX) and (currint = 5)) then begin

               if ((TxEditRec.transtype = 'Cash Sale') or (TxEditRec.transtype = 'Cash Purchase')) then begin

                  if MessageBox(self.handle,'This Cash Transaction has already been allocated - Do you wish to unallocate and then edit it?', 'Kingswood Accounts',                  // TGM AB 18/08/17
                       MB_YESNO + MB_DEFBUTTON2) = mrYes then begin                                                                                                                  // TGM AB 18/08/17

                          if prog = SalesTX then EditAllocatedTransaction(TxEditRec.TransF,'CASHREC')
                              else EditAllocatedTransaction(TxEditRec.TransF,'CASHPAY');
                              Exitbutton.Enabled := false;

                     end else save.Enabled := false;
               end
                  else begin
                                getitem(TxFile,30);
                                if ansiuppercase(currdisp[1]) = 'Y' then begin
                                   save.Enabled := false;
                                   ShowMessage('This Transaction already has payment allocated and cannot be edited');
                       end
                          else begin
                                    getitem(TxFile,29);
                                    if currlong <> 0 then begin
                                    save.Enabled := false;
                                    ShowMessage('This Transaction already has payment allocated and cannot be edited');
                                    end;
                               end;
                       end;
           end;

           // Payments

           SetDB(TxFile);
           ReadRec ( TxFile, TxEditRec.TransF );
           getitem(TxFile,1);

           if ((prog = SalesTX) and (currint = 2)) or ((prog = SalesTX) and (currint = 12)) or ((prog = PurchTX) and (currint = 6)) or ((prog = PurchTX) and (currint = 16)) then begin

           PaymentQuery.close;
           PaymentQuery.DatabaseName := accsdatamodule.AccsDataBase.databasename;
           PaymentQuery.SQL.clear;
           PaymentQuery.SQL.Add('Select * from AllocatedVAT where PaymentID = ' + vartostr(TxEditRec.TransF));
           PaymentQuery.open;
           If PaymentQuery.RecordCount > 0 then begin
                  save.Enabled := false;
           //       if MessageDlg('This Transaction has already been allocated - Do you wish to zeroise this transaction to allow it to be unallocated and then edited?',                                          // TGM AB 18/08/17
           //          mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin                                                                                                                                        // TGM AB 18/08/17
                 if MessageBox(self.handle,'This Transaction has already been allocated - Do you wish to zeroise this transaction to allow it to be unallocated and then edited?', 'Kingswood Accounts',           // TGM AB 18/08/17
                       MB_YESNO + MB_DEFBUTTON2) = mrYes then begin                                                                                                                                                // TGM AB 18/08/17
                           if prog = SalesTX then EditAllocatedTransaction(TxEditRec.TransF,'REC')
                              else EditAllocatedTransaction(TxEditRec.TransF,'PAY');
                              Exitbutton.Enabled := false;
                           end;
              end;
           PaymentQuery.close;
           PaymentQuery.SQL.clear;

          end;




     //Ch0XX ends here

    *)



           if NOT NoPresented then
              ShowMessage('This Transaction is Presented' + #13 +
                          'You have to UnPresent it before editing');


           if ((cash2.xAllocation) and (NoPresented)) then begin                    // TGM AB 07/07/17

           // check that if the transaction is an invoice that payment is not already allocated

           SetDB(TxFile);
           ReadRec ( TxFile, TxEditRec.TransF );
           getitem(TxFile,1);
           if ((prog = SalesTX) and (currint = 1)) or ((prog = PurchTX) and (currint = 5)) then begin

               if ((TxEditRec.transtype = 'Cash Sale') or (TxEditRec.transtype = 'Cash Purchase')) then begin

                  if MessageBox(self.handle,'This Cash Transaction has already been allocated - Do you wish to unallocate and then edit it?', 'Kingswood Accounts',                  // TGM AB 18/08/17
                       MB_YESNO + MB_DEFBUTTON2) = mrYes then begin                                                                                                                  // TGM AB 18/08/17
          //           if MessageDlg('This Cash Transaction has already been allocated - Do you wish to unallocate and then edit it?',                                               // TGM AB 18/08/17
          //                mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin                                                                                                     // TGM AB 18/08/17

                          if prog = SalesTX then EditAllocatedTransaction(TxEditRec.TransF,'CASHREC')
                              else EditAllocatedTransaction(TxEditRec.TransF,'CASHPAY');
                              Exitbutton.Enabled := false;

                     end else save.Enabled := false;
               end
                  else begin
                                getitem(TxFile,30);
                                if ansiuppercase(currdisp[1]) = 'Y' then begin
                                   save.Enabled := false;
                                   ShowMessage('This Transaction already has payment allocated and cannot be edited');
                       end
                          else begin
                                    getitem(TxFile,29);
                                    if currlong <> 0 then begin
                                    save.Enabled := false;
                                    ShowMessage('This Transaction already has payment allocated and cannot be edited');
                                    end;
                               end;
                       end;
           end;
           // TGM AB - check that a payment hasn't already been allocated against an invoice and if so prompt
           // user to either look at 'read only' or have it totally unallocated and edit (removes all links
           // and allocation records)

           SetDB(TxFile);
           ReadRec ( TxFile, TxEditRec.TransF );
           getitem(TxFile,1);

           if ((prog = SalesTX) and (currint = 2)) or ((prog = SalesTX) and (currint = 12)) or ((prog = PurchTX) and (currint = 6)) or ((prog = PurchTX) and (currint = 16)) then begin

           PaymentQuery.close;
           PaymentQuery.DatabaseName := accsdatamodule.AccsDataBase.databasename;
           PaymentQuery.SQL.clear;
           PaymentQuery.SQL.Add('Select * from AllocatedVAT where PaymentID = ' + vartostr(TxEditRec.TransF));
           PaymentQuery.open;
           If PaymentQuery.RecordCount > 0 then begin
                  save.Enabled := false;
           //       if MessageDlg('This Transaction has already been allocated - Do you wish to zeroise this transaction to allow it to be unallocated and then edited?',                                          // TGM AB 18/08/17
           //          mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin                                                                                                                                        // TGM AB 18/08/17
                 if MessageBox(self.handle,'This Transaction has already been allocated - Do you wish to zeroise this transaction to allow it to be unallocated and then edited?', 'Kingswood Accounts',           // TGM AB 18/08/17
                       MB_YESNO + MB_DEFBUTTON2) = mrYes then begin                                                                                                                                                // TGM AB 18/08/17
                           if prog = SalesTX then EditAllocatedTransaction(TxEditRec.TransF,'REC')
                              else EditAllocatedTransaction(TxEditRec.TransF,'PAY');
                              Exitbutton.Enabled := false;
                           end;
              end;
           PaymentQuery.close;
           PaymentQuery.SQL.clear;


           end;

           end;  // end cash2.xAllocation

           //Ch006

           // Check to see if transaction has been presented in a VAT Return / Closed Period

           if save.Enabled = true then begin      // if Presented / Allocated then this will already be false
         //      showmessage(vartostr(TxEditRec.TransF));
         //      showmessage(vartostr(TxEditRec.TransT));

               MyQuery := TQuery.create(self);
               Myquery.DatabaseName := accsdatamodule.AccsDataBase.databasename;
               MyQuery.SQL.clear;
               MyQuery.SQL.add ('Select * From Transactions where VATProcessed = ''True'' and TxNo >= ' + vartostr(TxEditRec.TransF) + ' and TxNo <= ' + vartostr(TxEditRec.TransT));
               MyQuery.open;



               if MyQuery.recordcount > 0 then begin
                           save.Enabled := false;
                           ShowMessage('This Transaction is included within a VAT Return / Closed VAT Period and cannot be edited');
                           ExitButton.Enabled := True;

               end;

               MyQuery.close;
               MyQuery.free;

           end;

           // End Ch006



     end;
//tgm 12/10/01

// Next Lines Added by TGM AB to introduce invoicer panels & layout
     if ((not GEditing) and (Invoicer) and (PROG = SALESTX)) then begin
                                             SalesPurchaseGroup.Visible := false;
                                             changetaskspanel.Visible := true;
                                             changetaskspanel.width := 793;
                                             cashbookform.caption := 'Select A Task';
                                             TaskNumber := 0;
                                             Disablethescreen(self);
                                             save.enabled := false;
                                             changetask.enabled := false;
                                             end;
     if ((GEditing) and (Invoicer) and (PROG = SALESTX) and (DetailGrid.Visible)) then begin
                                             changetaskspanel.width := 261;
                                             PrintInvoice.enabled := True;
                                             changetaskspanel.visible := true;
                                             changetask.enabled := false;
                                        //     save.enabled := true;
                                             end;

     if ((PROG = PURCHTX) and (FileExists(Accsdata.AccsDataModule.AccsDataBase.Directory + 'pinvoice'))) then begin
                                             changetaskspanel.width := 261;
                                             PrintInvoice.enabled := True;
                                             changetaskspanel.visible := true;
                                             changetask.enabled := false;
                                        //     save.enabled := true;
                                             end;
     JobCardOpen := false;
     JobCardNumber := 0;
     ProformaOpen := False;
     ProformaNumber := 0;
     Quotenumber := 0;
     //CurrentProformaInvoiceNumber := 0;
     Invoicenumber := 0;
     Reportspanel.visible := false;

     if cashbookimportpayment then custsuppcodeexit(self);

     // TGM AB 01/01/15 - load QTY2/3 values into array
     if GEditing then begin
         for j:= 1 to MaxGridLines do begin
               QTY2Values[j] := ZQTY2[1][j];
               QTY3Values[j] := ZQTY3[1][j];
         end;
     end;

     CheckForSingleEnterprise;       // TGM AB 26/08/16

end;

Procedure SETVALS;
Begin						     { begin SETVALS }
    If ( ACT=62 ) THEN
       ZTOTAMT[2]:=ZTOTAMT[1]
    Else
       ZTOTAMT[2]:=0-ZTOTAMT[1];
    If ( ACT=62 ) Then
       ZAMT[2][1]:=ZAMT[1][1]
    Else
        ZAMT[2][1]:=0-ZAMT[1][1];
    ZBANK  [2]:=ZBANK  [1];
    ZTXDATE[2]:=ZTXDATE[1];
    ZDUESTR[2]:=ZDUESTR[1];
    ZDUEINT[2]:=ZDUEINT[1];
    ZREF   [2]:=ZREF   [1];
    ZCOMM  [2]:=ZCOMM  [1];
    ZUSE[2][1]:=ZUSE[1][1];
End;						     { end SETVALS }

Function MoveTxInfo ( Var Col, Row : LongInt ) : Boolean;
Var
   Nominal,
   Amount,
   VAT,
   VATCode,
   BankCode,
   Dummy,
   CorrectEntry : Boolean;
   GridPosOk    : Packed Array [1..MaxGridLines] Of Boolean;  // TENFOUND
   LineOK,
   LastLine,
   LineCount : Integer;
   TestStr   : ShortString;
   TempStr : ShortString;
Begin
     If NOT GEditing Then
        InitVals;

     For LineCount := 1 To MaxGridLines Do  // TENFOUND
         GridPosOk[Linecount] := False;

     MoveTxInfo := True;
     CorrectEntry := True;
     Col := 0;
     Row := 0;
     LastLine := -1;

     LineCount := 1;

     If (( PROG In [SALESTX, PURCHTX, CASHINC, CASHEXP]) And ( NOT ( ACT In [3,61,62] ))) Then
        While ( LineCount <= MaxGridLines ) And ( CorrectEntry ) Do  // TENFOUND
           Begin
              Nominal := True;
              Amount := True;
              VAT    := True;
              VATCode := True;

              If TestGridCell ( CashBookForm.DetailGrid.Cells[NomCol, LineCount] ) Then
                 Begin
                      { Only set if col hasn;t been Changed previously }
                      If Col = EntCol Then
                         Begin
                              Col := 1;
                              Row := LineCount;
                         End;
                      Nominal := False;
                 End;
              If TestGridCell ( CashBookForm.DetailGrid.Cells[AmtCol, LineCount] ) Then
                 Begin
                      { Only set if col hasn;t been Changed previously }
                      If Col = EntCol Then
                         Begin
                              Col := AmtCol;
                              Row := LineCount;
                         End;
                      Amount := False;
                 End;
              If TestGridCell ( CashBookForm.DetailGrid.Cells[VCodeCol, LineCount] ) Then
                 Begin
                      { Only set if col hasn;t been Changed previously }
                      If Col = EntCol Then
                         Begin
                              Col := VCodeCol;
                              Row := LineCount;
                         End;
                      VATCode := False;
                 End;
              If TestGridCell ( CashBookForm.DetailGrid.Cells[VAmtCol, LineCount] ) Then
                 Begin
                      { Only set if col hasn;t been Changed previously }
                      If Col = EntCol Then
                         Begin
                              Col := VAmtCol;
                              Row := LineCount;
                         End;
                      VAT := False;
                 End;

              If (( LineCount > 1 ) And
                  ( NOT Nominal ) And ( NOT Amount ) And
                  ( NOT VAT ) And ( NOT VatCode )) Then
                  { Line not in use or last line }
                 Begin
                    If LastLine = -1 Then
                       LastLine := LineCount-1;
                    CorrectEntry := True;
                    GridPosOk[LineCount] := False;
                 End
              Else
                  Begin
                       CorrectEntry := ( Nominal ) And ( Amount ) And
                                       ( VAT ) And ( VATCode );
                       GridPosOk[LineCount] := True;
                  End;
              Inc ( LineCount );
           End;

     If CorrectEntry Then     { Check Date }
        Begin
             TestStr := CashBookForm.TxDate.Text;
//             TestStr := CashBookForm.DateMask.Text;
             SlimAll ( TestStr );
             If Length ( TestStr ) > 0 Then
                If NOT DateValid ( TestStr, TDateFormat ) Then
                   CashBookForm.TxDate.SetFocus;
//                   CashBookForm.DateMask.SetFocus;
        End;

     If CorrectEntry Then
        Begin
             zComm[1] := CashBookForm.Comment.Text;
             zRef[1] := CashBookForm.Reference.Text;

             If PROG In [CASHINC,CASHEXP] Then
                Begin
                   TestStr := CashBookForm.BankAccount.Text;
                   SlimAll ( TestStr );
                   // TGM AB 09/08/02 adding cust/supp code into cashbook
                   ZAccount[1] := Cust_suppcode;

                   ZBank[1] := StrToInt ( TestStr );

                   Try
                      ZStub[1] := StrToInt ( CashBookForm.StubNo.Text );
                   Except
                      ZStub[1] := 0;
                   End;
                End
             else If ( PROG In [SALESTX,PURCHTX] ) And ( NOT ( ACT In [61,62] )) Then
                Begin
                   If CheckCustSupp ( CashBookForm.SalesPurchDB, CashBookForm.CustSuppCode.Text ) Then
                      Begin
                           TestStr := CashBookForm.CustSuppCode.Text;
                           SlimAll ( TestStr );
                           ZCustRec[1] := StrToInt ( TestStr );
                           ZAccount[1] := ZCustRec[1];
                        End
                   Else
                       Begin
                            CorrectEntry := False;
                            Col := SalesPurchaseCode;
                       End;

                   If ( ACT In [2,3] ) Then { Cash Sale/Purch or Receipt/Payment }
                      Begin
                           TestStr := CashBookForm.StubNo.Text;
                           SlimAll ( TestStr );
                           If Numeric ( TestStr ) Then
                              ZStub[1] := StrToInt ( TestStr );
                           TestStr := CashBookForm.BankAccount.Text;
                           SlimAll ( TestStr );
                           If Numeric ( TestStr ) Then
                              zBank[1] := StrToInt ( TestStr )
                           Else
                               CorrectEntry := False;
                      End;

                   If ACT = 3 Then { Receipt or PAyment }
                      Begin
                         TestStr := CashBookForm.BankAccount.Text;
                         SlimAll ( TestStr );
                         If Numeric ( TestStr ) Then
                            zBank[1] := StrToInt ( TestStr )
                         Else
                             CorrectEntry := False;
                         // next few lines added 21/05/02 to fix bug where saving using ALT S didn't insert decimal value if entry was a whole number
                         TempStr :=  CashBookForm.Discount.text;
                         If ChangeToLong ( TempStr ) Then
                         CashBookForm.Discount.text := TempStr;
                         TempStr :=  CashBookForm.AmtReceived.text;
                         If ChangeToLong ( TempStr ) Then
                         CashBookForm.AmtReceived.text := TempStr;
                         StrLong ( CashBookForm.StubNo.text, zStub[1] );
                         StrLong ( CashBookForm.Discount.text, zDiscount[1] );
                         StrLong ( CashBookForm.AmtReceived.text, zAmt[1,1] );
                      End;
                End
             Else If ( ACT In [61,62] ) Then
                  Begin
                       TestStr := CashBookForm.BankAccount.Text;
                       SlimAll ( TestStr );
                       ZBank[1] := StrToInt ( TestStr );
                       TestStr := CashBookForm.CustSuppFrom.Text;
                       SlimAll ( TestStr );
                       ZAccount[1] := StrToInt ( TestStr );
                       ZCustRec[1] := ZAccount[1];
                       TestStr := CashBookForm.CustSuppTo.Text;
                       SlimAll ( TestStr );
                       ZAccount[2] := StrToInt ( TestStr );
                       ZCustRec[2] := ZAccount[2];
                       StrLong ( CashBookForm.CustSuppAmount.Text, ZAmt[1,1] );
                       zUse[1,1] := True;
                  End;

             zTxDate[1] := KDateToInt ( CashBookform.TxDate.Text );
//             zTxDate[1] := KDateToInt ( CashBookform.DateMask.Text );
             LineOk := 0;
             If (( PROG In [SALESTX, PURCHTX, CASHINC, CASHEXP]) And ( NOT ( ACT In [3,61,62] ))) Then
               For LineCount := 1 To MaxGridLines{LastLine} Do  // TENFOUND
                 If GridPosOK[LineCount] Then
                   Begin
                      Inc ( LineOK );
                      zEnt[1,LineOK] := CashBookForm.DetailGrid.Cells[EntCol,Linecount];
                      zUse[1,LineOK] := True;
                      TestStr := CashBookForm.DetailGrid.Cells[NomCol, LineCount];
                      SlimAll ( TestStr );
                      ZGen[1,LineOK] := StrToInt ( TestStr );
                      ZDesc[1,LineOK] := CashBookForm.DetailGrid.Cells[DesCol, LineCount];

                      TestStr := CashBookForm.DetailGrid.Cells[QtyCol, LineCount];
                      If testStr = '' then TestStr := '1.00';
                      SlimAll ( TestStr );
                      Dummy := ChangeToLong ( TestStr );
                      StrLong ( TestStr, ZQty[1,LineOK] );

                      TestStr := CashBookForm.DetailGrid.Cells[AmtCol, LineCount];
                      SlimAll ( TestStr );
                      Dummy := ChangeToLong ( TestStr );
                      StrLong ( TestStr, ZAmt[1,LineOK] );

                      ZTax[1,LineOK] := CashBookForm.DetailGrid.Cells[VCodeCol, LineCount];

                      TestStr := CashBookForm.DetailGrid.Cells[VAmtCol, LineCount];
                      SlimAll ( TestStr );
                      Dummy := ChangeToLong ( TestStr );
                      StrLong ( TestStr, ZTaxAmt[1,LineOK] );


                      TestStr := CashBookForm.DetailGrid.Cells[ANCol, LineCount];
                      SlimAll ( TestStr );
                      Try
                         zAnalysis[1,LineOK] := StrToInt ( TestStr );
                      Except
                         zAnalysis[1,LineOk] := 0;
                      End;

                      // TGM AB 28/11/14 - copy in extra QTY data
                      ZQTY2[1][LineOK] := Qty2Values[LineOK];
                      ZQTY3[1][LineOK] := Qty3Values[LineOK];

                   End;
             CheckEnd;
        End;
     MoveTxInfo := CorrectEntry;
End;

procedure TCashBookForm.SaveClick(Sender: TObject);
Var
   BadCol,
   BadRow : LongInt;
   ErrText : String;
   NewDb,
   WasAct,
   WasProg,
   Counter2,
   Counter : Integer;
   Transdate : string; // TGM AB 11/06/02 - Used to hold date of last transaction & setup cursor position in date box
   UseDefaults : boolean;
   Registry : TRegistry;
   SaveInvoiceNumbers: Boolean;
   StartTxNo : integer;

begin

   if cash1.xyearend = true then begin
        if messagedlg('You are making changes to an archive set of accounts, are you sure you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
   end;

   AccsDataModule.AgeOfDebtSyncRequired := True;

   StartTxNo := 0;

   If GEditing then StartTxNo := TxEditRec.TransF
      else StartTxNo := Accsdatamodule.TransactionsDB.RecordCount + 1;


   If Gediting then SaveInvoiceNumbers := false
        else SaveInvoiceNumbers := true;
   try if StrToInt(BankAccount.text) > 0 then begin
       zbank[1] := StrToInt(BankAccount.text);
       Cash1.XLASTBANK := StrToInt(BankAccount.text);
       end;
   except
   end;

   If PROG In [CASHINC,CASHEXP] then begin
       if zbank[1] = 0 then begin
           showmessage('Error - Please Check Bank Account Number');
           exit;
       end;

   end;

   //Ch027 start

   If (( PROG In [SALESTX, PURCHTX, CASHINC, CASHEXP]) And ( NOT ( ACT In [3,61,62] )) and ( Gediting )) Then begin

         if CheckEditedGridLinesOK = false then begin
                                                        exit;
         end;

   end;

   //Ch027 end


     _SaveCancelled := false;
       // TGM AB MoveTxInfo moves all details form the grid into vars ready to be written to file
       // varibles are listed between ZTXDate - array and Zuser3 - array in TxWrite unit
    if MoveTxInfo ( BadCol, BadRow  ) Then
      begin
       // If MessageDlg(ReadLang ( 142, CurrLang ),mtInformation, [mbYes, mbNo], 0) = mrYes then
       //  Begin
       if CheckNominals = 0 then
       begin

           If GEditing Then
              Begin
                if (prog = cashinc) or (prog = cashexp) then act := 0;
                WriteTransactions ( 2, SalesPurchDB, 0, FALSE );
                WriteTransactions ( 1, SalesPurchDB, 0, FALSE );
                ResetPointers ( CashBookForm );
                { Exit the Form }
                Mainunit.FMainScreen.LoadTransactionGrid;
                CashBookForm.ExitButtonClick(Sender);
              End
           Else
              If ( ACT In [61,62] ) Then
                 Begin
                      SetVals;
                      WasAct := ACT;
                      WasProg := PROG;
                      ZStub[1] := 0;
                      ZStub[2] := 0;
                      Act := 3;
                      WriteTransactions( 1, SalesPurchDB, WasAct, FALSE );
                      If WasAct = 62 Then
                         If PROG = SalesTx Then
                            PROG := PURCHTX
                         Else
                            PROG := SALESTX;
                      If SalesPurchDB = SlFile Then
                         NewDb := PlFile
                      Else
                          NewDb := SlFile;
                      If WasAct = 62 Then
                         WriteTransactions ( 2, NewDb, WasAct, FALSE )
                      Else
                         WriteTransactions ( 2, SalesPurchDb,WasAct, FALSE );
                      ACT := WasAct;
                      PROG := WasProg;
                 End
             Else begin
                  if (((prog = SalesTX) or (Prog = PurchTx)) and (Act in [1,4])) then begin
                      ZStub[1] := 0;
                      ZStub[2] := 0;
                  end;
                  WriteTransactions ( 1, SalesPurchDB, 0, FALSE );
                  end;

              {
              registry:=Tregistry.Create;
              Registry.OpenKey('Software\Kingswood\Kingsacc\SLPLDefaults', True);
              if Registry.ReadString('SLPLDefaults') = 'True' then UseDefaults := true
              else UseDefaults := false;
              Registry.Free;
              }
              //   24/11/14 [V4.1 R7.6] /MK Bug Fix - Check for SLPLDefaults in new uPrefences key not old key.
              UseDefaults := Preferences.ValueAsBoolean[cPref_EnableSLPLDefaults];

              if ((Prog in [SALESTX,PURCHTX]) and (cash2.XAllocation))then begin
                 // Act 2 is a cash purchase / sale
                 // Act 3 is a sale receipt / purchase payment
                 if Act = 3 then begin

                                 if InvoiceAllocationPanel.Visible then begin
                                                                      //AllocateToInvoices(Currrec[TxFile]);//AllocateToInvoices(Currrec[TxFile]);
                                                                      setdb(txfile);
                                                                      AllocateToInvoices(TxWrite.TxNo)   //db1.DBRechigh
                                 end;
                                 if balancepanel.visible then begin
                                      setdb(txfile);
                                      AllocateToOpeningBalance(TxWrite.TxNo)   //db1.DBRechigh

                                 end;
                 end;
                 if Act = 2 then begin
                                       MarkInvoiceComplete(StartTxNo,True,false);

                 end;
              end;


              if (UseDefaults and Invoice.checked and (detailgrid.Visible)) then begin
                accsdatamodule.SLPLDefaults.open;
                if ((SalesPurchDB = 4) and  (accsdatamodule.SLPLDefaults.locate('SLPLCode;SLPLType',VarArrayOf([StrToInt(CustSuppCode.Text),'S']),[])) and (CustSuppCode.text <> ''))
                then begin
                     accsdatamodule.SLPLDefaults.edit;
                     accsdatamodule.SLPLDefaults['Comment'] := Comment.text;
                     accsdatamodule.SLPLDefaults['Nominal'] :=DetailGrid.Cells[NomCol, 1];
                     accsdatamodule.SLPLDefaults['Ent'] :=DetailGrid.Cells[EntCol, 1];
                     accsdatamodule.SLPLDefaults.post;
                end;
                if ((SalesPurchDB = 4) and  ( not accsdatamodule.SLPLDefaults.locate('SLPLCode;SLPLType',VarArrayOf([StrToInt(CustSuppCode.Text),'S']),[])) and (CustSuppCode.text <> ''))
                then begin
                     accsdatamodule.SLPLDefaults.append;
                     accsdatamodule.SLPLDefaults['SLPLCode'] := StrToInt(CustSuppCode.text);;
                     accsdatamodule.SLPLDefaults['SLPLType'] := 'S';
                     accsdatamodule.SLPLDefaults['Comment'] := Comment.text;
                     accsdatamodule.SLPLDefaults['Nominal'] :=DetailGrid.Cells[NomCol, 1];
                     accsdatamodule.SLPLDefaults['Ent'] :=DetailGrid.Cells[EntCol, 1];

                     accsdatamodule.SLPLDefaults.post;
                end;
                if ((SalesPurchDB = 5) and  (accsdatamodule.SLPLDefaults.locate('SLPLCode;SLPLType',VarArrayOf([StrToInt(CustSuppCode.Text),'P']),[])) and (CustSuppCode.text <> ''))
                then begin
                     accsdatamodule.SLPLDefaults.edit;
                     accsdatamodule.SLPLDefaults['Comment'] := Comment.text;
                     accsdatamodule.SLPLDefaults['Nominal'] :=DetailGrid.Cells[NomCol, 1];
                     accsdatamodule.SLPLDefaults['Ent'] :=DetailGrid.Cells[EntCol, 1];
                     accsdatamodule.SLPLDefaults.post;
                end;
                if ((SalesPurchDB = 5) and  ( not accsdatamodule.SLPLDefaults.locate('SLPLCode;SLPLType',VarArrayOf([StrToInt(CustSuppCode.Text),'P']),[])) and (CustSuppCode.text <> ''))
                then begin
                     accsdatamodule.SLPLDefaults.append;
                     accsdatamodule.SLPLDefaults['SLPLCode'] := StrToInt(CustSuppCode.text);;
                     accsdatamodule.SLPLDefaults['SLPLType'] := 'P';
                     accsdatamodule.SLPLDefaults['Comment'] := Comment.text;
                     accsdatamodule.SLPLDefaults['Nominal'] :=DetailGrid.Cells[NomCol, 1];
                     accsdatamodule.SLPLDefaults['Ent'] :=DetailGrid.Cells[EntCol, 1];
                     accsdatamodule.SLPLDefaults.post;
                end;

                accsdatamodule.SLPLDefaults.close;
             end;

             { Initialise the Grid }
             For Counter := 1 To MaxGridLines + 1 Do  // TENFOUND  WAS 11
                 For Counter2 := 0 To 25 do // changed to 25 to include Eachcol set out at 20  Detailgrid.ColCount Do           // TGM AB Changed from 7 to detailgrid.colcount
                     DetailGrid.Cells[Counter2,Counter] := '';
             Reference.Text := '';
             If AgedPanel.Visible = False Then
                Comment.Text := '';
             If StubNo.Visible = True Then
                Stubno.Text := '';
             AmtReceived.Text := '';
             Discount.Text := '';

             // TGM AB 23/01/15
             for counter:= 1 to MaxGridLines do begin
                      QTY2Values[counter] := 0;
                      QTY3Values[counter] := 0;
             end;
             // end TGM AB 23/01/15

             // clear to sales / to purchase

             if (ACT in [61,62]) then begin
                 CustSuppFrom.text := '';
                 CustSuppTo.text := '';
                 CustSuppAmount.text := '';
                 eFromName.text := '';
                 eFromBal.text := '';
                 eToName.text := '';
                 eToBal.text := '';
             end;

             DetailGrid.Row := 1;
             DetailGrid.Col := 0;
             ThisAmount:=0;
             ThisDiscount:=0;
             { Save the User entered date for next entry into accounts }
             if not Gediting then Cash11.Default_Date := TxDate.Text;
//             Cash11.Default_Date := DateMask.Text;
             DefWrite ( 11 );

             If not CashbookImportPayment then begin

             if ((invoicer) and (PrintInvoice.Visible) and (Invoice.checked) and (jobcardpanel.visible = false) and (proformapanel.visible = false) and SaveInvoiceNumbers and (Prog = SalesTX)) then begin
                if invoiceNumber > 0 then begin
                   accsdatamodule.InvoiceNumbers.edit;
                   accsdatamodule.InvoiceNumbers['lastSaleInv']:=invoiceNumber;
                   accsdatamodule.InvoiceNumbers.post;
                   invoicenumber := 0;
                end;
             end;
             if ((invoicer) and (PrintInvoice.Visible) and (CashInvoice.checked) and (jobcardpanel.visible = false) and (proformapanel.visible = false) and SaveInvoiceNumbers and (Prog = SalesTX)) then begin
                if invoiceNumber > 0 then begin
                   accsdatamodule.InvoiceNumbers.edit;
                   accsdatamodule.InvoiceNumbers['lastSaleInv']:=invoiceNumber;
                   accsdatamodule.InvoiceNumbers.post;
                   invoicenumber := 0;
                end;
             end;
             if ((invoicer) and (PrintInvoice.Visible) and (CreditNote.checked) and (jobcardpanel.visible = false) and (proformapanel.visible = false) and SaveInvoiceNumbers and (Prog = SalesTX)) then begin
                if invoiceNumber > 0 then begin
                   accsdatamodule.InvoiceNumbers.edit;
                   accsdatamodule.InvoiceNumbers['lastSaleCred']:=invoiceNumber;
                   accsdatamodule.InvoiceNumbers.post;
                   invoicenumber := 0;
                end;
             end;
             if ((invoicer) and (FileExists(Accsdata.AccsDataModule.AccsDataBase.Directory + 'pinvoice')) and SaveInvoiceNumbers and (Prog = PurchTX)) then begin
                if invoiceNumber > 0 then begin
                   accsdatamodule.InvoiceNumbers.edit;
                   accsdatamodule.InvoiceNumbers['LastPurchInv']:=invoiceNumber;
                   accsdatamodule.InvoiceNumbers.post;
                   invoicenumber := 0;
                end;
             end;   // End TGM AB
                If CustSuppCode.Visible = True Then
                   CustSuppCode.SetFocus
                Else
                    BankAccount.SetFocus;
             end;

             // TGM AB 08/07/02 - saving invoice number as last used


             if cashbookimportpayment then custsuppcodeexit(self);

        end
      else
         showmessage('Invalid Nominal Code - ' + vartostr(Checknominals)); // checknominals
         //End else _SaveCancelled := true;  // comment tgm 15/12/01  this is the end of the Yes/No dialogue where yes was chosen
      End
    Else
        Begin
              if BadCol = NomCol then ErrText          := 'Nominal Code'
              else if BadCol = AmtCol then ErrText          := 'Amount'
                   else if BadCol = VCodeCol then  ErrText       := 'VAT Code'
                        else if BadCol = VAmtCol then ErrText := 'VAT Amount'
                           else if BadCol = BankCode then ErrText := 'Bank Account'
                             else if BadCol = SalesPurchaseCode then ErrText := 'Customer/Supplier'
                                  else ErrText := 'UnKnown Field';

	      MessageDlg('Missing ' + ErrText, mtInformation,[mbOK], 0);

              if ((BadCol = NomCol) or (BadCol = AmtCol) or (BadCol = VCodeCol) or (BadCol = VAmtCol)) then Begin
                                            DetailGrid.Col := BadCol;
                                            DetailGrid.Row := BadRow;
                                            DetailGrid.SetFocus;
              end;
               if (BadCol = SalesPurchaseCode) then CustSuppCode.SetFocus;


        End;

    // TGM AB 11/06/02 - Next 5 lines reset position of the cursor in the date box to the start
    transdate := txdate.Text;
    txdate.Enabled := false;
    txdate.text := '';
    txdate.text := transdate;
    txdate.enabled := true;

    try custsuppcodeexit(self);
    except
    end;

    AmtReceived.text := '';
    Discount.text := '';
    Try
        AllocAmount.text := '';
        AllocDiscount.text := '';
    except
    end;


end;

procedure TCashBookForm.FormDeactivate(Sender: TObject);
Var
   PCount : Integer;
begin
   With TxEditRec Do
      Begin
           TransF := 0;
           TransT := 0;
           TransType := '  ';
           NoRecs    := 0;
      End;

   GEditing := False;

   AccsDataModule.DisposeTransPointers;

  //    17/01/12 [V4.1 R1.2] /MK Change - Old Dispose Pointers Code Not Setting TxHold/NomHold To Nil.
  {
  For PCount := 1 To MaxTx Do
      Dispose ( TxHold[PCount] );
  For PCount := 1 To MaxNom Do
      Dispose ( NomHold[PCount] );
  }
//     FMainScreen.Visible := True;

end;

procedure TCashBookForm.ExitButtonClick(Sender: TObject);
begin
     // TGM AB 19/02/02 Added to terminate application when running with parameters
     if param_start = true then begin
                                if ((param_type = 'S') or (Param_type = 'P')) then begin
                                                                                   // DataExport.CompleteExport;
                                                                                   // accsdatamodule.CloseAllFiles;
                                                                                   application.terminate;
                                end
                                   else close;
                                end
     else Close;

end;

procedure TCashBookForm.BankAccountEnter(Sender: TObject);
begin
     If ( NOT Numeric ( BankAccount.Text )) Then
        BankAccount.Text := IntToStr ( Cash1.xLastBank );
     PromptLine.Panels.Items[1].Text := 'Press F2 or Double Click to List Accounts';
end;

Procedure ListVAT;
Begin
     NewListBox.ListInfo.ActiveDb := 0;
     NewListBox.ListInfo.ListType := 'V';
     InitRange ( NewListBox.ListInfo.AccRange );
     NewListBox.ShowModal;
End;

procedure TCashBookForm.BankAccountKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    If Key = VK_F2 Then    { F2 Pressed }
       Begin
         NewListBox.ListIt ( Sender, Banks, 'N' );
         If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
            BankAccount.Text := NewListBox.ListInfo.ReturnValue;
         Key := 0;
       End;
end;

procedure TCashBookForm.DetailGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var
   CheckStr,
   OrigVat : ShortString;
   cellvalue:string;
begin
         if ((((key > 64) and (key < 91)) or ((key >96) and (Key <123))) and (DetailGrid.col = NomCol)
     and not (key in [VK_F1,VK_F2,VK_F3,VK_F4,VK_F5,VK_F6,VK_F7,
                      VK_NUMPAD1,VK_NUMPAD2,VK_NUMPAD3,VK_NUMPAD4,VK_NUMPAD5,VK_NUMPAD6,VK_NUMPAD7,VK_NUMPAD8,VK_NUMPAD9,VK_NUMPAD0])) then begin
                          NewListbox.InitialSearchFieldText := chr(key);
                          NewListBox.ListInfo.Ent := DetailGrid.Cells[EntCol,DetailGrid.Row];
                          SlimAll ( NewListBox.ListInfo.Ent );
                          If Length ( NewListBox.ListInfo.Ent ) > 0 Then
                             Begin
                                NewListBox.ListIt ( Sender, EntRange, 'N' );   { Nominal Ledger Accounts }
                                DetailGrid.Col := DetailGrid.Col+1;
                             End
                          Else
                             Begin
                                NewListBox.ListIt ( Sender, AllNoms, 'N' );   { Nominal Ledger Accounts }
                                DetailGrid.Col := DetailGrid.Col+1;
                             End;
                          If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
                             Begin
                                  DetailGrid.Cells[NomCol,DetailGrid.Row] := NewListBox.ListInfo.ReturnValue;
                                  DetailGrid.Cells[DesCol,DetailGrid.Row] :=
                                    GetAccountName ( NewListBox.ListInfo.ActiveDb,
                                       StrToInt ( NewListBox.ListInfo.ReturnValue ), 1 );
                                  DetailGrid.Cells[VCodeCol,DetailGrid.Row] :=
                                     GetAccountName ( NewListBox.ListInfo.ActiveDb,
                                       StrToInt ( NewListBox.ListInfo.ReturnValue ), 20 );
                             End;


     end;

   if Key = VK_F2 Then    { F2 Pressed }
       Begin
                 if DetailGrid.Col = EntCol then Begin   { Enterprise Column }
                          NewListBox.ListIt ( Sender, Enterprise, 'E' );   { Enterprise Accounts }
                          If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
                             Begin
                                DetailGrid.Cells[EntCol,DetailGrid.Row] := NewListBox.ListInfo.ReturnValue;
                                DetailGrid.Col := DetailGrid.Col+1;
                             End;
                 End else
                 if DetailGrid.Col = NomCol then Begin   { Nominal Ledger Column }
                          NewListBox.ListInfo.Ent := DetailGrid.Cells[EntCol,DetailGrid.Row];
                          SlimAll ( NewListBox.ListInfo.Ent );
                          If Length ( NewListBox.ListInfo.Ent ) > 0 Then
                             Begin
                                NewListBox.ListIt ( Sender, EntRange, 'N' );   { Nominal Ledger Accounts }
                                DetailGrid.Col := DetailGrid.Col+1;
                             End
                          Else
                             Begin // TGM AB 13/02/09
                                if cash11.Xuse_enterprise = false then begin
                                        if prog = salestx then NewListBox.ListIt ( Sender, NonEntToLiab, 'N' )
                                           else if prog = purchtx then NewListBox.ListIt ( Sender, OverheadsToLiab, 'N' )
                                                else NewListBox.ListIt ( Sender, AllNoms, 'N' );
                                        DetailGrid.Col := DetailGrid.Col+1;
                                end else
                                        begin
                                              NewListBox.ListIt ( Sender, AllNoms, 'N' );   { Nominal Ledger Accounts }
                                              DetailGrid.Col := DetailGrid.Col+1;
                                        end;
                             End;
                          If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
                             Begin
                                  DetailGrid.Cells[NomCol,DetailGrid.Row] := NewListBox.ListInfo.ReturnValue;
                                  DetailGrid.Cells[DesCol,DetailGrid.Row] :=
                                    GetAccountName ( NewListBox.ListInfo.ActiveDb,
                                       StrToInt ( NewListBox.ListInfo.ReturnValue ), 1 );
                                  DetailGrid.Cells[VCodeCol,DetailGrid.Row] :=
                                     GetAccountName ( NewListBox.ListInfo.ActiveDb,
                                       StrToInt ( NewListBox.ListInfo.ReturnValue ), 20 );
                             End;
                 End else
                 if DetailGrid.Col = VCodeCol then Begin   { VAT Column }
                          OrigVat := DetailGrid.Cells[VCodeCol,DetailGrid.Row];
                          SlimAll ( OrigVat );
                          NewListBox.ListIt ( Sender, Vat, 'V' );   { VAT Rates }
                          If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
                             begin
                                DetailGrid.Cells[VCodeCol,DetailGrid.Row] := NewListBox.ListInfo.ReturnValue;
                                DetailGrid.Col := DetailGrid.Col+1;
                                CheckVatForChanges((OrigVat <> DetailGrid.Cells[VCodeCol,DetailGrid.Row]));
                             end;
                 End else
                 if DetailGrid.Col = ANCol then Begin   { Analysis Codes }
                          if not bool(SetupAnalysisForm) then Application.CreateForm(TSetupAnalysisForm, SetupAnalysisForm);
                          SetupAnalysisForm.ShowWindow(1);
                           DetailGrid.Cells[ANCol,DetailGrid.Row] := Setupanalysisform.selectedcode;

                          // TGM AB removed with the introduction of new paradox table
                          (* ListBox.ListIt ( Sender, Analysis, 'A' );   { Nominal Ledger Accounts }
                          If Length ( ListBox.ListInfo.ReturnValue ) > 0 Then
                             DetailGrid.Cells[ANCol,DetailGrid.Row] := ListBox.ListInfo.ReturnValue;
                             *)
                 End;

                Key := 0;
       End;
   If ((Key = VK_F6) and (not Invoicer)) then
      begin
           if DetailGrid.Col = QtyCol then { Quantity Column }
              CallCalcAmt;
           Key := 0;
      end;
   If Key = VK_F5 then
      Begin
            if ((DetailGrid.Col = Amtcol) or (DetailGrid.Col =EachCol)) then
                  DetailGrid.Cells[DetailGrid.Col, DetailGrid.Row] := EuroConvert ( DetailGrid.Cells[DetailGrid.Col, DetailGrid.Row] );

            Key := 0;
      End;

   If Key = VK_F1 then
      Begin

            if DetailGrid.Col = EntCol then Application.HelpContext(51);  {Ents}
            if DetailGrid.Col =  NomCol then Application.HelpContext(8);   {Nominal}
            if DetailGrid.Col = DesCol then Application.HelpContext(9);   {Description}
            if DetailGrid.Col = QtyCol then Application.HelpContext(10);  {Quantity}
            if DetailGrid.Col = AmtCol then Application.HelpContext(11);  {Amount}
            if DetailGrid.Col = VCodeCol then Application.HelpContext(12);  {VATCode}
            if DetailGrid.Col = VAmtCol then Application.HelpContext(14);  {VATAMount}
            if DetailGrid.Col = ANCol then Application.HelpContext(13);  {Analysis}

            Key := 0;
      end;

      if ( Key = VK_F7 ) and ( NOT Cash11.xBilling ) then    { F7 Pressed }
      GetExtraDetails(true);
end;

procedure TCashBookForm.GetExtraDetails(Showpanel : boolean);
var
   CheckStr, Tempstr : ShortString;
   TempLong : Real;
   TempStr2 : ShortString;
   ErrorCode : integer;
begin
     // line below added by GM 29/09/03 to prevent extra desc panel from being shown in non invoicer systems
//     if not invoicer then showpanel := false;
    CheckStr := DetailGrid.Cells[NomCol,DetailGrid.Row];
    if pExtraDesc.Showing then
       pExtraDesc.Hide
    // check the Nominal Account has been filled in
    else if ( DetailGrid.Cells[NomCol,DetailGrid.Row] <> '' ) and
            ( Numeric(CheckStr)) then
       // Show the Panel
       begin
            if GEditing then AccsDataModule.ProdsTxTemp.edit;
          // try and find a record for this line
          if NOT AccsDataModule.ProdsTxTemp.Locate('LineNo',DetailGrid.Row,[] ) then
             begin

                if AccsDataModule.NominalList.Locate('Account',DetailGrid.Cells[NomCol,DetailGrid.Row],[] ) then begin
                   //if Numeric(CheckStr) then begin
                   AccsDataModule.ProdsTxTemp.Append;
                   AccsDataModule.ProdsTxTemp.FieldByName('LineNo').AsInteger := DetailGrid.Row;
                   TempStr2 := '';
                   // check Nomlisting for associated Product Record
                   if AccsDataModule.Products.Locate('ID',AccsDataModule.NominalList.FieldByName('Product').AsVariant,[] ) then
                      begin
                         {AccsDataModule.ProdsTxTemp.Append;
                         AccsDataModule.ProdsTxTemp.FieldByName('LineNo').AsInteger := DetailGrid.Row;
                         TempStr2 := '';}
                         try TempLong := AccsDataModule.Products['Defaultprice']
                         except
                         TempLong := 0.00;
                         end;
                         Str(TempLong:8:3,TempStr2);          // TGM AB 04/08/17 was 8:2
                         Slimall (TempStr2);                   // TGM AB 04/08/17 was Tempstr
                         DetailGrid.Cells[EachCol,DetailGrid.Row] := TempStr2;
                         AccsDataModule.ProdsTxTemp.FieldByName('Desc1').AsString := AccsDataModule.Products.FieldByName('Desc1').AsString;
                         AccsDataModule.ProdsTxTemp.FieldByName('Desc2').AsString := AccsDataModule.Products.FieldByName('Desc2').AsString;
                         AccsDataModule.ProdsTxTemp.FieldByName('Desc3').AsString := AccsDataModule.Products.FieldByName('Desc3').AsString;
                         AccsDataModule.ProdsTxTemp.FieldByName('ProductID').AsInteger := AccsDataModule.Products.FieldByName('ID').AsInteger;
                         //AccsDataModule.ProdsTxTemp.Post;
                     //    DefaultProduct := AccsDataModule.ProductsID.AsInteger;
                         DefaultProduct := AccsDataModule.Products['ID'];
                         cbProducts.KeyValue := AccsDataModule.ProdsTxTemp['ProductID'];

                         // SP 29/05/2015
                         productsEdit.Text := cbProducts.Text;
                         end else
                      begin
                         cbProducts.KeyValue := 0;
                         DefaultProduct := 0;

                         // SP 29/05/2015
                         productsEdit.Text := '';
                      end;

                end;
             end
          else
             begin
                  AccsDataModule.ProdsTxTemp.edit;
                if (AccsDataModule.ProdsTxTemp['ProductID'] > 0) then begin
                   cbProducts.KeyValue := AccsDataModule.ProdsTxTemp.FieldByName('ProductID').AsInteger;
                   DefaultProduct := AccsDataModule.ProdsTxTemp['ProductID'];

                   // SP 29/05/2015
                   productsEdit.Text := cbProducts.Text;
                end else
                begin
                     cbProducts.KeyValue := '0';
                     DefaultProduct := 0;

                   // SP 29/05/2015
                   productsEdit.Text := cbProducts.Text;
                end;
             end;

          pExtraDesc.Top := 264+120;
          // Show the Extract Description for the selected Nominal Account
          case DetailGrid.Row of
             1 : pExtraDesc.Top := 264;
             2 : pExtraDesc.Top := 264+21;
             3 : pExtraDesc.Top := 264+42;
             4 : pExtraDesc.Top := 264+63;
             5 : pExtraDesc.Top := 264+84;
             6 : pExtraDesc.Top := 264+105;
          end;
          if showpanel then begin
                                 pExtraDesc.Show;
                                 meLineDate.SetFocus;
          end;
          if (invoicer and (not showpanel)) then Detailgrid.Cells[DetailCol,DetailGrid.row] :=  copy(varToStr(AccsDataModule.ProdsTxTemp['LineDate']),1,6)+ copy(varToStr(AccsDataModule.ProdsTxTemp['LineDate']),9,2) + ' ' + LineRef.text + ' ' + dbedesc1.Text;
       end
    else
       ShowMessage('No Nominal Account Code Selected OR Invalid Nominal Code');
end;

procedure TCashBookForm.DetailGridDrawCell(Sender: TObject; Col,
  Row: Longint; Rect: TRect; State: TGridDrawState);
Var
   AccRange : TAccRange;
   TestString : String;
begin

     If ( NOT GEditIng ) And ( Row > 0 ) Then
        Begin

             if col = NomCol then Begin
                     if DetailGrid.Cells[Col,Row] = '900' then begin
                        DetailGrid.Col := Col;
                     end;
                     AccRange := GetEntRanges ( CashBookForm.DetailGrid.Cells[EntCol, Row] );
                     If NOT NewListBox.CheckNom ( DetailGrid.Cells[Col,Row], AccRange ) Then
                        Begin
                           DetailGrid.Col := Col;
                           DetailGrid.Row := Row;
                        End
                     Else begin     // puts negative sign in amount box
                     TestString := '';
                     TestString := NewListBox.NegitiveFlag ( DetailGrid.Cells[Col, Row], DetailGrid.Cells[AmtCol, Row] );
                     DetailGrid.Cells[AmtCol, Row] := Teststring;
                     if (TestString = '-') then begin
                               if PROG = SalesTX then showmessage('This is An Expense Code in the Sales Screen' +#10#13 + 'Remember to put a minus sign in if you wish this line to be a deduction.' )
                               else if Prog = PurchTx then showmessage ('This is an Income code in the Purchase Screen' +#10#13 + 'Remember to put a minus sign in if you wish this line to be a deduction.');
                           end;
                     end;

                     // if the Comment is empty and the user specified they want to copy
                     // the Last nominal Description into the Comment
                     if ( PROG In [PurchTx,SalesTx] ) and ( Cash11.xUseLastNomDesc ) and
                        ( Row >= LastRow ) and ( Length( Comment.Text ) = 0 ) then
                        Comment.Text := DetailGrid.Cells[DesCol,Row];
                   End;
               {
               AmtCol : begin
                      OLDAmt := CashBookForm.DetailGrid.Cells[Col,Row];
                      edit1.Text := 'Old Amt ' + OldAmt;
                   end;
               VCodeCol : begin
                      OLDVat := CashBookForm.DetailGrid.Cells[Col,Row];
                      edit1.Text := 'Old VAT Code ' + OldVat;
                   end;
               VAmtCol : begin
                      OLDVatAmt := CashBookForm.DetailGrid.Cells[Col,Row];
                      edit1.Text := 'Old VAT Amt ' + OldVatAmt;
                   end;
               }
               {
               AmtCol : If LastRow > 0 Then OLDAmt := CashBookForm.DetailGrid.Cells[AmtCol, LastRow];
               VCodeCol : If LastRow > 0 Then OLDVat := CashBookForm.DetailGrid.Cells[VCodeCol, LastRow];
               VAmtCol : If LastRow > 0 Then OLDVatAmt := CashBookForm.DetailGrid.Cells[VAmtCol, LastRow];
               }
        end
     else
         if ( Row > 0 ) then
            begin
               {
               case Col Of
                  AmtCol : if LastRow > 0 then OLDAmt := CashBookForm.DetailGrid.Cells[AmtCol, LastRow];
                  VCodeCol : if LastRow > 0 then OLDVat := CashBookForm.DetailGrid.Cells[VCodeCol, LastRow];
                  VAmtCol : If LastRow > 0 Then OLDVatAmt := CashBookForm.DetailGrid.Cells[VAmtCol, LastRow];
               end;
               }
            end;

     // TGM AB 26/08/16 - check and add enterprise on systems with only a single enterprise code

//     if ((DetailGrid.Col = EntCol) and (SingleEnterprise)) then begin

       if ((DetailGrid.Col = EntCol) and (SingleEnterprise) ) then begin

          if DetailGrid.Enabled then begin      // TGM AB 18/11/16

               DetailGrid.SetFocus;

               if DetailGrid.Cells[EntCol,DetailGrid.Row] = '' then begin
                  DetailGrid.Cells[EntCol,DetailGrid.Row] := SingleEnterpriseCode;
                  DetailGrid.SetFocus;
               end;
          end;                                  // TGM AB 18/11/16
     end;

     // end TGM AB 26/08/16
end;

Procedure TotalSoFar;
Var
   x : Integer;
   TempLong,
   TotalVAT,
   TotalLessVAT,
   TotalAMT          : LongInt;
   ST                : ShortString;
Begin
     TotalVAT     := 0;
     TotalLessVAT := 0;
     For x := 1 To MaxGridLines Do // TENFOUND
         Begin
              TempLong := 0;
              ST := CashBookForm.DetailGrid.Cells[AmtCol,x];
              If ChangeToLong ( ST ) Then
                 StrLong ( St, TempLong );
              TotalLessVat := TotalLessVat + TempLong;
              TempLong := 0;
              ST := CashBookForm.DetailGrid.Cells[VAmtCol,x];
              If ChangeToLong ( ST ) Then
                 StrLong ( St, TempLong );
              TotalVat := TotalVat + TempLong;
         End;
     TotalAMT := TotalVAT + TotalLessVAT;
     LongStr ( TotalLessVAT, ST, 'L' );
     CashBookForm.TotalLessVAT.Text := ST;
     LongStr ( TotalVAT, ST, 'L' );
     CashBookForm.TotalVAT.Text := ST;
     LongStr ( TotalAmt, ST, 'L' );
     CashBookForm.TotalAmt.Text := St;
End;

Function RowOK ( LastCol, LastRow, Row : LongInt; Var BadCol : LongInt ) : Boolean;
Var
   Nominal,
   Amount,
   VAT,
   VATCode,
   Qty  : Boolean;

Begin
     BadCol    := -1;
{-->>     RowOK     := False;}
     Nominal   := True;
     Amount    := True;
     VATCode   := True;
     VAT       := True;
     Qty := true;

     If TestGridCell ( CashBookForm.DetailGrid.Cells[NomCol, LastRow] ) Then
        Begin
             If BadCol = -1 Then
                BadCol := 1;
             Nominal := False;
        End;
     If TestGridCell ( CashBookForm.DetailGrid.Cells[AmtCol, LastRow] ) Then
        Begin
             If BadCol = -1 Then
                BadCol := AmtCol;
             Amount := False;
        End;
     If TestGridCell ( CashBookForm.DetailGrid.Cells[VCodeCol, LastRow] ) Then
        Begin
             If BadCol = -1 Then
                BadCol := VCodeCol;
             VATCode := False;
        End;
     If TestGridCell ( CashBookForm.DetailGrid.Cells[VAmtCol, LastRow] ) Then
        Begin
             If BadCol = -1 Then
                BadCol := VAmtCol;
             VAT := False;
        End;
     If TestGridCell ( CashBookForm.DetailGrid.Cells[QtyCol, LastRow] ) Then
        Begin
             If BadCol = -1 Then
                BadCol := QtyCol;
             Qty := False;
        End;


     If {( Row >= LastRow ) And} ( NOT Nominal ) And ( NOT Amount ) And
        ( NOT VAT ) And ( NOT VATCode ) Then  { Line not in use }
        RowOK := True
     Else
         RowOK := ( Nominal ) And ( Amount ) And ( VAT ) And ( VATCode );

//     TotalSoFar;

End;

procedure TCashBookForm.DetailGridSelectCell(Sender: TObject; Col,
  Row: Longint; var CanSelect: Boolean);
Var
   RecNo     : Integer;
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

   sel: TRect;   // TGM AB 07/11/14

   begin

          // TGM AB 07/11/14 New Code for Multi Qty transaction button within cell - only on ledger entry / editing

          If ((Col = QtyCol) and (Tasknumber < 2)) then begin            // Tasknumber 1 - ledger , 0 - Editing
                Sel := DetailGrid.CellRect(col, row);
                SetWindowPos(ExtraQtysBtn.Handle, { handle }
                0,
                (DetailGrid.Left + 1) + ((Sel.Right )- (sel.Bottom-sel.Top)),
                Sel.Top + DetailGrid.top + 2,
                (sel.Bottom-sel.Top),
                Sel.Bottom - Sel.top ,
                SWP_NOZORDER or SWP_SHOWWINDOW);
                col := Col;
                Row := Row;
                ExtraQtysBtn.Show;
          end else ExtraQtysBtn.Hide;

          // End TGM AB

          if lastcol = EntCol then Begin
                   TempStr := DetailGrid.Cells[LastCol, LastRow];
                   SlimAll ( TempStr );
                   If Length ( TempStr ) > 0 Then
                      If NOT CheckEnt ( DetailGrid.Cells[LastCol,LastRow], RecNo ) Then
                         CanSelect := False;
              End;
          if lastcol = NomCol then Begin
                   TempStr := DetailGrid.Cells[LastCol, LastRow];
                   SlimAll ( TempStr );
                   If Tempstr = '0' then begin
                       showmessage('Invalid Nominal Code Specified');
                       DetailGrid.Cells[NomCol, LastRow] := '';
                       exit;
                   end;
                   TempName := DetailGrid.Cells[LastCol+1, LastRow];
                   SlimAll ( TempName );
                   If Numeric ( TempStr ) Then
                      Begin
                         If Length ( TempName ) = 0 Then
                            DetailGrid.Cells[LastCol+1, LastRow] :=
                               GetAccountName ( NlFile, StrToInt ( TempStr ), 1 );
                         TempVATStr := DetailGrid.Cells[VCodeCol, LastRow];
                         SlimAll ( TempVATStr );
                         If Length ( TempVATStr ) = 0 Then
                            DetailGrid.Cells[VCodeCol, LastRow] :=
                                GetAccountName ( NlFile, StrToInt ( TempStr ), 20 );
                      End;
              End;
          if lastcol = QtyCol then Begin
                   TempStr := DetailGrid.Cells[LastCol, LastRow];
                   SlimAll ( TempStr );
                   if Length ( TempStr ) > 0 then
                      if NOT ChangeToLong ( TempStr ) then
                         CanSelect := False
                      else
                          DetailGrid.Cells[LastCol, LastRow] := TempStr;
                   If {(Invoicer and }(not Gediting){)} then CalculateAmount(self); // TGM AB 13/06/02                 // TGM AB 11/11/16
                   If {((Invoicer) and} (not isvatcodeinclusive(LastRow)){)} then IsVatCalculated[LastRow] := FALSE;       // TGM AB 11/11/16    



              End;
          if lastcol = AmtCol then Begin
                   TempStr := DetailGrid.Cells[LastCol, LastRow];
                   SlimAll ( TempStr );

                   if Length ( TempStr ) > 0 then
                      { Check for minus sign and no numbers begin entered }
                      if NOT (( Length ( TempStr ) = 1 ) And ( TempStr = '-' )) Then
                         begin
                            if NOT ChangeToLong ( TempStr ) then
                               begin
                                  CanSelect := False;
                                  DetailGrid.Cells[LastCol, LastRow] := '0';
                               end
                            else
                                begin
                                   // NewAmt := TempStr;
                                   {
                                   If NewAmt <> OldAmt Then
                                      begin
                                         DetailGrid.Cells[VAmtCol, Lastrow] := '0';
                                         IsVatCalculated[LastRow] := FALSE;
                                         OldAmt := NewAmt;
                                      end;
                                   }
                                   // TempStr := ListBox.NegitiveFlag ( DetailGrid.Cells[NomCol, LastRow], TempStr );
                                   ChangeToLong ( TempStr );
                                   DetailGrid.Cells[LastCol, LastRow] := TempStr;
                                end;
                         end;
                      // TGM AB 14/06/02 validation for Each Column
                     { if invoicer then } CalculateUnitCost(LastRow,true);          // TGM AB 11/11/16
              End;
          if lastcol = VCodeCol then Begin
                   TempStr := DetailGrid.Cells[LastCol, Lastrow];
                   SlimAll ( TempStr );

                   if Length(TempStr) > 0 then
                      begin
                         // NewVAT := TempStr;
                         if ( NOT NewListBox.CheckVAT ( TempStr, VATArrPos )) then
                            begin
                               CanSelect := False;
                               DetailGrid.Cells[LastCol, LastRow] := ' ';
                            end;
                         {
                         else if NewVAT <> OldVAT Then
                            begin
                               DetailGrid.Cells[VAmtCol, Lastrow] := '0';
                               IsVatCalculated[LastRow] := FALSE;
                               OldVAT := NewVAT;
                            end;
                         }
                      end;
                    // TGM AB 14/06/02 validation for Each Column
                    if {((invoicer) and } (not isvatcodeinclusive(lastrow)){)} then CalculateUnitCost(lastrow,false);      // TGM AB 11/11/16   
              End;
          if lastcol = VAmtCol then Begin
                   TempStr := DetailGrid.Cells[LastCol, LastRow];
                   SlimAll ( TempStr );
                   {
                   if Length ( TempStr ) > 0 then
                      if NOT ChangeToLong ( TempStr ) then
                         CanSelect := False
                      else
                          DetailGrid.Cells[LastCol, LastRow] := TempStr;
                   }
                   if Length ( TempStr ) > 0 then
                      { Check for minus sign and no numbers begin entered
                      if NOT (( Length ( TempStr ) = 1 ) And ( TempStr = '-' )) Then
                      }
                         begin
                            if NOT ChangeToLong ( TempStr ) then
                               begin
                                  CanSelect := False;
                                  DetailGrid.Cells[LastCol, LastRow] := '0';
                               end
                            else
                                Begin
                                   // NewVATAmt := TempStr;
                                   // TempStr := ListBox.NegitiveFlag ( DetailGrid.Cells[1, LastRow], TempStr );
                                   // DetailGrid.Cells[LastCol, LastRow] := TempStr;
                                   {
                                   if NewVATAmt <> OldVATAmt then
                                      begin
                                         DetailGrid.Cells[VAmtCol, Lastrow] := '0';
                                         IsVatCalculated[LastRow] := FALSE;
                                         //OldVatAmt := NewVatAmt;
                                      end;
                                   }
                                End;
                         End;
              End;
          if lastcol = ANCol then Begin
                   TempStr := DetailGrid.Cells[LastCol, LastRow];
                   SlimAll ( TempStr );
                   If Length ( TempStr ) > 0 Then
                      If NOT Numeric ( TempStr ) Then
                         CanSelect := False;
              End;

          if lastcol = EachCol then Begin // TGM AB 13/06/02
                     TempStr := DetailGrid.Cells[LastCol, LastRow];
                     SlimAll ( TempStr );
                     if Length ( TempStr ) > 0 then
                     if NOT IsNumber ( TempStr ) then                   // TGM AB 04/08/17 ChangeToLong
                          CanSelect := False
                                   else
                                        DetailGrid.Cells[LastCol, LastRow] := TempStr;


                     if (invoicer and (tasknumber <> 1)) then  CalculateAmount(self);
                     if ((Invoicer) and (not isvatcodeinclusive(LastRow))) then IsVatCalculated[LastRow] := FALSE;

              End;
     CheckVatForChanges(False);
     TotalSoFar;

     if ( Row <> LastRow ) And ( LastRow <> -1 ) Then
        if NOT RowOK ( LastCol, LastRow, Row, BadCol ) Then
           begin
              if BadCol = NomCol then ErrText := 'Nominal Code'
              else if BadCol = AmtCol then ErrText := 'Amount'
                   else if BadCol = VCodeCol then ErrText := 'VAT Code'
                        else if BadCol = VAmtCol then ErrText := 'VAT Amount'
                             else if BadCol = QtyCol then ErrText := 'Qty'
                                  else ErrText := 'UnKnown Field';
              // if BadCol = VAmtCol then IsVATCalculated[LastRow] := FALSE;
	      MessageDlg('Missing ' + ErrText, mtInformation,[mbOK], 0);
              CanSelect := False;
           end;
     if CanSelect = False then GridOK := false else GridOK := true;
     if DetailGrid.cells[NomCol,Row] <> '' then if DetailGrid.cells[AnCol,Row] = '' then DetailGrid.cells[AnCol,Row] := '0';
end;

procedure TCashBookForm.BankAccountExit(Sender: TObject);
Var
   TestStr  : ShortString;
   AccRange : TAccRange;
   TempLong : LongInt;

   Procedure GetBankInfo;
   Begin
        SetDb ( NlFile );
        ReadRec ( NlFile, StrToInt ( TestStr ));
        dberr;
        If RecActive ( NlFile ) Then
           Begin
              GetItem ( NlFile, 1 );
              BankNameLabel.Caption := CurrStr;
              If Cash1.xShowBank Then
                 Begin
                    GetItem ( NlFile, 2 );
                    ThisBankBalance := CurrLong;
                    LongStr ( CurrLong, CurrStr, 'L' );
                    BankBalance.Text := CurrStr;
                    if ( Currlong < 0 ) then
                       BankBalance.Font.Color := clRed
                    else
                       BankBalance.Font.Color := clBlack;
                 End;
           End;

   End;

begin
     InitRange ( AccRange );
     AccRange[1] := Cash1.xBankMin;
     AccRange[2] := Cash1.xBankMax;
     TestStr := BankAccount.Text;
     SlimAll ( TestStr );
     If ( NOT NewListBox.CheckNom ( BankAccount.Text,{ 0, 0, }AccRange )) Or
        ( Length ( TestStr ) = 0 ) or ( BankAccount.Text = '0' ) Then      // TGM AB Ch004
        BankAccount.SetFocus
     Else
         GetBankInfo;
     PromptLine.Panels.Items[1].Text := '';

     // next few lines added by tgm 21/05/02 to make stub number appear after exiting bank
     // edit box instead of when exiting the stubno edit box
     if not gediting then begin
        If Prog In [CASHINC,SALESTX]
        Then
            TempLong := PSysLongToDelphi ( Cash1.xRecStub )
        Else
            TempLong := PSysLongToDelphi ( Cash1.xPayStub );
        StubNo.Text := IntToStr ( TempLong );
     end;

end;

procedure TCashBookForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     if not ((Param_type = 'P') or (Param_type = 'S')) then FMainScreen.Visible := True;
  //   FMainScreen.Visible := True;
     try Accsdatamodule.AllocationTempDB.close;
         Accsdatamodule.AllocationTempDB.emptytable;
     except
     end;

   // SP 29/05/2015
   if Assigned(ProductListingForm) then
      FreeAndNil(ProductListingForm);

     Release;
end;

procedure TCashBookForm.CustSuppCodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

    If Key = VK_F2 Then    { F2 Pressed }
       Begin
          If PROG = SALESTX Then
             NewListBox.ListIt ( Sender, Customers, 'C' )
          Else
             NewListBox.ListIt ( Sender, Suppliers, 'S' );
          If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
             CustSuppCode.Text := NewListBox.ListInfo.ReturnValue;
             CustSuppCodeExit ( Sender );
          If PaymentReceipt.checked then
             Comment.text := CustSuppNameLabel.Caption;
          CustSuppCodeExit ( Sender );
          Key := 0;
       End;

    If Key = VK_F1 then
       Begin
            If PROG = SALESTX Then
               Application.HelpContext(2)           {Sales}
            Else
               Application.HelpContext(3);           {Purchases}
            Key := 0;
       end;
end;

procedure TCashBookForm.CustSuppCodeEnter(Sender: TObject);
begin
     PromptLine.Panels.Items[1].Text := 'Press F2 or Double Click to List Accounts';
     if NOT GEditing then
        TxDate.Text := Cash11.Default_Date;{XDate}
     DateSearch.Date := KStrToDate ( Cash11.Default_Date );
     //DateMask.Text := Cash11.Default_Date;{XDate}
end;

procedure TCashBookForm.CustSuppCodeExit(Sender: TObject);
Var
   TestStr : ShortString;
   Registry : Tregistry;
   UseDefaults : boolean;
   SInvoiceNUmber : string;

   Procedure GetCustSuppInfo;
   Var
      TStr, TempStr : ShortString;
   Begin
        SetDb ( SalesPurchDB );
        ReadRec ( SalesPurchDB, StrToInt ( TestStr ));
        dberr;
        If RecActive ( SalesPurchDB ) Then
           Begin
              // Get the Name
              GetItem ( SalesPurchDB, 1 );
              CustSuppNameLabel.Caption := CurrStr;
              // Check in case you're editing the Transaction
              TStr := Comment.Text;
              SlimAll ( TStr );

              if ((PaymentReceipt.Checked or CashInvoice.Checked)) then // TGM AB and Cash1.XDEFCOMM) then
                    if Length ( TStr ) = 0 Then
                       Comment.text := CurrStr;

              GetItem ( SalesPurchDB, 2 );
              CustSuppAdd1Label.Caption := CurrStr;
              GetItem ( SalesPurchDB, 3 );
              CustSuppAdd2Label.Caption := CurrStr;
              GetItem ( SalesPurchDB, 4 );
              CustSuppAdd3Label.Caption := CurrStr;
              GetItem ( SalesPurchDB, 5 );
              CustSuppAdd4Label.Caption := CurrStr;
              GetItem ( SalesPurchDB, 23 );
              CustSuppAdd5Label.Caption := CurrStr;
              GetItem ( SalesPurchDB, 22 );
               if currint <> 0 then CustSuppAreaCodelabel.Caption := 'Area Code - ' + Vartostr(Currint)
                 else CustSuppAreaCodelabel.Caption := '';
              GetItem ( SalesPurchDB, 19 );
              if currstr <> '' then begin
                 if CustSuppAreaCodelabel.Caption <> '' then CustSuppAreaCodelabel.Caption :=  CustSuppAreaCodelabel.Caption + #10#13 + 'Tel - ' + CurrStr
                    else CustSuppAreaCodelabel.Caption := 'Tel - ' + CurrStr;
              end;
              GetItem ( SalesPurchDB, 28 );
              if currstr <> '' then begin
                 if CustSuppAreaCodelabel.Caption <> '' then CustSuppAreaCodelabel.Caption :=  CustSuppAreaCodelabel.Caption + #10#13 + CurrStr
                    else CustSuppAreaCodelabel.Caption := CurrStr;
              end;
          //    CustSuppCommentLabel.caption := CurrStr;
              GetItem ( SalesPurchDB, 7 );
              CustSuppBalance := CurrLong;
              LongStr ( CurrLong, CurrStr, 'L' );
              CurrentBal.Text := CurrStr;
              GetItem ( SalesPurchDB, 9 );
              LongStr ( CurrLong, CurrStr, 'L' );
              AgedCurr.Text := CurrStr;
              GetItem ( SalesPurchDB, 10 );
              CustSuppAged1 := CurrLong;
              LongStr ( CurrLong, CurrStr, 'L' );
              Aged1.Text := CurrStr;
              GetItem ( SalesPurchDB, 11 );
              LongStr ( CurrLong, CurrStr, 'L' );
              Aged2.Text := CurrStr;
              GetItem ( SalesPurchDB, 12 );
              LongStr ( CurrLong, CurrStr, 'L' );
              Aged3.Text := CurrStr;

              TempStr := '';
              GetItem (SalesPurchDB,17);    // Balance-ST
              LongStr ( CurrLong, TempStr, 'L' );

              // TGM 14/06/02 AB added next line
              {
              application.processmessages;
              registry:=Tregistry.Create;
              Registry.OpenKey('Software\Kingswood\Kingsacc\SLPLDefaults', True);
              if Registry.ReadString('SLPLDefaults') = 'True' then UseDefaults := true
              else UseDefaults := false;
              Registry.Free;
              }
              //   24/11/14 [V4.1 R7.6] /MK Bug Fix - Check for SLPLDefaults in new uPrefences key not old key.
              UseDefaults := Preferences.ValueAsBoolean[cPref_EnableSLPLDefaults];

              // TGM AB Unallocated Invoice Setup

              if invoiceallocationpanel.Visible then begin
                   AccsDataModule.AllocationTempDB.Close;
                   AccsDataModule.AllocationTempDB.emptytable;
                   AccsDataModule.AllocationTempDB.open;
                   if ((PreviousYearTxs = true) or (IncludeLastYearCB.checked)) then GetUnAllocatedInvoicesPreviousYear(strtoint(custsuppcode.text));
                   GetUnAllocatedInvoices(StrToInt ( TestStr ),true);
                   BalanceLabel.caption := Tempstr;
//                   Allocationgrid.SetFocus;
              end
                else begin
                          Accsdatamodule.AllocationTempDB.close;
                          Accsdatamodule.AllocationTempDB.EmptyTable;
                     end;


              if (UseDefaults and Invoice.checked and (not GEditing) and (not EditingJobCard)) then begin
                 accsdatamodule.SLPLDefaults.open;
                 Comment.text := '';
                 if ((SalesPurchDB = 4) and  (accsdatamodule.SLPLDefaults.locate('SLPLCode;SLPLType',VarArrayOf([StrToInt(CustSuppCode.Text),'S']),[])) and (CustSuppCode.text <> ''))
                 then begin // sales ledger
                      if (accsdatamodule.SLPLDefaults['Comment'] <> null) then Comment.text := varToStr(accsdatamodule.SLPLDefaults['Comment']);
                      try DetailGrid.Cells[NomCol, 1] := IntToStr(accsdatamodule.SLPLDefaults['Nominal']);
                          DetailGrid.Cells[DesCol, 1] := GetAccountName ( NLFile, accsdatamodule.SLPLDefaults['Nominal'], 1 );
                          if accsdatamodule.SLPLDefaults['Ent'] <> null then DetailGrid.Cells[EntCol, 1] := varToStr(accsdatamodule.SLPLDefaults['Ent']);
                      except
                      end;
                 end;
                 if ((SalesPurchDB = 5) and  (accsdatamodule.SLPLDefaults.locate('SLPLCode;SLPLType',VarArrayOf([StrToInt(CustSuppCode.Text),'P']),[])) and (CustSuppCode.text <> ''))
                 then begin // purchase
                      if (accsdatamodule.SLPLDefaults['Comment'] <> null) then Comment.text := varToStr(accsdatamodule.SLPLDefaults['Comment']);
                      try DetailGrid.Cells[NomCol, 1] := IntToStr(accsdatamodule.SLPLDefaults['Nominal']);
                          DetailGrid.Cells[DesCol, 1] := GetAccountName ( NLFile, accsdatamodule.SLPLDefaults['Nominal'], 1 );
                          if accsdatamodule.SLPLDefaults['Ent'] <> null then DetailGrid.Cells[EntCol, 1] := varToStr(accsdatamodule.SLPLDefaults['Ent']);
                      except
                      end;
                 end;
                 accsdatamodule.SLPLDefaults.close;
              end;

           End;
   End;

   begin
    if CustSuppCode.Visible then
        begin
             SetDb ( SalesPurchDB );
             TestStr := CustSuppCode.Text;
             SlimAll ( TestStr );

             if ( NOT CheckCustSupp ( SalesPurchDB, CustSuppCode.Text )) then
                {CustSuppCode.SetFocus}
             else
                 GetCustSuppInfo;
             PromptLine.Panels.Items[1].Text := '';
             if (not (act = 3)) then begin
                  if (invoicer and (not Gediting) and (not EditingJobCard)) then Reference.text := IntToStr(GetRefNumber);
             end;
             application.processmessages;



     end;

end;

procedure TCashBookForm.ToSalesRadioClick(Sender: TObject);
begin
     BankListAcc.Hide;
     Comment.Text := '';
     Font.Color := clBlack;
     CustSuppNamelabel.font.color := clblack;
     ACT := 61;
     SetUpScreen ( PROG, ACT );
end;

procedure TCashBookForm.ToPurchaseRadioClick(Sender: TObject);
begin
     BankListAcc.Hide;
     Comment.Text := '';
     Font.Color := clBlack;
     CustSuppNamelabel.font.color := clblack;
     ACT := 62;
     SetUpScreen ( PROG, ACT );
end;

procedure TCashBookForm.InvoiceClick(Sender: TObject);
begin
     BankListAcc.Hide;
     Comment.Text := '';
     Font.Color := clBlack;
     CustSuppNamelabel.font.color := clblack;
     ACT := 1;
     SetUpScreen ( PROG, ACT );
end;

procedure TCashBookForm.CashInvoiceClick(Sender: TObject);
begin
     BankListAcc.Show;
     Comment.Text := CustSuppNameLabel.Caption;;
     Font.Color := clBlack;
     CustSuppNamelabel.font.color := clblack;
     ACT := 2;
     SetUpScreen ( PROG, ACT );
end;

procedure TCashBookForm.PaymentReceiptClick(Sender: TObject);
begin
     application.processmessages;
     BankListAcc.Show;
     Comment.text := CustSuppNameLabel.Caption;
     Font.Color := clBlack;
     CustSuppNamelabel.font.color := clblack;
     ACT := 3;
     SetUpScreen ( PROG, ACT );
     BankAccountExit(Sender);
     if cash2.XAllocation then CustSuppcodeExit(self);
     CustSuppCode.SetFocus;
     application.processmessages;

end;

procedure TCashBookForm.CreditNoteClick(Sender: TObject);
begin
     BankListAcc.Hide;
     Comment.Text := '';
     Font.Color := clred;
     CustSuppNamelabel.font.color := clred;
     Help.Font.Color := clBlack;
     ACT := 4;
     SetUpScreen ( PROG, ACT );
end;

procedure TCashBookForm.IncomeClick(Sender: TObject);
begin
     BankListAcc.Hide;
     //GM added line below 17/07/02 to fix bug when program called with parameters from herd program
     // note this procedure calls setupscreen and setupscreen calls this procedure
     if not GEditing then Comment.Text := '';
     Font.Color := clBlack;
     Prog := CashInc;
     Act  := 0;
     SetUpScreen ( PROG, ACT );
end;

procedure TCashBookForm.ExpenditureClick(Sender: TObject);
begin
     BankListAcc.Hide;
     //GM added line below 17/07/02 to fix bug when program called with parameters from herd program
     // note this procedure calls setupscreen and setupscreen calls this procedure
     If Not GEditing then Comment.Text := '';
     Font.Color := clBlack;
     Prog := CashExp;
     Act  := 0;
     SetUpScreen ( PROG, ACT );
end;

procedure TCashBookForm.AddRemoveProductsClick(Sender: TObject);
begin
(*     If PROG In [CashInc, CashExp] Then
        Begin
             ListBox.ListIt ( Sender, Banks, 'N' );
             If Length ( ListBox.ListInfo.ReturnValue ) > 0 Then
                BankAccount.Text := ListBox.ListInfo.ReturnValue;
        End
     Else
         Begin
              If ( PROG = SALESTX ) Then
                 ListBox.ListIt ( Sender, Customers, 'C' )
              Else
                  ListBox.ListIt ( Sender, Suppliers, 'S' );
              If Length ( ListBox.ListInfo.ReturnValue ) > 0 Then
                 CustSuppCode.Text := ListBox.ListInfo.ReturnValue;
         End;
*)
 // If not bool(fSetUpProducts) then application.createform(TfSetUpProducts,fSetUpProducts);                                            // TGM AB 24/06/16
 // fSetupProducts.showmodal;                                                                                                           // TGM AB 24/06/16

{
        if not bool(ProductAllocationForm) then Application.CreateForm(TProductAllocationForm, ProductAllocationForm);                  // TGM AB 24/06/16
        ProductAllocationForm.StartingNominalCode := strtoint(DetailGrid.Cells[NomCol, DetailGrid.row]);                                // TGM AB 24/06/16
        ProductAllocationForm.ShowModal;                                                                                                // TGM AB 24/06/16
}

end;

procedure TCashBookForm.AmtReceivedExit(Sender: TObject);
Var
   Tempstr : ShortString;
begin
     TempStr := AmtReceived.Text;
     If ChangeToLong ( TempStr ) Then
        AmtReceived.Text := TempStr
     Else
        AmtReceived.SetFocus;
end;

procedure TCashBookForm.DiscountExit(Sender: TObject);
Var
   Tempstr : ShortString;
begin
     TempStr := Discount.Text;
     If ChangeToLong ( TempStr ) Then
        Discount.Text := TempStr
     Else
        Discount.SetFocus;
end;


procedure TCashBookForm.ListAccountsClick(Sender: TObject);
var
   CustomerId : Integer;
begin
   If CustSuppCode.Visible Then
      Begin
         // SP - 26/03/2015
         if (JobCardPanel.visible) and (TfmFarmSyncSettings.SyncServiceIsAvailable) then
            begin
               CustomerId := TfmJobCardCustomerListing.SelectCustomer;
               if (CustomerId>0) then
                  begin
                     CustSuppCode.Text := IntToStr(CustomerId);
                     CustSuppCodeExit ( Sender );
                     if ( PaymentReceipt.Checked ) then
                        Comment.text := CustSuppNameLabel.Caption;
                     CustSuppCodeExit ( Sender );
                     JobCardImportButtonClick(nil);
                     Exit;
                  end
               else if (CustomerId = 0) then
                  Exit; // No Customer selected, and choose another wasn't clicked
            end;

           if PROG = SALESTX then
              NewListBox.ListIt ( Sender, Customers, 'C' )
           else
              NewListBox.ListIt ( Sender, Suppliers, 'S' );
           if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
              CustSuppCode.Text := NewListBox.ListInfo.ReturnValue;
           CustSuppCodeExit ( Sender );
           if ( PaymentReceipt.Checked ) then // tgm AB And ( Cash1.XDEFCOMM ) then
              Comment.text := CustSuppNameLabel.Caption;
           CustSuppCodeExit ( Sender );
      End
   Else
       If BankAccount.Visible Then
           Begin
                NewListBox.ListIt ( Sender, Banks, 'N' );
                If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
                   BankAccount.Text := NewListBox.ListInfo.ReturnValue;
                BankAccountExit ( Sender );
           End;
end;

procedure TCashBookForm.DetailGridDblClick(Sender: TObject);
Var
   OrigVAT,
   TmpStr : ShortString;
begin

         if DetailGrid.Col = EntCol then Begin   { Enterprise Column }
                 NewListBox.ListIt ( Sender, Enterprise, 'E' );   { Enterprise Accounts }
                 If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
                    Begin
                        DetailGrid.Cells[EntCol,DetailGrid.Row] := NewListBox.ListInfo.ReturnValue;
                        DetailGrid.Col := DetailGrid.Col+1;
                    End;
             End else
         if DetailGrid.Col = Nomcol then Begin   { Nominal Ledger Column }
                 NewListBox.ListInfo.Ent := DetailGrid.Cells[EntCol,DetailGrid.Row];
                 SlimAll ( NewListBox.ListInfo.Ent );
                 If Length ( NewListBox.ListInfo.Ent ) > 0 Then
                    NewListBox.ListIt ( Sender, EntRange, 'N' )   { Nominal Ledger Accounts }
                 Else
                    // NewListBox.ListIt ( Sender, AllNoms, 'N' );   { Nominal Ledger Accounts }
                    Begin // TGM AB 13/02/09
                                if cash11.Xuse_enterprise = false then begin
                                        if prog = salestx then NewListBox.ListIt ( Sender, NonEntToLiab, 'N' )
                                           else if prog = purchtx then NewListBox.ListIt ( Sender, OverheadsToLiab, 'N' )
                                                else NewListBox.ListIt ( Sender, AllNoms, 'N' );
                                DetailGrid.Col := DetailGrid.Col+1;
                                end else
                                        begin
                                              NewListBox.ListIt ( Sender, AllNoms, 'N' );   { Nominal Ledger Accounts }
                                              DetailGrid.Col := DetailGrid.Col+1;
                                        end;
                  End;
                 If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
                    Begin
                         DetailGrid.Cells[NomCol,DetailGrid.Row] := NewListBox.ListInfo.ReturnValue;
                         DetailGrid.Cells[DesCol,DetailGrid.Row] :=
                           GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ), 1 );
                         TmpStr := DetailGrid.Cells[VCodeCol,DetailGrid.Row];
                         SlimAll ( TmpStr );
                         If Length ( TmpStr ) = 0 Then
                            DetailGrid.Cells[VCodeCol,DetailGrid.Row] :=
                               GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ), 20 );
                         DetailGrid.Col := DetailGrid.Col+1;
                    End;
             End else
         if DetailGrid.Col = DesCol then begin
                                    GetExtraDetails(true)
                                    end else
         if DetailGrid.Col = QtyCol then CallCalcAmt else

         if DetailGrid.Col = VCodeCol then Begin   { VAT Column }
                 OrigVAT := DetailGrid.Cells[VCodeCol,DetailGrid.Row];
                 SlimAll ( OrigVAT );
                 NewListBox.ListIt ( Sender, Vat, 'V' );   { VAT Rates }
                 If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
                    Begin
                         DetailGrid.Cells[VCodeCol,DetailGrid.Row] := NewListBox.ListInfo.ReturnValue;
                         DetailGrid.Col := DetailGrid.Col+1;
                         CheckVatForChanges((OrigVat <> DetailGrid.Cells[VCodeCol,DetailGrid.Row]));
                    End;
             End else
         if DetailGrid.Col = ANCol then Begin
                   if not bool(SetupAnalysisForm) then Application.CreateForm(TSetupAnalysisForm, SetupAnalysisForm);
                          SetupAnalysisForm.ShowWindow(1);
                          DetailGrid.Cells[ANCol,DetailGrid.Row] := Setupanalysisform.selectedcode;

           // TGM AB removed with the introduction of new paradox table
          //       ListBox.ListIt ( Sender, Analysis, 'A' );   { Nominal Ledger Accounts }
          //       If Length ( ListBox.ListInfo.ReturnValue ) > 0 Then
          //          DetailGrid.Cells[ANCol,DetailGrid.Row] := ListBox.ListInfo.ReturnValue;
             End;
end;

procedure TCashBookForm.CustSuppCodeDblClick(Sender: TObject);
begin
     If PROG = SALESTX Then
        NewListBox.ListIt ( Sender, Customers, 'C' )
     Else
         NewListBox.ListIt ( Sender, Suppliers, 'S' );
     If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
        CustSuppCode.Text := NewListBox.ListInfo.ReturnValue;
end;

procedure TCashBookForm.BankAccountDblClick(Sender: TObject);
begin
     NewListBox.ListIt ( Sender, Banks, 'N' );
     If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
        BankAccount.Text := NewListBox.ListInfo.ReturnValue;
end;

procedure TCashBookForm.StubNoExit(Sender: TObject);
Var
   TempLong : LongInt;
begin
     If Prog In [CASHINC,SALESTX] Then
        TempLong := PSysLongToDelphi ( Cash1.xRecStub )
     Else
        TempLong := PSysLongToDelphi ( Cash1.xPayStub );

     If NOT Numeric ( StubNo.Text ) Then
        StubNo.Text := IntToStr ( TempLong );

     // tgm put in next few lines to force program to save the stub number if it's changed by user
     zstub[1] := StrToInt(StubNo.Text);
     If Prog In [CASHINC,SALESTX] Then
        DelphiLongToPSys ( zStub[1], Cash1.xRecStub )
     else
        DelphiLongToPSys ( zStub[1], Cash1.xPayStub );
end;

Procedure TCashBookForm.SetUpScreen ( Prog, Act : Integer );
Var
   Counter,
   Counter1 : Integer;
Begin
     // Blank the VAT Array
     BlankOrigVals;

     // Call the property to zero the Default Cost per Unit
     calcamtForm.DefaultCostPerUnit := 0;

     TotalsPanel.Hide;
     EuroPanel.hide;
     pCustSuppBals.Hide;

     ExtraQtysPanel.hide;
     ExtraQtysBtn.hide;



     If NOT GEditing Then
        Begin              { Initialise all relevant variables }
             StubNo.Text := '';
             Reference.Text := '';
             AmtReceived.Text := '';
             Discount.Text := '';
             Cust_suppcode := 0;   // TGM AB 09/08/02
             For Counter := 1 To MaxGridLines Do  // TENFOUND
                 For Counter1 := 0 To 25 do // Detailgrid.colcount Do                // TGM AB FIXED 20/06/02
                     DetailGrid.Cells[Counter1, Counter] := '';
        End;

     Case PROG Of
          CASHINC,
          CASHEXP : Begin
//                      Height := OrigHeight+24;
                      Visible := True;
                      AgedPanel.Hide;
                      PayRecPanel.Hide;
                      CustSuppTrans.Hide;
                      InvoiceAllocationPanel.hide;
                      TotalsPanel.Show;
                      If ((Cash11.xEuroConverter > 0) or (Cash11.xEuroConverter < 0)) then
                         EuroPanel.show;

                      BankAccountLabel.Caption := ReadLang ( 45, CurrLang );
                      CashBookGroup.Top := 0;
                      CashBookGroup.Left := 266;
                      CashBookGroup.Width := 209;
                      If GEditing Then
                         CashBookGroup.Hide
                      Else
                          CashBookGroup.Visible := True;
                      SalesPurchaseGroup.Hide;

                      { Items to hide on screen }
                      CustSuppCode.Hide;
                      CustSuppCodeLabel.Hide;
                      CustSuppNameLabel.Hide;
                      CustSuppAdd1Label.Hide;
                      CustSuppAdd2Label.Hide;
                      CustSuppAdd3Label.Hide;
                      CustSuppAdd4Label.Hide;
                      CustSuppAdd5Label.Hide;
                      CustSuppAreaCodeLabel.Hide;
                      CustSuppCommentLabel.Hide;

                      SalesPurchaseGroup.Caption := 'CashBook';
                      PaymentReceipt.Caption := 'Payment';
                      Caption := 'CashBook';{ + ' - ' + st;}

                      { Items to Show on screen }
                      SelectCustomer.visible := true;    // TGM AB 09/08/02
                      BankAccount.Visible := True;
                      BankNameLabel.Visible := True;
                      BankAccount.TabOrder := 0;
                      BankAccountLabel.Visible := True;
                      CommentLabel.Caption := ReadLang ( 94, currLang );{'Customer'}
                      StubNo.Visible := True;
                      StubNoLabel.Visible := True;
                      BankBalance.Visible := True;
                      BankBalanceLabel.Visible := True;
                      If PROG = CASHEXP Then
                         Begin
                              Caption := 'Cashbook Expenditure';{ + ' - ' + st;}
                              CommentLabel.Caption := ReadLang ( 95, CurrLang );{'Supplier'}
                              // TGM AB 18/02/02  Next 2 lines when using Parameters
                              expenditure.Checked := true;
                              income.checked := false;

                         End
                      Else
                         Begin
                              Caption := 'Cashbook Income';{ + ' - ' + st;}
                              CommentLabel.Caption := ReadLang ( 94, CurrLang );{'Customer'}
                              // TGM AB 18/02/02  Next 2 lines when using Parameters
                              expenditure.Checked := false;
                              income.checked := true;

                         End;
                    End;
          SALESTX,
          PURCHTX : Begin
//                      Height := OrigHeight+24;
                      if ((not Cash1.xcashbook) and (Invoicer) and (Tasknumber in [2..4] )) then VatPanel.show;
                      Visible := True;
                      AgedPanel.Hide;
                      PayRecPanel.Hide;
                      CustSuppTrans.Hide;
                      InvoiceAllocationPanel.hide;
                      SelectCustomer.visible := false;  // TGM AB 09/08/02

                      CurrBalLabel.Caption := ReadLang ( 40, CurrLang );
                      AgedCurrLabel.Caption := ReadLang ( 41, CurrLang );
                      Aged1Label.Caption := ReadLang ( 42, CurrLang );
                      Aged2Label.Caption := ReadLang ( 43, CurrLang );
                      Aged3Label.Caption := ReadLang ( 44, CurrLang );
                      If PROG = SALESTX Then
                         Begin
                              ToSalesRadio.Caption := ReadLang ( 136, CurrLang );
                              ToPurchaseRadio.Caption := ReadLang ( 135, CurrLang );
                         End
                      Else
                         Begin
                              ToSalesRadio.Caption := ReadLang ( 135, CurrLang );
                              ToPurchaseRadio.Caption := ReadLang ( 136, CurrLang );
                         End;

                      Invoice.Caption := ReadLang ( 104, CurrLang );

                      If PROG = SALESTX Then
                         CashInvoice.Caption := ReadLang ( 105, CurrLang )
                      Else
                          CashInvoice.Caption := ReadLang ( 115, CurrLang );
                      CreditNote.Caption := ReadLang ( 107, CurrLang );

                      CashBookGroup.Hide;

                      If GEditing Then
                         SalesPurchaseGroup.Hide
                      Else
                          if ((not invoicer) or (PROG=PURCHTX)) then SalesPurchaseGroup.Visible := True; // TGM AB 28/06/02
                      DetailGrid.Visible := True;

                      if CashbookImportPayment then SalesPurchaseGroup.hide;

         // TGM AB 13/06/02             F6Button.Show;
         // TGM AB 13/06/02             F6button.Top := OrigGridTop + 76;//15;

                      If PROG = SALESTX Then
                         Begin
                           Case ACT Of
                             1 : Caption := 'Sales Invoice';{ + ' - ' + st;}
                             3 : Begin
                                      Caption := 'Sales Receipt';{ + ' - ' + st;}
                                      AmtReceivedLabel.Caption := 'Amount Received';
                                      AgedPanel.Visible := True;
                                      if (cash2.XAllocation and (cash11.xSalesPaymentVAT = 'Y') and (not gediting)) then begin         // TGM AB 12/06/15
                                        InvoiceAllocationPanel.Visible := True;
                                        Overpaymentsbtn.enabled := True;
                                        BalancePanel.Visible := false;
                                        PayRecPanel.Visible := True;
                                        IncludeLastYearCB.show;
                                        IncludeLastYearCB.checked := false;
                                //        UnallocatedInvoicesBtn.Font.Style := [fsBold];
                                      end else begin
                                                PayRecPanel.Visible := True;
                                                PayRecPanel.TabOrder :=
                                                        StubNo.TabOrder+1;
                                                end;
                                      DetailGrid.Hide;
                // TGM AB 13/06/02
                                      F6Button.Hide;
                                      VatPanel.Hide;
                                 End;
                             2 : begin
                                      Caption := 'Cash Sale';{ + ' - ' + st;}
//                                      F6Button.Top := F6Button.Top + 24;//24;
                                 end;
                             4 : Caption := 'Sales Credit Note';{ + ' - ' + st;}
                            61 : Begin
                                      Caption := 'Customer To Customer Transfer';{ + ' - ' + st;}
                                      pCustSuppBals.Top := AgedPanel.Top;
                                      pCustSuppBals.Left := AgedPanel.Left;
                                      pCustSuppBals.Show;
                                      AgedPanel.Hide;
                                      PayRecPanel.Hide;
                                      InvoiceAllocationPanel.hide;
                                      CustSuppTrans.Show;
                                      CustSuppTrans.TabOrder := Comment.TabOrder+1;
                                      DetailGrid.Hide;
                                      // TGM AB 13/06/02
                                      F6Button.Hide;
                                      VatPanel.Hide
                                 End;
                            62 : Begin
                                      Caption := 'Customer To Supplier Transfer';{ + ' - ' + st;}
                                      pCustSuppBals.Top := AgedPanel.Top;
                                      pCustSuppBals.Left := AgedPanel.Left;
                                      pCustSuppBals.Show;
                                      AgedPanel.Hide;
                                      PayRecPanel.Hide;
                                      InvoiceAllocationPanel.hide;
                                      CustSuppTrans.Show;
                                      CustSuppTrans.TabOrder := Comment.TabOrder+1;
                                      DetailGrid.Hide;
                                // TGM AB 13/06/02
                                      F6Button.Hide;
                                      VatPanel.Hide;
                                 End;
                           End;
                           CustSuppCodeLabel.Caption := 'Customer ';//ReadLang ( 108, CurrLang );{'Customer Code'}
                           SalesPurchaseGroup.Caption := ReadLang ( 116, CurrLang ); {'Sales'}
                           PaymentReceipt.Caption := ReadLang ( 106, CurrLang );{'Receipt'}
                         End
                      Else
                         Begin
                           Case ACT Of
                             1 : Caption := 'Purchase Invoice';{+ ' - ' + st;}
                             3 : Begin
                                      if not cashbookimportpayment then Caption := 'Purchase Payment';{ + ' - ' + st;}
                                      AmtReceivedLabel.Caption := 'Amount Paid';
                                      AgedPanel.Visible := True;
                                      if (cash2.XAllocation and (cash11.xPurchPaymentVAT = 'Y') and (not gediting)) then begin       // TGM AB 12/06/15
                                        InvoiceAllocationPanel.Visible := True;
                                        Overpaymentsbtn.enabled := True;
                                        BalancePanel.Visible := false;
                                        IncludeLastYearCB.show;
                                        IncludeLastYearCB.checked := false;
                                        PayRecPanel.Visible := True;
                                      end else begin
                                                PayRecPanel.Visible := True;
                                                PayRecPanel.TabOrder :=
                                                        StubNo.TabOrder+1;
                                                end;
                                      DetailGrid.Hide;
                              // TGM AB 13/06/02
                                      F6Button.Hide;
                                      VatPanel.Hide;
                                 End;
                             2 : Begin
                                      Caption := 'Cash Purchase';{ + ' - ' + st;}
                                 End;
                             4 : Caption := 'Purchase Credit Note';{ + ' - ' + st;}
                            61 : Begin
                                      Caption := 'Supplier To Supplier Transfer';{ + ' - ' + st;}
                                      pCustSuppBals.Top := AgedPanel.Top;
                                      pCustSuppBals.Left := AgedPanel.Left;
                                      pCustSuppBals.Show;
                                      AgedPanel.Hide;
                                      PayRecPanel.Hide;
                                      CustSuppTrans.Show;
                                      CustSuppTrans.TabOrder := Comment.TabOrder+1;
                                      DetailGrid.Hide;
                                 // TGM AB 13/06/02
                                      F6Button.Hide;
                                      VatPanel.Hide;
                                  End;
                            62 : Begin
                                      Caption := 'Supplier To Customer Transfer';{ + ' - ' + st;}
                                      pCustSuppBals.Top := AgedPanel.Top;
                                      pCustSuppBals.Left := AgedPanel.Left;
                                      pCustSuppBals.Show;
                                      AgedPanel.Hide;
                                      PayRecPanel.Hide;
                                      CustSuppTrans.Show;
                                      CustSuppTrans.TabOrder :=
                                             Comment.TabOrder+1;
                                      DetailGrid.Hide;
                                 // TGM AB 13/06/02
                                      F6Button.Hide;
                                      VatPanel.Hide;
                                 End;
                           End;
                           CustSuppCodeLabel.Caption := 'Supplier ';//ReadLang ( 109, CurrLang );{'Supplier Code'}
                           SalesPurchaseGroup.Caption := ReadLang ( 117, CurrLang ); {'Purchase'}
                           PaymentReceipt.Caption := ReadLang ( 114, CurrLang );{'Payment'}
                         End;
                      StubNo.Hide;
                      StubNoLabel.Hide;
                      If Act In [61,62] Then
                         Begin
                             BankBalanceLabel.Hide;
                             BankBalance.Hide;
                             BankAccount.Top := CustSuppCode.Top;
                             BankAccount.Left := CustSuppCode.Left;
                             BankAccountLabel.Top := BankAccount.Top;
                             BankAccountLabel.Left := 26;
                             ListAccounts.Show;
                             BankAccount.Show;
                             BankNameLabel.Show;
                             BankAccountLabel.Show;
                             BankAccount.TabOrder := 0;
                             CustSuppCode.Hide;
                             CustSuppCodeLabel.Hide;
                             CustSuppCode.Hide;
                             CustSuppCodeLabel.Hide;
                             CustSuppNameLabel.Hide;
                             CustSuppAdd1Label.Hide;
                             CustSuppAdd2Label.Hide;
                             CustSuppAdd3Label.Hide;
                             CustSuppAdd4Label.Hide;
                             CustSuppAdd5Label.Hide;
                             CustSuppAreaCodeLabel.Hide;
                             CustSuppCommentLabel.Hide;
                             BankAccount.SetFocus;
                         End
                      Else
                          Begin
                               { Items to hide on screen }
                               BankNameLabel.Hide;
                               BankAccount.Hide;
                               BankAccountLabel.Hide;
                               BankBalance.Hide;
                               BankBalanceLabel.Hide;
                               { Items to Show on screen }
                               CustSuppCode.Visible := True;
                               CustSuppCode.TabOrder := 0;
                               if not CashbookImportPayment then CustSuppCode.SetFocus;
                               CustSuppCodeLabel.Visible := True;
                               CommentLabel.Caption := ReadLang ( 79, CurrLang );{'Comment'}
                               CustSuppNameLabel.Visible := True;
                               CustSuppAdd1Label.Visible := True;
                               CustSuppAdd2Label.Visible := True;
                               CustSuppAdd3Label.Visible := True;
                               CustSuppAdd4Label.Visible := True;
                               CustSuppAdd5Label.Visible := True;
                               CustSuppAreaCodeLabel.Visible := True;
                               CustSuppCommentLabel.Visible := True;
                          End;

                      If ACT In [2,3,61,62] Then { Credit Note }
                         Begin
                              If Act In [2,3] Then
                                 Begin
                                      StubNo.Visible := True;
                                      StubNoLabel.Visible := True;
                                      BankBalance.Visible := True;
                                      BankBalanceLabel.Visible := True;
                                      If Act = 2 Then begin
                                         TotalsPanel.Show;
                                         If ((Cash11.xEuroConverter > 0) or (Cash11.xEuroConverter < 0)) then
                                            EuroPanel.Show;
                                      end;
                                 End;
                              If Act = 3 Then
                                 Begin
                                     // Height := Height - ( Detailgrid.Height ) +
                                                        // ( PayRecPanel.Height + 15 );
                                      PromptLine.Top := PayRecPanel.Top +
                                                        PayRecPanel.Height + 5;
                                 End
                              Else
                                 If Act In [61,62] Then
                                    Begin
                                    //  Height := Height - ( Detailgrid.Height ) +
                                                        // ( CustSuppTrans.Height + 15 );
                                      PromptLine.Top := PayRecPanel.Top +
                                                        PayRecPanel.Height + 5;
                                    End
                                 Else
//                                    Height := OrigHeight+24;

//                              DetailGrid.Top := OrigGridTop + 24;
                              If Act = 2 Then
                                 PromptLine.Top := DetailGrid.Height +
                                                     DetailGrid.Top + 5;

                              If Act In [2,3] Then
                                 Begin
                                      BankAccount.Visible := True;
                                      BankAccount.Top := Comment.Top + 24;
                                      BankAccount.Left := Comment.Left;
                                      BankListAcc.Show;
                                      BankAccount.TabOrder := StubNo.TabOrder-1;
                                      BankAccountLabel.Visible := True;
                                      BankAccountLabel.Top := Comment.Top + 24;
                                      BankAccountLabel.Left := CommentLabel.Left +
                                                                 CommentLabel.Width-
                                                                 BankAccountLabel.Width;
                                      StubNo.Top := BankAccount.Top + 24;
                                      StubNoLabel.Top := BankAccount.Top +24;
                                      BankBalance.Top := StubNo.Top + 24;
                                      BankBalanceLabel.Top := StubNoLabel.Top + 24;
                                 End;
                         End
                      Else
                            Begin
                              {
                              BankBalance.Visible := True;
                              BankBalanceLabel.Visible := True;
                              }
//                              Height := OrigHeight;
//                              DetailGrid.Top := OrigGridTop;
                              {
                              BankBalance.Top := TopPos;
                              BankBalanceLabel.Top := TopPos;
                              }
                              PromptLine.Top := DetailGrid.Height +
                                                     DetailGrid.Top + 5;
                              TotalsPanel.Show;
                              If ((Cash11.xEuroConverter > 0) or (Cash11.xEuroConverter < 0)) then
                              EuroPanel.show;
                              {
                              BankAccount.TabOrder := StubNo.TabOrder-1;
                              BankAccount.Visible := True;
                              BankAccount.Top := TopPos;
                              BankAccount.Left := LeftPos;
                              BankAccountLabel.Visible := True;
                              BankAccountLabel.Top := TopPos;
                              BankAccountLabel.Left := LeftPos-(BankAccountLabel.Width+5);
                              }
                            End;
                    End;
     End;

     // SP 24/03/2015

     JobCardImportButton.Visible := False;
End;

procedure TCashBookForm.CustSuppAmountExit(Sender: TObject);
Var
   TempStr : ShortString;
begin
     TempStr := CustSuppAmount.Text;
     If ChangeToLong ( TempStr ) Then
        CustSuppAmount.Text := TempStr
     Else
        CustSuppAmount.SetFocus;
end;

procedure TCashBookForm.CustSuppFromDblClick(Sender: TObject);
begin
     if PROG = SALESTX then
        NewListBox.ListIt ( Sender, Customers, 'C' )
     else
         NewListBox.ListIt ( Sender, Suppliers, 'S' );
     if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then begin
        CustSuppFrom.Text := NewListBox.ListInfo.ReturnValue;
        CustsuppFromExit(self);
     end;
end;

procedure TCashBookForm.CustSuppToDblClick(Sender: TObject);
begin
     If ( ToSalesRadio.Checked ) And ( PROG = SALESTX ) Then
        NewListBox.ListIt ( Sender, Customers, 'C' )
     Else
         If ( ToPurchaseRadio.Checked ) And ( PROG = PURCHTX ) Then
            NewListBox.ListIt ( Sender, Customers, 'C' )
         Else
             NewListBox.ListIt ( Sender, Suppliers, 'S' );
     If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then begin
        CustSuppTo.Text := NewListBox.ListInfo.ReturnValue;
        CustsuppToExit(self);
     end;


     
end;

procedure TCashBookForm.DetailGridMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var Column, Row : Longint;

begin
     DetailGrid.MouseToCell(X, Y, Column, Row);
     if ((Column = EntCol) or (Column = NomCol) or (column = VCodeCol) or (column =  ANCol)) then  DetailGrid.Hint := ReadLang(148, CurrLang)
          else if (Column = QtyCol) then DetailGrid.Hint := ReadLang(149, CurrLang)
               Else DetailGrid.Hint := '';
end;

procedure TCashBookForm.F6ButtonClick(Sender: TObject);
begin
     CallCalcAmt;
end;

Procedure TCashBookForm.CallCalcAmt;
var                                                           // TGM AB 18/11/16
      tempstr : string;                                        // TGM AB 18/11/16
begin
     CalcamtForm.SQuantity := DetailGrid.Cells[QtyCol, DetailGrid.Row];
     if Numeric(DetailGrid.Cells[NomCol, DetailGrid.Row]) then
        CalcamtForm.TempNom := StrToInt(DetailGrid.Cells[NomCol, DetailGrid.Row])
     else
        CalcamtForm.TempNom := 0;
        CalcamtForm.ShowModal;
     if CalcAmtForm.OKClicked then
        begin
          DetailGrid.Cells[QtyCol, DetailGrid.Row] := CalcamtForm.SQuantity;

          // TGM AB 18/11/16

          tempstr := '';
          tempstr := DetailGrid.Cells[AmtCol, DetailGrid.Row];
          if length (DetailGrid.Cells[AmtCol, DetailGrid.Row]) = 1 then begin
              if tempstr[1] = '-' then begin
                 if CalcamtForm.STotalCost[1] <> '-' then tempstr :=  CalcamtForm.STotalCost + '-'
                        else tempstr := CalcamtForm.STotalCost;
              end;
          end
                else tempstr := CalcamtForm.STotalCost;

          DetailGrid.Cells[AmtCol, DetailGrid.Row] := Tempstr;

          // end TGM AB 18/11/16

     //     DetailGrid.Cells[AmtCol, DetailGrid.Row] := CalcamtForm.STotalCost;              // TGM AB 18/11/16
          // ReCalculate the VAT Amount
          IsVatCalculated[DetailGrid.Row] := FALSE;
          DetailGrid.Col := VCodeCol;  // Move into the Amount Column
          DetailGrid.SetFocus;
          IsVatCalculated[DetailGrid.Row] := true;
        end;
end;

procedure TCashBookForm.AmtReceivedKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     If Key = VK_F2 Then
        Begin
           NewListBox.ListInfo.Account := CustSuppCode.Text;
           If PROG = SALESTX Then
              NewListBox.ListIt ( Sender, CustLedgerCards, 'L' )
           Else
               NewListBox.ListIt ( Sender, SuppLedgerCards, 'L' );
           If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
              AmtReceived.Text := NewListBox.ListInfo.ReturnValue;
           Key := 0;
        End;

//     If Cash2.XCOUNTRY = 2 Then
        If Key = VK_F5 then
           ( Sender as TEdit).Text := EuroConvert( ( Sender as TEdit).Text );

        AmtReceived.Modified := True;
        AmtReceivedChange(self);
end;

procedure TCashBookForm.CommentKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   If Key = VK_F1 then
     Begin
       if SalesPurchaseGroup.Visible then
         begin
             Application.HelpContext(6);
         end
       else Application.HelpContext(144);
     End;
   //Key := 0;

   If Key = VK_F2 then begin
      If expenditure.checked then  NewListBox.ListIt ( Sender, Suppliers, 'S' )
         else NewListBox.ListIt ( Sender, Customers, 'C' );
      If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then begin
            comment.Text := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ),1);
            cust_suppcode := StrToInt(NewListBox.ListInfo.ReturnValue);
            justadded := true;
      end else begin
               Comment.text := '';
               showmessage('Please choose from the drop down list of Customers / Suppliers.')
               end;

   end;

end;

procedure TCashBookForm.PaymentReceiptKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
If Key = VK_F1 then
   Begin
      if PROG = SALESTX then
         begin
             Application.HelpContext(72);
         end
      else Application.HelpContext(77);
   End;
   Key := 0;
end;

procedure TCashBookForm.PaymentReceiptMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     Comment.text := CustSuppNameLabel.Caption;
end;

procedure TCashBookForm.TxDateExit(Sender: TObject);
Var
   TestDate : ShortString;
   DateBefore : Boolean;
begin
     TestDate := '';
     TestDate := TxDate.Text;
     If NOT DateValid ( TxDate.Text, TDateFormat ) Then
        TxDate.SetFocus
     Else If NOT CheckDateRange ( TestDate, True, DateBefore, True ) Then
        Begin
             TxDate.Text := TestDate;
             TxDate.SetFocus;
        End;
     PromptLine.Panels.Items[1].Text := '';
end;

procedure TCashBookForm.DateSearchCloseUp(Sender: TObject);
begin
     TxDate.Text:= DateToStr(DateSearch.Date);
     TxDate.SetFocus;
end;

procedure TCashBookForm.DateSearchDropDown(Sender: TObject);
begin
    DateSearch.Date := StrToDate (TxDate.Text );
end;

procedure TCashBookForm.BankListAccClick(Sender: TObject);
begin
     If BankAccount.Visible Then
        Begin
             NewListBox.ListIt ( Sender, Banks, 'N' );
             If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
                BankAccount.Text := NewListBox.ListInfo.ReturnValue;
             BankAccountExit ( Sender );
        End;
end;

procedure TCashBookForm.FormShow(Sender: TObject);
begin
     Tasknumber := 0; // TGM AB
     Setupcolumns(self); // TGM AB 17/06/02
     Valuereturned := false;
     BankListAcc.Hide;
     If Cash1.XCASHBOOK Then    // TGM AB removed NOT
        Begin
             BankAccount.Text := IntToStr ( Cash1.xLastBank );
             BankAccount.SetFocus;
             Expenditure.SetFocus;
             BankAccount.SetFocus;
        end;
end;

procedure TCashBookForm.CustSuppToKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   If Key = VK_F2 Then
     Begin
          if ( ToSalesRadio.Checked ) and ( PROG = SALESTX ) then
             NewListBox.ListIt ( Sender, Customers, 'C' )
          else
             if ( ToPurchaseRadio.Checked ) and ( PROG = PURCHTX ) then
                NewListBox.ListIt ( Sender, Customers, 'C' )
             else
                NewListBox.ListIt ( Sender, Suppliers, 'S' );
          (*
          If PROG = SALESTX Then
             ListBox.ListIt ( Sender, Customers, 'C' )
          Else
             ListBox.ListIt ( Sender, Suppliers, 'S' );
          *)
          If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
             CustSuppTo.Text := NewListBox.ListInfo.ReturnValue;
     End;

   If Key = VK_F1 Then
      If Prog = SalesTx Then
         Application.HelpContext(20)
      Else
         Application.HelpContext(28);

end;

procedure TCashBookForm.CustSuppFromKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_F2 then
     begin
          if PROG = SALESTX Then
             NewListBox.ListIt ( Sender, Customers, 'C' )
          else
             NewListBox.ListIt ( Sender, Suppliers, 'S' );
          if Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
             CustSuppFrom.Text := NewListBox.ListInfo.ReturnValue;
     end;

   if Key = VK_F1 then
      if Prog = SalesTx then
         Application.HelpContext(19)
      else
         Application.HelpContext(26);
end;

procedure TCashBookForm.CustSuppAmountKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//     If Cash2.XCOUNTRY = 2 Then
        If Key = VK_F5 then
           ( Sender as TEdit).Text := EuroConvert( (Sender as TEdit).Text );
end;

procedure TCashBookForm.DiscountKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//     If Cash2.XCOUNTRY = 2 Then
        If Key = VK_F5 then
           ( Sender as TEdit).Text := EuroConvert( ( Sender as TEdit).Text );
end;

procedure TCashBookForm.HelpClick(Sender: TObject);
begin
     If (PROG = CASHINC ) or (PROG = CASHEXP) Then
        //Application.HelpContext(216) //cashbook ledger
          AccsDataModule.HTMLHelp('cashBook.htm')
     Else if PROG = SALESTX Then
        //Application.HelpContext(66) //sales ledger
         AccsDataModule.HTMLHelp('salesLedger.htm')
     Else if PROG = PURCHTX Then
        //Application.HelpContext(67) //purchase ledger
          AccsDataModule.HTMLHelp('purchaseLedger.htm')

end;

procedure TCashBookForm.DetailGridClick(Sender: TObject);
var                                                                // TGM AB 18/11/16
        AccRange : TAccRange;                                      // TGM AB 18/11/16
begin
     // Hide the Extra Desc panel if its showing
     if pExtraDesc.Showing then
        pExtraDesc.Hide;

     if ((DetailGrid.Col = EntCol) or (DetailGrid.Col = NomCol) or (DetailGrid.Col = VCodeCol) or (DetailGrid.Col = ANCol)) then begin
              if NOT Cash11.xBilling then
                 PromptLine.Panels.Items[1].Text := 'Press F2 or Double Click to List Accounts - ' + F7Prompt
              else
                 PromptLine.Panels.Items[1].Text := 'Press F2 or Double Click to List Accounts';
     end

        else if (DetailGrid.Col =  QtyCol) then begin
              if NOT Cash11.xBilling then
                 if (not cash1.xcashbook) then PromptLine.Panels.Items[1].Text := F7Prompt // TGM AB 13/06/02
                    else PromptLine.Panels.Items[1].Text := 'Press F6 or Double Click to Calculate Quantity - ' + F7Prompt
              else
                 PromptLine.Panels.Items[1].Text := 'Press F6 or Double Click to Calculate Quantity';
        end

           else if (DetailGrid.Col = DesCol) then begin
              if NOT Cash11.xBilling then
                PromptLine.Panels.Items[1].Text := 'Press F7 or Double Click to add extra details'
              else
                PromptLine.Panels.Items[1].Text := '';

              if tasknumber < 2 then begin                                    // TGM AB 18/11/16
               //   if CashBookForm.DetailGrid.Cells[EntCol, DetailGrid.Row] <> '' then begin
                        AccRange := GetEntRanges ( CashBookForm.DetailGrid.Cells[EntCol, DetailGrid.Row] );
                        If NewListBox.CheckNom ( DetailGrid.Cells[NomCol,DetailGrid.Row], AccRange ) Then begin                         // TGM AB 02/12/16
                                if DetailGrid.Cells[TempCol,DetailGrid.Row] = '*' then begin                                            // TGM AB 02/12/16                                                 
                                           DetailGrid.Col := DetailGrid.Col;                                                            // TGM AB 02/12/16
                                           DetailGrid.Row := DetailGrid.Row;                                                            // TGM AB 02/12/16
                                    end else begin                                                                                      // TGM AB 02/12/16
                                        if DetailGrid.Cells[NomCol,DetailGrid.Row] <> '' then begin                                                          // TGM AB 27/01/17
                                                if CheckForDefaultProduct(DetailGrid.Cells[NomCol,DetailGrid.Row]) then getextradetails(true);                  // TGM AB 27/01/17
                                        end;                                                                                                                 // TGM AB 27/01/17
                                        DetailGrid.Cells[TempCol,DetailGrid.Row] := '*';                                                // TGM AB 02/12/16
                                    end;                                                                                                // TGM AB 02/12/16
                                end else Begin                                                                                          // TGM AB 02/12/16
                                        DetailGrid.Col := DetailGrid.Col;
                                        DetailGrid.Row := DetailGrid.Row;
                                End;
               //   end;
              end;                                                           // end TGM AB 18/11/16

           end

           // TGM AB to handle Details Column 18/06/02
           else if (DetailGrid.Col = DetailCol) then begin
                // be very careful with this section as it depends totally on the F7Prompt
                // as applied above
                if PromptLine.Panels.Items[1].Text = F7Prompt then Detailgrid.col := DesCol
                   else getextradetails(true);
                PromptLine.Panels.Items[1].Text := '';

           end
               else begin
                   if Cash11.xBilling then
                   PromptLine.Panels.Items[1].Text := ''
                   else
                   PromptLine.Panels.Items[1].Text := F7Prompt;
               end;
     Promptline.Refresh;
end;

procedure TCashBookForm.DetailGridExit(Sender: TObject);
Var TempArrPos  : Integer;
    TestVATCode : ShortString;
begin
    if LastCol = VCodeCol then // Check the VAT Code
       begin
          TestVATCode := DetailGrid.Cells[LastCol, Lastrow];
          SlimAll ( TestVATCode );
          if Length(TestVATCode) > 0 then
             begin
                if ( NOT NewListBox.CheckVAT ( TestVATCode, TempArrPos )) then
                   begin
                      DetailGrid.SetFocus;
                      MessageDLG(TestVATCode + ' is not a Valid VAT Code',mtinformation,[mbOk],0);
                   end
                else
                   begin
                      if TestVATCode <> OldVat then
                         DetailGrid.Cells[VAmtCol, Lastrow] := '0';
                      CheckVATForChanges(False);
                   end;
             end;
       end;
        PromptLine.Panels.Items[1].Text := '';

end;

procedure TCashBookForm.TxDateEnter(Sender: TObject);
begin
   PromptLine.Panels.Items[1].Text := 'Click The Down Arrow Button To Use The Calendar';
end;

procedure TCashBookForm.CustSuppCodeChange(Sender: TObject);
var teststr:string;
begin
     teststr := CustSuppCode.text;
     If ((not numeric(CustSuppCode.text)) and (CustSuppCode.text <> '')) then begin
          newlistbox.InitialSearchFieldText:=teststr;
          If PROG = SALESTX Then begin
             newListBox.ListIt ( Sender, Customers, 'C' );
          end Else begin
             newListBox.ListIt ( Sender, Suppliers, 'S' );
          end;

          If Length ( newListBox.ListInfo.ReturnValue ) > 0 Then
             CustSuppCode.Text := newListBox.ListInfo.ReturnValue;
             CustSuppCodeExit ( Sender );
          If (PaymentReceipt.checked or Cashinvoice.checked) then
             Comment.text := CustSuppNameLabel.Caption;
          CustSuppCodeExit ( Sender );
    end;

     if ((PaymentReceipt.Checked or Cashinvoice.checked)) then // TGM AB And (Not Cash1.XDEFCOMM)) then
        Comment.Text := '';

     Try
         PreviousYearTxs := False;
         IncludeLastYearCB.Checked := false;
     except
     end;

end;

procedure TCashBookForm.CustSuppFromExit(Sender: TObject);
var
   LocalDB,
   ThisRec : Integer;
   ThisStr : ShortString;
begin
     if PROG = SALESTX then
        LocalDB := SLFILE
     else
        LocalDB := PLFILE;
     if ( CheckCustSupp ( LocalDB, CustSuppFrom.Text )) then
        begin
           SetDB(LocalDB);
           ThisStr := CustSuppfrom.Text;
           SLIMALL(ThisStr);
           if Numeric(ThisStr) then
              begin
                 ThisRec := StrToInt(ThisStr);
                 ReadRec ( LocalDB, ThisRec );
                 GetItem(LocalDB, 1);
                 eFromName.Text := CurrStr;
                 GetItem(LocalDB, 7);
                 FromBalance := CurrLong;
                 LongStr ( CurrLong, CurrStr, 'L' );
                 eFromBal.Text := CurrStr;
              end
           else
              CustSuppFrom.SetFocus;
        end;
end;

procedure TCashBookForm.CustSuppToExit(Sender: TObject);
Var
   ThisRec,
   LocalDB,
   AccFrom,
   AccTo   : Integer;
   ThisStr,
   TempStr : ShortString;
begin
     if ( ToSalesRadio.Checked ) and ( PROG = SALESTX ) then
        LocalDB := SLFILE
     else if ( ToPurchaseRadio.Checked ) and ( PROG = PURCHTX ) then
        LocalDB := SLFILE
     else
        LocalDB := PLFILE;
     if ( CheckCustSupp ( LocalDB, CustSuppTo.Text )) then
        begin
           SetDB(LocalDB);
           ThisStr := CustSuppTo.Text;
           SLIMALL(ThisStr);
           if Numeric(ThisStr) then
              begin
                 ThisRec := StrToInt(ThisStr);
                 ReadRec ( LocalDB, ThisRec );
                 GetItem(LocalDB, 1);
                 eToName.Text := CurrStr;
                 GetItem(LocalDB, 7);
                 ToBalance := CurrLong;
                 LongStr ( CurrLong, CurrStr, 'L' );
                 eToBal.Text := CurrStr;
              end
           else
              Messagedlg('Invalid Information', mtConfirmation, [mbOK], 0);
        end;

     TempStr := ( CustSuppFrom.Text );
     SlimAll ( TempStr );
     if Numeric ( TempStr ) then
        AccFrom := StrToInt ( TempStr )
     else
         CustSuppFrom.SetFocus;
     TempStr := ( CustSuppTo.Text );
     SlimAll ( TempStr );
     if Numeric ( TempStr ) Then
        AccTo := StrToInt ( TempStr )
     else
     {    CustSuppTo.SetFocus;}
       Messagedlg('Invalid Information', mtConfirmation, [mbOK], 0);

     if ( ToSalesRadio.Checked ) then
        if ( AccFrom = AccTo ) then
           CustSuppTo.SetFocus;

end;

procedure TCashBookForm.CustSuppFromEnter(Sender: TObject);
begin
     eFromName.Text := '';
     eFromBal.Text := '';
end;

procedure TCashBookForm.CustSuppToEnter(Sender: TObject);
begin
     eToName.Text := '';
     eToBal.Text := '';
end;

procedure TCashBookForm.CustSuppAmountChange(Sender: TObject);
var
   TempLng : LongInt;
   TempStr : ShortString;
begin
     if CustSuppAmount.Modified and ( NOT GEditing ) then
        begin
           TempStr := CustSuppAmount.Text;
           if ChangeToLong ( TempStr ) then
              begin
                 StrLong ( TempStr, TempLng );
                 LongStr ( FromBalance-TempLng, CurrStr, 'L' );
                 eFromBal.Text := CurrStr;

                 if ToPurchaseRadio.Checked then
                    begin
                       LongStr ( ToBalance-TempLng, CurrStr, 'L' );
                       eToBal.Text := CurrStr;
                    end
                 else
                    begin
                       LongStr ( ToBalance+TempLng, CurrStr, 'L' );
                       eToBal.Text := CurrStr;
                    end;
              end;
        end;
end;

procedure TCashBookForm.AmtReceivedChange(Sender: TObject);
var
   TempLng : LongInt;
   TempStr : ShortString;
begin
     if AmtReceived.Modified and ( NOT GEditing ) then
        begin
           TempStr := AmtReceived.Text;
           if ChangeToLong ( TempStr ) then
              begin
                 StrLong ( TempStr, TempLng );
                 ThisAmount := TempLng;
                 LongStr ( CustSuppBalance-ThisAmount-ThisDiscount, CurrStr, 'L' );
                 CurrentBal.Text := CurrStr;
              //   LongStr ( CustSuppAged1-ThisAmount-ThisDiscount, CurrStr, 'L' );
              //   Aged1.Text := CurrStr;         TGM AB Removed
                 if PROG = SALESTX then
                    LongStr ( ThisBankBalance+ThisAmount, CurrStr, 'L' )
                 else
                    LongStr ( ThisBankBalance-ThisAmount, CurrStr, 'L' );
                 BankBalance.Text := CurrStr;
              end;
        end;
end;

procedure TCashBookForm.DiscountChange(Sender: TObject);
var
   TempLng : LongInt;
   TempStr : ShortString;
begin
     if Discount.Modified and ( NOT GEditing ) then
        begin
           TempStr := Discount.Text;
           if ChangeToLong ( TempStr ) then
              begin
                 StrLong ( TempStr, TempLng );
                 ThisDiscount := TempLng;
                 LongStr ( CustSuppBalance-ThisDiscount-ThisAmount, CurrStr, 'L' );
                 CurrentBal.Text := CurrStr;
               //  LongStr ( CustSuppAged1-ThisDiscount-ThisAmount, CurrStr, 'L' );
               //  Aged1.Text := CurrStr;   TGM AB Removed
                 if PROG = SALESTX then
                    LongStr ( ThisBankBalance+ThisAmount, CurrStr, 'L' )
                 else
                    LongStr ( ThisBankBalance-ThisAmount, CurrStr, 'L' );
                 BankBalance.Text := CurrStr;
              end;
        end;
end;

procedure TCashBookForm.DetailGridSetEditText(Sender: TObject; ACol,
  ARow: Longint; const Value: String);
var testdone:boolean;
begin
   // ((ACol = QtyCol) and (DetailGrid.cells[Acol,Arow] = '')) then DetailGrid.cells[Acol,Arow] := '1.00';
   if LastCol <> ACol then
      LastCol := ACol;
   if LastRow <> ARow then
      LastRow := ARow;
   if ( ACol = AmtCol ) {or (( ACol = AmtCol ) and ( LastRow <> ARow )) }then
      begin
         OldAmt := Value;
         if ( IsAmtChanged[ARow] <> Value ) And ( Value <> '' ) then
            begin
               IsAmtChanged[ARow] := Value;
//tgm VAT Inclusive problem has something to do with this
               IsVATCalculated[ARow] := false;


            end;
      end
   else if ( ACol = VCodeCol ) {or (( ACol = VCodeCol ) and ( LastRow <> ARow )) }then
      begin
         OldVat := Value;
         if (IsCodeChanged[ARow] <> Value) And (Length(Trim(Value))> 0 ) then
            begin
                 IsCodeChanged[ARow] := Value;
                 IsVatCalculated[ARow] := false;
            end;

      end;

   //Vat Amount is Blank
   {
   else if ( ACol = VAmtCol ) And ( Length(Trim(Value)) = 0 ) then
        IsVATCalculated[ARow] := FALSE;
   }
        if (ACol = VAmtCol) then IsVATCalculated[ARow]:=True;
end;

procedure TCashBookForm.DetailGridGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);

begin




   if ( ACol = AmtCol ) or (( ACol = AmtCol ) and ( LastRow <> ARow )) then
      begin
//         OLDAmt := CashBookForm.DetailGrid.Cells[ACol, ARow];
         NewAmt := Value; // OldAmt;
         IsAmtChanged[ARow] := Value;
      end
   else if ( ACol = VCodeCol ) or (( ACol = VCodeCol ) and ( LastRow <> ARow )) then
      begin
//       OLDVat := CashBookForm.DetailGrid.Cells[ACol, ARow];
         NewVAT := Value; //OldVAT;
         IsCodeChanged[ARow] := Value;
      end
   else if ( ACol = VAmtCol ) or (( ACol = VAmtCol ) and ( LastRow <> ARow )) then
      begin
//         OLDVatAmt := CashBookForm.DetailGrid.Cells[ACol, ARow];
         NewVATAmt := Value; //OldVATAmt;
      end;
end;


procedure TCashBookForm.DetailGridGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
     DetailGrid.EditorMode := True;
//          EntCol : Value := '!>AAAA; ';
//          NomCol : Value := '!9999; ';
     if ACol = VCodeCol then Value := '!>A; ';
//          ANCol : Value := '!9999; ';

end;

procedure TCashBookForm.pExtraDescExit(Sender: TObject);
begin
    if AccsDataModule.ProdsTxTemp.Active then
       if AccsDataModule.ProdsTxTemp.State in dsEditmodes then
          AccsDataModule.ProdsTxTemp.Post;
//    try AccsDataModule.ProdsTxTemp.Post;
//    except
//    end;
    pExtraDesc.Hide;
    // TGM AB 18/06/02
    Detailgrid.cells[DetailCol,Detailgrid.row] := copy(VarToStr(AccsDataModule.ProdsTxTemp['LineDate']),1,6) + copy(varToStr(AccsDataModule.ProdsTxTemp['LineDate']),9,2) + ' ' + LineRef.text + ' ' + DBEdesc1.Text;
    try if Detailgrid.cells[EachCol,Detailgrid.row] <> '' then DetailGrid.Col := QtyCol
       else DetailGrid.Col := Detailgrid.col +1;
    except DetailGrid.Col := Detailgrid.col +1;
    end;
    Detailgrid.setfocus;
end;

procedure TCashBookForm.DBEdit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_F7 then    { F7 Pressed }
       begin
          pExtraDesc.Hide;
          DetailGrid.SetFocus;
       end;
end;

procedure TCashBookForm.ReportsButtonClick(Sender: TObject);
var
   reporttype : char;
   SummaryAmount, SummaryTAXamount, SummaryTotalamount : real;
   i,code : integer;
   TempString : string;
begin

// TGM AB 04/06/15 Added 11 lines of code below to run new report - commented out all the remaining code regarding the old report.

    enablethescreen(self);
    If not bool(JobCardReportSetupForm) then Application.CreateForm(TJobCardReportSetupForm, JobCardReportSetupForm);
    if tasknumber = 4 then JobCardReportSetupForm.LoadForm('P');
    if tasknumber = 5 then JobCardReportSetupForm.LoadForm('Q');
    if jobcardpanel.visible then JobCardReportSetupForm.LoadForm('J');
    Jobcardexitclick(self);
    proformaexitclick(self);
    disablethescreen(self);
    if tasknumber = 5 then QuoteClick(self)
        else if tasknumber = 4 then ProformaClick(self)
             else jobcardsclick(self);

{

     enablethescreen(self);
     // next bit would allow detailed report, however need to add descrition fields for report to make
     // sense if detailed report is chosen
     // postponed this task 18/04/03
     //if messagedlg('Summary Report Only?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin

     if tasknumber = 4 then begin
                                        reporttype := 'P';
                                        reportsql.Close;
                                        reportsql.SQL.Clear;
                                        reportsql.sql.Add('select Min(S.Name) as CName, BatchID,Min(CustID) as Customer,SUM(CAST(Amount AS NUMERIC)) as Amount, SUM(CAST(TaxAmount AS NUMERIC)) as TAXAmount, SUM(CAST(Amount AS NUMERIC) + cast(TaxAmount AS NUMERIC)) as TotalAmount,'
                                                                  + ' Min(JobDate) as JDate, Min(Comment) as JComment, Min(Reference) as Reference from proforma P');
                                        reportsql.sql.Add('left join SLedger.db S on (S.Account = P.CustID) where (P.proforma = ''true'' and P.complete = ''false''and BatchID > 0)');
                                        reportsql.sql.Add('group by BatchID');
                                        reportsql.sql.Add('order by Customer');

     end;
     if tasknumber = 5 then begin
                                        reporttype := 'Q';
                                        reportsql.Close;
                                        reportsql.SQL.Clear;
                                        reportsql.sql.Add('select Min(S.Name) as CName, BatchID,Min(CustID) as Customer,SUM(CAST(Amount AS NUMERIC)) as Amount, SUM(CAST(TaxAmount AS NUMERIC)) as TAXAmount, SUM(CAST(Amount AS NUMERIC) + cast(TaxAmount AS NUMERIC)) as TotalAmount, Min(JobDate) as JDate,'
                                                                  + ' Min(Comment) as JComment, Min(Reference) as Reference from proforma P');
                                        reportsql.sql.Add('left join SLedger.db S on (S.Account = P.CustID) where (P.quote = ''true'' and P.complete = ''false''and BatchID > 0)');
                                        reportsql.sql.Add('group by BatchID');
                                        reportsql.sql.Add('order by Customer');

     end;

     if jobcardpanel.visible then begin
                                        reporttype := 'J';
                                        reportsql.Close;
                                        reportsql.SQL.Clear;
                                        reportsql.sql.Add('select Min(S.Name) as CName, BatchID,Min(CustID) as Customer,SUM(CAST(Amount AS NUMERIC)) as Amount, SUM(CAST(TaxAmount AS NUMERIC)) as TAXAmount, SUM(CAST(Amount AS NUMERIC) + cast(TaxAmount AS NUMERIC)) as TotalAmount,'
                                                                  + ' Min(JobDate) as JDate, Min(Comment) as JComment, Min(Reference) as Reference from proforma P');
                                        reportsql.sql.Add('left join SLedger.db S on (S.Account = P.CustID) where (P.proforma = ''false'' and P.Quote = ''False'' and P.complete = ''false'' and BatchID > 0)');
                                        reportsql.sql.Add('group by BatchID');
                                        reportsql.sql.Add('order by Customer');
     end;
  end;{ else begin  // this bit would give the detailed form - need to add desc fields
      if tasknumber = 4 then begin
                                        reporttype := 'P';
                                        reportsql.Close;
                                        reportsql.SQL.Clear;
                                        reportsql.sql.Add('select S.Name as CName, BatchID, CustID as Customer, CAST(Amount AS NUMERIC) as TotalAmount, JobDate as JDate, Comment as JComment, Reference as Reference from proforma P');
                                        reportsql.sql.Add('left join SLedger.db S on (S.Account = P.CustID) where (P.proforma = ''true'' and P.complete = ''false'')');
                                        reportsql.sql.Add('order by Customer, BatchID');

     end;
     if tasknumber = 5 then begin
                                        reporttype := 'Q';
                                        reportsql.Close;
                                        reportsql.SQL.Clear;
                                        reportsql.sql.Add('select S.Name as CName, BatchID, CustID as Customer, CAST(Amount AS NUMERIC) as TotalAmount, JobDate as JDate, Comment as JComment, Reference as Reference from proforma P');
                                        reportsql.sql.Add('left join SLedger.db S on (S.Account = P.CustID) where (P.quote = ''true'' and P.complete = ''false'')');
                                        reportsql.sql.Add('order by Customer, BatchID');

     end;

     if jobcardpanel.visible then begin
                                        reporttype := 'J';
                                        reportsql.Close;
                                        reportsql.SQL.Clear;
                                        reportsql.sql.Add('select S.Name as CName, BatchID, CustID as Customer, CAST(Amount AS NUMERIC) as TotalAmount, JobDate as JDate, Comment as JComment, Reference as Reference from proforma P');
                                        reportsql.sql.Add('left join SLedger.db S on (S.Account = P.CustID) where (P.proforma = ''false'' and P.complete = ''false'')');
                                        reportsql.sql.Add('order by Customer, BatchID');
     end;


  end;}
  {   ReportSql.active := true;
     try  Application.CreateForm(TJobCardReportForm, JobCardReportForm);
       except
     end;
     Reportsql.first;
     SummaryAmount := 0;
     SummaryTAXAmount := 0;
     SummaryTotalAmount := 0;
     for i := 1 to Reportsql.recordcount do begin
         try SummaryAmount := Reportsql['Amount'] + SummaryAmount;
         except
         end;
         try SummaryTAXAmount := Reportsql['TAXAmount'] + SummaryTAXAmount;
         except
         end;
         try SummaryTotalAmount := Reportsql['TotalAmount'] + SummaryTotalAmount;
         except
         end;
         if i <> Reportsql.recordcount then Reportsql.next;
     end;
     TempString := '0';
     Str(SummaryAmount:8:2,TempString);
     JobCardReports.JobCardReportForm.SummaryAmount.caption := tempstring;
     TempString := '0';
     Str(SummaryTAXAmount:8:2,TempString);
     JobCardReports.JobCardReportForm.SummaryTAXAmount.caption := tempstring;
     TempString := '0';
     Str(SummaryTotalAmount:8:2,TempString);
     JobCardReports.JobCardReportForm.SummaryTotalAmount.caption := tempstring;
     JobCardReportForm.BuildReport(reporttype);
     application.processmessages;
     Jobcardexitclick(self);
     proformaexitclick(self);
     disablethescreen(self);
     if reporttype = 'Q' then QuoteClick(self)
        else if reporttype = 'P' then ProformaClick(self)
             else jobcardsclick(self);
  }
end;

procedure TCashBookForm.closeExtraDescButtonClick(Sender: TObject);
var description1a,description1b :string;
begin
     pExtraDesc.visible:=false;
     if length(varToStr(AccsDataModule.ProdsTxTemp['LineDate'])) = 8 then Description1a := copy(varToStr(AccsDataModule.ProdsTxTemp['LineDate']),1,8)
     else Description1a := copy(varToStr(AccsDataModule.ProdsTxTemp['LineDate']),1,6) + copy(varToStr(AccsDataModule.ProdsTxTemp['LineDate']),9,2);
     Description1b := LineRef.text;
     if Length(Description1a) > 0 then Description1a := Description1a + ' ';
     if Length(Description1b) > 0 then Description1b := Description1b + ' ';
     DetailGrid.Cells[DetailCol,Detailgrid.row] := Description1a + Description1b + DbeDesc1.text;
end;

procedure TCashBookForm.SaveJobCards(BatchId : Integer; CardType :String);
var i,code,Nominal: integer;
    qty,total,each,Amount,TaxAmount:real;
    f:textfile;
    tempstring,SEach:string;
    invoiceNumber:integer;
    Line1,Line2,Line3,SInvoiceNumber:string;
    ProductID : integer;
    VLineDate, VLineRef : string;

    // Cardtype
    //         P - Proforma
    //         J - Job Card
    //         C - Complete
    //         Q - Quote
    //         PC - Proforma Complete
    //         QC - Quote Complete
    //         JC - JobCard Complete
begin

       detailgrid.Col := ANCol; // TGM AB 27/06/14

       query1.DatabaseName := accsdatamodule.AccsDataBase.databasename;
       Query1.close;
       If CardType = 'J' then begin
          Query1.sql.text := 'Update proforma.db set BatchID = -1 where batchid = ' + '''' + VartoStr(BatchID) + ''' and Proforma = False and Quote = false;';
          //'Delete from proforma.db where batchid = ' + '''' + VartoStr(BatchID) + ''' and Proforma = False and Quote = false;';

          Query1.execsql;
       end;
       If CardType = 'P' then begin
          Query1.sql.text := 'Update proforma.db set BatchID = -1 where batchid = ' + '''' + VartoStr(BatchID) + ''' and Proforma = True;';
          Query1.execsql;
       end;

       If CardType = 'Q' then begin
          query1.sql.text := 'Update proforma.db set BatchID = -1 where batchid = ' + '''' + VartoStr(BatchID) + ''' and Quote = True;';
          Query1.execsql;
       end;

//       Showmessage('Saving Record Number :- ' + Vartostr(BatchID));
       accsdatamodule.ProformaDB.open;

       //       invoice.open;
       if not ((CardType = 'PC') or (CardType ='JC') or (CardType = 'QC')) then begin
          BatchID := FindHighestJobCardNumber + 1;
          FOR i:=1 TO detailgrid.rowcount-1 do begin

          Line1:='';
          Line2:='';
          Line3:='';
          VLineDate := '';
          VLineRef := '';
          ProductID := 0;
          tempstring:= detailgrid.cells[NomCol,i];
          val(tempstring,Nominal,code);
          if Nominal > 0 then begin
             if AccsDataModule.ProdsTxTemp.Locate('LineNo',i,[] ) then begin
                VLineDate := AccsDataModule.ProdsTxTemp.FieldByName('LineDate').AsString;
                VLineRef := AccsDataModule.ProdsTxTemp.FieldByName('LineRef').AsString;
                line1:= AccsDataModule.ProdsTxTemp.FieldByName('Desc1').AsString;
                line2:= AccsDataModule.ProdsTxTemp.FieldByName('Desc2').AsString;
                line3:= AccsDataModule.ProdsTxTemp.FieldByName('Desc3').AsString;
                if AccsDataModule.ProdsTxTemp['ProductID']> 0 then ProductID := AccsDataModule.ProdsTxTemp.fieldbyname('ProductID').AsInteger;

             end;
             If detailgrid.cells[QtyCol,i] = '' then detailgrid.cells[QtyCol,i] := '1.00';
             tempstring:= detailgrid.cells[QtyCol,i];
             val(tempstring,qty,code);
             tempstring:= detailgrid.cells[AmtCol,i];
             val(tempstring,total,code);
             if ((total > 0) and (qty > 0)) then begin
                each:=total/qty;
                str(each:5:2,SEach);
             end else SEach := '   ';
             with accsdataModule.ProformaDB do begin
                  append;
                  fieldvalues['BatchID']:=BatchID;
                  fieldvalues['JobDate']:=StrToDate(TxDate.text);
                  FieldValues['CustID']:=StrToInt(CustSuppCode.text);
                  FieldValues['Reference']:=Reference.text;
                  FieldValues['Enterprise']:= detailgrid.cells[EntCol,i];
                  FieldValues['Nominal']:= Nominal;
                  FieldValues['Descript']:= detailgrid.cells[DesCol,i];
                  FieldValues['Quantity']:=detailgrid.cells[QtyCol,i];
                  FieldValues['Amount']:=detailgrid.cells[AmtCol,i];
                  FieldValues['TaxCode']:=detailgrid.cells[VCodeCol,i];
                  FieldValues['TaxAmount']:=detailgrid.cells[VAmtCol,i];
                  try FieldValues['AnalysisCode'] := detailgrid.cells[ANCol,i];
                  except FieldValues['AnalysisCode'] := '0';
                  end;
                  FieldValues['LineNo']:=i;
                  If Length(VLinedate) > 1 then FieldValues['LineDate']:=StrToDate(VLineDate);
                  FieldValues['LineRef']:=VLineRef;
                  FieldValues['Desc1']:=Line1;
                  FieldValues['Desc2']:=Line2;
                  FieldValues['Desc3']:=Line3;
                  FieldValues['Comment']:=Comment.text;
                  Fieldvalues['ProductID'] := ProductID;
                  if CardType = 'J' then begin
                                               FieldValues['Proforma'] := False;
                                               FieldValues['Quote'] := False;
                                               FieldValues['Complete'] := False;
                                               FieldValues['JobCardNumber'] := StrToInt(Reference.text);
                                               if not editingJobCard then begin
                                                  accsdatamodule.InvoiceNumbers.edit;
                                                  accsdatamodule.InvoiceNumbers['LastJobCard']:= StrToInt(Reference.text); //JobCardNumber; //ProformaNumber;//invoiceNumber;
                                                  accsdatamodule.InvoiceNumbers.post;
                                                  invoicenumber := 0;
                                               end;
                  end;
                  if CardType = 'P' then begin
                                               FieldValues['Proforma'] := True;
                                               FieldValues['Quote'] := False;
                                               FieldValues['Complete'] := False;
                                               FieldValues['ProformaNumber'] :=  StrToInt(Reference.text);
                                               if not editingJobCard then begin
                                                  accsdatamodule.InvoiceNumbers.edit;
                                                  accsdatamodule.InvoiceNumbers['LastProforma']:= StrToInt(Reference.text);
                                                  accsdatamodule.InvoiceNumbers.post;
                                                  invoicenumber := 0;
                                               end;
                  end;
                  if CardType = 'Q' then begin
                                               FieldValues['Quote'] := True;
                                               FieldValues['Proforma'] := False;
                                               FieldValues['Complete'] := False;
                                               FieldValues['QuoteNumber'] := StrToInt(Reference.text); //QuoteNumber; //CurrentQuoteNumber;
                                               if not editingJobCard then begin
                                                  accsdatamodule.InvoiceNumbers.edit;
                                                  accsdatamodule.InvoiceNumbers['LastQuote']:=StrToInt(Reference.text); //QuoteNumber; //invoiceNumber;
                                                  accsdatamodule.InvoiceNumbers.post;
                                                  invoicenumber := 0;
                                               end;
                  end;
                  post;
             end;
          end;
          end;
       end;
       if CardType = 'PC' then begin
          Query1.sql.text := 'Update proforma.db set Complete = ''True'' where BatchId = ' + '''' + VartoStr(BatchID) + ''' and Proforma = True and Complete = False;';
          Query1.execsql;
       end;

       if CardType = 'JC' then begin
         Query1.sql.text := 'Update proforma.db set Complete = ''True'' where BatchId = ' + '''' + VartoStr(BatchID) + ''' and Proforma = False and Quote = False  and Complete = False;';
          Query1.execsql;
       end;

       if CardType = 'QC' then begin
          Query1.sql.text := 'Update proforma.db set Complete = ''True'' where BatchId = ' + '''' + VartoStr(BatchID) + ''' and Quote = True and Complete = False;';
          Query1.execsql;
       end;



     if ((cardtype <> 'PC') and (CardType <> 'JC') and (CardType <> 'QC')) then begin
        AccsDataModule.ProdsTxTemp.active:=false;
        AccsDataModule.ProdsTxTemp.EmptyTable;
        AccsDataModule.ProdsTxTemp.open;
     end;

end;

procedure TCashBookForm.LoadJobCards(BatchID : string; CardType : Char);
var i,linecount,code,Nominal: integer;
    qty,total,each:real;
    f:textfile;
    tempstring,SEach:string;
    invoiceNumber:integer;
    Line1,Line2,Line3,SInvoiceNumber:string;
    ProductID : integer;
    //JobNumber, filter :string;
    filter : string;
    R,c:integer;
    VLineDate,VLineRef : string;
    ExtraDetails : boolean;

    // card type - J Job Card
    //           - P Proforma

begin
     if FIsLoadingInvoice then Exit;

     EnableTheScreen(self);


     FIsLoadingInvoice := True;
     try

     If cardType = 'J' then Filter := ' BatchID = ''' + BatchID + '''and Proforma = false and Quote = False';
     if cardtype = 'P' then Filter := 'BatchID = ''' + BatchID + ''' and Proforma = ''True''';
     if cardtype = 'Q' then Filter := 'BatchID = ''' + BatchID + ''' and Quote = ''True''';

     accsdatamodule.ProformaDB.filter:= Filter;
     accsDataModule.ProformaDB.Filtered := true;
     accsdatamodule.ProformaDB.open;
     accsdatamodule.ProformaDB.first;

     // empty the grid!
     For r := 1 to MaxGridLines + 1 do begin  // TENFOUND WAS 11
         for c:= 0 to 25 do begin //Detailgrid.ColCount-1 do begin
             detailgrid.Cells[c,r] := '' ;
         end; // for c
     end; // for r

     AccsDataModule.ProdsTxTemp.active:=false;
     AccsDataModule.ProdsTxTemp.EmptyTable;
     AccsDataModule.ProdsTxTemp.open;

     FOR i:=1 TO AccsDataModule.ProformaDB.recordcount do begin //detailgrid.rowcount-1 do begin
          Line1:='';
          Line2:='';
          Line3:='';
          VLineRef := '';
          VLineDate := '';
          Extradetails := false;
          ProductID := 0;

       with accsdataModule.ProformaDB do begin
            TxDate.text:=DateToStr(FieldValues['JobDate']);
            CustSuppCode.text:=varToStr(FieldValues['CustID']);
            Reference.text:= varToStr(FieldValues['Reference']);
            Comment.text:= varToStr(FieldValues['Comment']);
            detailgrid.cells[EntCol,i]:=varToStr(FieldValues['Enterprise']);
            detailgrid.cells[NomCol,i]:=varToStr(FieldValues['Nominal']);
            detailgrid.cells[DesCol,i]:= varToStr(FieldValues['Descript']);
            detailgrid.cells[QtyCol,i]:= varToStr(FieldValues['Quantity']);
            detailgrid.cells[AmtCol,i]:= varToStr(FieldValues['Amount']);
            detailgrid.cells[VCodeCol,i]:= varToStr(FieldValues['TaxCode']);
            detailgrid.cells[VAmtCol,i]:= varToStr(FieldValues['TaxAmount']);
            detailgrid.cells[ANCol,i] := vartostr(FieldValues['AnalysisCode']);
            VLineDate := varToStr(FieldValues['LineDate']);
            VLineRef := varToStr(FieldValues['LineRef']);
            line1:=varToStr(FieldValues['Desc1']);
            line2:=varToStr(FieldValues['Desc2']);
            line3:=varToStr(FieldValues['Desc3']);
            if FieldByName('ProductID').AsInteger > 0 then ProductID := FieldByName('ProductID').AsInteger;
            if length(VLineDate) > 1 then extradetails := true;
            if length(VLineRef) > 1 then extradetails := true;
            if length(line1) > 1 then extradetails := true;
            if length(line2) > 1 then extradetails := true;
            if length(line3) > 1 then extradetails := true;
            If ExtraDetails then begin
               AccsDataModule.ProdsTxTemp.Append;
           //    if AccsdataModule.ProdsTx['LineDate'] <> 0 then AccsdataModule.ProdsTxTemp['LineDate'] := AccsdataModule.ProdsTx['LineDate'];
           //    if AccsdataModule.ProdsTx['LineRef'] <> 0 then AccsdataModule.ProdsTxTemp['LineRef'] := AccsdataModule.ProdsTx['LineRef'];
               AccsDataModule.ProdsTxTemp['Desc1']:=Line1;
               If Length(VLineDate) > 1 then AccsDataModule.ProdsTxTemp['LineDate']:=StrToDate(VLineDate);
               If Length(VLineRef) > 1 then AccsDataModule.ProdsTxTemp['LineRef']:=VLineRef;
               If Length(Line2) > 1 then AccsDataModule.ProdsTxTemp['Desc2']:=Line2;
               If Length(Line3) > 1 then AccsDataModule.ProdsTxTemp['Desc3']:=Line3;
               AccsDataModule.ProdsTxTemp['LineNo']:= i; //varToStr(FieldValues['LineNo']);
               AccsDataModule.ProdsTxTemp['ProductID'] := ProductID;
               AccsDataModule.ProdsTxTemp.Post;
               Detailgrid.cells[Detailcol,i] := VLineDate + ' ' + VLineRef + ' ' + Line1;
            end;
            IsVATCalculated[i] := true;
       end;

       // TGM AB calculate the each amount and fill into column
       calculateUnitCost(i,false);
       // end;

       if i <> AccsDataModule.ProformaDB.RecordCount then AccsDataModule.ProformaDB.next;
     end;

     // TGM AB 19/06/02 - Next few Lines gathers the details column
     application.processmessages;
     txdate.SetFocus;
     CustSuppCodeExit(self); // gathers up name & address, displays on form!

     finally
        FIsLoadingInvoice := False;
        if (DetailGrid.RowCount>0) then
           DetailGrid.TopRow := 1;
     end;
     // detail field on lines
     //for i := 1 to AccsDataModule.ProformaDB.recordcount do begin
     //                    detailgrid.row:= i;
     //                    getextradetails(false);
     //end;
     // End TGM AB
end;

procedure TCashBookForm.TotalLessVATChange(Sender: TObject);
var temp:real;
    tempstring:string;
    code:integer;
begin
     If ((Cash11.xEuroConverter > 0) or (Cash11.xEuroConverter < 0)) then begin
        val(TotalLessVAT.text,temp,code);
        temp:=temp/100;
        if Cash11.xSaveAsEuro then Str((Temp * Cash11.xEuroConverter):8:2,TempString)
        else Str((Temp / Cash11.xEuroConverter):8:2,TempString);
        TotalLessVATEuro.text := TempString;
     end;
end;

procedure TCashBookForm.TotalVATChange(Sender: TObject);
var temp:real;
    tempstring:string;
    code:integer;
begin
     If ((Cash11.xEuroConverter > 0) or (Cash11.xEuroConverter < 0)) then begin
        val(TotalVAT.text,temp,code);
        temp:=temp/100;
        if Cash11.xSaveAsEuro then Str((Temp * Cash11.xEuroConverter):8:2,TempString)
        else Str((Temp / Cash11.xEuroConverter):8:2,TempString);
        TotalVATEuro.text := TempString;
     end;
end;

procedure TCashBookForm.TotalAmtChange(Sender: TObject);
var temp:real;
    tempstring:string;
    code:integer;
begin
     If ((Cash11.xEuroConverter > 0) or (Cash11.xEuroConverter < 0)) then begin
        val(TotalAmt.text,temp,code);
        temp:=temp/100;
        if Cash11.xSaveAsEuro then Str((Temp * Cash11.xEuroConverter):8:2,TempString)
        else Str((Temp / Cash11.xEuroConverter):8:2,TempString);
        TotalAmtEuro.text := TempString;
     end;
end;


procedure TCashBookForm.CalculateAmount(Sender: TObject);
var
    NewTotal, Each, Qty : Double;
    TempStr : ShortString;
    SCost, SQuantity, STotalCost : ShortString;
    LCost, LQuantity : LongInt;
begin
     // TGM AB 13/06/02 Procedure to do quantity * each calculation
     // TGM AB 04/08/17 - rewritten to handle 3 decimal place Each values


     SQuantity := DetailGrid.Cells[QtyCol, DetailGrid.Row];
     SCost := '';
     SCost := DetailGrid.Cells[EachCol, DetailGrid.Row];
     Slimall(SCost);

     try Each := strtofloat(SCost);
     except  Each := 0;
     end;
     try Qty :=  strtofloat(SQuantity);
     except  Each := 0;
     end;

     NewTotal := (Each * Qty) * 100;

     if newtotal > 0 then begin
                          DoubletoStr(NewTotal, TempStr , '%8.2f', True, True, 8, True);
                          SlimAll(Tempstr);
                          STotalCost := TempStr;
                          if DetailGrid.Cells[AmtCol, DetailGrid.row] = '-' then begin
                                                                                 STotalCost := STotalCost + '-';
                                                                                 DetailGrid.Cells[EachCol, DetailGrid.row] := SCost + '-';
                          end;
                          DetailGrid.Cells[AmtCol, DetailGrid.row] := STotalCost;
     end;
     if newtotal < 0 then begin
                          newtotal := newtotal * -1;
                          DoubletoStr(NewTotal, TempStr , '%8.2f', True, True, 8, True);
                          SlimAll(Tempstr);
                          STotalCost := TempStr;
                          if DetailGrid.Cells[AmtCol, DetailGrid.row] = '-' then STotalCost := STotalCost
                             else begin
                                  DetailGrid.Cells[AmtCol, DetailGrid.row] := STotalCost + '-';
                                  if pos ('-', SCost) =0 then DetailGrid.Cells[EachCol, DetailGrid.row] := SCost + '-';
                             end;
     end;

   //  IsVatCalculated[DetailGrid.Row] := FALSE;
    if IsVatCodeInclusive(Detailgrid.row) then IsVatCalculated[DetailGrid.Row] := FALSE;
end;

procedure TCashBookForm.CalculateUnitCost(Rowcount : Integer; UpdateVat : boolean);
var
   SQuantity, STotalcost, TempStr, SVatAmt, SUnitCost : ShortString;
   LQuantity, LTotalCost, LVatAmt, LUnitCost : LongInt;
   UnitCost : Double;
begin
// TGM AB 04/08/17 - rewritten to handle 3 decimal place Each values
// TGM AB 14/06/02 Calculate unit cost using amount & Quantity

           TempStr := '';
           SQuantity := '';
           STotalCost := '';
           SVatAmt := '';
           SUnitCost := '';
           LQuantity := 0;
           LTotalCost := 0;
           LVatAmt := 0;
           LUnitCost := 0;

//           For Rowcount := 1 to 11 do begin
           UnitCost := 0.00;
           SUnitCost := DetailGrid.Cells[EachCol,Rowcount];
           SQuantity := DetailGrid.Cells[QtyCol,Rowcount];
           STotalCost := DetailGrid.Cells[AmtCol,Rowcount];
           SVatAmt := DetailGrid.Cells[VAmtCol,Rowcount];
           Strlong(SQuantity, LQuantity);
           Strlong(STotalCost, LTotalCost);
           Strlong(SVatAmt, LVatAmt);
           Strlong(SUnitCost, LUnitCost);

           if not ((LQuantity = 0) or (LTotalcost = 0)) then UnitCost := (LTotalCost / LQuantity) * 100;
           if LTotalcost = 0 then DetailGrid.Cells[EachCol,Rowcount] := '';

           if isvatcodeinclusive(Rowcount) then begin      // line below uses +1 & -1 to simply eliminate any difference if totals are not whole numbers (ie rounding of vat amunt)
                                      if ((((LUnitCost*LQuantity)/100) < (LTotalCost + LVatAmt -1)) or (((LUnitCost*LQuantity)/100) > (LTotalCost + LVatAmt +1))) then
                                         begin
                                              if lastcol <> AmtCol then LTotalcost := LTotalCost + LVatAmt;
                                              if not ((LQuantity = 0) or (LTotalcost = 0)) then UnitCost := (LTotalCost / LQuantity) * 100;
                                      end
                                         else unitcost := LUnitcost ;
           end;

           if UnitCost > 0.00 then begin
                                       DoubleToStr(UnitCost,TempStr,'%8.3f', True, True, 8, True);              // TGM AB 04/08/17 was %8.2f
                                       Slimall (TempStr);
                                       DetailGrid.Cells[EachCol,Rowcount] := TempStr;
                                       application.processmessages;
                                       if ((updatevat) and (not IsVatCodeInclusive(Rowcount))) then IsVatCalculated[Rowcount] := FALSE;

           end;
           if UnitCost < 0.00 then begin
                                       Unitcost := unitcost * -1;
                                       DoubleToStr(UnitCost,TempStr,'%8.3f', True, True, 8, True);              // TGM AB 04/08/17 was %8.2f
                                       Slimall (TempStr);
                                       if pos('-',TempStr) > 0 then DetailGrid.Cells[EachCol,Rowcount] := TempStr
                                          else DetailGrid.Cells[EachCol,Rowcount] := TempStr + '-';
                                       application.processmessages;
                                       if ((updatevat) and (not IsVatCodeInclusive(Rowcount))) then IsVatCalculated[Rowcount] := FALSE;

           end;

           if ((updatevat) and (not IsVatCodeInclusive(Rowcount))) then IsVatCalculated[Rowcount] := FALSE;

//           end; // For ...




end;

{function TCashbookForm.Invoicer: boolean;
begin
     result := false;
     if (FileExists(Accsdata.AccsDataModule.AccsDataBase.Directory + 'invoice')) then result := true;
     if Cash2.XWININV = True then result := true;
end;}

function TCashbookForm.IsVatCodeInclusive(RowNumber : Integer): Boolean;
var
   vatcode : string[1];
   vat_type : char;
   i: integer;
begin
   result := false;
   vatcode := copy(Detailgrid.cells[VCodeCol,RowNumber],1,1);
   for i:= 0 to 9 do begin
       if Cash1.xtaxids[i] = vatcode then vat_type := Cash2.xtaxTypes[i];
   end;
   if vat_type = 'I' then result := true;
end;


procedure TCashBookForm.LoadJobCardClick(Sender: TObject);
var
   CustomerId : Integer;
begin
   TaskNumber := 3;
   EditingJobCard := True;
   if ( (JobCardOpen) and ( MessageDlg('You have a job card open. Are you sure you wish to load a different job card?',
                            mtConfirmation, [mbYes, mbNo], 0) = mrNo) ) then Exit;

   if ( CustSuppCode.Text = '' ) then
      begin
         {
         NewListBox.ListIt ( Sender, Customers, 'C' );
         if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
            begin
               CustSuppCode.Text := NewListBox.ListInfo.ReturnValue;
               CustSuppCodeExit ( Sender );
            end
         else
            begin
               Showmessage('Please select a customer when creating a new job card');
               Exit;
            end;
         }

         // SP - 14/02/2017  Seamus Donohue
         CustomerId := -1;
         if ( TfmFarmSyncSettings.SyncServiceIsAvailable ) then
            begin
               CustomerId := TfmJobCardCustomerListing.SelectCustomer;
               if ( CustomerId > 0 ) then
                  begin
                     CustSuppCode.Text := IntToStr(CustomerId);
                     CustSuppCodeExit ( Sender );
                  end;
            end;

         if ( CustomerId = -1 ) then
            begin
               NewListBox.ListIt ( Sender, Customers, 'C' );
               if ( Length(NewListBox.ListInfo.ReturnValue) > 0 ) then
                  begin
                     CustSuppCode.Text := NewListBox.ListInfo.ReturnValue;
                     CustSuppCodeExit ( Sender );
                  end
               else
                  begin
                     Showmessage('Please select a customer when creating a new job card');
                     Exit;
                  end;
            end;
         //   18/11/19 [V5.9 R1.2] /MK Bug Fix - Don't exit if CustomerId is not -1 as it can come from the TfmJobCardCustomerListing.
         {
         else
            Exit;// Don't proceed any further, we do not have s selected customer to load a jobcard
         }

      end;  // if already a account no in box use it

   try
      Application.CreateForm(TFLoadJobs, FLoadJobs);
   except
   end;

   FLoadJobs.Accountlabel.caption := Custsuppnamelabel.caption;
   EnableTheScreen(self);
   FLoadJobs.BuildWindow('J',True);
   DeleteJobCard.Enabled := true;
   if FLoadJobs.NoToNewJobCard then
      begin
         ClearTheScreen(self);
         DisableTheScreen(self);
         JobCardOpen := false;
      end
   else
      begin
         JobCardOpen := True;
         EnableTheScreen(self);
         txdate.setfocus;
         totalsofar;
         Reportsbutton.enabled := false;
      end;

   JobCardImportButton.Left := DetailGrid.Left;
   JobCardImportButton.Visible := True;
end;

procedure TCashBookForm.ChangeTaskClick(Sender: TObject);
begin
   JobCardImportButton.Visible := False;
          EditingJobCard := false;
          case TaskNumber of
                          0 : begin
                              // no action required no tasks currently active / setup
                              end;

                          1 : begin // ledger
                              if (((GridFilledIn) or (Custsupptrans.visible = true) or (PayRecPanel.visible = true) or (CustSuppCode.text <> '')) and (MessageDlg('If you have any unsaved details entered on the ledger screen they will be lost, are you sure you wish to exit?',
                                                  mtConfirmation, [mbYes, mbNo], 0) = mrNO)) then exit
                              else begin
                              SalesPurchasegroup.visible := false;
                              EnableTheScreen(self);
                              invoice.checked := true;
                              ClearTheScreen(self);
                              DisableTheScreen(self);
                              end;



                              end;
                          2 : begin
                              if ((GridFilledIn or (CustSuppCode.text <> '')) and (MessageDlg('If you have any unsaved details entered on the invoice screen they will be lost, are you sure you wish to exit?',
                                                  mtConfirmation, [mbYes, mbNo], 0) = mrNO)) then exit
                              else begin
                              SalesPurchasegroup.visible := false;
                              EnableTheScreen(self);
                              invoice.checked := true;
                              ClearTheScreen(self);
                              DisableTheScreen(self);
                              end;


                              end;
                          3 : begin
                               if ((JobCardOpen) and (messageDlg('You have a job card open. Are you sure you wish to exit && lose any changes made?',
                                  mtConfirmation, [mbYes, mbNo], 0) = mrNo)) then Exit
                                  else begin
                                  ClearTheScreen(self);
                                  DisableTheScreen(self);
                                  JobCardPanel.hide;
                                  Reportspanel.enabled := false;
                                  JobCardOpen := false;
                                  JobCardNumber := 0;
                                  ProformaOpen := false;
                                  ProformaNumber := 0;
                                  ChangeTasksPanel.width := 793;
                               end;
                              end;
                          4 : begin
                               if ((ProformaOpen) and (messageDlg('You have a proforma invoice open. Are you sure you wish to exit && lose any changes?',
                                                  mtConfirmation, [mbYes, mbNo], 0) = mrNo)) then Exit
                                   else begin
                                   ClearTheScreen(self);
                                   DisableTheScreen(self);
                                   Reportspanel.enabled := false;
                                   ProformaPanel.hide;
                                   ProformaOpen := false;
                                   ProformaNumber := 0;
                                   ChangeTasksPanel.width := 793;
                               end;
                              end;
                          5 : begin
                               if ((QuoteOpen) and (messageDlg('You have a quotation open. Are you sure you wish to exit && lose any changes?',
                                                  mtConfirmation, [mbYes, mbNo], 0) = mrNo)) then Exit
                                   else begin
                                   ClearTheScreen(self);
                                   DisableTheScreen(self);
                                   Reportspanel.enabled := false;
                                   ProformaPanel.hide;
                                   QuoteOpen := false;
                                   QuoteNumber := 0;
                                   ChangeTasksPanel.width := 793;
                               end;
                              end;


        end; // case ..

        changetaskspanel.width := 793;
        PrintInvoice.enabled := false;
        DisableTheScreen(self);
        changetask.enabled := false;
        Cashbookform.caption := 'Select A Task';
        save.Enabled := false;
        TaskNumber := 0;
        Reportspanel.hide;

        Panel1.Show;
end;

procedure TCashBookForm.LedgerClick(Sender: TObject);
begin
          Reference.enabled := true;
          EnableTheScreen(self);
          ChangeTasksPanel.width := 131;
          Tasknumber := 1;   // ledger task
          cashbookform.caption := 'Sales Invoice';
          Setupcolumns(self);
          Invoice.checked := true;
          Paymentreceipt.enabled := true;
          ToSalesRadio.enabled := true;
          ToPurchaseRadio.enabled := true;
          Cashinvoice.enabled := true;
          SalesPurchaseGroup.visible := true;
          save.enabled := true;
          Reportsbutton.enabled := false;
          changetask.enabled := true;
end;

procedure TCashBookForm.InvoicingClick(Sender: TObject);
var invoicenumber : integer;
    SInvoiceNUmber : string;
begin
          EditingJobCard := false;
          Reference.enabled := false;
          Tasknumber := 2;
          Setupcolumns(self);
          SalesPurchaseGroup.visible := true;
          Paymentreceipt.enabled := false;
          ToSalesRadio.enabled := false;
          ToPurchaseRadio.enabled := false;
 //         Cashinvoice.enabled := false;     TGM AB removed to allow invoice to be printed from cash sale screen
          changetaskspanel.width := 261;
          changetask.enabled := true;
          PrintInvoice.enabled := True;
          save.enabled := True;
          CashBookForm.caption := 'Sales Invoice';
          accsdatamodule.InvoiceNumbers.open;
          accsdatamodule.invoiceNumbers.first;
          if not accsdatamodule.invoicelayout.Active then begin
             accsdatamodule.invoicelayout.databaseName:= accsdatamodule.AccsDataBase.DatabaseName;
             accsdatamodule.invoicelayout.tablename:='InvoiceLayout.db';
          end;
          EnableTheScreen(self);
end;

procedure TCashBookForm.PrintInvoices(Sender: TObject);
var i,j,k,linecount,code: integer;
    qty, TotalExVAT, each, EachIncVAT, VATAmount, TotalIncVAT:real;
    f:textfile;
    tempstring:string[50];
    SQty,STotalExVAT,SVATAmount,STotalIncVAT,SEach, SEachIncVAT :string[15];
    SInvoiceNumber:string[10];
    line1,line2,line3:string[50];
    templong : longint;
    VLineDate, VLineRef, VatRate : string;
    tempstr : shortstring;
    TotalQuantity : real;
begin
   Linecount:=1;

   with AccsDataModule.InvoiceReportTable do
      begin
         Active := False;
         DatabaseName := accsdata.accsdatamodule.accsdatabase.directory + '..';
         TableName:='InvoiceReport.db';
         EmptyTable;
         open;
      end;

   for i:=1 to detailgrid.rowcount-1 do
      begin
         if ( length(detailgrid.cells[NomCol,i]) > 0 ) then
            begin
               AccsDataModule.InvoiceReportTable.append;
               tempstring:='';
               if ( detailgrid.cells[QtyCol,i] = '' ) then
                  detailgrid.cells[QtyCol,i] := '1.00';
               tempstring:= detailgrid.cells[QtyCol,i];
               slimall(TempString);
               Strlong(tempstring, templong);
               qty := templong / 100;

               tempstring:='';
               tempstring:= detailgrid.cells[AmtCol,i]; // totalexcVAT
               if ( TempString = '' ) then
                  TempString:='0.00';
               slimall(TempString);
               templong := 0;
               Strlong(tempstring, templong);
               TotalExVAT := templong /100;
               Str(TotalExVAT:12:2,STotalExVAT);
               slimall (STotalExVAT);
               if ( (TotalExVAT <> 0) and (Qty <> 0) ) then
                  begin
                     Each:=TotalExVAT/Qty;
                     str(each:5:3,SEach);         // TGM AB 15/09/17 was 5:2
                  end
               else
                  begin
                      SEach := ' ';
                      Each:=0;
                  end;

               // vat code lookup
               tempstring := '';
               tempstring := detailgrid.cells[VCodeCol,i];
               slimall(tempstring);
               for j := 0 to 9 do
                  begin
                     if ( Cash1.xtaxids[j] <> ' ' ) then
                        if ( Cash1.xtaxids[j] = tempstring ) then
                           tempstring := vartostr(Cash1.xtaxRates[j]/100) + '%';
                  end;
               if ( length(tempstring) = 1 ) then
                  tempstring := '0%';
               VatRate := Tempstring;

               tempstring:='';
               tempstring:= detailgrid.cells[VAmtCol,i];
               if ( TempString = '' ) then
                  TempString:='0.00';
               slimall(TempString);
               templong := 0;
               Strlong(tempstring, templong);
               VatAmount := templong / 100;
               Str(VATAmount:8:2,SVATAmount);
               TotalIncVAT:=(VatAmount + TotalExVAT);
               Str(TotalIncVAT:12:2,STotalIncVAT);
               if ( (TotalIncVAT <> 0) and (Qty <> 0) ) then
                  begin
                     EachIncVAT:=TotalIncVAT/Qty;
                     str(eachIncVAT:5:3,SEachIncVAT);           // TGM AB 15/09/17 was 5:2
                  end
               else
                  begin
                     SEachIncVAT := ' ';
                     EachIncVAT:=0;
                  end;
               linecount:= linecount + 1;
               TempString:= detailgrid.cells[DesCol,i];
               VLineDate := '';
               VLineRef := '';
               line1:='';
               line2:='';
               line3:='';

               if ( AccsDataModule.ProdsTxTemp.Locate('LineNo',i,[] ) ) then
                  begin
                     VLineDate := AccsDataModule.ProdsTxTemp.FieldByName('LineDate').AsString;
                     If length(VLineDate) = 10 then VLineDate := copy(VLinedate,1,6) + copy(VLineDate,9,2);
                     VLineRef := AccsDataModule.ProdsTxTemp.FieldByName('LineRef').AsString;
                     line1:= AccsDataModule.ProdsTxTemp.FieldByName('Desc1').AsString;
                     line2:= AccsDataModule.ProdsTxTemp.FieldByName('Desc2').AsString;
                     line3:= AccsDataModule.ProdsTxTemp.FieldByName('Desc3').AsString;
                  end;

               with AccsDataModule.InvoiceReportTable do
                  begin
                    fieldvalues['Description']:=detailgrid.cells[DesCol,i];
                    if ( length(VLineDate) > 0 ) then
                       fieldvalues['Linedate']:=VLineDate;
                    if ( length(VLineRef) > 0 ) then
                       fieldvalues['LineRef']:=VLineRef;
                    if ( length(line1) > 0 ) then
                       fieldvalues['Line1']:=Line1;
                    fieldvalues['Quantity']:= detailgrid.cells[QtyCol,i];
                    fieldvalues['Each']:=SEach;
                    fieldvalues['EachIncVAT'] := SEachIncVAT;
                    fieldvalues['TotalExcVAT']:=STotalExVAT;
                    fieldvalues['Vat']:=SVATAmount;
                    fieldvalues['TotalIncVAT']:=STotalIncVAT;
                    fieldvalues['VatRate']:=VatRate;
                    post;
                  end;

               if ( length(line2) > 0 ) then
                  begin
                     AccsDataModule.InvoiceReportTable.append;
                     AccsDataModule.InvoiceReportTable.fieldvalues['Line1']:=Line2;
                     AccsDataModule.InvoiceReportTable.post;
                  end;

               if ( length(line3) > 0 ) then
                  begin
                     AccsDataModule.InvoiceReportTable.append;
                     AccsDataModule.InvoiceReportTable.fieldvalues['Line1']:=Line3;
                     AccsDataModule.InvoiceReportTable.post;
                  end;
            end;
      end;

   AccsDataModule.InvoiceReportTable.refresh;
   with AccsDataModule.InvoiceVatQuery do
      begin
         Active := False;
         sql.clear;
         sql.add('select max(vatrate) as vatrate, sum(cast (totalexcvat as numeric)) as amount, sum(cast (vat as numeric)) as vat , sum(cast (Quantity as numeric)) as Quantity');
         sql.add('from "C:\kingsacc\invoicereport.db"');
         sql.add('group by vatrate');
         open; //execsql;
         active := true;
      end;

   with InvoiceReportForm do
      begin
         InvoiceNumber.Caption:= Reference.text;
         Date.Caption:= TxDate.text;
         ToName.Caption:=CustSuppNameLabel.caption;
         ToAddress1.Caption := CustSuppAdd1Label.caption;
         ToAddress2.caption := CustSuppAdd2Label.caption;
         ToAddress3.Caption := CustSuppAdd3Label.caption;
         ToAddress4.Caption := CustSuppAdd4Label.caption;
         ToAddress5.Caption := CustSuppAdd5Label.caption;
         TempString:=TotalLessVAT.text;
         RAccountNumber.Caption := CustSuppCode.text;
         RName.Caption:=CustSuppNameLabel.caption;
         RAddress1.Caption := CustSuppAdd1Label.caption;
         RAddress2.caption := CustSuppAdd2Label.caption;
         RAddress3.Caption := CustSuppAdd3Label.caption;
         TotExcVAT.caption:=TotalLessVAT.text;
         RTotExcVAT.caption:=TotalLessVAT.text;
         TotVAT.caption:=TotalVAT.text;
         RTotVAT.caption:=TotalVAT.text;
         TotIncVAT.caption:=TotalAmt.text;
         RTotIncVAT.caption:=TotalAmt.text;
         VatCodeRateLabel.caption := 'Rate';                // TGM AB 23/02/18
         AmountTableLabel.caption:= 'Amount';               // TGM AB 23/02/18
         VatTableLabel.caption := 'Vat Amount';             // TGM AB 23/02/18
         EuroAmountTableLabel.caption := 'Amount';          // TGM AB 23/02/18
         EuroVatTableLabel.caption := 'Vat Amount';         // TGM AB 23/02/18
         TotalQuantity := 0;
         AccsDataModule.InvoiceVatQuery.first;
         InvoiceReportForm.VatCodeRateLabel.font.size := 8;       // TGM AB 23/02/18
         InvoiceReportForm.AmountTableLabel.font.size := 8;       // TGM AB 23/02/18
         InvoiceReportForm.VatTableLabel.font.Size := 8;          // TGM AB 23/02/18
         InvoiceReportForm.EuroAmountTableLabel.font.size := 8;   // TGM AB 23/02/18
         InvoiceReportForm.EuroVatTableLabel.font.Size := 8;      // TGM AB 23/02/18

         for k := 1 to AccsDataModule.InvoiceVatQuery.RecordCount do
            begin
              if ( length(vartostr(AccsDataModule.InvoiceVatQuery['vatrate'])) > 0 ) then
                 begin
                    VatCodeRateLabel.Caption := VatCodeRateLabel.Caption + #13#10 + AccsDataModule.InvoiceVatQuery['vatrate'];   // TGM AB 23/02/18
                    DoubletoStr(AccsDataModule.InvoiceVatQuery['amount'], TempStr , '%8.2f', True, False, 10, True);
                    AmountTableLabel.Caption := AmountTableLabel.Caption + #13#10 + TempStr;                                     // TGM AB 23/02/18
                    DoubletoStr(AccsDataModule.InvoiceVatQuery['VAT'], TempStr , '%8.2f', True, False, 10, True);
                    VatTableLabel.Caption := VatTableLabel.Caption + #13#10 + TempStr;                                           // TGM AB 23/02/18
                    TotalQuantity := TotalQuantity + AccsDataModule.InvoiceVatQuery['Quantity'];

                    if ((Cash11.xEuroConverter > 0) or (Cash11.xEuroConverter < 0)) then
                       begin
                          DoubletoStr(AccsDataModule.InvoiceVatQuery['amount']/Cash11.xEuroConverter, TempStr , '%8.2f', True, False, 10, True);
                          EuroAmountTableLabel.Caption := EuroAmountTableLabel.Caption + #13#10 + TempStr;                         // TGM AB 23/02/18
                          DoubletoStr(AccsDataModule.InvoiceVatQuery['VAT']/Cash11.xEuroConverter, TempStr , '%8.2f', True, False, 10, True);
                          EuroVatTableLabel.Caption := EuroVatTableLabel.Caption + #13#10 + TempStr;                               // TGM AB 23/02/18
                       end;
                 end;
              AccsDataModule.InvoiceVatQuery.next;
            end;

         if k > 6 then
            begin
               InvoiceReportForm.VatCodeRateLabel.font.size := 6;       // TGM AB 23/02/18
               InvoiceReportForm.AmountTableLabel.font.size := 6;       // TGM AB 23/02/18
               InvoiceReportForm.VatTableLabel.font.Size := 6;          // TGM AB 23/02/18
               InvoiceReportForm.EuroAmountTableLabel.font.size := 6;   // TGM AB 23/02/18
               InvoiceReportForm.EuroVatTableLabel.font.Size := 6;      // TGM AB 23/02/18
            end;

         if k > 8 then
            begin
               InvoiceReportForm.VatCodeRateLabel.font.size := 5;       // TGM AB 23/02/18
               InvoiceReportForm.AmountTableLabel.font.size := 5;       // TGM AB 23/02/18
               InvoiceReportForm.VatTableLabel.font.Size := 5;          // TGM AB 23/02/18
               InvoiceReportForm.EuroAmountTableLabel.font.size := 5;   // TGM AB 23/02/18
               InvoiceReportForm.EuroVatTableLabel.font.Size := 5;      // TGM AB 23/02/18
            end;

         DoubletoStr(TotalQuantity, TempStr , '%8.2f', True, False, 10, True);
         SumQuantity.Caption := Tempstr;
         AccsDataModule.InvoiceVatQuery.Close;
      end;

   if ( not(AccsDataModule.InvoiceLayout.Active) ) then
      AccsDataModule.InvoiceLayout.Open;

   if ( not(bool(InvoiceprintForm)) ) then
      Application.CreateForm(TInvoicePrintForm, InvoicePrintForm);

   InvoicePrintForm.Clear();

   if ( Trim(CustSuppCode.Text) <> '' ) then
      try
         InvoicePrintForm.InvoiceType := 'Sale';
         InvoicePrintForm.EntityId := StrToInt(CustSuppCode.Text);
         InvoicePrintForm.InvoiceNumber := Trim(Reference.text);
      except
      end;

   InvoicePrintForm.ShowModal;
end;

procedure TCashBookForm.JobcardsClick(Sender: TObject);
begin
     Reference.enabled := false;
     EnableTheScreen(self);
     Setupscreen(PROG,ACT);
     DisableTheScreen(self);
     TaskNumber := 3;
     Setupcolumns(self);
     Changetaskspanel.width := 131;
     JobCardPanel.visible := true;
     changetask.enabled := true;
     CashBookForm.caption := 'Job Cards';
     Reportsbutton.Caption := 'Job Card Report';
     Reportspanel.enabled := true;
     Reportspanel.show;
     Reportsbutton.enabled := true;
     Panel1.Hide;
     //NewJobCardclick(self);

     // SP - 26/03/2015

     if ((TfmFarmSyncSettings.SyncServiceIsAvailable) and
         (TfmFarmSyncSettings.SyncConfigured(AccsDataModule.CurrentDatabase)) and
         (Preferences.ValueAsBoolean[cPref_JobCard_SyncOnOpen])) then
        begin
           if ((Preferences.ValueAsBoolean[cPref_DownloadJobCardOncePerSession]) and (AccsDataModule.JobCardDownloadCount<=0)) OR
              not (Preferences.ValueAsBoolean[cPref_DownloadJobCardOncePerSession]) then
             begin
               AccsDataModule.JobCardXmlDocument := nil;
               uAccsSync.InvokeFarmSyncProgram(Handle,'-s -a "'+ AccsDataModule.CurrentDatabase +'"');
               AccsDataModule.JobCardDownloadCount := AccsDataModule.JobCardDownloadCount+1;
             end;
        end;
end;

procedure TCashBookForm.CreateNewJobCard(CustomerNo : String);
var
   r,c: integer;
begin
// TGM AB - 1/7/02 Creates a new job card for specified customer
   EnableTheScreen(self);
   Custsuppcode.text := CustomerNo;
   CustSuppCodeexit(self);
   For r := 1 to MaxGridLines + 1 do begin  // TENFOUND WAS 11
         for c:= 0 to 25 do begin // Detailgrid.ColCount-1 do begin
             detailgrid.Cells[c,r] := '' ;
         end; // for c
   end; // for r
   if Custsuppcode.text <> '' then txdate.SetFocus;
end;

procedure TCashBookForm.NewJobCardClick(Sender: TObject);
var
   CustomerId : Integer;
begin
     EditingJobCard := False;
     if JobCardOpen then if MessageDlg('You already have a job card open. Are you sure you wish to start a new job card?',
                                               mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

     ClearTheScreen(self);

     AccsDataModule.ProdsTxTemp.active:=false;
     AccsDataModule.ProdsTxTemp.EmptyTable;
     AccsDataModule.ProdsTxTemp.open;
     _BatchID := FindHighestJobCardNumber +1;

     // SP - 26/03/2015
     CustomerId := -1;
     if (TfmFarmSyncSettings.SyncServiceIsAvailable) then
        begin
           CustomerId := TfmJobCardCustomerListing.SelectCustomer;
           if (CustomerId>0) then
              begin
                 CustSuppCode.Text := IntToStr(CustomerId);
                 CustSuppCodeExit ( Sender );
              end;
        end;

     if (CustomerId = -1) then
        begin
           NewListBox.ListIt ( Sender, Customers, 'C' );
           if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then begin
              CustSuppCode.Text := NewListBox.ListInfo.ReturnValue;
              CustSuppCodeExit ( Sender );
           end
            else begin
                      Showmessage('Please select a customer when creating a new job card');
                      exit;
            end;
        end;


     CreateNewJobCard(CustSuppCode.Text);

     JobCardOpen := true;
     //JobCardNumber := 0;
     EnableTheScreen(self);
     Reportsbutton.enabled := false;

     JobCardImportButton.Left := DetailGrid.Left;
     JobCardImportButton.Visible := True;

     if (CustomerId>0) then
        JobCardImportButtonClick(nil);
end;

procedure TCashBookForm.SaveAsJobCardClick(Sender: TObject);
begin
      DeleteJobCard.Enabled := false;
      if GridFilledIn then begin
          if JobCardOpen then begin
             SaveJobCards(_BatchID,'J'); //(JobCardNumber,'J');
                EditingJobCard := False;
                ClearTheScreen(self);
                DisableTheScreen(self);
                JobCardOpen := false;
                JobCardNumber := 0;
                showmessage('Job Card Saved');
                Reportsbutton.enabled := true;

          end
              else showmessage('No open job cards to save');
      end
         else if jobcardopen then showmessage('No valid items entered in the grid')
              else showmessage('No job cards loaded');

end;

Function TCashBookForm.FindHighestJobCardNumber: Integer;
begin

       result := 0;
       query1.DatabaseName := accsdatamodule.AccsDataBase.databasename;
       Query1.close;
       Query1.sql.text := 'Select max(BatchID) as BatchID from proforma.db';
    //   Query1.execsql;
       Query1.open;
       If Query1['BatchID'] > 0 then result:= Query1['BatchID']
       else result := 1;

end;

function TCashBookForm.GridFilledIn : Boolean;
var
   r,c : integer;
begin
     // checks the important fields in the grid - makes decision if valid details entered
     result := false;
     For r := 1 to MaxGridLines + 1 do begin  // TENFOUND WAS 11
           if Detailgrid.cells[NomCol,r] <> '' then begin
               if ((Detailgrid.cells[AmtCol,r] <> '') and (Detailgrid.cells[VCodeCol,r] <> '') and
                  (Detailgrid.cells[VAmtCol,r] <> '')) then result := true;

           end;
           if Detailgrid.cells[NomCol,r] = '' then begin
               if ((Detailgrid.cells[AmtCol,r] <> '') and (Detailgrid.cells[VCodeCol,r] <> '') and
                  (Detailgrid.cells[VAmtCol,r] <> '')) then begin
                                                            result := false;
                                                            Showmessage('Nominal Code Missing on Line ' + inttostr(r));
                                                            end;
           end;
     end; // for r

end;

procedure TCashBookForm.PrintasProformaClick(Sender: TObject);

begin
   AccsDataModule.AgeOfDebtSyncRequired := True;

     Oldreference := reference.text;
     if (JobCardOpen and GridFilledIn) then begin
        Cashbookform.caption := 'Proforma Invoicing';
        TaskNumber := 4;
        Reference.text := IntToStr(GetRefNumber);
        PrintInvoices(self);
        if MessageDlg('Do you want to save this job card as a proforma invoice now?',
              mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                     EditingJobCard := False;
                     ProformaNumber := StrToInt(Reference.text);
                     SaveJobCards (_BatchID,'P');
                     SaveJobCards (_BatchID,'JC');
                     {if JobCardNumber >0 then SaveJobCards(JobCardNumber,'P')
                        else SaveJobCards(FindHighestJobCardNumber+1,'P');}
                     accsdatamodule.InvoiceNumbers.edit;
                     accsdatamodule.InvoiceNumbers['LastProforma']:= ProformaNumber;
                     accsdatamodule.InvoiceNumbers.post;
                     JobCardNumber := 0;
                     JobCardOpen := False;
                     ProformaNumber := 0;
                     ProformaOpen := False;
                     ClearTheScreen(self);
                     DisableTheScreen(self);
                     Cashbookform.caption := 'Job Cards';
                     Reportsbutton.enabled := true;
        end else begin reference.text := Oldreference;
                       TaskNumber := 3;
                 end;
     end
        else if not JobcardOpen then showmessage('No job cards loaded')
                    else showmessage('Incomplete lines or no listings on job card');
     Cashbookform.caption := 'Job Cards';
end;

procedure TCashBookForm.PrintAsInvoiceClick(Sender: TObject);
var
   BadCol,
   BadRow : LongInt;
   ErrText : String;
   
begin
   AccsDataModule.AgeOfDebtSyncRequired := True;

     Oldreference := reference.text;

     if MoveTxInfo ( BadCol, BadRow  ) Then begin

        if (JobCardOpen and GridFilledIn) then begin
           CashbookForm.caption := 'Job Card to Sales Invoice';
           TaskNumber := 2;
           Reference.text := IntToStr(GetRefNumber);
           //PrintInvoices(self);
           if MessageDlg('Do you want to save this job card as an invoice now?',
                   mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                                                             PrintInvoices(self);
                                                             EditingJobCard := false;
                                                             SaveJobCards(_BatchID,'JC'); //(JobCardNumber,'JC');
                                                             InvoiceNumber := StrToInt(Reference.text);
                                                             Saveclick(self);
                                                             accsdatamodule.InvoiceNumbers.edit;
                                                             accsdatamodule.InvoiceNumbers['lastSaleInv']:=invoiceNumber;
                                                             accsdatamodule.InvoiceNumbers.post;
                                                             InvoiceNumber := 0;
                                                             JobCardOpen := false;
                                                             JobCardNumber := 0;
                                                             ProformaOpen := false;
                                                             ProformaNumber := 0;
                                                             //CurrentProformaInvoiceNumber := 0;
                                                             ClearTheScreen(self);
                                                             DisableTheScreen(self);
                                                             Reportsbutton.enabled := true;

                end else begin reference.text := oldreference;
                       TaskNumber := 3; // back to jobcard again;
                         end;
        end
           else if not JobcardOpen then showmessage('No job cards loaded')
                    else showmessage('Incomplete lines or no listings On job card');
           CashbookForm.caption := 'Job Cards';
     end                // MoveTxInfo
         Else begin
              if BadCol = NomCol then ErrText          := 'Nominal Code'
              else if BadCol = AmtCol then ErrText          := 'Amount'
                   else if BadCol = VCodeCol then  ErrText       := 'VAT Code'
                        else if BadCol = VAmtCol then ErrText := 'VAT Amount'
                           else if BadCol = BankCode then ErrText := 'Bank Account'
                             else if BadCol = SalesPurchaseCode then ErrText := 'Customer/Supplier'
                                  else ErrText := 'UnKnown Field';

              MessageDlg('Missing ' + ErrText, mtInformation,[mbOK], 0);

              if ((BadCol = NomCol) {or (BadCol = AmtCol)} or (BadCol = VCodeCol) or (BadCol = VAmtCol)) then Begin
                                            DetailGrid.Col := BadCol;
                                            DetailGrid.Row := BadRow;
                                            DetailGrid.SetFocus;
              end;
        End;
        
end;

procedure TCashBookForm.ProformaClick(Sender: TObject);
begin
     Reference.enabled := false;
     EnableTheScreen(self);
     Setupscreen(PROG,ACT);
     DisableTheScreen(self);
     TaskNumber := 4;
     Setupcolumns(self);
     Changetaskspanel.width := 131;
     changetask.enabled := true;
     CashBookForm.caption := 'Proforma Invoicing';
     NewProforma.Caption := 'New Proforma';
     LoadProforma.Caption := 'Load Proforma';
     SaveAsProforma.Caption := 'Save Proforma';
     PrintProforma.Caption := 'Print Proforma';
     ProformaPanel.visible := true;
     Reportsbutton.Caption := 'Proforma Report';
     Reportspanel.enabled := true;
     Reportspanel.show;
     Reportsbutton.enabled := true;
     Panel1.Hide;
     //NewProformaclick(self);

end;

procedure TCashBookForm.ClearTheScreen(Sender: TObject);
var
   r,c : integer;
begin
     // test procedure for clearing the screen TGM AB 3/07/02 only used if invoicer enabled
      For r := 1 to MaxGridLines + 1 do begin // TENFOUND WAS 11
         for c:= 0 to 25 do begin // Detailgrid.ColCount-1 do begin
             detailgrid.Cells[c,r] := '' ;
         end; // for c
     end; // for r
     Detailgrid.cells[0,1] := '';
     custsuppcode.Text := '';
     Totalsofar;
     Reference.text :='';
     comment.text := '';
     custsuppnamelabel.caption := '';
     custsuppadd1label.caption := '';
     custsuppadd2label.caption := '';
     custsuppadd3label.caption := '';
     custsuppadd4label.caption := '';
     custsuppadd5label.caption := '';
     custsuppareacodelabel.caption := '';
     custsuppcommentlabel.caption := '';
     Detailgrid.enabled := false;
     vatpanel.enabled := false;
     PayRecPanel.visible := false;
     CustSuppTrans.visible := false;
     AccsDataModule.ProdsTxTemp.active:=false;
     AccsDataModule.ProdsTxTemp.EmptyTable;
     AccsDataModule.ProdsTxTemp.open;


end;

procedure TCashBookForm.DisableTheScreen(Sender: TObject);

begin
     // test procedure for disabling the screen TGM AB 5/07/02 only used if invoicer enabled
     txdate.enabled := false;
     DateSearch.enabled := false;
     Listaccounts.enabled := false;
     custsuppcode.enabled := false;
     Totalsofar;
     Reference.enabled := false;
     comment.enabled := false;
     custsuppnamelabel.enabled := false;
     custsuppadd1label.enabled := false;
     custsuppadd2label.enabled := false;
     custsuppadd3label.enabled := false;
     custsuppadd4label.enabled := false;
     custsuppadd5label.enabled := false;
     custsuppareacodelabel.enabled := false;
     custsuppcommentlabel.enabled := false;

     Detailgrid.enabled := false;
     vatpanel.enabled := false;
     Totalspanel.enabled := false;
end;

procedure TCashBookForm.EnableTheScreen(Sender: TObject);

begin
     // test procedure for enabling the screen TGM AB 5/07/02 only used if invoicer enabled
     txdate.enabled := true;
     DateSearch.enabled := true;
     Listaccounts.enabled := true;
     custsuppcode.enabled := true;
     Totalsofar;
     //Reference.enabled := true;
     comment.enabled := true;
     custsuppnamelabel.enabled := true;
     custsuppadd1label.enabled := true;
     custsuppadd2label.enabled := true;
     custsuppadd3label.enabled := true;
     custsuppadd4label.enabled := true;
     custsuppadd5label.enabled := true;
     custsuppareacodelabel.enabled := true;
     custsuppcommentlabel.enabled := true;

     Detailgrid.enabled := true;
     vatpanel.enabled := true;
     Totalspanel.enabled := true;
end;

procedure TCashBookForm.JobCardExitClick(Sender: TObject);
begin
          if ((JobCardOpen) and (messageDlg('You have a job card open. Are you sure you wish to exit && lose any changes made?',
                    mtConfirmation, [mbYes, mbNo], 0) = mrNo)) then Exit
          else begin
                    ClearTheScreen(self);
                    DisableTheScreen(self);
                    JobCardPanel.hide;
                    Reportspanel.enabled := false;
                    JobCardOpen := false;
                    JobCardNumber := 0;
                    ProformaOpen := false;
                    ProformaNumber := 0;
                    ChangeTasksPanel.width := 793;
          end;
end;

procedure TCashBookForm.ProformaExitClick(Sender: TObject);
begin
       if ((ProformaOpen) and (messageDlg('You have a proforma invoice open. Are you sure you wish to exit && lose any changes?',
                    mtConfirmation, [mbYes, mbNo], 0) = mrNo)) then Exit
          else begin
                    ClearTheScreen(self);
                    DisableTheScreen(self);
                    Reportspanel.enabled := false;
                    ProformaPanel.hide;
                    ProformaOpen := false;
                    ProformaNumber := 0;
                    ChangeTasksPanel.width := 793;
          end;
end;

procedure TCashBookForm.NewProformaClick(Sender: TObject);
var SProformaNumber : string;
begin
     EditingJobCard := False;
     case TaskNumber of
          4:
            begin

            if ProformaOpen then if MessageDlg('You already have a Proforma Invoice open. Are you sure you wish to start a new proforma invoice?',
                                               mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

            ClearTheScreen(self);

            AccsDataModule.ProdsTxTemp.active:=false;
            AccsDataModule.ProdsTxTemp.EmptyTable;
            AccsDataModule.ProdsTxTemp.open;
            _BatchID := FindHighestJobCardNumber +1;
            NewListBox.ListIt ( Sender, Customers, 'C' );
            if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then begin
             CustSuppCode.Text := NewListBox.ListInfo.ReturnValue;
             CustSuppCodeExit ( Sender );
             CreateNewJobCard(CustSuppCode.Text);
             end
                else begin
                      Showmessage('Please select a customer when creating a new proforma invoice');
                      exit;
             end;
             ProformaOpen := true;
             //ProformaNumber := 0;
            end;
          5:
            begin

                 if QuoteOpen then if MessageDlg('You already have a Quotation open. Are you sure you wish to start a new quotation?',
                                               mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

                 ClearTheScreen(self);

                 AccsDataModule.ProdsTxTemp.active:=false;
                 AccsDataModule.ProdsTxTemp.EmptyTable;
                 AccsDataModule.ProdsTxTemp.open;
                 _BatchID := FindHighestJobCardNumber +1;

                 NewListBox.ListIt ( Sender, Customers, 'C' );
                 if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then begin
                    CustSuppCode.Text := NewListBox.ListInfo.ReturnValue;
                    CustSuppCodeExit ( Sender );
                    CreateNewJobCard(CustSuppCode.Text);
                 end
                 else begin
                      Showmessage('Please select a customer when creating a new quotation');
                      exit;
                 end;
                 QuoteOpen := true;
                 //QuoteNumber := 0;
            end;



     end;
     EnableTheScreen(self);
     Reportsbutton.enabled := false;
end;

procedure TCashBookForm.PrintProformaClick(Sender: TObject);
begin
     Case TaskNumber of
     4:
       begin
            if (ProformaOpen and GridFilledIn) then begin
               PrintInvoices(self);
               if MessageDlg('Do you want to save this proforma invoice now?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                     EditingJobCard := false;
                     SaveJobCards(_BatchID,'P');
                     accsdatamodule.InvoiceNumbers.edit;
                     accsdatamodule.InvoiceNumbers['LastProforma']:=StrToInt(Reference.text);
                     accsdatamodule.InvoiceNumbers.post;
                     ProformaNumber := 0;
                     ProformaOpen := False;
                     ClearTheScreen(self);
                     DisableTheScreen(self);
                     Reportsbutton.enabled := true;

                  end;
               end
               else if not ProformaOpen then showmessage('No proforma invoices loaded')
                    else showmessage('Incomplete lines or no listings on proforma invoice');
       end;

       5:
       begin
            if (QuoteOpen and GridFilledIn) then begin
               PrintInvoices(self);
               if MessageDlg('Do you want to save this quotation now?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                     SaveJobCards(_BatchID,'Q');
                     accsdatamodule.InvoiceNumbers.edit;
                     accsdatamodule.InvoiceNumbers['LastQuote']:=StrToInt(Reference.text);
                     accsdatamodule.InvoiceNumbers.post;
                     QuoteNumber := 0;
                     QuoteOpen := False;
                     ClearTheScreen(self);
                     DisableTheScreen(self);
                     Reportsbutton.enabled := true;
                  end;
               end
               else if not QuoteOpen then showmessage('No quotation loaded')
                    else showmessage('Incomplete lines or no listings on quotation');
       end;

     end;
end;

procedure TCashBookForm.PrintProformaAsInvoiceClick(Sender: TObject);
var
   BadCol,
   BadRow : LongInt;
   ErrText : String;
begin
   AccsDataModule.AgeOfDebtSyncRequired := True;

     Oldreference := reference.text;
     case TaskNumber of
     4:
       begin

       if MoveTxInfo ( BadCol, BadRow  ) Then begin

          if (ProformaOpen and GridFilledIn) then begin
           CashbookForm.caption := 'Proforma Invoice to Sales Invoice';
           TaskNumber := 2;
           Reference.text := IntToStr(GetRefNumber);
           //PrintInvoices(self);
           if MessageDlg('Do you want to save this proforma invoice as an invoice now?',
                   mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                                                             PrintInvoices(self);
                                                             EditingJobCard := false;
                                                             InvoiceNumber := StrToInt(Reference.text);
                                                             Saveclick(self);
                                                             If not _SaveCancelled then begin
                                                                SaveJobCards(_BatchID,'PC');
                                                                accsdatamodule.InvoiceNumbers.edit;
                                                                accsdatamodule.InvoiceNumbers['lastSaleInv']:=invoiceNumber;
                                                                accsdatamodule.InvoiceNumbers.post;
                                                                InvoiceNumber := 0;
                                                                ProformaOpen := false;
                                                                ProformaNumber := 0;
                                                                ClearTheScreen(self);
                                                                DisableTheScreen(self);
                                                                Reportsbutton.enabled := true;

                                                             end;

           end else begin reference.text := oldreference;
                          TaskNumber := 4; // back to proforma again
                    end
        end
           else if not ProformaOpen then showmessage('No proforma invoices loaded')
                       else showmessage('Incomplete lines or no listings on proforma invoice');
        CashbookForm.caption := 'Proforma Invoicing';
        TaskNumber := 4;
      end
       Else begin
              if BadCol = NomCol then ErrText          := 'Nominal Code'
              else if BadCol = AmtCol then ErrText          := 'Amount'
                   else if BadCol = VCodeCol then  ErrText       := 'VAT Code'
                        else if BadCol = VAmtCol then ErrText := 'VAT Amount'
                           else if BadCol = BankCode then ErrText := 'Bank Account'
                             else if BadCol = SalesPurchaseCode then ErrText := 'Customer/Supplier'
                                  else ErrText := 'UnKnown Field';

              MessageDlg('Missing ' + ErrText, mtInformation,[mbOK], 0);

              if ((BadCol = NomCol) {or (BadCol = AmtCol)} or (BadCol = VCodeCol) or (BadCol = VAmtCol)) then Begin
                                            DetailGrid.Col := BadCol;
                                            DetailGrid.Row := BadRow;
                                            DetailGrid.SetFocus;
              end;
        End;

     end;
     5:
       begin

       if MoveTxInfo ( BadCol, BadRow  ) Then begin

          if (QuoteOpen and GridFilledIn) then begin
           CashbookForm.caption := 'Quotation to Sales Invoice';
           TaskNumber := 2;
           Reference.text := IntToStr(GetRefNumber);
           //PrintInvoices(self);
           if MessageDlg('Do you want to save this quotation as an invoice now?',
                   mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                                                             PrintInvoices(self);
                                                             InvoiceNumber := StrToInt(Reference.text);
                                                             Saveclick(self);
                                                             If not _SaveCancelled then begin
                                                                SaveJobCards(_BatchID,'QC');
                                                                accsdatamodule.InvoiceNumbers.edit;
                                                                accsdatamodule.InvoiceNumbers['lastSaleInv']:=invoiceNumber;
                                                                accsdatamodule.InvoiceNumbers.post;
                                                                InvoiceNumber := 0;
                                                                QuoteOpen := false;
                                                                QuoteNumber := 0;
                                                                ClearTheScreen(self);
                                                                DisableTheScreen(self);
                                                                Reportsbutton.enabled := true;
                                                             end;
           end else begin
                      Reference.text := oldreference;
                      TaskNumber := 5; // back to quote again
                    end;
        end
           else if not QuoteOpen then showmessage('No quotations loaded')
                    else showmessage('Incomplete lines or no listings on quotation');
        CashbookForm.caption := 'Quotation';
        TaskNumber := 5;
     end
     Else begin
              if BadCol = NomCol then ErrText          := 'Nominal Code'
              else if BadCol = AmtCol then ErrText          := 'Amount'
                   else if BadCol = VCodeCol then  ErrText       := 'VAT Code'
                        else if BadCol = VAmtCol then ErrText := 'VAT Amount'
                           else if BadCol = BankCode then ErrText := 'Bank Account'
                             else if BadCol = SalesPurchaseCode then ErrText := 'Customer/Supplier'
                                  else ErrText := 'UnKnown Field';

              MessageDlg('Missing ' + ErrText, mtInformation,[mbOK], 0);

              if ((BadCol = NomCol) {or (BadCol = AmtCol)} or (BadCol = VCodeCol) or (BadCol = VAmtCol)) then Begin
                                            DetailGrid.Col := BadCol;
                                            DetailGrid.Row := BadRow;
                                            DetailGrid.SetFocus;
              end;
        End;

     end;


     end;
end;

procedure TCashBookForm.LoadProformaClick(Sender: TObject);
begin

           if (custsuppcode.text = '') then begin
                                           NewListBox.ListIt ( Sender, Customers, 'C' );
                                           if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then begin
                                           CustSuppCode.Text := NewListBox.ListInfo.ReturnValue;
                                           CustSuppCodeExit ( Sender );
                                           end
                                              else begin
                                              Showmessage('Please select a customer when creating a new proforma invoice');
                                              exit;
                                              end;
       end;

       try  Application.CreateForm(TFLoadJobs, FLoadJobs);
       except
       end;

       FLoadJobs.Accountlabel.caption := Custsuppnamelabel.caption;
       EnableTheScreen(self);
       Case Tasknumber of
       4:

         begin
         if ProformaOpen then if MessageDlg('You already have a Proforma Invoice open. Are you sure you wish to load a different proforma invoice?',
                                               mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

         FLoadJobs.BuildWindow('P',True);
                if FLoadJobs.NoToNewProforma then begin
                                        ClearTheScreen(self);
                                        DisableTheScreen(self);
                                        end
                else begin
                    ProformaOpen := True;
                    EditingJobCard := True;
                    EnableTheScreen(self);
                    Reportsbutton.enabled := false;
                    txdate.setfocus;
                    totalsofar;
               end;
         end;
       5:

         begin
            if QuoteOpen then if MessageDlg('You already have a Quotation open. Are you sure you wish to load a different quotation?',
                                               mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

              FLoadJobs.BuildWindow('Q',True);
               if FLoadJobs.NoToNewQuote then begin
                                        ClearTheScreen(self);
                                        DisableTheScreen(self);
                                        end
               else begin
                    QuoteOpen := True;
                    EditingJobCard := True;
                    EnableTheScreen(self);
                    Reportsbutton.enabled := false;
                    txdate.setfocus;
                    totalsofar;
               end;
          end;
       end;
       DeleteProforma.Enabled := true;
end;

procedure TCashBookForm.SaveasProformaClick(Sender: TObject);

begin
     DeleteProforma.Enabled := false;
     case tasknumber of
     4: begin
      if GridFilledIn then begin
          if ProformaOpen then begin
             EditingJobCard := false;
             SaveJobCards(_BatchID,'P'); //(ProformaNumber,'P');
                ClearTheScreen(self);
                DisableTheScreen(self);
                ProformaOpen := false;
                ProformaNumber := 0;
                showmessage('Proforma Invoice Saved');
                Reportsbutton.enabled := true;


          end
              else showmessage('No open proforma invoices to save');
      end
         else if ProformaOpen then showmessage('No valid items entered in the grid')
              else showmessage('No proforma invoices loaded');
      end;
     5: begin
      if GridFilledIn then begin
          if QuoteOpen then begin
             SaveJobCards(_BatchID,'Q'); //(QuoteNumber,'Q');
                ClearTheScreen(self);
                DisableTheScreen(self);
                QuoteOpen := false;
                QuoteNumber := 0;
                showmessage('Quotation Saved');
                Reportsbutton.enabled := true;

          end
              else showmessage('No open quotations to save');
      end
         else if QuoteOpen then showmessage('No valid items entered in the grid')
              else showmessage('No quotations loaded');
      end;


      end;
end;

procedure TCashBookForm.PrintInvoiceClick(Sender: TObject);
begin
     
     if CustSuppCode.text <> '' then begin
                                           // 2 lines below forces onselect cell code to check that the grid is OK
                                           Detailgrid.Col := 1;
                                           Detailgrid.Col := 0;
                                           //if not GEditing then Detailgrid.Row := 2;
                                           //Detailgrid.Row := 1;
                                           if CheckEditedGridLinesOK = false then exit;                  // Ch027
                                           if GridOK <> False then PrintInvoices(self)
                                           else exit;
                                           if save.enabled then begin
                                                if MessageDlg('Save This Invoice Now?',
                                                        mtConfirmation, [mbYes, mbNo], 0) = mrYes then CashBookform.SaveClick(self);
                                           end;

     end
        else begin
             showmessage('No Customer Selected For This Invoice');
             exit;
        end;
end;

procedure TCashBookForm.SelectCustomerClick(Sender: TObject);
begin
     If expenditure.checked then  NewListBox.ListIt ( Sender, Suppliers, 'S' )
             else NewListBox.ListIt ( Sender, Customers, 'C' );
          If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then begin
                  comment.Text := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ),1);
                  cust_suppcode := StrToInt(NewListBox.ListInfo.ReturnValue);
          end;
end;

procedure TCashBookForm.DeleteProformaClick(Sender: TObject);

begin
     case tasknumber of
     4:
     begin
     if ((not proformaopen)) then showmessage('No Saved Proforma Invoice To Delete')
     else begin
          if MessageDlg('Are you sure you wish to delete this Proforma Invoice?',mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
          query1.DatabaseName := accsdatamodule.AccsDataBase.databasename;
          Query1.close;
          Query1.sql.text := 'Update proforma.db set BatchID = -1 where BatchId = ' + '''' + VartoStr(_BatchID) + ''' and Proforma = True;';
          Query1.execsql;
          ClearTheScreen(self);
          DisableTheScreen(self);
          showmessage('Proforma Invoice Successfully Deleted');
          ProformaOpen := False;
          ProformaNumber := 0;
     end;
     end;
     5:
     begin
     if ((not Quoteopen)) then showmessage('No Saved Quotation To Delete')
     else begin
          if MessageDlg('Are you sure you wish to delete this Quotation?',mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
          query1.DatabaseName := accsdatamodule.AccsDataBase.databasename;
          Query1.close;
          Query1.sql.text := 'Update proforma.db set BatchID = -1 where BatchId = ' + '''' + VartoStr(_BatchID) + ''' and Quote = True;';
          Query1.execsql;
          ClearTheScreen(self);
          DisableTheScreen(self);
          showmessage('Quotation Successfully Deleted');
          QuoteOpen := False;
          QuoteNumber := 0;
     end;
     end;


     end;
end;

procedure TCashBookForm.DeleteJobCardClick(Sender: TObject);
begin
      if ((not Jobcardopen)) then showmessage('No Saved JobCard To Delete')
      else begin
          if MessageDlg('Are you sure you wish to delete this Job Card?',mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
          query1.DatabaseName := accsdatamodule.AccsDataBase.databasename;
          Query1.close;
          Query1.sql.text := 'Update proforma.db set BatchID = -1 where BatchId = ' + '''' + VartoStr(_BatchID) + ''' and Proforma = False and Quote = false;';
          Query1.execsql;
          ClearTheScreen(self);
          DisableTheScreen(self);
          showmessage('Jobcard Successfully Deleted');
          JobCardOpen := False;
          JobCardNumber := 0;
      end;
end;

procedure TCashBookForm.cbProductsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if cbProducts.Value = '0'
     then  begin
           AccsDataModule.ProdsTxTemp.edit;
           AccsDataModule.ProdsTxTemp.FieldByName('ProductID').AsInteger := 0;
           AccsDataModule.ProdsTxTemp['Desc1'] := '';
           AccsDataModule.ProdsTxTemp['Desc2'] := '';
           AccsDataModule.ProdsTxTemp['Desc3'] := '';
           AccsDataModule.ProdsTxTemp.post;
           DetailGrid.Cells[EachCol,DetailGrid.Row] := '0.00';
     end;

end;

procedure TCashBookForm.QuoteClick(Sender: TObject);
begin
     Reference.enabled := false;
     EnableTheScreen(self);
     Setupscreen(PROG,ACT);
     DisableTheScreen(self);
     TaskNumber := 5;
     Setupcolumns(self);
     Changetaskspanel.width := 131;
     changetask.enabled := true;
     CashBookForm.caption := 'Quotation';
     NewProforma.Caption := 'New Quote';
     LoadProforma.Caption := 'Load Quote';
     SaveAsProforma.Caption := 'Save Quote';
     PrintProforma.Caption := 'Print Quote';
     ProformaPanel.visible := true;
     Reportsbutton.Caption := 'Quotation Report';
     Reportspanel.enabled := true;
     Reportspanel.show;
     Reportsbutton.enabled := true;
     Panel1.Hide;
     //NewProformaclick(self);

end;

procedure TCashBookForm.ReferenceDblClick(Sender: TObject);
begin
          Reference.enabled := true;
end;

procedure TCashBookForm.cbProductsCloseUp(Sender: TObject);
var
   TempLong : Real;
   TempStr : ShortString;
begin
  if cbProducts.keyvalue > 0 then begin
     // try and find a record for this line
    if not AccsDataModule.ProdsTxTemp.Locate('LineNo',DetailGrid.Row,[] ) then
       begin
          AccsDataModule.ProdsTxTemp.Append;
          AccsDataModule.ProdsTxTemp.FieldByName('LineNo').AsInteger := DetailGrid.Row;
          // check Nomlisting for associated Product Record
          if (AccsDataModule.Products.Locate('ID',AccsDataModule.NominalList.FieldByName('Product').AsVariant,[] ) or (cbproducts.value <> '0')) then begin

          TempStr := '';
          try TempLong := AccsDataModule.Products['Defaultprice']
          except
                TempLong := 0.00;
          end;
          Str(TempLong:8:3,TempStr);               // TGM AB 04/08/17 was 8:2
          Slimall(TempStr);                      
          DetailGrid.Cells[EachCol,DetailGrid.Row] := TempStr;
          AccsDataModule.ProdsTxTemp.FieldByName('Desc1').AsString := AccsDataModule.Products.FieldByName('Desc1').AsString;
          AccsDataModule.ProdsTxTemp.FieldByName('Desc2').AsString := AccsDataModule.Products.FieldByName('Desc2').AsString;
          AccsDataModule.ProdsTxTemp.FieldByName('Desc3').AsString := AccsDataModule.Products.FieldByName('Desc3').AsString;
          AccsDataModule.ProdsTxTemp.FieldByName('ProductID').AsInteger := AccsDataModule.Products.FieldByName('ID').AsInteger;
       //   DefaultProduct := AccsDataModule.ProductsID.AsInteger;;
          DefaultProduct := AccsDataModule.Products['ID'];
          end;
          AccsDataModule.ProdsTxTemp.Post;
       end
    else   // Edit the Record Number
       begin

                    AccsDataModule.ProdsTxTemp.Edit;
                    AccsDataModule.ProdsTxTemp.FieldByName('LineNo').AsInteger := DetailGrid.Row;
                    TempStr := '';
                    try TempLong := AccsDataModule.Products['Defaultprice']
                    except
                          TempLong := 0.00;
                    end;
                    Str(TempLong:8:3,TempStr);         // TGM AB 04/08/17 was 8:2
                    Slimall (TempStr);                 
                    DetailGrid.Cells[EachCol,DetailGrid.Row] := TempStr;
                    AccsDataModule.ProdsTxTemp.FieldByName('Desc1').AsString := AccsDataModule.Products.FieldByName('Desc1').AsString;
                    AccsDataModule.ProdsTxTemp.FieldByName('Desc2').AsString := AccsDataModule.Products.FieldByName('Desc2').AsString;
                    AccsDataModule.ProdsTxTemp.FieldByName('Desc3').AsString := AccsDataModule.Products.FieldByName('Desc3').AsString;
                    AccsDataModule.ProdsTxTemp.FieldByName('ProductID').AsInteger := AccsDataModule.Products.FieldByName('ID').AsInteger;
                    //DefaultProduct := AccsDataModule.ProductsID.AsInteger;
                    DefaultProduct := AccsDataModule.Products['ID'];
                    AccsDataModule.ProdsTxTemp.Post;


       end;
       CalculateAmount(self);
       if DetailGrid.Cells[QTYCol,DetailGrid.Row] <> '' then begin
          IsVATCalculated[Detailgrid.row] := false;
       //   Detailgrid.col := EachCol;
       end;
  end;

  // SP 29/05/2015
  productsEdit.Text := cbProducts.Text;
end;

procedure TCashBookForm.LineDatePickerCloseUp(Sender: TObject);
var tempDate : string;
begin
     //Linedate.field.Value := DateToStr(LineDatePicker.Date);
     meLineDate.text := DateToStr(LineDatePicker.Date);
end;

procedure TCashBookForm.meLineDateExit(Sender: TObject);
begin
   //     if ((meLineDate.text <> '  /  /  ') and (meLineDate.text <> '  /  /    ')) then LineDatePicker.Date := StrToDate(meLineDate.text);     // TGM AB 19/05/17

        // TGM AB 19/05/17 - valid date check
        if ((meLineDate.text <> '  /  /  ') and (meLineDate.text <> '  /  /    ')) then begin

                try LineDatePicker.Date := StrToDate(meLineDate.text);
                except meLineDate.setfocus
                end;
        end;

        // end

end;

procedure TCashBookForm.LineDatePickerDropDown(Sender: TObject);
begin
     if LineDatePicker.Date = 30/12/99 then LineDatePicker.date := StrToDate (TxDate.Text );

end;

procedure TCashBookForm.meLineDateChange(Sender: TObject);
begin
     if LineDate.Text <> meLineDate.text then begin
        if ((melinedate.Text <> '  /  /  ') and (melinedate.Text <> '  /  /    ')) then LineDate.Text := meLineDate.Text
        else LineDate.Text := '';
     end;
end;

procedure TCashBookForm.LineDateChange(Sender: TObject);
begin
     if meLineDate.Text <> LineDate.text then meLineDate.Text := LineDate.text;
end;

procedure TCashBookForm.CommentKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
         if ((Comment.text <> '') and ((prog = CashInc) or (Prog = CashExp)) and (justadded = false)) then Begin   { Customer / Supplier Column }
                        Newlistbox.InitialSearchFieldText:= Comment.Text;
                 If expenditure.checked then  NewListBox.ListIt ( Sender, Suppliers, 'S' )
                    else NewListBox.ListIt ( Sender, Customers, 'C' );
                    If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then begin
                       comment.Text := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ),1);
                       cust_suppcode := StrToInt(NewListBox.ListInfo.ReturnValue);
                       justadded := true;
                       end else begin
                           Comment.text := '';
                           showmessage('Please choose from the drop down list of Customers / Suppliers.')
                       end;
        end
                else justadded := false;
end;


procedure TCashBookForm.AmtReceivedClick(Sender: TObject);
begin
       custsuppcodeexit(sender);
       application.processmessages;
       self.setfocus;
end;

procedure TCashBookForm.AmtReceivedMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
        custsuppcodeexit(sender);
   //     AmtReceivedClick(sender);
        application.processmessages;
end;

procedure TCashbookform.GetUnAllocatedInvoices(CustSuppID : integer;OverpaymentLine : boolean);
var
        i : integer;
// This procedure picks up all unallocated inoivces and copies into Temp Allocation Table
begin

    PreviousYearTxs := False;
 //   IncludeLastYearCB.Checked := False;

    AccsDataModule.TransactionsDB.Filtered := false;
    if PROG = SALESTX then AccsDataModule.TransactionsDB.Filter := 'TxType = ''1'' and Account = ''' + vartostr(CustSuppID) + ''' and Allocated <> ''Y'' and Amount <> 0.00'
        else AccsDataModule.TransactionsDB.Filter := 'TxType = ''5'' and Account = ''' + vartostr(CustSuppID) + ''' and Allocated <> ''Y''';
    AccsDataModule.TransactionsDB.Filtered := true;

//    AccsDataModule.AllocationTempDB.Close;
//    AccsDataModule.AllocationTempDB.emptytable;
//    AccsDataModule.AllocationTempDB.open;

    Accsdatamodule.TransactionsDB.First;

  //  if Accsdatamodule.TransactionsDB.RecordCount = 0 then AllocationGrid.Enabled := false          // TGM AB 14/06/13
  //      else AllocationGrid.Enabled := true;                                                       // TGM AB 14/06/13

    for i:= 1 to Accsdatamodule.TransactionsDB.RecordCount do begin
        AccsDataModule.AllocationTempDB.append;
        AccsDataModule.AllocationTempDB['TxID'] := Accsdatamodule.TransactionsDB['TxNo'];
        AccsDataModule.AllocationTempDB['InvDate'] := Accsdatamodule.TransactionsDB['TxDate'];
        AccsDataModule.AllocationTempDB['InvRef'] := Accsdatamodule.TransactionsDB['Reference'];
        AccsDataModule.AllocationTempDB['InvComment'] := Accsdatamodule.TransactionsDB['Descript'];
        AccsDataModule.AllocationTempDB['InvTotal'] := Accsdatamodule.TransactionsDB['Amount'] + Accsdatamodule.TransactionsDB['TaxDisc'];
        AccsDataModule.AllocationTempDB['Outstanding'] := AccsDataModule.AllocationTempDB['InvTotal'] - Accsdatamodule.TransactionsDB['Amtpaid'];
        AccsDataModule.AllocationTempDB['PreviousYear'] := ' ';
        if AccsDataModule.AllocationTempDB['InvTotal'] = 0 then AccsDataModule.AllocationTempDB.cancel                // TGM AB 15/11/17
                else AccsDataModule.AllocationTempDB.post;                                                            // TGM AB 15/11/17
        Accsdatamodule.TransactionsDB.next;
    end;

    AccsDataModule.TransactionsDB.Filtered := false;
    AccsDataModule.TransactionsDB.Filter := '';

    // Add blank line for overpayment
    if OverpaymentLine then begin
        AccsDataModule.AllocationTempDB.append;
        AccsDataModule.AllocationTempDB['TxID'] := 0;
        AccsDataModule.AllocationTempDB['InvComment'] := 'Overpayment';
        AccsDataModule.AllocationTempDB.post;
    end;

    if Accsdatamodule.AllocationTempDB.RecordCount = 0 then AllocationGrid.Enabled := false     // TGM AB 14/06/13
        else AllocationGrid.Enabled := true;                                                    // TGM AB 14/06/13

end;

procedure TCashBookForm.SimpleAllocationClick(Sender: TObject);
begin
        InvoiceAllocationPanel.Visible := false;
end;

procedure TCashbookform.TotalAllocationAmounts;
var
      i, currenttx : integer;
      Amt, Dis, RowAmt, RowDis, RowOut, TempReal : real;
      AmtStr, DisStr : shortstring;
begin
     try currenttx := AccsDataModule.AllocationTempDB['TxID'];
     except begin
            AccsDataModule.AllocationTempDB.cancel;
            exit;
            end;
     end;
     Amt := 0;
     Dis := 0;

     AccsDataModule.AllocationTempDB.first;
     for i:= 1 to AccsDataModule.AllocationTempDB.RecordCount do begin


         RowAmt := 0;
         RowDis := 0;
         RowOut := 0;
         TempReal := 0;
         Amt := Amt +  AccsDataModule.AllocationTempDB.FieldByName('AmountPaid').asfloat;
         Dis := Dis +  AccsDataModule.AllocationTempDB.FieldByName('Discount').asfloat;
         RowAmt := AccsDataModule.AllocationTempDB.FieldByName('AmountPaid').asfloat;
         RowDis := AccsDataModule.AllocationTempDB.FieldByName('Discount').asfloat;
         RowOut := AccsDataModule.AllocationTempDB.FieldByName('Outstanding').asfloat;
         if RowOut < -10000000 then RowOut := 0; // fixes bug where outstanding is sometimes read as a huge negative number
         TempReal := RowAmt + RowDis;
         if (( round(RowOut*100) = round(TempReal*100)) and (RowOut <> 0)) then begin
                AccsDataModule.AllocationTempDB.edit;
                AccsDataModule.AllocationTempDB['CompleteAllocation'] := 'Y';
                end else begin
                   if ((AccsDataModule.AllocationTempDB.FieldByName('AmountPaid').asfloat <> 0) or (AccsDataModule.AllocationTempDB.FieldByName('Discount').asfloat <> 0)) then begin
                        AccsDataModule.AllocationTempDB.edit;
                        AccsDataModule.AllocationTempDB['CompleteAllocation'] := '';
                        end;
                   if ((TempReal > Rowout) and (Rowout > 0)) then begin
                       showmessage('Error - Cannot allocate more than the outstanding amount');
                       AccsDataModule.AllocationTempDB.edit;
                       AccsDataModule.AllocationTempDB['AmountPaid'] := 0;
                       AccsDataModule.AllocationTempDB['Discount'] := 0;
                       AccsDataModule.AllocationTempDB.post;
                   end;
                   end;
         AccsDataModule.AllocationTempDB.next;
     end;
     DoubleToStr ( Amt, AmtStr, '%1.2f', False, False, 0, True );
     DoubleToStr ( Dis, DisStr, '%1.2f', False, False, 0, True );

     AllocAmount.text := AmtStr;
     AllocDiscount.text := DisStr;
     AmtReceived.text := AmtStr;
     Discount.text := DisStr;
     AmtReceived.Modified := true;
     Discount.Modified := true;
     AmtReceivedChange(self);
     DiscountChange(self);
     AccsDataModule.AllocationTempDB.Locate('TxID',currenttx,[]);
end;

procedure TCashbookform.AllocateToInvoices(PaymentTx : Integer);
var
      i, txid : integer;
      AmtPaid, Discount, outstanding, temptotal : real;
      complete, tempstr : string;
      PaymentID : integer;
      RunningVAT, invoiceTOTAL, invoiceVAT, VATClaimed : real;
      VATPercentage, AllocatedVAT : real;
      OutstandingVAT, tempreal, TotalPaymentVAT, TempOverpayment : real;
begin

      AmtPaid := 0;
      Discount := 0;

      accsdatamodule.TransactionsDB.Locate('TxNo',PaymentTx,[]);
      if accsdatamodule.TransactionsDB['TxType'] = 9 then begin
               PaymentTx := PaymentTx -1
      end;
      PaymentID := PaymentTx;

      // Split Last Years & This Years Transactions



      Accsdatamodule.AllocationTempDB.Filter := 'PreviousYear <> ''*''';
      Accsdatamodule.AllocationTempDB.Filtered := true;

      AccsDataModule.AllocationTempDB.first;
      for i:= 1 to AccsDataModule.AllocationTempDB.RecordCount do
         begin
            TxID := AccsDataModule.AllocationTempDB['TxID'];
            if ( TxID > 0 ) then
               begin
                  complete := 'N';
                  TxID := AccsDataModule.AllocationTempDB['TxID'];
                  AmtPaid := AccsDataModule.AllocationTempDB.FieldByName('AmountPaid').asfloat;
                  Discount := AccsDataModule.AllocationTempDB.FieldByName('Discount').asfloat;
                  Outstanding := AccsDataModule.AllocationTempDB.FieldByName('Outstanding').asfloat;
                  try
                     if ( Length(AccsDataModule.AllocationTempDB.FieldByName('CompleteAllocation').AsString) = 0 ) then
                        complete := 'N'
                     else
                        complete := AccsDataModule.AllocationTempDB['CompleteAllocation']
                  except

                  end;
                  temptotal := (AmtPaid + Discount);
                  if (Outstanding = temptotal) then complete := 'Y';

                  // now locate the invoice in the transactions file and update details
                  accsdatamodule.TransactionsDB.open;
                  accsdatamodule.TransactionsDB.Locate('TxNo',TxID,[]);
                  accsdatamodule.TransactionsDB.Edit;
                  accsdatamodule.TransactionsDB['AmtPaid'] := accsdatamodule.TransactionsDB['AmtPaid'] + AmtPaid + Discount;
                  accsdatamodule.TransactionsDB.Post;
               end;
            AccsDataModule.AllocationTempDB.Next;
         end;

      // This section allocates the VAT percentages of each invoice against the payment.
      if ( not(InvoiceAllocationPanel.Visible) ) then
         MarkInvoiceComplete(TxID,False,False);

      AmtPaid := 0;
      Discount := 0;
      invoiceTOTAL := 0;
      invoiceVAT := 0;
      RunningVAT := 0;
      VATPercentage := 0;
      OutstandingVAT := 0;
      TotalPaymentVAT := 0;
      TempOverpayment := 0;

      AccsDataModule.AllocationTempDB.first;
      for i:= 1 to AccsDataModule.AllocationTempDB.RecordCount do
         begin
            TxID := AccsDataModule.AllocationTempDB['TxID'];
            AmtPaid := AccsDataModule.AllocationTempDB.FieldByName('AmountPaid').asfloat;
            Discount := AccsDataModule.AllocationTempDB.FieldByName('Discount').asfloat;

            temptotal := (AmtPaid + Discount);

            allocatedVAT := 0;

            if ( TxID <> 0 ) then
               begin
                  accsdatamodule.TransactionsDB.Locate('TxNo',TxID,[]);
                  invoiceTOTAL := accsdatamodule.TransactionsDB['Amount'];
                  invoiceVAT := accsdatamodule.TransactionsDB['TaxDisc'];
                  invoiceTOTAL := invoiceTOTAL + invoiceVAT;
                  try
                     VATClaimed := accsdatamodule.TransactionsDB.FieldByName('VATClaimed').AsFloat;
                  except
                     VATClaimed := 0;
                  end;
                  OutstandingVAT := invoiceVAT - VATClaimed;

                  // Work out percentage of invoice paid

                if ((temptotal <> 0) and ( invoiceTOTAL <> 0 )) then VATPercentage := temptotal / invoiceTOTAL        // TGB AB 27/05/16
                 else VATPercentage := 0;                                                                             // TGB AB 27/05/16
                AllocatedVAT := VATPercentage *  invoiceVAT;
                TempStr := FloatToStrF(AllocatedVAT, ffFixed, 9,2);
                AllocatedVAT := StrToFloat(Tempstr);

                  if ( (outstandingVAT - allocatedVAT) < 0.05 ) then
                     allocatedVAT := outstandingVAT;

                  accsdatamodule.TransactionsDB.edit;
                  accsdatamodule.TransactionsDB['VATClaimed'] := VATClaimed + allocatedVAT;
                  accsdatamodule.TransactionsDB.post;
                  RunningVAT := RunningVAT + allocatedVAT;  // Total VAT element of payment
               end;
            // Enter Invoice Breakdown Details into AllocatedVAT database table for report purposes

            if temptotal <> 0 then begin
                   accsdatamodule.AllocatedVATDB.open;
                   accsdatamodule.AllocatedVATDB.append;
                   accsdatamodule.AllocatedVATDB['PaymentID'] := PaymentTx;
                   accsdatamodule.AllocatedVATDB['InvoiceID'] := TxID;
                   accsdatamodule.AllocatedVATDB['Amount'] := temptotal - allocatedVAT;
                   accsdatamodule.AllocatedVATDB['VAT'] := allocatedVAT;
                   accsdatamodule.AllocatedVATDB['TotalAmount'] := temptotal;
                   accsdatamodule.AllocatedVATDB['AllocatedDate'] := StrToDate(TxDate.text);
                   accsdatamodule.AllocatedVATDB.post;
            end;

            TotalPaymentVAT := TotalPaymentVAT + allocatedVAT;  // total of each line to be added together on the payment line

            AccsDataModule.AllocationTempDB.Next;
         end;

         // Update payment with VAT proportions of each line

      accsdatamodule.TransactionsDB.Locate('TxNo',PaymentTx,[]);
      accsdatamodule.TransactionsDB.edit;
      accsdatamodule.TransactionsDB['AllocatedVATAmount'] := {accsdatamodule.TransactionsDB['AllocatedVATAmount'] +} TotalPaymentVAT;
      Accsdatamodule.TransactionsDB['BankRec'] := 'U';  // TGM AB 30/08/13

      try
         accsDataModule.AllocationTempDB.Locate('InvComment','Overpayment',[]);
         TempOverpayment := accsDataModule.AllocationTempDB.FieldByName('AmountPaid').AsFloat;
      except
         TempOverpayment := 0;
      end;

      accsdatamodule.TransactionsDB['Overpayment'] := TempOverpayment;

      accsdatamodule.TransactionsDB.post;

      AccsDataModule.AllocationTempDB.first;
      for i:= 1 to AccsDataModule.AllocationTempDB.RecordCount do
         begin
            TxID := AccsDataModule.AllocationTempDB['TxID'];
            if ( TxID <> 0 ) then
               begin
                  try
                     if ( Length(AccsDataModule.AllocationTempDB.FieldByName('CompleteAllocation').AsString) > 0 ) then
                        complete := copy(AccsDataModule.AllocationTempDB.FieldByName('CompleteAllocation').AsString,0,1)
                     else
                        complete := '';
                  except
                     complete := '';
                  end;
                  if ( ansiuppercase(complete) = 'Y' ) then
                     MarkInvoiceComplete(TxID,False,false);
               end;
            AccsDataModule.AllocationTempDB.Next;
         end;

      Accsdatamodule.AllocationTempDB.Filtered := false;

      // Last Year

      AmtPaid := 0;
      Discount := 0;

      Accsdatamodule.AllocationTempDB.Filter := 'PreviousYear = ''*''';
      Accsdatamodule.AllocationTempDB.Filtered := true;

      AccsDataModule.AllocationTempDB.first;
      for i:= 1 to AccsDataModule.AllocationTempDB.RecordCount do
         begin
            TxID := AccsDataModule.AllocationTempDB['TxID'];
            if ( TxID <> 0 ) then
               begin
                  complete := 'N';
                  TxID := AccsDataModule.AllocationTempDB['TxID'];
                  AmtPaid := AccsDataModule.AllocationTempDB.FieldByName('AmountPaid').asfloat;
                  Discount := AccsDataModule.AllocationTempDB.FieldByName('Discount').asfloat;
                  Outstanding := AccsDataModule.AllocationTempDB.FieldByName('Outstanding').asfloat;
                  try
                     if ( Length(AccsDataModule.AllocationTempDB.FieldByName('CompleteAllocation').AsString) > 0 ) then
                        complete := AccsDataModule.AllocationTempDB['CompleteAllocation']
                     else
                        complete := '';
                  except
                  end;
                  temptotal := (AmtPaid + Discount);
                  if ( Outstanding = temptotal ) then
                     complete := 'Y';
                  // now locate the invoice in the transactions file and update details
                  accsdatamodule.TransactionsYr1DB.open;
                  accsdatamodule.TransactionsYr1DB.Locate('TxNo',TxID,[]);
                  accsdatamodule.TransactionsYr1DB.Edit;
                  accsdatamodule.TransactionsYr1DB['AmtPaid'] := accsdatamodule.TransactionsYr1DB['AmtPaid'] + AmtPaid + Discount;
                  accsdatamodule.TransactionsYr1DB.Post;
               end;
            AccsDataModule.AllocationTempDB.Next;
         end;

      // This section allocates the VAT percentages of each invoice against the payment.
      if ( not(InvoiceAllocationPanel.Visible) ) then
         MarkInvoiceComplete(TxID,False,True);

      AmtPaid := 0;
      Discount := 0;
      invoiceTOTAL := 0;
      invoiceVAT := 0;
      RunningVAT := 0;
      VATPercentage := 0;
      OutstandingVAT := 0;
      TotalPaymentVAT := 0;

      AccsDataModule.AllocationTempDB.first;
      for i:= 1 to AccsDataModule.AllocationTempDB.RecordCount do
         begin
            TxID := AccsDataModule.AllocationTempDB['TxID'];
            AmtPaid := AccsDataModule.AllocationTempDB.FieldByName('AmountPaid').asfloat;
            Discount := AccsDataModule.AllocationTempDB.FieldByName('Discount').asfloat;

            temptotal := (AmtPaid + Discount);

            allocatedVAT := 0;

            if ( TxID <> 0 ) then
               begin
                   accsdatamodule.TransactionsYr1DB.Locate('TxNo',TxID,[]);
                   invoiceTOTAL := accsdatamodule.TransactionsYr1DB['Amount'];
                   invoiceVAT := accsdatamodule.TransactionsYr1DB['TaxDisc'];
                   invoiceTOTAL := invoiceTOTAL + invoiceVAT;
                   try
                      VATClaimed := accsdatamodule.TransactionsYr1DB['VATClaimed'];
                   except
                      VATClaimed := 0;
                   end;
                   OutstandingVAT := invoiceVAT - VATClaimed;

                   // Work out percentage of invoice paid

                if ((temptotal <> 0) and ( invoiceTOTAL <> 0 )) then VATPercentage := temptotal / invoiceTOTAL        // TGB AB 27/05/16
                 else VATPercentage := 0;                                                                             // TGB AB 27/05/16
                AllocatedVAT := VATPercentage *  invoiceVAT;
                TempStr := FloatToStrF(AllocatedVAT, ffFixed, 9,2);
                AllocatedVAT := StrToFloat(Tempstr);

                   if ( (outstandingVAT - allocatedVAT) < 0.05 ) then
                      allocatedVAT := outstandingVAT;

                   accsdatamodule.TransactionsYr1DB.edit;
                   accsdatamodule.TransactionsYr1DB['VATClaimed'] := VATClaimed + allocatedVAT;
                   accsdatamodule.TransactionsYr1DB.post;
                   RunningVAT := RunningVAT + allocatedVAT;  // Total VAT element of payment
               end;

            // Enter Invoice Breakdown Details into AllocatedVAT database table for report purposes
            if ( temptotal <> 0 ) then
               begin
                  accsdatamodule.AllocatedVATDB.open;
                  accsdatamodule.AllocatedVATDB.append;
                  accsdatamodule.AllocatedVATDB['PaymentID'] := PaymentTx;
                  accsdatamodule.AllocatedVATDB['InvoiceID'] := TxID;
                  accsdatamodule.AllocatedVATDB['Amount'] := temptotal - allocatedVAT;
                  accsdatamodule.AllocatedVATDB['VAT'] := allocatedVAT;
                  accsdatamodule.AllocatedVATDB['TotalAmount'] := temptotal;
                  accsdatamodule.AllocatedVATDB['AllocatedDate'] := StrToDate(TxDate.text);
                  accsdatamodule.AllocatedVATDB['PreviousYear'] := True;
                  accsdatamodule.AllocatedVATDB.post;
               end;

            TotalPaymentVAT := TotalPaymentVAT + allocatedVAT;  // total of each line to be added together on the payment line

            AccsDataModule.AllocationTempDB.Next;
         end;

      // Update payment with VAT proportions of each line
      accsdatamodule.TransactionsDB.Locate('TxNo',PaymentTx,[]);
      accsdatamodule.TransactionsDB.edit;
      accsdatamodule.TransactionsDB['AllocatedVATAmount'] := accsdatamodule.TransactionsDB['AllocatedVATAmount'] + TotalPaymentVAT;
      Accsdatamodule.TransactionsDB['BankRec'] := 'U';  // TGM AB 30/08/13

      try
         accsDataModule.AllocationTempDB.Locate('InvComment','Overpayment',[]);
         TempOverpayment := accsDataModule.AllocationTempDB.FieldByName('AmountPaid').AsFloat;
      except
         TempOverpayment := 0;
      end;
      accsdatamodule.TransactionsDB['Overpayment'] := accsdatamodule.TransactionsDB.FieldByName('Overpayment').AsFloat + TempOverpayment;
      accsdatamodule.TransactionsDB.post;

      AccsDataModule.AllocationTempDB.first;
      for i:= 1 to AccsDataModule.AllocationTempDB.RecordCount do
         begin
            TxID := AccsDataModule.AllocationTempDB['TxID'];
            if ( TxID <> 0 ) then
               begin
                 try
                    if ( Length(AccsDataModule.AllocationTempDB.FieldByName('CompleteAllocation').AsString) > 0 ) then
                       complete := copy(AccsDataModule.AllocationTempDB.FieldByName('CompleteAllocation').AsString,0,1)
                    else
                       complete := '';
                 except
                 end;
                 if ( ansiuppercase(complete) = 'Y' ) then
                    MarkInvoiceComplete(TxID,False,True);
               end;
            AccsDataModule.AllocationTempDB.Next;
         end;
      Accsdatamodule.AllocationTempDB.Filtered := false;
end;

procedure TCashBookForm.MarkInvoiceComplete(TxID : integer; CashTrans : boolean; lastyear : boolean);
var
        TxType : integer; // holds txtype for invoice 1 for sales 5 for Purchase
        complete : boolean;
        PaymentType : integer; // payment type of 2 for sales or 6 for purchase
        Amount, VAT : Real;
        PaymentID : integer;
begin

    Amount := 0;
    VAT := 0;

    // mark invoice & type 9 & 0 as allocated

    if Prog = SalesTX then TxType := 1
        else TxType := 5;

    if Prog = SalesTX then PaymentType := 2
        else PaymentType := 6;

    if LastYear = false then begin

        accsdatamodule.TransactionsDB.Locate('TxNo',TxID,[]);
        accsdatamodule.TransactionsDB.edit;
        Amount := accsdatamodule.TransactionsDB['Amount'];
        VAT := accsdatamodule.TransactionsDB['TaxDisc'];
        accsdatamodule.TransactionsDB['Allocated'] := 'Y';
        accsdatamodule.TransactionsDB['AmtPaid'] := Amount + VAT;
        accsdatamodule.TransactionsDB['VATClaimed'] := VAT;
        accsdatamodule.TransactionsDB.post;

        Complete := false;

        while not complete do begin
                accsdatamodule.TransactionsDB.next;
        //      accsdatamodule.TransactionsDB.edit;
                if accsdatamodule.TransactionsDB['OrigType'] = TxType then begin
                        if not ((accsdatamodule.TransactionsDB['TxType'] = 0) or (accsdatamodule.TransactionsDB['TxType'] = 9)) then complete := true;
                        if not complete then begin
                                accsdatamodule.TransactionsDB.edit;
                                accsdatamodule.TransactionsDB['Allocated'] := 'Y';
                                accsdatamodule.TransactionsDB.post;
                        end;
                end else
                complete := True;
        end;


        //    accsdatamodule.TransactionsDB.Locate('TxNo',TxID,[]);

        if cashtrans then begin

                complete := false;

                while not complete do begin
                        accsdatamodule.TransactionsDB.next;
                        if accsdatamodule.TransactionsDB['TxType'] = PaymentType then begin
        //                accsdatamodule.TransactionsDB.Locate('TxNo',TxID,[]);
                        PaymentID := accsdatamodule.TransactionsDB['TxNo'];
                        accsdatamodule.TransactionsDB.edit;
        //                accsdatamodule.TransactionsDB['AmtPaid'] := Amount + VAT; //(accsdatamodule.TransactionsDB['Amount'] + accsdatamodule.TransactionsDB['TaxDisc']);

                        accsdatamodule.TransactionsDB['AllocatedVatAmount'] := VAT; //accsdatamodule.TransactionsDB['TaxDisc'];
                        accsdatamodule.TransactionsDB.post;
                        complete := True;
                   end;
                end;

                // need to put details into the AllocatedVAT table

                accsdatamodule.AllocatedVATDB.open;
                accsdatamodule.AllocatedVATDB.append;
                accsdatamodule.AllocatedVATDB['PaymentID'] := PaymentID;
                accsdatamodule.AllocatedVATDB['InvoiceID'] := TxID;
                accsdatamodule.AllocatedVATDB['Amount'] := Amount;
                accsdatamodule.AllocatedVATDB['VAT'] := VAT;
                accsdatamodule.AllocatedVATDB['TotalAmount'] := Amount + VAT;
                accsdatamodule.AllocatedVATDB['AllocatedDate'] := StrToDate(TxDate.text);
                accsdatamodule.AllocatedVATDB.post;

        end;   // cashbookg
    end   // not (TxWrite.TxNo)   //db1.DBRechighlast year
        else begin
             accsdatamodule.TransactionsYr1DB.Locate('TxNo',TxID,[]);
             accsdatamodule.TransactionsYr1DB.edit;
             Amount := accsdatamodule.TransactionsYr1DB['Amount'];
             VAT := accsdatamodule.TransactionsYr1DB['TaxDisc'];
             accsdatamodule.TransactionsYr1DB['Allocated'] := 'Y';
             accsdatamodule.TransactionsYr1DB['AmtPaid'] := Amount + VAT;
             accsdatamodule.TransactionsYr1DB['VATClaimed'] := VAT;          // TGM AB 31/05/13
             accsdatamodule.TransactionsYr1DB.post;

             Complete := false;

             while not complete do begin
                accsdatamodule.TransactionsYr1DB.next;
        //      accsdatamodule.TransactionsYr1DB.edit;
                if accsdatamodule.TransactionsYr1DB['OrigType'] = TxType then begin
                        if not ((accsdatamodule.TransactionsYr1DB['TxType'] = 0) or (accsdatamodule.TransactionsYr1DB['TxType'] = 9)) then complete := true;
                        if not complete then begin
                                accsdatamodule.TransactionsYr1DB.edit;
                                accsdatamodule.TransactionsYr1DB['Allocated'] := 'Y';
                                accsdatamodule.TransactionsYr1DB.post;
                        end;
                        if accsdatamodule.TransactionsYr1DB.RecNo = accsdatamodule.TransactionsYr1DB.RecordCount then complete := true;
                end else
                        complete := True;
             end;


             //    accsdatamodule.TransactionsYr1DB.Locate('TxNo',TxID,[]);

                             // need to put details into the AllocatedVAT table

                accsdatamodule.AllocatedVATDB.open;
                accsdatamodule.AllocatedVATDB.append;
                accsdatamodule.AllocatedVATDB['PaymentID'] := PaymentID;
                accsdatamodule.AllocatedVATDB['InvoiceID'] := TxID;
                accsdatamodule.AllocatedVATDB['Amount'] := Amount;
                accsdatamodule.AllocatedVATDB['VAT'] := VAT;
                accsdatamodule.AllocatedVATDB['TotalAmount'] := Amount + VAT;
                accsdatamodule.AllocatedVATDB['AllocatedDate'] := StrToDate(TxDate.text);
                accsdatamodule.AllocatedVATDB['PreviousYear'] := True;
                accsdatamodule.AllocatedVATDB.post;


             if cashtrans then begin
                 // can't do a cash transaction in last years data

            end;

        end; // last year
end;

procedure TCashBookForm.AllocationGridColExit(Sender: TObject);
begin
        TotalAllocationAmounts;
end;

procedure TCashBookForm.OpeningBalanceBtnClick(Sender: TObject);
begin
        AllocationGrid.Hide;
        AllocAmount.Hide;
        AllocDiscount.hide;
        IncludeLastYearCB.Hide;
        BalancePanel.visible := true;
        Label15.hide;
        Label16.hide;
        payrecpanel.show;
        payrecpanel.BringToFront;
        AmtReceived.text := '';
        Discount.text := '';
        CustSuppCodeExit(Self);
        label18.hide; // TGM AB 19/06/15
   //     UnallocatedPaymentBtn.Font.Style := [];
   //     OpeningBalanceBtn.Font.Style := [fsBold];
   //     UnallocatedInvoicesBtn.Font.Style := [];
end;

procedure TCashBookForm.OverPaymentBtnClick(Sender: TObject);
begin
        AllocationGrid.Hide;
        AllocAmount.Hide;
        AllocDiscount.hide;
        BalancePanel.visible := false;
        Label15.hide;
        Label16.hide;
        payrecpanel.show;
        payrecpanel.BringToFront;
        AmtReceived.text := '';
        Discount.text := '';
        CustSuppCodeExit(Self);
    //    UnallocatedPaymentBtn.Font.Style := [fsBold];
    //    OpeningBalanceBtn.Font.Style := [];
    //    UnallocatedInvoicesBtn.Font.Style := [];
end;

procedure TCashBookForm.ThisYearBtnClick(Sender: TObject);
begin
              CustSuppCodeExit(Self);
              AllocationGrid.show;
              AllocAmount.show;
              AllocDiscount.show;
              BalancePanel.visible := false;
              Label15.show;
              Label16.show;
              payrecpanel.hide;
              AmtReceived.text := '';
              Discount.text := '';
              IncludeLastYearCB.show;
              IncludeLastYearCB.checked := false;
              label18.show; // TGM AB 19/06/15

end;

procedure TCashBookForm.UnallocatedBtnClick(Sender: TObject);
begin
        AllocationGrid.Hide;
        AllocAmount.Hide;
        AllocDiscount.hide;
        IncludeLastYearCB.Hide;
        BalancePanel.visible := false;
        Label15.hide;
        Label16.hide;
        payrecpanel.show;
        payrecpanel.BringToFront;
        AmtReceived.text := '';
        Discount.text := '';
        CustSuppCodeExit(Self);
        label18.hide; // TGM AB 19/06/15
end;

procedure TCashbookform.GetUnAllocatedInvoicesPreviousYear(CustSuppID : integer);
var
        i : integer;
// This procedure picks up all unallocated inoivces from last year and copies into Temp Allocation Table
begin

    try Accsdatamodule.TransactionsYr1DB.open;

        AccsDataModule.TransactionsYr1DB.Filtered := false;
        if PROG = SALESTX then AccsDataModule.TransactionsYr1DB.Filter := 'TxType = ''1'' and Account = ''' + vartostr(CustSuppID) + ''' and Allocated <> ''Y'''
            else AccsDataModule.TransactionsYr1DB.Filter := 'TxType = ''5'' and Account = ''' + vartostr(CustSuppID) + ''' and Allocated <> ''Y''';
        AccsDataModule.TransactionsYr1DB.Filtered := true;

//    AccsDataModule.AllocationTempDB.Close;
//    AccsDataModule.AllocationTempDB.emptytable;
//    AccsDataModule.AllocationTempDB.first;

        Accsdatamodule.TransactionsYr1DB.First;

    //    if Accsdatamodule.TransactionsYr1DB.RecordCount = 0 then AllocationGrid.Enabled := false        // TGM AB 14/06/13
    //        else AllocationGrid.Enabled := true;                                                        // TGM AB 14/06/13

        for i:= 1 to Accsdatamodule.TransactionsYr1DB.RecordCount do begin
            AccsDataModule.AllocationTempDB.append;
            AccsDataModule.AllocationTempDB['TxID'] := Accsdatamodule.TransactionsYr1DB['TxNo'];
            AccsDataModule.AllocationTempDB['PreviousYear'] := '*';
            AccsDataModule.AllocationTempDB['InvDate'] := Accsdatamodule.TransactionsYr1DB['TxDate'];
            AccsDataModule.AllocationTempDB['InvRef'] := Accsdatamodule.TransactionsYr1DB['Reference'];
            AccsDataModule.AllocationTempDB['InvComment'] := Accsdatamodule.TransactionsYr1DB['Descript'];
            AccsDataModule.AllocationTempDB['InvTotal'] := Accsdatamodule.TransactionsYr1DB['Amount'] + Accsdatamodule.TransactionsYr1DB['TaxDisc'];
            AccsDataModule.AllocationTempDB['Outstanding'] := AccsDataModule.AllocationTempDB['InvTotal'] - Accsdatamodule.TransactionsYr1DB['Amtpaid'];
            if AccsDataModule.AllocationTempDB['InvTotal'] = 0 then AccsDataModule.AllocationTempDB.cancel                // TGM AB 15/11/17
                else AccsDataModule.AllocationTempDB.post;                                                                // TGM AB 15/11/17
            Accsdatamodule.TransactionsYr1DB.next;
        end;

        AccsDataModule.TransactionsYr1DB.Filtered := false;
        AccsDataModule.TransactionsYr1DB.Filter := '';

        Accsdatamodule.TransactionsYr1DB.close;

    except
    end;

end;

procedure TCashBookForm.IncludeLastYearCBClick(Sender: TObject);
begin
        if IncludeLastYearCB.checked then PreviousYearTxs := true else PreviousYearTxs := false;
        custsuppcodeexit(self);
end;

procedure TCashBookForm.AllocateToOpeningBalance(TxID : integer);
begin

     Accsdatamodule.TransactionsDB.Locate('TxNo',TxID,[]);
     Accsdatamodule.TransactionsDB.edit;
     Accsdatamodule.TransactionsDB['AllocatedToOpening'] := True;
     Accsdatamodule.TransactionsDB.post;
     if Accsdatamodule.TransactionsDB['TaxDisc'] <> 0 then begin
         Accsdatamodule.TransactionsDB.prior;
         Accsdatamodule.TransactionsDB.edit;
         Accsdatamodule.TransactionsDB['AllocatedToOpening'] := True;
         Accsdatamodule.TransactionsDB.post;
     end;

end;

procedure TCashBookForm.OverpaymentsBtnClick(Sender: TObject);
var
        accountno : integer;
begin
        try Application.CreateForm(TOverpaymentForm, OverpaymentForm);
        except
        end;

        accountno := 0;

        if length(custsuppcode.text) > 0 then begin
            try accountno := strtoint(custsuppcode.text)
            except
            end;
        end;

             // s - supplier, c - customer & account number
        if PROG = SALESTX then OverpaymentForm.LoadForm('c',accountno)  //c
           else OverpaymentForm.LoadForm('s',accountno);  // s

        ThisYearBtnClick(self); // refreshes the grid by reloading transactions etc
end;

procedure TCashbookform.EditAllocatedTransaction(TxID :Integer; TxType : String);
var
   i : integer;
   TempInvoiceID, TempPaymentID : integer;
   TempInvoiceVAT, TempInvoiceTotalAmount, TempAMT : real;
   PaymentTotalAmount : real;
begin
    // Unallocates any payment and allows user to edit transaction & re-allocate

    {

    TxTypes

    PAY - Purchase Payment
    REC - Sales Receipt
    CASHPAY - Cash Purchase
    CASHREC - Cash Sales

    }

    If ((TxType = 'REC') or (TxType = 'PAY')) then begin

    // Look up Allocated VAT Table and find transactions with TxID as the payment id

    Accsdatamodule.AllocatedVATDB.open;
    Accsdatamodule.AllocatedVATDB.Filtered := false;
    Accsdatamodule.AllocatedVATDB.Filter := 'PaymentID = ''' + vartostr(TxID) + '''';
    Accsdatamodule.AllocatedVATDB.Filtered := true;

    if Accsdatamodule.AllocatedVATDB.RecordCount > 0 then begin
       Accsdatamodule.AllocatedVATDB.First;
       for i:=1 to Accsdatamodule.AllocatedVATDB.RecordCount do begin

           // store invoce details

           TempInvoiceID := 0;
           TempInvoiceVAT := 0;
           TempInvoiceTotalAmount := 0;

           TempInvoiceID := Accsdatamodule.AllocatedVATDB['InvoiceID'];
           TempInvoiceVAT := Accsdatamodule.AllocatedVATDB['VAT'];
           TempInvoiceTotalAmount := Accsdatamodule.AllocatedVATDB['TotalAmount'];

           // locate invoice and remove payment details

           // TGM AB 07/07/17 start

           if Accsdatamodule.AllocatedVATDB['PreviousYear'] = 'True' then begin

                        Accsdatamodule.TransactionsYr1DB.open;
                        Accsdatamodule.TransactionsYr1DB.Locate('TxNo',TempInvoiceID,[]);
                        Accsdatamodule.TransactionsYr1DB.edit;
                        Accsdatamodule.TransactionsYr1DB['Allocated'] := '';
                        TempAMT := 0;
                        TempAMT := Accsdatamodule.TransactionsYr1DB['AmtPaid'];
                        Accsdatamodule.TransactionsYr1DB['AmtPaid'] := TempAMT - TempInvoiceTotalAmount;
                        Accsdatamodule.TransactionsYr1DB['VATClaimed'] := Accsdatamodule.TransactionsYr1DB['VATClaimed'] - TempInvoiceVAT;
                        Accsdatamodule.TransactionsYr1DB.post;
                        Accsdatamodule.TransactionsYr1DB.close;


           end else begin

                        Accsdatamodule.TransactionsDB.Locate('TxNo',TempInvoiceID,[]);
                        Accsdatamodule.TransactionsDB.edit;
                        Accsdatamodule.TransactionsDB['Allocated'] := '';
                        TempAMT := 0;
                        TempAMT := Accsdatamodule.TransactionsDB['AmtPaid'];
                        Accsdatamodule.TransactionsDB['AmtPaid'] := TempAMT - TempInvoiceTotalAmount;
                        Accsdatamodule.TransactionsDB['VATClaimed'] := Accsdatamodule.TransactionsDB['VATClaimed'] - TempInvoiceVAT;
                        Accsdatamodule.TransactionsDB.post;

                end;
           // TGM AB 07/07/17 end

           // Mark allocation record with 0's to remove but keep a record of it

           Accsdatamodule.AllocatedVATDB.edit;
           Accsdatamodule.AllocatedVATDB['InvoiceID'] := 0;
           Accsdatamodule.AllocatedVATDB['PaymentID'] := 0;
           Accsdatamodule.AllocatedVATDB.post;

           Accsdatamodule.AllocatedVATDB.next;
       end;

       Accsdatamodule.AllocatedVATDB.Filtered := false;
       Accsdatamodule.AllocatedVATDB.Filter := '';

       // removed Allocated VAT from the payment

       PaymentTotalAmount := 0;
       Accsdatamodule.TransactionsDB.Locate('TxNo',TxID,[]);
       Accsdatamodule.TransactionsDB.edit;
       Accsdatamodule.TransactionsDB['AllocatedVATAmount'] := 0;
       PaymentTotalAmount := Accsdatamodule.TransactionsDB['Amount'] + Accsdatamodule.TransactionsDB['TaxDisc'];
       Accsdatamodule.TransactionsDB.post;

       // Setup screen to bring up invoices again to allocate (payment amount zeroised)
       InvoiceAllocationPanel.Visible := True;
       BalancePanel.Visible := false;
       PayRecPanel.Visible := True;
       IncludeLastYearCB.show;
       IncludeLastYearCB.checked := false;
       Amtreceived.Text := '0';
       Discount.text := '0';
       Overpaymentsbtn.enabled := false;
       CustSuppCodeExit(Self);



       Save.Enabled := true;

    end;



    end;  // If ((TxType = 'REC') or (TxType = 'PAY'))

    If ((TxType = 'CASHREC') or (TxType = 'CASHPAY')) then begin

    // Look up Allocated VAT Table and find transactions with TxID as the invoice id

    Accsdatamodule.AllocatedVATDB.open;
    Accsdatamodule.AllocatedVATDB.Filtered := false;
    Accsdatamodule.AllocatedVATDB.Filter := 'InvoiceID = ''' + vartostr(TxID) + '''';
    Accsdatamodule.AllocatedVATDB.Filtered := true;

    if Accsdatamodule.AllocatedVATDB.RecordCount > 0 then begin
       Accsdatamodule.AllocatedVATDB.First;
       for i:=1 to Accsdatamodule.AllocatedVATDB.RecordCount do begin

           // store payment details

           TempPaymentID := 0;
           TempPaymentID := Accsdatamodule.AllocatedVATDB['PaymentID'];

           // locate Payment and remove payment details

           Accsdatamodule.TransactionsDB.Locate('TxNo',TempPaymentID,[]);
           Accsdatamodule.TransactionsDB.edit;
           Accsdatamodule.TransactionsDB['AllocatedVATAmount'] := 0;
           Accsdatamodule.TransactionsDB.post;

           // Mark allocation record with 0's to remove but keep a record of it

           Accsdatamodule.AllocatedVATDB.edit;
           Accsdatamodule.AllocatedVATDB['InvoiceID'] := 0;
           Accsdatamodule.AllocatedVATDB['PaymentID'] := 0;
           Accsdatamodule.AllocatedVATDB.post;

           Accsdatamodule.AllocatedVATDB.next;
       end;

       Accsdatamodule.AllocatedVATDB.Filtered := false;
       Accsdatamodule.AllocatedVATDB.Filter := '';

       // removed Allocated VAT from the Invoice

       PaymentTotalAmount := 0;
       Accsdatamodule.TransactionsDB.Locate('TxNo',TxID,[]);
       Accsdatamodule.TransactionsDB.edit;
       Accsdatamodule.TransactionsDB['Allocated'] := '';
       Accsdatamodule.TransactionsDB['AmtPaid'] := 0;
       Accsdatamodule.TransactionsDB['VATClaimed'] := 0;
       Accsdatamodule.TransactionsDB.post;

       Save.Enabled := true;

    end;

    end;  // If ((TxType = 'CASHREC') or (TxType = 'CASHPAY'))


end;

procedure TCashBookForm.ExtraQtysBtnClick(Sender: TObject);
var
     EnterpriseCode,Tempstr : ShortString;

begin
        //check if enterprise selected
        EnterpriseCode := '';

        Qty2label.Visible := True;
        Qty2.Visible := True;
        Qty3label.Visible := True;
        Qty3.Visible := True;

        TxLine :=DetailGrid.row;

   //     GetExtraDetails(false);

        if length(DetailGrid.Cells[Entcol, DetailGrid.row]) = 0 then begin
            showmessage('You must select an Enterprise Code before adjusting quantites.');
            exit;
        end else begin
                 EnterpriseCode := DetailGrid.Cells[Entcol, DetailGrid.row];
                 SlimAll(EnterpriseCode);
                 if not GatherEnterpriseQtyFields(EnterpriseCode) then begin
                        showmessage('You have not specified extra quantity fields for Enterprise ''' + EnterpriseCode + ''' '+ #10#13 +
                                        'Go To Setup > Enterprises and enter values for the Quantity 2/3 fields.');
                        exit;
                        end;
                    if Qty2Active then begin
                             Qty2Label.caption := Qty2Name;
                             Qty2.text := '0.00';
                             Qty2Exit(self);
                    end else begin
                        Qty2label.Visible := False;
                        Qty2.Visible := False;
                        end;
                    if Qty3Active then begin
                             Qty3Label.caption := Qty3Name;
                             Qty3.text := '0.00';
                             Qty3Exit(self);
                    end else begin
                        Qty3label.Visible := False;
                        Qty3.Visible := False;
                        end;
                 end;

        if ExtraQtysBtn.top < 380 then begin
                ExtraQtysPanel.Top := ExtraQtysBtn.top + 25;
                ExtraQtysPanel.left := ExtraQtysBtn.left - 120;
        end else begin
                        ExtraQtysPanel.Top := ExtraQtysBtn.top - 160;
                        ExtraQtysPanel.left := ExtraQtysBtn.left - 120;
                 end;

        // Fill in Qty2 / Qty3 Values

        TempStr := vartostr(Qty2Values[TxLine]/100);
        if ChangeToLong ( TempStr ) Then begin
            slimall(Tempstr);
            Qty2.Text := TempStr;
        end else Qty2.Text := '0.00';

        TempStr := vartostr(Qty3Values[TxLine]/100);
        if ChangeToLong ( TempStr ) Then begin
            slimall(Tempstr);
            Qty3.Text := TempStr;
        end else Qty3.Text := '0.00';

        ExtraQtysPanel.show;
        SaveQtysBtn.SetFocus;
end;

procedure TCashBookForm.ClearQtysBtnClick(Sender: TObject);
begin
        ExtraQtysPanel.hide;
        Qty2.Clear;
        Qty3.Clear;
        Qty2Values[TxLine] := 0;
        Qty3Values[TxLine] := 0;
        Detailgrid.setfocus;
end;

procedure TCashBookForm.ExtraQtysPanelExit(Sender: TObject);
begin
        ExtraQtysPanel.hide;
        Detailgrid.setfocus;
end;

Function TCashBookForm.GatherEnterpriseQtyFields(EnterpriseCode : String) : boolean;
begin
        Result := false;
        Qty2Name := '';
        Qty3Name := '';
        Qty2Active := False;
        Qty3Active := False;

        Accsdatamodule.EntsFileDB.Locate('EntCode',EnterpriseCode,[]);

                if not varisnull(Accsdatamodule.EntsFileDB['Quantity2Name']) then begin
                        Qty2Name := Accsdatamodule.EntsFileDB['Quantity2Name'];
                        Qty2Active := True;
                        Result := true;
                end;

                if not varisnull(Accsdatamodule.EntsFileDB['Quantity3Name']) then begin
                        Qty3Name := Accsdatamodule.EntsFileDB['Quantity3Name'];
                        Qty3Active := True;
                        Result := true;
                end;

end;

procedure TCashBookForm.Qty3Exit(Sender: TObject);
Var
   Tempstr : ShortString;
begin
     TempStr := Qty3.Text;
     If ChangeToLong ( TempStr ) Then
        Qty3.Text := TempStr
     Else
        Qty3.SetFocus;

end;

procedure TCashBookForm.Qty2Exit(Sender: TObject);
Var
   Tempstr : ShortString;
begin
     TempStr := Qty2.Text;
     If ChangeToLong ( TempStr ) Then
        Qty2.Text := TempStr
     Else
        Qty2.SetFocus;

end;

procedure TCashBookForm.SaveQtysBtnClick(Sender: TObject);
var
        tempvalue : real;
        IntValue : integer;
begin
        try tempvalue := strtofloat(Qty2.text);
            tempvalue := tempvalue * 100;
            Intvalue := StrToInt(vartostr(tempvalue));
        except
            Intvalue := 0;
        end;
        Qty2Values[TxLine] := Intvalue;

        try tempvalue := strtofloat(Qty3.text);
            tempvalue := tempvalue * 100;
            Intvalue := StrToInt(vartostr(tempvalue));
        except
            Intvalue := 0;
        end;
        Qty3Values[TxLine] := Intvalue;

        ExtraQtysPanel.hide;
end;

// SP - 26/03/2015
procedure TCashBookForm.JobCardImportButtonClick(Sender: TObject);
var
   MyTop, MyLeft : Integer;
   StoredLeftPosition : Integer;
begin
   if not JobCardOpen then Exit;

   JobCardImportButton.Enabled := False;
   if not (IsNumeric(CustSuppCode.Text)) then
      begin
         MessageDlg('Invalid customer code - code must be numeric.',mtError,[mbOK],0);
         Exit;
      end;

   try
      StoredLeftPosition := CashBookForm.Left;

      MyTop := Top + 8 + DetailGrid.Top;
      MyLeft := DetailGrid.ClientToScreen(Point(DetailGrid.CellRect(5, 0).Left, 0)).x - (Left - 25);

      TJobCardViewerForm.LoadJobs(CustSuppNameLabel.Caption,
            StrToInt(CustSuppCode.Text), Point(MyLeft,MyTop), vtToBeImported);
   finally
      CashBookForm.Left := StoredLeftPosition;
      JobCardImportButton.Enabled := True;
   end;
end;

// SP - 26/03/2015
procedure TCashBookForm.AddJobToCard(AJobCardRecord : TJobCardRecord);
var
   RowIndex : Integer;
   NominalAccount : TNominalAccount;
   CheckStr, Tempstr : ShortString;
   TempLong : Real;
   TempStr2 : ShortString;
begin
   NominalAccount := AccsDataModule.Accounts.GetNominalAccount(AJobCardRecord.NominalId);
   if (NominalAccount = nil) then
      begin
         MessageDlg('Nominal account not found.',mtError,[mbOK],0);
         Exit;
      end;

   RowIndex := NextRowIndex;
   DetailGrid.Row := RowIndex;
   
   DetailGrid.Cells[EntCol,RowIndex]   := NominalAccount.EntCode;
   DetailGrid.Cells[NomCol,RowIndex]   := IntToStr(NominalAccount.Id);
   DetailGrid.Cells[DesCol,RowIndex]   := AJobCardRecord.NominalDescription;
   DetailGrid.Cells[QtyCol,RowIndex]   := FloatToStrF(AJobCardRecord.Quantity, ffFixed, 8, 2);
   DetailGrid.Cells[VCodeCol,RowIndex] := NominalAccount.VATCode;
   DetailGrid.Cells[AmtCol,RowIndex]   := '0.00';
   DetailGrid.Cells[VAmtCol,RowIndex]  := '0.00';
   DetailGrid.Cells[ANCol,RowIndex]    := '0';

   // Due to a change in the app users can now leave the product (Machine) empty
   // If empty, we must try load the product using the default product associated with the nominal account.
   if (AJobCardRecord.ProductId<=0) then
      begin
         // Have we got a default product associated with the nominal account.
         if (NominalAccount.DefaultProduct <> nil) then
             AJobCardRecord.ProductId := NominalAccount.DefaultProduct.Id;
      end;

   if (AJobCardRecord.ProductId>0) then
      begin
         AccsDataModule.ProdsTxTemp.Append;
         try
            AccsDataModule.ProdsTxTemp.FieldByName('LineNo').AsInteger := RowIndex;
            AccsDataModule.ProdsTxTemp['LineDate'] := AJobCardRecord.JobDate;
            AccsDataModule.ProdsTxTemp['LineRef'] := AJobCardRecord.JobReference;

            // check Nomlisting for associated Product Record
            if AccsDataModule.Products.Locate('ID', AJobCardRecord.ProductId,[] ) then
               begin
                  try TempLong := AccsDataModule.Products['Defaultprice']
                  except
                  TempLong := 0.00;
                  end;
                  Str(TempLong:8:2,TempStr2);
                  Slimall (TempStr);

                  DetailGrid.Cells[EachCol,RowIndex] := TempStr2;
                  AccsDataModule.ProdsTxTemp.FieldByName('Desc1').AsString := AccsDataModule.Products.FieldByName('Desc1').AsString;

                  if ( Length(AccsDataModule.Products.FieldByName('Desc2').AsString) <= 0 ) then
                     AccsDataModule.ProdsTxTemp.FieldByName('Desc2').AsString := AJobCardRecord.Comment1
                  else
                     begin
                        //   09/04/18 [V4.3 R0.6] /MK Change - If Product Description Line 2 has data and JobCardApp.Comment1 has data then make Detail Line 3 JobCardApp.Comment1.
                        AccsDataModule.ProdsTxTemp.FieldByName('Desc2').AsString := AccsDataModule.Products.FieldByName('Desc2').AsString;
                        if ( Length(AJobCardRecord.Comment1) > 0 ) then
                           AccsDataModule.ProdsTxTemp.FieldByName('Desc3').AsString := AJobCardRecord.Comment1;
                     end;

                  //   09/04/18 [V4.3 R0.6] /MK Additional Feature - If Detail Line 3 does not have data then do check for JobCardApp.Comment2 same as JobCardApp.Comment1.
                  if ( Length(AccsDataModule.ProdsTxTemp.FieldByName('Desc3').AsString) <= 0 ) then
                     begin
                        if ( Length(AccsDataModule.Products.FieldByName('Desc3').AsString) <= 0 ) then
                           AccsDataModule.ProdsTxTemp.FieldByName('Desc3').AsString := AJobCardRecord.Comment2
                        else
                           AccsDataModule.ProdsTxTemp.FieldByName('Desc3').AsString := AccsDataModule.Products.FieldByName('Desc3').AsString;
                     end;

                  AccsDataModule.ProdsTxTemp.FieldByName('ProductID').AsInteger := AJobCardRecord.ProductId;
                  Detailgrid.Cells[DetailCol,RowIndex] :=
                       copy(varToStr(AccsDataModule.ProdsTxTemp['LineDate']),1,6) +
                       copy(varToStr(AccsDataModule.ProdsTxTemp['LineDate']),9,2) +
                       ' ' +
                       LineRef.text +
                       ' ' +
                       dbedesc1.Text;
               end;

            AccsDataModule.ProdsTxTemp.Post;

            CalculateAmount(self);
            calculateUnitCost(RowIndex, true);
            LastRow := RowIndex;
            LastCol := ANCol;
            CheckVATForChanges(True);

         except
            AccsDataModule.ProdsTxTemp.Cancel;
            MessageDlg('Error posting product details.',mtError,[mbOK],0);
         end;
      end;
   TotalSoFar();
end;

// SP - 26/03/2015
function TCashBookForm.NextRowIndex: Integer;
var
   I, J : Integer;
   IsEmpty : Boolean;
begin
   Result := -1;
   for i := 0 to DetailGrid.RowCount-1 do
      begin
         for j := 0 to DetailGrid.ColCount-1 do
           begin
             IsEmpty := DetailGrid.Cells[j, i] = '';
             if not IsEmpty then
                Break;
          end;

         if (IsEmpty) then
            begin
               Result := i;
               Break;
            end;
      end;
end;

// SP - 26/03/2015
procedure TCashBookForm.DefaultHandler(var Message);
begin
  with TMessage(Message) do
    begin
      if (Msg = WM_JOBSFOUND) then
         begin
            CashBookForm.Left := 25;
         end
      else if (Msg = WM_CUSTOMER_NAME_CHANGED) then
         begin
            UpdateCustomerName();
         end
      else if (Msg = WM_KINGSWOOD_FARMSYNC_ERRORINSYNCPROCESS) then
         begin
            _MessageDlg('Error''s have occurred during the Farm Sync operation - please contact Kingswood support.',mtError,[mbOK],0);
         end
      else
         inherited DefaultHandler(Message);
    end;
end;

// SP - 26/03/2015
procedure TCashBookForm.WMCopyData(var Msg: TWMCopyData);
var
   JobCardRecord : TJobCardRecord;
begin
   msg.Result := 0;
   if (KINGSWOOD_ACCOUNTS_POSTJOBTOJOBCARDSCREEN <> 0) and
      (Msg.CopyDataStruct.dwData = KINGSWOOD_ACCOUNTS_POSTJOBTOJOBCARDSCREEN) then
      begin
         JobCardRecord := TJobCardRecord(Msg.CopyDataStruct.lpData^);
         AddJobToCard(JobCardRecord);
         msg.Result := 1;
      end;
end;

// SP 29/05/2015
procedure TCashBookForm.productsEditEnter(Sender: TObject);
var
   Value : Variant;
begin
   If not Assigned(ProductListingForm) then
      Application.CreateForm(TProductListingForm, ProductListingForm);

   ProductListingForm.ShowProductListing('');
   cbProducts.KeyValue := ProductListingForm.ProductID;
   cbProductsCloseUp(nil);

   try
      closeExtraDescButton.SetFocus;
   except
   end;
end;

// TGM AB 19/06/15
procedure TCashBookForm.AutoAllocateAmountExit(Sender: TObject);
Var
   Tempstr : ShortString;
begin
     TempStr := AutoAllocateAmount.Text;
     If ChangeToLong ( TempStr ) Then
        AutoAllocateAmount.Text := TempStr
     Else
        AutoAllocateAmount.SetFocus;
end;

procedure TCashBookForm.AutoAllocateBtnClick(Sender: TObject);
var
   TempStr : Shortstring;
   AllocAmount,Outstanding : Real;
   RowCounter : Integer;
   TableRowCount : Integer;
begin
   // read in Auto Allocation Amount
   try
      TableRowCount := AccsDataModule.AllocationTempDB.recordcount;
   except
      TableRowCount := 0;
   end;

   if ( TableRowCount > 0 ) then
      begin
         AllocAmount := 0;
         TempStr := AutoAllocateAmount.Text;
         AllocAmount := StrToFloat(TempStr);
         CustSuppCodeExit(self);

         AccsDataModule.AllocationTempDB.first;

         While AllocAmount > 0 do
            begin
               Outstanding := AccsDataModule.AllocationTempDB.FieldByName('Outstanding').asfloat;
               if ( AccsDataModule.AllocationTempDB['InvComment'] = 'Overpayment' ) then
                  begin
                     AccsDataModule.AllocationTempDB.edit;
                     AccsDataModule.AllocationTempDB['AmountPaid'] := AllocAmount;
                     AllocAmount := 0;
                  end
               else
                  begin
                     if ( Outstanding < AllocAmount ) then
                        begin
                           AccsDataModule.AllocationTempDB.edit;
                           AccsDataModule.AllocationTempDB['AmountPaid'] := Outstanding;
                           AccsDataModule.AllocationTempDB['CompleteAllocation'] := 'Y';
                           AllocAmount := AllocAmount - Outstanding;
                        end
                     else
                        begin
                           AccsDataModule.AllocationTempDB.edit;
                           AccsDataModule.AllocationTempDB['AmountPaid'] := AllocAmount;
                           AllocAmount := 0;
                        end;
                  end;
               AccsDataModule.AllocationTempDB.next;
            end;

         AutoAllocateAmount.Text := '0.00';
         TotalAllocationAmounts;
      end;
end;
// end TGM AB 19/06/15

procedure TCashBookForm.AllocationGridExit(Sender: TObject);
begin
        TotalAllocationAmounts;     // TGM AB 20/11/15
end;

procedure TCashBookForm.SearchProductsBtnClick(Sender: TObject);        // TGM AB 22/07/16
begin
   If not Assigned(ProductListingForm) then
      Application.CreateForm(TProductListingForm, ProductListingForm);

   ProductListingForm.ShowProductListing('');
   cbProducts.KeyValue := ProductListingForm.ProductID;
   cbProductsCloseUp(nil);

   try
      closeExtraDescButton.SetFocus;
   except
   end;
end;

//   02/12/16 [V4.2 R4.5] /MK Bug Fix - If a blank enterprise existed the program would give an invalid type conversion error.
procedure TCashBookForm.CheckForSingleEnterprise;       // TGM AB 26/08/16
var
   i, RecCount : integer;
begin
   // checks if enterpirse system and then if only one code or not
   SingleEnterprise := False;
   SingleEnterpriseCode := '';

   RecCount := 0;

   //   04/01/17 [V4.2 R5.3] /SP Bug fix - Do not default to single enterprise if the user is using the job card app
   //   19/10/18 [V4.3 R2.5] /MK Bug Fix - Changed from SyncIsAvailable to SyncConfigured as everyone is getting the sync program but only
   //                                      those that have the JobCard would have the SyncConfigured.
   if ( TfmFarmSyncSettings.SyncConfigured(AccsDataModule.CurrentDatabase) ) then Exit;

   if ( not(cash11.Xuse_enterprise) ) then
      begin
         Accsdatamodule.EntsFileDB.First;
         while ( not(AccsDataModule.EntsFileDB.Eof) ) do
            begin
               if ( AccsDataModule.EntsFileDB.FieldByName('Active').AsBoolean ) and
                  ( Length(AccsDataModule.EntsFileDB.FieldByName('EntCode').AsString) > 0 ) then
                  begin
                     RecCount := RecCount +1;
                     SingleEnterpriseCode := AccsDataModule.EntsFileDB.FieldByName('EntCode').AsString;
                  end;
               Accsdatamodule.EntsFileDB.Next;
            end;
         SingleEnterprise := ( RecCount = 1 );
      end;
end;


function  TCashBookForm.CheckForDefaultProduct(NominalCode : String) : boolean;              // TGM AB 06/01/17
begin
    Result := False;
    if AccsDataModule.NominalList.Locate('Account',NominalCode,[] ) then begin
          if AccsDataModule.NominalList.FieldByName('Product').AsInteger <> 0 then Result := True;
    end;
end;

procedure TCashBookForm.UpdateCustomerName;
var
   TestStr : ShortString;
begin
  try
   SetDb ( SalesPurchDB );
   TestStr := CustSuppCode.Text;
   SlimAll ( TestStr );
   ReadRec ( SalesPurchDB, StrToInt ( TestStr ));
   dberr;
   if RecActive ( SalesPurchDB ) then
      begin
         GetItem ( SalesPurchDB, 1 );
         CustSuppNameLabel.Caption := CurrStr;
      end;
   except
   end;
end;

end.


