{
   28/05/18 [V4.3 R0.9] /MK Additional Feature - Created new drop-down-button for Bank Reports that has a drop-down-menu
                                                 to allow the user to selected Bank Audit Trail or the new Bank Transaction Report.

   27/08/19 [V4.5 R0.3] /MK Additional Feature - Added submenu item to VatPopMenu for "View Submitted Forms" - TGM request.

   02/09/19 [V4.5 R0.3] /MK Change - Set NominalReportForm.MainGridVatSumChecked = False as not required to be defaulted here.

   06/10/20 [V4.5 R4.2] /MK Change - DigitalVATBtnClick - MTD users need to enter in their Username and Password before submitting VAT Return.

   14/10/20 [V4.5 R4.3] /MK Change - DigitalVatBtnClick - After the prompt for Username and Password, store this info so the prompt doesn't keep appearing.

   20/10/20 [V4.5 R4.5] /MK Change - Changed the word log in credentials on the prompt that appears to Username and Password - TGM request. 
}

unit NewRepUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Menus, RXCtrls, ReportDefs,Registry, fullaudit,
  CredentialsStore, LogInCredentials, AccsUtils;

type
  TNewRepForm = class(TForm)
    GCustSupp: TGroupBox;
    GEnt: TGroupBox;
    GAudit: TGroupBox;
    GFinancial: TGroupBox;
    GVat: TGroupBox;
    AccListingBtn: TSpeedButton;
    AgeOfDebtBtn: TSpeedButton;
    InvoiceListingBtn: TSpeedButton;
    pOptions: TPanel;
    ExitButton: TBitBtn;
    Help: TBitBtn;
    PrinterBtn: TBitBtn;
    CustRadio: TRadioButton;
    SuppRadio: TRadioButton;
    CreditNoteBtn: TSpeedButton;
    StatementsBtn: TSpeedButton;
    RecordCardsBtn: TSpeedButton;
    TransactionSummBtn: TSpeedButton;
    LedgerCardsBtn: TSpeedButton;
    TransactionRepBtn: TSpeedButton;
    IncExpBtn: TSpeedButton;
    TrialBalBtn: TSpeedButton;
    FullNomBtn: TSpeedButton;
    ActualCashBtn: TSpeedButton;
    ProfitAndLossBtn: TSpeedButton;
    ManagementBalBtn: TSpeedButton;
    CostPerUnitBtn: TSpeedButton;
    VATBtn: TSpeedButton;
    CheckReps: TCheckBox;
    StatusBar: TStatusBar;
    PaymentListingBtn: TSpeedButton;
    Bevel1: TBevel;
    InvoiceSummBtn: TSpeedButton;
    PopupMenu1: TPopupMenu;
    sbOverheads: TRxSpeedButton;
    miThisYear: TMenuItem;
    Thisyearversuslast3years1: TMenuItem;
    Thisyearmonthly1: TMenuItem;
    Lastyearmonthly1: TMenuItem;
    Thisyearversuslastyear1: TMenuItem;
    NewReports: TCheckBox;
    GBudgets: TGroupBox;
    ThisYearVBudgetBtn: TSpeedButton;
    CashFlowVBudgetYearBtn: TSpeedButton;
    ThisMonthVBudgetBtn: TSpeedButton;
    sbBudgetReports: TRxSpeedButton;
    sbSetupBudgets: TSpeedButton;
    sbanalysisOld: TRxSpeedButton;
    AnalysisPopup: TPopupMenu;
    AnalysisSummaryReport1: TMenuItem;
    AnalysisCodeBreakdownReport1: TMenuItem;
    CashflowVBudgetBtn: TSpeedButton;
    ChequeJnlBtn: TSpeedButton;
    sbAnalysis: TRxSpeedButton;
    ProductCodeSummary1: TMenuItem;
    EntSummaryBtn: TRxSpeedButton;
    EntSummaryPopUp: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    miEntSummaryThisYrVslast3Yr: TMenuItem;
    ThisYearMonthly2: TMenuItem;
    LastYearMonthly2: TMenuItem;
    EnterprisePopUp: TPopupMenu;
    CostingReportThisYear1: TMenuItem;
    ThisYearVsLastYear1: TMenuItem;
    ThisYearVsPreviousYears1: TMenuItem;
    ThisYearMonthly3: TMenuItem;
    LastYearMonthly3: TMenuItem;
    EnterpriseReports: TRxSpeedButton;
    cbShowKeyReportMenu: TCheckBox;
    N1: TMenuItem;
    ProductListing1: TMenuItem;
    pmBankReports: TPopupMenu;
    BankAuditBtn: TRxSpeedButton;
    pmiBankTransactionRep: TMenuItem;
    pmiBankAuditTrailRep: TMenuItem;
    VATPopupMenu: TPopupMenu;
    StandardVATReportBtn: TMenuItem;
    DigitalVATBtn: TMenuItem;
    NewVATBtn: TRxSpeedButton;
    ViewSubmittedReturns1: TMenuItem;
    procedure AccListingBtnClick(Sender: TObject);
    procedure AgeOfDebtBtnClick(Sender: TObject);
    procedure InvoiceListingBtnClick(Sender: TObject);
    procedure PaymentListingBtnClick(Sender: TObject);
    procedure CreditNoteBtnClick(Sender: TObject);
    procedure TransactionSummBtnClick(Sender: TObject);
    procedure StatementsBtnClick(Sender: TObject);
    procedure LedgerCardsBtnClick(Sender: TObject);
    procedure RecordCardsBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckRepsClick(Sender: TObject);
    procedure AccListingBtnMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure VATBtnClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure PrinterBtnClick(Sender: TObject);
    procedure TransactionRepBtnClick(Sender: TObject);
    procedure IncExpBtnClick(Sender: TObject);
    procedure TrialBalBtnClick(Sender: TObject);
    procedure FullNomBtnClick(Sender: TObject);
    procedure ActualCashBtnClick(Sender: TObject);
    procedure CashflowVBudgetBtnClick(Sender: TObject);
    procedure CashFlowVBudgetYearBtnClick(Sender: TObject);
    procedure ProfitAndLossBtnClick(Sender: TObject);
    procedure ManagementBalBtnClick(Sender: TObject);
    procedure ThisYearVBudgetBtnClick(Sender: TObject);
    procedure CostPerUnitBtnClick(Sender: TObject);
    procedure InvoiceSummBtnClick(Sender: TObject);
    procedure Thisyearversuslast3years1Click(Sender: TObject);
    procedure NewReportsClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure ThisMonthVBudgetBtnClick(Sender: TObject);
    procedure sbSetupBudgetsClick(Sender: TObject);
    procedure sbBudgetReportsClick(Sender: TObject);
    procedure AnalysisSummaryReport1Click(Sender: TObject);
    procedure AnalysisCodeBreakdownReport1Click(Sender: TObject);
    procedure ChequeJnlBtnClick(Sender: TObject);
    procedure ProductCodeSummary1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure miEntSummaryThisYrVslast3YrClick(Sender: TObject);
    procedure ThisYearMonthly2Click(Sender: TObject);
    procedure LastYearMonthly2Click(Sender: TObject);
    procedure CostingReportThisYear1Click(Sender: TObject);
    procedure ThisYearVsPreviousYears1Click(Sender: TObject);
    procedure LastYearMonthly3Click(Sender: TObject);
    procedure ThisYearMonthly3Click(Sender: TObject);
    procedure ThisYearVsLastYear1Click(Sender: TObject);
    procedure ProductListing1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbShowKeyReportMenuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pmiBankAuditTrailRepClick(Sender: TObject);
    procedure pmiBankTransactionRepClick(Sender: TObject);
    procedure StandardVATReportBtnClick(Sender: TObject);
    procedure DigitalVATBtnClick(Sender: TObject);
    procedure NewVATBtnClick(Sender: TObject);
    procedure ViewSubmittedReturns1Click(Sender: TObject);
  private
    { Private declarations }
    procedure ButtonControl(Sender: TObject);
    procedure CheckCustSupp;
    procedure ShowKeyReportMenu(const AOverrideDefault : Boolean);
    function CanShowKeyReports : Boolean;
    function GetReportScreenCaption : string;
    procedure PrintBankAuditTrail;
    procedure PrintBankTransactionListingRep;
    procedure ShowVatReport;
  public
    { Public declarations }
    DataBase : Integer;
    DisableKeyReportsInvocation : Boolean;
  end;

var
  NewRepForm: TNewRepForm;
//  CompletedBefore:boolean;
  TheRegistry:TRegistry;
  EnterpriseSummaryOption : integer;

Const
     test : integer = 4;

implementation
uses
  Calcs,
  Util,
  Clears,
  DBCore,
  defsecfl,
  accsdata,
  Entreps,
  Cashflow,
  RcsInv,
  RcsList,
  NomRpt,
  Vars,
  Types,
  Stat,
  Printset,
  params, NomReps, NewClass, uBudgets, BudgetReportForm, SetupBudgetReports, chequeJournal, calculatemonths, dataexport,
  Mainunit, casha, ProductListing, uReports, uPreferences,
  uPreferenceConsts, uAccsSystem, uDigitalVATForm,
  uVATSubmissionReportForm;   // Ch006
{$R *.DFM}

function CompletedBefore:boolean;

begin
     CompletedBefore:=false;
     TheRegistry:=Tregistry.create;
     TheRegistry.OpenKey('Software\Kingswood\Kingsacc\Euro',true);
     If TheRegistry.readstring(VarToStr(accsdata.accsdatamodule.accsdatabase.aliasname)) = 'Completed' then begin
        CompletedBefore:=true;
//        stat.StatementForm.ShowEuroTotals.enabled:=false;
     end;
     TheRegistry.free;

end;
procedure TNewRepForm.ButtonControl(Sender: TObject);
begin
   With NewRepForm Do
     If ( CheckReps.Checked = False ) Then
          Begin
               ProfitAndLossBtn.Top := ActualCashBtn.Top;       //financial
          //     ManagementBalBtn.Top := CashFlowVBudgetBtn.Top;
               if cash1.XCASHBOOK then begin
                       ChequeJnlbtn.Top := TransactionRepBtn.Top;
                       TrialBalBtn.Top := IncExpBtn.Top;
                       FullNomBtn.Top := BankAuditBtn.Top;
               end else begin
                           TrialBalBtn.Top := TransactionRepBtn.Top;      // audit
                           FullNomBtn.Top := IncExpBtn.Top;
                   end;
   //            ThisYearVPrevBtn.Top := CostingRepBtn.Top;
   //            ThisYearBtn.Top := 73; //56;
   //            CostPerUnitBtn.Top := 101; //85;  //ThisYearVBudgetBtn.Top;
               AgeOfDebtBtn.Top := AccListingBtn.Top;
               LedgerCardsBtn.Top := 128; //92 //84;      // TGM AB 27/01/17
               StatementsBtn.Top := 92;                   // TGM AB 27/01/17
          End
     Else
          Begin
               ProfitAndLossBtn.Top := 48;   //110
         //      ManagementBalBtn.Top := 140;
               if cash1.XCASHBOOK then begin
                           TrialBalBtn.Top := 106;    //114
                           FullNomBtn.Top := 134;
                           ChequeJnlbtn.top := 164;

               end else begin
                           TrialBalBtn.Top := 106;    //114
                           FullNomBtn.Top := 134;  //142
               end;
      //         ThisYearVPrevBtn.Top := 44;
      //         ThisYearBtn.Top := 73;
      //         ThisYearBtn.Top := 101; //113;  //140
      //         CostPerUnitBtn.Top := 129; //141;  //168
               AgeOfDebtBtn.Top := 92; //84;
               LedgerCardsBtn.Top := 316; //297
               StatementsBtn.Top := 288;            // TGM AB 27/01/17
          End;

end;

procedure TNewRepForm.AccListingBtnClick(Sender: TObject);
begin
   SetupReport(rpCustomerAccountListing);
   if CustSuppListing <> nil then
      try
         FreeAndNil(CustSuppListing);
      except
      end;
   Application.CreateForm(TCustSuppListing, CustSuppListing);
   CheckCustSupp;
   Act := 1;
   CustSuppListing.Caption := 'Account Listing';{ + ' - ' + st;}
   CustSuppListing.ShowModal;
end;

procedure TNewRepForm.AgeOfDebtBtnClick(Sender: TObject);
begin
   SetupReport(rpCustomerAgeOfDebt);
   if CustSuppListing <> nil then
      try
         FreeAndNil(CustSuppListing);
      except
      end;
   Application.CreateForm(TCustSuppListing, CustSuppListing);
   CheckCustSupp;
   Act := 2;
   CustSuppListing.Caption := 'Age Of Debt';{ + ' - ' + st;}
   CustSuppListing.ShowModal;
end;

procedure TNewRepForm.InvoiceListingBtnClick(Sender: TObject);
begin
   SetupReport(rpCustomerInvoiceListing);
   CheckCustSupp;
   Act := 5;
   RcsInv.CustSuppInvListing.Caption := 'Invoice Listing';{ + ' - ' + st;}
   RcsInv.CustSuppInvListing.ShowModal;
end;

procedure TNewRepForm.PaymentListingBtnClick(Sender: TObject);
begin
     SetupReport(rpCustomerPaymentListing);
     CheckCustSupp;
     Act := 6;
     RcsInv.CustSuppInvListing.Caption := 'Payment Listing';{ + ' - ' + st;}
     RcsInv.CustSuppInvListing.ShowModal;
end;

procedure TNewRepForm.CreditNoteBtnClick(Sender: TObject);
begin
     SetupReport(rpCustomerCreditNoteListing);
     CheckCustSupp;
     Act := 7;
     RcsInv.CustSuppInvListing.Caption := 'Credit Note Listing';{ + ' - ' + st;}
     RcsInv.CustSuppInvListing.ShowModal;
end;

procedure TNewRepForm.TransactionSummBtnClick(Sender: TObject);
begin
     SetupReport(rpCustomerTransactionSummary);
     CheckCustSupp;
     Act := 8;
     RcsInv.CustSuppInvListing.Caption := 'Transaction Summary';{ + ' - ' + st;}
     RcsInv.CustSuppInvListing.ShowModal;
end;

procedure TNewRepForm.StatementsBtnClick(Sender: TObject);
begin
     SetupReport(rpStatements);
     if CustRadio.Checked then
        PROG := CUSTSTM
     else
        PROG := SUPPSTM;
     Act := 9;
     Stat.StatementForm.bStatementSetup.visible := true;
     Stat.StatementForm.Caption := 'Statements';{ + ' - ' + st;}
     Stat.StatementForm.ShowModal;
end;

procedure TNewRepForm.LedgerCardsBtnClick(Sender: TObject);
begin
     SetupReport(rpLedgerCards);
     if CustRadio.Checked then
        PROG := CUSTLED
     else
        PROG := SUPPLED;
     Act := 10;
     Stat.StatementForm.bStatementSetup.visible := false;
     stat.StatementForm.ShowEuroTotals.visible:=true;
     Stat.StatementForm.Caption := 'Ledger Cards';{ + ' - ' + st;}
     Stat.StatementForm.ShowModal;
end;

procedure TNewRepForm.RecordCardsBtnClick(Sender: TObject);
begin
     SetupReport(rpRecordCards);
     if CustRadio.Checked then
        PROG := CUSTREC
     else
        PROG := SUPPREC;
     Act := 11;
     Stat.StatementForm.bStatementSetup.visible := false;
     stat.StatementForm.ShowEuroTotals.visible:=false;
     Stat.StatementForm.Caption := 'Record Cards';{ + ' - ' + st;}
     Stat.StatementForm.ShowModal;
end;

procedure TNewRepForm.FormShow(Sender: TObject);
var i: integer;
begin
   cbShowKeyReportMenu.OnClick := nil;
   cbShowKeyReportMenu.Visible := (AccsSystem.SystemType = stCashbook);
   if not cbShowKeyReportMenu.Visible then
      cbShowKeyReportMenu.Checked := False
   else
      begin
         cbShowKeyReportMenu.Checked := Preferences.ValueAsBoolean[cPref_ShowKeyReportsMenu];
      end;
   cbShowKeyReportMenu.OnClick := cbShowKeyReportMenuClick;



        If not (screen.Width > 800) then begin
        Top := 0;
        Left := 0;
     end;
{     setDB(NLFile);
     for i := DB1.DBRecHigh downto 1 do begin
          readrec(NLFile,i);
          getitem(NLfile,5);
          if not (currint > 0) then begin
             currint := i;
             putitem(NLfile,5);
             rewriterec(NLfile,i);
          end;
          ReadTables ( NlFile, i , CurrStr );
          SlimAll(CurrStr);
          if currstr = '' then begin
             readrec(NLFile,i);
             getitem(NLFile,1);
             writetables( NLFile,i,CurrStr);
          end;
      end;
 }





    if Cash11.xuse_inc_exp then
       IncExpBtn.Hide
    Else
       IncExpBtn.Show;

    if Cash1.xCashbook then begin           // Cust Supp Reps
       GCustSupp.Hide;
       ChequeJnlBtn.show;
    end else
        begin
            ChequeJnlBtn.hide;
            GCustSupp.Show;
            CustRadio.Checked := True;
            if Cash11.xBilling then
               begin
                  StatementsBtn.Hide;
                  RecordCardsBtn.Hide;
                  InvoiceSummBtn.Hide;
               end
            else
               begin
                  StatementsBtn.Show;
                  RecordCardsBtn.Show;
                  InvoiceSummBtn.Show;
               end;
       End;
    if Cash11.xUse_Enterprise then begin   // Enterprise Reps
       GEnt.Hide;
       GBudgets.hide;
       end
    Else begin
       GEnt.Show;
       GBudgets.show;
       end;
    If Cash11.Xuse_vat then           // Vat Rep
       GVAT.hide
    else
       GVAT.Show;

    // Ch006
    NewVATBtn.DropDownMenu := nil;
    NewVATBtn.Caption := 'VAT Report';
    if ( cash2.xcountry = 1 ) then
       begin
          NewVATBtn.DropDownMenu := VATPopupMenu;
          NewVATBtn.Caption := 'VAT Reports';
       end;
    {
    if (cash2.xcountry =  2) then DigitalVATBtn.visible := false
                else DigitalVATBtn.visible := true;
    }
  //  If ( Cash2.xCountry = 2 ) Then DigitalVATBtn.Caption := 'View VAT Report && Close Period'
  //      else  DigitalVATBtn.Caption := 'Digital VAT Return';

    // Ch006 end

    Device[1] := 'F';
    CheckRepsClick( Sender );
end;

procedure TNewRepForm.CheckRepsClick(Sender: TObject);
begin
     if CheckReps.Checked Then /////// THIS WILL SHOW ALL BTNS
        Begin

             ActualCashBtn.Show;
             CashFlowVBudgetBtn.Show;
           //  ThisYearVBudgetBtn.Show;
             sbOverheads.Show;

             TransactionRepBtn.Show;// Accountants / Audit Reps
             if Not (Cash11.xuse_inc_exp ) then
                IncExpBtn.Show;
             BankAuditBtn.Show;

             If GEnt.Visible Then    // Show Enterprise Reps
                Begin
                     sbAnalysis.Show;
   //                  CostingRepBtn.Show;
                     CashFlowVBudgetYearBtn.Show;
                     Enterprisereports.show;
                     ThisYearVBudgetBtn.Show;
                     ThisMonthVBudgetBtn.Show;
   //                  LastYearBtn.Show;
        //             EntSummaryBtn.show;

                End
             Else
                Begin
                     sbAnalysis.Hide;
                     Enterprisereports.hide;
    //                 CostingRepBtn.Hide;
                     ThisYearVBudgetBtn.Hide;
                     ThisMonthVBudgetBtn.Hide;
    //                 LastYearBtn.hide;
       //              EntSummaryBtn.hide;

                End;

             If GCustSupp.Visible Then   // Hide CustSupp
                Begin
                     //sbAnalysis.Show;
                     AcclistingBtn.Show;
                     InvoiceListingBtn.Show;
                     PaymentListingBtn.Show;
                     CreditNoteBtn.Show;
                     TransactionSummBtn.Show;

                     if Cash11.xBilling then
                        begin
                           StatementsBtn.Hide;
                           RecordCardsBtn.Hide;
                           InvoiceSummBtn.Hide;
                        end
                     else
                        begin
                           StatementsBtn.Show;
                           RecordCardsBtn.Show;
                           InvoiceSummBtn.Show;
                        end;
                End
             Else
                Begin
                     AcclistingBtn.Hide;
                     InvoiceListingBtn.Hide;
                     PaymentListingBtn.Hide;
                     CreditNoteBtn.Hide;
                     TransactionSummBtn.Hide;
                     StatementsBtn.Hide;
                     RecordCardsBtn.Hide;
                     InvoiceSummBtn.Hide;
                     //sbAnalysis.Hide;
                End;
             ButtonControl(Sender);
        End
     Else  ////////// THIS ELSE WILL HIDE UNNEEDED OPTIONS - BASIC MENU
         Begin


             ActualCashBtn.Hide;              // Financial
             CashFlowVBudgetBtn.Hide;
             sbOverheads.Hide;
             sbAnalysis.Hide;

             TransactionRepBtn.Hide;             // Accountants / Audit Reps
             IncExpBtn.Hide;
             BankAuditBtn.Hide;
             CashFlowVBudgetYearBtn.Hide;
             ThisYearVBudgetBtn.hide;
             ThisMonthVBudgetBtn.Hide;

             If GEnt.Visible Then    // Hide Enterprise Reps
                Begin
       //              CostingRepBtn.Hide;
       // TGM AB              Enterprisereports.hide;
       //              LastYearBtn.Hide;
       //              EntSummaryBtn.Hide;
                End
             Else
                Begin
       //              CostingRepBtn.Show;
       //              LastYearBtn.Show;
                     Enterprisereports.show;
       //              EntSummaryBtn.show;
                End;

             If GCustSupp.Visible Then           // Hide CustSupps
                Begin
                     AcclistingBtn.Hide;
                     InvoiceListingBtn.Hide;
                     PaymentListingBtn.Hide;
                     CreditNoteBtn.Hide;
                     TransactionSummBtn.Hide;
                //     StatementsBtn.Hide;               // TGM AB 27/01/17 show the statement button now as default
                     RecordCardsBtn.Hide;
                     InvoiceSummBtn.Hide;
                End
             Else
                 Begin
                     AcclistingBtn.Show;
                     InvoiceListingBtn.Show;
                     PaymentListingBtn.Show;
                     CreditNoteBtn.Show;
                     TransactionSummBtn.Show;
                End;
             ButtonControl(Sender);
         End;
   Caption := GetReportScreenCaption;
end;

procedure TNewRepForm.AccListingBtnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
     if ( Sender is TSpeedButton ) then
        begin
           StatusBar.Panels.Items[2].Text := ( Sender as TSpeedButton ).Caption;
           ( Sender as TSpeedButton ).Hint := StatusBar.Panels.Items[2].Text;
        end
     else if ( Sender is TRXSpeedButton ) then
        begin
           StatusBar.Panels.Items[2].Text := ( Sender as TRXSpeedButton ).Caption;
           ( Sender as TRXSpeedButton ).Hint := StatusBar.Panels.Items[2].Text;
        end
end;

procedure TNewRepForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     StatusBar.Panels.Items[2].Text := '';
end;

procedure TNewRepForm.VATBtnClick(Sender: TObject);
begin
     SetupReport(rpVatReport);
     DataBase := NlFile;
     NominalReportForm.MainGridVatSumChecked := False;
     NominalReportForm.SetNominalReportForm(VatReport);
     NominalReportForm.ShowModal;
end;

procedure TNewRepForm.HelpClick(Sender: TObject);
begin
     //Application.HelpContext(180);
     AccsDataModule.HTMLHelp('reports.htm');
end;

procedure TNewRepForm.PrinterBtnClick(Sender: TObject);
begin
     PrintForm.ShowModal;
end;

procedure TNewRepForm.TransactionRepBtnClick(Sender: TObject);
begin
     SetupReport(rpTransactionReport);
     PROG := AnnBud;
     DataBase := NlFile;
     NominalReportForm.SetNominalReportForm(TxList);
     NominalReportForm.ShowModal;
end;

procedure TNewRepForm.IncExpBtnClick(Sender: TObject);
begin
     SetupReport(rpCashBookIncomeExpenditure);
     PROG := AnnBud;
     DataBase := NlFile;
     NominalReportForm.SetNominalReportForm(CashIncExp);
     NominalReportForm.ShowModal;
end;

procedure TNewRepForm.TrialBalBtnClick(Sender: TObject);
begin
     SetupReport(rpTrialBalance);
     PROG := AnnBud;
     DataBase := NlFile;
     NominalReportForm.SetNominalReportForm(TrialBalance);
     NominalReportForm.ShowModal;
end;

procedure TNewRepForm.FullNomBtnClick(Sender: TObject);
begin
     SetupReport(rpFullNominalAuditTrail);
     PROG := AnnBud;
     DataBase := NlFile;
     NominalReportForm.SetNominalReportForm(FullNomAudit);    // FullAudit Changed to FullNomAudit TGM AB 27/02/02
     NominalReportForm.ShowModal;
end;

procedure TNewRepForm.ActualCashBtnClick(Sender: TObject);
begin
     SetupReport(rpActualCashFlowToDate);
     Act := 1;
     PROG := AnnBud;
     DataBase := NlFile;
     CashFlow.CashFlowReportsForm.Caption := 'Actual Cash Flow To Date';{ + ' - ' + st;}
     CashFlow.CashFlowReportsForm.Enabled := True;
     RFarmGate.PLINESPAGE[1] := 50;
     CashFlowReportsForm.ShowModal;
     RFarmGate.PLINESPAGE[1] := 62;
end;

procedure TNewRepForm.CashflowVBudgetBtnClick(Sender: TObject);
begin
     SetupReport(rpCashFlowVsBudgetThisMonth);
     Act := 2;
     PROG := AnnBud;
     DataBase := NlFile;
     CashFlowReportsForm.Caption := 'Cash Versus Budget - This Month';{ + ' - ' + st;}
     CashFlowReportsForm.Enabled := True;
     CashFlowReportsForm.CalMonthLabel.Show;
     CashFlowReportsForm.CalMonth.Show;
     CashFlowReportsForm.ShowModal;
end;

procedure TNewRepForm.CashFlowVBudgetYearBtnClick(Sender: TObject);
begin
     SetupReport(rpCashFlowVsBudgetThisYear);
     RFarmGate.PLinesPage[1] := 50;
     Act := 3;
     PROG := AnnBud;
     DataBase := NlFile;
     CashFlow.CashFlowReportsForm.Caption := 'Cash Versus Budget - This Year';{ + ' - ' + st;}
     CashFlow.CashFlowReportsForm.Enabled := True;
     CashFlow.CashFlowReportsForm.CalMonthLabel.Show;
     CashFlow.CashFlowReportsForm.CalMonth.Show;
     RFarmGate.PLINESPAGE[1] := 50;
     CashFlowReportsForm.ShowModal;
     RFarmGate.PLINESPAGE[1] := 62;
end;

procedure TNewRepForm.ProfitAndLossBtnClick(Sender: TObject);
begin
     SetupReport(rpProfitAndLoss);
     Act := 24;
     PROG := AnnBud;
     DataBase := NlFile;
     CashFlow.CashFlowReportsForm.Caption := 'Profit And Loss Account';{ + ' - ' + st;}
     CashFlowReportsForm.ShowModal;
end;

procedure TNewRepForm.ManagementBalBtnClick(Sender: TObject);
begin
     DataBase := NlFile;
     NominalReportForm.SetNominalReportForm(ManBalSheet);
     RFarmGate.PLINESPAGE[1] := 50;
     NominalReportForm.ShowModal;
     RFarmGate.PLINESPAGE[1] := 62;
end;

procedure TNewRepForm.ThisYearVBudgetBtnClick(Sender: TObject);
begin
     SetupReport(rpThisYearVsBudgetAndLastYear);
     Database := EntFile;
     Prog := EntRep;
     Act := 3;//     EntReportForm.EntThisYearVBudAndLastYearRadio.Checked := True;
     EntCostPerUnit.ShowModal;
end;

procedure TNewRepForm.CostPerUnitBtnClick(Sender: TObject);
begin
     SetupReport(rpCostPerUnit);
     Database := EntFile;
     Prog := EntRep;
     Act := 6;//     EntReportForm.EntPerUnitRadio.Checked := True;
     EntCostPerUnit.ShowModal;
end;

procedure TNewRepForm.InvoiceSummBtnClick(Sender: TObject);
begin
//     If CompletedBefore then stat.StatementForm.ShowEuroTotals.enabled:=false else
//        if newreports.checked = true then stat.StatementForm.ShowEuroTotals.enabled:=true;
     stat.StatementForm.ShowEuroTotals.visible:=false;
     SetupReport(rpInvoiceSummary);
     if CustRadio.Checked then
        PROG := CUSTSUM
     else
        PROG := SUPPSUM;
     Act := 911;
     Stat.StatementForm.bStatementSetup.visible := false;
     Stat.StatementForm.Caption := 'Invoice Summary';{ + ' - ' + st;}
     Stat.StatementForm.ShowModal;
end;

procedure TNewRepForm.CheckCustSupp;
begin
   if CustSuppListing <> nil then
      try
         FreeAndNil(CustSuppListing);
      except
      end;
   Application.CreateForm(TCustSuppListing, CustSuppListing);
   if CustRadio.Checked then
      begin
         PROG := CustRep;
         DataBase := SLFile;
         CustSuppListing.RepType := Customer;
      end
   else
      begin
         PROG := SUPPrep;
         DataBase := PLFile;
         CustSuppListing.RepType := Supplier;
      end;
end;

procedure TNewRepForm.Thisyearversuslast3years1Click(Sender: TObject);
begin
     RFarmGate.PLINESPAGE[1] := 70;
     Act := 5;
     PROG := AnnBud;
     DataBase := NlFile;

     if (Sender is TMenuItem) then
        begin
           case (Sender as TMenuItem).tag of
                1 : SetupReport(rpOverheadThisYearOnly);
                3 : SetupReport(rpOverheadThisYearVsLastYear);
                2 : SetupReport(rpOverheadThisYearVsLastThreeYears);
                4 : SetupReport(rpOverheadThisYearMonthly);
                5 : SetupReport(rpOverheadLastYearMonthly);
           end;
           if Cash11.Xuse_enterprise then
              CashFlowReportsForm.Caption := 'Income - ' + (Sender as TMenuItem).Caption
           else
              CashFlowReportsForm.Caption := 'Overheads - ' + (Sender as TMenuItem).Caption
        end
     else
        CashFlowReportsForm.Caption := 'Overheads';
     CashFlowReportsForm.Enabled := True;
     if (Sender is TMenuItem) then
        CashFlowReportsForm.SecondOption := (Sender as TMenuItem).Tag
     else
        CashFlowReportsForm.SecondOption := 0;

     CashFlowReportsForm.ShowModal;
     RFarmGate.PLINESPAGE[1] := 62;
end;

procedure TNewRepForm.NewReportsClick(Sender: TObject);

begin
     If (NewReports.checked and (not CompletedBefore)) then begin
        Stat.StatementForm.ShowEuroTotals.enabled:=true;
     end else begin
        Stat.StatementForm.ShowEuroTotals.enabled:=false;
     end;
end;

procedure TNewRepForm.ExitButtonClick(Sender: TObject);
begin
     if ((param_start = true) and not (param_type = 'M')) then application.terminate; //TGM AB 12/03/02
end;






procedure TNewRepForm.ThisMonthVBudgetBtnClick(Sender: TObject);
begin
     SetupReport(rpThisMonthVsBudgetAndLastYear);
     Database := EntFile;
     Prog := EntRep;
     Act := 3;//     EntReportForm.EntThisYearVBudAndLastYearRadio.Checked := True;
     EntCostPerUnit.ShowModal;
end;

procedure TNewRepForm.sbSetupBudgetsClick(Sender: TObject);
begin
     TfmBudgets.ShowBudget;
end;

procedure TNewRepForm.sbBudgetReportsClick(Sender: TObject);
begin
     if not Bool(SetupBudgetReports.SetupBudgetReportsForm) then Application.CreateForm(TSetupBudgetReportsForm, SetupBudgetReportsForm);
     SetupBudgetReportsForm.ShowModal;
end;

procedure TNewRepForm.AnalysisSummaryReport1Click(Sender: TObject);
begin
   SetupReport(rpCustomerAnalysis);
   if CustSuppListing <> nil then
      try
         FreeAndNil(CustSuppListing);
      except
      end;
   Application.CreateForm(TCustSuppListing, CustSuppListing);
   CheckCustSupp;
   Act := 10;
   case PROG of
      CustRep : CustSuppListing.Caption := 'Sales Analysis Listing';
      SuppRep : CustSuppListing.Caption := 'Purchase Analysis Listing';
   end;
   ProductReport := false;
   CustSuppListing.ShowModal;
end;

procedure TNewRepForm.AnalysisCodeBreakdownReport1Click(Sender: TObject);
begin
   SetupReport(rpCustomerAnalysis);
   if CustSuppListing <> nil then
      try
         FreeAndNil(CustSuppListing);
      except
      end;
   Application.CreateForm(TCustSuppListing, CustSuppListing);
   CheckCustSupp;
   Act := 10;
   case PROG of
      CustRep : CustSuppListing.Caption := 'Analysis Code Breakdown';
      SuppRep : CustSuppListing.Caption := 'Analysis Code Breakdown';
   end;
   Breakdownreport := True;
   ProductReport := false;
   CustSuppListing.ShowModal;
end;

procedure TNewRepForm.ChequeJnlBtnClick(Sender: TObject);
begin
  if not bool(ChequeJournalForm) then Application.CreateForm(TChequeJournalForm, ChequeJournalForm);
     ChequeJournalForm.show;
end;

procedure TNewRepForm.ProductCodeSummary1Click(Sender: TObject);
begin
   SetupReport(rpCustomerAnalysis);
   if CustSuppListing <> nil then
      try
         FreeAndNil(CustSuppListing);
      except
      end;
   Application.CreateForm(TCustSuppListing, CustSuppListing);
   CheckCustSupp;
   Act := 10;
   case PROG of
      CustRep : CustSuppListing.Caption := 'Sales Analysis Listing';
      SuppRep : CustSuppListing.Caption := 'Purchase Analysis Listing';
   end;
   ProductReport := true;
   CustSuppListing.ShowModal;
end;

procedure TNewRepForm.MenuItem1Click(Sender: TObject);
begin
     CalculateMonths.CalculateMonthlyValues;
     Calculatemonths.UpdateNLMonthlyFigures;
     SetupReport(rpEntSummary1);
     Act := 4;
     PROG := AnnBud;
     DataBase := NlFile;
     RFarmGate.PLINESPAGE[1] := 80;
     EnterpriseSummaryOption := 1;
     CashFlowReportsForm.ShowModal;
   //  CashA.RunCashFlow(4,1);
     RFarmGate.PLINESPAGE[1] := 62;
end;

procedure TNewRepForm.MenuItem2Click(Sender: TObject);
begin
     CalculateMonths.CalculateMonthlyValues;
     Calculatemonths.UpdateNLMonthlyFigures;
     SetupReport(rpEntSummary2);
     Act := 4;
     PROG := AnnBud;
     DataBase := NlFile;
     //CashFlow.CashFlowReportsForm.Caption := 'Actual Cash Flow To Date';{ + ' - ' + st;}
     //CashFlow.CashFlowReportsForm.Enabled := True;
     RFarmGate.PLINESPAGE[1] := 80;
     EnterpriseSummaryOption := 3;
     CashFlowReportsForm.ShowModal;
   //  CashA.RunCashFlow(4,3);
     RFarmGate.PLINESPAGE[1] := 62;
end;

procedure TNewRepForm.miEntSummaryThisYrVslast3YrClick(Sender: TObject);
begin
     CalculateMonths.CalculateMonthlyValues;
     Calculatemonths.UpdateNLMonthlyFigures;
     SetupReport(rpEntSummary3);
     Act := 4;
     PROG := AnnBud;
     DataBase := NlFile;
     //CashFlow.CashFlowReportsForm.Caption := 'Actual Cash Flow To Date';{ + ' - ' + st;}
     //CashFlow.CashFlowReportsForm.Enabled := True;
     RFarmGate.PLINESPAGE[1] := 80;
     CashA.RunCashFlow(4,2);
     RFarmGate.PLINESPAGE[1] := 62;
end;

procedure TNewRepForm.ThisYearMonthly2Click(Sender: TObject);
begin
     CalculateMonths.CalculateMonthlyValues;
     Calculatemonths.UpdateNLMonthlyFigures;
     SetupReport(rpEntSummary4);
     Act := 4;
     PROG := AnnBud;
     DataBase := NlFile;
     //CashFlow.CashFlowReportsForm.Caption := 'Actual Cash Flow To Date';{ + ' - ' + st;}
    // CashFlow.CashFlowReportsForm.Enabled := True;
     RFarmGate.PLINESPAGE[1] := 55;
     CashA.RunCashFlow(4,4);
     RFarmGate.PLINESPAGE[1] := 62;
end;

procedure TNewRepForm.LastYearMonthly2Click(Sender: TObject);
begin
     CalculateMonths.CalculateMonthlyValues;
     Calculatemonths.UpdateNLMonthlyFigures;
     SetupReport(rpEntSummary5);
     Act := 4;
     PROG := AnnBud;
     DataBase := NlFile;
     //CashFlow.CashFlowReportsForm.Caption := 'Actual Cash Flow To Date';{ + ' - ' + st;}
     //CashFlow.CashFlowReportsForm.Enabled := True;
     RFarmGate.PLINESPAGE[1] := 55;          //62 made 55 to match this year monthly
     CashA.RunCashFlow(4,5);
     RFarmGate.PLINESPAGE[1] := 62;
end;



procedure TNewRepForm.CostingReportThisYear1Click(Sender: TObject);
begin
     SetupReport(rpCostingReportThisYear);
     Database := EntFile;
     Prog := EntRep;
     Act := 1; //     EntReportForm.EntCostThisYearRadio.Checked := True;
     EntCostPerUnit.ShowModal;
end;

procedure TNewRepForm.ThisYearVsPreviousYears1Click(Sender: TObject);
begin
     SetupReport(rpThisYearVsPrevYear);
     Database := EntFile;
     Prog := EntRep;
     Act := 2;//    EntReportForm.EntCostThisYearVLAstRadio.Checked := True;
     EntCostPerUnit.ShowModal;
end;

procedure TNewRepForm.LastYearMonthly3Click(Sender: TObject);
begin
     SetupReport(rpLastYearMonthly);
     Database := EntFile;
     Prog := EntRep;
     Act := 5;//     EntReportForm.LastYearMonthlyRadio.Checked := True;
     RFarmGate.PLINESPAGE[1] := 50;
     EntCostPerUnit.ShowModal;
     RFarmGate.PLINESPAGE[1] := 62;
end;

procedure TNewRepForm.ThisYearMonthly3Click(Sender: TObject);
begin
     SetupReport(rpThisYearMonthly);
     Database := EntFile;
     Prog := EntRep;
     Act := 4;//     EntReportForm.ThisYearMonthlyRadio.Checked := True;
     RFarmGate.PLINESPAGE[1] := 50;
     EntCostPerUnit.ShowModal;
     RFarmGate.PLINESPAGE[1] := 62;
end;

procedure TNewRepForm.ThisYearVsLastYear1Click(Sender: TObject);
begin
     Database := EntFile;
     Prog := EntRep;
     Act := 2000;
     EntCostPerUnit.ShowModal;
end;

procedure TNewRepForm.ProductListing1Click(Sender: TObject);
begin
    // TGM AB Product Listing Report
    if not bool(ProductListingReport) then Application.CreateForm(TProductListingReport, ProductListingReport);
    ProductListingReport.RunReport;
end;

procedure TNewRepForm.FormActivate(Sender: TObject);
begin
   if not DisableKeyReportsInvocation then
      begin
         ShowKeyReportMenu(false);
      end
   else
      begin
         DisableKeyReportsInvocation := False; // reset flag.
      end;
   // detach FormActivate event.
   OnActivate := nil;
end;

procedure TNewRepForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   // reattach FormActivate event.
   OnActivate := FormActivate;
end;

procedure TNewRepForm.cbShowKeyReportMenuClick(Sender: TObject);
begin
   if( cbShowKeyReportMenu.Checked )then
      begin
         Preferences.ValueAsBoolean[cPref_ShowKeyReportsMenu] := cbShowKeyReportMenu.Checked;
         ShowKeyReportMenu(true);
      end
   else
      Preferences.ValueAsBoolean[cPref_ShowKeyReportsMenu] := false;
end;

procedure TNewRepForm.ShowKeyReportMenu(const AOverrideDefault : Boolean);
begin
   cbShowKeyReportMenu.Visible := False;

   if not CanShowKeyReports then Exit;
   cbShowKeyReportMenu.Visible := True;

   if (AOverrideDefault) then
      TfmReports.ShowReports()
   else if (Preferences.ValueAsBoolean[cPref_ShowKeyReportsMenu]) then
      TfmReports.ShowReports();

   if not (Preferences.ValueAsBoolean[cPref_ShowKeyReportsMenu]) then
      cbShowKeyReportMenu.Checked := false;
end;

function TNewRepForm.CanShowKeyReports: Boolean;
begin
   Result := (AccsSystem.SystemType = stCashbook) and
               ((AccsSystem.SystemOptions = []) or
                (AccsSystem.SystemOptions = [soEnterprises]))
end;

function TNewRepForm.GetReportScreenCaption: string;
begin
   if not (CheckReps.Checked) then
      Result := 'Standard Reports'
   else
      Result := 'Extended Reports';
end;

procedure TNewRepForm.FormCreate(Sender: TObject);
begin
   Caption := GetReportScreenCaption;
   DisableKeyReportsInvocation := True;
end;

procedure TNewRepForm.PrintBankAuditTrail;
begin
     SetupReport(rpBankAuditTrail);
     PROG := AnnBud;
     DataBase := NlFile;
     NominalReportForm.SetNominalReportForm(BankAudit);
     NominalReportForm.ShowModal;
end;

procedure TNewRepForm.pmiBankAuditTrailRepClick(Sender: TObject);
begin
   PrintBankAuditTrail;
end;

procedure TNewRepForm.PrintBankTransactionListingRep;
begin
   PROG := AnnBud;
   DataBase := NlFile;
   NominalReportForm.SetNominalReportForm(BankTransListing);
   NominalReportForm.ShowModal;
end;

procedure TNewRepForm.pmiBankTransactionRepClick(Sender: TObject);
begin
   PrintBankTransactionListingRep;
end;

procedure TNewRepForm.StandardVATReportBtnClick(Sender: TObject);
begin
   ShowVatReport
end;

procedure TNewRepForm.DigitalVATBtnClick(Sender: TObject);
var
   LoginCredentials: TLoginCredentials;
begin
   // New Ch006

   SetupReport(rpVatReport);
   DataBase := NlFile;

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
end;

procedure TNewRepForm.ShowVatReport;
begin
     // New Ch006

     SetupReport(rpVatReport);
     DataBase := NlFile;

     NominalReportForm.MainGridVatSumChecked := False;
     NominalReportForm.SetNominalReportForm(VatReport);
     NominalReportForm.ShowModal;
end;

procedure TNewRepForm.NewVATBtnClick(Sender: TObject);
var
   pt : tPoint;
begin
   if ( cash2.xcountry = 2 ) then
      ShowVatReport
   else
      begin
         GetCursorPos(pt);
         VATPopupMenu.Popup(pt.x,pt.y);
      end;
end;

procedure TNewRepForm.ViewSubmittedReturns1Click(Sender: TObject);
begin
   TVATSubmissionReportForm.ShowTheForm(vtFromReports);
end;

end.
