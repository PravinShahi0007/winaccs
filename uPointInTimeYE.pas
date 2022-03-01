unit uPointInTimeYE;

// 10/20 TGM AB Ch022 - new form to introduce Point In Time Year End

//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, dxBar, dxBarExtItems, ComCtrls, StdCtrls, Mask, RXCtrls,
  cxControls, cxContainer, cxEdit, cxGroupBox, ExtCtrls, Db, DBTables,
  Gauges, cxProgressBar, dxStatusBar, RXSpin, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar;

type
  TPointInTimeYEForm = class(TForm)
    BarManager: TdxBarManager;
    blbExit: TdxBarLargeButton;
    bbBankFileFormat: TdxBarButton;
    blbHelp: TdxBarLargeButton;
    dxBarButton1: TdxBarButton;
    blbAddLine: TdxBarLargeButton;
    blbRun: TdxBarLargeButton;
    dxBarSubItem1: TdxBarSubItem;
    gbYearEndChecks: TcxGroupBox;
    RxLabel1: TRxLabel;
    CheckBacked: TCheckBox;
    cxGroupBox1: TcxGroupBox;
    ArchiveCheck: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    CompanyEdit: TEdit;
    ArchiveEdit: TEdit;
    ActionList1: TActionList;
    actClose: TAction;
    actRun: TAction;
    ActHelp: TAction;
    YearEndQuery: TQuery;
    CurrentTxDB: TTable;
    NextTxDB: TTable;
    TempProductsDB: TTable;
    GroupBox1: TGroupBox;
    Label25: TLabel;
    Label4: TLabel;
    CopyBalanceCheck: TCheckBox;
    Label6: TLabel;
    FinancialEdit: TEdit;
    TickBoxHelpImage: TImage;
    ArchiveHelpBalloon: TImage;
    ProgressPanel: TPanel;
    ProgressBar: TcxProgressBar;
    Label3: TLabel;
    AllocationCFDB: TTable;
    Label5: TLabel;
    ArchiveYearSelect: TRxSpinEdit;
    ArchiveWarning: TRxLabel;
    Label7: TLabel;
    TxRangeLabel: TLabel;
    StatusBar: TdxStatusBar;
    RangeWarning: TRxLabel;
    YearEndDate: TcxDateEdit;
    procedure actCloseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actRunExecute(Sender: TObject);
    procedure CheckBackedClick(Sender: TObject);
    procedure ActHelpExecute(Sender: TObject);
    procedure SplitTransactions;
    procedure RunYearEnd;
    procedure AppendTransactions;
    procedure CorrectAllocationBefore;
    procedure CorrectAllocationAfter;
    procedure ArchiveHelpBalloonClick(Sender: TObject);
    procedure FixDiscountDates;
    procedure ArchiveYearSelectChange(Sender: TObject);
    procedure CalcFinancialYear;
    procedure CalcTxRange;
    procedure YearEndDatePropertiesCloseUp(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  PointInTimeYEForm: TPointInTimeYEForm;
  AllocationData : Boolean;
  TxStartYear, TxEndYear : Integer;
  FirstOpenComplete : Boolean;

implementation

uses Chkcomp, vars, params, calcs, AccsData, printers, Uyearend, MAINUNIT, FullAudit, TxWrite, FileCtrl, DefSecFl;

{$R *.DFM}


procedure TPointInTimeYEForm.CalcFinancialYear;
var
        myYear, myMonth, myDay : Word;
begin
        DecodeDate(StrtoDate(YearEndDate.text), myYear, myMonth, myDay);

        if myMonth = 12 then ArchiveYearSelect.Value := myYear           // if year end finishes in December then financial year start is current year otherwise it's previous year
               else  ArchiveYearSelect.Value := myYear -1;

end;


procedure TPointInTimeYEForm.CalcTxRange;
var
        MyQuery : TQuery;
        myYear, myMonth, myDay : Word;
begin

               TxStartYear  := 0;
               TxEndYear    := 0;

               MyQuery := TQuery.create(self);
               Myquery.DatabaseName := accsdatamodule.AccsDataBase.databasename;
               MyQuery.SQL.clear;
               MyQuery.SQL.add ('select txdate from transactions where TxNo >= ' + vartostr(xFirstTx) + 'group by txdate');
               MyQuery.open;

               if MyQuery.recordcount > 0 then begin

                MyQuery.First;
                DecodeDate((MyQuery['TxDate']), myYear, myMonth, myDay);
                TxStartYear  := myYear;

                MyQuery.Last;
                DecodeDate((MyQuery['TxDate']), myYear, myMonth, myDay);
                TxEndYear  := myYear;


               end;

               MyQuery.close;
               MyQuery.free;

               TxRangeLabel.caption := Vartostr(TxStartYear) + ' to ' + Vartostr(TxEndYear);

end;



procedure TPointInTimeYEForm.actCloseExecute(Sender: TObject);
begin
        close;
        PointInTimeYEForm := nil;
end;

procedure TPointInTimeYEForm.FormCreate(Sender: TObject);
var
        St, NewDir : String;
        FinStart, FinEnd : Integer;
        YearEnd : Shortstring;

begin


   CheckBacked.Checked := False;
   ArchiveCheck.Checked := True;
   CopyBalanceCheck.Checked := False;

   blbRun.Enabled := False;

   CompanyEdit.Text := FCheckName.CheckCompanyName.Text;
   FinancialEdit.Text := IntToStr ( Cash1.XFINYEAR+1 );

   NewDir := RFarmGate.pLocation[2];
   { chop the new_dir down to 3 characters }
   while length ( NewDir ) > 3 do
     delete ( NewDir, length ( NewDir ), 1 );

   { concat the current year onto new_dir }
   Str ( Cash1.xfinyear, st );
   ArchiveEdit.Text := NewDir + St;
   CopybalanceCheck.Checked := Cash1.xCopyBal;

   // Enter Normal Year End Date
   GetFinDateRange ( FinStart, FinEnd );
   YearEnd := '';
   KDateToStr ( FinEnd, YearEnd );
   YearEndDate.Text := YearEnd;

   CalcTxRange;

   CalcFinancialYear;


   ProgressPanel.visible := False;


end;

procedure TPointInTimeYEForm.actRunExecute(Sender: TObject);
var
        TxCount : Integer;
begin

        if ((ArchiveCheck.Checked) and (DirectoryExists('C:\Kingsacc\' + ArchiveEdit.Text))) then begin
            Showmessage('An Archive Folder with this name already exists - Please Specify Another Folder!');
            Exit;
        end;

        if (RangeWarning.Visible) then begin
            Showmessage('Archive Folder Year is outside Data Transaction Date Range - Please Specify Correct Archive Year!');
            Exit;
        end;

        ProgressPanel.visible := True;
        ProgressBar.Position := 0;
        ProgressBar.Properties.Max := 9;

        AllocationData := False;

        if (cash2.xAllocation or cash2.XPaymentVAT) then AllocationData := True;

    // Set correct Finanical Year

        Cash1.XFinYear := strtoint(ArchiveYearSelect.text);
        DefWrite(0);


   // Data Integrity Check Macro

        StatusBar.Panels.Items[0].Text := 'Step 1 - Data Integrity Check';
        StatusBar.Panels.Items[1].Text := '';
        Application.ProcessMessages;

        Auditfiles.OnShow(self);
        Auditfiles.OnActivate(self);
        AuditFiles.SuppressPrompts := true;
        Auditfiles.checkbtnClick(self);

        If AuditFiles.DataIntegrityFail = true then begin
            Showmessage('Data Integrity Tests indicates problem with your data. Please Contact Kingswood For Help');
            AuditFiles.SuppressPrompts := false;
            Exit;
        end;

        AuditFiles.SuppressPrompts := false;
        ProgressBar.Position := ProgressBar.Position + 1;

   // Sets the Correct Path for Archive Data

        YearEndForm.ArchiveEdit.Text := ArchiveEdit.Text;

   // Take Archive Zip File

        StatusBar.Panels.Items[0].Text := 'Step 2 - Data Archive Point';
        StatusBar.Panels.Items[1].Text := '';
        Application.ProcessMessages;

        ChkComp.AutomatedBackup;
        ProgressBar.Position := ProgressBar.Position + 1;

   // This Section removes the data that falls outside the year date range, corrects links to productsTx table & updates allocation table as required

        StatusBar.Panels.Items[0].Text := 'Step 3 - Split Transactions from Current Year';
        StatusBar.Panels.Items[1].Text := '';
        Application.ProcessMessages;

        SplitTransactions;

        ProgressBar.Position := ProgressBar.Position + 1;

    //    showmessage('Transactions Split');

   // This Section does a pointer reset & updates SL, PL  & NL Balances

        // First Reset Pointers to 1

        StatusBar.Panels.Items[0].Text := 'Step 4 - Pointer Reset & Updating Year End Balances in Current Year';
        StatusBar.Panels.Items[1].Text := '';
        Application.ProcessMessages;

        Auditfiles.OnShow(self);
        Auditfiles.OnActivate(self);

        AuditFiles.SuppressPrompts := true;

        Auditfiles.PassMask.Text := 'config';
        Auditfiles.ResetSales.Checked := True;
        Auditfiles.ResetPurchase.Checked := True;
        Auditfiles.ResetNominal.Checked := True;
        Auditfiles.ResetFirstGroup.ItemIndex := 1;
        Auditfiles.LowestTx.text := '1';
        Auditfiles.ConfirmBtnClick(self);

        // Reset pointers to correct First Tx

        Auditfiles.OnShow(self);
        Auditfiles.OnActivate(self);

        AuditFiles.SuppressPrompts := true;

        Auditfiles.PassMask.Text := 'config';
        Auditfiles.ResetSales.Checked := True;
        Auditfiles.ResetPurchase.Checked := True;
        Auditfiles.ResetNominal.Checked := True;
        Auditfiles.ResetFirstGroup.ItemIndex := 1;
        Auditfiles.LowestTx.text := vartostr(xFirstTx);
        Auditfiles.ConfirmBtnClick(self);

        ProgressBar.Position := ProgressBar.Position + 1;

        AuditFiles.SuppressPrompts := false;

        // Repair Balances

        Auditfiles.OnShow(self);
        Auditfiles.OnActivate(self);

        AuditFiles.SuppressPrompts := true;

        Auditfiles.PassMask.Text := 'config';

        Auditfiles.nominalbtnClick(self);
        Auditfiles.salesbtnClick(self);
        Auditfiles.purchasebtnClick(self);

        Auditfiles.PassMask.Text := '';

        ProgressBar.Position := ProgressBar.Position + 1;

        AuditFiles.SuppressPrompts := false;

   // This Section runs the year end routine as normal on the adjusted data

        StatusBar.Panels.Items[0].Text := 'Step 5 - Completing Year End';
        StatusBar.Panels.Items[1].Text := '';
        Application.ProcessMessages;

        RunYearEnd;

        ProgressBar.Position := ProgressBar.Position + 1;

   // This section puts the extra data onto the end of the new year data & updates balances etc

        StatusBar.Panels.Items[0].Text := 'Step 6 - Appending Carry Forward Transactions onto New Year';
        StatusBar.Panels.Items[1].Text := '';
        Application.ProcessMessages;

        AppendTransactions;

        ProgressBar.Position := ProgressBar.Position + 1;


     //   showmessage('Transactions Appended to new year');


   // Fix balances etc and update front grid

        StatusBar.Panels.Items[0].Text := 'Step 7 - Pointer Reset & Updating Balances in Current Year';
        StatusBar.Panels.Items[1].Text := '';
        Application.ProcessMessages;

     //   TxWrite.ResetPointers ( nil );
        Auditfiles.OnShow(self);
        Auditfiles.OnActivate(self);

        AuditFiles.SuppressPrompts := true;

        Auditfiles.PassMask.Text := 'config';
        Auditfiles.ResetSales.Checked := True;
        Auditfiles.ResetPurchase.Checked := True;
        Auditfiles.ResetNominal.Checked := True;

        Auditfiles.ResetFirstGroup.ItemIndex := 1;
        Auditfiles.LowestTx.text := vartostr(xFirstTx);

        Auditfiles.ConfirmBtnClick(self);

        AuditFiles.SuppressPrompts := false;

        Auditfiles.OnShow(self);
        Auditfiles.OnActivate(self);

        AuditFiles.SuppressPrompts := true;

        Auditfiles.PassMask.Text := 'config';

        Auditfiles.nominalbtnClick(self);
        Auditfiles.salesbtnClick(self);
        Auditfiles.purchasebtnClick(self);
        Auditfiles.PassMask.Text := '';

        ProgressBar.Position := ProgressBar.Position + 1;

        AuditFiles.SuppressPrompts := false;

        StatusBar.Panels.Items[0].Text := 'Step 8 - Updating Front Grid';
        StatusBar.Panels.Items[1].Text := '';
        Application.ProcessMessages;

        FMainscreen.LoadTransactionGrid;

        ProgressBar.Position := ProgressBar.Position + 1;


   // Remove Temp Files

        if fileexists('c:\Kingsacc\TransactionsCurrent.db') then deletefile('c:\Kingsacc\TransactionsCurrent.db');
        if fileexists('c:\Kingsacc\TransactionsNext.db') then deletefile('c:\Kingsacc\TransactionsNext.db');
        if fileexists('C:\Kingsacc\ProductsTx.db') then DeleteFile(pchar('C:\Kingsacc\ProductsTx.db'));




        StatusBar.Panels.Items[0].Text := 'Step 9 - Data Integrity Check';
        StatusBar.Panels.Items[1].Text := '';
        Application.ProcessMessages;

        Auditfiles.OnShow(self);
        Auditfiles.OnActivate(self);
        AuditFiles.SuppressPrompts := true;
        Auditfiles.checkbtnClick(self);

        AuditFiles.SuppressPrompts := false;
        ProgressBar.Position := ProgressBar.Position + 1;



        If AuditFiles.DataIntegrityFail = true then begin
            Showmessage('Data Integrity Tests indicates problem with your data. Please Contact Kingswood For Help');
            AuditFiles.SuppressPrompts := false;
            Exit;
        end
            else begin
                        StatusBar.Panels.Items[0].Text := 'Year end Complete';
                        StatusBar.Panels.Items[1].Text := '';
                        Application.ProcessMessages;
                        showmessage('Point In Time Year End Complete');

                        ProgressBar.Position := 0;
                        ProgressPanel.visible := False;

                        PointInTimeYEForm.Close;

                end;


end;





procedure TPointInTimeYEForm.CheckBackedClick(Sender: TObject);
begin
         blbRun.Enabled := ( CheckBacked.Checked );
end;

procedure TPointInTimeYEForm.ActHelpExecute(Sender: TObject);
begin
        AccsDataModule.HTMLHelp('yearEnd.htm');
end;

procedure TPointInTimeYEForm.SplitTransactions;
var
   i: integer;
   MyTable : TTable;
   ProdsTxNo, TransTxNo : Integer;
   MyQuery : TQuery;

begin

        StatusBar.Panels.Items[1].Text := 'Checking Transaction Dates';
        Application.ProcessMessages;

        FixDiscountDates;

        StatusBar.Panels.Items[1].Text := 'Creating Temp Tables';
        Application.ProcessMessages;

        if fileexists('c:\Kingsacc\TransactionsCurrent.db') then deletefile('c:\Kingsacc\TransactionsCurrent.db');
        if fileexists('c:\Kingsacc\TransactionsNext.db') then deletefile('c:\Kingsacc\TransactionsNext.db');
        if fileexists('C:\Kingsacc\ProductsTx.db') then DeleteFile(pchar('C:\Kingsacc\ProductsTx.db'));


        AccsDataModule.TransactionsDB.open;


        MyTable := TTable.Create(nil);
        MyTable.DatabaseName := 'c:\Kingsacc';

        with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'TransactionsCurrent.db';
            FieldDefs := AccsDataModule.TransactionsDB.fielddefs;
            IndexDefs := AccsDataModule.TransactionsDB.indexdefs;
            FieldDefs.Add('SplitPreviousID',ftInteger,0,FALSE);
            CreateTable;
        end;
        MyTable.free;




        MyTable := TTable.Create(nil);
        MyTable.DatabaseName := 'c:\Kingsacc';


        with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'TransactionsNext.db';
            FieldDefs := AccsDataModule.TransactionsDB.fielddefs;
            IndexDefs := AccsDataModule.TransactionsDB.indexdefs;
            FieldDefs.Add('SplitPreviousID',ftInteger,0,FALSE);
            CreateTable;
        end;
         MyTable.free;

        CurrentTxDB.DatabaseName := 'C:\Kingsacc';
        CurrentTxDB.open;

        NextTxDB.DatabaseName := 'C:\Kingsacc';
        NextTxDB.open;

        TempProductsDB.DatabaseName := 'C:\Kingsacc';

        StatusBar.Panels.Items[1].Text := 'Splitting Transactions';
        Application.ProcessMessages;


        AccsDataModule.TransactionsDB.first;
        while not AccsDataModule.TransactionsDB.eof do begin
                if AccsDataModule.TransactionsDB['TxDate'] <=  strtodate(YearEndDate.Text) then begin
                   CurrentTxDB.append;
                   for i := 1 to AccsDataModule.TransactionsDB.FieldCount-1 do
                        CurrentTxDB.Fields[i].AsVariant := AccsDataModule.TransactionsDB.Fields[i].AsVariant;

                   CurrentTxDB['SplitPreviousID'] := AccsDataModule.TransactionsDB['TxNo'];
                   CurrentTxDB.post;

                end
                else begin
                   NextTxDB.append;
                   for i := 1 to AccsDataModule.TransactionsDB.FieldCount-1 do
                        NextTxDB.Fields[i].AsVariant := AccsDataModule.TransactionsDB.Fields[i].AsVariant;

                   NextTxDB['SplitPreviousID'] := AccsDataModule.TransactionsDB['TxNo'];
                   NextTxDB.post;
                end;

                AccsDataModule.TransactionsDB.next;
        end;


        CurrentTxDB.close;
        NextTxDB.close;

        // Copy ProductsTx File

        CopyFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'ProductsTx.db'),pchar('C:\Kingsacc\ProductsTx.db'),false);



        // Delete old Tx Files and copy sorted file in

        AccsDataModule.TransactionsDB.close;
        if fileexists(Accsdatamodule.AccsDataBase.Directory + 'Transactions.db') then deletefile(Accsdatamodule.AccsDataBase.Directory + 'Transactions.db');
        if fileexists(Accsdatamodule.AccsDataBase.Directory + 'Transactions.px') then deletefile(Accsdatamodule.AccsDataBase.Directory + 'Transactions.px');
        if fileexists(Accsdatamodule.AccsDataBase.Directory + 'Transactions.XG0') then deletefile(Accsdatamodule.AccsDataBase.Directory + 'Transactions.XG0');
        if fileexists(Accsdatamodule.AccsDataBase.Directory + 'Transactions.YG0') then deletefile(Accsdatamodule.AccsDataBase.Directory + 'Transactions.YG0');

        copyfile(pchar('c:\Kingsacc\TransactionsCurrent.db'),pchar(Accsdatamodule.AccsDataBase.Directory + 'Transactions.db'),FALSE);

        AccsDataModule.TransactionsDB.open;


        // Correct the links in the ProductsTx file.

        StatusBar.Panels.Items[1].Text := 'Updating Product Links';
        Application.ProcessMessages;

        ProdsTxNo := 0;
        TransTxNo := 0;

        AccsDatamodule.ProdsTx.open;

        AccsDatamodule.ProdsTx.First;

        while not AccsDatamodule.ProdsTx.eof do begin

                ProdsTxNo := AccsDatamodule.ProdsTx['TxNo'];


                if ProdsTxNo <> 0 then begin        // Valid Record

                     try accsdatamodule.TransactionsDB.locate('SplitPreviousID',ProdsTxNo,[]);

                         TransTxNo := accsdatamodule.TransactionsDB['TxNo'];

                         if accsdatamodule.TransactionsDB['SplitPreviousID'] = ProdsTxNo then begin             // In Current Year

                               AccsDatamodule.ProdsTX.edit;
                               AccsDatamodule.ProdsTx['TxNo'] := TransTxNo;
                               AccsDatamodule.ProdsTx.post;

                   //            showmessage('Tx No' + vartostr(TransTxNo) + ' : SplitPreviousID ' + vartostr(ProdsTxNo));


                         end else begin                                                                         // Not in current year

                                AccsDatamodule.ProdsTX.edit;
                                AccsDatamodule.ProdsTx['TxNo'] := 0;
                                AccsDatamodule.ProdsTx.post;

                         end;

                     except

                     end;


                end;



                AccsDatamodule.ProdsTx.Next;
        end;

        // Check & update allocation links as required

        if AllocationData then begin

                StatusBar.Panels.Items[1].Text := 'Updating Allocation Links';
                Application.ProcessMessages;

                CorrectAllocationBefore;

        end;


        // Remove SplitPreviousID from Transactions table

        AccsDataModule.TransactionsDB.close;

        MyQuery := TQuery.create(self);
        Myquery.DatabaseName := accsdatamodule.AccsDataBase.databasename;

        // need to recreate missing VAT index before removing the extra field

        MyQuery.sql.clear;
        MyQuery.sql.Add('CREATE INDEX ByTaxCode ON Transactions (TaxCode)');
        MyQuery.ExecSQL;

        MyQuery.sql.clear;
        MyQuery.sql.text:='ALTER TABLE Transactions DROP SplitPreviousID';
        MyQuery.ExecSQL;

        MyQuery.close;
        MyQuery.free;

        AccsDataModule.TransactionsDB.open;

end;

procedure TPointInTimeYEForm.RunYearEnd;
begin
    // run existing yearend

        YearEndForm.CheckBacked.Checked := true;

        if Archivecheck.checked then YearEndForm.ArchiveCheck.Checked := true
                else YearEndForm.ArchiveCheck.Checked := false;

        if CopyBalanceCheck.checked then YearEndForm.CopyBalanceCheck.Checked := true
                else YearEndForm.CopyBalanceCheck.Checked := false;

        YearEndForm.RunButtonClick(PointInTimeYEForm);

end;


procedure TPointInTimeYEForm.AppendTransactions;
var
        i : Integer;
        MyQuery : TQuery;
        ProdsTxNo, TransTxNo : integer;
begin

   // append transactions to the end of the new year

        StatusBar.Panels.Items[1].Text := 'Appending Transactions';
        Application.ProcessMessages;


        AccsDataModule.TransactionsDB.close;

        MyQuery := TQuery.create(self);
        Myquery.DatabaseName := accsdatamodule.AccsDataBase.databasename;


        MyQuery.sql.clear;
        MyQuery.sql.text:='ALTER TABLE Transactions ADD SplitPreviousID Integer';
        MyQuery.ExecSQL;

        MyQuery.close;
        MyQuery.free;

   //     Copy records from temp table back into transactions table

        AccsDataModule.TransactionsDB.open;
        AccsDataModule.TransactionsDB.Last;

        NextTxDB.open;
        NextTxDB.first;

        while not NextTxDB.eof do begin

                   AccsDataModule.TransactionsDB.append;
                   for i := 1 to AccsDataModule.TransactionsDB.FieldCount-1 do
                        AccsDataModule.TransactionsDB.Fields[i].AsVariant := NextTxDB.Fields[i].AsVariant;

                   AccsDataModule.TransactionsDB.post;

        NextTxDB.next;

        end;

        NextTxDB.close;


   // Copy in any Products Lines into new year data

        StatusBar.Panels.Items[1].Text := 'Updating Product Links';
        Application.ProcessMessages;

        TempProductsDB.DatabaseName := 'C:\Kingsacc';
        TempProductsDB.Open;

         while not TempProductsDB.eof do begin

                ProdsTxNo := TempProductsDB['TxNo'];


                if ProdsTxNo <> 0 then begin        // Valid Record

                     try accsdatamodule.TransactionsDB.locate('SplitPreviousID',ProdsTxNo,[]);

                         TransTxNo := accsdatamodule.TransactionsDB['TxNo'];

                         if accsdatamodule.TransactionsDB['SplitPreviousID'] = ProdsTxNo then begin             // In Current Year

                               AccsDatamodule.ProdsTX.open;
                               AccsDatamodule.ProdsTX.append;

                               for i := 1 to AccsDataModule.ProdsTX.FieldCount-1 do
                                        AccsDataModule.ProdsTX.Fields[i].AsVariant := TempProductsDB.Fields[i].AsVariant;

                               AccsDatamodule.ProdsTx['TxNo'] := TransTxNo;

                               AccsDatamodule.ProdsTx.post;

                         end;

                     except

                     end;

                end;

                TempProductsDB.Next;

        end;

    // Check & update allocation links as required

        if AllocationData then begin

                StatusBar.Panels.Items[1].Text := 'Updating Allocation Links';
                Application.ProcessMessages;

                CorrectAllocationAfter;

        end;




   // Remove SplitPreviousID from Transactions table

        AccsDataModule.TransactionsDB.close;

        MyQuery := TQuery.create(self);
        Myquery.DatabaseName := accsdatamodule.AccsDataBase.databasename;

        // need to recreate missing VAT index before removing the extra field

        MyQuery.sql.clear;
        MyQuery.sql.text:='ALTER TABLE Transactions DROP SplitPreviousID';
        MyQuery.ExecSQL;

        MyQuery.close;
        MyQuery.free;

        AccsDataModule.TransactionsDB.open;

end;

procedure TPointInTimeYEForm.CorrectAllocationBefore;
var
        MyTable : TTable;
        i,j : integer;
        PaymentID : integer;
        InvoiceID : integer;
begin

        // Need to copy table before editing

        if fileexists('c:\Kingsacc\AllocatedVAT.db') then deletefile('c:\Kingsacc\AllocatedVAT.db');

        CopyFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'AllocatedVAT.db'),pchar('C:\Kingsacc\AllocatedVAT.db'),false);

        // Create a blank table to copy records for next year into

        MyTable := TTable.Create(nil);
        MyTable.DatabaseName := 'c:\Kingsacc';

        with MyTable do
         begin
            FieldDefs.Clear;
            IndexDefs.Clear;
            TableName := 'AllocationCarryForward.db';
            FieldDefs := AccsDataModule.AllocatedVATDB.fielddefs;
            IndexDefs := AccsDataModule.AllocatedVATDB.indexdefs;
            CreateTable;
        end;
        MyTable.free;

        AllocationCFDB.DatabaseName := 'C:\Kingsacc';
        AllocationCFDB.open;

        // Update Allocation Table to correct for changes in the TxNo's

        AccsDataModule.AllocatedVATDB.open;
        AccsDataModule.AllocatedVATDB.First;

        for i := 1 to AccsDataModule.AllocatedVATDB.RecordCount do begin

                if AccsDataModule.AllocatedVATDB['PaymentID'] = 0 then begin

                        AccsDataModule.AllocatedVATDB.edit;
                        AccsDataModule.AllocatedVATDB['PaymentID'] := 0;
                        AccsDataModule.AllocatedVATDB['InvoiceID'] := 0;
                        AccsDataModule.AllocatedVATDB.post;

                end;   // =0

                if AccsDataModule.AllocatedVATDB['PaymentID'] <> 0 then begin

                      PaymentID := AccsDataModule.AllocatedVATDB['PaymentID'];

                      try accsdatamodule.TransactionsDB.locate('SplitPreviousID',PaymentID,[]);

                           if accsdatamodule.TransactionsDB['SplitPreviousID'] = PaymentID then begin

                              // update Allocation Table PaymentID

                                  AccsDataModule.AllocatedVATDB.edit;
                                  AccsDataModule.AllocatedVATDB['PaymentID'] := Accsdatamodule.TransactionsDB['TxNo'];
                                  AccsDataModule.AllocatedVATDB.post;

                              // check Invoice ID

                              if AccsDataModule.AllocatedVATDB['PreviousYear'] <> True then begin

                                  InvoiceID := AccsDataModule.AllocatedVATDB['InvoiceID'];

                                  accsdatamodule.TransactionsDB.locate('SplitPreviousID',InvoiceID,[]);

                                  if accsdatamodule.TransactionsDB['SplitPreviousID'] = InvoiceID then begin

                                        AccsDataModule.AllocatedVATDB.edit;
                                        AccsDataModule.AllocatedVATDB['InvoiceID'] := Accsdatamodule.TransactionsDB['TxNo'];
                                        AccsDataModule.AllocatedVATDB.post;

                                  end else begin

                                                AccsDataModule.AllocatedVATDB.edit;
                                                AccsDataModule.AllocatedVATDB['InvoiceID'] := '999999';
                                                AccsDataModule.AllocatedVATDB.post;

                                           end;

                              end;

                           end
                                else begin

                                   // belongs in new year so copy into AllocationCarryForward table

                                      AllocationCFDB.append;

                                      for j := 0 to AccsDataModule.AllocatedVATDB.FieldCount-1 do
                                        AllocationCFDB.Fields[j].AsVariant :=  AccsDataModule.AllocatedVATDB.Fields[j].AsVariant;

                                      AllocationCFDB.post;

                                   // zeroise out the line in curret year

                                      AccsDataModule.AllocatedVATDB.edit;
                                      AccsDataModule.AllocatedVATDB['PaymentID'] := '0';
                                      AccsDataModule.AllocatedVATDB.post;

                                end;


                      except

                      end;


                end; // <> 0

                AccsDataModule.AllocatedVATDB.Next;

        end;  // for i :=


        AllocationCFDB.close;
        AccsDataModule.AllocatedVATDB.close;

end;


procedure TPointInTimeYEForm.CorrectAllocationAfter;
var
        MyTable : TTable;
        i,j : integer;
        PaymentID, NewPaymentID : integer;
        InvoiceID, NewInvoiceID : integer;
        PreviousYear : Boolean;
        InvoiceFound : Boolean;
begin

        CurrentTxDB.Open;


        AllocationCFDB.open;
        AllocationCFDB.first;

        for i := 1 to AllocationCFDB.RecordCount do begin

            PaymentID := 0;
            InvoiceID := 0;

            NewPaymentID := 0;
            NewInvoiceID := 0;

            PreviousYear := False;
            InvoiceFound := False;



            if AllocationCFDB['PaymentID'] <> 0 then begin

                      PaymentID := AllocationCFDB['PaymentID'];
                      InvoiceID := AllocationCFDB['InvoiceID'];


                      try accsdatamodule.TransactionsDB.locate('SplitPreviousID',PaymentID,[]);

                           if accsdatamodule.TransactionsDB['SplitPreviousID'] = PaymentID then begin

                               NewPaymentID :=  accsdatamodule.TransactionsDB['TxNo'];

                           end else  NewPaymentID := 9999999;

                      except
                      end;

                      try accsdatamodule.TransactionsDB.locate('SplitPreviousID',InvoiceID,[]);

                           if accsdatamodule.TransactionsDB['SplitPreviousID'] = InvoiceID then begin

                               NewInvoiceID :=  accsdatamodule.TransactionsDB['TxNo'];
                               InvoiceFound := true;

                           end;

                      except
                      end;

                      if not InvoiceFound then begin

                        try CurrentTxDB.locate('SplitPreviousID',InvoiceID,[]);

                           if CurrentTxDB['SplitPreviousID'] = InvoiceID then begin

                               NewInvoiceID := CurrentTxDB['TxNo'];
                               InvoiceFound := true;
                               PreviousYear := True;

                           end;

                        except
                        end;

                      end;

                      if not InvoiceFound then NewInvoiceID := 9999999;



                      AccsDataModule.AllocatedVATDB.append;

                            for j := 0 to AllocationCFDB.FieldCount-1 do
                                   AccsDataModule.AllocatedVATDB.Fields[j].AsVariant :=  AllocationCFDB.Fields[j].AsVariant;

                      AccsDataModule.AllocatedVATDB['InvoiceID'] := NewInvoiceID;
                      AccsDataModule.AllocatedVATDB['PaymentID'] := NewPaymentID;

                      If PreviousYear then AccsDataModule.AllocatedVATDB['PreviousYear'] := True;

                      AccsDataModule.AllocatedVATDB.post;


            end;  // <> 0

            AllocationCFDB.next;

        end;    // recordcount

        AllocationCFDB.close;
        CurrentTxDB.Open;

end;



procedure TPointInTimeYEForm.ArchiveHelpBalloonClick(Sender: TObject);
begin

        MessageDlg('An Archive of your data is a backup on your hard disk.  It is strongly recommended that you allow the program to create an archive.', mtInformation,[mbOk], 0);

end;


procedure TPointInTimeYEForm.FixDiscountDates;
var txtype : integer;
    txDate : TDateTime;
begin

        // if a type 9 follows a type 6, the type 9 should be same date as the type 6

        accsdatamodule.TransactionsDB.first;
        txType := accsdatamodule.TransactionsDB['TxType'];
        txDate := accsdatamodule.TransactionsDB['TxDate'];
        accsdatamodule.TransactionsDB.next;
        while not accsdatamodule.TransactionsDB.eof do begin
                   if ((txType = 6) and (accsdatamodule.TransactionsDB['TxType'] = 9) and (accsdatamodule.TransactionsDB['origtype'] = 6)) then begin
                        if accsdatamodule.TransactionsDB['TxDate'] <> txDate then begin
                                accsdatamodule.TransactionsDB.edit;
                                accsdatamodule.TransactionsDB['TxDate'] := txdate;
                                accsdatamodule.TransactionsDB.post;
                        end;
                   end;
                   txType := accsdatamodule.TransactionsDB['TxType'];
                   txDate := accsdatamodule.TransactionsDB['TxDate'];
                   accsdatamodule.TransactionsDB.next;
        end;

        // if a type 9 follows a type 2, the type 9 should be same date as the type 2

        accsdatamodule.TransactionsDB.first;
        txType := accsdatamodule.TransactionsDB['TxType'];
        txDate := accsdatamodule.TransactionsDB['TxDate'];
        accsdatamodule.TransactionsDB.next;
        while not accsdatamodule.TransactionsDB.eof do begin
                   if ((txType = 2) and (accsdatamodule.TransactionsDB['TxType'] = 9) and (accsdatamodule.TransactionsDB['origtype'] = 2)) then begin
                        if accsdatamodule.TransactionsDB['TxDate'] <> txDate then begin
                                accsdatamodule.TransactionsDB.edit;
                                accsdatamodule.TransactionsDB['TxDate'] := txdate;
                                accsdatamodule.TransactionsDB.post;
                        end;
                   end;
                   txType := accsdatamodule.TransactionsDB['TxType'];
                   txDate := accsdatamodule.TransactionsDB['TxDate'];
                   accsdatamodule.TransactionsDB.next;
        end;


end;



procedure TPointInTimeYEForm.ArchiveYearSelectChange(Sender: TObject);
Var
      TempString : String;
begin

      TempString := Copy(ArchiveEdit.text,0,3);

      ArchiveEdit.text := Tempstring + ArchiveYearSelect.Text;

      // Set year end to match selected Financial Year

      if FirstOpenComplete then begin

        if Cash1.XFINMonth = 1 then begin

                YearEndDate.text := Copy(YearEndDate.text,0,6) + Copy(ArchiveYearSelect.Text,3,2);


        end else begin

                YearEndDate.text := Copy(YearEndDate.text,0,6) + Copy((VarToStr(StrToInt(ArchiveYearSelect.Text)+1)),3,2);


                end;
      end;

      FirstOpenComplete := True;

      if DirectoryExists('C:\Kingsacc\' + ArchiveEdit.Text) then ArchiveWarning.Visible := True
                else ArchiveWarning.Visible := False;

      if ((ArchiveYearSelect.AsInteger <  TxStartYear) or  (ArchiveYearSelect.AsInteger > TxEndYear))then RangeWarning.Visible := True
                else RangeWarning.Visible := False;

end;

procedure TPointInTimeYEForm.YearEndDatePropertiesCloseUp(Sender: TObject);
begin
        CalcFinancialYear;
end;

end.
