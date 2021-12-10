unit uLedgerReport;

{
   26/08/16 - Added functionality to export extended report to XML File

           LineType - only used for export

           h1 - header line with Account No Info
           hx - header line with unrequired address info
           hc - column header line
           hb - header line with opening balance
           pa - payment line
           in - invoice line
           di - discount line
           id - invoice detail line
           it - invoice detail lines totals
           cb - line with closing balance
           cu - current balance
           c1 - balance + 1
           c2 - balance + 2
           c3 - balance + 3
           fx - footer line with unrequired info

   26/08/16 - Added new function to correctly pickup invoice line details from previous years transactions

   23/10/15 - Fixed bug where carried forward transactions were being incorrectly displayed on reports

   24/02/17 [V4.2 R7.1] /MK Additional Feature - Moved all code the creates the report from RunStatementReport to BuildStatementReport so as
                                                 the Stat unit can create the report to email it on to the clients.
                                               - New public form integer, FEmailCustSupp, that is assigned by Stat if emailing statement.

   01/06/18 [V4.3 R1.0] /MK Incorporated Changes from Andrew (TGM) - Changed PrinterSettings.FirstPage to 0 and PrinterSettings.LastPage to 0 as
                                                                     these settings were causing the statement to only print 2 pages as the original
                                                                     settings were PrinterSettings.FirstPage 1 and PrinterSettings.LastPage 2.

   31/10/18 [V4.3 R2.6] /MK Bug Fix - BuildStatementReport - TopLine1 should only show if the graphic is not showing because when the statement
                                                             is printed or saved as a PDF file, the statement header sits on top of the graphic - Tom Doran.
                           ** I saw that the letter head i.e. the graphic, is appearing on each page of the statement ( if more than one page ) GL says that this
                              is normal for a letter head **
                           ** I spoke with Andrew in TGM about the users address on the statement issue i.e. the address1 and address2 are merged as is the
                              address3 and address4. Andrew said the reason he did this so that even if the graphic is showing the customer's address
                              i.e. the customer of the Kingswood Accounts user, still fits in an envelope window.

   23/09/19 [V4.5 R0.6] /MK Change - EnterExtendedTxDetails, EnterExtendedTxDetailsLastYear -
                                     If there is a LineDate on an invoice then show it under the LineDate column - Tom Doran / GL.

   04/09/20 /AB Bug Fix - Ch029 - Bug fix within statement report. Running a report between 2 dates with no transactions the balances picked up is the current balance not the point in time balance
                                - Changes marked Ch029

   04/03/21 /AB Additional Feature - Changes marked Ch032.                             
}

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Dialogs;

type
  TLedgerReport = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    Company: TQRLabel;
    BottomLine: TQRShape;
    KingswoodLbl: TQRLabel;
    TimeLbl: TQRSysData;
    PrintDateLbl: TQRLabel;
    PageNumber: TQRSysData;
    Heading: TQRLabel;
    TopLine1: TQRShape;
    TopLine2: TQRShape;
    ReportDateLbl: TQRLabel;
    DetailBand1: TQRBand;
    QRDBText1: TQRDBText;
    PageFooterBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRDBText11: TQRDBText;
    KingsAccFooter: TQRLabel;
    ReportDate: TQRLabel;
    Dataset: TQRLabel;
    QRDBText12: TQRDBText;
    QRDBText13: TQRDBText;
    BlueLineLabel: TQRDBText;
    QRDBText14: TQRDBText;
    QRDBText15: TQRDBText;
    LineDebit: TQRDBText;
    LineVAT: TQRDBText;
    LinePrice: TQRDBText;
    LineUnitPrice: TQRDBText;
    LineQty: TQRDBText;
    QRDBText21: TQRDBText;
    LineCredit: TQRDBText;
    TotalLineCredit: TQRDBText;
    TotalLineDebit: TQRDBText;
    TotalLineVAT: TQRDBText;
    TotalLinePrice: TQRDBText;
    GreenLineLabel: TQRDBText;
    HeaderImage: TQRImage;
    QRDBText16: TQRDBText;
  private
    procedure EnterAccountDetails(header : boolean);
    procedure EnterStatementHeader(header : boolean);
    procedure GatherTransactions(AccountNo : Integer);
    procedure FilterLedgerTransactions;
    procedure FilterStatementTransactions;
    procedure GetAccountDetails(AccountNo : Integer);
    procedure EnterStatementFooter;
    procedure EnterExtendedTxDetails(TxNo : Integer);    // TGM AB 11/03/16
    procedure EnterExtendedTxDetailsLastYear(TxNo : Integer);
  public
    FEmailCustSupp : Integer;
    procedure BuildStatementReport;
    procedure RunLedgerReport;
    procedure RunStatementReport;
    function CheckAreaCode : boolean;
    procedure RunStatementReportExport(CompanyName : string); // TGM AB 26/08/16
    procedure GatherInvoiceInfo(TxNo : Integer);              // TGM AB 21/10/16
    Procedure GatherInvoiceInfoLastYear(TxNo : Integer);      // TGM AB 21/10/16
  end;

var
  LedgerReport: TLedgerReport;
  AccountStartLine : integer;
  ReportAccountNo, FirstTxOfYear {, LastTxOfYear, AgeCurr, Age1, Age2, Age3} : integer;
  Address1, Address2, Address3, Address4, Postcode : string;
  PageLineCount, AccountNo : integer;
  Balance, AgeCurr, Age1, Age2, Age3 : real;
  AccountName : string;
  IncBalance, ActiveAcc, ShowInEuro : boolean;
  ReportBalance, PrintBalance : real;
  datefilter : boolean;
  AreaCode : integer;
  ShowExtendedStatement : boolean;              // TGM AB 04/03/16
  ExtendedStatementConditions : integer;        // TGM AB 11/03/16
  ExtendedShowSubTotals : boolean;              // TGM AB 11/03/16
  ExtendedShowPerUnit : boolean;                // TGM AB 11/03/16
  ExtendedAltName1, ExtendedAltName2 : string;  // TGM AB 11/03/16
  TxLinePriceTotal, TxLineVATTotal, TxLineCreditTotal, TxLineDebitTotal : real;    // TGM AB 08/04/16
  ReportLinePriceTotal, ReportLineVATTotal, ReportLineCreditTotal, ReportLineDebitTotal : real;    // TGM AB 08/04/16
  GlobalFirstTxYear, GlobalFirstTxLastYear : Integer;                     //TGM AB 18/10/16
  ShowInvoiceDetails : Boolean;  // TGM AB 21/10/16
  InvoiceDate, InvoiceLine1, InvoiceLine2, InvoiceLine3 : String;   // TGM AB 21/10/16
  StatementPageLineLimit : Integer;                    // TGM AB 17/03/17
  StatementReportUseGraphic : Boolean;                 // TGM AB 17/03/17
  FilterFirstTxOfYear : Integer;                       // TGM AB 07/04/17
  LedgerPageLineLimit : Integer;                       // TGM AB 14/04/17
  IncStatementComment : Boolean;                       // Ch032
  StatementComment : String;                           // Ch032
  FilterFirstTxOfLastYear : Integer;                   // Ch034


implementation

{$R *.DFM}

 uses accsdata, vars, types, stat, params, FullAudit, DBCore, CalculateMonths, RCSList;

procedure TLedgerReport.RunLedgerReport;
var
   i : integer;
   OutputRecord : boolean;
begin


     GlobalFirstTxYear := FullAudit.AuditFiles.FirstTxThisYear;  //TGM AB 18/10/16
     GlobalFirstTxLastYear := FullAudit.AuditFiles.FirstTxLastYear;  //TGM AB 18/10/16

     LedgerPageLineLimit := 45;                       // TGM AB 14/04/17

     Accsdatamodule.LedgerReportDB.close;
     if FileExists  (Accsdatamodule.AccsDataBase.Directory + 'LedgerReportTable.db' ) then begin
         try DeleteFile  (Accsdatamodule.AccsDataBase.Directory + 'LedgerReportTable.db' );
         except showmessage('Error Deleting Ledger Report Table!');
         end;
     end;

     try Accsdatamodule.CreateLedgerReportTable;
     except showmessage('Error Creating Ledger Report Table!');
     end;

     Accsdatamodule.LedgerReportDB.open;

     Accsdatamodule.CustSuppTempTableDB.close;
     if FileExists  (Accsdatamodule.AccsDataBase.Directory + 'CustSuppTempTable.db' ) then begin
         try DeleteFile  (Accsdatamodule.AccsDataBase.Directory + 'CustSuppTempTable.db' );
         except showmessage('Error Deleting Cust/Supp Temp Table!');
         end;
     end;

     try Accsdatamodule.CreateCustSuppTempTable;
         except showmessage('Error Creating Cust/Supp Temp Table!');
         end;

     Accsdatamodule.CustSuppTempTableDB.open;

     // Pickup Options From Stat Form

     IncBalance := Stat.StatementForm.IncBalance.checked;

     ReportBalance := strtoFloat(Stat.StatementForm.GreaterThanBalance.text);

     ShowInEuro := Stat.StatementForm.ShowEuroTotals.checked;

     // code to generate options etc goes in here

     Case Stat.StatementForm.iAccType of

          1,2: begin     // all Accounts & Range Of Accounts
                   for i:= StatementForm.iAccFrom to StatementForm.iAccTo do begin
                   OutputRecord := False;
                   AccountNo := i;
                   GetAccountDetails(AccountNo);

                   Case Stat.StatementForm.iPrintType of
                       1: OutputRecord := True;
                       2: begin
                              if ((balance < (ReportBalance*-1)) or (balance > ReportBalance)) then OutputRecord := True;
                          end;
                       3: begin
                              if ((balance <> 0) or (FilterFirstTxOfYear > 0) or (FilterFirstTxOfLastYear > 0)) then OutputRecord := True;     //Ch034         // TGM AB 07/04/17
                          end;
                   end;

                   If not ActiveAcc then OutputRecord := false;

                   if OutputRecord then begin
                     PageLineCount := 0;
                     GatherTransactions(AccountNo);
                     EnterAccountDetails(true);
                     FilterLedgerTransactions;
                   end;
               end;
          end;
          3: begin     // Selected Accounts

               for i:= 1 to 9999 do begin
                   if Stat.StatementForm.PrList[i] <> 0 then begin
                      OutputRecord := False;
                      AccountNo := Stat.StatementForm.PrList[i];
                      GetAccountDetails(AccountNo);

                      Case Stat.StatementForm.iPrintType of
                           1: OutputRecord := True;
                           2: begin
                                  if ((balance < (ReportBalance*-1)) or (balance > ReportBalance)) then OutputRecord := True;
                              end;
                           3: begin
                                  if ((balance <> 0) or (FilterFirstTxOfYear > 0) or (FilterFirstTxOfLastYear > 0)) then OutputRecord := True;     //Ch034     // TGM AB 07/04/17
                              end;
                      end;
                          if OutputRecord then begin
                              PageLineCount := 0;
                              AccountNo := Stat.StatementForm.PrList[i];
                              GatherTransactions(AccountNo);
                              EnterAccountDetails(true);
                              FilterLedgerTransactions;
                          end;
                   end;
               end;
          end;

     end;

     LedgerReport.PageHeaderBand1.Height := 100;
     LedgerReport.HeaderImage.enabled := false;   // TGM AB 07/04/17

     Company.enabled := true;
     Dataset.enabled := true;
     Reportdate.enabled := true;
     ReportDatelbl.enabled := true;
     Printdatelbl.enabled := true;
     Timelbl.enabled := true;
     PageNumber.enabled := true;
     Kingswoodlbl.enabled := False;
     Bottomline.enabled := true;
     

     ReportDate.Caption := Cash11.DEFAULT_DATE;
     KingswoodLbl.caption := 'Kingswood Accounts ' + VerNo;
     Company.Caption := cash1.XCOMPANY;
     dataset.caption := RFarmGate.PLocation[2];
     If Prog = CustLED then Heading.caption := 'Customer Ledger Card'
        else Heading.caption := 'Supplier Ledger Card';
     Preview;

end;

procedure TLedgerReport.GetAccountDetails(AccountNo : Integer);
begin
   ReportAccountNo := AccountNo;
   try
      AccountName := '';
   except

   end;
   FirstTxOfYear := 0;
   Balance :=  0;
   Address1 :=  '';
   Address2 :=  '';
   Address3 :=  '';
   Address4 :=  '';
   PostCode :=  '';
   AgeCurr :=  0;
   Age1 :=  0;
   Age2 :=  0;
   Age3 :=  0;
   AreaCode :=  0;
   FilterFirstTxOfYear :=0;     // TGM AB 07/04/17
   FilterFirstTxOfLastYear :=0;     // Ch034


   Case Prog of

        CustLED : begin
                  Accsdatamodule.SLFileDB.Locate('SLNo',AccountNo,[]);
                  try AccountName := Accsdatamodule.SLFileDB['Name'];
                      FirstTxOfYear := Accsdatamodule.SLFileDB['FirstTx']; //xFirstTx; TGM AB 09/08/13
                      FilterFirstTxOfYear := Accsdatamodule.SLFileDB['FirstTx']; // TGM AB 28/04/17
                      Balance :=  Accsdatamodule.SLFileDB['Balance'];
                      ActiveAcc := Accsdatamodule.SLFileDB['Active'];
                  except
                      ActiveAcc := False;
                  end;
                  if FirstTxOfYear < GlobalFirstTxYear then FirstTxOfYear := GlobalFirstTxYear;  //TGM AB 23/10/15
        end;
        SUPPLED : begin
                  Accsdatamodule.PLFileDB.Locate('PLNo',AccountNo,[]);
                  try AccountName := Accsdatamodule.PLFileDB['Name'];
                      FirstTxOfYear := Accsdatamodule.PLFileDB['FirstTx']; //xFirstTx; TGM AB 09/08/13
                      FilterFirstTxOfYear := Accsdatamodule.PLFileDB['FirstTx']; // TGM AB 28/04/17
                      Balance :=  Accsdatamodule.PLFileDB['Balance'];
                      ActiveAcc := Accsdatamodule.PLFileDB['Active'];
                  except
                      ActiveAcc := False;
                  end;
                  if FirstTxOfYear < GlobalFirstTxYear then FirstTxOfYear := GlobalFirstTxYear;  //TGM AB 23/10/15
        end;
        CustSTM : begin
                  try Accsdatamodule.SLFileDB.Locate('SLNo',AccountNo,[]);
                  except
                      ActiveAcc := False;
                  end;
                      if vartostr(Accsdatamodule.SLFileDB['Name']) <> null then  AccountName :=  Accsdatamodule.SLFileDB['Name'];
                      FirstTxOfYear := Accsdatamodule.SLFileDB['FirstTx']; //xFirstTx; TGM AB 09/08/13
                      if FirstTxOfYear < GlobalFirstTxYear then FirstTxOfYear := GlobalFirstTxYear;  //TGM AB 23/10/15
                      FilterFirstTxOfYear := Accsdatamodule.SLFileDB['FirstTx']; // TGM AB 07/04/17
                      Balance :=  Accsdatamodule.SLFileDB['Balance'];
                      if vartostr(Accsdatamodule.SLFileDB['Address1']) <> null then  Address1 :=  Accsdatamodule.SLFileDB['Address1'];
                      if vartostr(Accsdatamodule.SLFileDB['Address2']) <> null then  Address2 :=  Accsdatamodule.SLFileDB['Address2'];
                      if vartostr(Accsdatamodule.SLFileDB['Address3']) <> null then  Address3 :=  Accsdatamodule.SLFileDB['Address3'];
                      if vartostr(Accsdatamodule.SLFileDB['Address4']) <> null then  Address4 :=  Accsdatamodule.SLFileDB['Address4'];
                      if vartostr(Accsdatamodule.SLFileDB['Postcode']) <> null then  PostCode :=  Accsdatamodule.SLFileDB['PostCode'];
                      AgeCurr :=  Accsdatamodule.SLFileDB['AgeCurr'];
                      Age1 :=  Accsdatamodule.SLFileDB['Age1'];
                      Age2 :=  Accsdatamodule.SLFileDB['Age2'];
                      Age3 :=  Accsdatamodule.SLFileDB['Age3'];
                      AreaCode :=  Accsdatamodule.SLFileDB['AreaCode'];
                      try ActiveAcc := Accsdatamodule.SLFileDB['Active'];        // TGM AB 30/04/16
                      except ActiveAcc := False;                                 // TGM AB 30/04/16
                      end;                                                       // TGM AB 30/04/16

        end;
        SUPPSTM : begin
                  try Accsdatamodule.PLFileDB.Locate('PLNo',AccountNo,[]);
                  except
                      ActiveAcc := False;
                  end;
                      if vartostr(Accsdatamodule.PLFileDB['Name']) <> null then  AccountName :=  Accsdatamodule.PLFileDB['Name'];
                      FirstTxOfYear := Accsdatamodule.PLFileDB['FirstTx']; //xFirstTx; TGM AB 09/08/13
                      if FirstTxOfYear < GlobalFirstTxYear then FirstTxOfYear := GlobalFirstTxYear;  //TGM AB 23/10/15
                      FilterFirstTxOfYear := Accsdatamodule.PLFileDB['FirstTx']; // TGM AB 07/04/17
                      Balance :=  Accsdatamodule.PLFileDB['Balance'];
                      if vartostr(Accsdatamodule.PLFileDB['Address1']) <> null then  Address1 :=  Accsdatamodule.PLFileDB['Address1'];
                      if vartostr(Accsdatamodule.PLFileDB['Address2']) <> null then  Address2 :=  Accsdatamodule.PLFileDB['Address2'];
                      if vartostr(Accsdatamodule.PLFileDB['Address3']) <> null then  Address3 :=  Accsdatamodule.PLFileDB['Address3'];
                      if vartostr(Accsdatamodule.PLFileDB['Address4']) <> null then  Address4 :=  Accsdatamodule.PLFileDB['Address4'];
                      if vartostr(Accsdatamodule.PLFileDB['PostCode']) <> null then  PostCode :=  Accsdatamodule.PLFileDB['PostCode'];
                      AgeCurr :=  Accsdatamodule.PLFileDB['AgeCurr'];
                      Age1 :=  Accsdatamodule.PLFileDB['Age1'];
                      Age2 :=  Accsdatamodule.PLFileDB['Age2'];
                      Age3 :=  Accsdatamodule.PLFileDB['Age3'];
                      AreaCode :=  Accsdatamodule.PLFileDB['AreaCode'];
                      try ActiveAcc := Accsdatamodule.PLFileDB['Active'];        // TGM AB 30/04/16
                      except ActiveAcc := False;                                 // TGM AB 30/04/16
                      end;                                                       // TGM AB 30/04/16

        end;
   end;

   // Ch034 looks back at last years data file if it exists and checks for FirstTx for the Account

   if Stat.StatementForm.IncludeLastYearsTx.checked then begin

        Case Prog of

                CustLED, CustSTM : begin       // SLFile

                    if FileExists  (Accsdatamodule.AccsDataBase.Directory + 'SLFile-1.db' ) then begin

                        Accsdatamodule.LastSLFileDB.open;

                        Accsdatamodule.LastSLFileDB.Locate('SLNo',AccountNo,[]);

                        if Accsdatamodule.LastSLFileDB['SLNo']= AccountNo then begin

                             FilterFirstTxOfLastYear := Accsdatamodule.LastSLFileDB['FirstTx'];

                        end;

                     end;   // File Exists
                end;

                SuppLED, SuppSTM : begin       // PLFile

                     if FileExists  (Accsdatamodule.AccsDataBase.Directory + 'PLFile-1.db' ) then begin

                        Accsdatamodule.LastPLFileDB.open;

                        Accsdatamodule.LastPLFileDB.Locate('PLNo',AccountNo,[]);

                        if Accsdatamodule.LastPLFileDB['PLNo']= AccountNo then begin

                             FilterFirstTxOfLastYear := Accsdatamodule.LastPLFileDB['FirstTx'];

                        end;

                     end;   // File Exists

                end;

        end;

   end; // if stat.

   // End Ch034



end;

procedure TLedgerReport.EnterAccountDetails(header : boolean);   // Header page 1 only
begin
        Accsdatamodule.LedgerReportDB.last;
        Accsdatamodule.LedgerReportDB.Edit;
        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB['AccountNoLabel'] := 'Account No ' + vartostr(AccountNo) + ' : ' + AccountName;
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;
        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;
        Accsdatamodule.LedgerReportDB.Append;
        if ShowInEuro then Accsdatamodule.LedgerReportDB['LineLabel'] := 'Date         Tx No     Type     Reference              Description                           Debit (€)       Credit (€)   Balance (€)'
            else Accsdatamodule.LedgerReportDB['LineLabel'] := 'Date         Tx No     Type    Reference              Description                                 Debit            Credit          Balance';
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;
        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB['LineLabel'] := ' _______________________________________________________________________________________';
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;

        if header then begin
                AccountStartLine := 0;
                Accsdatamodule.LedgerReportDB.Append;
                Accsdatamodule.LedgerReportDB['LineLabel'] := 'Account Starting Balance -';
                Accsdatamodule.LedgerReportDB['Balance'] := Balance;  // Was 0
                Accsdatamodule.LedgerReportDB.post;
                PageLineCount := PageLineCount + 1;
                AccountStartLine := Accsdatamodule.LedgerReportDB['ID'];
        end;

        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;

end;


procedure TLedgerReport.GatherTransactions(AccountNo : Integer);
var
   i : integer;
   RunningBalance : real;
   ArchiveYear : boolean;
   AddInDiscount : boolean;
   DiscountAmtCre : real;
   DiscountAmtDeb : real;
begin
   // Filter Txs
   Accsdatamodule.LedgerReportQuery.close;
   Accsdatamodule.LedgerReportQuery.sql.clear;

   Accsdatamodule.CustSuppTempTableDB.close;
   Accsdatamodule.CustSuppTempTableDB.EmptyTable;
   Accsdatamodule.CustSuppTempTableDB.open;

   DiscountAmtCre := 0;
   DiscountAmtDeb := 0;

   if ( Stat.StatementForm.IncludeLastYearsTx.Checked ) then
      begin
         Accsdatamodule.GatherPreviousYears;
         ArchiveYear := FileExists('C:\kingsacc\' + RFarmGate.pLocation[2] + '\Year-1.db')
      end;

   if ((Stat.StatementForm.IncludeLastYearsTx.checked) and (ArchiveYear)) then begin

       If Prog in [CustLED,CUSTSTM] then begin
           Accsdatamodule.LedgerReportQuery.sql.add('Select * from ''year-1'' where Account = ' + vartostr(Accountno) + ' and (txtype = 1 or txtype = 2 or txtype = 3 or txtype = 11 or txtype = 12) and TxNo >= ' + vartostr(GlobalFirstTxLastYear) + ' order by TxDate, TxNo');  //{or txtype = 11 or txtype = 12)}          // TGM AB 18/10/16
       end else begin  // SuppLED
           Accsdatamodule.LedgerReportQuery.sql.add('Select * from ''year-1'' where Account = ' + vartostr(Accountno) + ' and (txtype = 5 or txtype = 6 or txtype = 7 or txtype = 15 or txtype = 16) and TxNo >= ' + vartostr(GlobalFirstTxLastYear) + ' order by TxDate, TxNo');  //{or txtype = 15 or txtype = 16)}          // TGM AB 18/10/16
       end;
       Accsdatamodule.LedgerReportQuery.open;

       Accsdatamodule.LedgerReportQuery.first;

       for i := 1 to Accsdatamodule.LedgerReportQuery.recordcount do begin

        AddInDiscount := false;

        Accsdatamodule.CustSuppTempTableDB.Append;
        Accsdatamodule.CustSuppTempTableDB['LastYear'] := '*';
        Accsdatamodule.CustSuppTempTableDB['TxDate'] := Accsdatamodule.LedgerReportQuery['TxDate'];
        Accsdatamodule.CustSuppTempTableDB['TxNo'] := Accsdatamodule.LedgerReportQuery['TxNo'];
        Accsdatamodule.CustSuppTempTableDB['TxReference'] := Accsdatamodule.LedgerReportQuery['Reference'];
        Accsdatamodule.CustSuppTempTableDB['TxDescription'] := Accsdatamodule.LedgerReportQuery['Descript'];
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [1,11] then begin
                                                                                                     Accsdatamodule.CustSuppTempTableDB['TxType'] := 'INV';
                                                                                                     Accsdatamodule.CustSuppTempTableDB['Debit']  := Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc'];
        end;
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [5,15] then begin     // TGM AB 15/04/16 was 5,16
                                                                                                     Accsdatamodule.CustSuppTempTableDB['TxType'] := 'INV';
                                                                                                     Accsdatamodule.CustSuppTempTableDB['Credit']  := Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc'];
        end;
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [2,12] then begin
                                                                                                     Accsdatamodule.CustSuppTempTableDB['TxType'] := 'PAY';
                                                                                                     if Accsdatamodule.LedgerReportQuery['TaxDisc'] <> 0 then begin
                                                                                                         AddInDiscount := true;
                                                                                                         if Accsdatamodule.LedgerReportQuery['DebitAC'] = cash1.XNOMDEBTOR then begin
                                                                                                            Accsdatamodule.CustSuppTempTableDB['Debit']  := (Accsdatamodule.LedgerReportQuery['Amount']) * -1;
                                                                                                            DiscountAmtDeb := (Accsdatamodule.LedgerReportQuery['TaxDisc']) * -1
                                                                                                            end else begin
                                                                                                                 Accsdatamodule.CustSuppTempTableDB['Credit']  := Accsdatamodule.LedgerReportQuery['Amount'];
                                                                                                                 DiscountAmtCre :=Accsdatamodule.LedgerReportQuery['TaxDisc'];
                                                                                                            end;
                                                                                                     end else begin
                                                                                                         if Accsdatamodule.LedgerReportQuery['DebitAC'] = cash1.XNOMDEBTOR then Accsdatamodule.CustSuppTempTableDB['Debit']  := (Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc']) * -1
                                                                                                           else Accsdatamodule.CustSuppTempTableDB['Credit']  := Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc'];
                                                                                                         end;
        end;
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [6,16] then begin       // TGM AB 15/04/16 was 6,15
                                                                                                     Accsdatamodule.CustSuppTempTableDB['TxType'] := 'PAY';
                                                                                                     if Accsdatamodule.LedgerReportQuery['TaxDisc'] <> 0 then begin
                                                                                                        AddInDiscount := true;
                                                                                                        if Accsdatamodule.LedgerReportQuery['CreditAC'] = cash1.XNOMCREDIT then begin
                                                                                                           Accsdatamodule.CustSuppTempTableDB['Credit']  := (Accsdatamodule.LedgerReportQuery['Amount']) * -1;
                                                                                                           DiscountAmtCre := (Accsdatamodule.LedgerReportQuery['TaxDisc']) * -1;
                                                                                                        end else begin
                                                                                                           Accsdatamodule.CustSuppTempTableDB['Debit']  := Accsdatamodule.LedgerReportQuery['Amount'];
                                                                                                           DiscountAmtDeb :=Accsdatamodule.LedgerReportQuery['TaxDisc'];
                                                                                                        end;
                                                                                                     end else begin
                                                                                                     if Accsdatamodule.LedgerReportQuery['CreditAC'] = cash1.XNOMCREDIT then Accsdatamodule.CustSuppTempTableDB['Credit']  := (Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc']) * -1
                                                                                                           else Accsdatamodule.CustSuppTempTableDB['Debit']  := Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc'];
                                                                                                         end;
        end;
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [3] then begin
                                                                                               Accsdatamodule.CustSuppTempTableDB['TxType'] := 'CRN';
                                                                                               Accsdatamodule.CustSuppTempTableDB['Credit']  := (Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc']) * -1
        end;
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [7] then begin
                                                                                               Accsdatamodule.CustSuppTempTableDB['TxType'] := 'CRN';
                                                                                               Accsdatamodule.CustSuppTempTableDB['Debit']  := (Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc']) * -1
        end;
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [2] then Accsdatamodule.CustSuppTempTableDB['TxDescription'] := 'Receipt';
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [6] then Accsdatamodule.CustSuppTempTableDB['TxDescription'] := 'Payment';
        Accsdatamodule.CustSuppTempTableDB.post;
        if AddInDiscount then begin
           Accsdatamodule.CustSuppTempTableDB.Append;
           Accsdatamodule.CustSuppTempTableDB['LastYear'] := '*';
           Accsdatamodule.CustSuppTempTableDB['TxDate'] := Accsdatamodule.LedgerReportQuery['TxDate'];
           Accsdatamodule.CustSuppTempTableDB['TxNo'] := Accsdatamodule.LedgerReportQuery['TxNo'];
           Accsdatamodule.CustSuppTempTableDB['TxDescription'] := 'Discount';
           if DiscountAmtCre <> 0 then Accsdatamodule.CustSuppTempTableDB['Credit'] := DiscountAmtCre;
           if DiscountAmtDeb <> 0 then Accsdatamodule.CustSuppTempTableDB['Debit'] :=  DiscountAmtDeb;
           DiscountAmtCre := 0;
           DiscountAmtDeb := 0;
           Accsdatamodule.CustSuppTempTableDB['TxType'] := 'DIS';
           Accsdatamodule.CustSuppTempTableDB.post;
        end;
        Accsdatamodule.LedgerReportQuery.next;

     end;

   end; // last years tx's

   Accsdatamodule.LedgerReportQuery.close;
   Accsdatamodule.LedgerReportQuery.sql.clear;

   If Prog in [CustLED,CUSTSTM] then begin
           Accsdatamodule.LedgerReportQuery.sql.add('Select * from Transactions where Account = ' + vartostr(Accountno) + ' and (txtype = 1 or txtype = 2 or txtype = 3 or txtype = 11 or txtype = 12) and TxNo >= ' + vartostr(FirstTxOfYear) + ' order by TxDate, TxNo');        //{or txtype = 11 or txtype = 12)}
        end else begin  // SuppLED
           Accsdatamodule.LedgerReportQuery.sql.add('Select * from Transactions where Account = ' + vartostr(Accountno) + ' and (txtype = 5 or txtype = 6 or txtype = 7 or txtype = 15 or txtype = 16) and TxNo >= ' + vartostr(FirstTxOfYear) + ' order by TxDate, TxNo');        //{or txtype = 15 or txtype = 16)}
        end;
   Accsdatamodule.LedgerReportQuery.open;

   Accsdatamodule.LedgerReportQuery.first;

   for i := 1 to Accsdatamodule.LedgerReportQuery.recordcount do begin

        AddInDiscount := false;

        Accsdatamodule.CustSuppTempTableDB.Append;
        Accsdatamodule.CustSuppTempTableDB['TxDate'] := Accsdatamodule.LedgerReportQuery['TxDate'];
        Accsdatamodule.CustSuppTempTableDB['TxNo'] := Accsdatamodule.LedgerReportQuery['TxNo'];
        Accsdatamodule.CustSuppTempTableDB['TxReference'] := Accsdatamodule.LedgerReportQuery['Reference'];
        Accsdatamodule.CustSuppTempTableDB['TxDescription'] := Accsdatamodule.LedgerReportQuery['Descript'];
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [1,11] then begin
                                                                                                     Accsdatamodule.CustSuppTempTableDB['TxType'] := 'INV';
                                                                                                     Accsdatamodule.CustSuppTempTableDB['Debit']  := Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc'];
        end;
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [5,15] then begin   // TGM AB 15/04/16 was 5,16
                                                                                                     Accsdatamodule.CustSuppTempTableDB['TxType'] := 'INV';
                                                                                                     Accsdatamodule.CustSuppTempTableDB['Credit']  := Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc'];
        end;
    (*    if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [2,12] then begin
                                                                                                     Accsdatamodule.CustSuppTempTableDB['TxType'] := 'PAY';
                                                                                                     Accsdatamodule.CustSuppTempTableDB['Discount'] := Accsdatamodule.LedgerReportQuery['TaxDisc'];
                                                                                                        if Accsdatamodule.LedgerReportQuery['DebitAC'] = cash1.XNOMDEBTOR then Accsdatamodule.CustSuppTempTableDB['Debit']  := (Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc']) * -1
                                                                                                           else Accsdatamodule.CustSuppTempTableDB['Credit']  := Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc'];
        end;
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [6,15] then begin
                                                                                                     Accsdatamodule.CustSuppTempTableDB['TxType'] := 'PAY';
                                                                                                     Accsdatamodule.CustSuppTempTableDB['Discount'] := Accsdatamodule.LedgerReportQuery['TaxDisc'];
                                                                                                     if Accsdatamodule.LedgerReportQuery['CreditAC'] = cash1.XNOMCREDIT then Accsdatamodule.CustSuppTempTableDB['Credit']  := (Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc']) * -1
                                                                                                           else Accsdatamodule.CustSuppTempTableDB['Debit']  := Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc'];
        end;   *)
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [2,12] then begin
                                                                                                     Accsdatamodule.CustSuppTempTableDB['TxType'] := 'PAY';
                                                                                                     if Accsdatamodule.LedgerReportQuery['TaxDisc'] <> 0 then begin
                                                                                                         AddInDiscount := true;
                                                                                                         if Accsdatamodule.LedgerReportQuery['DebitAC'] = cash1.XNOMDEBTOR then begin
                                                                                                            Accsdatamodule.CustSuppTempTableDB['Debit']  := (Accsdatamodule.LedgerReportQuery['Amount']) * -1;
                                                                                                            DiscountAmtDeb := (Accsdatamodule.LedgerReportQuery['TaxDisc']) * -1
                                                                                                            end else begin
                                                                                                                 Accsdatamodule.CustSuppTempTableDB['Credit']  := Accsdatamodule.LedgerReportQuery['Amount'];
                                                                                                                 DiscountAmtCre :=Accsdatamodule.LedgerReportQuery['TaxDisc'];
                                                                                                            end;
                                                                                                     end else begin
                                                                                                         if Accsdatamodule.LedgerReportQuery['DebitAC'] = cash1.XNOMDEBTOR then Accsdatamodule.CustSuppTempTableDB['Debit']  := (Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc']) * -1
                                                                                                           else Accsdatamodule.CustSuppTempTableDB['Credit']  := Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc'];
                                                                                                         end;
        end;
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [6,16] then begin   // TGM AB 15/04/16 was 6,15
                                                                                                     Accsdatamodule.CustSuppTempTableDB['TxType'] := 'PAY';
                                                                                                     if Accsdatamodule.LedgerReportQuery['TaxDisc'] <> 0 then begin
                                                                                                        AddInDiscount := true;
                                                                                                        if Accsdatamodule.LedgerReportQuery['CreditAC'] = cash1.XNOMCREDIT then begin
                                                                                                           Accsdatamodule.CustSuppTempTableDB['Credit']  := (Accsdatamodule.LedgerReportQuery['Amount']) * -1;
                                                                                                           DiscountAmtCre := (Accsdatamodule.LedgerReportQuery['TaxDisc']) * -1;
                                                                                                        end else begin
                                                                                                           Accsdatamodule.CustSuppTempTableDB['Debit']  := Accsdatamodule.LedgerReportQuery['Amount'];
                                                                                                           DiscountAmtDeb :=Accsdatamodule.LedgerReportQuery['TaxDisc'];
                                                                                                        end;
                                                                                                     end else begin
                                                                                                     if Accsdatamodule.LedgerReportQuery['CreditAC'] = cash1.XNOMCREDIT then Accsdatamodule.CustSuppTempTableDB['Credit']  := (Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc']) * -1
                                                                                                           else Accsdatamodule.CustSuppTempTableDB['Debit']  := Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc'];
                                                                                                         end;
        end;
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [3] then begin
                                                                                               Accsdatamodule.CustSuppTempTableDB['TxType'] := 'CRN';
                                                                                               Accsdatamodule.CustSuppTempTableDB['Credit']  := (Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc']) * -1
        end;
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [7] then begin
                                                                                               Accsdatamodule.CustSuppTempTableDB['TxType'] := 'CRN';
                                                                                               Accsdatamodule.CustSuppTempTableDB['Debit']  := (Accsdatamodule.LedgerReportQuery['Amount'] + Accsdatamodule.LedgerReportQuery['TaxDisc']) * -1
        end;
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [2] then Accsdatamodule.CustSuppTempTableDB['TxDescription'] := 'Receipt';
        if Accsdatamodule.LedgerReportQuery.FieldByName('TxType').asinteger in [6] then Accsdatamodule.CustSuppTempTableDB['TxDescription'] := 'Payment';
        Accsdatamodule.CustSuppTempTableDB.post;
        if AddInDiscount then begin
           Accsdatamodule.CustSuppTempTableDB.Append;
           Accsdatamodule.CustSuppTempTableDB['TxDate'] := Accsdatamodule.LedgerReportQuery['TxDate'];
           Accsdatamodule.CustSuppTempTableDB['TxNo'] := Accsdatamodule.LedgerReportQuery['TxNo'];
           Accsdatamodule.CustSuppTempTableDB['TxDescription'] := 'Discount';
           if DiscountAmtCre <> 0 then Accsdatamodule.CustSuppTempTableDB['Credit'] := DiscountAmtCre;
           if DiscountAmtDeb <> 0 then Accsdatamodule.CustSuppTempTableDB['Debit'] :=  DiscountAmtDeb;
           DiscountAmtCre := 0;
           DiscountAmtDeb := 0;
           Accsdatamodule.CustSuppTempTableDB['TxType'] := 'DIS';
           Accsdatamodule.CustSuppTempTableDB.post;
        end;
        Accsdatamodule.LedgerReportQuery.next;

   end;

   Accsdatamodule.CustSuppTempTableDB.last;
   RunningBalance := Balance;

   If ShowInEuro then begin
        RunningBalance := Balance / cash11.xEuroConverter;
   end;

   for i:= 1 to Accsdatamodule.CustSuppTempTableDB.RecordCount do begin

       if Prog in [CustLED,CUSTSTM] then begin    // TGM AB
                      Accsdatamodule.CustSuppTempTableDB.edit;
                      If ShowInEuro then begin
                         Accsdatamodule.CustSuppTempTableDB['Debit'] := Accsdatamodule.CustSuppTempTableDB['Debit'] / cash11.xEuroConverter;
                         Accsdatamodule.CustSuppTempTableDB['Credit'] := Accsdatamodule.CustSuppTempTableDB['Credit'] / cash11.xEuroConverter;
                      end;
                      Accsdatamodule.CustSuppTempTableDB['Balance'] := RunningBalance;
                      Accsdatamodule.CustSuppTempTableDB.post;
                      RunningBalance := RunningBalance + Accsdatamodule.CustSuppTempTableDB.FieldByName('Credit').asfloat - Accsdatamodule.CustSuppTempTableDB.FieldByName('Debit').asfloat;
       end else begin
                      Accsdatamodule.CustSuppTempTableDB.edit;
                      If ShowInEuro then begin
                         Accsdatamodule.CustSuppTempTableDB['Debit'] := Accsdatamodule.CustSuppTempTableDB['Debit'] / cash11.xEuroConverter;
                         Accsdatamodule.CustSuppTempTableDB['Credit'] := Accsdatamodule.CustSuppTempTableDB['Credit'] / cash11.xEuroConverter;
                      end;
                      Accsdatamodule.CustSuppTempTableDB['Balance'] := RunningBalance;
                      Accsdatamodule.CustSuppTempTableDB.post;
                      RunningBalance := RunningBalance - Accsdatamodule.CustSuppTempTableDB.FieldByName('Credit').asfloat + Accsdatamodule.CustSuppTempTableDB.FieldByName('Debit').asfloat;
                end;

       Accsdatamodule.CustSuppTempTableDB.prior;
   end;




end;

procedure TLedgerReport.FilterLedgerTransactions;
var
     DateFrom, DateTo, testdate : tdatetime;
     i,j : integer;
     runningbalance, openingbalance : real;
     FirstTx : boolean;
     FirstTx2 : boolean;
begin


       // print qualifying transactions
       datefilter := false;
       DateFrom := strtodate('01/01/90');
       DateTo := Now + 366;                      // TGM AB 01/09/17   - allows for accidential invoices dated in the future
       FirstTx := True;
       runningbalance := 0;
       openingbalance := 0;

       if ((stat.StatementForm.DateFrom.Text <> '  /  /  ') or (stat.StatementForm.DateTo.Text <> '  /  /  ')) then begin
           datefilter := true;
           if stat.StatementForm.DateFrom.Text <> '  /  /  ' then DateFrom := strtodate(stat.StatementForm.DateFrom.Text);
           if stat.StatementForm.DateTo.Text <> '  /  /  ' then DateTo := strtodate(stat.StatementForm.DateTo.Text);
       end;

       Accsdatamodule.CustSuppTempTableDB.First;

       For i:= 1 to Accsdatamodule.CustSuppTempTableDB.recordcount do begin
         // date range check
           testdate := Accsdatamodule.CustSuppTempTableDB['TxDate'];
           if ((testdate >= DateFrom) and (testdate <= DateTo)) then begin
              if FirstTx then begin
                 Accsdatamodule.LedgerReportDB.prior;
             //    Accsdatamodule.LedgerReportDB.prior;
                 Accsdatamodule.LedgerReportDB.edit;
                 if Prog = CustLED then begin
                        openingbalance := Accsdatamodule.CustSuppTempTableDB['Balance'];
                        try openingbalance := openingbalance + Accsdatamodule.CustSuppTempTableDB['Credit'];
                        except
                        end;
                        try openingbalance := openingbalance - Accsdatamodule.CustSuppTempTableDB['Debit'];
                        except
                        end;
                      end else begin
                                openingbalance := Accsdatamodule.CustSuppTempTableDB['Balance'];
                                try openingbalance := openingbalance - Accsdatamodule.CustSuppTempTableDB['Credit'];
                                except
                                end;
                                try openingbalance := openingbalance + Accsdatamodule.CustSuppTempTableDB['Debit'];
                                except
                                end;
                 end;
                 Accsdatamodule.LedgerReportDB['Balance'] := openingbalance;
                 Accsdatamodule.LedgerReportDB.post;
                 Accsdatamodule.LedgerReportDB.next;
            //     Accsdatamodule.LedgerReportDB.edit;
                 FirstTx := False;
              end;
              Accsdatamodule.LedgerReportDB.Append;
              Accsdatamodule.LedgerReportDB['LastYear'] := Accsdatamodule.CustSuppTempTableDB['LastYear'];
              Accsdatamodule.LedgerReportDB['TxDate'] := Accsdatamodule.CustSuppTempTableDB['TxDate'];
              Accsdatamodule.LedgerReportDB['TxNo'] := Accsdatamodule.CustSuppTempTableDB['TxNo'];
              Accsdatamodule.LedgerReportDB['TxType'] := Accsdatamodule.CustSuppTempTableDB['TxType'];
              Accsdatamodule.LedgerReportDB['TxReference'] := Accsdatamodule.CustSuppTempTableDB['TxReference'];
              Accsdatamodule.LedgerReportDB['TxDescription'] := Accsdatamodule.CustSuppTempTableDB['TxDescription'];
              Accsdatamodule.LedgerReportDB['Debit'] := Accsdatamodule.CustSuppTempTableDB['Debit'];
              Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.CustSuppTempTableDB['Credit'];
              if incbalance then Accsdatamodule.LedgerReportDB['Balance'] := Accsdatamodule.CustSuppTempTableDB['Balance'];
              RunningBalance := Accsdatamodule.CustSuppTempTableDB['Balance'];
              Accsdatamodule.LedgerReportDB.post;
              PageLineCount := PageLineCount + 1;
          //    Accsdatamodule.CustSuppTempTableDB.next;

              if pagelinecount = LedgerPageLineLimit then begin
                        pagelinecount := 0;
                        EnterAccountDetails(False);
              end;

           end;
         Accsdatamodule.CustSuppTempTableDB.next;
       end;

       if datefilter then begin

              if pagelinecount >= (LedgerPageLineLimit -4) then begin                             // TGM AB 14/04/17 was 42
                  for j:=pagelinecount to(LedgerPageLineLimit - 1) do begin                       // TGM AB 14/04/17 was 45
                      Accsdatamodule.LedgerReportDB.Append;
                      Accsdatamodule.LedgerReportDB.post;
                      PageLineCount := PageLineCount + 1;
                  end;
                  pagelinecount := 0;
                  EnterAccountDetails(False);
              end;

              Accsdatamodule.LedgerReportDB.Append;
              Accsdatamodule.LedgerReportDB.post;
              PageLineCount := PageLineCount + 1;
              Accsdatamodule.LedgerReportDB.Append;

              Accsdatamodule.LedgerReportDB['Balance'] := runningbalance;
              if stat.StatementForm.DateTo.Text <> '  /  /  ' then Accsdatamodule.LedgerReportDB['LineLabel'] := 'Balance on ' + vartostr(DateTo)
                      else Accsdatamodule.LedgerReportDB['LineLabel'] := 'Balance on ' + copy(vartostr(Stat.StatementForm.RepDate.Text),1,8);

              Accsdatamodule.LedgerReportDB.post;
              PageLineCount := PageLineCount + 1;
              Accsdatamodule.LedgerReportDB.Append;
              Accsdatamodule.LedgerReportDB.post;
              PageLineCount := PageLineCount + 1;
              Accsdatamodule.LedgerReportDB.Append;
              Accsdatamodule.LedgerReportDB['Balance'] := Balance;
              if ShowInEuro then Accsdatamodule.LedgerReportDB['Balance'] := Accsdatamodule.LedgerReportDB['Balance'] /cash11.xEuroConverter;
              Accsdatamodule.LedgerReportDB['LineLabel'] := 'Current Balance';
              Accsdatamodule.LedgerReportDB.post;
              PageLineCount := PageLineCount + 1;
       end else begin

                        if pagelinecount >= (LedgerPageLineLimit - 2) then begin                      // TGM AB 14/04/17 was 44
                            for j:=pagelinecount to (LedgerPageLineLimit - 1) do begin                 // TGM AB 14/04/17 was 44
                                Accsdatamodule.LedgerReportDB.Append;
                                Accsdatamodule.LedgerReportDB.post;
                                PageLineCount := PageLineCount + 1;
                            end;
                            pagelinecount := 0;
                            EnterAccountDetails(False);
                        end;

                        Accsdatamodule.LedgerReportDB.Append;
                        Accsdatamodule.LedgerReportDB.post;
                        PageLineCount := PageLineCount + 1;
                        Accsdatamodule.LedgerReportDB.Append;
                        Accsdatamodule.LedgerReportDB['Balance'] := Balance;
                        if ShowInEuro then Accsdatamodule.LedgerReportDB['Balance'] := Accsdatamodule.LedgerReportDB['Balance'] /cash11.xEuroConverter;
                        Accsdatamodule.LedgerReportDB['LineLabel'] := 'Current Balance';
                        Accsdatamodule.LedgerReportDB.post;
                        PageLineCount := PageLineCount + 1;
           end;

       while pagelinecount < LedgerPageLineLimit do begin                             // TGM AB 14/04/17 was 46
             Accsdatamodule.LedgerReportDB.Append;
             Accsdatamodule.LedgerReportDB.post;
             PageLineCount := PageLineCount + 1;
       end;

end;

procedure TLedgerReport.BuildStatementReport;
var
   i : Integer;
   OutputRecord : Boolean;
begin

   // TGM AB 17/03/17

   try
      if ( not(AccsDataModule.Statement.Active) ) then AccsDataModule.Statement.Open;
   except
   end;

   if Prog = CustSTM then accsdatamodule.Statement.locate('StateType','S',[])
            else accsdatamodule.Statement.locate('StateType','P',[]);

   StatementReportUseGraphic := false;

   if ((AccsDataModule.Statement['UseGraphicsFile'] = true) and (FileExists(accsdatamodule.statement['GraphicsFileName']))) then begin
                                                                StatementReportUseGraphic := True;
                                                                StatementPageLineLimit := 44;
                                                                HeaderImage.Parent := PageHeaderBand1;
                                                                LedgerReport.PageHeaderBand1.height := 119;
                                                                LedgerReport.HeaderImage.enabled := true;
                                                                LedgerReport.HeaderImage.Top := 0;
                                                                LedgerReport.HeaderImage.Left := 0;
                                                                LedgerReport.HeaderImage.Picture.LoadFromFile(accsdatamodule.statement['GraphicsFileName']);


   end
        else begin
            StatementPageLineLimit := 48;
            LedgerReport.PageHeaderBand1.height := 40;
            LedgerReport.HeaderImage.enabled := false;
        end;

   // end TGM AB 17/03/17

   //Ch032 start

   if AccsDataModule.Statement['IncludeComment'] = true then begin
          IncStatementComment := True;

          try StatementComment := AccsDataModule.Statement.fieldbyname('Comment').asstring;
          except    StatementComment :=  '';
          end;

   end
        else begin
                IncStatementComment := False;
                StatementComment := '';
        end;

    //Ch032 end

   GlobalFirstTxYear := FullAudit.AuditFiles.FirstTxThisYear;  //TGM AB 18/10/16
   GlobalFirstTxLastYear := FullAudit.AuditFiles.FirstTxLastYear;  //TGM AB 18/10/16

   Accsdatamodule.LedgerReportDB.close;
   if ( FileExists(Accsdatamodule.AccsDataBase.Directory + 'LedgerReportTable.db') ) then
      try
         DeleteFile(Accsdatamodule.AccsDataBase.Directory + 'LedgerReportTable.db');
      except
         MessageDlg('Error Deleting Ledger Report Table!',mtError,[mbOK],0);
      end;

   try
      Accsdatamodule.CreateLedgerReportTable;
   except
      MessageDlg('Error Creating Ledger Report Table!',mtError,[mbOK],0);
   end;

   Accsdatamodule.LedgerReportDB.open;

   Accsdatamodule.CustSuppTempTableDB.close;
   if ( FileExists(Accsdatamodule.AccsDataBase.Directory + 'CustSuppTempTable.db') ) then
      try
         DeleteFile(Accsdatamodule.AccsDataBase.Directory + 'CustSuppTempTable.db' );
      except
         MessageDlg('Error Deleting Cust/Supp Temp Table!',mtError,[mbOK],0);
      end;

   try
      Accsdatamodule.CreateCustSuppTempTable;
   except
      MessageDlg('Error Creating Cust/Supp Temp Table!',mtError,[mbOK],0);
   end;

   Accsdatamodule.CustSuppTempTableDB.open;

   // Pickup Options From Stat Form
   ShowInEuro := Stat.StatementForm.ShowEuroTotals.checked;

   IncBalance := true; // true for statements

   ShowExtendedStatement := Stat.StatementForm.CBExtendedStatement.checked;                     // TGM AB 04/03/16
   ExtendedStatementConditions := Stat.StatementForm.GroupExtendedConditions.ItemIndex;         // TGM AB 11/03/16
   ExtendedShowSubTotals := Stat.StatementForm.CBExtendedSubTotals.checked;                     // TGM AB 11/03/16
   ExtendedShowPerUnit := Stat.StatementForm.CBExtendedShowPerUnit.checked;                     // TGM AB 11/03/16
   try
      ExtendedAltName1 := Stat.StatementForm.ExtAltName1.text;                                  // TGM AB 11/03/16
   except
      ExtendedAltName1 := '';                                                                   // TGM AB 11/03/16
   end;                                                                                         // TGM AB 11/03/16
   try
      ExtendedAltName2 := Stat.StatementForm.ExtAltName2.text;                                  // TGM AB 11/03/16
   except
      ExtendedAltName2 := '';                                                                   // TGM AB 11/03/16
   end;                                                                                         // TGM AB 11/03/16

   ShowInvoiceDetails := Stat.StatementForm.UseInvoiceDetailsCB.checked;                        // TGM AB 21/10/16

   ReportLinePriceTotal := 0;    // TGM AB 08/04/16
   ReportLineVATTotal := 0;      // TGM AB 08/04/16
   ReportLineCreditTotal := 0;   // TGM AB 08/04/16
   ReportLineDebitTotal := 0;    // TGM AB 08/04/16

   // code to generate options etc goes in here
   case Stat.StatementForm.iAccType of
      1,2: for i:= StatementForm.iAccFrom to StatementForm.iAccTo do // all Accounts & Range Of Accounts
              begin
                 OutputRecord := False;
                 AccountNo := i;
                 GetAccountDetails(AccountNo);
                 if ActiveAcc then
                    ActiveAcc := checkareacode;           // TGM AB 30/04/16

                 case Stat.StatementForm.iPrintType of
                     1: OutputRecord := True;
                     2: if ( (balance < (ReportBalance*-1)) or (balance > ReportBalance) ) then
                           OutputRecord := True;
                     3: if ((balance <> 0) or (FilterFirstTxOfYear > 0) or (FilterFirstTxOfLastYear > 0)) then          //Ch034  // TGM AB 07/04/17
                           OutputRecord := True;
                 end;

                 if not ActiveAcc then OutputRecord := False;   //OutputRecord := ActiveAcc;                     // TGM AB 07/04/17

                 if OutputRecord then
                    begin
                      PageLineCount := 0;
                      ReportLinePriceTotal := 0;    // TGM AB 08/04/16
                      ReportLineVATTotal := 0;      // TGM AB 08/04/16
                      ReportLineCreditTotal := 0;   // TGM AB 08/04/16
                      ReportLineDebitTotal := 0;    // TGM AB 08/04/16
                      GatherTransactions(AccountNo);
                      EnterStatementHeader(true);
                      FilterStatementTransactions;
                    end;
              end;
      3: for i:= 1 to 9999 do // Selected Accounts
            begin
               if ( Stat.StatementForm.PrList[i] <> 0 ) then
                  begin
                     OutputRecord := False;
                     AccountNo := Stat.StatementForm.PrList[i];
                     GetAccountDetails(AccountNo);
                     if ( ActiveAcc ) then
                        ActiveAcc := checkareacode;           // TGM AB 30/04/16

                     case Stat.StatementForm.iPrintType of
                        1: OutputRecord := True;
                        2: if ((balance < (ReportBalance*-1)) or (balance > ReportBalance)) then
                              OutputRecord := True;
                        3: if ((balance <> 0) or (FilterFirstTxOfYear > 0) or (FilterFirstTxOfLastYear > 0)) then         //Ch034            // TGM AB 07/04/17
                              OutputRecord := True;
                     end;

                     if not ActiveAcc then OutputRecord := False;   //OutputRecord := ActiveAcc;                     // TGM AB 07/04/17

                     if OutputRecord then
                        begin
                           PageLineCount := 0;
                           AccountNo := Stat.StatementForm.PrList[i];
                           ReportLinePriceTotal := 0;    // TGM AB 08/04/16
                           ReportLineVATTotal := 0;      // TGM AB 08/04/16
                           ReportLineCreditTotal := 0;   // TGM AB 08/04/16
                           ReportLineDebitTotal := 0;    // TGM AB 08/04/16
                           GatherTransactions(AccountNo);
                           EnterStatementHeader(true);
                           FilterStatementTransactions;
                        end;
                  end;
            end;
      4: if ( FEmailCustSupp > 0 ) then
            begin
                OutputRecord := False;
                GetAccountDetails(FEmailCustSupp);
                if ( ActiveAcc ) then
                   ActiveAcc := checkareacode;

                case Stat.StatementForm.iPrintType of
                   1: OutputRecord := True;
                   2: if ((balance < (ReportBalance*-1)) or (balance > ReportBalance)) then
                         OutputRecord := True;
                   3: if ((balance <> 0) or (FilterFirstTxOfYear > 0) or (FilterFirstTxOfLastYear > 0)) then         //Ch034     // TGM AB 07/04/17
                         OutputRecord := True;
                end;

                if not ActiveAcc then OutputRecord := False;   //OutputRecord := ActiveAcc;                     // TGM AB 07/04/17

                if OutputRecord then
                   begin
                      PageLineCount := 0;
                      AccountNo := Stat.StatementForm.PrList[i];
                      ReportLinePriceTotal := 0;
                      ReportLineVATTotal := 0;
                      ReportLineCreditTotal := 0;
                      ReportLineDebitTotal := 0;
                      GatherTransactions(FEmailCustSupp);
                      EnterStatementHeader(true);
                      FilterStatementTransactions;
                   end;
            end;
   end;

  //  LedgerReport.PageHeaderBand1.Height := 40;        TGM AB 07/04/17
   Company.enabled := false;
   Dataset.enabled := false;
   Reportdate.enabled := false;
   ReportDatelbl.enabled := false;
   Printdatelbl.enabled := false;
   Timelbl.enabled := false;
   PageNumber.enabled := false;
   Kingswoodlbl.enabled := false;
   Bottomline.enabled := false;

   if ( Prog = CustSTM ) then
      Heading.caption := 'Customer Statement'
   else
      Heading.caption := 'Supplier Remittance';

   if ( ShowExtendedStatement ) then
      Heading.caption := 'Extended ' + Heading.caption;   // TGM AB 04/03/16

   try
      if ( not(AccsDataModule.Statement.Active) ) then
         AccsDataModule.Statement.Open;
      AccsDataModule.Statement.FieldByName('ShowHeader');
      //   31/10/18 [V4.3 R2.6] /MK Bug Fix - TopLine1 should only show if the graphic is not showing because when the statement
      //                                      is printed or saved as a PDF file, the statement header sits on top of the graphic.
      Topline1.Enabled := ( AccsDataModule.Statement.FieldByName('ShowHeader').AsBoolean ) and
                          ( not(StatementReportUseGraphic) );
   except
      Topline1.Enabled := False;
   end;

   Topline2.Enabled := Topline1.Enabled;
   Heading.Enabled :=  Topline1.Enabled;

   if ( ShowExtendedStatement ) then
      begin
         LineUnitPrice.Enabled := ExtendedShowPerUnit;

         TotalLineCredit.Enabled := False;   // TGM AB 15/04/16 disabled as already displayed on main transaction line
         TotalLineDebit.Enabled := False;    // TGM AB 15/04/16 disabled as already displayed on main transaction line

         case ExtendedStatementConditions of
            0 : begin
                   LinePrice.Enabled := true;
                   LineVAT.Enabled := true;
                   LineDebit.Enabled := true;
                   LineCredit.Enabled := true;
                   TotalLinePrice.Enabled := True;
                   TotalLineVAT.Enabled := True;
                   GreenLineLabel.Enabled := True;
                end;
            1 : begin
                   LinePrice.Enabled := false;
                   LineVAT.Enabled := false;
                   LineDebit.Enabled := true;
                   LineCredit.Enabled := true;
                   TotalLinePrice.Enabled := false;
                   TotalLineVAT.Enabled := false;
                   GreenLineLabel.Enabled := False;
                end;
            2 : begin
                   LinePrice.Enabled := false;
                   LineVAT.Enabled := false;
                   LineDebit.Enabled := true;
                   LineCredit.Enabled := true;
                   TotalLinePrice.Enabled := True;
                   TotalLineVAT.Enabled := True;
                   GreenLineLabel.Enabled := True;
                end;
            3 : begin
                   LinePrice.Enabled := true;
                   LineVAT.Enabled := false;
                   LineDebit.Enabled := false;
                   LineCredit.Enabled := false;
                   TotalLinePrice.Enabled := True;
                   TotalLineVAT.Enabled := True;
                   GreenLineLabel.Enabled := True;
                end;
            end;
      end;
end;

procedure TLedgerReport.RunStatementReport;
begin
   BuildStatementReport;
   Preview;
end;

procedure TLedgerReport.EnterStatementHeader(header : boolean);   // Header page 1 only
var
        Tempstr : string;

begin
        if header then begin
        AccsDataModule.Statement.open;
      //  AccsDataModule.Statement.last;  // TGM AB 15/10/10 was first;
        if Prog = CustSTM then accsdatamodule.Statement.locate('StateType','S',[])
            else accsdatamodule.Statement.locate('StateType','P',[]);

        if Accsdatamodule.Statement['StatementFrom'] = True then begin
           Accsdatamodule.LedgerReportDB.last;
           Accsdatamodule.LedgerReportDB.Edit;
           Accsdatamodule.LedgerReportDB.Append;
           Accsdatamodule.LedgerReportDB['AccountNoLabel'] := 'From :';
           Accsdatamodule.LedgerReportDB['StatementLabel'] := AccsDataModule.Statement['Name'];
           Accsdatamodule.LedgerReportDB['LineType'] := 'hx';  // TGM AB 02/09/16
           Accsdatamodule.LedgerReportDB.post;
           PageLineCount := PageLineCount + 1;

           // TGM AB 07/04/17 begin

           //   31/10/18 [V4.3 R2.6] /MK Change - I took out this code that merges the Address1&Address2 as well as the Address3&Address4 if the graphic file is showing
           //                                     as it doesn't seem to be required anymore. Tested with Tom Doran's data who has long addresses'.
           if StatementReportUseGraphic then begin
                Accsdatamodule.LedgerReportDB.Append;
                Tempstr := '';
                Tempstr := vartostr(AccsDataModule.Statement['Address1']);
                if length(vartostr(AccsDataModule.Statement['Address2'])) > 0 then Tempstr := Tempstr + ', ' + vartostr(AccsDataModule.Statement['Address2']);
                Accsdatamodule.LedgerReportDB['StatementLabel'] := Tempstr;
                Accsdatamodule.LedgerReportDB['LineType'] := 'hx';
                Accsdatamodule.LedgerReportDB.post;
                PageLineCount := PageLineCount + 1;
                Accsdatamodule.LedgerReportDB.Append;
                Tempstr := '';
                Tempstr := vartostr(AccsDataModule.Statement['Address3']);
                if length(vartostr(AccsDataModule.Statement['Address4'])) > 0 then Tempstr := Tempstr + ', ' + vartostr(AccsDataModule.Statement['Address4']);
                Accsdatamodule.LedgerReportDB['StatementLabel'] := Tempstr;
                Accsdatamodule.LedgerReportDB['LineType'] := 'hx';
                Accsdatamodule.LedgerReportDB.post;
                PageLineCount := PageLineCount + 1;
           end
                else begin

           // TGM AB 07/04/17 end
                Accsdatamodule.LedgerReportDB.Append;
                Accsdatamodule.LedgerReportDB['StatementLabel'] := AccsDataModule.Statement['Address1'];
                Accsdatamodule.LedgerReportDB['LineType'] := 'hx'; // TGM AB 02/09/16
                Accsdatamodule.LedgerReportDB.post;
                PageLineCount := PageLineCount + 1;
                Accsdatamodule.LedgerReportDB.Append;
                Accsdatamodule.LedgerReportDB['StatementLabel'] := AccsDataModule.Statement['Address2'];
                Accsdatamodule.LedgerReportDB['LineType'] := 'hx'; // TGM AB 02/09/16
                Accsdatamodule.LedgerReportDB.post;
                PageLineCount := PageLineCount + 1;
                Accsdatamodule.LedgerReportDB.Append;
                Accsdatamodule.LedgerReportDB['StatementLabel'] := AccsDataModule.Statement['Address3'];
                Accsdatamodule.LedgerReportDB['LineType'] := 'hx'; // TGM AB 02/09/16
                Accsdatamodule.LedgerReportDB.post;
                PageLineCount := PageLineCount + 1;
                Accsdatamodule.LedgerReportDB.Append;
                Accsdatamodule.LedgerReportDB['StatementLabel'] := AccsDataModule.Statement['Address4'];
                Accsdatamodule.LedgerReportDB['LineType'] := 'hx'; // TGM AB 02/09/16
                Accsdatamodule.LedgerReportDB.post;
                PageLineCount := PageLineCount + 1;

               end;   // TGM AB 07/04/17

                Accsdatamodule.LedgerReportDB.Append;
                Accsdatamodule.LedgerReportDB['StatementLabel'] := AccsDataModule.Statement['Telephone'];
                Accsdatamodule.LedgerReportDB['LineType'] := 'hx'; // TGM AB 02/09/16
                Accsdatamodule.LedgerReportDB.post;
                PageLineCount := PageLineCount + 1;


        end
           else begin
               Accsdatamodule.LedgerReportDB.last;
               Accsdatamodule.LedgerReportDB.Edit;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;

               if not StatementReportUseGraphic then begin                 // TGM AB 07/04/17
                        Accsdatamodule.LedgerReportDB.Append;              // TGM AB 07/04/17
                        Accsdatamodule.LedgerReportDB.post;                // TGM AB 07/04/17
                        PageLineCount := PageLineCount + 1;                // TGM AB 07/04/17
                        Accsdatamodule.LedgerReportDB.Append;              // TGM AB 07/04/17
                        Accsdatamodule.LedgerReportDB.post;                // TGM AB 07/04/17
                        PageLineCount := PageLineCount + 1;                // TGM AB 07/04/17
               end;                                                        // TGM AB 07/04/17
           end;

           if not StatementReportUseGraphic then begin       // TGM AB 17/03/17              (claim back 1 line lost with graphic header)
                Accsdatamodule.LedgerReportDB.Append;        // TGM AB 17/03/17
                Accsdatamodule.LedgerReportDB.post;          // TGM AB 17/03/17
                PageLineCount := PageLineCount + 1;          // TGM AB 17/03/17
           end;

           Accsdatamodule.LedgerReportDB.Append;
           Accsdatamodule.LedgerReportDB['CustomerAddressLabel'] := AccountName;
    //       Accsdatamodule.LedgerReportDB['StatementLabel'] := 'Statement Of Account ' + statementform.RepDate.Text;
           Accsdatamodule.LedgerReportDB['AccNo'] := ReportAccountNo; // TGM AB 02/09/16
           Accsdatamodule.LedgerReportDB['LineType'] := 'h1';  // TGM AB 02/09/16
           Accsdatamodule.LedgerReportDB.post;
           PageLineCount := PageLineCount + 1;
           Accsdatamodule.LedgerReportDB.Append;
           Accsdatamodule.LedgerReportDB['CustomerAddressLabel'] := Address1;
           Accsdatamodule.LedgerReportDB['LineType'] := 'hx'; // TGM AB 02/09/16
           Accsdatamodule.LedgerReportDB.post;
           PageLineCount := PageLineCount + 1;
           Accsdatamodule.LedgerReportDB.Append;
           Accsdatamodule.LedgerReportDB['CustomerAddressLabel'] := Address2;
           Accsdatamodule.LedgerReportDB['LineType'] := 'hx'; // TGM AB 02/09/16
           Accsdatamodule.LedgerReportDB.post;
           PageLineCount := PageLineCount + 1;
           Accsdatamodule.LedgerReportDB.Append;
           Accsdatamodule.LedgerReportDB['CustomerAddressLabel'] := Address3;
           Accsdatamodule.LedgerReportDB['LineType'] := 'hx'; // TGM AB 02/09/16
           Accsdatamodule.LedgerReportDB.post;
           PageLineCount := PageLineCount + 1;
           Accsdatamodule.LedgerReportDB.Append;
           Accsdatamodule.LedgerReportDB['CustomerAddressLabel'] := Address4;
           Accsdatamodule.LedgerReportDB['LineType'] := 'hx'; // TGM AB 02/09/16
           Accsdatamodule.LedgerReportDB.post;
           PageLineCount := PageLineCount + 1;
           Accsdatamodule.LedgerReportDB.Append;
           Accsdatamodule.LedgerReportDB['CustomerAddressLabel'] := PostCode;
           Accsdatamodule.LedgerReportDB['LineType'] := 'hx'; // TGM AB 02/09/16
           Accsdatamodule.LedgerReportDB.post;
           PageLineCount := PageLineCount + 1;
           Accsdatamodule.LedgerReportDB.Append;
           Accsdatamodule.LedgerReportDB['StatementLabel'] := 'Statement Of Account ' + statementform.RepDate.Text;
           Accsdatamodule.LedgerReportDB['LineType'] := 'hx'; // TGM AB 02/09/16
           Accsdatamodule.LedgerReportDB.post;
           PageLineCount := PageLineCount + 1;
        end;

        if not header then begin
            Accsdatamodule.LedgerReportDB.Append;
           Accsdatamodule.LedgerReportDB.post;
           PageLineCount := PageLineCount + 1;

           if AccsDataModule.Statement['StatementFrom'] = False then begin

               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;

           end;


        end;

        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB['LineLabel'] := ' _______________________________________________________________________________________';
        Accsdatamodule.LedgerReportDB['LineType'] := 'hc'; // TGM AB 02/09/16
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;
        Accsdatamodule.LedgerReportDB.Append;

        // TGM AB 08/04/16
        if ShowExtendedStatement then begin
                if ShowInEuro then Accsdatamodule.LedgerReportDB['LineLabel'] := 'Date         Tx No     Type     Reference              Comment                               Debit (€)       Credit (€)   Balance (€)'
                        else Accsdatamodule.LedgerReportDB['LineLabel'] := 'Date         Tx No     Type    Reference              Comment                                     Debit            Credit          Balance';
        end else begin
                  if ShowInEuro then Accsdatamodule.LedgerReportDB['LineLabel'] := 'Date         Tx No     Type     Reference              Description                           Debit (€)       Credit (€)   Balance (€)'
                        else Accsdatamodule.LedgerReportDB['LineLabel'] := 'Date         Tx No     Type    Reference              Description                                 Debit            Credit          Balance';
             end;
        Accsdatamodule.LedgerReportDB['LineType'] := 'hc'; // TGM AB 02/09/16
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;

        // TGM AB 04/03/16
        if ShowExtendedStatement then begin
           Accsdatamodule.LedgerReportDB.Append;
           if ShowInvoiceDetails then Accsdatamodule.LedgerReportDB['BlueLineLabel'] := 'Line Date    Invoice Details             ' + ExtendedAltName1 + '/' + ExtendedAltName2                                                                                                                                  // TGM AB 21/10/16
                else Accsdatamodule.LedgerReportDB['BlueLineLabel'] := 'Line Date    Description                 ' + ExtendedAltName1 + '/' + ExtendedAltName2;         // TGM AB 21/10/16

           if ExtendedShowPerUnit then Tempstr := 'Unit Price'
               else Tempstr := '          ';

           Case ExtendedStatementConditions of

                   0,2,3 : Begin
                        Tempstr := Tempstr + '      Price Ex VAT            VAT';
                   end;


           end;

           Accsdatamodule.LedgerReportDB['BlueLineLabel2'] := '';
           Accsdatamodule.LedgerReportDB['BlueLineLabel2'] := Tempstr;
           Accsdatamodule.LedgerReportDB['LineType'] := 'hc'; // TGM AB 02/09/16
           Accsdatamodule.LedgerReportDB.post;
           PageLineCount := PageLineCount + 1;
           
        end;
        // end TGM AB 04/03/16

        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB['LineLabel'] := ' _______________________________________________________________________________________';
        Accsdatamodule.LedgerReportDB['LineType'] := 'hc'; // TGM AB 02/09/16
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;

        if header then begin
                AccountStartLine := 0;
                Accsdatamodule.LedgerReportDB.Append;
                if ShowInEuro then Accsdatamodule.LedgerReportDB['Balance'] := Balance / cash11.xEuroConverter  // TGM AB 16/01/15
                   else Accsdatamodule.LedgerReportDB['Balance'] := Balance; // TGM AB 16/01/15
                Accsdatamodule.LedgerReportDB['LineType'] := 'hb'; // TGM AB 02/09/16
                Accsdatamodule.LedgerReportDB.post;
                PageLineCount := PageLineCount + 1;
                AccountStartLine := Accsdatamodule.LedgerReportDB['ID'];
        end;


        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;

end;

procedure TLedgerReport.FilterStatementTransactions;
var
   DateFrom, DateTo, testdate : TDateTime;
   i, j : Integer;
   runningbalance, openingbalance : real;
   FirstTx : boolean;
   ZeroTxBalance : real;       //Ch029
   PrintRecCount : integer;    //Ch029
begin
   // print qualifying transactions
   datefilter := false;
   DateFrom := strtodate('01/01/90');
   DateTo := Now + 366;                     // TGM AB 01/09/17   - allows for accidential invoices dated in the future
   FirstTx := True;
   runningbalance := 0;
   openingbalance := 0;
   printbalance := 0;
   ZeroTxbalance :=0;     //Ch029
   PrintRecCount := 0;    //Ch029

   if ( (stat.StatementForm.DateFrom.Text <> '  /  /  ') or (stat.StatementForm.DateTo.Text <> '  /  /  ') ) then
   begin
      datefilter := true;
      if ( stat.StatementForm.DateFrom.Text <> '  /  /  ' ) then
         DateFrom := strtodate(stat.StatementForm.DateFrom.Text);
      if ( stat.StatementForm.DateTo.Text <> '  /  /  ' ) then
         DateTo := strtodate(stat.StatementForm.DateTo.Text);
   end;

   Accsdatamodule.CustSuppTempTableDB.First;
   if ShowInEuro then
      Runningbalance := Balance / cash11.xEuroConverter   // TGM AB 16/01/15 - sets balance for filtered report with no transactions
   else
      Runningbalance := Balance;  // TGM AB 16/01/15

   for i:= 1 to Accsdatamodule.CustSuppTempTableDB.RecordCount do
      begin
         // date range check
         testdate := Accsdatamodule.CustSuppTempTableDB['TxDate'];
         if ( (testdate >= DateFrom) and (testdate <= DateTo) ) then
            begin
               if FirstTx then
                  begin
                     Accsdatamodule.LedgerReportDB.prior;
                     Accsdatamodule.LedgerReportDB.edit;
                     if ( Prog in [CustLED,CustSTM] ) then
                        begin
                           openingbalance := Accsdatamodule.CustSuppTempTableDB['Balance'];
                           try
                              openingbalance := openingbalance + Accsdatamodule.CustSuppTempTableDB['Credit'];
                           except
                           end;

                           try
                              openingbalance := openingbalance - Accsdatamodule.CustSuppTempTableDB['Debit'];
                           except
                           end;
                        end
                     else
                        begin
                           openingbalance := Accsdatamodule.CustSuppTempTableDB['Balance'];
                           try
                              openingbalance := openingbalance - Accsdatamodule.CustSuppTempTableDB['Credit'];
                           except
                           end;
                           try
                              openingbalance := openingbalance + Accsdatamodule.CustSuppTempTableDB['Debit'];
                           except
                           end;
                        end;
                     Accsdatamodule.LedgerReportDB['Balance'] := openingbalance;
                     Accsdatamodule.LedgerReportDB.post;
                     Accsdatamodule.LedgerReportDB.next;
                     FirstTx := False;
                  end;
               Accsdatamodule.LedgerReportDB.Append;
               PrintRecCount := PrintRecCount + 1;    //Ch029
               Accsdatamodule.LedgerReportDB['LastYear'] := Accsdatamodule.CustSuppTempTableDB['LastYear'];
               Accsdatamodule.LedgerReportDB['TxDate'] := Accsdatamodule.CustSuppTempTableDB['TxDate'];
               Accsdatamodule.LedgerReportDB['TxNo'] := Accsdatamodule.CustSuppTempTableDB['TxNo'];
               Accsdatamodule.LedgerReportDB['TxType'] := Accsdatamodule.CustSuppTempTableDB['TxType'];
               if Accsdatamodule.CustSuppTempTableDB['TxType'] = 'PAY' then
                  Accsdatamodule.LedgerReportDB['LineType'] := 'pa';     // TGM AB 02/09/16
               if Accsdatamodule.CustSuppTempTableDB['TxType'] = 'DIS' then
                  Accsdatamodule.LedgerReportDB['LineType'] := 'di';     // TGM AB 02/09/16
               if Accsdatamodule.CustSuppTempTableDB['TxType'] = 'INV' then
                  Accsdatamodule.LedgerReportDB['LineType'] := 'in';     // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB['TxReference'] := Accsdatamodule.CustSuppTempTableDB['TxReference'];
               Accsdatamodule.LedgerReportDB['TxDescription'] := Accsdatamodule.CustSuppTempTableDB['TxDescription'];
               Accsdatamodule.LedgerReportDB['Debit'] := Accsdatamodule.CustSuppTempTableDB['Debit'];
               Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.CustSuppTempTableDB['Credit'];
               if incbalance then
                  Accsdatamodule.LedgerReportDB['Balance'] := Accsdatamodule.CustSuppTempTableDB['Balance'];
               RunningBalance := Accsdatamodule.CustSuppTempTableDB['Balance'];
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               if ( pagelinecount = StatementPageLineLimit ) then                         // TGM AB 07/04/17 was 48 now StatementPageLineLimit
                  begin
                     pagelinecount := 0;              // TGM AB 30/04/16
                     EnterStatementHeader(False);     // TGM AB 30/04/16
                  end;

               if ShowExtendedStatement then
                  begin
                     if ( (Accsdatamodule.LedgerReportDB['TxType'] <> 'PAY') and (Accsdatamodule.LedgerReportDB['TxType'] <> 'DIS') ) then
                        begin
                           if ( Accsdatamodule.LedgerReportDB['LastYear'] = '*' ) then
                              EnterExtendedTxDetailsLastYear(Accsdatamodule.CustSuppTempTableDB['TxNo'])    // TGM AB 09/09/16
                           else
                              EnterExtendedTxDetails(Accsdatamodule.CustSuppTempTableDB['TxNo']);           // TGM AB 09/09/16
                        end;
                  end;

               if ( pagelinecount > StatementPageLineLimit ) then         // TGM AB 07/04/17 was 48 now StatementPageLineLimit
                  pagelinecount := pagelinecount - StatementPageLineLimit;       // TGM AB 30/04/16      // TGM AB 07/04/17 was 48 now StatementPageLineLimit

               if ( pagelinecount = StatementPageLineLimit ) then        // TGM AB 07/04/17 was 48 now StatementPageLineLimit
                  begin
                     pagelinecount := 0;
                     EnterStatementHeader(False);
                  end;
            end;

            // Start Ch029

            if (testdate < DateFrom) then begin

                // This sets the report starting balance according to last TX before filter period

                if datefilter then begin
                        ZeroTxBalance := Accsdatamodule.CustSuppTempTableDB['Balance'];
                end;

            end;

            // Start Ch029

         AccsDataModule.CustSuppTempTableDB.Next;
      end;

   // Start Ch029

   if PrintRecCount = 0 then begin     // no transactions

                runningbalance := ZeroTxBalance;
                openingbalance := ZeroTxBalance;
                Accsdatamodule.LedgerReportDB.prior;
                Accsdatamodule.LedgerReportDB.edit;
                Accsdatamodule.LedgerReportDB['Balance'] := openingbalance;
                Accsdatamodule.LedgerReportDB.post;
                Accsdatamodule.LedgerReportDB.next;

   end;
   // Start Ch029

   if datefilter then begin

          if pagelinecount >= StatementPageLineLimit - 2 then begin                       // TGM AB 07/04/17 was 46 now StatementPageLineLimit - 2
              for j:=pagelinecount to (StatementPageLineLimit - 1) do begin                 // TGM AB 07/04/17 was 47 now StatementPageLineLimit - 1
                  Accsdatamodule.LedgerReportDB.Append;
                  Accsdatamodule.LedgerReportDB.post;
                  PageLineCount := PageLineCount + 1;
              end;
              pagelinecount := 0;
              EnterStatementHeader(False);
          end;

          Accsdatamodule.LedgerReportDB.Append;
          Accsdatamodule.LedgerReportDB.post;
          PageLineCount := PageLineCount + 1;

          // enter extended statement totals


          Accsdatamodule.LedgerReportDB.Append;
  //        if ShowInEuro then Accsdatamodule.LedgerReportDB['Balance'] := runningbalance / cash11.xEuroConverter
  //           else



          Accsdatamodule.LedgerReportDB['Balance'] := runningbalance;

          if stat.StatementForm.DateTo.Text <> '  /  /  ' then Accsdatamodule.LedgerReportDB['LineLabel'] := 'Outstanding Balance on ' + vartostr(DateTo)
                  else Accsdatamodule.LedgerReportDB['LineLabel'] := 'Outstanding Balance on ' + copy(vartostr(Stat.StatementForm.RepDate.Text),1,8);

          Accsdatamodule.LedgerReportDB['LineType'] := 'cb'; // TGM AB 02/09/16
          Accsdatamodule.LedgerReportDB.post;
          PageLineCount := PageLineCount + 1;

          PrintBalance := runningbalance;

   end else begin

                    if pagelinecount >= (StatementPageLineLimit - 2) then begin                                      // TGM AB 07/04/17 was 46 now StatementPageLineLimit - 2
                        for j:=pagelinecount to (StatementPageLineLimit - 1) do begin                              // TGM AB 07/04/17 was 47 now StatementPageLineLimit - 1
                            Accsdatamodule.LedgerReportDB.Append;
                            Accsdatamodule.LedgerReportDB.post;
                            PageLineCount := PageLineCount + 1;
                        end;
                        pagelinecount := 0;
                        EnterStatementHeader(False);
                    end;


                    Accsdatamodule.LedgerReportDB.Append;
                    Accsdatamodule.LedgerReportDB.post;
                    PageLineCount := PageLineCount + 1;

                    // enter extended statement totals

                    if ShowExtendedStatement then begin   // TGM AB 25/03/16
                              Accsdatamodule.LedgerReportDB.Append;
                              Accsdatamodule.LedgerReportDB['BlueLineLabel'] := '     Totals - ';
                              Accsdatamodule.LedgerReportDB['LinePrice'] := ReportLinePriceTotal;           // TGM AB 21/10/16
                              Accsdatamodule.LedgerReportDB['LineVAT'] := ReportLineVATTotal;               // TGM AB 21/10/16
                              if ReportLineCreditTotal <> 0 then Accsdatamodule.LedgerReportDB['LineCredit'] := ReportLineCreditTotal;
                              if ReportLineDebitTotal <> 0 then Accsdatamodule.LedgerReportDB['LineDebit'] := ReportLineDebitTotal;
                              Accsdatamodule.LedgerReportDB.post;
                              PageLineCount := PageLineCount + 1;
                    end;                                  // TGM AB 25/03/16


                    Accsdatamodule.LedgerReportDB.Append;
                    if ShowInEuro then Accsdatamodule.LedgerReportDB['Balance'] := Balance / cash11.xEuroConverter
                       else  Accsdatamodule.LedgerReportDB['Balance'] := Balance;
                    Accsdatamodule.LedgerReportDB['LineLabel'] := 'Outstanding Balance';
                    Accsdatamodule.LedgerReportDB['LineType'] := 'cb'; // TGM AB 02/09/16
                    Accsdatamodule.LedgerReportDB.post;
                    PageLineCount := PageLineCount + 1;
                    PrintBalance := balance;
       end;

   if pagelinecount > (StatementPageLineLimit - 12) then begin                                                         // TGM AB 07/04/17 was 36 now StatementPageLineLimit -12
                        for j:=pagelinecount to (StatementPageLineLimit - 1) do begin                              // TGM AB 07/04/17 was 47 now StatementPageLineLimit - 1
                            Accsdatamodule.LedgerReportDB.Append;
                            Accsdatamodule.LedgerReportDB.post;
                            PageLineCount := PageLineCount + 1;
                        end;
                        pagelinecount := 0;
                        EnterStatementHeader(False);
                        Accsdatamodule.LedgerReportDB.Append;
                        Accsdatamodule.LedgerReportDB.post;
                        PageLineCount := PageLineCount + 1;
                        EnterStatementFooter;
                    end
                        else EnterStatementFooter;

   while pagelinecount < StatementPageLineLimit do begin                         // TGM AB 07/04/17 was 48 now StatementPageLineLimit
         Accsdatamodule.LedgerReportDB.Append;
         Accsdatamodule.LedgerReportDB.post;
         PageLineCount := PageLineCount + 1;
   end;



end;

procedure TLedgerReport.EnterStatementFooter;   // last page only only
var                             //Ch032
        j, crlf : integer;      //Ch032
        tempstring : string;    //Ch032
        Comment : string;       //Ch032

begin

        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB['LineLabel'] := ' _______________________________________________________________________________________';
        Accsdatamodule.LedgerReportDB['LineType'] := 'fx'; // TGM AB 02/09/16
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;
        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;
        Accsdatamodule.LedgerReportDB.Append;
        if Prog = CustSTM then Accsdatamodule.LedgerReportDB['LineLabel'] := 'Please return this section with your payment';
        Accsdatamodule.LedgerReportDB['LineType'] := 'fx'; // TGM AB 02/09/16
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;
        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;
        Accsdatamodule.LedgerReportDB.Append;
        if datefilter then begin
                                 if stat.StatementForm.DateTo.Text <> '  /  /  ' then Accsdatamodule.LedgerReportDB['TxDescription'] := 'Outstanding Balance on ' + vartostr(Stat.StatementForm.DateTo.Text) + ' :'
                                    else Accsdatamodule.LedgerReportDB['TxDescription'] := 'Outstanding Balance on ' + copy(vartostr(Stat.StatementForm.RepDate.Text),1,8) + ' :'
           end
              else Accsdatamodule.LedgerReportDB['TxDescription'] := 'Balance Outstanding :';
        if datefilter then Accsdatamodule.LedgerReportDB['Credit'] := PrintBalance
           else Accsdatamodule.LedgerReportDB['Credit'] := balance;
        if ShowInEuro and not datefilter then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
        Accsdatamodule.LedgerReportDB['LineType'] := 'fx'; // TGM AB 02/09/16
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;
        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;


        case statementform.AgeBycombo.ItemIndex of
            0: begin
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := 'Current :';
               Accsdatamodule.LedgerReportDB['Credit'] := AgeCurr;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'cu'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '30+ days :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age1;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c1'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '60+ days :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age2;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c2'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '90+ days :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age3;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c3'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
            end;
            1: begin
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '0-1 Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := AgeCurr;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'cu'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '2-3 Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age1;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c1'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '4-5 Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age2;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c2'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '6+  Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age3;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c3'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
            end;
            2: begin
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '0-2 Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := AgeCurr;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'cu'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '3-5 Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age1;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c1'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '6-8 Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age2;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c2'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '9+  Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age3;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c3'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
            end;
            3: begin
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '0-5   Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := AgeCurr;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'cu'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '6-11  Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age1;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c1'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '12-17 Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age2;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c2'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '18+   Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age3;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c3'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
            end;
            4: begin
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '0-8   Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := AgeCurr;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'cu'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '9-17  Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age1;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c1'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '18-26 Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age2;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c2'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '27+   Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age3;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c3'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
            end;
            5: begin
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '0-11  Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := AgeCurr;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'cu'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '12-23 Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age1;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c1'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '24-35 Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age2;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c2'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
               Accsdatamodule.LedgerReportDB.Append;
               Accsdatamodule.LedgerReportDB['TxDescription'] := '36+   Months :';
               Accsdatamodule.LedgerReportDB['Credit'] := Age3;
               if ShowInEuro then Accsdatamodule.LedgerReportDB['Credit'] := Accsdatamodule.LedgerReportDB['Credit'] / cash11.xEuroConverter;
               Accsdatamodule.LedgerReportDB['LineType'] := 'c3'; // TGM AB 02/09/16
               Accsdatamodule.LedgerReportDB.post;
               PageLineCount := PageLineCount + 1;
            end;



        end;

        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;
        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB['LineLabel'] := 'Account Number : ' + IntToStr(ReportAccountNo);
        Accsdatamodule.LedgerReportDB['TxDescription'] := 'Account Name : ' + AccountName;
        Accsdatamodule.LedgerReportDB['LineType'] := 'fx'; // TGM AB 02/09/16
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;

        //Ch032 starts here

        CRLF := 1;

        if IncStatementComment then begin

             if length(StatementComment) > 0 then begin

                // add blank line

                Accsdatamodule.LedgerReportDB.Append;
                Accsdatamodule.LedgerReportDB.post;
                PageLineCount := PageLineCount + 1;

                Comment := StatementComment;

                TempString := Comment;

                while length(Comment) > 0 do begin

                        for j:= 0 to length(Comment) do begin

                                if Comment[j] = #$D then begin

                                        TempString := copy(Comment,CRLF,j-CRLF);


                                        Accsdatamodule.LedgerReportDB.Append;
                                        Accsdatamodule.LedgerReportDB['CommentLabel'] := Tempstring;
                                        Accsdatamodule.LedgerReportDB['LineType'] := 'fx';
                                        Accsdatamodule.LedgerReportDB.post;
                                        PageLineCount := PageLineCount + 1;

                                        CRLF := j + 2;

                                        TempString := copy(Comment,CRLF,length(Comment));

                                    //    If tempstring = '' then Comment := '';

                                end;    // if

                        end;  // for

                        If TempString <> '' then begin
                                        Accsdatamodule.LedgerReportDB.Append;
                                        Accsdatamodule.LedgerReportDB['CommentLabel'] := Tempstring;
                                        Accsdatamodule.LedgerReportDB['LineType'] := 'fx';
                                        Accsdatamodule.LedgerReportDB.post;
                                        PageLineCount := PageLineCount + 1;
                                        TempString := '';
                                    //    Comment := '';
                        end;

                        If tempstring = '' then break;

                end;  // while



            end;  // if


        end;

        if pagelinecount > StatementPageLineLimit then  pagelinecount := pagelinecount - StatementPageLineLimit;

        //Ch032 ends here


end;

function TLedgerReport.CheckAreaCode : boolean;
var
   AreaFrom, AreaTo : integer;
begin
   result := false;
   AreaFrom := StrtoInt(Stat.StatementForm.AreaCodeFrom.text);
   AreaTo := StrtoInt(Stat.StatementForm.AreaCodeTo.text);

   if ((AreaCode>=AreaFrom) and (AreaCode <=AreaTo)) then result := true;


end;

procedure TLedgerReport.EnterExtendedTxDetails(TxNo : Integer);   // New 11/03/16
var
        TxType, OrigType : Integer;
        SameTx : Boolean;
        UnitPrice : Real;
        IncludeTotals : Boolean;    // Totals line is valid to print
begin
    // Displays extra details for extended statement report

    TxLinePriceTotal := 0;
    TxLineVATTotal := 0;
    TxLineCreditTotal := 0;
    TxLineDebitTotal := 0;
    IncludeTotals := False;



    Accsdatamodule.TransactionsDB.Locate('TxNo', TxNo,[]);
    OrigType := Accsdatamodule.TransactionsDB['TxType'];

    case OrigType of

    9 : begin
        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB['LineType'] := 'id';  // TGM AB 02/09/16
        Accsdatamodule.LedgerReportDB['LineDate'] := Accsdatamodule.TransactionsDB['TxDate'];
        
        // TGM AB 21/10/16

        if ShowInvoiceDetails then begin

                GatherInvoiceInfo(Accsdatamodule.TransactionsDB['TxNo']);
                if ( Length(InvoiceDate) > 0 ) then
                   Accsdatamodule.LedgerReportDB['LineDate'] := InvoiceDate;
                Accsdatamodule.LedgerReportDB['LineDescription'] := InvoiceLine1;

        end
                else Accsdatamodule.LedgerReportDB['LineDescription'] := Accsdatamodule.TransactionsDB['Descript'];

        // TGM AB 21/10/16


        Accsdatamodule.LedgerReportDB['LineQty'] := Accsdatamodule.TransactionsDB['Quantity'];
        if Accsdatamodule.TransactionsDB['Quantity'] <> 0 then begin
                try UnitPrice :=  Accsdatamodule.TransactionsDB['Amount'] / Accsdatamodule.TransactionsDB['Quantity'];
                    Accsdatamodule.LedgerReportDB['LineUnitPrice'] := UnitPrice;
                except
                end;
        end;
        if ShowInEuro then begin                                                                                                                                                                                                    // TGM AB 21/10/16
                Accsdatamodule.LedgerReportDB['LineUnitPrice'] := Accsdatamodule.LedgerReportDB['LineUnitPrice'] / cash11.xEuroConverter;                                                                                           // TGM AB 21/10/16
                Accsdatamodule.LedgerReportDB['LinePrice'] := Accsdatamodule.TransactionsDB['Amount'] / cash11.xEuroConverter;                                                                                                      // TGM AB 21/10/16
                Accsdatamodule.LedgerReportDB['LineVAT'] := Accsdatamodule.TransactionsDB['TaxDisc'] / cash11.xEuroConverter;                                                                                                       // TGM AB 21/10/16
                if prog = CustSTM then Accsdatamodule.LedgerReportDB['LineDebit'] := (Accsdatamodule.TransactionsDB['Amount']/ cash11.xEuroConverter) + (Accsdatamodule.TransactionsDB['TaxDisc']/ cash11.xEuroConverter);          // TGM AB 21/10/16
                if prog = SuppSTM  then Accsdatamodule.LedgerReportDB['LineCredit'] := (Accsdatamodule.TransactionsDB['Amount']/ cash11.xEuroConverter) + (Accsdatamodule.TransactionsDB['TaxDisc']/ cash11.xEuroConverter);        // TGM AB 21/10/16
        end else begin                                                                                                                                                                                                              // TGM AB 21/10/16
                Accsdatamodule.LedgerReportDB['LinePrice'] := Accsdatamodule.TransactionsDB['Amount'];                                                                                                                              // TGM AB 21/10/16
                Accsdatamodule.LedgerReportDB['LineVAT'] := Accsdatamodule.TransactionsDB['TaxDisc'];                                                                                                                               // TGM AB 21/10/16
                if prog = CustSTM then Accsdatamodule.LedgerReportDB['LineDebit'] := Accsdatamodule.TransactionsDB['Amount'] + Accsdatamodule.TransactionsDB['TaxDisc'];                                                            // TGM AB 21/10/16
                if prog = SuppSTM  then Accsdatamodule.LedgerReportDB['LineCredit'] := Accsdatamodule.TransactionsDB['Amount'] + Accsdatamodule.TransactionsDB['TaxDisc'];                                                          // TGM AB 21/10/16
            end;                                                                                                                                                                                                                    // TGM AB 21/10/16
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;

        // TGM AB 21/10/16

        try TxLinePriceTotal := TxLinePriceTotal + Accsdatamodule.LedgerReportDB['LinePrice'];
        except
        end;
        try TxLineVATTotal := TxLineVATTotal + Accsdatamodule.LedgerReportDB['LineVAT'];           // TGM AB 09/09/16
        except
        end;
        try TxLineCreditTotal := TxLineCreditTotal + Accsdatamodule.LedgerReportDB['LineCredit'];
        except
        end;
        try TxLineDebitTotal := TxLineDebitTotal + Accsdatamodule.LedgerReportDB['LineDebit'];
        except
        end;

        if ShowInvoiceDetails then begin
                if InvoiceLine2 <> '' then begin
                        Accsdatamodule.LedgerReportDB.append;
                        Accsdatamodule.LedgerReportDB['LineDescription'] := InvoiceLine2;
                        Accsdatamodule.LedgerReportDB.post;
                        PageLineCount := PageLineCount + 1;
                end;

                if InvoiceLine3 <> '' then begin
                        Accsdatamodule.LedgerReportDB.append;
                        Accsdatamodule.LedgerReportDB['LineDescription'] := InvoiceLine3;
                        Accsdatamodule.LedgerReportDB.post;
                        PageLineCount := PageLineCount + 1;
                end;
        end;

        // TGM AB 21/10/16

        if pagelinecount = 48 then begin                    // TGM AB 30/05/16
                        pagelinecount := 0;                 // TGM AB 30/05/16
                        EnterStatementHeader(False);        // TGM AB 30/05/16
        end;                                                // TGM AB 30/05/16



        IncludeTotals := True;

        end;

    1,3,5,7,11,15 : begin
                SameTx := True;

                while SameTx do begin
                Accsdatamodule.TransactionsDB.next;
                TxType := Accsdatamodule.TransactionsDB['TxType'];

                   if Accsdatamodule.TransactionsDB['OrigType'] = OrigType then begin

                        if Accsdatamodule.TransactionsDB['TxType'] = 9 then begin

                                Accsdatamodule.LedgerReportDB.Append;
                                Accsdatamodule.LedgerReportDB['LineType'] := 'id';  // TGM AB 02/09/16
                                Accsdatamodule.LedgerReportDB['LineDate'] := Accsdatamodule.TransactionsDB['TxDate'];

                                // TGM AB 21/10/16

                                if ShowInvoiceDetails then begin

                                     GatherInvoiceInfo(Accsdatamodule.TransactionsDB['TxNo']);
                                     if ( Length(InvoiceDate) > 0 ) then
                                        Accsdatamodule.LedgerReportDB['LineDate'] := InvoiceDate;
                                     Accsdatamodule.LedgerReportDB['LineDescription'] := InvoiceLine1;

                                end
                                        else Accsdatamodule.LedgerReportDB['LineDescription'] := Accsdatamodule.TransactionsDB['Descript'];

                                // TGM AB 21/10/16

                                Accsdatamodule.LedgerReportDB['LineQty'] := Accsdatamodule.TransactionsDB['Quantity'];
                                if Accsdatamodule.TransactionsDB['Quantity'] <> 0 then begin
                                        try UnitPrice :=  Accsdatamodule.TransactionsDB['Amount'] / Accsdatamodule.TransactionsDB['Quantity'];
                                            Accsdatamodule.LedgerReportDB['LineUnitPrice'] := UnitPrice;
                                        except
                                        end;
                                end;
                                if ShowInEuro then begin                                                                                                                                                                                                    // TGM AB 21/10/16
                                        Accsdatamodule.LedgerReportDB['LineUnitPrice'] := Accsdatamodule.LedgerReportDB['LineUnitPrice'] / cash11.xEuroConverter;                                                                                           // TGM AB 21/10/16
                                        Accsdatamodule.LedgerReportDB['LinePrice'] := Accsdatamodule.TransactionsDB['Amount'] / cash11.xEuroConverter;                                                                                                      // TGM AB 21/10/16
                                        Accsdatamodule.LedgerReportDB['LineVAT'] := Accsdatamodule.TransactionsDB['TaxDisc'] / cash11.xEuroConverter;                                                                                                       // TGM AB 21/10/16
                                        if prog = CustSTM then Accsdatamodule.LedgerReportDB['LineDebit'] := (Accsdatamodule.TransactionsDB['Amount']/ cash11.xEuroConverter) + (Accsdatamodule.TransactionsDB['TaxDisc']/ cash11.xEuroConverter);          // TGM AB 21/10/16
                                        if prog = SuppSTM  then Accsdatamodule.LedgerReportDB['LineCredit'] := (Accsdatamodule.TransactionsDB['Amount']/ cash11.xEuroConverter) + (Accsdatamodule.TransactionsDB['TaxDisc']/ cash11.xEuroConverter);        // TGM AB 21/10/16
                                end else begin                                                                                                                                                                                                              // TGM AB 21/10/16
                                                Accsdatamodule.LedgerReportDB['LinePrice'] := Accsdatamodule.TransactionsDB['Amount'];                                                                                                                      // TGM AB 21/10/16
                                                Accsdatamodule.LedgerReportDB['LineVAT'] := Accsdatamodule.TransactionsDB['TaxDisc'];                                                                                                                       // TGM AB 21/10/16
                                                if prog = CustSTM then Accsdatamodule.LedgerReportDB['LineDebit'] := Accsdatamodule.TransactionsDB['Amount'] + Accsdatamodule.TransactionsDB['TaxDisc'];                                                    // TGM AB 21/10/16
                                                if prog = SuppSTM  then Accsdatamodule.LedgerReportDB['LineCredit'] := Accsdatamodule.TransactionsDB['Amount'] + Accsdatamodule.TransactionsDB['TaxDisc'];                                                  // TGM AB 21/10/16
                                end;                                                                                                                                                                                                                        // TGM AB 21/10/16
                                Accsdatamodule.LedgerReportDB.post;
                                PageLineCount := PageLineCount + 1;

                                // TGM AB 21/10/16

                                try TxLinePriceTotal := TxLinePriceTotal + Accsdatamodule.LedgerReportDB['LinePrice'];
                                except
                                end;
                                try TxLineVATTotal := TxLineVATTotal + Accsdatamodule.LedgerReportDB['LineVAT'];
                                except
                                end;
                                try TxLineCreditTotal := TxLineCreditTotal + Accsdatamodule.LedgerReportDB['LineCredit'];
                                except
                                end;
                                try TxLineDebitTotal := TxLineDebitTotal + Accsdatamodule.LedgerReportDB['LineDebit'];
                                except
                                end;

                                if ShowInvoiceDetails then begin
                                     if InvoiceLine2 <> '' then begin
                                         Accsdatamodule.LedgerReportDB.append;
                                         Accsdatamodule.LedgerReportDB['LineDescription'] := InvoiceLine2;
                                         Accsdatamodule.LedgerReportDB.post;
                                         PageLineCount := PageLineCount + 1;
                                     end;

                                     if InvoiceLine3 <> '' then begin
                                         Accsdatamodule.LedgerReportDB.append;
                                         Accsdatamodule.LedgerReportDB['LineDescription'] := InvoiceLine3;
                                         Accsdatamodule.LedgerReportDB.post;
                                         PageLineCount := PageLineCount + 1;
                                     end;
                                end;

                                // TGM AB 21/10/16

                                if pagelinecount = 48 then begin                    // TGM AB 30/05/16
                                                pagelinecount := 0;                 // TGM AB 30/05/16
                                                EnterStatementHeader(False);        // TGM AB 30/05/16
                                end;                                                // TGM AB 30/05/16



                                IncludeTotals := True;
                        end;

                        if not (TxType in [0,9]) then SameTx := False;

                    end else SameTx := False;
                   if Accsdatamodule.TransactionsDB['TxNo'] = Accsdatamodule.TransactionsDB.recordcount then SameTx := False;
                end // while

        end;

    end;


    ReportLinePriceTotal := ReportLinePriceTotal + TxLinePriceTotal;         // TGM AB 08/04/16
    ReportLineVATTotal := ReportLineVATTotal + TxLineVATTotal;               // TGM AB 08/04/16
    ReportLineCreditTotal := ReportLineCreditTotal + TxLineCreditTotal;      // TGM AB 08/04/16
    ReportLineDebitTotal :=  ReportLineDebitTotal + TxLineDebitTotal;        // TGM AB 08/04/16

    if ExtendedShowSubTotals and IncludeTotals then begin

        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB['LineType'] := 'it';  // TGM AB 02/09/16
        Accsdatamodule.LedgerReportDB['TotalLinePrice']  := TxLinePriceTotal;                // TGM AB 21/10/16
        Accsdatamodule.LedgerReportDB['TotalLineVAT']    := TxLineVATTotal;                  // TGM AB 21/10/16
        if TxLineCreditTotal <> 0 then Accsdatamodule.LedgerReportDB['TotalLineCredit'] := TxLineCreditTotal;
        if TxLineDebitTotal <> 0 then Accsdatamodule.LedgerReportDB['TotalLineDebit']  := TxLineDebitTotal;
        Accsdatamodule.LedgerReportDB['GreenLineLabel']  := 'Totals';
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;
    end;


end;

procedure TLedgerReport.EnterExtendedTxDetailsLastYear(TxNo : Integer);   // New 09/09/16
var
        TxType, OrigType : Integer;
        SameTx : Boolean;
        UnitPrice : Real;
        IncludeTotals : Boolean;    // Totals line is valid to print
begin
    // Displays extra details for extended statement report

    TxLinePriceTotal := 0;
    TxLineVATTotal := 0;
    TxLineCreditTotal := 0;
    TxLineDebitTotal := 0;
    IncludeTotals := False;



    Accsdatamodule.TransactionsYr1DB.Locate('TxNo', TxNo,[]);
    OrigType := Accsdatamodule.TransactionsYr1DB['TxType'];

    case OrigType of

    9 : begin
        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB['LineType'] := 'id';
        Accsdatamodule.LedgerReportDB['LineDate'] := Accsdatamodule.TransactionsYr1DB['TxDate'];

        // TGM AB 21/10/16

        if ShowInvoiceDetails then begin

                GatherInvoiceInfoLastYear(Accsdatamodule.TransactionsYr1DB['TxNo']);
                if ( Length(InvoiceDate) > 0 ) then
                   Accsdatamodule.LedgerReportDB['LineDate'] := InvoiceDate;
                Accsdatamodule.LedgerReportDB['LineDescription'] := InvoiceLine1;

        end
                else Accsdatamodule.LedgerReportDB['LineDescription'] := Accsdatamodule.TransactionsYr1DB['Descript'];

        // TGM AB 21/10/16

        Accsdatamodule.LedgerReportDB['LineQty'] := Accsdatamodule.TransactionsYr1DB['Quantity'];
        if Accsdatamodule.TransactionsYr1DB['Quantity'] <> 0 then begin
                try UnitPrice :=  Accsdatamodule.TransactionsYr1DB['Amount'] / Accsdatamodule.TransactionsYr1DB['Quantity'];
                    Accsdatamodule.LedgerReportDB['LineUnitPrice'] := UnitPrice;
                except
                end;
        end;
        if ShowInEuro then begin                                                                                                                                                                                                       // TGM AB 21/10/16
                Accsdatamodule.LedgerReportDB['LineUnitPrice'] := Accsdatamodule.LedgerReportDB['LineUnitPrice'] / cash11.xEuroConverter;                                                                                              // TGM AB 21/10/16
                Accsdatamodule.LedgerReportDB['LinePrice'] := Accsdatamodule.TransactionsYr1DB['Amount'] / cash11.xEuroConverter;                                                                                                      // TGM AB 21/10/16
                Accsdatamodule.LedgerReportDB['LineVAT'] := Accsdatamodule.TransactionsYr1DB['TaxDisc'] / cash11.xEuroConverter;                                                                                                       // TGM AB 21/10/16
                if prog = CustSTM then Accsdatamodule.LedgerReportDB['LineDebit'] := (Accsdatamodule.TransactionsYr1DB['Amount']/ cash11.xEuroConverter) + (Accsdatamodule.TransactionsYr1DB['TaxDisc']/ cash11.xEuroConverter);       // TGM AB 21/10/16
                if prog = SuppSTM  then Accsdatamodule.LedgerReportDB['LineCredit'] := (Accsdatamodule.TransactionsYr1DB['Amount']/ cash11.xEuroConverter) + (Accsdatamodule.TransactionsYr1DB['TaxDisc']/ cash11.xEuroConverter);     // TGM AB 21/10/16
        end else begin                                                                                                                                                                                                                 // TGM AB 21/10/16
                Accsdatamodule.LedgerReportDB['LinePrice'] := Accsdatamodule.TransactionsYr1DB['Amount'];                                                                                                                              // TGM AB 21/10/16
                Accsdatamodule.LedgerReportDB['LineVAT'] := Accsdatamodule.TransactionsYr1DB['TaxDisc'];                                                                                                                               // TGM AB 21/10/16
                if prog = CustSTM then Accsdatamodule.LedgerReportDB['LineDebit'] := Accsdatamodule.TransactionsYr1DB['Amount'] + Accsdatamodule.TransactionsYr1DB['TaxDisc'];                                                         // TGM AB 21/10/16
                if prog = SuppSTM  then Accsdatamodule.LedgerReportDB['LineCredit'] := Accsdatamodule.TransactionsYr1DB['Amount'] + Accsdatamodule.TransactionsYr1DB['TaxDisc'];                                                       // TGM AB 21/10/16
            end;                                                                                                                                                                                                                       // TGM AB 21/10/16
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;

        // TGM AB 21/10/16

        try TxLinePriceTotal := TxLinePriceTotal + Accsdatamodule.LedgerReportDB['LinePrice'];
        except
        end;
        try TxLineVATTotal := TxLineVATTotal + Accsdatamodule.LedgerReportDB['LineVAT'];           // TGM AB 09/09/16
        except
        end;
        try TxLineCreditTotal := TxLineCreditTotal + Accsdatamodule.LedgerReportDB['LineCredit'];
        except
        end;
        try TxLineDebitTotal := TxLineDebitTotal + Accsdatamodule.LedgerReportDB['LineDebit'];
        except
        end;

        if ShowInvoiceDetails then begin
                if InvoiceLine2 <> '' then begin
                        Accsdatamodule.LedgerReportDB.append;
                        Accsdatamodule.LedgerReportDB['LineDescription'] := InvoiceLine2;
                        Accsdatamodule.LedgerReportDB.post;
                        PageLineCount := PageLineCount + 1;
                end;

                if InvoiceLine3 <> '' then begin
                        Accsdatamodule.LedgerReportDB.append;
                        Accsdatamodule.LedgerReportDB['LineDescription'] := InvoiceLine3;
                        Accsdatamodule.LedgerReportDB.post;
                        PageLineCount := PageLineCount + 1;
                end;
        end;

        // TGM AB 21/10/16

        if pagelinecount = 48 then begin
                        pagelinecount := 0;
                        EnterStatementHeader(False);
        end;

        IncludeTotals := True;

        end;

    1,3,5,7,11,15 : begin
                SameTx := True;

                while SameTx do begin
                Accsdatamodule.TransactionsYr1DB.next;
                TxType := Accsdatamodule.TransactionsYr1DB['TxType'];

                   if Accsdatamodule.TransactionsYr1DB['OrigType'] = OrigType then begin

                        if Accsdatamodule.TransactionsYr1DB['TxType'] = 9 then begin

                                Accsdatamodule.LedgerReportDB.Append;
                                Accsdatamodule.LedgerReportDB['LineType'] := 'id';
                                Accsdatamodule.LedgerReportDB['LineDate'] := Accsdatamodule.TransactionsYr1DB['TxDate'];

                                // TGM AB 21/10/16

                                if ShowInvoiceDetails then begin

                                        GatherInvoiceInfoLastYear(Accsdatamodule.TransactionsYr1DB['TxNo']);
                                        if ( Length(InvoiceDate) > 0 ) then
                                           Accsdatamodule.LedgerReportDB['LineDate'] := InvoiceDate;
                                        Accsdatamodule.LedgerReportDB['LineDescription'] := InvoiceLine1;

                                end
                                        else Accsdatamodule.LedgerReportDB['LineDescription'] := Accsdatamodule.TransactionsYr1DB['Descript'];

                                // TGM AB 21/10/16

                                Accsdatamodule.LedgerReportDB['LineQty'] := Accsdatamodule.TransactionsYr1DB['Quantity'];
                                if Accsdatamodule.TransactionsYr1DB['Quantity'] <> 0 then begin
                                        try UnitPrice :=  Accsdatamodule.TransactionsYr1DB['Amount'] / Accsdatamodule.TransactionsYr1DB['Quantity'];
                                            Accsdatamodule.LedgerReportDB['LineUnitPrice'] := UnitPrice;
                                        except
                                        end;
                                end;
                                if ShowInEuro then begin                                                                                                                                                                                                       // TGM AB 21/10/16
                                        Accsdatamodule.LedgerReportDB['LineUnitPrice'] := Accsdatamodule.LedgerReportDB['LineUnitPrice'] / cash11.xEuroConverter;                                                                                              // TGM AB 21/10/16
                                        Accsdatamodule.LedgerReportDB['LinePrice'] := Accsdatamodule.TransactionsYr1DB['Amount'] / cash11.xEuroConverter;                                                                                                      // TGM AB 21/10/16
                                        Accsdatamodule.LedgerReportDB['LineVAT'] := Accsdatamodule.TransactionsYr1DB['TaxDisc'] / cash11.xEuroConverter;                                                                                                       // TGM AB 21/10/16
                                        if prog = CustSTM then Accsdatamodule.LedgerReportDB['LineDebit'] := (Accsdatamodule.TransactionsYr1DB['Amount']/ cash11.xEuroConverter) + (Accsdatamodule.TransactionsYr1DB['TaxDisc']/ cash11.xEuroConverter);       // TGM AB 21/10/16
                                        if prog = SuppSTM  then Accsdatamodule.LedgerReportDB['LineCredit'] := (Accsdatamodule.TransactionsYr1DB['Amount']/ cash11.xEuroConverter) + (Accsdatamodule.TransactionsYr1DB['TaxDisc']/ cash11.xEuroConverter);     // TGM AB 21/10/16
                                end else begin                                                                                                                                                                                                                 // TGM AB 21/10/16
                                                Accsdatamodule.LedgerReportDB['LinePrice'] := Accsdatamodule.TransactionsYr1DB['Amount'];                                                                                                                      // TGM AB 21/10/16
                                                Accsdatamodule.LedgerReportDB['LineVAT'] := Accsdatamodule.TransactionsYr1DB['TaxDisc'];                                                                                                                       // TGM AB 21/10/16
                                                if prog = CustSTM then Accsdatamodule.LedgerReportDB['LineDebit'] := Accsdatamodule.TransactionsYr1DB['Amount'] + Accsdatamodule.TransactionsYr1DB['TaxDisc'];                                                 // TGM AB 21/10/16
                                                if prog = SuppSTM  then Accsdatamodule.LedgerReportDB['LineCredit'] := Accsdatamodule.TransactionsYr1DB['Amount'] + Accsdatamodule.TransactionsYr1DB['TaxDisc'];                                               // TGM AB 21/10/16
                                        end;                                                                                                                                                                                                                   // TGM AB 21/10/16
                                Accsdatamodule.LedgerReportDB.post;
                                PageLineCount := PageLineCount + 1;

                                // TGM AB 21/10/16

                                try TxLinePriceTotal := TxLinePriceTotal + Accsdatamodule.LedgerReportDB['LinePrice'];
                                except
                                end;
                                try TxLineVATTotal := TxLineVATTotal + Accsdatamodule.LedgerReportDB['LineVAT'];
                                except
                                end;
                                try TxLineCreditTotal := TxLineCreditTotal + Accsdatamodule.LedgerReportDB['LineCredit'];
                                except
                                end;
                                try TxLineDebitTotal := TxLineDebitTotal + Accsdatamodule.LedgerReportDB['LineDebit'];
                                except
                                end;

                                if ShowInvoiceDetails then begin
                                     if InvoiceLine2 <> '' then begin
                                         Accsdatamodule.LedgerReportDB.append;
                                         Accsdatamodule.LedgerReportDB['LineDescription'] := InvoiceLine2;
                                         Accsdatamodule.LedgerReportDB.post;
                                         PageLineCount := PageLineCount + 1;
                                     end;

                                     if InvoiceLine3 <> '' then begin
                                         Accsdatamodule.LedgerReportDB.append;
                                         Accsdatamodule.LedgerReportDB['LineDescription'] := InvoiceLine3;
                                         Accsdatamodule.LedgerReportDB.post;
                                         PageLineCount := PageLineCount + 1;
                                     end;
                                end;

                                // TGM AB 21/10/16

                                if pagelinecount = 48 then begin
                                                pagelinecount := 0;
                                                EnterStatementHeader(False);
                                end;



                                IncludeTotals := True;
                        end;

                        if not (TxType in [0,9]) then SameTx := False;

                    end else SameTx := False;
                   if Accsdatamodule.TransactionsYr1DB['TxNo'] = Accsdatamodule.TransactionsYr1DB.recordcount then SameTx := False;
                end // while

        end;

    end;


    ReportLinePriceTotal := ReportLinePriceTotal + TxLinePriceTotal;         // TGM AB 08/04/16
    ReportLineVATTotal := ReportLineVATTotal + TxLineVATTotal;               // TGM AB 08/04/16
    ReportLineCreditTotal := ReportLineCreditTotal + TxLineCreditTotal;      // TGM AB 08/04/16
    ReportLineDebitTotal :=  ReportLineDebitTotal + TxLineDebitTotal;        // TGM AB 08/04/16

    if ExtendedShowSubTotals and IncludeTotals then begin

        Accsdatamodule.LedgerReportDB.Append;
        Accsdatamodule.LedgerReportDB['LineType'] := 'it';                                   // TGM AB 21/10/16
        Accsdatamodule.LedgerReportDB['TotalLinePrice']  := TxLinePriceTotal;                // TGM AB 21/10/16
        Accsdatamodule.LedgerReportDB['TotalLineVAT']    := TxLineVATTotal;                  // TGM AB 21/10/16
        if TxLineCreditTotal <> 0 then Accsdatamodule.LedgerReportDB['TotalLineCredit'] := TxLineCreditTotal;
        if TxLineDebitTotal <> 0 then Accsdatamodule.LedgerReportDB['TotalLineDebit']  := TxLineDebitTotal;
        Accsdatamodule.LedgerReportDB['GreenLineLabel']  := 'Totals';
        Accsdatamodule.LedgerReportDB.post;
        PageLineCount := PageLineCount + 1;
    end;


end;



procedure TLedgerReport.RunStatementReportExport(CompanyName : string);               // TGM AB 26/08/16
var
   i, AccFrom, AccTo : integer;
   OutputRecord : boolean;

begin

     GlobalFirstTxYear := FullAudit.AuditFiles.FirstTxThisYear;  //TGM AB 18/10/16
     GlobalFirstTxLastYear := FullAudit.AuditFiles.FirstTxLastYear;  //TGM AB 18/10/16

     Accsdatamodule.LedgerReportDB.close;
     if FileExists  (Accsdatamodule.AccsDataBase.Directory + 'LedgerReportTable.db' ) then begin
         try DeleteFile  (Accsdatamodule.AccsDataBase.Directory + 'LedgerReportTable.db' );
         except showmessage('Error Deleting Ledger Report Table!');
         end;
     end;

     try Accsdatamodule.CreateLedgerReportTable;
     except showmessage('Error Creating Ledger Report Table!');
     end;

     Accsdatamodule.LedgerReportDB.open;

     Accsdatamodule.CustSuppTempTableDB.close;
     if FileExists  (Accsdatamodule.AccsDataBase.Directory + 'CustSuppTempTable.db' ) then begin
         try DeleteFile  (Accsdatamodule.AccsDataBase.Directory + 'CustSuppTempTable.db' );
         except showmessage('Error Deleting Cust/Supp Temp Table!');
         end;
     end;

     try Accsdatamodule.CreateCustSuppTempTable;
         except showmessage('Error Creating Cust/Supp Temp Table!');
         end;

     Accsdatamodule.CustSuppTempTableDB.open;

     // Pickup Options From Import

     ShowInEuro := False;   // not an option for App

     IncBalance := true; // true for statements

     ShowExtendedStatement := True;      // Show Extended Statement details
     ExtendedStatementConditions := 5;   // Age by 12 Months
     ExtendedShowSubTotals := false;     // don't show sub totals
     ExtendedShowPerUnit := True;        // show the per unit details
     ShowInvoiceDetails := False;        // don't overwrite nominal description with invoice details            // TGM AB 21/10/16

     if not bool(StatementForm) then Application.CreateForm(TStatementForm, StatementForm);

     if fileexists('c:\kingsacc\' + CompanyName + '\year-1.db') then StatementForm.IncludeLastYearsTx.checked := True        // include transactions from last year
        else StatementForm.IncludeLastYearsTx.checked := False;

     RFarmGate.plocation[2] := CompanyName;

     CustSuppListing.AgeByCombo.ItemIndex := 5;          // Age by 12 Months
     CalculateMonths.UpdateSLFigures(date,CustSuppListing.AgeByCombo.ItemIndex);
     CalculateMonths.UpdatePLFigures(date,CustSuppListing.AgeByCombo.ItemIndex);

     statementform.AgeBycombo.ItemIndex := 5;            // Age by 12 Months


     if Prog = SUPPSTM then SetDb ( PLFILE )
     else
        SetDb ( SLFILE );
     AccFrom  := 1;
     AccTo    := db1.dbrechigh;

     for i:= AccFrom to AccTo do begin
        OutputRecord := True;
        AccountNo := i;
        GetAccountDetails(AccountNo);

        If not ActiveAcc then OutputRecord := false;

        if OutputRecord then begin
                PageLineCount := 0;
                GatherTransactions(AccountNo);
                EnterStatementHeader(true);
                FilterStatementTransactions;
        end;


     end;



end;



Procedure TLedgerReport.GatherInvoiceInfo(TxNo : Integer);   // TGM AB 21/10/16
begin
    // gathers extra invoice info for each transaction

    InvoiceLine1 := '';
    InvoiceLine2 := '';
    InvoiceLine3 := '';

    Accsdatamodule.InvoiceLinesQuery.SQL.clear;
    Accsdatamodule.InvoiceLinesQuery.SQL.Add('Select * from ProductsTx where TxNo = ' + vartostr(TxNo));
    Accsdatamodule.InvoiceLinesQuery.open;

    if Accsdatamodule.InvoiceLinesQuery.recordcount > 0 then begin
          if vartostr(AccsDataModule.InvoiceLinesQuery['LineDate']) <> Null then InvoiceDate := AccsDataModule.InvoiceLinesQuery['LineDate']; 
          if vartostr(Accsdatamodule.InvoiceLinesQuery['Desc1']) <> null then InvoiceLine1 := Accsdatamodule.InvoiceLinesQuery['Desc1'];
          if vartostr(Accsdatamodule.InvoiceLinesQuery['Desc2']) <> null then InvoiceLine2 := Accsdatamodule.InvoiceLinesQuery['Desc2'];
          if vartostr(Accsdatamodule.InvoiceLinesQuery['Desc3']) <> null then InvoiceLine3 := Accsdatamodule.InvoiceLinesQuery['Desc3'];
    end;

    Accsdatamodule.InvoiceLinesQuery.close;

end;


Procedure TLedgerReport.GatherInvoiceInfoLastYear(TxNo : Integer);   // TGM AB 21/10/16
begin
    // gathers extra invoice info for each transaction

    InvoiceLine1 := '';
    InvoiceLine2 := '';
    InvoiceLine3 := '';

    if fileexists('c:\kingsacc\' + RFarmGate.pLocation[2] + '\ProductsTx-1.db') then begin

        Accsdatamodule.InvoiceLinesQuery.SQL.clear;
        Accsdatamodule.InvoiceLinesQuery.SQL.Add('Select * from ''ProductsTx-1'' where TxNo = ' + vartostr(TxNo));
        Accsdatamodule.InvoiceLinesQuery.open;

        if Accsdatamodule.InvoiceLinesQuery.recordcount > 0 then begin
              if vartostr(Accsdatamodule.InvoiceLinesQuery['LineDate']) <> null then InvoiceDate := Accsdatamodule.InvoiceLinesQuery['LineDate'];
              if vartostr(Accsdatamodule.InvoiceLinesQuery['Desc1']) <> null then InvoiceLine1 := Accsdatamodule.InvoiceLinesQuery['Desc1'];
              if vartostr(Accsdatamodule.InvoiceLinesQuery['Desc2']) <> null then InvoiceLine2 := Accsdatamodule.InvoiceLinesQuery['Desc2'];
              if vartostr(Accsdatamodule.InvoiceLinesQuery['Desc3']) <> null then InvoiceLine3 := Accsdatamodule.InvoiceLinesQuery['Desc3'];
        end;

        Accsdatamodule.InvoiceLinesQuery.close;

    end;

end;

end.
