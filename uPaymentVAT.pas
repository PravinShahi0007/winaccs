unit uPaymentVAT;

// 20/05/11 TGM AB - new unit to generate the payment based VAT report

// 17/07/15 TGM AB - unit vastly re-written to allow a mixed VAT report & allow payment based reports to feed values into summary table

// 18/09/20 CH006(P) - Added in procedures to generate MTD figures for Payment Based VAT Customers & modified report output to match the new include / exempt totals as per MTD report


interface

Type TTempArray = record
      VatCode : String[1];
      Total : Real;
      VAT : Real;
   end;


 // procedure RunReport;
  procedure AuditReport(ReportType : Char); //TGM AB 17/07/15. S - Sales Only, P - Purchases Only, B - Both
  procedure GatherInvoices(TxID : integer);
  procedure InvoiceBreakdown(TxID : integer; PaymentTotal, VATTotal : Real; LastYear : Boolean);
  procedure GatherInvoicesYr1(TxID : integer);    // Ch006(P)
  procedure InvoiceBreakdownYr2(TxID : integer; PaymentTotal, VATTotal : Real);  // Ch006(P)

Var
  ReportDate : string;
  TransactionsFrom : Integer;
  TransactionsTo : Integer;
  DateFrom : string;
  DateTo : string;
  QueryDateFrom, QueryDateTo : string;
  OutputAuditTrail : boolean;
  TempArray:array[0..9] of TTempArray;



implementation

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, Types, AccsData, NomRpt, uPaymentVATReport,
  uPaymentAuditReport, vars, calcs, clears, DBCore, uvatreps;

{Procedure RunReport;
var
        i,j : integer;
        SalesTotal, SalesVAT, SalesBefore : real;
        PurchaseTotal, PurchaseVAT, PurchaseBefore : real;
        st : shortstring;
begin
     // Gather variables from VAT Report Form

     ReportDate := NominalReportForm.VatRepDate.Text;
     TransactionsFrom := Strtoint(NominalReportForm.VatTxFrom.text);
     TransactionsTo := Strtoint(NominalReportForm.VatTxTo.text);
     DateFrom := NominalReportForm.VatDateFrom.Text;
     DateTo := NominalReportForm.VatDateTo.Text;
     OutputAuditTrail := NominalReportForm.VatAuditChecked.Checked;

     SalesTotal := 0;
     SalesVAT := 0;
     SalesBefore := 0;

     PurchaseTotal := 0;
     PurchaseVAT := 0;
     PurchaseBefore := 0;

     //Filter Transactions File

     AccsDatamodule.VATReportQuery.close;
     AccsDatamodule.VATReportQuery.SQL.Clear;

     QueryDateFrom := copy(DateFrom,4,2) + '/' + copy(DateFrom,1,2) + '/' + copy(DateFrom,7,2);
     QueryDateTo := copy(DateTo,4,2) + '/' + copy(DateTo,1,2) + '/' + copy(DateTo,7,2);

     // Sales Types 2 & 12

     AccsDatamodule.VATReportQuery.SQL.add('Select count(txno), txtype, sum(Amount), sum(TaxDisc), sum(AllocatedVATAmount) From Transactions');
     AccsDatamodule.VATReportQuery.SQL.add('where ((TxType = 2) or (TxType = 12))');
     if DateFrom <> '  /  /  ' then AccsDatamodule.VATReportQuery.SQL.add('and ((txdate >= ''' + QueryDateFrom + ''') and (txdate <= ''' + QueryDateTo + '''))')
        else AccsDatamodule.VATReportQuery.SQL.add('and (txno between ' + vartostr(TransactionsFrom) + ' and ' + vartostr(TransactionsTo) +')');
     AccsDatamodule.VATReportQuery.SQL.add('group by txtype');
     AccsDatamodule.VATReportQuery.open;

     AccsDatamodule.VATReportQuery.first;


     for i:=1 to AccsDatamodule.VATReportQuery.recordcount do begin
                try SalesTotal := SalesTotal + AccsDatamodule.VATReportQuery['Sum of Amount'] + AccsDatamodule.VATReportQuery['Sum of TaxDisc'];
                except
                end;
                try SalesVAT := SalesVAT + AccsDatamodule.VATReportQuery['Sum of AllocatedVATAmount'];
                except
                end;
                AccsDatamodule.VATReportQuery.next
     end;



     SalesBefore := SalesTotal - SalesVAT;


     // Purchase Types 6 & 16

     AccsDatamodule.VATReportQuery.close;
     AccsDatamodule.VATReportQuery.SQL.Clear;

     AccsDatamodule.VATReportQuery.SQL.add('Select count(txno), txtype, sum(Amount), sum(TaxDisc), sum(AllocatedVATAmount) From Transactions');
     AccsDatamodule.VATReportQuery.SQL.add('where ((TxType = 6) or (TxType = 16))');
     if DateFrom <> '  /  /  ' then AccsDatamodule.VATReportQuery.SQL.add('and ((txdate >= ''' + QueryDateFrom + ''') and (txdate <= ''' + QueryDateTo + '''))')
        else AccsDatamodule.VATReportQuery.SQL.add('and (txno between ' + vartostr(TransactionsFrom) + ' and ' + vartostr(TransactionsTo) +')');
     AccsDatamodule.VATReportQuery.SQL.add('group by txtype');
     AccsDatamodule.VATReportQuery.open;

     AccsDatamodule.VATReportQuery.first;

     for i:=1 to AccsDatamodule.VATReportQuery.recordcount do begin
                try PurchaseTotal := PurchaseTotal + AccsDatamodule.VATReportQuery['Sum of Amount'] + AccsDatamodule.VATReportQuery['Sum of TaxDisc'];
                except;
                end;
                try PurchaseVAT := PurchaseVAT + AccsDatamodule.VATReportQuery['Sum of AllocatedVATAmount'];
                except
                end;
                AccsDatamodule.VATReportQuery.next
     end;


     PurchaseBefore := PurchaseTotal - PurchaseVAT;



     if not bool(PaymentVATReport) then Application.CreateForm(TPaymentVATReport, PaymentVATReport);
     PaymentVATReport.AccountsName.Caption := Cash1.XCOMPANY;
     PaymentVATReport.KingswoodLbl.caption :=  'Kingswood Accounts ' + Verno;
     PaymentVATReport.DataSet.Caption :=  Accsdata.AccsDataModule.AccsDataBase.AliasName;
     PaymentVATReport.DateLbl.Caption := ReportDate;

     if DateFrom <> '  /  /  ' then PaymentVATReport.Range.Caption := 'Date Range : ' + DateFrom + ' to ' + DateTo
        else PaymentVATReport.Range.Caption := 'Transaction Range : ' + vartostr(TransactionsFrom) + ' to ' + vartostr(TransactionsTo);


     DoubleToStr (SalesBefore,st,'%8.2f', true, false, 20, True);
     PaymentVATReport.SalesBefore.Caption := st;
     DoubleToStr (SalesVAT,st,'%8.2f', true, false, 20, True);
     PaymentVATReport.SalesVAT.Caption := st;
     DoubleToStr (SalesTotal,st,'%8.2f', true, false, 20, True);
     PaymentVATReport.SalesTotal.Caption := st;

     DoubleToStr (PurchaseBefore,st,'%8.2f', true, false, 20, True);
     PaymentVATReport.PurchaseBefore.Caption := st;
     DoubleToStr (PurchaseVAT,st,'%8.2f', true, false, 20, True);
     PaymentVATReport.PurchaseVAT.Caption := st;
     DoubleToStr (PurchaseTotal,st,'%8.2f', true, false, 20, True);
     PaymentVATReport.PurchaseTotal.Caption := st;

 ///    if OutputAuditTrail then Auditreport;       TGM AB
 ///    PaymentVATReport.Preview;
 ///    if OutputAuditTrail then PaymentAuditReport.Preview;

end;
 }
Procedure AuditReport;
var
        i,j : integer;
        st : shortstring;
        SalesTotal, SalesVAT, TempVAT : real;
        PurchaseTotal, PurchaseVAT : real;
        TotalAmount, TotalVAT, TotalExempt : real;       //  Ch006(P)
begin

     // Gather variables from VAT Report Form     TGM AB 17/07/15

     ReportDate := NominalReportForm.VatRepDate.Text;                  // TGM AB 17/07/15
     TransactionsFrom := Strtoint(NominalReportForm.VatTxFrom.text);   // TGM AB 17/07/15
     TransactionsTo := Strtoint(NominalReportForm.VatTxTo.text);       // TGM AB 17/07/15
     DateFrom := NominalReportForm.VatDateFrom.Text;                   // TGM AB 17/07/15
     DateTo := NominalReportForm.VatDateTo.Text;                       // TGM AB 17/07/15

     QueryDateFrom := copy(DateFrom,4,2) + '/' + copy(DateFrom,1,2) + '/' + copy(DateFrom,7,2);     // TGM AB 20/11/15
     QueryDateTo := copy(DateTo,4,2) + '/' + copy(DateTo,1,2) + '/' + copy(DateTo,7,2);             // TGM AB 20/11/15

  (*   if not bool(PaymentAuditReport) then Application.CreateForm(TPaymentAuditReport, PaymentAuditReport);
     PaymentAuditReport.AccountsName.Caption := Cash1.XCOMPANY;
     PaymentAuditReport.KingswoodLbl.caption :=  'Kingswood Accounts ' + Verno;
     PaymentAuditReport.DataSet.Caption :=  Accsdata.AccsDataModule.AccsDataBase.AliasName;
     PaymentAuditReport.DateLbl.Caption := ReportDate;

     if DateFrom <> '  /  /  ' then PaymentAuditReport.Range.Caption := 'Date Range : ' + DateFrom + ' to ' + DateTo
        else PaymentAuditReport.Range.Caption := 'Transaction Range : ' + vartostr(TransactionsFrom) + ' to ' + vartostr(TransactionsTo);

     Accsdatamodule.TempVATDB.Close;
     Accsdatamodule.TempVATDB.EmptyTable;
     Accsdatamodule.TempVATDB.open;
    *)        // TGM AB 17/07/15


    // Initialising The Temp Array   // TGM AB 04/09/15

    for j:= 0 to 9 do Begin
                       TempArray[j].VatCode := Cash1.xTaxIds[j];
                       TempArray[j].Total := 0;
                       TempArray[j].VAT := 0;
    end;

     AccsDatamodule.AllocatedVATDB.Open;
    
     // sales

     if ((ReportType = 'B') or (ReportType = 'S' ))then begin     // TGM AB 17/07/15

     SalesTotal := 0;
     SalesVAT := 0;

     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB['Label'] := 'SALES RECEIPT AUDIT TRAIL';
     Accsdatamodule.TempVATDB['Description'] := '* Denotes Previous Yr';
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB['Label'] := '========================================';
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB.post;

     AccsDatamodule.VATReportQuery.close;
     AccsDatamodule.VATReportQuery.SQL.Clear;

     AccsDatamodule.VATReportQuery.SQL.Add('SELECT * ');
     AccsDataModule.VATReportQuery.SQL.Add('FROM Transactions');
     AccsDatamodule.VATReportQuery.SQL.Add('WHERE ((TxType = 2) or (TxType = 12))');
     if DateFrom <> '  /  /  ' then
        AccsDatamodule.VATReportQuery.SQL.Add('AND ((txdate >= ''' + QueryDateFrom + ''') and (txdate <= ''' + QueryDateTo + '''))')
     else
        AccsDatamodule.VATReportQuery.SQL.Add('AND (txno between ' + vartostr(TransactionsFrom) + ' and ' + vartostr(TransactionsTo) +')');
     AccsDatamodule.VATReportQuery.SQL.Add('ORDER BY TxNo DESC');
     AccsDatamodule.VATReportQuery.Open;

     AccsDatamodule.VATReportQuery.First;

     while ( not(AccsDatamodule.VATReportQuery.Eof) ) do
        try
           // try and locate record in allocatedVAT table otherwise leave the transaction out

           AccsDatamodule.AllocatedVATDB.filter := 'PaymentID = ' + vartostr(AccsDatamodule.VATReportQuery['TxNo']);
           AccsDatamodule.AllocatedVATDB.filtered := true;

           if ( AccsDatamodule.AllocatedVATDB.RecordCount > 0 ) then
              try
                 Accsdatamodule.TempVATDB.append;
                 Accsdatamodule.TempVATDB['Record'] := AccsDatamodule.VATReportQuery['TxNo'];
                 Accsdatamodule.TempVATDB['TxDate'] := AccsDatamodule.VATReportQuery['TxDate'];
                 Accsdatamodule.TempVATDB['Reference'] := AccsDatamodule.VATReportQuery['Reference'];
                 Accsdatamodule.TempVATDB['Description'] := AccsDatamodule.VATReportQuery['Descript'];
                 try DoubleToStr ((AccsDatamodule.VATReportQuery['Amount']+AccsDatamodule.VATReportQuery['TaxDisc']),st,'%8.2f', true, false, 20, True);
                 except st := '0.00'
                 end;
                 slimleft (st);
                 Accsdatamodule.TempVATDB['AmountText'] := st;

                 SalesTotal := SalesTotal + (AccsDatamodule.VATReportQuery['Amount']+AccsDatamodule.VATReportQuery['TaxDisc']);

                 try DoubleToStr (AccsDatamodule.VATReportQuery['AllocatedVATAmount'],st,'%8.2f', true, false, 20, True);
                 except st := '0.00'
                 end;
                 slimleft (st);
                 Accsdatamodule.TempVATDB['VATText'] := st;

                 try TempVAT := AccsDatamodule.VATReportQuery['AllocatedVATAmount'];
                 except TempVAT := 0.00;
                 end;

                 SalesVAT := SalesVAT + TempVAT; //AccsDatamodule.VATReportQuery['AllocatedVATAmount'];

                 SetDb ( SLFile );
                 ReadRec ( SLFile, AccsDatamodule.VATReportQuery['Account']);
                 if AccsDatamodule.VATReportQuery['Account'] <> 0 then begin
                       If RecActive ( SLFile ) Then Begin
                               GetItem ( SLFile, 1 );
                               Accsdatamodule.TempVATDB['Account'] := CurrStr;
                       end;
                 end;
                 Accsdatamodule.TempVATDB.post;

                 GatherInvoices(AccsDatamodule.VATReportQuery['TxNo']);
              except
                 on e : Exception do
                    ShowMessage(e.Message);
              end; // >0

           AccsDatamodule.AllocatedVATDB.filtered := false;
           AccsDatamodule.AllocatedVATDB.filter := '';

           AccsDatamodule.VATReportQuery.Next;
        except
           on e : Exception do
              ShowMessage(e.Message);
        end;

     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB['Label'] := 'Totals ...';
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB.post;

     // CH006(P) start

     TotalAmount := 0;
     TotalVAT := 0;
     TotalExempt := 0;

     for j:= 0 to 9 do Begin
            if cash2.XCOUNTRY = 1 then begin
                   if uVATReps.VatArray[j].NIInclude = True then begin
                               TotalAmount := TotalAmount + uVATReps.VatArray[j].SalesNet;
                               TotalVat := TotalVat + uVATReps.VatArray[j].SalesVat;
                   end else begin
                               TotalExempt := TotalExempt + uVATReps.VatArray[j].SalesNet;

                   end;
            end
                   else begin
                               TotalAmount := TotalAmount + uVATReps.VatArray[j].SalesNet;
                               TotalVat := TotalVat + uVATReps.VatArray[j].SalesVat;
                   end;
     end;


     Accsdatamodule.TempVATDB.append;
     if cash2.XCOUNTRY = 1 then Accsdatamodule.TempVATDB['Label'] := 'Amount Total (Included in VAT Return) .... '
                    else Accsdatamodule.TempVATDB['Label'] := 'Amount Total .... ';
     st := '';
     DoubleToStr (TotalAmount-TotalVat,st,'%8.2f', true, false, 20, True);
     slimleft (st);
     Accsdatamodule.TempVATDB['AmountText'] := st;
     Accsdatamodule.TempVATDB.post;

     Accsdatamodule.TempVATDB.append;
     if cash2.XCOUNTRY = 1 then Accsdatamodule.TempVATDB['Label'] := 'VAT / Discount (Included in VAT Return) .... '
                    else Accsdatamodule.TempVATDB['Label'] := 'VAT / Discount .... ';
     st := '';
     DoubleToStr (TotalVat,st,'%8.2f', true, false, 20, True);
     slimleft (st);
     Accsdatamodule.TempVATDB['AmountText'] := st;
     Accsdatamodule.TempVATDB.post;

     Accsdatamodule.TempVATDB.append;
     if cash2.XCOUNTRY = 1 then Accsdatamodule.TempVATDB['Label'] := 'Grand Total (Included in VAT Return) .... '
                    else Accsdatamodule.TempVATDB['Label'] := 'Grand Total .... ';
     st := '';
     DoubleToStr ((TotalAmount),st,'%8.2f', true, false, 20, True);
     slimleft (st);
     Accsdatamodule.TempVATDB['AmountText'] := st;
     Accsdatamodule.TempVATDB.post;

     if TotalExempt <> 0 then begin

        Accsdatamodule.TempVATDB.append;
        Accsdatamodule.TempVATDB.post;
        Accsdatamodule.TempVATDB.append;
        Accsdatamodule.TempVATDB['Label'] := 'Exempt Total (Not Included in VAT Return) .... ';
        st := '';
        DoubleToStr ((TotalExempt),st,'%8.2f', true, false, 20, True);
        slimleft (st);
        Accsdatamodule.TempVATDB['AmountText'] := st;
        Accsdatamodule.TempVATDB.post;

     end;

     {
     Accsdatamodule.TempVATDB.append;
     try DoubleToStr (SalesTotal,st,'%8.2f', true, false, 20, True);
     except st := '0.00'
     end;
     slimleft (st);
     Accsdatamodule.TempVATDB['AmountText'] := st;
     Accsdatamodule.TempVATDB['Label'] := 'Grand Total ...';
     Accsdatamodule.TempVATDB.post;

     Accsdatamodule.TempVATDB.append;
     try DoubleToStr (SalesVAT,st,'%8.2f', true, false, 20, True);
     except st := '0.00'
     end;
     slimleft (st);
     Accsdatamodule.TempVATDB['AmountText'] := st;
     Accsdatamodule.TempVATDB['Label'] := 'VAT/Discount Total ...';
     Accsdatamodule.TempVATDB.post;
     }

     // CH006(P) end

 {
     Accsdatamodule.TempVATDB.append;
     try DoubleToStr ((SalesTotal+SalesVAT),st,'%8.2f', true, false, 20, True);
     except st := '0.00'
     end;
     slimleft (st);
     Accsdatamodule.TempVATDB['AmountText'] := st;
     Accsdatamodule.TempVATDB['Label'] := 'Grand Total ...';
     Accsdatamodule.TempVATDB.post;
    }
     end; // Sales  TGM AB 17/07/15


     // purchases

     if ((ReportType = 'B') or (ReportType = 'P' ))then begin     // TGM AB 17/07/15

     PurchaseTotal := 0;
     PurchaseVAT := 0;


     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB.post;

     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB['Label'] := 'PURCHASE PAYMENT AUDIT TRAIL';
     Accsdatamodule.TempVATDB['Description'] := '* Denotes Previous Yr';
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB['Label'] := '========================================';
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB.post;

     AccsDatamodule.VATReportQuery.close;
     AccsDatamodule.VATReportQuery.SQL.Clear;

     AccsDatamodule.VATReportQuery.SQL.add('Select * From Transactions');
     AccsDatamodule.VATReportQuery.SQL.add('where ((TxType = 6) or (TxType = 16))');
     if DateFrom <> '  /  /  ' then AccsDatamodule.VATReportQuery.SQL.add('and ((txdate >= ''' + QueryDateFrom + ''') and (txdate <= ''' + QueryDateTo + '''))')
        else AccsDatamodule.VATReportQuery.SQL.add('and (txno between ' + vartostr(TransactionsFrom) + ' and ' + vartostr(TransactionsTo) +')');
     AccsDatamodule.VATReportQuery.SQL.add('order by txno desc');
     AccsDatamodule.VATReportQuery.open;

     AccsDatamodule.VATReportQuery.first;

     for i:=1 to AccsDatamodule.VATReportQuery.recordcount do begin
        // try and locate record in allocatedVAT table otherwise leave the transaction out

        AccsDatamodule.AllocatedVATDB.filter := 'PaymentID = ' + vartostr(AccsDatamodule.VATReportQuery['TxNo']);
        AccsDatamodule.AllocatedVATDB.filtered := true;

        if  AccsDatamodule.AllocatedVATDB.RecordCount > 0 then begin


          Accsdatamodule.TempVATDB.append;
          Accsdatamodule.TempVATDB['Record'] := AccsDatamodule.VATReportQuery['TxNo'];
          Accsdatamodule.TempVATDB['TxDate'] := AccsDatamodule.VATReportQuery['TxDate'];
          Accsdatamodule.TempVATDB['Reference'] := AccsDatamodule.VATReportQuery['Reference'];
          Accsdatamodule.TempVATDB['Description'] := AccsDatamodule.VATReportQuery['Descript'];
          try DoubleToStr ((AccsDatamodule.VATReportQuery['Amount']+AccsDatamodule.VATReportQuery['TaxDisc']),st,'%8.2f', true, false, 20, True);
          except st := '0.00'
          end;
          slimleft (st);
          Accsdatamodule.TempVATDB['AmountText'] := st;

          PurchaseTotal := PurchaseTotal + (AccsDatamodule.VATReportQuery['Amount']+AccsDatamodule.VATReportQuery['TaxDisc']);

          try DoubleToStr (AccsDatamodule.VATReportQuery['AllocatedVATAmount'],st,'%8.2f', true, false, 20, True);
          except st := '0.00'
          end;
          slimleft (st);
          Accsdatamodule.TempVATDB['VATText'] := st;

          try TempVAT := AccsDatamodule.VATReportQuery['AllocatedVATAmount'];
          except TempVAT := 0.00;
          end;

          PurchaseVAT := PurchaseVAT + TempVAT; //AccsDatamodule.VATReportQuery['AllocatedVATAmount'];

          SetDb ( PLFile );
          ReadRec ( PLFile, AccsDatamodule.VATReportQuery['Account']);
          if AccsDatamodule.VATReportQuery['Account'] <> 0 then begin
                If RecActive ( PLFile ) Then Begin
                        GetItem ( PLFile, 1 );
                        Accsdatamodule.TempVATDB['Account'] := CurrStr;
                end;
          end;
          Accsdatamodule.TempVATDB.post;

          GatherInvoices(AccsDatamodule.VATReportQuery['TxNo']);

          
        end; // >0

          AccsDatamodule.AllocatedVATDB.filtered := false;
          AccsDatamodule.AllocatedVATDB.filter := '';
          AccsDatamodule.VATReportQuery.next;

     end;

     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB['Label'] := 'Totals ...';
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB.post;

     //Ch006(P) start

     TotalAmount := 0;
     TotalVAT := 0;
     TotalExempt := 0;

     for j:= 0 to 9 do Begin
            if cash2.XCOUNTRY = 1 then begin
                   if uVATReps.VatArray[j].NIInclude = True then begin
                               TotalAmount := TotalAmount + uVATReps.VatArray[j].PurchNet;
                               TotalVat := TotalVat + uVATReps.VatArray[j].PurchVat;
                   end else begin
                               TotalExempt := TotalExempt + uVATReps.VatArray[j].PurchNet;
                   end;
            end
                   else begin
                               TotalAmount := TotalAmount + uVATReps.VatArray[j].PurchNet;
                               TotalVat := TotalVat + uVATReps.VatArray[j].PurchVat;
                   end;
     end;


     Accsdatamodule.TempVATDB.append;
     if cash2.XCOUNTRY = 1 then Accsdatamodule.TempVATDB['Label'] := 'Amount Total (Included in VAT Return) .... '
                    else Accsdatamodule.TempVATDB['Label'] := 'Amount Total .... ';
     st := '';
     DoubleToStr (TotalAmount-TotalVat,st,'%8.2f', true, false, 20, True);
     slimleft (st);
     Accsdatamodule.TempVATDB['AmountText'] := st;
     Accsdatamodule.TempVATDB.post;

     Accsdatamodule.TempVATDB.append;
     if cash2.XCOUNTRY = 1 then Accsdatamodule.TempVATDB['Label'] := 'VAT / Discount (Included in VAT Return) .... '
                    else Accsdatamodule.TempVATDB['Label'] := 'VAT / Discount .... ';
     st := '';
     DoubleToStr (TotalVat,st,'%8.2f', true, false, 20, True);
     slimleft (st);
     Accsdatamodule.TempVATDB['AmountText'] := st;
     Accsdatamodule.TempVATDB.post;

     Accsdatamodule.TempVATDB.append;
     if cash2.XCOUNTRY = 1 then Accsdatamodule.TempVATDB['Label'] := 'Grand Total (Included in VAT Return) .... '
                    else Accsdatamodule.TempVATDB['Label'] := 'Grand Total .... ';
     st := '';
     DoubleToStr ((TotalAmount),st,'%8.2f', true, false, 20, True);
     slimleft (st);
     Accsdatamodule.TempVATDB['AmountText'] := st;
     Accsdatamodule.TempVATDB.post;

     if TotalExempt <> 0 then begin

        Accsdatamodule.TempVATDB.append;
        Accsdatamodule.TempVATDB.post;
        Accsdatamodule.TempVATDB.append;
        Accsdatamodule.TempVATDB['Label'] := 'Exempt Total (Not Included in VAT Return) .... ';
        st := '';
        DoubleToStr ((TotalExempt),st,'%8.2f', true, false, 20, True);
        slimleft (st);
        Accsdatamodule.TempVATDB['AmountText'] := st;
        Accsdatamodule.TempVATDB.post;

     end;

     TotalAmount := 0;
     TotalVAT := 0;
     TotalExempt := 0;

  {                                                                //Ch006(P)
     Accsdatamodule.TempVATDB.append;
     try DoubleToStr (PurchaseTotal,st,'%8.2f', true, false, 20, True);
     except st := '0.00'
     end;
     slimleft (st);
     Accsdatamodule.TempVATDB['AmountText'] := st;
     Accsdatamodule.TempVATDB['Label'] := 'Grand Total ...';
     Accsdatamodule.TempVATDB.post;

     Accsdatamodule.TempVATDB.append;
     try DoubleToStr (PurchaseVAT,st,'%8.2f', true, false, 20, True);
     except st := '0.00'
     end;
     slimleft (st);
     Accsdatamodule.TempVATDB['AmountText'] := st;
     Accsdatamodule.TempVATDB['Label'] := 'VAT/Discount Total ...';
     Accsdatamodule.TempVATDB.post;
     }

     //Ch006(P) end

 {
     Accsdatamodule.TempVATDB.append;
     try DoubleToStr ((PurchaseTotal),st,'%8.2f', true, false, 20, True);
     except st := '0.00'
     end;
     slimleft (st);
     Accsdatamodule.TempVATDB['AmountText'] := st;
     Accsdatamodule.TempVATDB['Label'] := 'Grand Total ...';
     Accsdatamodule.TempVATDB.post;
  }
     end; // purchases  TGM AB 17/07/15
end;

procedure GatherInvoices(TxID : integer);
var
        i : integer;
        st : shortstring;
        PaymentTotal, PaymentVAT : real;
        PreviousYear : boolean;
begin
      AccsDatamodule.VATReportInvoiceQuery.close;
      AccsDatamodule.VATReportInvoiceQuery.SQL.Clear;

      AccsDatamodule.VATReportInvoiceQuery.SQL.add('Select * From AllocatedVAT');
      AccsDatamodule.VATReportInvoiceQuery.SQL.add('where PaymentID = ' + vartostr(TxID));
      AccsDatamodule.VATReportInvoiceQuery.open;

      AccsDatamodule.VATReportInvoiceQuery.first;

      for i := 1 to AccsDatamodule.VATReportInvoiceQuery.recordcount do begin
          Accsdatamodule.TempVATDB.append;
          Accsdatamodule.TempVATDB['Label'] := '     Inv';

          PaymentTotal := AccsDatamodule.VATReportInvoiceQuery['TotalAmount'];
          PaymentVAT := AccsDatamodule.VATReportInvoiceQuery['VAT'];
          PreviousYear := false;

          try DoubleToStr (AccsDatamodule.VATReportInvoiceQuery['TotalAmount'],st,'%8.2f', true, false, 20, True);
          except st := '0.00'
          end;
          slimleft (st);
          Accsdatamodule.TempVATDB['AmountText'] := st;

          try DoubleToStr (AccsDatamodule.VATReportInvoiceQuery['VAT'],st,'%8.2f', true, false, 20, True);
          except st := '0.00'
          end;
          slimleft (st);
          Accsdatamodule.TempVATDB['VATText'] := st;

          Accsdatamodule.TempVATDB['TXID'] := AccsDatamodule.VATReportInvoiceQuery['InvoiceID'];
          try PreviousYear := AccsDatamodule.VATReportInvoiceQuery['PreviousYear']
          except PreviousYear := false;
          end;

          if PreviousYear then begin

              Accsdatamodule.TempVATDB['PreviousYear'] := '*';
              Accsdatamodule.TransactionsYr1DB.open;
              Accsdatamodule.TransactionsYr1DB.Locate('TxNo',AccsDatamodule.VATReportInvoiceQuery['InvoiceID'],[]);
              Accsdatamodule.TempVATDB['Reference'] := Accsdatamodule.TransactionsYr1DB['Reference'];
              Accsdatamodule.TempVATDB['Description'] := Accsdatamodule.TransactionsYr1DB['Descript'];
              Accsdatamodule.TempVATDB['TxDate'] := Accsdatamodule.TransactionsYr1DB['TxDate'];

              try DoubleToStr ((Accsdatamodule.TransactionsYr1DB['Amount']+Accsdatamodule.TransactionsYr1DB['TaxDisc']),st,'%8.2f', true, false, 20, True);
              except st := '0.00'
              end;
              slimleft (st);
              Accsdatamodule.TempVATDB['Account'] := 'Inv Total : ' + st;
              Accsdatamodule.TempVATDB.post;
              if ( AccsDatamodule.VATReportInvoiceQuery['InvoiceID'] > 0 ) then
                 InvoiceBreakdown(AccsDatamodule.VATReportInvoiceQuery['InvoiceID'], PaymentTotal, PaymentVAT, PreviousYear);

          end else begin
                if AccsDatamodule.VATReportInvoiceQuery['InvoiceID'] <> 0 then begin
                        Accsdatamodule.TransactionsDB.Locate('TxNo',AccsDatamodule.VATReportInvoiceQuery['InvoiceID'],[]);
                        Accsdatamodule.TempVATDB['Reference'] := Accsdatamodule.TransactionsDB['Reference'];
                        Accsdatamodule.TempVATDB['Description'] := Accsdatamodule.TransactionsDB['Descript'];
                        Accsdatamodule.TempVATDB['TxDate'] := Accsdatamodule.TransactionsDB['TxDate'];

                        try DoubleToStr ((Accsdatamodule.TransactionsDB['Amount']+Accsdatamodule.TransactionsDB['TaxDisc']),st,'%8.2f', true, false, 20, True);
                        except st := '0.00'
                        end;
                        slimleft (st);
                        Accsdatamodule.TempVATDB['Account'] := 'Inv Total : ' + st;

                end else begin
                               Accsdatamodule.TempVATDB['Description'] := 'Overpayment';
                    end;

                Accsdatamodule.TempVATDB.post;

                if ( AccsDatamodule.VATReportInvoiceQuery['InvoiceID'] > 0 ) then
                   InvoiceBreakdown(AccsDatamodule.VATReportInvoiceQuery['InvoiceID'], PaymentTotal, PaymentVAT, PreviousYear);

          end;
          AccsDatamodule.VATReportInvoiceQuery.next;
      end;
          Accsdatamodule.TempVATDB.append;
          Accsdatamodule.TempVATDB.post;
end;

procedure InvoiceBreakdown(TxID : integer; PaymentTotal, VATTotal : Real; LastYear : Boolean);
var
          InvoiceTotal, InvoiceVATTotal, Multiplier : Real;
          Stop : Boolean;
          InvoiceType, j : Integer;
          st, TaxCode, Desc : shortstring;
begin

       for j:= 0 to 9 do Begin
               TempArray[j].Total := 0;
               TempArray[j].VAT := 0;
       end;

       // Generate invoice breakdown
       if not LastYear then begin

          // Find transaction & get VAT details

          Accsdatamodule.TransactionsDB.Locate('TxNo',TxID,[]);
          InvoiceTotal := Accsdatamodule.TransactionsDB['Amount'] + Accsdatamodule.TransactionsDB['TaxDisc'];
          InvoiceVATTotal := Accsdatamodule.TransactionsDB['TaxDisc'];
          InvoiceType := Accsdatamodule.TransactionsDB['TxType'];

          Multiplier := PaymentTotal / InvoiceTotal;

          Stop := False;
          While not Stop do begin
                  Accsdatamodule.TransactionsDB.Next;
                  if ((Accsdatamodule.TransactionsDB['TxType'] <> '9') and (Accsdatamodule.TransactionsDB['TxType'] <> '0')) then Stop := True;
                  if ((Accsdatamodule.TransactionsDB['TxType'] = '9') and (Accsdatamodule.TransactionsDB['OrigType'] = InvoiceType)) then begin

                      Taxcode := Accsdatamodule.TransactionsDB['TAXCode'];
                      slimall(TaxCode);

                      for j := 0 to 9 do begin
                           if TempArray[j].Vatcode = TaxCode then begin
                                 TempArray[j].Total := TempArray[j].Total + Accsdatamodule.TransactionsDB['TaxDisc'] + Accsdatamodule.TransactionsDB['Amount'];
                                 TempArray[j].VAT := TempArray[j].VAT + Accsdatamodule.TransactionsDB['TaxDisc']
                           end;
                      end;

                  end;
                  if Accsdatamodule.TransactionsDB['TxNo'] = Accsdatamodule.TransactionsDB.recordcount then Stop := True;     // TGM AB 23/06/17
          end;

          // Fill details onto form & into VAT array

          for j := 0 to 9 do begin
                if TempArray[j].Total <> 0 then begin

                             Accsdatamodule.TempVATDB.append;

                             try DoubleToStr ((TempArray[j].VAT * Multiplier),st,'%8.2f', true, false, 20, True);
                             except st := '0.00'
                             end;
                             slimleft (st);
                             Accsdatamodule.TempVATDB['VATBreakdown'] := st;

                             try DoubleToStr ((TempArray[j].Total * Multiplier),st,'%8.2f', true, false, 20, True);
                             except st := '0.00'
                             end;
                             slimleft (st);
                             Accsdatamodule.TempVATDB['TotalBreakdown'] := st;

                             Accsdatamodule.TempVATDB['CodeBreakdown'] := TempArray[j].Vatcode;
                             Accsdatamodule.TempVATDB['DescBreakdown'] := Desc;

                             Accsdatamodule.TempVATDB.post;

                end;
          end;

          for j:= 0 to 9 do Begin
               if TempArray[j].Total <> 0 then begin
                                  if InvoiceType = 1 then begin
                                          VatArray[j].SalesNet := VatArray[j].SalesNet + (TempArray[j].Total * Multiplier);
                                          VatArray[j].SalesVat := VatArray[j].SalesVat + (TempArray[j].VAT * Multiplier);
                                  end else begin
                                          VatArray[j].PurchNet := VatArray[j].PurchNet + (TempArray[j].Total * Multiplier);
                                          VatArray[j].PurchVat := VatArray[j].PurchVat + (TempArray[j].VAT * Multiplier);
                                  end;
               end;
          end;
       end //not lastyear
        else begin
                // Find transaction & get VAT details

          Accsdatamodule.TransactionsYr1DB.Locate('TxNo',TxID,[]);
          InvoiceTotal := Accsdatamodule.TransactionsYr1DB['Amount'] + Accsdatamodule.TransactionsYr1DB['TaxDisc'];
          InvoiceVATTotal := Accsdatamodule.TransactionsYr1DB['TaxDisc'];
          InvoiceType := Accsdatamodule.TransactionsYr1DB['TxType'];

          Multiplier := PaymentTotal / InvoiceTotal;

          Stop := False;
          While not Stop do begin
                  Accsdatamodule.TransactionsYr1DB.Next;
                  if ((Accsdatamodule.TransactionsYr1DB['TxType'] <> '9') and (Accsdatamodule.TransactionsYr1DB['TxType'] <> '0')) then Stop := True;
                  if ((Accsdatamodule.TransactionsYr1DB['TxType'] = '9') and (Accsdatamodule.TransactionsYr1DB['OrigType'] = InvoiceType)) then begin

                      Taxcode := Accsdatamodule.TransactionsYr1DB['TAXCode'];
                      slimall(TaxCode);

                      for j := 0 to 9 do begin
                           if TempArray[j].Vatcode = TaxCode then begin
                                 TempArray[j].Total := TempArray[j].Total + Accsdatamodule.TransactionsYr1DB['TaxDisc'] + Accsdatamodule.TransactionsYr1DB['Amount'];
                                 TempArray[j].VAT := TempArray[j].VAT + Accsdatamodule.TransactionsYr1DB['TaxDisc']
                           end;
                      end;

                  end;
                  if Accsdatamodule.TransactionsYr1DB['TxNo'] = Accsdatamodule.TransactionsYr1DB.recordcount then Stop := True;     // TGM AB 23/06/17
          end;

          // Fill details onto form & into VAT array

          for j := 0 to 9 do begin
                if TempArray[j].Total <> 0 then begin

                             Accsdatamodule.TempVATDB.append;

                             try DoubleToStr ((TempArray[j].VAT * Multiplier),st,'%8.2f', true, false, 20, True);
                             except st := '0.00'
                             end;
                             slimleft (st);
                             Accsdatamodule.TempVATDB['VATBreakdown'] := st;

                             try DoubleToStr ((TempArray[j].Total * Multiplier),st,'%8.2f', true, false, 20, True);
                             except st := '0.00'
                             end;
                             slimleft (st);
                             Accsdatamodule.TempVATDB['TotalBreakdown'] := st;

                             Accsdatamodule.TempVATDB['CodeBreakdown'] := TempArray[j].Vatcode;
                             Accsdatamodule.TempVATDB['DescBreakdown'] := Desc;

                             Accsdatamodule.TempVATDB.post;

                end;
          end;

          for j:= 0 to 9 do Begin
               if TempArray[j].Total <> 0 then begin
                                  if InvoiceType = 1 then begin
                                          VatArray[j].SalesNet := VatArray[j].SalesNet + (TempArray[j].Total * Multiplier);
                                          VatArray[j].SalesVat := VatArray[j].SalesVat + (TempArray[j].VAT * Multiplier);
                                  end else begin
                                          VatArray[j].PurchNet := VatArray[j].PurchNet + (TempArray[j].Total * Multiplier);
                                          VatArray[j].PurchVat := VatArray[j].PurchVat + (TempArray[j].VAT * Multiplier);
                                  end;
               end;
          end;

        end; // last year
end;


// Ch006(P) Start


procedure GatherInvoicesYr1(TxID : integer);
var
        i : integer;
        st : shortstring;
        PaymentTotal, PaymentVAT : real;
        PreviousYear : boolean;
begin

      AccsDatamodule.VATReportInvoiceQuery.close;
      AccsDatamodule.VATReportInvoiceQuery.SQL.Clear;

      AccsDatamodule.VATReportInvoiceQuery.SQL.add('Select * From "AllocatedVAT-1"');
      AccsDatamodule.VATReportInvoiceQuery.SQL.add('where PaymentID = ' + vartostr(TxID));
      AccsDatamodule.VATReportInvoiceQuery.open;

      AccsDatamodule.VATReportInvoiceQuery.first;

      for i := 1 to AccsDatamodule.VATReportInvoiceQuery.recordcount do begin
          Accsdatamodule.TempVATDB.append;
          Accsdatamodule.TempVATDB['Label'] := '     Inv';

          PaymentTotal := AccsDatamodule.VATReportInvoiceQuery['TotalAmount'];
          PaymentVAT := AccsDatamodule.VATReportInvoiceQuery['VAT'];
          PreviousYear := false;

          try DoubleToStr (AccsDatamodule.VATReportInvoiceQuery['TotalAmount'],st,'%8.2f', true, false, 20, True);
          except st := '0.00'
          end;
          slimleft (st);
          Accsdatamodule.TempVATDB['AmountText'] := st;

          try DoubleToStr (AccsDatamodule.VATReportInvoiceQuery['VAT'],st,'%8.2f', true, false, 20, True);
          except st := '0.00'
          end;
          slimleft (st);
          Accsdatamodule.TempVATDB['VATText'] := st;

          Accsdatamodule.TempVATDB['TXID'] := AccsDatamodule.VATReportInvoiceQuery['InvoiceID'];

          PreviousYear := false;
          if not varisnull(AccsDatamodule.VATReportInvoiceQuery['PreviousYear']) then begin
             try PreviousYear := AccsDatamodule.VATReportInvoiceQuery['PreviousYear']
             except PreviousYear := false;
             end;
          end;

          if PreviousYear then begin

              Accsdatamodule.TempVATDB['PreviousYear'] := '*';
              Accsdatamodule.TransactionsYr2DB.open;
              Accsdatamodule.TransactionsYr2DB.Locate('TxNo',AccsDatamodule.VATReportInvoiceQuery['InvoiceID'],[]);
              Accsdatamodule.TempVATDB['Reference'] := Accsdatamodule.TransactionsYr2DB['Reference'];
              Accsdatamodule.TempVATDB['Description'] := Accsdatamodule.TransactionsYr2DB['Descript'];
              Accsdatamodule.TempVATDB['TxDate'] := Accsdatamodule.TransactionsYr2DB['TxDate'];
              Accsdatamodule.TempVATDB['PreviousYear'] := '#';


              try DoubleToStr ((Accsdatamodule.TransactionsYr2DB['Amount']+Accsdatamodule.TransactionsYr2DB['TaxDisc']),st,'%8.2f', true, false, 20, True);
              except st := '0.00'
              end;
              slimleft (st);
              Accsdatamodule.TempVATDB['Account'] := 'Inv Total : ' + st;
              Accsdatamodule.TempVATDB.post;
              if AccsDatamodule.VATReportInvoiceQuery['InvoiceID'] <> 0 then InvoiceBreakdownYr2(AccsDatamodule.VATReportInvoiceQuery['InvoiceID'], PaymentTotal, PaymentVAT);

          end else begin
                if AccsDatamodule.VATReportInvoiceQuery['InvoiceID'] <> 0 then begin
                        Accsdatamodule.TransactionsYr1DB.open;
                        Accsdatamodule.TransactionsYr1DB.Locate('TxNo',AccsDatamodule.VATReportInvoiceQuery['InvoiceID'],[]);
                        Accsdatamodule.TempVATDB['Reference'] := Accsdatamodule.TransactionsYr1DB['Reference'];
                        Accsdatamodule.TempVATDB['Description'] := Accsdatamodule.TransactionsYr1DB['Descript'];
                        Accsdatamodule.TempVATDB['TxDate'] := Accsdatamodule.TransactionsYr1DB['TxDate'];
                        Accsdatamodule.TempVATDB['PreviousYear'] := '*';

                        try DoubleToStr ((Accsdatamodule.TransactionsYr1DB['Amount']+Accsdatamodule.TransactionsYr1DB['TaxDisc']),st,'%8.2f', true, false, 20, True);
                        except st := '0.00'
                        end;
                        slimleft (st);
                        Accsdatamodule.TempVATDB['Account'] := 'Inv Total : ' + st;

                end else begin
                               Accsdatamodule.TempVATDB['Description'] := 'Overpayment';
                    end;

                Accsdatamodule.TempVATDB.post;
                if AccsDatamodule.VATReportInvoiceQuery['InvoiceID'] <> 0 then InvoiceBreakdown(AccsDatamodule.VATReportInvoiceQuery['InvoiceID'], PaymentTotal, PaymentVAT, True);

          end;
          AccsDatamodule.VATReportInvoiceQuery.next;
      end;
          Accsdatamodule.TempVATDB.append;
          Accsdatamodule.TempVATDB.post;
end;


procedure InvoiceBreakdownYr2(TxID : integer; PaymentTotal, VATTotal : Real);
var
          InvoiceTotal, InvoiceVATTotal, Multiplier : Real;
          Stop : Boolean;
          InvoiceType, j : Integer;
          st, TaxCode, Desc : shortstring;
begin

       for j:= 0 to 9 do Begin
               TempArray[j].Total := 0;
               TempArray[j].VAT := 0;
       end;



          // Find transaction & get VAT details

          Accsdatamodule.TransactionsYr2DB.Locate('TxNo',TxID,[]);
          InvoiceTotal := Accsdatamodule.TransactionsYr2DB['Amount'] + Accsdatamodule.TransactionsYr2DB['TaxDisc'];
          InvoiceVATTotal := Accsdatamodule.TransactionsYr2DB['TaxDisc'];
          InvoiceType := Accsdatamodule.TransactionsYr2DB['TxType'];

          Multiplier := PaymentTotal / InvoiceTotal;

          Stop := False;
          While not Stop do begin
                  Accsdatamodule.TransactionsYr2DB.Next;
                  if ((Accsdatamodule.TransactionsYr2DB['TxType'] <> '9') and (Accsdatamodule.TransactionsYr2DB['TxType'] <> '0')) then Stop := True;
                  if ((Accsdatamodule.TransactionsYr2DB['TxType'] = '9') and (Accsdatamodule.TransactionsYr2DB['OrigType'] = InvoiceType)) then begin

                      Taxcode := '';                                                                                                                 // TGM AB 01/07/16
                      if not VarIsNull(Accsdatamodule.TransactionsYr2DB['TAXCode']) then Taxcode := Accsdatamodule.TransactionsYr2DB['TAXCode'];     // TGM AB 01/07/16
                      slimall(TaxCode);

                      for j := 0 to 9 do begin
                           if TempArray[j].Vatcode = TaxCode then begin
                                 TempArray[j].Total := TempArray[j].Total + Accsdatamodule.TransactionsYr2DB['TaxDisc'] + Accsdatamodule.TransactionsYr2DB['Amount'];
                                 TempArray[j].VAT := TempArray[j].VAT + Accsdatamodule.TransactionsYr2DB['TaxDisc']
                           end;
                      end;

                  end;
                  if Accsdatamodule.TransactionsYr2DB['TxNo'] = Accsdatamodule.TransactionsYr2DB.recordcount then Stop := True;     // TGM AB 23/06/17
          end;

          // Fill details onto form & into VAT array

          for j := 0 to 9 do begin
                if TempArray[j].Total <> 0 then begin

                             Accsdatamodule.TempVATDB.append;

                             try DoubleToStr ((TempArray[j].VAT * Multiplier),st,'%8.2f', true, false, 20, True);
                             except st := '0.00'
                             end;
                             slimleft (st);
                             Accsdatamodule.TempVATDB['VATBreakdown'] := st;

                             try DoubleToStr ((TempArray[j].Total * Multiplier),st,'%8.2f', true, false, 20, True);
                             except st := '0.00'
                             end;
                             slimleft (st);
                             Accsdatamodule.TempVATDB['TotalBreakdown'] := st;

                             Accsdatamodule.TempVATDB['CodeBreakdown'] := TempArray[j].Vatcode;
                             Accsdatamodule.TempVATDB['DescBreakdown'] := Desc;

                             Accsdatamodule.TempVATDB.post;

                end;
          end;

          for j:= 0 to 9 do Begin
               if TempArray[j].Total <> 0 then begin
                                  if InvoiceType = 1 then begin
                                          VatArray[j].SalesNet := VatArray[j].SalesNet + (TempArray[j].Total * Multiplier);
                                          VatArray[j].SalesVat := VatArray[j].SalesVat + (TempArray[j].VAT * Multiplier);
                                  end else begin
                                          VatArray[j].PurchNet := VatArray[j].PurchNet + (TempArray[j].Total * Multiplier);
                                          VatArray[j].PurchVat := VatArray[j].PurchVat + (TempArray[j].VAT * Multiplier);
                                  end;
               end;
          end;

end;

// Ch006(P) End


end.
