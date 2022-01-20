{
   24/08/16 [V4.2 R3.6] /MK Bug Fix - ValidateTransactions - Because we default the Analysis to 0, if 0 is not found the transaction was not saved - Stephen Campion.

   25/10/17 [V4.2 R8.9] /MK Change - Added two new columns for Detail1 and Detail2 fields - Brendan Brady.
                                   - Change width of form depending on what fields are showing.

   09/01/18 [V4.2 R9.6] /MK Bug Fix - ImportTransactions - Must have ReadCSVSettings here for the SourceBank to be filled first.

   22/01/18 [V4.3 R0.2] /MK Additional Feature - SaveTransactions - Store the Description and Nominal selected by user in new BankImportNLStore table.
                                               - ImportTransactions - When importing a file check if Description is in new BankImportNLStore table.
                                                                    - If detail exists in BankImportNLStore table then set NominalAccount to stored value.

   26/09/18 [V4.3 R1.4] /MK Change - ValidateTransactions - If transaction being saved is outside of current year the add year start to error message - Rory Crinion.

   20/11/18 [V4.3 R2.8] /MK Change - WriteToTable - Default the Import boolean to false if date on bank file is outside financial year - Rory Crinion.
                            Additional Feature - Allow "Overwrite of Nominal Description" prompt to appear after selecting nominal and preference is on - Scott Mernagh.

   23/11/18 [V4.3 R2.9] /MK Change - SaveTransactions - If the multi line has the NomName i.e used Free Text Nominal preference, then change DescString.
                                   - LoadBankDefaults - OpenDialog.InitialDir should be the specified default location of bank link files from drop-down-menu.

   04/01/19 [V4.3 R4.0] /MK Additional Feature - Added new discount column to grid.
                                               - SetupScreen - Only show new discount column if Ledger system.
                                               - SetupWidthOfForm - Change width of the form if new discount column is hidden.
                                               - BankImportGridTableViewEditing - Only allow discount field to be edited if transaction type is Pay / Rec.
                                               - SaveTransactions - Added variables to store the discount for the payment / receipt.
                                                                  - Take discount and save to payment / receipt.

   09/01/19 [V4.3 R4.0] /MK Bug Fix - BankImportGridTableViewEditKeyUp - Only send message to show NewList form if the key is not the return key - SP/TGM.

   15/01/19 [V4.3 R4.1] /MK Change - SetupScreen - Cashbook Income/Expenditure legend item should only appear if Ledger with Cashbook is enabled.
                                   - ValidateTransactions - Moved Transaction Type check before the date check as this the order the columns take on the grid.
                                                          - Moved Customer/Supplier check after Stub Number to match order of columns on grid.
                                   - InvokeMultiLineEditor - Only allow edit of multiline in Ledgers if Transaction Type is not Pay/Rec.
                                   - BankImportGridTableViewEditing - Don't allow the entry to the Nominal field if the Transaction Type is Pay/Rec.
                            Additional Feature - Allow the split of a transaction when the user right-clicks in the Cust/Supp cell.
                                               - Splitting a transaction creates a new line in the database that the user must fill completely.
                                               - George (TGM) asked for this change to allow multiple Cust/Suppliers be added for a lodgement that may include
                                                 more than one cheque.

   23/01/19 [V4.3 R4.2] /MK Bug Fix - Default height gbImportPanel has to include Browse for Folder section - TGM.

   28/03/19 [V4.3 R4.5] /MK Change - WriteToTable - HSBC bank use a ShortNameMonth e.g. JAN, FEB etc, as part of the date.
                                                    Check to see if this exists and use function to derive date from it - Georgina Fort.

   23/07/19 [V4.4 R1.0] /MK Additional Feature - WriteToTable - Assign Nominal/Enterprise to line if Detail text exists in BankImportNLStore.
                            Change - ImportTransactions - No need to do a second loop through the grid to allocate stored nominals as stored
                                                          nominals are being assigned when transactions are imported from file.
                                   - StoreNominalSelection - If AAllocSelectToGrid then loop through grid and assign nominals to stored Details in BankImportNLStore - Gemma (Matt Ward).

   27/08/19 [V4.5 R0.3] /MK Change - BankImportGridTableViewFocusedItemChanged, BankImportGridTableViewFocusedRecordChanged -
                                     Check if multiline transaction and don't allow edit of nominal, amount, enterprise or analysis code.
                                   - InvokeMultiLineEditor - If user has entered nominal/ent info and then presses Multline button to add more lines, clear off nominal/ent of single line.
                                   - StoreNominalSelection - Don't auto update nominal if this transaction is a mutliline.
                            Bug Fix - SaveTransactions - As BankCSVDetailTempTableDB("NomName") always has the nominal name even if single line then use this instead of BankCSVTempTableDB("NomName")

   16/09/19 [V4.5 R0.4] /MK Change - erTransactionTypesPropertiesChange - If TransactionType is "Payment / Receipt" then blank out stored nominal else assign stored nominal - Martina Flynn.
                                   - BankImportGridTableViewEditing - Don't allow edit of Enterprise if TransactionType is "Payment / Receipt".
                                   - StoreNominalSelection - Don't store nominal if TransactionType is "Payment / Receipt".
                                   - When using StoreNLAndDescription pass in TransactionType.
                            Additional Feature - AssignNomDetailFromStore - New procedure created as the same code was being used 3 times in different subroutines.

   25/10/19 [V4.5 R0.7] /MK Bug Fix - AssignNomDetailFromStore - Don't try if AccsDataModule.BankCSVTempTableDB.FieldByName('Details').AsString is nothing.

   23/12/19 [V4.5 R1.6] /MK Change - WriteToTable - Allow for "java simpledateformat" value to be converted to date - Shane Chambers.
                                   - Allow for the Debit/Credit indicator field that appears in the Bank of Ireland Business Banking file.

   21/02/20 [V4.5 R1.7] /AB Bug Fix - Fixed bug in where nominal description field isn't clearing and appearing in next transaction for DD/DC/SO transactions

   02/03/20 [V4.5 R1.7] /MK Change - ImportTransactions - Don't default Vat to "Z" for Vat module users - George (TGM) request.
                                   - FindAndPostNominal - Default Vat to selected Nominals associated VatCode - George (TGM) request.
                                   - AssignNomDetailFromStore - If Stored Nominal has an associated VatCode then add vat code to the grid - George (TGM) request.

   30/07/20 [V4.5 R3.4] /MK Change - FormCreate - OpenDialog - Changed DefaultExt and Filter to CSV files so customers can't select PDF files -

   29/09/20 [V4.5 R3.9] /MK Change - Order the Source Bank drop-down-list by Name.

   29/09/20 [V4.5 R4.0] /MK Additional Feature - When transactions are saved pop up the new uReviewFarmFinances form.

   19/10/20 [V4.5 R4.4] /MK Change - Added conts for Transaction Type.
                                   - Added new Bank Transfer Transaction Type.
                                   - FindAndPostNominal - If the Transaction Type is Bank Transfer then show banks listing, if the user selects the
                                                          same bank account as the transactions are being imported to give error and
                                                          don't allow the nominal to be set as this bank.
                                   - StoreNominalSelection - For Bank Transfer transactions set the Nominal and clear out the Enterprise.
                                   - erTransactionTypesPropertiesChange - If the Transaction Type is bank transfer then turn off the IsMultiLineTransaction.
                                   - InvokeSearchItem - If the Transaction Type is not Bank Transfer then pop up the Mult Line Editor screen.
                                   - BankImportGridTableViewEditing - Don't allow edit of Enterprise or Vat Code if Transaction type Pay/Receipt or Bank Transfer.
                                                                    - Allow edit of Customer/Supplier field if Transaction Type is anything other than Bank Transfer.
                                                                    - Allow edit of Quantity field if Transaction Type is Cashbook or Cash Sale/Purch.
                                   - SetupWidthOfForm - Added 5 to the width of the columns to allow for the form to fill better.

   11/01/21 [V4.5 R4.8] /MK Bug Fix - SaveTransactions - Check to see if the BankCSVDetailTempTableDB.NomName field has a value, if not then use BankCSVTempTableDB.NomName.

   20/01/22 [V4.5 R6.5] /MK Bug Fix - SaveTransactions - If VatCode selected IsExclusive then transaction amount should be Amount plus VatAmount.
}

unit uBankImport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, cxButtons, cxTextEdit, cxLabel, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxContainer, cxEdit, cxGroupBox, dxBar,
  ActnList, dxBarExtItems, cxMaskEdit, cxDropDownEdit, cxShellComboBox,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, NewListing,
  uAccounts, cxEditRepositoryItems, db, dbTables, TYPES, dxStatusBar,
  ExtCtrls, AccsData, cxStyles, cxHint, cxButtonEdit,
  uTransactionNominalFreeTextDescriptionInput, cxDataUtils, Menus,
  KRoutines, uReviewFarmFinances;

const
   WM_PROCESSGRIDKEYPRESS = WM_USER+1;
   WM_INVOKESEARCHITEM = WM_USER+2;

type
  TSelectType = (stSelected, stDeselected);

  TfmBankImport = class(TForm)
    BarManager: TdxBarManager;
    blbExit: TdxBarLargeButton;
    ActionList: TActionList;
    actExit: TAction;
    actHelp: TAction;
    actImportTransactions: TAction;
    actSave: TAction;
    BarPopupMenu: TdxBarPopupMenu;
    blbSave: TdxBarLargeButton;
    blbSettings: TdxBarLargeButton;
    bbBankFileFormat: TdxBarButton;
    gbImportPanel: TcxGroupBox;
    BankImportGridTableView: TcxGridDBTableView;
    BankImportGridLevel: TcxGridLevel;
    BankImportGrid: TcxGrid;
    blbHelp: TdxBarLargeButton;
    cxLabel1: TcxLabel;
    teBankAccount: TcxTextEdit;
    BrowseLabel: TcxLabel;
    btnSearchAccount: TcxButton;
    cmboBankFileFormat: TcxLookupComboBox;
    SourceBankLabel: TcxLabel;
    lBankAccountName: TcxLabel;
    actBankFileFormat: TAction;
    teFileToImport: TcxTextEdit;
    btnSelectImportFile: TcxButton;
    actSelectFile: TAction;
    OpenDialog: TOpenDialog;
    actSelectBank: TAction;
    Instructions: TLabel;
    BankImportGridTableViewImport: TcxGridDBColumn;
    cxEditRepository1: TcxEditRepository;
    erTransactionTypes: TcxEditRepositoryComboBoxItem;
    BankImportGridTableViewTransactionType: TcxGridDBColumn;
    BankImportGridTableViewTxDate: TcxGridDBColumn;
    BankImportGridTableViewDetails: TcxGridDBColumn;
    BankImportGridTableViewStubNumber: TcxGridDBColumn;
    BankImportGridTableViewAmount: TcxGridDBColumn;
    BankImportGridTableViewVATCode: TcxGridDBColumn;
    BankImportGridTableViewEnterprise: TcxGridDBColumn;
    BankImportGridTableViewNominalName: TcxGridDBColumn;
    BankImportGridTableViewCustSuppName: TcxGridDBColumn;
    BankImportGridTableViewIncomeOrExpense: TcxGridDBColumn;
    BankImportGridTableViewAnalysis: TcxGridDBColumn;
    erCurrency: TcxEditRepositoryCurrencyItem;
    StatusBar: TdxStatusBar;
    erButtonEdit: TcxEditRepositoryButtonItem;
    gbTransactionLegend: TcxGroupBox;
    cxLabel2: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    lLegCashbookHead: TcxLabel;
    lLegCashbookDetail: TcxLabel;
    BankImportGridTableViewMultiLineEdit : TcxGridDBColumn;
    BankImportGridTableViewQuantity: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    TransGridMultiLineStyle: TcxStyle;
    TransGridNormalStyle: TcxStyle;
    BankImportGridTableViewIsMultiLineTransaction: TcxGridDBColumn;
    pHelpPanel: TPanel;
    TickBoxHelpImage: TImage;
    lTickBoxHelp: TcxLabel;
    lSplitTransactionIndicator: TcxLabel;
    dxBarButton1: TdxBarButton;
    DeselectAllTransactions: TAction;
    EmphasizedHeaderStyle: TcxStyle;
    blbSelectDeSelectAllTrans: TdxBarLargeButton;
    BankImportGridTableViewExtraDetail1: TcxGridDBColumn;
    BankImportGridTableViewExtraDetail2: TcxGridDBColumn;
    BankImportGridTableViewNomCode: TcxGridDBColumn;
    BankImportGridTableViewNomFreeText: TcxGridDBColumn;
    BankImportGridTableViewDiscount: TcxGridDBColumn;
    blbAddLine: TdxBarLargeButton;
    actSplitTrans: TAction;
    BankImportGridTableViewTransHash: TcxGridDBColumn;
    TransGridSplitTransStyle: TcxStyle;
    BankImportGridTableViewSplitTransaction: TcxGridDBColumn;
    BankImportGridTableViewSplitTransID: TcxGridDBColumn;
    pmRightBtn: TPopupMenu;
    pmiSplitTransaction: TMenuItem;
    lLodgmentInfo: TcxLabel;
    SelectAllTransactions: TAction;
    lBankTransfer: TcxLabel;
    lBankTransferDesc: TcxLabel;
    procedure teBankAccountDblClick(Sender: TObject);
    procedure teBankAccountExit(Sender: TObject);
    procedure teBankAccountKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure teBankAccountPropertiesChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actBankFileFormatExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure teFileToImportClick(Sender: TObject);
    procedure actSelectFileExecute(Sender: TObject);
    procedure actImportTransactionsExecute(Sender: TObject);
    procedure actImportTransactionsUpdate(Sender: TObject);
    procedure BankImportGridTableViewEditKeyDown(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure BankImportGridTableViewFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure BankImportGridTableViewEditKeyUp(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
    procedure actExitExecute(Sender: TObject);
    procedure BankImportGridTableViewInitEdit(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit);
    procedure actSelectBankExecute(Sender: TObject);
    procedure BankImportGridTableViewEditKeyPress(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure blbHelpClick(Sender: TObject);
    procedure BankImportGridTableViewCellClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure BankImportGridTableViewEditValueChanged(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure erTransactionTypesPropertiesChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MultiLineEditClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure BankImportGridTableViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DeselectAllTransactionsExecute(Sender: TObject);
    procedure BankImportGridTableViewEditing(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      var AAllow: Boolean);
    procedure BankImportGridTableViewTxDatePropertiesPopup(
      Sender: TObject);
    procedure actSplitTransExecute(Sender: TObject);
    procedure BankImportGridTableViewFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure SelectAllTransactionsExecute(Sender: TObject);
  private
    function GetBankImportGridCell(Index: Integer): Variant;
    procedure SetBankImportGridCell(Index: Integer; const Value: Variant);
    procedure EnableDisableGridControls();
    procedure AssignNomDetailFromStore;
  private
    { Private declarations }
    FFileName : string;
    FBankAccount : TBankAccount;
    FAutoLoadTransFile : Boolean;
    SingleAmountColumn : Boolean;
    Delimiter : string;
    ChequeIdentifier : string;
    LodgementIdentifier : string;

    DateCol,
    DetailCol,
    ExtraDetail1Col,
    ExtraDetail2Col,
    DebitCol,
    CreditCol,
    HeaderLines,
    FieldCount,
    DebCredIndicCol : Integer;

    AllDebCredIncicCol : Boolean;

    HintStyleController: TcxHintStyleController;

    SalesPurchDB : Integer;

    FUsingVAT : Boolean;

    FTransactionsPosted : Boolean;

    FYearStart, FYearEnd : Integer;

    FSelectType : TSelectType;

    FWinShortDateStyle : String;

    procedure SetupScreen;
    procedure LoadBankByListing();
    procedure LoadBankDetails();
    procedure LoadBankDefaults(BankAccount : integer);
    procedure SaveBankDefaults(BankAccount : integer);
    Function RemoveNonNumeric(Value : shortstring): string;
    Function GetCustSuppInfo(SalesPurchDB, RecID : Integer) : string;

    procedure ValidateTransactions;
    procedure ReadCSVSettings;
    procedure ImportTransactions();
    procedure SaveTransactions();

    Procedure WriteToTable(ItemCount : integer; Value : shortstring);

    function IsIncomeOrExpense : TTransactionType; // (ttIncome, ttExpense);
    procedure FindAndPostEnterprise();
    procedure FindAndPostNominal(const ASearchTextValue : string = '');
    procedure FindAndPostVATCode();
    procedure FindAndPostCustomerSupplier();
    procedure FindAndPostAnalysisCode();

    procedure ProcessKeyPress(var Message:TMessage); message WM_PROCESSGRIDKEYPRESS;
    function FocusedColumnIndex : Integer;
    function FocusedColumnString : string;
    procedure MyCellDoubleClick(Sender : TObject);
    procedure InvokeGridCellSearch();

    procedure RaiseError(AErrorMessage : string; const AAbort : Boolean = True; const ADisplayError : Boolean = false);
    procedure ProcessCustomerSupplierLookup(ALookupText : string);

    procedure StoreNominalSelection(const ANomCode : Integer; AAllocSelectToGrid : Boolean = True);
    procedure FocusItem(ACustomGridTableItem : TcxCustomGridTableItem; const AHintTitle, AHintText : string);
    procedure HideHint();

    procedure ButtonEditClick(Sender: TObject; AButtonIndex: Integer);
    procedure InvokeSearchItem(var Message:TMessage); message WM_INVOKESEARCHITEM;
    procedure EditCBEQuantities(APoint : TPoint);
    procedure InvokeMultiLineEditor();
    procedure InvokeQuantityScreen;

    procedure ButtonEditOnChange(sender : TObject);
    procedure MoveToItem(AIndex : Integer);
    procedure SetupWidthOfForm;
    procedure AllocateStoredSelectionToGrid;

    procedure EditNominalFreeTextDescription();overload;
    procedure EditNominalFreeTextDescription(APoint : TPoint);overload;

    procedure SelectDeselectAllTrans;
    procedure CheckInitSelectDeSelectAll;

    property BankImportGridCell[Index : Integer] : Variant read GetBankImportGridCell write SetBankImportGridCell;

  public
    { Public declarations }
    class procedure RunImport();overload;
    class procedure RunImport(AFileName : string; ABankAccount : TBankAccount);overload;
  end;

const
   cIncome = 'Receipt';
   cExpense = 'Payment';

   //   19/10/20 [V4.5 R4.4] /MK Change - Added conts for Transaction Type.
   cBankTransfer = 'Bank Transfer';
   cPayReceipt = 'Receipt / Payment';
   cCashSalePurch = 'Cash Sale/Purch';
   cSODCDD = 'DD / DC / SO';
   cCashbook = 'Cashbook';

var
  fmBankImport: TfmBankImport;

implementation

uses
   AccsUtils, VARS, Clears, TxWrite, Calcs,
   uBankCSVConfig, FileCtrl, Mainunit, DBGen, uSetupAnalysis, DBCore,
   uBankMultiLineTransEdit, uQuantityInput, uTransactionQuantityInput,
   uPreferenceConsts, uPreferences, uAccsSystem;

{$R *.DFM}

{ TfmBankImport }

procedure TfmBankImport.ImportTransactions;
var
   ParameterCount,
   CSVLineCount,
   i, line : Integer;
   ImportFile : TStringList;
   Parameter,
   RecordString,
   TransactionHash : String;
begin
   FTransactionsPosted := False;

   //   09/01/18 [V4.2 R9.6] /MK Bug Fix - Must have ReadCSVSettings here for the SourceBank to be filled first.
   ReadCSVSettings;

   CSVLineCount := 0;
   Application.ProcessMessages;
   if not Sysutils.FileExists(teFileToImport.Text) then
      RaiseError('No Bank File selected - Please select a file to import',true,true);

   if (VarIsNull(cmboBankFileFormat.EditValue)) then
      RaiseError('No Source Bank selected - Please select the appropriate Source Bank',true,true);

   ImportFile := TStringlist.create;
   try
      ImportFile.LoadFromFile(teFileToImport.Text);

      AccsDataModule.BankCSVTempTableDB.Close;
      AccsDataModule.BankCSVTempTableDB.Emptytable;
      AccsDataModule.BankCSVTempTableDB.Open;
      AccsDataModule.BankCSVTempTableDB.Edit;
      for line := 0 to ImportFile.count-1 do
         begin
            RecordString := ImportFile.Strings[line];
            CSVLineCount := CSVLineCount + 1;

            if CSVLineCount > HeaderLines then
               begin
                  i := 1;

                  TransactionHash := AccsDataModule.NewTransactionHash(RecordString);
                  if ( AccsDataModule.TransactionHashExists(TransactionHash) ) then Continue;

                  AccsDataModule.BankCSVTempTableDB.Append;

                  AccsDataModule.BankCSVTempTableDB['Import'] := True;

                  AccsDataModule.BankCSVTempTableDB['Analysis'] := '0';
                  AccsDataModule.BankCSVTempTableDB['IsMultiLineTransaction'] := False;
                  AccsDataModule.BankCSVTempTableDB['Hash'] := TransactionHash;
                  AccsDataModule.BankCSVTempTableDB['IsSplitTransaction'] := False;

                  // need to parse the line into correct columns
                  while i < FieldCount do
                     begin
                        Application.ProcessMessages;
                         if pos('"',RecordString) = 1 then
                            begin
                               RecordString := copy(RecordString,2,length(RecordString));

                               if pos('"',RecordString) > 0 then
                                  begin
                                     parameter := copy(RecordString,1,pos('"',RecordString)-1);
                                     if parameter <> '' then WriteToTable(i,Parameter);

                                     if (pos('"',RecordString)+2 < length(RecordString)) then
                                        RecordString := copy(RecordString,pos('"',RecordString)+2,length(RecordString))
                                     else
                                        RecordString := '';
                                  end;
                               i := i + 1; //next record
                            end
                         else
                            begin
                               if pos(Delimiter,RecordString) > 0 then
                                  begin
                                     parameter := copy(RecordString,1,pos(Delimiter,RecordString)-1);
                                     if parameter <> '' then
                                        WriteToTable(i,Parameter);

                                     RecordString := copy(RecordString,pos(Delimiter,RecordString)+1,length(RecordString));

                                  end;

                               i := i + 1; //next record
                               if ((pos(Delimiter,RecordString) = 0) and (length(RecordString) > 0)) then
                                  begin
                                     parameter := RecordString;

                                     if parameter <> '' then
                                        WriteToTable(i,Parameter);
                                     RecordString := '';
                                  end;
                             end;
                     end;

                  //   02/03/20 [V4.5 R1.7] /MK Change - Don't default Vat to "Z" for Vat module users - George (TGM) request.
                  if ( cash11.XUse_Vat ) then
                     AccsDataModule.BankCSVTempTableDB['VATCode'] := 'Z';

                  if ( cash11.xuse_inc_exp = true ) or ( (cash11.xuse_inc_exp = false) and (cash1.xcashbook = false) ) then
                     begin
                        if ( Length(AccsDataModule.BankCSVTempTableDB.FieldByName('TransactionType').AsString) = 0 ) then
                          AccsDataModule.BankCSVTempTableDB['TransactionType'] := ''
                     end
                  else
                     AccsDataModule.BankCSVTempTableDB['TransactionType'] := cCashbook;

                  AccsDataModule.BankCSVTempTableDB['OriginalAmount'] := AccsDataModule.BankCSVTempTableDB['Amount'];

                  AccsDataModule.BankCSVTempTableDB.Post;
               end;
         end;

      // 23/07/19 [V4.4 R1.0] /MK Change - No need to do a second loop through the grid to allocate stored nominals as stored nominals are being assigned when transactions are imported from file.
      // Allocate saved nominals to grid.
      // AllocateStoredSelectionToGrid;

      CheckInitSelectDeSelectAll;

   finally
      FreeAndNil(ImportFile);
      AccsDataModule.BankCSVTempTableDB.First;
      //BankImportGridTableView.ApplyBestFit( BankImportGridTableViewDetails );
      StatusBar.Panels[0].Text := Format('%d transactions imported from %s',[AccsDataModule.BankCSVTempTableDB.RecordCount, teFileToImport.Text]);
   end;
end;

procedure TfmBankImport.LoadBankByListing;
begin
   lBankAccountName.Caption := '';
   NewListBox.ListIt ( nil, Banks, 'N' );
   if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
      begin
         teBankAccount.Text := NewListBox.ListInfo.ReturnValue;
         LoadBankDetails();
      end;
end;

procedure TfmBankImport.SetupScreen;
begin
   Height := 685;

   BrowseLabel.Visible := not FAutoLoadTransFile;
   teFileToImport.Visible := not FAutoLoadTransFile;
   btnSelectImportFile.Visible := not FAutoLoadTransFile;

   SourceBankLabel.Visible := not FAutoLoadTransFile;
   cmboBankFileFormat.Visible := not FAutoLoadTransFile;

   Instructions.Visible := false;

   if (cash11.xuse_inc_exp = true) or ((cash11.xuse_inc_exp = false) and (cash1.xcashbook = false)) then
      begin
         BankImportGridTableViewTransactionType.Visible := true;
         gbTransactionLegend.Visible := True; //Instructions.Visible := true;
      end
   else
      begin
         BankImportGridTableViewTransactionType.Visible := False;
         height := height - 55;
         gbTransactionLegend.Visible := False;
      end;

   Instructions.Caption := 'Tx Types              Cash Sale/Purch   - Cash Sale / Cash Purchase';
   Instructions.Caption := Instructions.Caption + #10#13 + '                      Receipt / Payment   - Customer Receipt / Supplier Payment';
   Instructions.Caption := Instructions.Caption + #10#13 + '                      DD / DC / SO        - Direct Debit / Direct Credit / Standing Order';

   erTransactionTypes.Properties.Items.Clear;
   erTransactionTypes.Properties.Items.Add(cCashSalePurch);
   erTransactionTypes.Properties.Items.Add(cPayReceipt);
   erTransactionTypes.Properties.Items.Add(cSODCDD);
   erTransactionTypes.Properties.Items.Add(cBankTransfer);

   //   15/01/19 [V4.3 R4.1] /MK Change - Cashbook Income/Expenditure legend item should only appear if Ledger with Cashbook is enabled.
   lLegCashbookHead.Visible := ( (cash11.xuse_inc_exp = false) and (cash1.xcashbook = false) );
   lLegCashbookDetail.Visible := lLegCashbookHead.Visible;
   if ( lLegCashbookHead.Visible ) then
      begin
         erTransactionTypes.Properties.Items.Add(cCashbook);
         Instructions.Caption := Instructions.Caption + #10#13 + '                      Cashbook       - Cashbook Income / Expenditure';
         lLegCashbookHead.Visible := True;
         lLegCashbookDetail.Visible := True;
      end;

   BankImportGridTableViewVATCode.Visible := FUsingVAT;
   if ( AccsSystem.SystemType = stCashbook ) then
       begin
          BankImportGridTableViewAnalysis.Visible := Preferences.ValueAsBoolean[cPref_ShowAnalysisCodeColumn];
          BankImportGridTableViewQuantity.Visible := Preferences.ValueAsBoolean[cPref_ShowQuantityColumn];
          BankImportGridTableViewCustSuppName.Visible :=
              Preferences.ValueAsBoolean[cPref_ShowCustomerColumn] or Preferences.ValueAsBoolean[cPref_ShowSupplierColumn];
          BankImportGridTableViewStubNumber.Visible := Preferences.ValueAsBoolean[cPref_ShowStubNoColumn];
       end;

   FTransactionsPosted := False;

   BankImportGridTableViewExtraDetail1.Visible := ( ExtraDetail1Col > 0 );
   BankImportGridTableViewExtraDetail1.Hidden := ( not(BankImportGridTableViewExtraDetail1.Visible) );
   BankImportGridTableViewExtraDetail2.Visible := ( ExtraDetail2Col > 0 );
   BankImportGridTableViewExtraDetail2.Hidden := ( not(BankImportGridTableViewExtraDetail2.Visible) );

   //   04/01/19 [V4.3 R4.0] /MK Additional Feature - Only show new discount column if Ledger system.
   BankImportGridTableViewDiscount.Visible := ( AccsSystem.SystemType = stLedger );

   SetupWidthOfForm;
end;

procedure TfmBankImport.teBankAccountDblClick(Sender: TObject);
begin
   actSelectBank.Execute;
end;

procedure TfmBankImport.teBankAccountExit(Sender: TObject);
begin
   LoadBankDetails;
end;

procedure TfmBankImport.teBankAccountKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if Key = VK_F2 then
      begin
         LoadBankByListing();
         Key := 0;
      end;
end;

procedure TfmBankImport.teBankAccountPropertiesChange(Sender: TObject);
begin
   lBankAccountName.Caption := '';
end;

procedure TfmBankImport.FormActivate(Sender: TObject);
begin
   OnActivate := nil;
   if FAutoLoadTransFile then
      ImportTransactions();
end;

procedure TfmBankImport.ReadCSVSettings;
begin
   // Read default parameters
   DateCol := 0;
   DetailCol := 0;
   ExtraDetail1Col := 0;
   ExtraDetail2Col := 0;
   DebitCol := 0;
   CreditCol := 0;
   DebCredIndicCol := 0;
   AllDebCredIncicCol := False;
   Delimiter := ',';
   ChequeIdentifier := '';
   LodgementIdentifier := '';
   HeaderLines := 0;
   FieldCount := 0;
   SingleAmountColumn := False;

   if ( Trim(cmboBankFileFormat.Text) = '' ) then
      begin
         MessageDlg('You must select the source of the bank import file',mtWarning,[mbOK],0);
         if cmboBankFileFormat.Visible then
            begin
               cmboBankFileFormat.SetFocus;
               cmboBankFileFormat.DroppedDown := True;
            end;
         teFileToImport.Text := '<Select Location of Bank File>';
         Abort;
      end;

   Accsdatamodule.BankCSVDefaultsDB.Locate('ID',cmboBankFileFormat.EditValue,[]);

   DateCol := Accsdatamodule.BankCSVDefaultsDB['DateFieldNo'];
   DetailCol := Accsdatamodule.BankCSVDefaultsDB['DetailFieldNo'];

   try
      ExtraDetail1Col := Accsdatamodule.BankCSVDefaultsDB['ExtraDetailField1No'];
   except
      ExtraDetail1Col := 0;
   end;

   try
      ExtraDetail2Col := Accsdatamodule.BankCSVDefaultsDB['ExtraDetailField2No'];
   except
      ExtraDetail2Col := 0;
   end;

   DebitCol := Accsdatamodule.BankCSVDefaultsDB['DebitFieldNo'];

   try
      CreditCol := Accsdatamodule.BankCSVDefaultsDB['CreditFieldNo'];
   except
      CreditCol := 0;
   end;

   if CreditCol = 0 then SingleAmountColumn := True;

   try
      DebCredIndicCol := AccsDataModule.BankCSVDefaultsDB.FieldByName('DebCredIndicCol').AsInteger;
   except
      DebCredIndicCol := 0;
   end;

   try
      AllDebCredIncicCol := AccsDataModule.BankCSVDefaultsDB.FieldByName('AllowDebCredIndicCol').AsBoolean;
   except
      AllDebCredIncicCol := False;
   end;

   HeaderLines := Accsdatamodule.BankCSVDefaultsDB['HeaderLines'];
   try
      FieldCount := Accsdatamodule.BankCSVDefaultsDB['FieldCount'];     // function not enabled
   except
      FieldCount := 25;    // used as count of data items in csv to be used to limit loop time
   end;

   if Accsdatamodule.BankCSVDefaultsDB['Delimiter'] <> '' then
      Delimiter := Accsdatamodule.BankCSVDefaultsDB['Delimiter'];
   if Accsdatamodule.BankCSVDefaultsDB['ChequeIdentifier'] <> '' then
      ChequeIdentifier := Accsdatamodule.BankCSVDefaultsDB['ChequeIdentifier'];
   if Accsdatamodule.BankCSVDefaultsDB['LodgementIdentifier'] <> '' then
      LodgementIdentifier := Accsdatamodule.BankCSVDefaultsDB['LodgementIdentifier'];
end;

procedure TfmBankImport.WriteToTable(ItemCount: integer; Value: shortstring);
var
   TempStr : Shortstring;
   TempReal : Real;
   i : integer;
   StubNo : string;
   CheckDate : ShortString;
   DateBefore : Boolean;
   sYear,
   sMonth,
   sDay : String;
   sDebCredIndic : String;
begin
   if ( ItemCount = DateCol ) then
      begin
         Slimall(Value);

         // Northern Bank as . in date not /
         for i:= 1 to length(Value) do
            begin
                if ( Value[i] = '.' ) then
                   Value[i] := '/';
            end;

         //   28/03/19 [V4.3 R4.5] /MK Change - HSBC bank use a ShortNameMonth e.g. JAN, FEB etc, as part of the date.
         //                                     Check to see if this exists and use function to derive date from it.
         if ( MonthIsShortName(Value) ) then
            AccsDataModule.BankCSVTempTableDB.FieldByName('TxDate').AsDateTime := GetShortMonthNameDate(Value)
         //   23/12/19 [V4.5 R1.6] /MK Change - Allow for "java simpledateformat" value to be converted to date - Shane Chambers.
         else if ( Pos('-',Value) > 0 ) and ( Pos('T',Value) > 0 ) then
            AccsDataModule.BankCSVTempTableDB.FieldByName('TxDate').AsDateTime := StrToDate(GetDateFromCommaSpacedString(Copy(Value,0,Pos('T',Value))))
         else
            AccsDataModule.BankCSVTempTableDB.FieldByName('TxDate').AsDateTime := StrToDate(Value);

         //   19/11/18 [V4.3 R2.8] /MK Change - Default the Import boolean to false if date on bank file is outside financial year.
         CheckDate := DateToStr(AccsDataModule.BankCSVTempTableDB.FieldByName('TxDate').AsDateTime);
         AccsDataModule.BankCSVTempTableDB.FieldByName('Import').AsBoolean := CheckDateRange(CheckDate, False, DateBefore, False);
      end;

   if ( ItemCount = DetailCol ) then
      begin
         // Identify any Stub Number
         if ( pos(ChequeIdentifier,Value) > 0 ) then
            begin
               // SP New Cheque Stub extraction util
               StubNo := AccsDataModule.ExtractStubFromBankDetailLine(ChequeIdentifier);
               if ( StubNo <> '' ) then
                  begin
                     AccsDataModule.BankCSVTempTableDB['StubNumber'] := StubNo;
                     AccsDataModule.BankCSVTempTableDB['Details'] := StringReplace(ChequeIdentifier, StubNo, '', [rfReplaceAll, rfIgnoreCase]);
                  end
               else
                  begin
                     AccsDataModule.BankCSVTempTableDB['Details'] := ChequeIdentifier;
                     TempStr := copy(Value,pos(ChequeIdentifier,Value)+length(ChequeIdentifier),length(Value));
                     Slimall(TempStr);
                     AccsDataModule.BankCSVTempTableDB['StubNumber'] := TempStr;
                  end;
            end
         else
            begin
               if ( pos(LodgementIdentifier,Value) > 0 ) then
                  begin
                     // SP New Cheque Stub extraction util
                     StubNo := AccsDataModule.ExtractStubFromBankDetailLine(LodgementIdentifier);
                     if ( StubNo <> '' ) then
                        begin
                           AccsDataModule.BankCSVTempTableDB['StubNumber'] := StubNo;
                           AccsDataModule.BankCSVTempTableDB['Details'] := Trim(StringReplace(LodgementIdentifier, StubNo, '', [rfReplaceAll, rfIgnoreCase]));
                        end
                     else
                        begin
                           AccsDataModule.BankCSVTempTableDB['Details'] := Trim(LodgementIdentifier);
                           TempStr := copy(Value,pos(LodgementIdentifier,Value)+length(LodgementIdentifier),length(Value));
                           Slimall(TempStr);
                           AccsDataModule.BankCSVTempTableDB['StubNumber'] := TempStr;
                        end;
                  end
               else
                  begin
                     Slimall(Value);
                     // SP New Cheque Stub extraction util
                     StubNo := AccsDataModule.ExtractStubFromBankDetailLine(Value);
                     if (StubNo<>'') then
                        begin
                           AccsDataModule.BankCSVTempTableDB['StubNumber'] := StubNo;
                           AccsDataModule.BankCSVTempTableDB['Details'] := Trim(StringReplace(Value, StubNo, '', [rfReplaceAll, rfIgnoreCase]));
                        end
                     else
                        AccsDataModule.BankCSVTempTableDB['Details'] := Trim(Value);
                  end;
            end;

         //   23/07/19 [V4.4 R1.0] /MK Additional Feature - Assign Nominal/Enterprise to line if Detail text exists in BankImportNLStore.
         AssignNomDetailFromStore;
      end;

   if ( ItemCount = ExtraDetail1Col ) then
      begin
         Slimall(Value);
         AccsDataModule.BankCSVTempTableDB['Details1'] := Trim(Value);
      end;

   if ( ItemCount = ExtraDetail2Col ) then
      begin
         Slimall(Value);
         AccsDataModule.BankCSVTempTableDB['Details2'] := Trim(Value);
      end;

   if ItemCount = DebitCol then
      begin
         Value := RemoveNonNumeric(Value);
         if SingleAmountColumn then
            begin
               if length(Value) > 0 then
                  begin
                     if Value[1] = '-' then
                        begin
                           Value := copy(Value,2,length(Value)-1);
                           try
                              TempReal := StrToFloat(Value);
                              AccsDataModule.BankCSVTempTableDB['Expenditure'] := TempReal;
                              AccsDataModule.BankCSVTempTableDB.FieldByName('Amount').AsFloat := TempReal;
                              AccsDataModule.BankCSVTempTableDB.FieldByName('IncomeOrExpense').AsString := cExpense;
                           except
                           end;
                        end
                     else
                        begin
                           if Value[1] = '+' then
                              Value := copy(Value,2,length(Value)-1);

                           try
                               TempReal := StrToFloat(Value);
                               AccsDataModule.BankCSVTempTableDB['Income'] := TempReal;
                               AccsDataModule.BankCSVTempTableDB['Amount'] := TempReal;
                               AccsDataModule.BankCSVTempTableDB.FieldByName('IncomeOrExpense').AsString := cIncome;
                           except
                           end;
                        end;
                  end;
            end
         else
            begin // SingleAmountColumn

               try
                   TempReal := StrToFloat(Value);

                   AccsDataModule.BankCSVTempTableDB['Expenditure'] := TempReal;

                   // SP 28/07/2015

                   // During an import of an Ulster Bank file for Joe & Elizabeth McKean 6397
                   // we came across a problem where the debit amount was actually prefixed
                   // with a negative symbol. The program was expecting a positive amount.
                   // To counteract this, we need to convert the negative amount to positive.

                   if (TempReal < 0) then
                      AccsDataModule.BankCSVTempTableDB['Amount'] := TempReal * -1
                   else
                      AccsDataModule.BankCSVTempTableDB['Amount'] := TempReal;

                   AccsDataModule.BankCSVTempTableDB.FieldByName('IncomeOrExpense').AsString := cExpense;
               except
               end;
         end;
      end;

   if ItemCount = CreditCol then
      begin
         Value := RemoveNonNumeric(Value);
         try
             TempReal := StrToFloat(Value);
             AccsDataModule.BankCSVTempTableDB['Income'] := TempReal;
             AccsDataModule.BankCSVTempTableDB['Amount'] := TempReal;
             AccsDataModule.BankCSVTempTableDB.FieldByName('IncomeOrExpense').AsString := cIncome;
         except
         end;
      end;

   if ( ItemCount = DebCredIndicCol ) and ( (AllDebCredIncicCol) and (DebCredIndicCol > 0) ) then
      begin
         if ( UpperCase(Value) = 'CREDIT' ) then
            AccsDataModule.BankCSVTempTableDB.FieldByName('IncomeOrExpense').AsString := cIncome
         else if ( UpperCase(Value) = 'DEBIT' ) then
            AccsDataModule.BankCSVTempTableDB.FieldByName('IncomeOrExpense').AsString := cExpense;
      end;
end;

procedure TfmBankImport.FormDestroy(Sender: TObject);
begin
   SysUtils.ShortDateFormat := FWinShortDateStyle;

   AccsDataModule.BankCSVTempTableDB.Close;
   AccsDataModule.BankCSVTempTableDB.EmptyTable;
   AccsDataModule.BankCSVDetailTempTableDB.Close;
   AccsDataModule.BankCSVDetailTempTableDB.EmptyTable;
   if (BankMultiLineTransEditForm <> nil) then
      FreeAndNil(BankMultiLineTransEditForm);

   NOTIFY_TRANSACTION_WRITE_SUCCESS := True;
   PREVENT_TRANSACTIONGRID_LOADING_ON_TRANSACTION_WRITE := False;
end;

procedure TfmBankImport.SaveTransactions;
var
  PCount : integer;
  i : integer;
  DateString, DescString, StubString, CommentString,
  NomString, EntString, VATCode, VATString, CustSuppName, CustSupp, TempStr, TxType : shortstring;
  AmountString, DiscountString : shortstring;
  StubNo, AnalysisCode : integer;
  Expend, Income, Amount, Discount : real;
  NomCode, VATArrPos : integer;
  VATAmt, NomAmt : long;
  IsExclusive : boolean;
  LineNum : Integer;
  Quantity : real;
  TransactionSkipped : Boolean;
begin
   ValidateTransactions();
   TransactionSkipped := False;
   try
        For PCount := 1 To MaxTx Do
             New ( TxHold[PCount] );
        For PCount := 1 To MaxNom Do
             New ( NomHold[PCount] );
         { Initialise the Pointer Variable }
        For PCount := 1 To MaxTx Do
             FillChar ( TxHold[PCount]^, SizeOf(TxHold[PCount]^),chr(0));
        For PCount := 1 To MaxNom Do
             FillChar ( NomHold[PCount]^, SizeOf(NomHold[PCount]^),chr(0));

        BankImportGridTableView.DataController.BeginFullUpdate;

        AccsDataModule.BankCSVTempTableDB.first;

        for i := 1 to AccsDatamodule.BankCSVTempTableDB.recordcount do begin

        if AccsDataModule.BankCSVTempTableDB.FieldByName('Import').AsBoolean then begin

        Initvals;

        if (AccsDataModule.BankCSVDetailTempTableDB.RecordCount = 0) then
           begin
              // create a dummy line and fill the required fields e.g. Nominal Account, Amount filled etc.
              AccsDataModule.BankCSVDetailTempTableDB.Append;

              AccsDataModule.BankCSVDetailTempTableDB.FieldByName('NomCode').AsInteger :=
                 AccsDatamodule.BankCSVTempTableDB.FieldByName('NomCode').AsInteger;

              AccsDataModule.BankCSVDetailTempTableDB.FieldByName('Enterprise').AsString :=
                 AccsDatamodule.BankCSVTempTableDB.FieldByName('Enterprise').AsString;

              AccsDataModule.BankCSVDetailTempTableDB.FieldByName('Amount').AsFloat :=
                 AccsDatamodule.BankCSVTempTableDB.FieldByName('Amount').AsFloat;

              AccsDataModule.BankCSVDetailTempTableDB.FieldByName('Analysis').AsInteger :=
                 AccsDatamodule.BankCSVTempTableDB.FieldByName('Analysis').AsInteger;

              AccsDataModule.BankCSVDetailTempTableDB.FieldByName('VATCode').AsString :=
                 AccsDatamodule.BankCSVTempTableDB.FieldByName('VATCode').AsString;

              AccsDataModule.BankCSVDetailTempTableDB.FieldByName('Quantity1').AsFloat :=
                 AccsDatamodule.BankCSVTempTableDB.FieldByName('Quantity1').AsFloat;

              AccsDataModule.BankCSVDetailTempTableDB.Post;
           end;

        LineNum := 1;
        while not AccsDatamodule.BankCSVDetailTempTableDB.Eof do
           begin
              DateString   := '';
              DescString   := '';
              StubString   := '';
              AmountString := '';
              DiscountString := '';
              EntString    := '';
              NomString    := '';
              VATString    := '';
              CustSupp     := '';
              CustSuppName := '';
              TxType       := '';
              Expend       := 0;
              Income       := 0;
              VATAmt       := 0;
              NomAmt       := 0;
              AnalysisCode := 0;

              // SP 14/01/2016
              CommentString := '';

              DateString := AccsDatamodule.BankCSVTempTableDB.FieldByName('TxDate').AsString;

              // SP 14/01/2016 - Modification - Mary Ryan (6951)/GL - Check ChangeLog.txt
              if Preferences.ValueAsBoolean[cPref_AllowFreeTextForNominalDescriptionColumn] then
                 begin
                    //   23/11/18 [V4.3 R2.9] /MK Change - If the multi line has the NomName i.e used Free Text Nominal preference, then change DescString.
                    if ( Length(AccsDataModule.BankCSVDetailTempTableDB.FieldByName('NomName').AsString) > 0 ) then
                       DescString := Trim(AccsDataModule.BankCSVDetailTempTableDB.FieldByName('NomName').AsString)
                    else
                       DescString := Trim(AccsDatamodule.BankCSVTempTableDB.FieldByName('Details').AsString);
                    // SP 29/07/2015
                    // If the description is empty, default to the nominal account name
                    if (Trim(DescString) = '') then
                       DescString := Trim(AccsDatamodule.BankCSVTempTableDB.FieldByName('NomName').AsString)
                 end
              else
                 begin
                    //   27/08/19 [V4.5 R0.3] /MK Bug Fix - As BankCSVDetailTempTableDB("NomName") always has the nominal name even if single line then use this instead of BankCSVTempTableDB("NomName")
                    //   11/01/21 [V4.5 R4.8] /MK Bug Fix - Check to see if the BankCSVDetailTempTableDB.NomName field has a value, if not then use BankCSVTempTableDB.NomName.
                    if ( Length(AccsDataModule.BankCSVDetailTempTableDB.FieldByName('NomName').AsString) > 0 ) then
                       DescString := Trim(AccsDataModule.BankCSVDetailTempTableDB.FieldByName('NomName').AsString)
                    else
                       DescString := Trim(AccsDatamodule.BankCSVTempTableDB.FieldByName('NomName').AsString);
                    CommentString := Trim(AccsDatamodule.BankCSVTempTableDB.FieldByName('Details').AsString);
                 end;

              StubString := AccsDatamodule.BankCSVTempTableDB.FieldByName('StubNumber').AsString;

              EntString := AccsDatamodule.BankCSVDetailTempTableDB.FieldByName('Enterprise').AsString;
              NomString := AccsDatamodule.BankCSVDetailTempTableDB.FieldByName('NomCode').AsString;

              VATCode := AccsDatamodule.BankCSVDetailTempTableDB.FieldByName('VATCode').AsString;

              CustSupp := AccsDatamodule.BankCSVTempTableDB.FieldByName('CustSupp').AsString;
              CustSuppName := AccsDatamodule.BankCSVTempTableDB.FieldByName('CustSuppName').AsString;

              TxType := AccsDatamodule.BankCSVTempTableDB.FieldByName('TransactionType').AsString;
              try
                  AnalysisCode := AccsDatamodule.BankCSVDetailTempTableDB.FieldByName('Analysis').AsInteger;
              except
                  AnalysisCode := 0;
              end;

              Amount := AccsDatamodule.BankCSVDetailTempTableDB.FieldByName('Amount').AsFloat;
              DoubletoStr((Amount*100), AmountString , '%8.2f', True, True, 8, True);
              SlimAll(AmountString);
              if AmountString = '0' then AmountString := '';
              if AmountString = '0.00' then AmountString := '';

              //   04/01/19 [V4.3 R3.0] /MK Additional Feature - Added variables to store the discount for the payment / receipt.
              Discount := AccsDatamodule.BankCSVTempTableDB.FieldByName('Discount').AsFloat;
              DoubletoStr((Discount*100), DiscountString , '%8.2f', True, True, 8, True);
              SlimAll(DiscountString);
              if DiscountString = '0' then DiscountString := '';
              if DiscountString = '0.00' then DiscountString := '';

              if VATString = '0' then VATString := '';
              if VATString = '0.00' then VATString := '';

              if (AccsSystem.SystemType <> stLedger) then
                 begin
                    // SP 14/01/2016
                    if Length(CommentString)>0 then
                       ZRef[1] := CommentString;
                 end;

              if TxType = cCashbook then
                 begin
                    if (IsIncomeOrExpense = ttExpense) then
                       prog := cashexp
                    else
                       prog := cashinc;
                   Act := 0;
                 end;

              if TxType = cCashSalePurch then
                 begin
                    if (IsIncomeOrExpense = ttExpense) then
                       prog := PurchTx
                    else
                       prog := SalesTx;
                    Act := 2;
                 end;

              if TxType = cPayReceipt then
                 begin
                    if (IsIncomeOrExpense = ttExpense) then
                       prog := PurchTx
                    else
                       prog := SalesTx;
                    Act := 3;
                 end;

              if TxType = cSODCDD then
                 begin
                    {
                    if (IsIncomeOrExpense = ttExpense) then
                       begin
                          Act := 1;
                          ZRef[1] := 'DD';
                       end
                    else
                       begin
                          Act := 2;
                          ZRef[1] := 'DC';
                       end;
                    Prog := Journal;
                    }
                    if (IsIncomeOrExpense = ttExpense) then
                       begin
                          prog := cashexp;
                          ZRef[1] := 'DD / SO';
                       end
                    else
                       begin
                          prog := cashinc;
                          ZRef[1] := 'DC / SO';
                       end;
                    Act := 1;
                 end;

              {
              if TxType = 'S Order' then
                 begin
                    if (IsIncomeOrExpense = ttExpense) then
                       prog := cashexp
                    else
                       prog := cashinc;
                    Act := 1;
                    ZRef[1] := 'S Order';
                 end;
              }

              if ( TxType = cBankTransfer ) then
                 begin
                    Act := 5;
                    prog := Journal;
                    ZRef[1] := Copy(cBankTransfer,0,8);
                    ZDesc[1,1] := CommentString;
                    zUse[1,1] := True;
                 end;

              // Below code was taken from above - right before the Prog and Act variables where being set.
              // This was necessary because these variables must be set before passing the AmountString
              // into the NegitiveFlag function otherwise contra transactions would not be correctly determined.

              // SP - 22/06/2015 - Handle contra transactions where appropriate
              if (( Length ( AmountString ) > 0) and ( AmountString[1] = '-' )) Then
                 // NegitiveFlag expects a positive number
                 // To satisfy NegitiveFlag logic, we must convert the negative to positive in order to get back a negative

                 // Example: string value to input 100.00
                 // Returns: string value 100.00-
                 // Example: string value to input 100.00
                 // Returns: string value 100.00
                 AmountString := NewListBox.NegitiveFlag ( NomString, Copy(AmountString, 2, MaxInt)); // omit the negative flag

              slimall(VATCode);
              if ((VATCode <> 'Z') and ( NewListBox.CheckVAT ( VATCode, VATArrPos ))) then
                 begin
                    StrLong(AmountString,NomAmt);
                    NewListBox.CalcTax ( VATArrpos, TempStr, VatAmt, NomAmt, IsExclusive );
                    LongStr(VatAmt,VATString,'L');
                    Slimall(VATString);
                    StrLong(AmountString,NomAmt);

                    //   20/01/22 [V4.5 R6.5] /MK Bug Fix - If VatCode selected IsExclusive then transaction amount should be Amount plus VatAmount.
                    if IsExclusive then
                       NomAmt := NomAmt + VatAmt
                    else
                       NomAmt := NomAmt - VatAmt;

                    LongStr(NomAmt,AmountString,'L');
                    Slimall(AmountString);
                 end;
              // SP - 22/06/2015 - End

              if ((CustSupp <> '') and (CustSupp <> '0')) then begin
                  slimall(CustSupp);
                  ZAccount[1] := StrtoInt(CustSupp);
                  ZComm[1] := CustSuppName;
              end;

              If ((Prog = PurchTx) or (Prog = SalesTX)) then ZCustRec[1] := ZAccount[1];

              ZBank[1] := StrToInt(teBankAccount.text);
              Cash1.XLASTBANK := StrToInt(teBankAccount.text);
              DateString := FormatDateTime('dd/mm/yy',StrToDateTime(DateString));
              ZTxDate[1] := KDateToInt(DateString);
              ZStub[1] := 0;
              if StubString <> '' then ZStub[1] := strtoint(StubString);
              zUse[1,LineNum] := True;
              ZTax[1,LineNum] := VATCode;  // was 'Z'
              if cash11.Xuse_enterprise = false then zEnt[1,LineNum] := EntString;

              if ( not(TxType = cPayReceipt) ) then
                 zGen[1,LineNum] := StrToInt(NomString);
              ZDesc[1,LineNum] := '               ';                            // Ch020
              zDesc[1,LineNum] := DescString;

              //    StrLong ( '1.00', ZQty[1,1] );
              Quantity := AccsDatamodule.BankCSVDetailTempTableDB.FieldByName('Quantity1').AsFloat;
              if (Quantity>0) then
                 begin
                    TempStr := FormatFloat(cDefaultCurrencyFormat, Quantity);
                    StrLong(TempStr,ZQty[1,LineNum]);
                 end;
              Quantity := AccsDatamodule.BankCSVDetailTempTableDB.FieldByName('Quantity2').AsFloat;
              if (Quantity>0) then
                 begin
                    TempStr := FormatFloat(cDefaultCurrencyFormat, Quantity);
                    StrLong(TempStr,ZQty2[1,LineNum]);
                 end;
              Quantity := AccsDatamodule.BankCSVDetailTempTableDB.FieldByName('Quantity3').AsFloat;
              if (Quantity>0) then
                 begin
                    TempStr := FormatFloat(cDefaultCurrencyFormat, Quantity);
                    StrLong(TempStr,ZQty3[1,LineNum]);
                 end;

              zAnalysis[1,LineNum] := AnalysisCode;

              Case PROG Of
                CASHINC : Begin
                            SalesPurchDB := 0;
                            StrLong(AmountString,ZAmt[1,LineNum]);
                          End;
                CASHEXP : Begin
                            SalesPurchDB := 0;
                            StrLong(AmountString,ZAmt[1,LineNum]);
                          End;
                SALESTX : Begin
                            SalesPurchDB := SlFile;
                            StrLong(AmountString,ZAmt[1,LineNum]);
                            //   04/01/19 [V4.3 R3.0] /MK Additional Feature - Take discount and save to receipt.
                            StrLong(DiscountString,zDiscount[1]);
                            if act = 3 then begin      // Payment does not have a VAT element
                                                  ZAmt[1,LineNum] := ZAmt[1,LineNum] + ZTAXAMT[1,LineNum];
                                                  ZTAXAMT[1,LineNum] := 0;
                                             end;
                          End;
                PURCHTX : Begin
                            SalesPurchDB := PlFile;
                            StrLong(AmountString,ZAmt[1,LineNum]);
                            //   04/01/19 [V4.3 R3.0] /MK Additional Feature - Take discount and save to payment.
                            StrLong(DiscountString,zDiscount[1]);
                            if act = 3 then begin      // Receipt does not have a VAT element
                                                  ZAmt[1,LineNum] := ZAmt[1,LineNum] + ZTAXAMT[1,LineNum];
                                                  ZTAXAMT[1,LineNum] := 0;
                                             end;
                          End;
                JOURNAL : Begin
                             StrLong(AmountString,ZAmt[1,LineNum]);
                             ZAmt[1,LineNum] := ZAmt[1,LineNum] + ZTAXAMT[1,LineNum];
                             ZTAXAMT[1,LineNum] := 0;
                             if ( Act = 5 ) then
                                begin
                                   if ( AccsDataModule.BankCSVTempTableDB.FieldByName('IncomeOrExpense').AsString = cExpense ) then
                                      begin
                                         Zbank[1] := StrToInt(teBankAccount.Text);
                                         zbank2[1] := StrToInt(NomString);
                                      end
                                   else
                                      begin
                                         Zbank[1] := StrToInt(NomString);
                                         zbank2[1] := StrToInt(teBankAccount.Text);
                                      end;
                                end;
                          end;
              End;

              try  StrLong(VATString,ZTAXAMT[1,LineNum]);
              except
              end;

              ZTOTAMT[1] := ZAmt[1,LineNum];
              ZTOTTAX[1] := ZTAXAMT[1,LineNum];

              LineNum := LineNum+1;
              AccsDataModule.BankCSVDetailTempTableDB.next;
           end; // while not (BankCSVDetailTempTableDB.eof)

           CheckEnd;

           WriteTransactions( 1, SalesPurchDB, 0, FALSE );
           AccsDataModule.StoreTransactionHash(AccsDataModule.BankCSVTempTableDB['Hash']);
        end // if import = true;
        else
           begin
              TransactionSkipped := True;
           end;

        AccsDataModule.BankCSVTempTableDB.next;

        end;  // if i :=.....

      BankImportGridTableView.DataController.EndFullUpdate;

      if (not IsDebugging) and (not TransactionSkipped) then
         begin
            if FileExists(FFileName) then
               DeleteFile(FFileName); // delete file on successful import
         end;

      StatusBar.Panels[0].Text := '';
      FTransactionsPosted := True;

      BankImportGridTableView.DataController.BeginFullUpdate;
      try
         //   22/01/18 [V4.3 R0.2] /MK Additional Feature - Store the Description and Nominal selected by user in new BankImportNLStore table.
         AccsDataModule.BankCSVTempTableDB.First;
         while ( not(AccsDataModule.BankCSVTempTableDB.Eof) ) do
            begin
               if ( AccsDataModule.BankCSVTempTableDB.FieldByName('Import').AsBoolean ) then
                  AccsDataModule.StoreNLAndDescription(AccsDataModule.BankCSVTempTableDB.FieldByName('NomCode').AsInteger,
                                                       StripAllSpaces(AccsDataModule.BankCSVTempTableDB.FieldByName('Details').AsString),
                                                       AccsDatamodule.BankCSVTempTableDB.FieldByName('TransactionType').AsString);
               AccsDataModule.BankCSVTempTableDB.Next;
            end;
      except
         //
      end;

      BankImportGridTableView.DataController.EndFullUpdate;
   except
      on e : Exception do
         raise Exception.Create(e.Message);
   end;
end;

procedure TfmBankImport.actSaveExecute(Sender: TObject);
begin
   SaveTransactions;
   SaveBankDefaults(StrToInt(teBankAccount.text));
   MessageDlg('Selected transactions have been successfully imported.', mtInformation,[mbOK],0);
   Formshow(self);
   TfmReviewFarmFinances.ShowTheForm;
   FMainScreen.LoadTransactionGrid;
   if FAutoLoadTransFile then
      Close
end;

procedure TfmBankImport.actBankFileFormatExecute(Sender: TObject);
begin
   TBankCSVConfigForm.ShowTheForm;
   SetupScreen;
end;

procedure TfmBankImport.LoadBankDefaults(BankAccount: integer);
begin
   AccsDataModule.BankImportDefaultsDB.Open;
   try
      if AccsDataModule.BankImportDefaultsDB.Locate('BankAccount',BankAccount,[]) then
         begin
            cmboBankFileFormat.EditValue := AccsDataModule.BankImportDefaultsDB['DefaultBankFileID'];

            //   23/11/18 [V4.3 R2.9] /MK Change - OpenDialog.InitialDir should be the specified default location of bank link files from drop-down-menu.
            if ( DirectoryExists(AccsDataModule.DefaultStatementDirectory) ) then
               OpenDialog.InitialDir := AccsDataModule.DefaultStatementDirectory
            else if DirectoryExists(AccsDataModule.BankImportDefaultsDB.FieldByName('DefaultPath').AsString) then
               OpenDialog.InitialDir := AccsDataModule.BankImportDefaultsDB.FieldByName('DefaultPath').AsString
         end
      else
         begin
            cmboBankFileFormat.EditValue := Null;
            OpenDialog.InitialDir := 'C:\';
         end;
   finally
      AccsDataModule.BankImportDefaultsDB.Close;
   end;
end;

procedure TfmBankImport.SaveBankDefaults(BankAccount: integer);
begin
    AccsDataModule.BankImportDefaultsDB.Open;
    try
       try
           if AccsDataModule.BankImportDefaultsDB.Locate('BankAccount',BankAccount,[]) then
              AccsDataModule.BankImportDefaultsDB.Edit
           else
              begin
                 AccsDataModule.BankImportDefaultsDB.Append;
                 AccsDataModule.BankImportDefaultsDB['BankAccount'] := BankAccount;
              end;

           AccsDataModule.BankImportDefaultsDB['DefaultBankFileID'] := cmboBankFileFormat.EditValue;
           AccsDataModule.BankImportDefaultsDB['DefaultPath'] := OpenDialog.InitialDir;
           AccsDataModule.BankImportDefaultsDB.Post;

       except
          AccsDataModule.BankImportDefaultsDB.Cancel;
       end;

    finally
       AccsDataModule.BankImportDefaultsDB.Close;
    end;
end;

procedure TfmBankImport.ValidateTransactions;
var
   RecNo : integer;
   ArrPos : Integer;
   AccRange : TAccRange;
   TypeString : string;
   NomCode, EntCode, TxType : ShortString;
   AnalysisString, CustSupplierString : string;
   AnalysisCode : TAnalysisCode;
   DateBefore : Boolean;
   TransactionDateString : shortstring;
   NoOfSelected : Integer;
   bIsLedger : Boolean;
begin
   InitRange ( AccRange );
   AccRange[1] := 1;
   AccRange[2] := Cash1.xNomPrvExp+Cash11.xNo_Of_Partners;
   NoOfSelected := 0;

   if (AccsDataModule.BankCSVTempTableDB.RecordCount = 0) then
      begin
         MessageDlg('There are no transactions to import.',mtWarning,[mbOk],0);
         SysUtils.Abort;
      end;

   bIsLedger := ( cash11.xuse_inc_exp = true ) or ( (cash11.xuse_inc_exp = false) and (cash1.xcashbook = false) );

   AccsDataModule.BankCSVTempTableDB.First;

   while not AccsDataModule.BankCSVTempTableDB.Eof do
      begin
         if not AccsDataModule.BankCSVTempTableDB.FieldByName('Import').AsBoolean then
            begin
               AccsDataModule.BankCSVTempTableDB.Next;
               Continue;
            end;

         Inc(NoOfSelected);

         //   15/01/19 [V4.3 R4.1] /MK Change - Moved Transaction Type check before the date check as this the order the columns take on the grid.
         if bIsLedger then
            if (erTransactionTypes.Properties.Items.IndexOf(AccsDatamodule.BankCSVTempTableDB.FieldByName('TransactionType').AsString) = -1) then
               begin
                  FocusItem( BankImportGridTableViewTransactionType, 'Transaction Type','MUST be specified - see legend at bottom of screen.' );
                  RaiseError('An invalid Transaction Type has been found.');
               end;

         if (AccsDatamodule.BankCSVTempTableDB.FieldByName('TxDate').AsDateTime <= 0) then
            begin
               FocusItem( BankImportGridTableViewTxDate, 'Transaction Date', 'You must specify a transaction date.');
               RaiseError('An invalid transaction date has been found.');
            end
         else
            begin
               // Need to convert the TDateTime back to ShortString so that we can pass it into CheckDateRange call
               TransactionDateString := DateToStr(AccsDatamodule.BankCSVTempTableDB.FieldByName('TxDate').AsDateTime);
               //   26/09/18 [V4.3 R1.4] /MK Change - If transaction being saved is outside of current year the add year start to error message - Rory Crinion.
               if not CheckDateRange(TransactionDateString,false,DateBefore,false) then
                  begin
                     FocusItem( BankImportGridTableViewTxDate, 'Transaction Date', Format('Transaction date must be within the current financial year (Year Start %s).',[AccsDataModule.FinancialYearToStr]));
                     RaiseError(Format('Transaction date must be within the current financial year (Year Start %s).',[AccsDataModule.FinancialYearToStr]));
                  end;
            end;

         if (Length(Trim(AccsDatamodule.BankCSVTempTableDB.FieldByName('StubNumber').AsString)) > 0) then
            begin
               if not IsNumeric(AccsDatamodule.BankCSVTempTableDB.FieldByName('StubNumber').AsString) then
                  begin
                     FocusItem( BankImportGridTableViewStubNumber, 'Stub Number', 'The Stub Number entered is not valid.');
                     RaiseError('Stub number is not valid.');
                  end;
            end;

         //   15/01/19 [V4.3 R4.1] /MK Change - Moved Customer/Supplier check after Stub Number to match order of columns on grid.
         if bIsLedger then
            if ((AccsDatamodule.BankCSVTempTableDB.FieldByName('TransactionType').AsString = cCashSalePurch) or
                ( AccsDatamodule.BankCSVTempTableDB.FieldByName('TransactionType').AsString = cPayReceipt)) then
                begin
                   if (Length(Trim(AccsDatamodule.BankCSVTempTableDB.FieldByName('CustSupp').AsString)) <= 0) then
                      begin
                         FocusItem( BankImportGridTableViewCustSuppName, 'Customer/Supplier','You must specify a valid Customer/Supplier.' );
                         RaiseError('No Customer/Supplier has been found.');
                      end;
                end;

         if (AccsDatamodule.BankCSVDetailTempTableDB.RecordCount = 0) then
            begin
               TxType := AccsDatamodule.BankCSVTempTableDB.FieldByName('TransactionType').AsString;

               if ( Length(Trim(AccsDatamodule.BankCSVTempTableDB.FieldByName('VATCode').AsString)) > 0 ) then
                  begin
                     if not NewListBox.CheckVat(AccsDatamodule.BankCSVTempTableDB.FieldByName('VATCode').AsString, ArrPos ) then
                        begin
                           FocusItem( BankImportGridTableViewVATCode, 'VAT Code', Format('%s is not a valid VAT Code.',
                                 [AccsDatamodule.BankCSVTempTableDB.FieldByName('VATCode').AsString]));

                           RaiseError(Format('%s is not a valid VAT Code.',
                                 [AccsDatamodule.BankCSVTempTableDB.FieldByName('VATCode').AsString]));
                        end;
                  end
               else if ( (not(TxType = cBankTransfer)) and (not(TxType = cPayReceipt)) ) then
                  begin
                     FocusItem( BankImportGridTableViewVATCode, 'VAT Code', 'VAT Code cannot be blank - Enter ''Z'' for zero VAT transactions.');
                     RaiseError('VAT Code cannot be blank - Enter ''Z'' for zero VAT transactions');
                  end;

               if ((AccsDatamodule.BankCSVTempTableDB.FieldByName('Amount').IsNull) or
                   (AccsDatamodule.BankCSVTempTableDB.FieldByName('Amount').AsFloat = 0)) then
                  begin
                     FocusItem( BankImportGridTableViewAmount , 'Amount', 'Please enter a non zero value for the amount column');
                     RaiseError('Please enter a non zero value for the amount column.');
                  end;

               NomCode := AccsDatamodule.BankCSVTempTableDB.FieldByName('NomCode').AsString;
               slimall(NomCode);

               if (TxType <> cPayReceipt) then
                  begin
                     if (NomCode = '') then
                        begin
                           FocusItem( BankImportGridTableViewNominalName , 'Inc./Exp. Account', 'You must specify an Inc./Exp. Account.');
                           RaiseError('You must specify an Inc./Exp. Account.')
                        end
                     else if not NewListBox.CheckNom ( NomCode, AccRange ) then
                        begin
                           FocusItem( BankImportGridTableViewNominalName , 'Inc./Exp. Account', 'You must specify a valid Inc./Exp. Account.');
                           RaiseError(NomCode + ' - Invalid Nominal Code');
                        end;
                  end;

               EntCode := AccsDatamodule.BankCSVTempTableDB.FieldByName('Enterprise').AsString;
               slimall(EntCode);

               if ((EntCode <> '') and not CheckEnt ( EntCode, RecNo )) then
                  begin
                     FocusItem( BankImportGridTableViewEnterprise, 'Enterprise Code', EntCode + ' - Invalid Enterprise Code');
                     RaiseError(EntCode + ' - Invalid Enterprise Code');
                  end;

               AnalysisString := Trim(AccsDatamodule.BankCSVTempTableDB.FieldByName('Analysis').AsString);
               //   24/08/16 [V4.2 R3.6] /MK Bug Fix - Because we default the Analysis to 0, if 0 is not found the transaction was not saved - Stephen Campion.
               if ( (Length(AnalysisString) > 0) and (IsNumeric(AnalysisString)) and (AnalysisString <> '0') ) then
                  begin
                     AnalysisCode := AccsDatamodule.Accounts.AnalysisCodes.GetAnalysisCode(AnalysisString);
                     if (AnalysisCode = nil) then
                        begin
                           FocusItem( BankImportGridTableViewAnalysis, 'Analysis Code', 'The Analysis Code you have entered does not exist.' );
                           RaiseError('The Analysis Code you have entered does not exist.');
                        end;
                  end;
            end;

         AccsDataModule.BankCSVTempTableDB.Next;
      end;

   if (NoOfSelected = 0) then
      begin
         AccsDataModule.BankCSVTempTableDB.First;
         
         MessageDlg('You have not selected any transactions to import.',mtWarning,[mbOk],0);
         SysUtils.Abort;
      end;
end;

procedure TfmBankImport.FormShow(Sender: TObject);
begin
   NOTIFY_TRANSACTION_WRITE_SUCCESS := False;
   PREVENT_TRANSACTIONGRID_LOADING_ON_TRANSACTION_WRITE := True;

   AccsDataModule.BankCSVTempTableDB.Close;
   AccsDataModule.BankCSVDetailTempTableDB.Close;

   if not AccsDataModule.BankCSVDefaultsDB.Active then
      AccsDataModule.BankCSVDefaultsDB.Active := True;

   if (AccsDataModule.BankCSVTempTableDB.Exists) then
       AccsDataModule.BankCSVTempTableDB.DeleteTable;
   if (AccsDataModule.BankCSVDetailTempTableDB.Exists) then
       AccsDataModule.BankCSVDetailTempTableDB.DeleteTable;
   AccsDataModule.CreateBankImportTempTable;
   AccsDataModule.BankCSVTempTableDB.Active := True;
   AccsDataModule.BankCSVDetailTempTableDB.Active := True;
   if FAutoLoadTransFile then
      begin
         teBankAccount.Text := IntToStr(FBankAccount.Id);
         teFileToImport.Text := FFileName;
         cmboBankFileFormat.EditValue := IntToStr(FBankAccount.BankFileFormat);
         gbImportPanel.Height := 134;
         //lTickBoxHelp.Top := gbImportPanel.Height - (lTickBoxHelp.Height +2);
         //TickBoxHelpImage.Top := lTickBoxHelp.Top + 3;
         lBankAccountName.Update;
      end
   else
      begin
         lBankAccountName.caption := '';
         teFileToImport.Text := '<Select Location of Bank File>';
         cmboBankFileFormat.EditValue := System.Null;
         Caption := 'Bank Statement Import';

         teBankAccount.Text := IntToStr(Cash1.xLastBank);
      end;

   if ( not(FTransactionsPosted) ) then
      SetupScreen();

   teBankAccountExit(self);
end;

class procedure TfmBankImport.RunImport(AFileName: string;
  ABankAccount: TBankAccount);
begin
   if (ABankAccount = nil) then
      raise Exception.Create('Invalid Bank argument passed.');

   if not (FileExists(AFileName)) then
      raise Exception.Create('Bank Transaction file does not exist.');

   with TfmBankImport.Create(nil) do
      try
         FFileName := AFileName;
         FBankAccount := ABankAccount;
         FAutoLoadTransFile := True;
         ShowModal;
      finally
         Free;
      end;
end;

function TfmBankImport.RemoveNonNumeric(Value: shortstring): string;
var
    i : integer;
    TempStr : shortstring;
begin
   while pos(',',Value) > 0 do
      begin
         if pos(',',Value) > 0 then
            begin
               TempStr := copy(Value,1,pos(',',Value)-1) + copy(Value,pos(',',Value)+1,length(Value));
               Value := TempStr;
            end;
      end;

   for i := 1 to length(Value) do
      begin
         if not (Value[i] in ['1','2','3','4','5','6','7','8','9','0','.','+','-']) then
            Value[i] := ' ';
      end;

   Slimall(Value);
   Result := Value;
end;

procedure TfmBankImport.teFileToImportClick(Sender: TObject);
begin
   actSelectFile.Execute;
end;

procedure TfmBankImport.actSelectFileExecute(Sender: TObject);
begin
   if (VarIsNull(cmboBankFileFormat.EditValue)) then
      RaiseError('No Source Bank selected - Please select the appropriate Source Bank',true,true)
   else if (OpenDialog.Execute) and (FileExists(OpenDialog.FileName)) then
      begin
         teFileToImport.Text := OpenDialog.FileName;
         actImportTransactions.Execute;
      end;
end;

procedure TfmBankImport.actImportTransactionsExecute(Sender: TObject);
begin
   ImportTransactions();
end;

procedure TfmBankImport.actImportTransactionsUpdate(Sender: TObject);
begin
   actImportTransactions.Enabled := FileExists(teFileToImport.Text);
end;

function TfmBankImport.GetCustSuppInfo(SalesPurchDB,
  RecID: Integer): string;
   Var
      TStr, TempStr : ShortString;
Begin
        SetDb ( SalesPurchDB );
        ReadRec ( SalesPurchDB, RecID );
        If RecActive ( SalesPurchDB ) Then
           Begin
              // Get the Name
              GetItem ( SalesPurchDB, 1 );
              Result := CurrStr;
        end;
end;

procedure TfmBankImport.BankImportGridTableViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_F2 then
      InvokeGridCellSearch();
end;

procedure TfmBankImport.BankImportGridTableViewFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
var
   CustomerSupplierValue : Integer;
   TempStr : string;
   DefaultNominal : Integer;
   TransType : TTransactionType;
   IsMultiLine : Boolean;
begin
  
   if not (AccsDataModule.BankCSVTempTable.State in dsEditModes) then
      AccsDataModule.BankCSVTempTable.Edit;

   if (APrevFocusedItem.VisibleIndex = BankImportGridTableViewCustSuppName.VisibleIndex) then
      begin
         // user has left the Customer/Supplier column.

         // Check if the customer/supplier code has been typed instead of the name.
         // If it has, attempt to lookup the name against the user typed code.
         // NOTE: The code must be numeric

         TempStr := Trim(AccsDataModule.BankCSVTempTableDB.FieldByName('CustSuppName').AsString);
         if IsNumeric(TempStr) then
            begin
               CustomerSupplierValue := StrToInt(TempStr);
               if (IsIncomeOrExpense = ttExpense) then
                  TempStr := GetAccountName(PLFile, CustomerSupplierValue, 1)
               else
                  TempStr := GetAccountName(SLFile, CustomerSupplierValue, 1);

               if ( Trim(TempStr) <> '' ) then
                  begin
                     AccsDataModule.BankCSVTempTableDB.FieldByName('CustSupp').AsInteger := CustomerSupplierValue;
                     AccsDataModule.BankCSVTempTableDB.FieldByName('CustSuppName').AsString := TempStr;
                  end
               else
                  begin
                     AccsDataModule.BankCSVTempTableDB.FieldByName('CustSupp').Clear;
                     AccsDataModule.BankCSVTempTableDB.FieldByName('CustSuppName').Clear;
                     if (IsIncomeOrExpense = ttExpense) then
                        TempStr := 'Supplier'
                     else
                        TempStr := 'Customer';
                     MessageDlg(Format(TempStr +' Account No: [%d] was not found.',[CustomerSupplierValue]),mtWarning,[mbOK],0);
                  end;
            end;

         // SP - 22/06/2015 - Default the nominal from customer/supplier value (where applicable)
         if (AccsDataModule.BankCSVTempTableDB.FieldByName('CustSupp').AsInteger>0) then
            begin
               DefaultNominal := AccsDataModule.GetNominalForSupplierCustomer(
                   AccsDataModule.BankCSVTempTableDB.FieldByName('CustSupp').AsInteger,IsIncomeOrExpense);

               if (DefaultNominal>0) then
                  StoreNominalSelection(DefaultNominal,False);
            end;
      end
   else if (APrevFocusedItem.VisibleIndex = BankImportGridTableViewNominalName.VisibleIndex) then
      begin
         if IsNumeric(AccsDataModule.BankCSVTempTableDB.FieldByName('NomName').AsString) then
            try
               StoreNominalSelection(StrToInt(AccsDataModule.BankCSVTempTableDB.FieldByName('NomName').AsString));
            except
               RaiseError(Format('Unable to find Inc./Exp. Account for entry "%s"', [AccsDataModule.BankCSVTempTableDB.FieldByName('NomCode').AsString]),true,true);
            end;
      end;

   if ( AFocusedItem.VisibleIndex = BankImportGridTableViewCustSuppName.VisibleIndex ) then
      BankImportGrid.PopupMenu := pmRightBtn
   else
      BankImportGrid.PopupMenu := nil;

   if ( APrevFocusedItem.VisibleIndex = BankImportGridTableViewMultiLineEdit.VisibleIndex ) then
      EnableDisableGridControls();
end;

function TfmBankImport.IsIncomeOrExpense : TTransactionType;
begin
   if (AccsDatamodule.BankCSVTempTableDB.FieldByName('IncomeOrExpense').AsString = cExpense) then
      Result := ttExpense
   else
      Result := ttIncome;
end;

procedure TfmBankImport.FindAndPostEnterprise;
begin
   if (cash11.Xuse_enterprise) then Exit;

    // Enterprise Column
   NewListBox.ListIt ( nil, Enterprise, 'E' );
   if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
      begin
         AccsDatamodule.BankCSVTempTableDB.Edit;
         AccsDatamodule.BankCSVTempTableDB.FieldByName('Enterprise').AsString := NewListBox.ListInfo.ReturnValue;
         //AccsDatamodule.BankCSVTempTableDB.FieldByName('NomCode').AsString := '';
         AccsDatamodule.BankCSVTempTableDB.Post;
      end;
end;

procedure TfmBankImport.FindAndPostNominal(const ASearchTextValue : string);
var
   IncomeStart, ExpenseStart : Integer;
   Point : TPoint;
   DefVatCode : Variant;
begin
   Point.x := -1;
   Point.y := -1;
   try
      Point := BankImportGrid.ClientToScreen(BankImportGridTableView.Controller.FocusedItem.FocusedCellViewInfo.EditBounds.BottomRight);
   except
   end;

   if IsIncomeOrExpense = ttExpense then
      PROG := CASHEXP
   else
      PROG := CASHINC;

   NewListBox.InitialSearchFieldText := ASearchTextValue;

   //   19/10/20 [V4.5 R4.4] /MK Change - If the Transaction Type is Bank Transfer then show banks listing, if the user selects the
   //                                     same bank account as the transactions are being imported to give error and
   //                                     don't allow the nominal to be set as this bank.
   if ( BankImportGridTableViewTransactionType.Visible ) and ( AccsDataModule.BankCSVTempTableDB.FieldByName('TransactionType').AsString = cBankTransfer ) then
      begin
         NewListBox.ListIt ( nil, Banks, 'N' );
         if ( Length(NewListBox.ListInfo.ReturnValue) > 0 ) then
            begin
               if ( StrToInt(NewListBox.ListInfo.ReturnValue) = StrToInt(teBankAccount.Text) ) then
                  RaiseError('Cannot transfer to the same bank account your importing transactions to.',True,True)
               else
                  StoreNominalSelection(StrToInt(NewListBox.ListInfo.ReturnValue));
            end;
         Exit;
      end;

   if not IsEmpty(AccsDatamodule.BankCSVTempTableDB.FieldByName('Enterprise').AsString) then
      begin
         NewListBox.ListInfo.Ent := AccsDatamodule.BankCSVTempTableDB.FieldByName('Enterprise').AsString;
         NewListBox.ListIt ( nil, EntRange, 'N' )   { Nominal Ledger Accounts }
      end
   else
      begin
         NewListBox.ListInfo.Ent := '';
         if (Preferences.ValueAsBoolean[cPref_AutoEntSelect]) then
            begin
               IncomeStart := AccsDataModule.GetEnterpriseIncomeStart();
               ExpenseStart := AccsDataModule.GetEnterpriseExpenseStart();
            end
         else
            begin
               IncomeStart := cNon_Enterprise_Income_Start;
               ExpenseStart := cNon_Enterprise_Expense_Start;
            end;

         if IsIncomeOrExpense = ttExpense then
            NewListBox.ListIt ( nil, AllNoms, 'N', IntToStr(ExpenseStart) )
         else
            NewListBox.ListIt ( nil, AllNoms, 'N', IntToStr(IncomeStart) );
      end;

   if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
      begin
         //   02/03/20 [V4.5 R1.7] /MK Change - Default Vat to selected Nominals associated VatCode - George (TGM) request.
         DefVatCode := GetAccountName ( NewListBox.ListInfo.ActiveDb, StrToInt ( NewListBox.ListInfo.ReturnValue ),20);
         if ( DefVatCode <> Null ) then
            begin
               AccsDataModule.BankCSVTempTableDB.Edit;
               AccsDataModule.BankCSVTempTableDB.FieldByName('VatCode').AsVariant := DefVatCode;
               AccsDataModule.BankCSVTempTableDB.Post;
            end;
         StoreNominalSelection(StrToInt(NewListBox.ListInfo.ReturnValue));
         EditNominalFreeTextDescription(Point);
      end;
end;

procedure TfmBankImport.FindAndPostVATCode;
begin
   NewListBox.ListIt ( nil, Vat, 'W' );   { VAT Rates }
   If Length ( NewListBox.ListInfo.ReturnValue ) > 0 Then
      begin
          AccsDatamodule.BankCSVTempTableDB.edit;
          AccsDatamodule.BankCSVTempTableDB['VATCode'] := NewListBox.ListInfo.ReturnValue;
          AccsDatamodule.BankCSVTempTableDB.post;
      end;
end;

procedure TfmBankImport.FindAndPostCustomerSupplier;
begin
   if (IsIncomeOrExpense = ttExpense) then
      PROG := CASHEXP
   else
      PROG := CASHINC;

   if Prog = CASHEXP then NewListBox.ListIt ( nil, Suppliers, 'S' )
      else if Prog = CASHINC then NewListBox.ListIt ( nil, Customers, 'C' );

   if not IsNumeric(AccsDatamodule.BankCSVTempTableDB.FieldByName('CustSuppName').AsString) then
      NewListBox.InitialSearchFieldText := AccsDatamodule.BankCSVTempTableDB.FieldByName('CustSuppName').AsString;

   if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
      begin
         AccsDatamodule.BankCSVTempTableDB.edit;
         AccsDatamodule.BankCSVTempTableDB['CustSupp'] := NewListBox.ListInfo.ReturnValue;
         if Prog = CASHEXP then AccsDatamodule.BankCSVTempTableDB['CustSuppName'] := GetCustSuppInfo(PLFile,StrToInt(NewListBox.ListInfo.ReturnValue))
            else if Prog = CASHINC then AccsDatamodule.BankCSVTempTableDB['CustSuppName'] := GetCustSuppInfo(SLFile,StrToInt(NewListBox.ListInfo.ReturnValue));
         AccsDatamodule.BankCSVTempTableDB.post;
      end
          else begin
              AccsDatamodule.BankCSVTempTableDB.edit;
              AccsDatamodule.BankCSVTempTableDB['CustSupp'] := 0;
              AccsDatamodule.BankCSVTempTableDB['CustSuppName'] := '';
              AccsDatamodule.BankCSVTempTableDB.post;
          end;
end;

procedure TfmBankImport.FindAndPostAnalysisCode;
begin
   if not bool(SetupAnalysisForm) then
      Application.CreateForm(TSetupAnalysisForm, SetupAnalysisForm);

   SetupAnalysisForm.ShowWindow(1);
   if length(Setupanalysisform.selectedcode) > 0 then
      begin
         AccsDatamodule.BankCSVTempTableDB.edit;
         AccsDataModule.BankCSVTempTableDB['Analysis'] := Setupanalysisform.selectedcode;
         AccsDatamodule.BankCSVTempTableDB.post;
      end;
end;

procedure TfmBankImport.ProcessKeyPress(var Message: TMessage);
var
   TempStr : string;
   Value : Variant;
begin
   if Message.Msg = WM_PROCESSGRIDKEYPRESS then
      begin
         if (FocusedColumnIndex = BankImportGridTableViewCustSuppName.VisibleIndex) then
            begin
               if ((BankImportGridTableView.Controller.EditingController.EditingItem = nil) or
                  (not(BankImportGridTableView.Controller.EditingController.IsEditing)) or
                  (BankImportGridTableView.Controller.EditingController.Edit = nil)) then Exit;


               Value := BankImportGridTableView.Controller.EditingController.Edit.EditingValue;
               if ((not VarIsNull(Value)) and (not IsNumeric(Value))) then
                  begin
                     ProcessCustomerSupplierLookup(Value);
                     try
                        MoveToItem(BankImportGridTableViewNominalName.VisibleIndex+1);
                     except
                     end;
               end;
            end
      end;
end;

procedure TfmBankImport.BankImportGridTableViewEditKeyUp(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
   //   09/01/19 [V4.3 R4.0] /MK Bug Fix - Only send message to show NewList form if the key is not the return key - SP/TGM.
   if ( Key <> vk_Return ) then
      SendMessage(Handle, WM_PROCESSGRIDKEYPRESS, 0, 0);
end;

function TfmBankImport.FocusedColumnIndex: Integer;
begin
   Result := BankImportGridTableView.Controller.FocusedColumnIndex;
end;

procedure TfmBankImport.actExitExecute(Sender: TObject);
begin
   Close;
end;

procedure TfmBankImport.BankImportGridTableViewInitEdit(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit);
begin
   if (AEdit = nil) then Exit;

   try
      HideHint();
   except
   end;

   if not Assigned(AEdit.OnDblClick) then
      AEdit.OnDblClick := MyCellDoubleClick;

   if (FocusedColumnIndex = BankImportGridTableViewQuantity.VisibleIndex) then
      begin
         (AEdit as TcxButtonEdit).Properties.Buttons[0].Visible := AccsDataModule.GetAdvancedQuantityInput(
         AccsDataModule.BankCSVTempTableDB.FieldByName('Enterprise').AsString) <> nil;
      end;
end;

procedure TfmBankImport.MyCellDoubleClick(Sender: TObject);
begin
   InvokeGridCellSearch();
end;

procedure TfmBankImport.actSelectBankExecute(Sender: TObject);
begin
   LoadBankByListing();
end;

procedure TfmBankImport.InvokeGridCellSearch;
begin
   NewListBox.ListInfo.Ent := '';

   if (FocusedColumnIndex = BankImportGridTableViewEnterprise.VisibleIndex) then
      FindAndPostEnterprise()
   else if (FocusedColumnIndex = BankImportGridTableViewNominalName.VisibleIndex) then
      FindAndPostNominal('')
   else if (FocusedColumnIndex = BankImportGridTableViewVATCode.VisibleIndex) then
      FindAndPostVATCode()
   else if (FocusedColumnIndex = BankImportGridTableViewCustSuppName.VisibleIndex) then
      begin
         FindAndPostCustomerSupplier();
         try
            MoveToItem(BankImportGridTableViewNominalName.VisibleIndex+1);
         except
         end;
      end
   else if (FocusedColumnIndex = BankImportGridTableViewAnalysis.VisibleIndex) then
      FindAndPostAnalysisCode();
   HideHint();
end;

procedure TfmBankImport.RaiseError(AErrorMessage : string; const AAbort : Boolean = true;
  const ADisplayError : Boolean = false);
begin
   if (ADisplayError) then
      MessageDlg(AErrorMessage,mtError,[mbOK],0);

   if ( AAbort ) then
      SysUtils.Abort;
end;

procedure TfmBankImport.ProcessCustomerSupplierLookup(ALookupText: string);
begin
   if AccsDatamodule.BankCSVTempTableDB.FieldByName('Expenditure').AsString <> '' then
      PROG := CASHEXP
   else
      PROG := CASHINC;

   NewListBox.InitialSearchFieldText := ALookupText;

   if Prog = CASHEXP then
      NewListBox.ListIt ( nil, Suppliers, 'S' )
   else if Prog = CASHINC then
      NewListBox.ListIt ( nil, Customers, 'C' );

   if Length ( NewListBox.ListInfo.ReturnValue ) > 0 then
      begin
         AccsDatamodule.BankCSVTempTableDB.edit;
         AccsDatamodule.BankCSVTempTableDB['CustSupp'] := NewListBox.ListInfo.ReturnValue;
         if Prog = CASHEXP then
            AccsDatamodule.BankCSVTempTableDB['CustSuppName'] := GetCustSuppInfo(PLFile,StrToInt(NewListBox.ListInfo.ReturnValue))
         else if Prog = CASHINC then
            AccsDatamodule.BankCSVTempTableDB['CustSuppName'] := GetCustSuppInfo(SLFile,StrToInt(NewListBox.ListInfo.ReturnValue));
         AccsDatamodule.BankCSVTempTableDB.post;
      end
   else
      begin
         AccsDatamodule.BankCSVTempTableDB.Edit;
         AccsDatamodule.BankCSVTempTableDB['CustSupp'] := 0;
         AccsDatamodule.BankCSVTempTableDB['CustSuppName'] := '';
         AccsDatamodule.BankCSVTempTableDB.Post;
     end;
end;

procedure TfmBankImport.BankImportGridTableViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
   Key := System.UpCase(Key);
   HideHint();
end;

procedure TfmBankImport.LoadBankDetails;
var
   BankAccount : TBankAccount;
begin
   BankAccount := nil;
   try
      if IsNumeric(teBankAccount.Text) then
         begin
            BankAccount := AccsDataModule.Accounts.BankAccounts.GetBankAccount(StrToInt(teBankAccount.Text));
            if (BankAccount <> nil) then
               begin
                  lBankAccountName.Caption := BankAccount.Name;
                  if not(FAutoLoadTransFile) then
                     // look up default bank file & location
                     LoadBankDefaults(BankAccount.Id);
               end
            else
               teBankAccount.SetFocus;
         end
      else
         teBankAccount.SetFocus;
   except
      teBankAccount.Text := '';
      teBankAccount.SetFocus;
   end;
end;

procedure TfmBankImport.FormCreate(Sender: TObject);
begin
   FWinShortDateStyle := SysUtils.ShortDateFormat;
   SysUtils.ShortDateFormat := 'dd/MM/yy';

   lBankAccountName.Caption := '';

   // If the user is using a Ledger or LedgerCashbook system then maximize screen so
   // all available columns can be viewed.
   if not(AccsSystem.SystemType = stCashbook) then
      begin
         WindowState := wsMaximized;
      end
   else
      begin
         if (Screen.Width < 1024) then
            Width := 790
         else
            Width := 1014;

         if (Screen.Height < 768) then
            Height := 590
         else
            Height := 680;
      end;

   OpenDialog.DefaultExt := '.csv';
   OpenDialog.Filter := 'CSV|*.csv';

   AccsDataModule.ImageList16x16.GetBitmap(1, erButtonEdit.Properties.Buttons[0].Glyph);
   erButtonEdit.Properties.OnButtonClick := ButtonEditClick;
   erButtonEdit.Properties.OnChange := ButtonEditOnChange;

   with TcxButtonEditProperties(BankImportGridTableViewMultiLineEdit.Properties) do
      OnButtonClick := MultiLineEditClick;
   with TcxButtonEditProperties(BankImportGridTableViewQuantity.Properties) do
      OnButtonClick := ButtonEditClick;
   BankMultiLineTransEditForm := TBankMultiLineTransEditForm.Create(nil);

   FUsingVAT := (soVAT in AccsSystem.SystemOptions);

   GetFinDateRange(FYearStart, FYearEnd);
end;

procedure TfmBankImport.blbHelpClick(Sender: TObject);
begin
   MessageDlg(Instructions.Caption, mtInformation,[mbOK],0);
end;

procedure TfmBankImport.StoreNominalSelection(const ANomCode : Integer; AAllocSelectToGrid : Boolean = True);
var
   NominalAccount : TNominalAccount;
   BankAccount : TBankAccount;
   IsMultiLine : Boolean;
begin
   if ( AccsDatamodule.BankCSVTempTableDB.FieldByName('TransactionType').AsString = cPayReceipt ) then Exit;

   try
      AccsDatamodule.BankCSVTempTableDB.Edit;
      try
         AccsDatamodule.BankCSVTempTableDB.FieldByName('NomCode').Clear;
         AccsDatamodule.BankCSVTempTableDB.FieldByName('NomName').Clear;
         if ( ANomCode > 0 ) then
            begin
               IsMultiLine := BankImportGridTableView.DataController.Values[BankImportGridTableView.DataController.FocusedRecordIndex,BankImportGridTableViewIsMultiLineTransaction.Index] = True;
               //   19/10/20 [V4.5 R4.4] /MK Change - For Bank Transfer transactions validate the bank account selected is in fact a bank account.
               if ( AccsDatamodule.BankCSVTempTableDB.FieldByName('TransactionType').AsString = cBankTransfer ) then
                  BankAccount := AccsDatamodule.Accounts.BankAccounts.GetBankAccount(ANomCode)
               else
                  NominalAccount := AccsDatamodule.Accounts.GetNominalAccount(ANomCode);
               //   27/08/19 [V4.5 R0.3] /MK Change - Don't auto update nominal if this transaction is a mutliline.
               //   19/10/20 [V4.5 R4.4] /MK Change - For Bank Transfer transactions set the Nominal and clear out the Enterprise.
               if ( (NominalAccount <> nil) or (BankAccount <> nil) ) and ( not(IsMultiLine) ) then
                  begin
                     AccsDatamodule.BankCSVTempTableDB.FieldByName('NomCode').AsInteger := ANomCode;
                     if ( NominalAccount <> nil ) then
                        begin
                           AccsDatamodule.BankCSVTempTableDB.FieldByName('NomName').AsString := NominalAccount.Name;
                           AccsDatamodule.BankCSVTempTableDB.FieldByName('Enterprise').AsString := NominalAccount.EntCode;
                        end
                     else if ( BankAccount <> nil ) then
                        begin
                           AccsDatamodule.BankCSVTempTableDB.FieldByName('NomName').AsString := BankAccount.Name;
                           AccsDatamodule.BankCSVTempTableDB.FieldByName('Enterprise').AsString := '';
                        end
                  end;
            end;
         AccsDatamodule.BankCSVTempTableDB.Post;
      except
         AccsDatamodule.BankCSVTempTableDB.Cancel;
      end;

      try
         if ( NominalAccount <> nil ) then
            AccsDataModule.StoreNLAndDescription(ANomCode,
                                                 StripAllSpaces(AccsDataModule.BankCSVTempTableDB.FieldByName('Details').AsString),
                                                 AccsDatamodule.BankCSVTempTableDB.FieldByName('TransactionType').AsString);
      except

      end;
   finally
      BankImportGridTableView.ApplyBestFit( BankImportGridTableViewNominalName );
      if ( AAllocSelectToGrid ) then
         AllocateStoredSelectionToGrid;
   end;
end;

procedure TfmBankImport.FocusItem(ACustomGridTableItem : TcxCustomGridTableItem;
   const AHintTitle, AHintText : string);
var
   Point : TPoint;

begin
   Windows.Beep(1000,150);

   if not BankImportGrid.Focused then
      BankImportGrid.SetFocus;

   BankImportGridTableView.Controller.EditingController.ShowEdit(ACustomGridTableItem);
   if (BankImportGridTableView.Controller.EditingController.Edit = nil) then Exit;

   if ( ACustomGridTableItem = BankImportGridTableViewTransactionType) then
      TcxCustomComboBox(BankImportGridTableView.Controller.EditingController.Edit).DroppedDown := true
   else
      BankImportGridTableView.Controller.EditingController.Edit.DoEditing;

   Point := BankImportGridTableView.Controller.EditingItem.FocusedCellViewInfo.EditBounds.BottomRight;
   Point.x := Point.x-8; // allow for any edit button

   Point := BankImportGrid.ClientToScreen(Point);

   HideHint();
   HintStyleController := TcxHintStyleController.Create(nil);
   HintStyleController.HintStyle.Standard := False;
   HintStyleController.HintStyle.Color := clRed;
   HintStyleController.HintStyle.Animate :=cxhaSlideDownward;
   HintStyleController.HintStyle.AnimationDelay := 50;
   HintStyleController.HintStyle.CallOutPosition := cxbpLeftTop;
   HintStyleController.HintStyle.CaptionFont.Name := 'Segoe UI';
   HintStyleController.HintStyle.CaptionFont.Size := 12;
   HintStyleController.HintStyle.CaptionFont.Style := [fsBold];
   HintStyleController.HintStyle.CaptionFont.Color := clWhite;
   HintStyleController.HintStyle.Font := HintStyleController.HintStyle.CaptionFont;
   HintStyleController.HintStyle.Font.Size := 10;
   HintStyleController.HintStyle.Rounded := True;
   HintStyleController.HintStyle.RoundRadius := 26;
   HintStyleController.ShowHint(Point.x, Point.y, AHintTitle, AHintText);
end;

procedure TfmBankImport.BankImportGridTableViewCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
   HideHint();
end;

procedure TfmBankImport.BankImportGridTableViewEditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
   HideHint();
end;

procedure TfmBankImport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   HideHint();
end;

procedure TfmBankImport.erTransactionTypesPropertiesChange(Sender: TObject);
begin
   HideHint();
   if ( AccsDatamodule.BankCSVTempTableDB.FieldByName('TransactionType').AsString = cPayReceipt ) then
      begin
         AccsDatamodule.BankCSVTempTableDB.Edit;
         AccsDatamodule.BankCSVTempTableDB.FieldByName('NomCode').AsInteger := 0;
         AccsDatamodule.BankCSVTempTableDB.FieldByName('NomName').AsString := '';
         AccsDatamodule.BankCSVTempTableDB.FieldByName('Enterprise').AsString := '';
         AccsDatamodule.BankCSVTempTableDB.Post;
      end
   //   19/10/20 [V4.5 R4.4] /MK Change - If the Transaction Type is bank transfer then turn off the IsMultiLineTransaction.
   else if ( AccsDataModule.BankCSVTempTableDB.FieldByName('TransactionType').AsString = cBankTransfer ) then
      begin
         AccsDatamodule.BankCSVTempTableDB.Edit;
         AccsDatamodule.BankCSVTempTableDB.FieldByName('IsMultiLineTransaction').AsBoolean := False;
         AccsDatamodule.BankCSVTempTableDB.FieldByName('Enterprise').AsString := '';
         AccsDatamodule.BankCSVTempTableDB.Post;
      end
   else
      begin
         AccsDatamodule.BankCSVTempTableDB.Edit;
         AssignNomDetailFromStore;
         AccsDatamodule.BankCSVTempTableDB.Post;
      end;
end;

procedure TfmBankImport.HideHint;
begin
   if (HintStyleController <> nil) then
      begin
         HintStyleController.HideHint;
         FreeAndNil(HintStyleController);
      end;
end;

procedure TfmBankImport.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Key = VK_ESCAPE) then
      begin
         if (AccsDataModule.BankCSVTempTableDB.Active ) and ( AccsDataModule.BankCSVTempTableDB.RecordCount = 0) then
            Close;
      end;
end;

procedure TfmBankImport.ButtonEditClick(Sender: TObject;
  AButtonIndex: Integer);
begin
   if (FocusedColumnString = BankImportGridTableViewNominalName.DataBinding.FieldName) then
      begin
         PostMessage(Handle, WM_INVOKESEARCHITEM, 1, 0);
      end
   else if (FocusedColumnString = BankImportGridTableViewEnterprise.DataBinding.FieldName) then
      begin
         PostMessage(Handle, WM_INVOKESEARCHITEM, 2, 0);
      end
   else if (FocusedColumnString = BankImportGridTableViewCustSuppName.DataBinding.FieldName) then
      begin
         PostMessage(Handle, WM_INVOKESEARCHITEM, 3, 0);
      end
   else if (FocusedColumnString = BankImportGridTableViewAnalysis.DataBinding.FieldName) then
      begin
         PostMessage(Handle, WM_INVOKESEARCHITEM, 4, 0);
      end
   else if (FocusedColumnString = BankImportGridTableViewVATCode.DataBinding.FieldName) then
      begin
         PostMessage(Handle, WM_INVOKESEARCHITEM, 5, 0);
      end
   else if (FocusedColumnString = BankImportGridTableViewQuantity.DataBinding.FieldName) then
      begin
         PostMessage(Handle, WM_INVOKESEARCHITEM, 6, 0);
      end
end;

function TfmBankImport.FocusedColumnString: string;
begin
   try
      Result := TcxGridDBColumn(BankImportGridTableView.Controller.FocusedColumn).DataBinding.FieldName;
   except
      Result := '';
   end;
end;

procedure TfmBankImport.InvokeSearchItem(var Message: TMessage);
begin
   if Message.Msg = WM_INVOKESEARCHITEM then
      begin
         // Do not allow editing of columns if any lines exist in the multiline table.

         //   19/10/20 [V4.5 R4.4] /MK Change - If the Transaction Type is not Bank Transfer then pop up the Mult Line Editor screen.
         if ( (Message.WParam in [1,2,4,5,6]) and
              (AccsDatamodule.BankCSVDetailTempTableDB.RecordCount > 0) and
              (AccsDataModule.BankCSVTempTableDB.FieldByName('TransactionType').AsString <> cBankTransfer) ) then
            begin
               InvokeMultiLineEditor();
               Exit;
            end;

         if (Message.WParam = 1) then
            FindAndPostNominal('')
         else if (Message.WParam = 2) then
            FindAndPostEnterprise()
         else if (Message.WParam = 3) then
            begin
               FindAndPostCustomerSupplier();
               try
                  MoveToItem(BankImportGridTableViewNominalName.VisibleIndex+1);
               except
               end;
            end
         else if (Message.WParam = 4) then
            FindAndPostAnalysisCode()
         else if (Message.WParam = 5) then
            FindAndPostVATCode()
         else  if (Message.WParam = 6) then
            InvokeQuantityScreen();
      end;
end;

procedure TfmBankImport.MoveToItem(AIndex : Integer);
var
   NextItem : TcxCustomGridTableItem;
begin
   if (AIndex <= BankImportGridTableView.ColumnCount-1) then
      begin
         if AIndex = -1 then
            BankImportGridTableView.Controller.FocusNextItem(BankImportGridTableView.Controller.FocusedItemIndex, True, True, True)
         else
            begin
               NextItem := BankImportGridTableView.FindItemByID(AIndex);
               if ((NextItem <> nil) and (NextItem.Visible)) then
                  begin
                     BankImportGridTableView.Controller.FocusedItem := BankImportGridTableView.FindItemByID(AIndex)
                  end
               else
                  BankImportGridTableView.Controller.FocusNextItem(BankImportGridTableView.Controller.FocusedItemIndex, True, True, True)
            end;
         if (BankImportGridTableView.Controller.FocusedItem <> nil) then
            BankImportGridTableView.Controller.EditingController.EditingItem := BankImportGridTableView.Controller.FocusedItem;
      end;
end;

class procedure TfmBankImport.RunImport;
begin
   with TfmBankImport.Create(nil) do
   try
      ShowModal;
   finally
      Free;
   end;
end;

procedure TfmBankImport.MultiLineEditClick(Sender: TObject;
  AButtonIndex: Integer);
begin
   if (AButtonIndex = 0) then // edit click, bring up the multi line editing window.
      InvokeMultiLineEditor();
end;

procedure TfmBankImport.InvokeQuantityScreen;
var
   Point : TPoint;
begin
   GetCursorPos(Point);
   Point := ScreenToClient(ClientToScreen(Point));
   // try to align to left,bottom of cell
   Point.x := Point.x - 65;
   Point.y := Point.y + BankImportGridTableView.OptionsView.DataRowHeight;
   EditCBEQuantities(Point);
end;

procedure TfmBankImport.EditCBEQuantities(APoint: TPoint);
var
   Qty2, Qty3 : Variant;
begin
   // Post any edits to the quantity before opening the multiple quantity window
   BankImportGridTableView.DataController.PostEditingData;

   if AccsDatamodule.MultipleQuantityHandler(AccsDatamodule.BankCSVTempTableDB.FieldByName('Enterprise').AsString,
              AccsDatamodule.BankCSVTempTableDB.FieldByName('Quantity2').AsFloat,
              AccsDatamodule.BankCSVTempTableDB.FieldByName('Quantity3').AsFloat,
              Qty2, Qty3,APoint) then
      begin
         AccsDatamodule.BankCSVTempTableDB.Edit;
         if not VarIsNullOrEmpty(Qty2) then
            AccsDatamodule.BankCSVTempTableDB.FieldByName('Quantity2').Value := Qty2;

         if not VarIsNullOrEmpty(Qty3) then
            AccsDatamodule.BankCSVTempTableDB.FieldByName('Quantity3').Value := Qty3;
         AccsDatamodule.BankCSVTempTableDB.Post;
      end;
end;

procedure TfmBankImport.InvokeMultiLineEditor;
var
   CanEditMultiLine : Boolean;
   IsMultiLine : Boolean;
begin
   if ( (AccsDataModule.BankCSVTempTableDB.FieldByName('IsSplitTransaction').AsBoolean) or
        (AccsDataModule.BankCSVTempTableDB.FieldByName('SplitTransID').AsInteger > 0) ) and
      ( AccsDataModule.BankCSVTempTableDB.FieldByName('OriginalAmount').AsFloat = 0 ) and
      ( AccsDataModule.BankCSVTempTableDB.FieldByName('Amount').AsFloat > 0 ) then
         AccsDataModule.BankCSVTempTableDB['OriginalAmount'] := AccsDataModule.BankCSVTempTableDB['Amount'];

   //   15/01/19 [V4.3 R4.1] /MK Change - Only allow edit of multiline in Ledgers if Transaction Type is not Pay/Rec.
   CanEditMultiLine := AccsDataModule.BankCSVTempTableDB['TransactionType'] <> cPayReceipt;
   if ( not(CanEditMultiLine) ) then
      begin
         MessageDlg('You cannot use the Multi-Line editor on a Pay/Rec Transaction Type.',mtError,[mbOK],0);
         Exit;
      end
   else
      begin
         CanEditMultiLine :=
             AccsDataModule.BankCSVTempTableDB['OriginalAmount'] = AccsDataModule.BankCSVTempTableDB['Amount'];
         if ( not CanEditMultiLine) then
            begin
               if (MessageDlg('The current amount value differs from the original amount.' + cCRLFx2 +
                              'Are you sure you want to proceed with multi line entry?',
                              mtConfirmation,[mbYes,mbNo],0)) = idNo then Exit;
            end;
      end;

   BankMultiLineTransEditForm.EditTransaction(IsIncomeOrExpense());

   //   27/08/19 [V5.9 R0.1] /MK Change - If user has entered nominal/ent info and then presses Multline button to add more lines, clear off nominal/ent of single line.
   IsMultiLine := BankImportGridTableView.DataController.Values[BankImportGridTableView.DataController.FocusedRecordIndex,BankImportGridTableViewIsMultiLineTransaction.Index] = True;
   if IsMultiLine then
      begin
         AccsDataModule.BankCSVTempTableDB.FieldByName('NomCode').AsInteger := 0;
         AccsDataModule.BankCSVTempTableDB.FieldByName('NomName').AsString := '';
         AccsDataModule.BankCSVTempTableDB.FieldByName('NomFreeText').AsString := '';
         AccsDataModule.BankCSVTempTableDB.FieldByName('Enterprise').AsString := '';
      end;
end;

procedure TfmBankImport.BankImportGridTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
   IsMuliLine,
   IsSplitTrans : Boolean;
begin
   IsMuliLine := False;
   IsSplitTrans := False;
   if (ARecord <> nil) then
      begin
         IsMuliLine := ARecord.Values[BankImportGridTableViewIsMultiLineTransaction.Index] = True;
         IsSplitTrans := ARecord.Values[BankImportGridTableViewSplitTransaction.Index] = True;
      end;

   if IsMuliLine then
      AStyle := TransGridMultiLineStyle
   else if IsSplitTrans then
      AStyle := TransGridSplitTransStyle
   else
      AStyle := TransGridNormalStyle;

end;

procedure TfmBankImport.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   CanClose := (FTransactionsPosted) or
               (MessageDlg('You are about to exit the Bank Import screen.' + cCRLFx2 + 'All changes will be lost!!!' + cCRLFx2 + 'Are you sure you want to exit?',mtWarning,[mbYes,mbNo],0) = idYes);
end;

procedure TfmBankImport.ButtonEditOnChange(Sender: TObject);
var
   EditingText : string;
begin
   if (FocusedColumnString = BankImportGridTableViewNominalName.DataBinding.FieldName) then
      begin
         EditingText := (Sender as TcxButtonEdit).Text;
         if (not(IsEmpty(EditingText)) and (not Numeric(EditingText))) then
            begin
               FindAndPostNominal(EditingText);
              (Sender as TcxButtonEdit).Text := '';
            end;
      end
end;

procedure TfmBankImport.BankImportGridTableViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
   try
      HideHint();
      //   04/01/19 [V5.8 R5.9] /MK Additional Feature - Only allow discount field to be edited if transaction type is Pay / Rec.
      if ( AItem = BankImportGridTableViewDiscount ) then
         with Sender.DataController do
            AAllow := Values[FocusedRecordIndex,BankImportGridTableViewTransactionType.Index] = cPayReceipt;
      //   15/01/19 [V4.3 R4.1] /MK Change - Don't allow the entry to the Nominal field if the Transaction Type is Pay/Rec.
      if ( AItem = BankImportGridTableViewNominalName ) then
         with Sender.DataController do
            AAllow := Values[FocusedRecordIndex,BankImportGridTableViewTransactionType.Index] <> cPayReceipt;
      //   19/10/20 [V4.5 R4.4] /MK Change - Don't allow edit of Enterprise or Vat Code if Transaction type Pay/Receipt or Bank Transfer.
      if ( AItem = BankImportGridTableViewEnterprise ) or ( AItem = BankImportGridTableViewVATCode ) then
         with Sender.DataController do
            AAllow := ( (not(Values[FocusedRecordIndex,BankImportGridTableViewTransactionType.Index] = cPayReceipt)) and
                        (not(Values[FocusedRecordIndex,BankImportGridTableViewTransactionType.Index] = cBankTransfer)) );
      //   19/10/20 [V4.5 R4.4] /MK Change - Allow edit of Customer/Supplier field if Transaction Type is anything other than Bank Transfer.
      if ( AItem = BankImportGridTableViewCustSuppName ) then
         with Sender.DataController do
            AAllow := Values[FocusedRecordIndex,BankImportGridTableViewTransactionType.Index] <> cBankTransfer;
      //   19/10/20 [V4.5 R4.4] /MK Change - Allow edit of Quantity field if Transaction Type is Cashbook or Cash Sale/Purch.
      if ( AItem = BankImportGridTableViewQuantity ) then
         with Sender.DataController do
            AAllow := ( (Values[FocusedRecordIndex,BankImportGridTableViewTransactionType.Index] = cCashSalePurch) or
                        (Values[FocusedRecordIndex,BankImportGridTableViewTransactionType.Index] = cCashbook) );
   except
   end;
end;

procedure TfmBankImport.BankImportGridTableViewTxDatePropertiesPopup(
  Sender: TObject);
begin
   try
      HideHint();
   except
   end;
end;

procedure TfmBankImport.SetupWidthOfForm;
var
   iCurrentFormWidth : Integer;
begin
   iCurrentFormWidth := 1500;

   //   19/10/20 [V4.5 R4.4] /MK Change - Added 5 to the width of the columns to allow for the form to fill better.
   if ( not(BankImportGridTableViewTransactionType.Visible) ) then
      iCurrentFormWidth := ( iCurrentFormWidth - BankImportGridTableViewTransactionType.Width+5 );
   if ( not(BankImportGridTableViewStubNumber.Visible) ) then
      iCurrentFormWidth := ( iCurrentFormWidth - BankImportGridTableViewStubNumber.Width+5 );
   if ( not(BankImportGridTableViewExtraDetail1.Visible) ) then
      iCurrentFormWidth := ( iCurrentFormWidth - BankImportGridTableViewExtraDetail1.Width+5 );
   if ( not(BankImportGridTableViewExtraDetail2.Visible) ) then
      iCurrentFormWidth := ( iCurrentFormWidth - BankImportGridTableViewExtraDetail2.Width+5 );
   if ( not(BankImportGridTableViewCustSuppName.Visible) ) then
      iCurrentFormWidth := ( iCurrentFormWidth - BankImportGridTableViewCustSuppName.Width+5 );
   if ( not(BankImportGridTableViewQuantity.Visible) ) then
      iCurrentFormWidth := ( iCurrentFormWidth - BankImportGridTableViewQuantity.Width+5 );
   if ( not(BankImportGridTableViewVATCode.Visible) ) then
      iCurrentFormWidth := ( iCurrentFormWidth - BankImportGridTableViewVATCode.Width+5 );
   if ( not(BankImportGridTableViewAnalysis.Visible) ) then
      iCurrentFormWidth := ( iCurrentFormWidth - BankImportGridTableViewAnalysis.Width+5 );
   //   04/01/19 [V4.3 R4.0] /MK Additional Feature - Change width of the form if new discount column is hidden.
   if ( not(BankImportGridTableViewDiscount.Visible) ) then
      iCurrentFormWidth := ( iCurrentFormWidth - BankImportGridTableViewDiscount.Width+5 );

   Width := iCurrentFormWidth;
end;

procedure TfmBankImport.AllocateStoredSelectionToGrid;
var
   i : integer;
   RecordId : Integer;
begin
   RecordId := AccsDataModule.BankCSVTempTableDB.FieldByName('ID').AsInteger;

   BankImportGridTableView.DataController.BeginFullUpdate;
   AccsDataModule.BankCSVTempTableDB.First;
   for i := 1 to AccsDataModule.BankCSVTempTableDB.RecordCount do
      begin
         AccsDataModule.BankCSVTempTableDB.RecNo := i;
         AccsDatamodule.BankCSVTempTableDB.Edit;
         AssignNomDetailFromStore;
         AccsDatamodule.BankCSVTempTableDB.Post;
      end;
   BankImportGridTableView.DataController.EndFullUpdate;

   BankImportGridTableView.DataController.BeginLocate;
   try
      AccsDataModule.BankCSVTempTableDB.Locate('ID',RecordID,[]);
      Update;
   finally
      BankImportGridTableView.DataController.EndLocate;
   end;
end;

procedure TfmBankImport.EditNominalFreeTextDescription;
begin
   EditNominalFreeTextDescription(Point(-1,-1));
end;

procedure TfmBankImport.EditNominalFreeTextDescription(APoint: TPoint);
var
  NominalCode : string;
  NominalDescription : string;
begin
   if not Preferences.ValueAsBoolean[cPref_AllowFreeTextForNominalDescriptionColumn] then Exit;

   if ( not(AccsDataModule.BankCSVTempTableDB.State in dsEditModes) ) then
      AccsDataModule.BankCSVTempTableDB.Edit;

   NominalCode := VarToStr(BankImportGridCell[BankImportGridTableViewNomCode.Index]);
   if (Length(Trim(NominalCode)) <= 0) then Exit;

   NominalDescription := VarToStr(BankImportGridCell[BankImportGridTableViewDetails.Index]);
   if ( Length(NominalDescription) = 0 ) then
      NominalDescription := VarToStr(BankImportGridCell[BankImportGridTableViewNominalName.Index]);

   BankImportGridCell[BankImportGridTableViewNomFreeText.Index] :=
       TfmTransactionNominalFreeTextDescriptionInput.GetText(NominalDescription);

   AccsDataModule.BankCSVTempTableDB.FieldByName('Details').AsString :=
      VarToStr(BankImportGridCell[BankImportGridTableViewNomFreeText.Index]);
end;

function TfmBankImport.GetBankImportGridCell(Index: Integer): Variant;
begin
   Result := varNull;
   if Index > -1 then
      Result := BankImportGridTableView.DataController.Values[BankImportGridTableView.DataController.FocusedRecordIndex, Index];
end;

procedure TfmBankImport.SetBankImportGridCell(Index: Integer; const Value: Variant);
begin
   BankImportGridTableView.DataController
      .Values[BankImportGridTableView.DataController.FocusedRecordIndex, Index]
         := Value;
end;

procedure TfmBankImport.actSplitTransExecute(Sender: TObject);
var
   vImportTx, vPayOrReceipt, vTxDate,
   vTxType, vVatCode, vTxHash : Variant;
   AView: TcxGridDBTableView;
   bIsLastRecord : Boolean;
   iOrigSplitID : Integer;

   procedure AddDefaultRowInfo;
   begin
      with AView.DataController do
         begin
            SetEditValue(BankImportGridTableViewImport.Index, vImportTx, evsValue);
            SetEditValue(BankImportGridTableViewTransactionType.Index, vTxType, evsValue);
            SetEditValue(BankImportGridTableViewIncomeOrExpense.Index, vPayOrReceipt, evsValue);
            SetEditValue(BankImportGridTableViewTxDate.Index, vTxDate, evsValue);
            SetEditValue(BankImportGridTableViewVATCode.Index, vVatCode, evsValue);
            SetEditValue(BankImportGridTableViewTransHash.Index, vTxHash, evsValue);
            SetEditValue(BankImportGridTableViewSplitTransaction.Index, 'True', evsValue);
            SetEditValue(BankImportGridTableViewIsMultiLineTransaction.Index, 'False', evsValue);
            SetEditValue(BankImportGridTableViewAnalysis.Index, '0', evsValue);
            SetEditValue(BankImportGridTableViewSplitTransID.Index, iOrigSplitID, evsValue);
         end;
   end;

begin
   if ( AccsDataModule.BankCSVTempTableDB.FieldByName('IsMultiLineTransaction').AsBoolean ) then
      begin
         MessageDlg('This is a multi line transaction.'+cCRLF+
                    'You cannot split a multi line transaction.',mtInformation,[mbOK],0);
         Exit;
      end;

   if ( not(AccsDataModule.BankCSVTempTableDB.State in dsEditModes) ) then
      AccsDataModule.BankCSVTempTableDB.Edit;
   AccsDataModule.BankCSVTempTableDB.FieldByName('IsSplitTransaction').AsBoolean := True;
   if ( AccsDataModule.BankCSVTempTableDB.FieldByName('SplitTransID').AsInteger = 0 ) then
      iOrigSplitID := AccsDataModule.BankCSVTempTableDB.FieldByName('Id').AsInteger
   else
      iOrigSplitID := AccsDataModule.BankCSVTempTableDB.FieldByName('SplitTransID').AsInteger;
   AccsDataModule.BankCSVTempTableDB.FieldByName('SplitTransID').AsInteger := iOrigSplitID;
   AccsDataModule.BankCSVTempTableDB.Post;

   bIsLastRecord := False;
   AView := BankImportGridTableView;
   with AView.DataController do
      begin
         vImportTx := AView.Controller.FocusedRecord.Values[BankImportGridTableViewImport.Index];
         vTxType := AView.Controller.FocusedRecord.Values[BankImportGridTableViewTransactionType.Index];
         vPayOrReceipt := AView.Controller.FocusedRecord.Values[BankImportGridTableViewIncomeOrExpense.Index];
         vTxDate := AView.Controller.FocusedRecord.Values[BankImportGridTableViewTxDate.Index];
         vVatCode := AView.Controller.FocusedRecord.Values[BankImportGridTableViewVATCode.Index];
         vTxHash := AView.Controller.FocusedRecord.Values[BankImportGridTableViewTransHash.Index];
         if ( not(VarIsNullOrEmpty(vPayOrReceipt)) ) and ( not(VarIsNullOrEmpty(vTxDate)) ) then
            try
               BeginUpdate;
               if ( FocusedRecordIndex < RecordCount - 1 ) then
                  begin
                     AView.OptionsData.Appending := False;
                     bIsLastRecord := False;
                     FocusedRecordIndex := FocusedRecordIndex + 1;
                     Insert;
                     AddDefaultRowInfo;
                     Post;
                  end
               else
                  begin
                     AView.OptionsData.Appending := True;
                     bIsLastRecord := True;
                     RecordCount := RecordCount + 1;
                     FocusedRecordIndex := FocusedRecordIndex + 1;
                     Append;
                     AddDefaultRowInfo;
                     Post;
                  end;
               EndUpdate;
            finally
            end;
      end;
   BankImportGrid.SetFocus;
   if bIsLastRecord then
      AView.OptionsData.Appending := False;
end;

procedure TfmBankImport.BankImportGridTableViewFocusedRecordChanged(
   Sender: TcxCustomGridTableView; APrevFocusedRecord,
   AFocusedRecord: TcxCustomGridRecord;
   ANewItemRecordFocusingChanged: Boolean);
var
   vPreRecSplitTransID,
   vFocusedSplitTransID : Variant;
   i, iSelectedRow : Integer;
begin
   try
      EnableDisableGridControls();
      
      vPreRecSplitTransID := APrevFocusedRecord.Values[BankImportGridTableViewSplitTransID.Index];
      if ( VarIsNullOrEmpty(vPreRecSplitTransID) ) then
         vPreRecSplitTransID := '0';
      vFocusedSplitTransID := AFocusedRecord.Values[BankImportGridTableViewSplitTransID.Index];
      if ( VarIsNullOrEmpty(vFocusedSplitTransID) ) then
         vFocusedSplitTransID := '0';
      if ( vFocusedSplitTransID <> vPreRecSplitTransID ) then
         begin
            BankImportGridTableView.DataController.BeginFullUpdate;
            with TQuery.Create(nil) do
               try
                  DatabaseName := AccsDataModule.AccsDataBase.DatabaseName;
                  SQL.Clear;
                  SQL.Add('UPDATE '+AccsDataModule.BankCSVTempTableDB.TableName);
                  SQL.Add('SET IsSplitTransaction = False');
                  ExecSQL;
               finally
                  Free;
               end;
            BankImportGridTableView.DataController.RefreshExternalData;
            BankImportGridTableView.DataController.EndFullUpdate;
         end;
   except
   end;
end;

procedure TfmBankImport.SelectAllTransactionsExecute(Sender: TObject);
begin
   if MessageDlg('Are you sure you want to select all transactions?',mtConfirmation,[mbYes,mbNo],0) = idNo then Exit;
   FSelectType := stSelected;
   SelectDeselectAllTrans;
   blbSelectDeSelectAllTrans.Glyph := nil;
   blbSelectDeSelectAllTrans.Action := DeselectAllTransactions;
   blbSelectDeSelectAllTrans.LargeImageIndex := 47;
   blbSelectDeSelectAllTrans.ImageIndex := 47;
   blbSelectDeSelectAllTrans.HotImageIndex := 47;
end;

procedure TfmBankImport.DeselectAllTransactionsExecute(Sender: TObject);
begin
   if MessageDlg('Are you sure you want to deselect all transactions?',mtConfirmation,[mbYes,mbNo],0) = idNo then Exit;
   FSelectType := stDeselected;
   SelectDeselectAllTrans;
   blbSelectDeSelectAllTrans.Glyph := nil;
   blbSelectDeSelectAllTrans.Action := SelectAllTransactions;
   blbSelectDeSelectAllTrans.LargeImageIndex := 46;
   blbSelectDeSelectAllTrans.ImageIndex := 46;
   blbSelectDeSelectAllTrans.HotImageIndex := 46;
end;

procedure TfmBankImport.SelectDeselectAllTrans;
begin
   AccsDatamodule.BankCSVTempTableDB.DisableControls;
   try
      AccsDatamodule.BankCSVTempTableDB.First;
      while not AccsDatamodule.BankCSVTempTableDB.Eof do
         begin
            AccsDatamodule.BankCSVTempTableDB.Edit;
            case FSelectType of
              stSelected :  AccsDatamodule.BankCSVTempTableDB.FieldByName('Import').AsBoolean := True;
              stDeselected :  AccsDatamodule.BankCSVTempTableDB.FieldByName('Import').AsBoolean := False;
            end;
            AccsDatamodule.BankCSVTempTableDB.Post;
            AccsDatamodule.BankCSVTempTableDB.Next;
         end;
   finally
      AccsDatamodule.BankCSVTempTableDB.EnableControls;
      AccsDatamodule.BankCSVTempTableDB.First;
   end;

end;

procedure TfmBankImport.CheckInitSelectDeSelectAll;
begin
   with TQuery.Create(nil) do
      try
         DatabaseName := AccsDataModule.AccsDataBase.DatabaseName;
         SQL.Clear;
         SQL.Add('SELECT *');
         SQL.Add('FROM '+AccsDatamodule.BankCSVTempTableDB.TableName);
         SQL.Add('WHERE Import = True');
         try
            Open;
            if ( RecordCount > 0 ) then
               begin
                  FSelectType := stSelected;
                  blbSelectDeSelectAllTrans.Glyph := nil;
                  blbSelectDeSelectAllTrans.Action := DeselectAllTransactions;
                  blbSelectDeSelectAllTrans.LargeImageIndex := 47;
                  blbSelectDeSelectAllTrans.ImageIndex := 47;
                  blbSelectDeSelectAllTrans.HotImageIndex := 47;
               end
            else
               begin
                  FSelectType := stDeselected;
                  blbSelectDeSelectAllTrans.Glyph := nil;
                  blbSelectDeSelectAllTrans.Action := SelectAllTransactions;
                  blbSelectDeSelectAllTrans.LargeImageIndex := 46;
                  blbSelectDeSelectAllTrans.ImageIndex := 46;
                  blbSelectDeSelectAllTrans.HotImageIndex := 46;
               end;
         except
            on e : Exception do
               ShowDebugMessage(e.Message);
         end;
      finally
         Free;
      end;
end;

procedure TfmBankImport.EnableDisableGridControls();
var
   IsMultiLine : Boolean;
begin
   IsMultiLine := BankImportGridTableView.DataController.Values[BankImportGridTableView.DataController.FocusedRecordIndex,BankImportGridTableViewIsMultiLineTransaction.Index] = True;
   BankImportGridTableViewNominalName.Options.Editing := ( not(IsMultiLine) );
   BankImportGridTableViewEnterprise.Options.Editing := ( not(IsMultiLine) );
   BankImportGridTableViewQuantity.Options.Editing := ( not(IsMultiLine) );
   BankImportGridTableViewAmount.Options.Editing := ( not(IsMultiLine) );
   BankImportGridTableViewDiscount.Options.Editing := ( not(IsMultiLine) );
   BankImportGridTableViewVATCode.Options.Editing := ( not(IsMultiLine) );
   BankImportGridTableViewAnalysis.Options.Editing := ( not(IsMultiLine) );
end;

procedure TfmBankImport.AssignNomDetailFromStore;
var
   sTransDesc : String;
   NominalAccount : TNominalAccount;
   StoredDetail : TStoredBankLinkInfo;
   DefVatCode : Variant;
begin
   sTransDesc := StripAllSpaces(AccsDataModule.BankCSVTempTableDB.FieldByName('Details').AsString);
   //   25/10/19 [V5.9 R1.0] /MK Bug Fix - Don't try if AccsDataModule.BankCSVTempTableDB.FieldByName('Details').AsString is nothing.
   if ( Length(sTransDesc) = 0 ) then Exit;
   StoredDetail := AccsDataModule.GetStoredBankLinkInfo(sTransDesc);
   if ( StoredDetail = nil ) then Exit;
   try
      NominalAccount := AccsDatamodule.Accounts.GetNominalAccount(StoredDetail.NominalID);
      if ( NominalAccount <> nil ) then
         begin
            if ( Length(StoredDetail.TxTypeDesc) > 0 ) and ( Length(AccsDatamodule.BankCSVTempTableDB.FieldByName('TransactionType').AsString) = 0 ) then
               AccsDatamodule.BankCSVTempTableDB.FieldByName('TransactionType').AsString := StoredDetail.TxTypeDesc;
            if ( AccsDataModule.BankCSVTempTableDB.FieldByName('NomCode').AsInteger = 0 ) then
               begin
                  AccsDataModule.BankCSVTempTableDB.FieldByName('NomCode').AsInteger := NominalAccount.Id;
                  //   02/03/20 [V4.5 R1.7] /MK Change - If Stored Nominal has an associated VatCode then add vat code to the grid - George (TGM) request.
                  DefVatCode := GetAccountName ( NlFile, NominalAccount.Id, 20);
                  if ( DefVatCode <> Null ) then
                     AccsDataModule.BankCSVTempTableDB.FieldByName('VatCode').AsVariant := DefVatCode;
               end;
            if ( Length(AccsDataModule.BankCSVTempTableDB.FieldByName('NomName').AsString) = 0 ) then
               AccsDataModule.BankCSVTempTableDB.FieldByName('NomName').AsString := NominalAccount.Name;
            if ( Length(AccsDataModule.BankCSVTempTableDB.FieldByName('Enterprise').AsString) = 0 ) then
               AccsDataModule.BankCSVTempTableDB.FieldByName('Enterprise').AsString := NominalAccount.EntCode;
         end;
   finally
      if ( StoredDetail <> nil ) then
         FreeAndNil(StoredDetail);
   end;
end;

end.

