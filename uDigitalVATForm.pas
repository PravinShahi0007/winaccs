unit uDigitalVATForm;

{
   Ch006 - New Form created for UK Digital VAT returns

   27/08/19 [V5.9 R0.1] /MK Change - actReportsExecute - Call class procedure TVATSubmissionReportForm.ShowTheForm and pass in ViewType.

   01/11/19 - /AB Change - added in tickbox at bottom of VAT panel to include Exempt VAT Code in Audit Trials - marked Ch017

   30/09/20 [V4.5 R4.1] /MK Change - SubmitReturn - If the user hasn't entered in the log in credentials into the System area then prompt the log in credentials - TGM request.
                                   - RetrieveReceiptFromAPI - Changed the assignment of LoginCredentials to Submit Return button so only check that LoginCredentials <> nil.

   06/10/20 [V4.5 R4.2] /MK Bug Fix - RetrieveReceiptFromAPI - Removed check for Username and Password that should be entered in the System area.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ComCtrls, ToolWin, StdCtrls, Buttons, ExtCtrls, Mask, Grids,
  DBGrids, Db, DBTables, RxLookup, ClipBrd, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxDBEdit, cxButtons, cxControls, cxContainer, cxEdit,
  cxGroupBox, ActnList, dxGDIPlusClasses, cxImage, cxLabel, dxBar,
  dxBarExtItems, cxHyperLinkEdit, cxStyles, cxMemo, uWinOS, HTTPApp,
  cxCheckBox, AccsData, uAccounts;

type
  TDigitalVATForm = class(TForm)
    Stage1IrlPanel: TGroupBox;
    Label25: TLabel;
    VatRepDate: TMaskEdit;
    VatRepDateSearch: TDateTimePicker;
    Stage2Panel: TGroupBox;
    PrintVatAuditReport: TCheckBox;
    RunBtn: TBitBtn;
    FiguresPanel: TGroupBox;
    IRLVATPanel: TPanel;
    Stage3Panel: TGroupBox;
    Label1: TLabel;
    SalesGrid: TStringGrid;
    PurchasesGrid: TStringGrid;
    Label2: TLabel;
    Stage4IRLPanel: TGroupBox;
    PreviewIRLReport: TBitBtn;
    CloseIRLPeriodBtn: TBitBtn;
    Stage4UKPanel: TGroupBox;
    PreviewUKReport: TBitBtn;
    VATReturnQuery: TQuery;
    VATReturnQueryDS: TDataSource;
    Stage5UKPanel: TGroupBox;
    PrintUKReturn: TBitBtn;
    EnableDebug: TCheckBox;
    CompleteUKReturn: TBitBtn;
    SubmitUKReturn: TBitBtn;
    CancelBtn: TBitBtn;
    NewRtnBtn: TBitBtn;
    gbSelectPeriod: TcxGroupBox;
    PeriodLookup: TRxDBLookupCombo;
    ActionList1: TActionList;
    actViewAuditTrail: TAction;
    actViewSubmissionReport: TAction;
    gbCompleteReturn: TcxGroupBox;
    actCompleteReturn: TAction;
    actPrintVATReturnReport: TAction;
    NIVatPanelold: TPanel;
    gbNIVatPanel: TcxGroupBox;
    box1lbl: TLabel;
    Box2lbl: TLabel;
    Box3lbl: TLabel;
    Box4lbl: TLabel;
    VATLabel: TLabel;
    Box6lbl: TLabel;
    Box7lbl: TLabel;
    Box8lbl: TLabel;
    Box9lbl: TLabel;
    Label4: TLabel;
    actCancelReturn: TAction;
    actNewReturn: TAction;
    btnCancelReturn: TcxButton;
    btnSubmitReturn: TcxButton;
    actSubmitReturn: TAction;
    gbReports: TcxGroupBox;
    btnPrintVATReturnReport: TcxButton;
    btnAuditTrailReport: TcxButton;
    btnViewSubmissionReport: TcxButton;
    pVATReturnSuccess: TPanel;
    cxImage1: TcxImage;
    pVATReturnError: TPanel;
    cxImage2: TcxImage;
    cxLabel2: TcxLabel;
    cxLabel1: TcxLabel;
    pCompleteReturn: TPanel;
    lEnterFormNumber: TLabel;
    Confirmation: TEdit;
    btnCompleteReturn: TcxButton;
    BarManager: TdxBarManager;
    blbExit: TdxBarLargeButton;
    blbSettings: TdxBarLargeButton;
    bbBankFileFormat: TdxBarButton;
    blbHelp: TdxBarLargeButton;
    dxBarButton1: TdxBarButton;
    blbAddLine: TdxBarLargeButton;
    actClose: TAction;
    blbReports: TdxBarLargeButton;
    actReports: TAction;
    actSettings: TAction;
    actHelp: TAction;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    dxBarSubItem1: TdxBarSubItem;
    lBundleNumber: TcxLabel;
    KingswoodMTDLink: TcxHyperLinkEdit;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    Box1: TcxTextEdit;
    Box3: TcxTextEdit;
    Box2: TcxTextEdit;
    Box4: TcxTextEdit;
    Box5: TcxTextEdit;
    Box6: TcxTextEdit;
    Box7: TcxTextEdit;
    Box8: TcxTextEdit;
    Box9: TcxTextEdit;
    gbConfigureClientCode: TcxGroupBox;
    ClientCodeTextEdit: TcxTextEdit;
    btnStoreClientCode: TcxButton;
    cxLabel6: TcxLabel;
    Label3: TLabel;
    actStoreClientCode: TAction;
    lNewSignupMessageText: TcxMemo;
	IncludeExemptCB: TcxCheckBox;
    pCompletionAPIWaiting: TPanel;
    cxImage3: TcxImage;
    RetrieveRecieptLabel: TcxLabel;
    btnRetrieveReceipt: TcxButton;
    blbSync: TdxBarLargeButton;
    actSync: TAction;
    procedure RunBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SalesGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure PurchasesGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure PreviewIRLReportClick(Sender: TObject);
    procedure VatRepDateSearchCloseUp(Sender: TObject);
    procedure VatRepDateSearchEnter(Sender: TObject);
    procedure CloseIRLPeriodBtnClick(Sender: TObject);
    procedure PreviewUKReportClick(Sender: TObject);
    procedure GenerateNIReport(IncConfirmation : Boolean);
    procedure PrintUKReturnClick(Sender: TObject);
    procedure CompleteUKReturnClick(Sender: TObject);
    procedure VatRepDateExit(Sender: TObject);
    procedure NewRtnBtnClick(Sender: TObject);
    procedure PeriodLookupChange(Sender: TObject);
    procedure actSubmitReturnExecute(Sender: TObject);
    procedure actCancelReturnExecute(Sender: TObject);
    procedure actViewAuditTrailExecute(Sender: TObject);
    procedure actViewSubmissionReportExecute(Sender: TObject);
    procedure actCompleteReturnExecute(Sender: TObject);
    procedure ConfirmationChange(Sender: TObject);
    procedure actPrintVATReturnReportExecute(Sender: TObject);
    procedure actReportsExecute(Sender: TObject);
    procedure actSettingsExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure blbHelpClick(Sender: TObject);
    procedure KingswoodMTDLinkClick(Sender: TObject);
    procedure ClientCodeTextEditPropertiesChange(Sender: TObject);
    procedure actStoreClientCodeExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnRetrieveReceiptClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    // 11/03/2019 - SP
    FReceiptCopied : Boolean;
    FSubmitAttempted : Boolean;
    FTransactionId : string;
    FHMRCProcessingTimeStamp : string;
    FHMRCPaymentIndicator : string;
    FHMRCBundleNumber : string;
    FReconcileActive : Boolean;
    FSubmissionCompletionPending : Boolean;
    FSubmissionPending: Boolean;
    FSecretKeyForClient: string;
    procedure ApplicationActivate(Sender: TObject);
    procedure MoveToStage(AStep: Integer);
    procedure SubmitReturn();
    procedure ViewAuditTrailReport();
    procedure CompleteReturn();
    function CustomMessageDlg(const ACaption: string;
       const AOKButtonCaption:string; const ACancelButtonCaption: string; AMsgDlgType: TMsgDlgType): Integer;
    procedure ProcessReceiptFromClipboard();
    procedure RetrieveReceiptFromAPI();
    function Reconcile() : TMTDReconcile;
    procedure CompleteUKVATReturn(const AConfirmationId: string; const AReconciled: Boolean = False);
    procedure StageAgentVATReturn(AStagedVATReturn: TMTDVATReturnRequest);
  public
    { Public declarations }
  end;

var
  DigitalVATForm: TDigitalVATForm;
  VATSpansYears : Boolean;
  AuditPreviewed : Boolean;   //Ch023

const
   NewSignupMessageText = 'If you have not yet received your Username and Password from Kingswood '+
                          'to enable you to log into the Kingswood MTD site, please email '+
                          'info@tgmsoftware.com, quoting your Name, VAT Number and your Customer Serial No: %d.';

implementation

Uses
   DigitalVAT, VARS, uVatAuditReport, Calcs, Clears, uVatReport, Types, uNIVatReport,
   UVATSetup, MD5, ShellApi, ActiveX, uVATSubmissionReportForm, AccsUtils,
   uAccsSystem, DbCore, Registry, uMTDApi, CredentialsStore, LoginCredentials,
   uLoginCredentials;

{$R *.DFM}

procedure TDigitalVATForm.RunBtnClick(Sender: TObject);
var
        st : shortstring;
        i : integer;
        runningnet, runningvat : real;
        LastSubmissionDate : TDateTime;
        TempInt : Integer;
        TempDate : TDateTime;
        TempDate2 : TDateTime;
        TestDate : Shortstring;
        Registry : TRegistry;    //Ch017

   Info : TVATReturnInfo;
   Msg: string;
begin
   Screen.Cursor := crHourGlass;
   Accsdatamodule.VATReturnDB.Open();
   if not Accsdatamodule.VATReturnDB.Locate('ReturnID',PeriodLookup.KeyValue,[]) then
      begin
         Screen.Cursor := crDefault;
         MessageDlg('Period key not found',mtError,[mbOK],0);
         Exit;
      end;

   FSubmissionPending := (AccsDataModule.MTDVATSubmissionReceiptPending(
    StrToDate(Accsdatamodule.VATReturnDB['ReturnStartDate']),
                       StrToDate(Accsdatamodule.VATReturnDB['ReturnEndDate'])));

   try
   // 11/03/2019 - SP
   FReceiptCopied := False;
   FSubmissionCompletionPending := False;
   FTransactionId := '';
   FHMRCProcessingTimeStamp := '';
   FHMRCPaymentIndicator := '';
   FHMRCBundleNumber := '';

   lBundleNumber.Caption := '';

   AuditPreviewed := False;   //Ch023   

        if cash2.xcountry = 1 then begin         // Northern Ireland

                if PeriodLookup.DisplayValue = '' then begin
                        Showmessage('Please Select a VAT Return Period');
                        Exit;
                end;

        end
             else begin

                 if VATRepDate.Text = '  /  /  ' then begin
                        Showmessage('Please Select a VAT Report Date');
                        Exit;
                end;

             end;

        VATSpansYears := True;         // 22/03/19 was False - should always look back at last years file

        // Start Ch017

        Registry:=Tregistry.Create;
        Registry.OpenKey('Software\Kingswood\Kingsacc\VATAuditDefaults', True);
        if IncludeExemptCB.checked = true then Registry.WriteString('NIMTDIncExempt','True')
                else Registry.WriteString('NIMTDIncExempt','False');
        Registry.Free;

        // End Ch017

        if gbSelectPeriod.Visible then begin
                 TempInt := PeriodLookup.KeyValue;
                 
                 Accsdatamodule.VATReturnDB.Locate('ReturnID',TempInt,[]);

                 if (cash2.xcountry = 1) then
                     begin
                     
                        Info := AccsDataModule.GetLastVATReturnInfo();
                        if (Info.IsPending) then
                           begin
                              if (Accsdatamodule.VATReturnDB['DisplayString'] <> Info.Period) then
                                 {begin
                                    Msg := Format('You have already made a submission for this period ''%s'', although '+ cCRLF +
                                                  'Kingswood Accounts did not receive the MTD receipt.' + cCRLFx2 +
                                                  'If you are confident that your VAT return for this period has been submitted successfully '+ cCRLF +
                                                  'to HMRC, you must copy the receipt details from within the Kingswood MTD website. Click ''Login'' to do this now, '+ cCRLF +
                                                  'otherwise you can attempt a new submission for selected period by clicking the ''Submit'' button.' +cCRLFx2 +
                                                  'If you require any further help, please contact TGM Software/Kingswood Computing.',[Info.Period]);

                                    if (CustomMessageDlg(Msg, 'Login', 'Submit', mtWarning) = mrOK) then
                                       begin
                                          ShellExecute(0, 'open', PChar(FMTDHomeURL + '/vat/submission/history'), nil, nil, SW_SHOWNORMAL);
                                          Exit;
                                       end;
                                    FSubmissionCompletionPending := True;
                                    // else
                                    // Allow user to attempt another submission for selected period.
                                 end
                              else}
                                 begin
                                    MessageDlg(Format('We''re sorry, but you cannot continue with this VAT return.' + cCRLFx2 +
                                                      'It appears you have submitted a VAT return to HMRC for period ''%s'','+ cCRLF +
                                                      'which has not been fully processed by Kingswood Accounts.' +cCRLFx2 +
                                                      'Please contact TGM Software/Kingswood Computing for help.',[Info.Period]),mtWarning,[mbOK],0);
                                    PeriodLookup.Enabled := True;
                                    Exit;
                                 end;
                           end;
                     end;

                 TempDate := Accsdatamodule.VATReturnDB['ReturnStartDate'];
                 TempDate2 := Accsdatamodule.VATReturnDB['ReturnEndDate'];

                 DigitalVAT.InitialiseReport(VarToStr(TempDate),VarToStr(TempDate2));

                 // check if period starts in previous year

                 TestDate := vartostr(Accsdatamodule.VATReturnDB['ReturnStartDate']);

        //         CheckDateRange ( TestDate, False, VATSpansYears, False )       22/03/19 - should always look back at last years file


        end else begin

                LastSubmissionDate := DigitalVAT.GetLastSubmissionDate;

                if strtodate(VATRepDate.Text) <= LastSubmissionDate then begin
                      showmessage('This date falls within an already closed VAT period');
                      exit;
                end;

                DigitalVAT.InitialiseReport('',VATRepDate.Text);
                VATSpansYears := False;
        end;

        if cash2.xcountry = 1 then begin          // UK

             if ((cash2.XAllocation) and (cash2.XPaymentVAT)) then begin      // Payment VAT
                     if ((Cash11.xSalesPaymentVAT <> 'Y') and (Cash11.xSalesPaymentVAT <> 'Y')) then begin
                        showmessage('Both Sales and Purchase VAT must be set to based Payment VAT');
                        exit;
                     end;

                     DigitalVAT.PaymentVatAuditTrail('S',False,0,VATSpansYears);
                     DigitalVAT.PaymentVatAuditTrail('P',False,0,VATSpansYears);


             end else begin     // Invoice VAT
                     DigitalVAT.InvoiceVatAuditTrail('S',False,0,VATSpansYears);
                     DigitalVAT.InvoiceVatAuditTrail('P',False,0,VATSpansYears);

                end;


        end else begin                            // Ireland

             if ((cash2.XAllocation) and (cash2.XPaymentVAT)) then begin

                     if cash11.xSalesPaymentVAT = 'Y' then DigitalVAT.PaymentVatAuditTrail('S',False,0,VATSpansYears)
                        else DigitalVAT.InvoiceVatAuditTrail('S',False,0,VATSpansYears);
                     if cash11.xPurchPaymentVAT = 'Y' then DigitalVAT.PaymentVatAuditTrail('P',False,0,VATSpansYears)
                        else DigitalVAT.InvoiceVatAuditTrail('P',False,0,VATSpansYears);

             end else begin

                     DigitalVAT.InvoiceVatAuditTrail('S',False,0,VATSpansYears);
                     DigitalVAT.InvoiceVatAuditTrail('P',False,0,VATSpansYears);

                end;

        end;




        if PrintVatAuditReport.checked then begin
                if not bool(VatAuditReport) then Application.CreateForm(TVatAuditReport, VatAuditReport);
                VatAuditReport.AccountsName.Caption := Cash1.XCOMPANY;
                VatAuditReport.KingswoodLbl.caption :=  'Kingswood Accounts ' + Verno;
                VatAuditReport.DataSet.Caption :=  Accsdata.AccsDataModule.AccsDataBase.AliasName;
                VatAuditReport.Range.Caption := 'VAT Period - ' + PeriodLookup.DisplayValue;
//                VatAuditReport.Preview;
        end;



        if cash2.xcountry = 1 then begin          // UK

                DigitalVAT.GenerateNIFigures;

                st := '';
                DoubleToStr (DigitalVAT.NICodeArray[0].Box1,st,'%8.2f', true, false, 20, True);
                slimleft (st);
                Box1.Text := st;
                st := '';
                DoubleToStr (DigitalVAT.NICodeArray[0].Box2,st,'%8.2f', true, false, 20, True);
                slimleft (st);
                Box2.Text := st;
                st := '';
                DoubleToStr (DigitalVAT.NICodeArray[0].Box3,st,'%8.2f', true, false, 20, True);
                slimleft (st);
                Box3.Text := st;
                st := '';
                DoubleToStr (DigitalVAT.NICodeArray[0].Box4,st,'%8.2f', true, false, 20, True);
                slimleft (st);
                Box4.Text := st;
                st := '';
                DoubleToStr (DigitalVAT.NICodeArray[0].Box5,st,'%8.2f', true, false, 20, True);
                slimleft (st);

                if pos('-',st) > 0 then begin
                     st := copy(st,2,length(st)-1);
                     VatLabel.Caption := '(Repayable)'
                end
                    else begin

                             VatLabel.Caption := '(Payable)'
                    end;

                Box5.Text := st;
                st := '';
                DoubleToStr (DigitalVAT.NICodeArray[0].Box6,st,'%8.2f', true, false, 20, True);
                slimleft (st);
                Box6.Text := st;
                st := '';
                DoubleToStr (DigitalVAT.NICodeArray[0].Box7,st,'%8.2f', true, false, 20, True);
                slimleft (st);
                Box7.Text := st;
                st := '';
                DoubleToStr (DigitalVAT.NICodeArray[0].Box8,st,'%8.2f', true, false, 20, True);
                slimleft (st);
                Box8.Text := st;
                st := '';
                DoubleToStr (DigitalVAT.NICodeArray[0].Box9,st,'%8.2f', true, false, 20, True);
                slimleft (st);
                Box9.Text := st;

                //NIVATPanel.Visible := True;
                //IRLVATPanel.Visible := False;

                //PrintUKReturn.enabled := False;
                //PreviewUKReport.enabled := True;
                //SubmitUKReturn.enabled := True;

        end
                else begin


                    SalesGrid.Cells[0,0] := 'VAT Code';
                    SalesGrid.Cells[1,0] := 'Rate';
                    SalesGrid.Cells[2,0] := 'Net Amount';
                    SalesGrid.Cells[3,0] := 'VAT Amount';

                    PurchasesGrid.Cells[0,0] := 'VAT Code';
                    PurchasesGrid.Cells[1,0] := 'Rate';
                    PurchasesGrid.Cells[2,0] := 'Net Amount';
                    PurchasesGrid.Cells[3,0] := 'VAT Amount';



                    // Fill in Sales Figures

                    runningnet := 0;
                    runningvat := 0;

                    for i:= 0 to 9 do Begin

                       SalesGrid.Cells[0,i+1] := DigitalVAT.VATCodeArray[i].VatCode;
                       SalesGrid.Cells[1,i+1] := DigitalVAT.VATCodeArray[i].VatRate;
                       st := '';
                       DoubleToStr (DigitalVAT.VATCodeArray[i].SalesNet,st,'%8.2f', true, false, 20, True);
                       slimleft (st);
                       SalesGrid.Cells[2,i+1] := st;

                       st := '';
                       DoubleToStr (DigitalVAT.VATCodeArray[i].SalesVat,st,'%8.2f', true, false, 20, True);
                       slimleft (st);
                       SalesGrid.Cells[3,i+1] := st;

                       Runningnet := Runningnet + DigitalVAT.VATCodeArray[i].SalesNet;
                       Runningvat := Runningvat + DigitalVAT.VATCodeArray[i].SalesVat;
                    End ;

                       SalesGrid.Cells[0,12] := 'Totals';

                       st := '';
                       DoubleToStr (Runningnet,st,'%8.2f', true, false, 20, True);
                       slimleft (st);
                       SalesGrid.Cells[2,12] := st;

                       st := '';
                       DoubleToStr (Runningvat,st,'%8.2f', true, false, 20, True);
                       slimleft (st);
                       SalesGrid.Cells[3,12] := st;


                    // Fill in Purchase Figures

                    runningnet := 0;
                    runningvat := 0;

                    for i:= 0 to 9 do Begin

                       PurchasesGrid.Cells[0,i+1] := DigitalVAT.VATCodeArray[i].VatCode;
                       PurchasesGrid.Cells[1,i+1] := DigitalVAT.VATCodeArray[i].VatRate;
                       st := '';
                       DoubleToStr (DigitalVAT.VATCodeArray[i].PurchNet,st,'%8.2f', true, false, 20, True);
                       slimleft (st);
                       PurchasesGrid.Cells[2,i+1] := st;

                       st := '';
                       DoubleToStr (DigitalVAT.VATCodeArray[i].PurchVat,st,'%8.2f', true, false, 20, True);
                       slimleft (st);
                       PurchasesGrid.Cells[3,i+1] := st;

                       Runningnet := Runningnet + DigitalVAT.VATCodeArray[i].PurchNet;
                       Runningvat := Runningvat + DigitalVAT.VATCodeArray[i].PurchVat;
                    End ;

                       PurchasesGrid.Cells[0,12] := 'Totals';

                       st := '';
                       DoubleToStr (Runningnet,st,'%8.2f', true, false, 20, True);
                       slimleft (st);
                       PurchasesGrid.Cells[2,12] := st;

                       st := '';
                       DoubleToStr (Runningvat,st,'%8.2f', true, false, 20, True);
                       slimleft (st);
                       PurchasesGrid.Cells[3,12] := st;




                       //NIVATPanel.Visible := False;
                       //IRLVATPanel.Visible := True;
                       //PreviewIRLReport.Enabled := True;
                       //CloseIRLPeriodBTn.Enabled := True;

                end;

       PeriodLookup.enabled := False;
       MoveToStage(2);

   finally
             Runbtn.enabled := False;

             Screen.Cursor := crDefault;
   end;

end;

procedure TDigitalVATForm.FormCreate(Sender: TObject);
var
        i : integer;
        sl: TStringList;
        FileName: string;
begin
   FSubmissionPending := False;
   lNewSignupMessageText.Text := Format(NewSignupMessageText, [PSysLongToDelphi ( Cash11.serial_no )]);

   // 11/03/2109 - SP
   FReceiptCopied := False;
   // Hook event to capture receipt details
   Application.OnActivate := ApplicationActivate;

   // 11/03/2109 - SP

   AuditPreviewed := False;   //Ch023

        VATRepDate.text := Cash1.xDate;

        If ( Cash2.xCountry = 2 ) Then DigitalVATForm.Caption := 'View VAT Report && Close Period'
              else  DigitalVATForm.Caption := 'Digital VAT Return';

        If ( Cash2.xCountry = 1 ) then begin


                if not fileexists(Accsdatamodule.AccsDataBase.Directory + 'DigitalVAT.xml') then begin

                        if not bool(VATSetupForm) then Application.CreateForm(TVATSetupForm, VATSetupForm);
                        Showmessage('This is the first time the Digital VAT report has been run please check / update report Set-up paramaters');
                        VATSetupForm.showmodal;

                end;


                // read VAT Periods from table - if none exist go into setup screen

                VATReturnQuery.DatabaseName := AccsDataModule.AccsDataBase.DatabaseName;

                VATReturnQuery.SQL.clear;
                VATReturnQuery.SQL.add('Select * from VATReturn where FinYear = "' + IntToStr(Cash1.xfinYear) + '"');
                VATReturnQuery.open;

                If VATReturnQuery.RecordCount = 0 then begin

                        if not bool(VATSetupForm) then Application.CreateForm(TVATSetupForm, VATSetupForm);
                        Showmessage('There are no VAT periods defined for the current finanical year - please set-up and confirm before continuing');
                        VATSetupForm.ShowPeriodsPanel := True;
                        VATSetupForm.showmodal;

                end;

                VATReturnQuery.close;
                VATReturnQuery.SQL.clear;
                VATReturnQuery.SQL.add('Select * from VATReturn where FinYear = "' + IntToStr(Cash1.xfinYear) + '" and SubmissionComplete = False');
                VATReturnQuery.open;

        end;



        if cash2.xcountry = 1 then begin        // UK
                self.caption := 'Digital VAT';
{                Stage1IRLPanel.Visible :=False;
                Stage1UKPanel.Visible :=True;
                Stage4IRLPanel.Visible :=False;
                Stage4UKPanel.Visible :=True;
                Stage5UKPanel.Visible :=True;
                PreviewUKReport.enabled := False;
                PrintUKReturn.enabled := False;
                SubmitUKReturn.enabled := False;
                CompleteUKReturn.enabled := False;
                }
                Confirmation.text := '';

        end
             else begin
             {
                    self.caption := 'VAT Report';
                    Stage1IRLPanel.Visible :=True;
                    Stage1UKPanel.Visible :=False;
                    Stage4IRLPanel.Visible :=True;
                    Stage4UKPanel.Visible :=False;
                    Stage5UKPanel.Visible :=False;
                    PreviewIRLReport.Enabled := False;
                    CloseIRLPeriodBTn.Enabled := False;
                  }
             end;
        Runbtn.enabled := true;

//        NIVATPanel.Visible := False;
//        IRLVATPanel.Visible := False;
//        actCancelReturn.enabled := True;
//        NewRtnBtn.enabled := False;
//        PeriodLookup.enabled := true;


   FReconcileActive := False;

   MoveToStage(1);
end;


procedure TDigitalVATForm.SalesGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  S: string;
  SavedAlign: word;
begin

  if ((ACol = 2) or (ACol = 3)) then begin
    S := SalesGrid.Cells[ACol, ARow];
    SavedAlign := SetTextAlign(SalesGrid.Canvas.Handle, TA_RIGHT);
    SalesGrid.Canvas.TextRect(Rect, Rect.Right - 2, Rect.Top + 2, S);
    SetTextAlign(SalesGrid.Canvas.Handle, SavedAlign);
  end;

end;

procedure TDigitalVATForm.PurchasesGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  S: string;
  SavedAlign: word;
begin

  if ((ACol = 2) or (ACol = 3)) then begin
    S := PurchasesGrid.Cells[ACol, ARow];
    SavedAlign := SetTextAlign(PurchasesGrid.Canvas.Handle, TA_RIGHT);
    PurchasesGrid.Canvas.TextRect(Rect, Rect.Right - 2, Rect.Top + 2, S);
    SetTextAlign(PurchasesGrid.Canvas.Handle, SavedAlign);
  end;

end;

procedure TDigitalVATForm.PreviewIRLReportClick(Sender: TObject);
var
        runningnet, runningvat : real;
        i : integer;
        st : shortstring;
begin
        if not bool(VatReport) then Application.CreateForm(TVatReport, VatReport);

        // sales

        runningnet := 0;
        runningvat := 0;

        VatReport.SalesVatCodes.Lines.Clear;
        VatReport.SalesVatRates.Lines.Clear;
        VatReport.SalesNetAmounts.Lines.Clear;
        VatReport.SalesVatAmounts.Lines.Clear;
        for I:= 0 to 9 do Begin
                       VatReport.SalesVatCodes.Lines.add(DigitalVAT.VATCodeArray[i].VatCode);
                       VatReport.SalesVatRates.Lines.add(DigitalVAT.VATCodeArray[i].VatRate);
                       st := '';
                       DoubleToStr (DigitalVAT.VATCodeArray[i].SalesNet,st,'%8.2f', true, false, 20, True);
                       slimleft (st);
                       VatReport.SalesNetAmounts.Lines.add(st);
                       st := '';
                       DoubleToStr (DigitalVAT.VATCodeArray[i].SalesVat,st,'%8.2f', true, false, 20, True);
                       slimleft (st);
                       VatReport.SalesVatAmounts.Lines.add(st);
                       Runningnet := Runningnet + DigitalVAT.VATCodeArray[i].SalesNet;
                       Runningvat := Runningvat + DigitalVAT.VATCodeArray[i].SalesVat;
        End ;
        st := '';
        DoubleToStr (Runningnet,st,'%8.2f', true, false, 20, True);
        slimleft (st);
        VatReport.SalesTotalNet.Caption := st;
        st := '';
        DoubleToStr (Runningvat,st,'%8.2f', true, false, 20, True);
        slimleft (st);
        VatReport.SalesTotalVat.Caption := st;

        // Purchases

        runningnet := 0;
        runningvat := 0;

        VatReport.PurchVatCodes.Lines.Clear;
        VatReport.PurchVatRates.Lines.Clear;
        VatReport.PurchNetAmounts.Lines.Clear;
        VatReport.PurchVatAmounts.Lines.Clear;
        for I:= 0 to 9 do Begin
                       VatReport.PurchVatCodes.Lines.add(DigitalVAT.VATCodeArray[i].VatCode);
                       VatReport.PurchVatRates.Lines.add(DigitalVAT.VATCodeArray[i].VatRate);
                       st := '';
                       DoubleToStr (DigitalVAT.VATCodeArray[i].PurchNet,st,'%8.2f', true, false, 20, True);
                       slimleft (st);
                       VatReport.PurchNetAmounts.Lines.add(st);
                       st := '';
                       DoubleToStr (DigitalVAT.VATCodeArray[i].PurchVat,st,'%8.2f', true, false, 20, True);
                       slimleft (st);
                       VatReport.PurchVatAmounts.Lines.add(st);
                       Runningnet := Runningnet + DigitalVAT.VATCodeArray[i].PurchNet;
                       Runningvat := Runningvat + DigitalVAT.VATCodeArray[i].PurchVat;
        End ;
        st := '';
        DoubleToStr (Runningnet,st,'%8.2f', true, false, 20, True);
        slimleft (st);
        VatReport.PurchTotalNet.Caption := st;
        st := '';
        DoubleToStr (Runningvat,st,'%8.2f', true, false, 20, True);
        slimleft (st);
        VatReport.PurchTotalVat.Caption := st;

        VatReport.AccountsName.Caption := Cash1.XCOMPANY;
        VatReport.KingswoodLbl.caption :=  'Kingswood Accounts ' + Verno;
        VatReport.Range.Caption := 'VAT Period End Date - ' + VATRepDate.text;
        VatReport.DataSet.Caption :=  Accsdata.AccsDataModule.AccsDataBase.AliasName;

        VatReport.Preview;

end;

procedure TDigitalVATForm.VatRepDateSearchCloseUp(Sender: TObject);
begin
             VATRepDate.text:= DateToStr(VATRepDateSearch.Date);
             VATRepDate.SetFocus;
end;

procedure TDigitalVATForm.VatRepDateSearchEnter(Sender: TObject);
begin
             VATRepDateSearch.date := strtodate(VATRepDate.text);
end;

procedure TDigitalVATForm.CloseIRLPeriodBtnClick(Sender: TObject);
var
        NewReturnID, I : Integer;
        MyQuery : TQuery;
begin
        AccsDataModule.VATReturnDB.Open;
        AccsDataModule.VATReturnDB.Append;
        AccsDataModule.VATReturnDB['ReturnDate'] := strtodate(VATRepDate.Text);
        AccsDataModule.VATReturnDB['IRLReturn'] := True;
        AccsDataModule.VATReturnDB['FinYear'] := Cash1.xfinYear;
        AccsDataModule.VATReturnDB['DisplayString'] := VATRepDate.Text;
        AccsDataModule.VATReturnDB.Post;
        AccsDataModule.VATReturnDB.last;

        NewReturnID := AccsDataModule.VATReturnDB['ReturnID'];

        // Archive Report

        MyQuery := TQuery.create(self);
        Myquery.DatabaseName := accsdatamodule.AccsDataBase.databasename;
        MyQuery.SQL.clear;
        MyQuery.SQL.add ('Update TempVAT set VATID =' + vartostr(NewReturnID));
        MyQuery.ExecSQL;

        MyQuery.SQL.clear;
        MyQuery.SQL.add ('INSERT INTO VATArchive');
        MyQuery.SQL.add ('SELECT * FROM TempVAT');
        MyQuery.ExecSQL;

        MyQuery.close;
        MyQuery.free;

        // End Archive

        // Save Summary

        AccsDataModule.VATTotalsArchiveDB.Open;

        For I:= 0 to 9 do begin

            AccsDataModule.VATTotalsArchiveDB.Append;

            AccsDataModule.VATTotalsArchiveDB['ReturnID'] := NewReturnID;
            AccsDataModule.VATTotalsArchiveDB['VATCode'] :=DigitalVAT.VATCodeArray[i].VatCode;
            AccsDataModule.VATTotalsArchiveDB['VATRate'] :=DigitalVAT.VATCodeArray[i].VatRate;
            AccsDataModule.VATTotalsArchiveDB['SalesNetAmount'] :=DigitalVAT.VATCodeArray[i].SalesNet;
            AccsDataModule.VATTotalsArchiveDB['SalesVATAmount'] :=DigitalVAT.VATCodeArray[i].SalesVat;
            AccsDataModule.VATTotalsArchiveDB['PurchNetAmount'] :=DigitalVAT.VATCodeArray[i].PurchNet;
            AccsDataModule.VATTotalsArchiveDB['PurchVATAmount'] :=DigitalVAT.VATCodeArray[i].PurchVat;

            AccsDataModule.VATTotalsArchiveDB.post;
        end;


        // End Save Summary


        if ((cash2.XAllocation) and (cash2.XPaymentVAT)) then begin

                     if cash11.xSalesPaymentVAT = 'Y' then DigitalVAT.PaymentVatAuditTrail('S',True,NewReturnID,VATSpansYears)
                        else DigitalVAT.InvoiceVatAuditTrail('S',True,NewReturnID,VATSpansYears);
                     if cash11.xPurchPaymentVAT = 'Y' then DigitalVAT.PaymentVatAuditTrail('P',True,NewReturnID,VATSpansYears)
                        else DigitalVAT.InvoiceVatAuditTrail('P',True,NewReturnID,VATSpansYears);

        end else begin

                     DigitalVAT.InvoiceVatAuditTrail('S',True,NewReturnID,VATSpansYears);
                     DigitalVAT.InvoiceVatAuditTrail('P',True,NewReturnID,VATSpansYears);

                end;


     //   DigitalVAT.InvoiceVatAuditTrail('S',True,NewReturnID,False);
      //  DigitalVAT.InvoiceVatAuditTrail('P',True,NewReturnID,False);

        FormCreate(self);
        
end;

procedure TDigitalVATForm.PreviewUKReportClick(Sender: TObject);
begin
          GenerateNIReport(False);
end;

procedure TDigitalVATForm.GenerateNIReport(IncConfirmation : Boolean);
begin
         if not bool(NIVatReport) then Application.CreateForm(TNIVatReport, NIVatReport);

         NIVatReport.Box1.Caption := Box1.text;
         NIVatReport.Box2.Caption := Box2.text;
         NIVatReport.Box3.Caption := Box3.text;
         NIVatReport.Box4.Caption := Box4.text;
         NIVatReport.Box5.Caption := Box5.text;
         NIVatReport.Comment.Caption := VATLabel.Caption;

   //      if IncConfirmation then begin

   //                     NIVatReport.Box6.Caption := FloatToStr(trunc(DigitalVAT.NICodeArray[0].Box6));
   //                     NIVatReport.Box7.Caption := FloatToStr(trunc(DigitalVAT.NICodeArray[0].Box7));
   //                     NIVatReport.Box8.Caption := FloatToStr(trunc(DigitalVAT.NICodeArray[0].Box8));
   //                     NIVatReport.Box9.Caption := FloatToStr(trunc(DigitalVAT.NICodeArray[0].Box9));
   //      end
   //             else begin
                        NIVatReport.Box6.Caption := Box6.text;
                        NIVatReport.Box7.Caption := Box7.text;
                        NIVatReport.Box8.Caption := Box8.text;
                        NIVatReport.Box9.Caption := Box9.text;
   //             end;


        NIVatReport.AccountsName.Caption := Cash1.XCOMPANY;
        NIVatReport.KingswoodLbl.caption :=  'Kingswood Accounts ' + Verno;
        NIVatReport.DataSet.Caption :=  Accsdata.AccsDataModule.AccsDataBase.AliasName;
        NIVatReport.Range.Caption := 'VAT Period - ' + PeriodLookup.DisplayValue;

        if IncConfirmation then begin
                    NIVatReport.CommentLabel1.Caption := 'VAT Submission Date - ' + vartostr(AccsDataModule.VATReturnDB['SubmissionDate']);
                    NIVatReport.CommentLabel1.enabled := True;
                    NIVatReport.CommentLabel2.Caption := 'Submission Confirmation - ' + vartostr(AccsDataModule.VATReturnDB['SubmissionReference']);
                    NIVatReport.CommentLabel2.enabled := True;

        end else begin
                    NIVatReport.CommentLabel1.Caption := '';
                    NIVatReport.CommentLabel1.enabled := False;
                    NIVatReport.CommentLabel2.Caption := '';
                    NIVatReport.CommentLabel2.enabled := False;
                end;

        NIVatReport.Preview;
end;

procedure TDigitalVATForm.PrintUKReturnClick(Sender: TObject);
begin
        GenerateNIReport(True);
end;

procedure TDigitalVATForm.CompleteUKReturnClick(Sender: TObject);
begin
   if Trim(Confirmation.Text) <> '' then
      begin
         CompleteUKVATReturn(Trim(Confirmation.Text));
      end
   else
      begin
         MoveToStage(5);
         MessageDlg('No valid Confirmation Reference Entered.',mtWarning,[mbOK],0);
     end;
end;

procedure TDigitalVATForm.VatRepDateExit(Sender: TObject);
Var
   TestDate : ShortString;
   DateBefore : Boolean;
begin
     TestDate := '';
     TestDate := VATRepDate.Text;
     If NOT DateValid ( VATRepDate.Text, TDateFormat ) Then
        VATRepDate.SetFocus
     Else If NOT CheckDateRange ( TestDate, True, DateBefore, True ) Then
        Begin
             VATRepDate.Text := TestDate;
             VATRepDate.SetFocus;
        End;
end;

procedure TDigitalVATForm.NewRtnBtnClick(Sender: TObject);
begin
        FormCreate(self);
        PeriodLookup.ClearValue;
end;

// 11/03/2019 - SP
procedure TDigitalVATForm.ApplicationActivate(Sender: TObject);
begin
   RetrieveReceiptFromAPI();
end;

procedure TDigitalVATForm.PeriodLookupChange(Sender: TObject);
begin
   RunBtn.Click();
end;

procedure TDigitalVATForm.MoveToStage(AStep: Integer);
begin
   pVATReturnSuccess.Visible := False;
   pCompletionAPIWaiting.Visible := False;
   btnRetrieveReceipt.Visible := False;
   gbSelectPeriod.Visible := False;
   gbNIVatPanel.Visible := False;
   gbCompleteReturn.Visible := False;
   gbReports.Visible := False;
   pCompleteReturn.Visible := False;
   gbConfigureClientCode.Visible := False;
   actCompleteReturn.Enabled := False;
   pVATReturnError.Visible := False;
   pVATReturnSuccess.Visible := False;
   actPrintVATReturnReport.Enabled := False;

   if (AStep <> 0) and (Length(AccsDataModule.APISecret)=0) then
      begin
         MoveToStage(0);
         Exit;
      end;

   case AStep of
      0 :
      begin
         gbConfigureClientCode.Visible := True;
      end;
      1 :
      begin

         PeriodLookup.enabled := true;
         gbSelectPeriod.Visible := True;
      end;
      2 :
      begin

         actViewAuditTrail.Enabled := True;
         //actViewSubmissionReport.Enabled := True;
         actCancelReturn.Enabled := True;
         actSubmitReturn.Enabled := True;

         gbReports.Visible := True;
         gbNIVatPanel.Visible := True;
      end;
      3:  // awaiting input of bundle code
      begin
         if (TCredentialsStore.IsStoredFor(AccsDataModule.CurrentDatabasePath)) then
            begin
               pCompletionAPIWaiting.Visible := True;
            end
         else
            begin
               gbReports.Visible := True;
               actCompleteReturn.Enabled := True;
               pCompleteReturn.Visible := True;
               gbCompleteReturn.Visible := True;
            end;
      end;
      4:
      begin
         gbReports.Visible := True;
         lEnterFormNumber.Visible := False;
         Confirmation.Visible := False;
         actCompleteReturn.Visible := False;

         pVATReturnSuccess.Left := 38;
         pVATReturnSuccess.Top := 82;
         pVATReturnSuccess.Visible := True;

         gbCompleteReturn.Visible := True;
         gbReports.Visible := True;

         actPrintVATReturnReport.Enabled := True;
      end;
      5:
      begin
         gbReports.Visible := True;

         lEnterFormNumber.Visible := False;
         Confirmation.Visible := False;
         actCompleteReturn.Visible := False;

         pVATReturnError.Left := 38;
         pVATReturnError.Top := 82;
         pVATReturnError.Visible := True;

         gbCompleteReturn.Visible := True;
         gbReports.Visible := True;
      end;
   end;
end;

procedure TDigitalVATForm.actSubmitReturnExecute(Sender: TObject);
begin
   SubmitReturn();
end;

procedure TDigitalVATForm.SubmitReturn;
var
   ParamStr: string;
   Hash: string;
   URL: string;

   p1: string;
   p2: string;
   p3: string;
   p4: string;
   p5: string;
   p6: string;
   p7: string;
   p8: string;
   p9: string;
   p10: string;
   p11: string;
   p12: string;

   p13: string;
   p14: string;
   p15: string;
   p16: string;
   p17: string;
   p18: string;
   p19: string;
   p20: string;
   p21: string;
   p22: string;
   p23: string;

   TempStr : String;

   DeviceInfo : TDeviceInfo;

   LoginCredentials: TLoginCredentials;
   ReconcileResult:TMTDReconcile;
   StagedVATReturn: TMTDVATReturnRequest;
begin

{$IFNDEF DEBUG }
   // Ch023 AB 15/05/20 - Added check & prompt to user to review Audit Trial Before Submitting Return
   if ( not(AuditPreviewed) ) then
      begin
         ShowMessage('Please click to View Audit Trail Report and check the details before Submitting Return.');
         Exit;
      end;
   // End Ch023
{$ENDIF}

   // 11/03/2019 - SP
   FSecretKeyForClient := AccsDataModule.APISecret;
   if ( not(ClientSecretIsValid(FSecretKeyForClient)) ) then
      begin
         MessageDlg('This system has not been configured to perform a digital VAT return.' + cCRLFx2 +
                    'Please contact Kingswood Computing to enable the Kingswood MTD link.',mtWarning,[mbOK],0);
         Exit;
      end;

   if FSubmissionPending then
      begin
         ReconcileResult := Reconcile();
         if (ReconcileResult.DialogMessage<>'') then
             begin
                MessageDlg(ReconcileResult.DialogMessage,ReconcileResult.DialogType,[mbOK],0);
                if ((ReconcileResult.DialogType = mtError) or
                    (ReconcileResult.DialogType = mtWarning)) then
                    Abort;
             end;

         if (ReconcileResult.Result = srReconciled) then
            begin
               if (Accsdatamodule.VATReturnDB.Locate('ReturnID',PeriodLookup.KeyValue,[])) then
                begin
                   CompleteUKVATReturn(Accsdatamodule.VATReturnDB['HMRCBundleNumber'],True);
                   Exit;
                end;
            end;
      end;

   FTransactionId := GUID();
   FSubmitAttempted := True;

{$IFNDEF DEBUG }
   // SP 27/09/2019 - Request by GL/TGM
   // Update the VATReturn table to acknowledge that a VAT return submission has been made.
   // We do this in the case where a user has submitted and not copied the VATReceipt back into
   // the accounts program. In these cases, we must prevent user from doing any subsequent VAT Return
   // which would lead to transactions for previous period being presented for the current period :O
    if (Accsdatamodule.VATReturnDB.Locate('ReturnID',PeriodLookup.KeyValue,[])) then
       try
          Accsdatamodule.VATReturnDB.Edit;
          AccsDataModule.VATReturnDB['TransactionId'] := FTransactionId;
          AccsDataModule.VATReturnDB['SubmitAttempted'] := FSubmitAttempted;
          AccsDataModule.VATReturnDB['SubmitAttemptDate'] := Now();
          AccsDataModule.VATReturnDB.Post;
       except
          AccsDataModule.VATReturnDB.Cancel;
       end;
{$ENDIF}

//  secretKeyForClient := 'THIS IS A SECRET KEY WHICH IS USED TO GENERATE THIS HASH';

   StagedVATReturn := TMTDVATReturnRequest.Create();
   StagedVATReturn.VRN := AccsDataModule.ClientVRN;
   
   // p1 = vatDueSales
   try
      p1 := FloatToStr(DigitalVAT.NICodeArray[0].Box1 * 100);
   except
     p1 := '0';
   end;
   StagedVATReturn.VATDueSales := DigitalVAT.NICodeArray[0].Box1 * 100;

   // p2 = vatDueAcquisitions
   try
      p2 := FloatToStr(DigitalVAT.NICodeArray[0].Box2 * 100);
   except
     p2 := '0';
   end;
   StagedVATReturn.VATDueAcquisitions := DigitalVAT.NICodeArray[0].Box2 * 100;

   // p3 = totalVatDue
   try
      p3 := FloatToStr(DigitalVAT.NICodeArray[0].Box3 * 100);
   except
     p3 := '0';
   end;
   StagedVATReturn.TotalVATDue := DigitalVAT.NICodeArray[0].Box3 * 100;

   // p4 = vatReclaimedCurrPeriod
   try
      p4 := FloatToStr(DigitalVAT.NICodeArray[0].Box4 * 100);
   except
     p4 := '0';
   end;
   StagedVATReturn.VATReclaimedCurrPeriod := DigitalVAT.NICodeArray[0].Box4 * 100;

   // p5 = netVatDue
   try
      p5 := FloatToStr(DigitalVAT.NICodeArray[0].Box5 * 100);
   except
     p5 := '0';
   end;

   if pos('-',p5) > 0 then begin
       p5 := copy(p5,2,length(p5)-1);
   end;

   if (DigitalVAT.NICodeArray[0].Box5 < 0) then
      StagedVATReturn.NetVATDue := ((DigitalVAT.NICodeArray[0].Box5 * -1) * 100)
   else
      StagedVATReturn.NetVATDue := DigitalVAT.NICodeArray[0].Box5 * 100;

   // p6 = totalValueSalesExVAT
   try
      p6 := FloatToStr(trunc(DigitalVAT.NICodeArray[0].Box6) * 100);
   except
     p6 := '0';
   end;
   StagedVATReturn.TotalValueSalesExVAT := trunc((DigitalVAT.NICodeArray[0].Box6) * 100);

   // p7 = totalValuePurchasesExVAT
   try
      p7 := FloatToStr(trunc(DigitalVAT.NICodeArray[0].Box7) * 100);
   except
     p7 := '0';
   end;
   StagedVATReturn.TotalValuePurchasesExVAT := trunc((DigitalVAT.NICodeArray[0].Box7) * 100);

   // p8 = totalValueGoodsSuppliedExVAT
   try
      p8 := FloatToStr(trunc(DigitalVAT.NICodeArray[0].Box8) * 100);
   except
     p8 := '0';
   end;
   StagedVATReturn.TotalValueGoodsSuppliedExVAT := trunc((DigitalVAT.NICodeArray[0].Box8) * 100);

   // p9 = totalAcquisitionsExVAT
   try
      p9 := FloatToStr(trunc(DigitalVAT.NICodeArray[0].Box9) * 100);
   except
     p9 := '0';
   end;
   StagedVATReturn.TotalAcquisitionsExVAT := trunc((DigitalVAT.NICodeArray[0].Box9) * 100);;

   // p10 periodFrom (to match against Obligation entry)

   TempsTr := periodlookup.DisplayValue;

   try
      p10 := Copy(TempStr, 7, 4) + Copy(TempStr, 4, 2) + Copy(TempStr, 1, 2);
   except
     p10 := 'err';
   end;
   //yyyy-mm-dd format
   StagedVATReturn.PeriodStart := Copy(TempStr, 7, 4) + '-' + Copy(TempStr, 4, 2) + '-' + Copy(TempStr, 1, 2);

   // p11 periodTo (to match against Obligation entry)
   try
      p11 := Copy(TempStr, 20, 4) + Copy(TempStr, 17, 2) + Copy(TempStr, 14, 2);
   except
     p11 := 'err';
   end;
   //yyyy-mm-dd format
   StagedVATReturn.PeriodEnd := Copy(TempStr, 20, 4) + '-' + Copy(TempStr, 17, 2) + '-' + Copy(TempStr, 14, 2);

   // 11/03/2019 - SP
   p12 := FTransactionId;
   StagedVATReturn.TransactionId := p12;

   DeviceInfo := GetDeviceInfo();

   // NB: dont change order or params
   p13 := Types.ShortVerNo;
   p14 := ClientDeviceID;
   p15 := URLEncode(uWinOS.GetUserName);
   p23 := URLEncode(UTCDateTimeAsString());
   p16 := URLEncode(GetIPAddress);
   p17 := IntToStr(TMTDApi.GetPort(AccsDataModule.MTDConfig)); // ip port number
   p18 := URLEncode(GetMACAddress);
   p19 := 'Windows'; // unless MS change windows something other!!
   p20 := URLEncode(GetWindowsProductName);
   p21 := URLEncode(DeviceInfo.DeviceMake);
   p22 := URLEncode(DeviceInfo.DeviceModel);

   StagedVATReturn.AddHeader('verNo',p13);
   StagedVATReturn.AddHeader('deviceId',p14);
   StagedVATReturn.AddHeader('userName',p15);
   StagedVATReturn.AddHeader('ipAddressTimestamp',p23);
   StagedVATReturn.AddHeader('ipAddress',p16);
   StagedVATReturn.AddHeader('port',p17);
   StagedVATReturn.AddHeader('macAddress',p18);
   StagedVATReturn.AddHeader('clientOS',p19);
   StagedVATReturn.AddHeader('clientOSVersion',p20);
   StagedVATReturn.AddHeader('clientDeviceMake',p21);
   StagedVATReturn.AddHeader('clientDeviceModel',p22);

   ParamStr := Format('p1=%s&p2=%s&p3=%s&p4=%s&p5=%s&p6=%s&p7=%s&p8=%s&p9=%s&p10=%s&p11=%s&p12=%s&p13=%s&p14=%s&p15=%s&p16=%s&p17=%s&p18=%s&p19=%s&p20=%s&p21=%s&p22=%s&p23=%s',

              [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23]);

  Hash := LowerStrMD5(ParamStr + FSecretKeyForClient);
  URL := Format('%s?p0=%s&%s',[AccsDataModule.MTDConfig.WebUrl + '/bridge/submit',Hash,ParamStr]);

  if EnableDebug.checked then showmessage(Hash + '   &   ' + ParamStr);
  if EnableDebug.checked then showmessage(URL);

   // 11/03/2019 - SP
  FReceiptCopied := False;

  if (AccsDataModule.MTDConfig.IsAgent) then
     StageAgentVATReturn(StagedVATReturn)
  else
     ShellExecute(0, 'open', PChar(URL), nil, nil, SW_SHOWMAXIMIZED);

  MoveToStage(3);

  enabled := true;
end;

procedure TDigitalVATForm.actCancelReturnExecute(Sender: TObject);
begin
   FormCreate(self);
   PeriodLookup.ClearValue;
end;

procedure TDigitalVATForm.actViewAuditTrailExecute(Sender: TObject);
begin
   ViewAuditTrailReport();
end;

procedure TDigitalVATForm.ViewAuditTrailReport();
begin
   if not bool(VatAuditReport) then Exit;

   VatAuditReport.Preview;
   AuditPreviewed := True;   //Ch023   
end;

procedure TDigitalVATForm.actViewSubmissionReportExecute(Sender: TObject);
begin
   GenerateNIReport(False);
end;

procedure TDigitalVATForm.actCompleteReturnExecute(Sender: TObject);
begin
   CompleteReturn();
end;

procedure TDigitalVATForm.CompleteReturn;
begin
//   if (country...
   CompleteUKReturn.Click();
end;

procedure TDigitalVATForm.ConfirmationChange(Sender: TObject);
begin
   // sample bundle number: 096000018352
   // Enable the completion button when at least 8 chars have been entered.
   actCompleteReturn.Enabled := Length(Confirmation.Text)>8;
end;

procedure TDigitalVATForm.actPrintVATReturnReportExecute(Sender: TObject);
begin
   GenerateNIReport(True);
end;

procedure TDigitalVATForm.actReportsExecute(Sender: TObject);
begin
   TVATSubmissionReportForm.ShowTheForm(vtFromDigVatRet);
end;

procedure TDigitalVATForm.actSettingsExecute(Sender: TObject);
begin
   if not bool(VATSetupForm) then Application.CreateForm(TVATSetupForm, VATSetupForm);
   VATSetupForm.showmodal;
end;

procedure TDigitalVATForm.actCloseExecute(Sender: TObject);
begin
   close;
   DigitalVATForm := nil;
end;

procedure TDigitalVATForm.blbHelpClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar(AccsDataModule.MTDConfig.WebUrl+'/help'), nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TDigitalVATForm.KingswoodMTDLinkClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar(AccsDataModule.MTDConfig.WebUrl), nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TDigitalVATForm.ClientCodeTextEditPropertiesChange(
  Sender: TObject);
var
  Value: string;
begin
  inherited;
  Value := Trim(ClientCodeTextEdit.Text);
  if (Length(Value)=0) or
     (AccsSystem.Region<>'UK') or
     (Length(AccsDataModule.APISecret)>0) then
     begin
        actStoreClientCode.Enabled := False;
        Exit;
     end;

  // Sample: 51C0567DFA664D36BD1642AE00F8FFA1
  actStoreClientCode.Enabled := ClientSecretIsValid(Value);
end;

procedure TDigitalVATForm.actStoreClientCodeExecute(Sender: TObject);
begin

   if (not ClientSecretIsValid(ClientCodeTextEdit.Text) or (Length(AccsDataModule.APISecret)>0)) then Exit;
   actStoreClientCode.Enabled := False;
   ClientCodeTextEdit.Enabled := False;
   try
      AccsDataModule.APISecret := ClientCodeTextEdit.Text;
      ClientCodeTextEdit.Text := '';
      MoveToStage(1);
   finally
      ClientCodeTextEdit.Enabled := True;
   end;
end;

procedure TDigitalVATForm.FormShow(Sender: TObject);
var                                      //Ch017
        Registry : TRegistry;            //Ch017
begin
   if (gbConfigureClientCode.Visible) then
      try
         ClientCodeTextEdit.SetFocus();
      except
      end;


      // Ch017

      if (cash2.XPaymentVAT = false) then IncludeExemptCB.Visible := True
              else IncludeExemptCB.Visible := false;

      Registry:=Tregistry.Create;
      Registry.OpenKey('Software\Kingswood\Kingsacc\VATAuditDefaults', True);
      if Registry.ReadString('NIMTDIncExempt') = 'True' then IncludeExemptCB.checked := true
             else IncludeExemptCB.checked := false;
      Registry.Free;

      // end Ch017
end;

procedure TDigitalVATForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   if ((FSubmitAttempted) and (not FReceiptCopied)) then
      begin
         CanClose := (CustomMessageDlg('Please wait, we did not detect a VAT return submission receipt.'+cCRLFx2 +
                'If your VAT return was successfully submitted, you should click ''Get Receipt'' and '+cCRLF +
                'return back to Kingswood MTD > Submissions section and click the ''COPY RECEIPT DETAILS'' button for '+cCRLF +
                'the appropriate VAT return period.'+ cCRLFx2 +
                'Otherwise, if your VAT return was unsuccessful, you should leave this screen without entering a receipt.'+cCRLFx2 +
                'Click ''Get Receipt'' to return to Kingswood MTD now or ''Cancel'' to leave screen without further action.','Get Receipt','Cancel',mtWarning) = mrCancel);
          if (not CanClose) then
             ShellExecute(0, 'open', PChar(AccsDataModule.MTDConfig.WebUrl + '/vat/submission/history'), nil, nil, SW_SHOWNORMAL);
      end;
end;

function TDigitalVATForm.CustomMessageDlg(const ACaption: string;
   const AOKButtonCaption:string; const ACancelButtonCaption: string; AMsgDlgType: TMsgDlgType): Integer;
var
   Dialog: TForm;
begin
   Dialog := CreateMessageDialog(ACaption, AMsgDlgType, [mbOK,mbCancel]);
   try
      with TButton(Dialog.FindComponent('OK')) do
         begin
            Caption := AOKButtonCaption;
         end;
      with TButton(Dialog.FindComponent('Cancel')) do
         begin
            Caption := ACancelButtonCaption;
         end;
      Result := Dialog.ShowModal;
   finally
      Dialog.free;
   end;
end;

procedure TDigitalVATForm.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if (FSubmissionCompletionPending and (ssRight in Shift)) then
   begin
      if (MessageDlg('Import HMRC MTD receipt?',mtConfirmation,[mbYes,mbNo],0) = idNo) then Exit;

      if (Clipboard.AsText <> '') then
         begin
            FReceiptCopied := False;
            ProcessReceiptFromClipboard();
            MoveToStage(3);
            ApplicationActivate(nil);
         end;
   end;
end;

procedure TDigitalVATForm.btnRetrieveReceiptClick(Sender: TObject);
begin
   ProcessReceiptFromClipboard();
   if not FReceiptCopied then
      RetrieveReceiptFromAPI();
end;

procedure TDigitalVATForm.ProcessReceiptFromClipboard;
var
   Data : string;
var
   MyString : TStringList;
   IsReceipt : Boolean;
   i : Integer;
   KeyName: string;
   KeyValue: string;
   TransactionId: string;
begin
   Data := Clipboard.AsText;
   if (Length(Data) < 21 ) then exit;

   IsReceipt := (Copy(Data,1 ,21) = 'KW_MTD_TRANSACTION_ID');
   if not (IsReceipt) then Exit;

    Application.OnActivate := nil;

    MyString := TStringList.Create;
    try
       Parse(Data, '&', MyString);

       // Example: KW_MTD_TRANSACTION_ID={ClientId.ToString()}&PROCESSING_DATE={ProcessingDate}&PAYMENT_INDICATOR={PaymentIndicator}&FORM_BUNDLE_NUMBER={FormBundleNumber}&CHARGE_REF_NUMBER={ChargeRefNumber}
       TransactionId := MyString.Values['KW_MTD_TRANSACTION_ID'];
       if (LowerCase(TransactionId)=LowerCase(FTransactionId)) then
          begin
             FReceiptCopied := true;

             FHMRCProcessingTimeStamp := MyString.Values['PROCESSING_DATE'];
             FHMRCPaymentIndicator := MyString.Values['PAYMENT_INDICATOR'];
             FHMRCBundleNumber := MyString.Values['FORM_BUNDLE_NUMBER'];

             Confirmation.Text := FHMRCBundleNumber;

             lBundleNumber.Caption := FHMRCBundleNumber;

             AccsDataModule.StoreHMRCReceipt(Data, FTransactionId, True);
          end
       else
          AccsDataModule.StoreHMRCReceipt(Data, FTransactionId, False);
    finally
      Clipboard.Clear();
      FreeAndNil(MyString);
    end;

    if (FReceiptCopied) then
       CompleteUKReturn.Click()
    else
       MessageDlg('There was a discrepancy between the HMRC receipt and submitted VAT return - contact Kingswood.',mtError,[mbOK],0);
end;

procedure TDigitalVATForm.RetrieveReceiptFromAPI;
var
   MTDApi: TMTDApi;
   VATReceipt: TMTDVATReceipt;
   LoginCredentials: TLoginCredentials;
begin
   if (not FSubmitAttempted) then Exit;

   //   30/09/20 [V4.5 R4.1] /MK Change - Changed the assignment of LoginCredentials to Submit Return button so only check that LoginCredentials <> nil.
   LoginCredentials := TCredentialsStore.Load(AccsDataModule.MTDCredentialStorePath);
   if ( LoginCredentials = nil ) then Exit;

   Screen.Cursor := crHourGlass;
   RetrieveRecieptLabel.Caption := 'Checking submission status, please wait a few moments...';

   MTDApi := TMTDApi.create(LoginCredentials, AccsDataModule.MTDConfig);
   try
      VATReceipt := MTDApi.GetReceipt(FTransactionId);
      if (VATReceipt=nil) then
         begin
            btnRetrieveReceipt.Visible := True;
            MessageDlg(IfThenElse(MTDApi.LastError<>'',MTDApi.LastError,'Error retrieving receipt'), mtError,[mbOK],0);
         end
      else
         begin
            FHMRCProcessingTimeStamp := VATReceipt.ProcessingDate;
            FHMRCPaymentIndicator := VATReceipt.PaymentIndicator;
            FHMRCBundleNumber := VATReceipt.BundleNumber;

            Confirmation.Text := FHMRCBundleNumber;
            lBundleNumber.Caption := FHMRCBundleNumber;

            AccsDataModule.StoreHMRCReceipt(VATReceipt.CreateStamp(FTransactionId), FTransactionId, True);
            FReceiptCopied := True;

            CompleteUKReturn.Click();
         end;
   finally
      FreeAndNil(MTDApi);
      FreeAndNil(VATReceipt);
      Screen.Cursor := crDefault;
   end;
end;

function TDigitalVATForm.Reconcile(): TMTDReconcile;
var
   VATReturn: TMTDVATReturn;
begin
   Screen.Cursor := crHourGlass;
   VATReturn := TMTDVATReturn.Create();
   try
      VATReturn.VATDueSales := StrToFloat(Box1.Text);
      VATReturn.VATDueAcquisitions := StrToFloat(Box2.Text);
      VATReturn.TotalVATDue := StrToFloat(Box3.Text);
      VATReturn.VATReclaimedCurrPeriod := StrToFloat(Box4.Text);
      VATReturn.NetVATDue := StrToFloat(Box5.Text);
      VATReturn.TotalValueSalesExVAT := trunc(StrToFloat(Box6.Text));
      VATReturn.TotalValuePurchasesExVAT := trunc(StrToFloat(Box7.Text));
      VATReturn.TotalValueGoodsSuppliedExVAT := trunc(StrToFloat(Box8.Text));
      VATReturn.TotalAcquisitionsExVAT := trunc(StrToFloat(Box9.Text));

      Accsdatamodule.VATReturnDB.open;
      if not Accsdatamodule.VATReturnDB.Locate('ReturnID',PeriodLookup.KeyValue,[]) then
         begin
            MessageDlg('VAT period not found.',MtError,[mbOK],0);
            Exit;
         end;

      Result := AccsDataModule.ReconcileLastMTDSubmission(
                    Accsdatamodule.VATReturnDB['ReturnStartDate'],
                    Accsdatamodule.VATReturnDB['ReturnEndDate'],VATReturn);
   finally
      FreeAndNil(VATReturn);
      Screen.Cursor := crDefault;
   end;
end;

procedure TDigitalVATForm.CompleteUKVATReturn(
  const AConfirmationId: string; const AReconciled: Boolean);
var
   NewReturnID : Integer;
   MyQuery : TQuery;
begin
   if (Trim(AConfirmationId)='') and (not AReconciled) then Exit;
   try
      Screen.Cursor := crHourGlass;

   PreviewUKReport.enabled := False;

   if (not AReconciled) then
      begin
         Accsdatamodule.VATReturnDB.Locate('TransactionId;ReturnID',VarArrayOf([FTransactionId,PeriodLookup.KeyValue]),[]);
         Accsdatamodule.VATReturnDB.edit;

         AccsDataModule.VATReturnDB['Box1'] := Box1.text;
         AccsDataModule.VATReturnDB['Box2'] := Box2.text;
         AccsDataModule.VATReturnDB['Box3'] := Box3.text;
         AccsDataModule.VATReturnDB['Box4'] := Box4.text;
         AccsDataModule.VATReturnDB['Box5'] := Box5.text;
         AccsDataModule.VATReturnDB['Box6'] := Box6.text;
         AccsDataModule.VATReturnDB['Box7'] := Box7.text;
         AccsDataModule.VATReturnDB['Box8'] := Box8.text;
         AccsDataModule.VATReturnDB['Box9'] := Box9.text;

         AccsDataModule.VATReturnDB['SubmissionDate'] := Now;
         AccsDataModule.VATReturnDB['SubmissionComplete'] := True;
         AccsDataModule.VATReturnDB['SubmissionReference'] := AConfirmationId;

         if (FReceiptCopied) then
           begin
              AccsDataModule.VATReturnDB['HMRCProcessingTimeStamp'] := FHMRCProcessingTimeStamp;
              AccsDataModule.VATReturnDB['HMRCPaymentIndicator'] := FHMRCPaymentIndicator;
              AccsDataModule.VATReturnDB['HMRCBundleNumber'] := FHMRCBundleNumber;
           end;

         AccsDataModule.VATReturnDB.Post;
      end
   else
      begin
         lBundleNumber.Caption := AccsDataModule.VATReturnDB['SubmissionReference'];
      end;

   NewReturnID := AccsDataModule.VATReturnDB['ReturnID'];

   // Archive Report

   MyQuery := TQuery.create(self);
   Myquery.DatabaseName := accsdatamodule.AccsDataBase.databasename;
   MyQuery.SQL.clear;
   MyQuery.SQL.add ('Update TempVAT set VATID =' + vartostr(NewReturnID));
   MyQuery.ExecSQL;

   MyQuery.SQL.clear;
   MyQuery.SQL.add ('INSERT INTO VATArchive');
   MyQuery.SQL.add ('SELECT * FROM TempVAT');
   MyQuery.ExecSQL;

   MyQuery.close;
   MyQuery.free;

   // End Archive

   if ((cash2.XAllocation) and (cash2.XPaymentVAT)) then begin      // Payment VAT

            DigitalVAT.PaymentVatAuditTrail('S',True,NewReturnID,VATSpansYears);
            DigitalVAT.PaymentVatAuditTrail('P',True,NewReturnID,VATSpansYears);


        end else begin     // Invoice VAT
                       DigitalVAT.InvoiceVatAuditTrail('S',True,NewReturnID,VATSpansYears);
                       DigitalVAT.InvoiceVatAuditTrail('P',True,NewReturnID,VATSpansYears);

           end;


   PrintUKReturn.enabled := True;
   SubmitUKReturn.enabled := False;
   CompleteUKReturn.enabled := False;
   actCancelReturn.enabled := False;
   NewRtnBtn.enabled := True;

   FSubmitAttempted := False;

   MoveToStage(4);
   finally
      Screen.Cursor := crDefault;
   end;
end;

procedure TDigitalVATForm.StageAgentVATReturn(AStagedVATReturn: TMTDVATReturnRequest);
var
   MTDApi: TMTDApi;
   ClientVatNumber: string;
   ErrorMessage: string;
begin
   Screen.Cursor := crHourGlass;
   MTDApi := TMTDApi.create(TCredentialsStore.Load(AccsDataModule.MTDCredentialStorePath), AccsDataModule.MTDConfig);
   try
      // Ensure we download the VAT number were not already present in database
      if (AccsDataModule.ClientVRN='') then
         begin
             ClientVatNumber := MTDApi.GetClientVRN(AccsDataModule.APISecret);
             if (ClientVatNumber='') then
                begin
                   MessageDlg('VAT return exiting early, unable to download your client details - contact Kingswood.', mtError, [mbOK], 0);
                   Exit;
                end;
             AccsDataModule.ClientVRN := ClientVatNumber;
             AStagedVATReturn.VRN := ClientVatNumber;
         end;

      if MTDApi.StageVATReturn(AStagedVATReturn) then
         ShellExecute(0, 'open', PChar(AccsDataModule.MTDConfig.WebUrl), nil, nil, SW_SHOWMAXIMIZED)
      else
         begin
            ErrorMessage := IfThenElse(MTDApi.LastError <> '', MTDApi.LastError, 'An error occurred while processing request');
            MessageDlg(ErrorMessage, mtError, [mbOK], 0);
         end;
   finally
      Screen.Cursor := crDefault;
      FreeAndNil(MTDApi);
   end;
end;

procedure TDigitalVATForm.FormDestroy(Sender: TObject);
begin
   Application.OnActivate := nil;
end;

end.

