{
   14/11/16 [V4.2 R4.4] /MK Bug Fix - CheckFlags - Run button should only be enabled where the user ticks CheckBacked.
                                    - RunButtonClick - CheckArchive, i.e. creation of new folder, should only be ran if user clicks on Run and ArchiveCheck is ticked.

   21/05/18 [V4.3 R0.9] /MK Change - Make the warning to take a backup on to a memory key more prominent - Monika/AB.

   13/03/20 [V4.5 R1.9] /AB Bug Fix - Fixed bug where year end doesn't delete old carried forward files (e.g. SLFile-1)
                                      so they could be overwritten with correct versions causing issues with some spanning reports - Ch021

   20/12/21 [V6.0 R3.3] /AB Change - Added change Ch033 - see ABChangeRegister.
}

unit Uyearend;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Grids{, VBXCtrl},
  Gauges, ComCtrls, RXCtrls, cxButtons, cxControls, cxContainer, cxEdit,
  cxGroupBox;

type
  TYearEndForm = class(TForm)
    GroupBox1: TGroupBox;
    ClearCapitolCheck: TCheckBox;
    StandardExitPanel: TPanel;
    Help: TBitBtn;
    ExitButton: TBitBtn;
    RunButton: TBitBtn;
    ProfitLossEdit: TEdit;
    FinancialEdit: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    CopyBalanceCheck: TCheckBox;
    FinalEndCheck: TCheckBox;
    YearEndPanel: TPanel;
    YearEndGrid: TStringGrid;
    LivestockCheck: TCheckBox;
    Panel1: TPanel;
    Label1: TLabel;
    CompanyEdit: TEdit;
    ArchiveEdit: TEdit;
    Label2: TLabel;
    ArchiveCheck: TCheckBox;
    ProgressLabel: TLabel;
    ProgressBar: TGauge;
    YearStatusBar: TStatusBar;
    Label3: TLabel;
    btnSendDataToAccountant: TcxButton;
    gbYearEndChecks: TcxGroupBox;
    CheckBacked: TCheckBox;
    RxLabel1: TRxLabel;
    CheckPrinted: TCheckBox;
    procedure ExitButtonClick(Sender: TObject);
    procedure YearEndGridDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ClearCapitolCheckClick(Sender: TObject);
    procedure RunButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBackedClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure btnSendDataToAccountantClick(Sender: TObject);
    procedure CreateArchiveRecordFile;           // TGM AB 27/01/17
    procedure Button1Click(Sender: TObject);           // Ch022
    procedure CoOpPointerFix; // Ch033
  private
    { Private declarations }
    NewDirOk  : Boolean;
    procedure CheckFlags ( Sender : TObject );
    function CheckArchive : Boolean;
  public
    { Public declarations }
  end;

var
  YearEndForm: TYearEndForm;

implementation
uses
    params,
    YearArch,
    DBgen,
    Pickdate,
    Mainunit,
    ChkComp,
    Umonth,
    PYEnd,
    Clears,
    Calcs,
    UTIL,
    DBCore,
    types,
    vars, AccsData, CalculateMonths, DefSecFl, FullAudit, uDataBackup,
    uKingswoodAccountantController;            //Ch022;

{$R *.DFM}

procedure TYearEndForm.ExitButtonClick(Sender: TObject);
begin
   Close;
end;

procedure TYearEndForm.YearEndGridDblClick(Sender: TObject);
begin
   if ( YearEndGrid.Cells[2,YearEndGrid.Row] = 'Yes' ) then
      YearEndGrid.Cells[2,YearEndGrid.Row] := 'No'
   else
      YearEndGrid.Cells[2,YearEndGrid.Row] := 'Yes';
end;

procedure TYearEndForm.FormShow(Sender: TObject);
var
   St,
   NewDir : String;
begin
   CheckBacked.Checked := False;
   FinalEndCheck.Checked := False;
   ArchiveCheck.Checked := True;
   CopyBalanceCheck.Checked := False;
   ClearCapitolCheck.Checked := False;
   RunButton.Enabled := False;

   CompanyEdit.Text := FCheckName.CheckCompanyName.Text;
   FinancialEdit.Text := IntToStr ( Cash1.XFINYEAR+1 );
   YearEndGrid.Cells[0,0] := 'Code';
   YearEndGrid.Cells[1,0] := 'Name';
   YearEndGrid.Cells[2,0] := 'Zero Balance';
   YearEndGrid.Cells[2,1] := 'Balance Accounts';
   NewDirOk := False;
   YearEndGrid.Hide;
   YearEndPanel.Hide;
   ProgressBar.Hide;

   NewDir := RFarmGate.pLocation[2];
   { chop the new_dir down to 3 characters }
   while length ( NewDir ) > 3 do
     delete ( NewDir, length ( NewDir ), 1 );

   { concat the current year onto new_dir }
   Str ( Cash1.xfinyear, st );
   ArchiveEdit.Text := NewDir + St;
   CopybalanceCheck.Checked := Cash1.xCopyBal;
   ProgressLabel.Caption := '';
end;

procedure FillGridYearEnd;
var
   GridRow,
   RecCount : Integer;
begin
   SetDb ( NlFile );
   GridRow := 2;
   for RecCount := Cash1.xNomCaFrom to Cash1.xNomlito do
      begin
         ReadRec ( NlFile, RecCount );
         DbErr;
         if RecActive ( NlFile ) then
            begin
               YearEndForm.YearEndGrid.Cells[0,GridRow] := IntToStr ( RecCount );
               GetItem ( NlFile, 1 );
               YearEndForm.YearEndGrid.Cells[1,GridRow] := CurrStr;
               YearEndForm.YearEndGrid.Cells[2,GridRow] := 'No';
               Inc ( GridRow );
            end;
      end;
   YearEndForm.YearEndGrid.RowCount := GridRow;
end;

procedure TYearEndForm.ClearCapitolCheckClick(Sender: TObject);
begin
   CheckFlags(Sender);
   if ( ClearCapitolCheck.Checked ) then
      begin
         FillGridYearEnd;
         YearEndGrid.Show;
         YearEndPanel.Show;
      end
   else
      begin
         YearEndGrid.Hide;
         YearEndPanel.Hide;
      end;
end;

procedure TYearEndForm.RunButtonClick(Sender: TObject);
var
   YearInt : Integer;
   St,
   YearString : String;
   Proceed : Boolean;
   Recalculate : boolean;
begin
   Proceed := True;
   if ( not(CheckBacked.Checked) ) then  // TGM AB
      begin
         MessageDlg('You Must Back-Up and Print Your Data To Proceed.',mtInformation,[mbOK],0);
         ModalResult := mrNone;
         Proceed := False;
         YearEndForm.CheckBacked.SetFocus;
      end
   else
      Proceed := True;

   Recalculate := True;
   CalculateMonths.CalculateMonthlyValues;
   CalculateMonths.UpdateNLMonthlyFigures;

   if ( not(ArchiveCheck.Checked) ) then
      begin
         if ( MessageDlg('OK To Proceed Without Archiving Data ?',mtInformation,[mbYes,mbNo],0) = mrNo ) then
            begin
               ModalResult := mrNone;
               Proceed := False;
               YearEndForm.ArchiveCheck.SetFocus;
            end;
      end
   else
      begin
         //   14/11/16 [V4.2 R4.4] /MK Bug Fix - CheckArchive, i.e. creation of new folder, should only be ran if user clicks on Run and ArchiveCheck is ticked.
         CheckArchive;

         if ( (cash1.Xcashbook ) and (not(Cash11.xuse_inc_exp)) ) then CoOpPointerFix;   //Ch033      Only run for cashbook systems

         ProgressLabel.Show;
         ProgressBar.Show;
         Help.Enabled := False;
         RunButton.Enabled := False;
         ExitButton.Enabled := False;
         // try and Close the Databases
         try
            CreateArchiveRecordFile;           // TGM AB 27/01/17
            AccsDataModule.AccsDataBase.CloseDataSets;
            AccsDataModule.AccsDataBase.Close;
            // set year end flag
            Cash1.XYEAREND :=true;
            Defwrite(0);
         except

         end;

         if ( not(Copy_data_files) ) then
            begin
               ModalResult := mrNone;
               Proceed := False;
               CheckBacked.SetFocus;
            end;
         Help.Enabled := True;
         RunButton.Enabled := True;
         ExitButton.Enabled := True;
      end;

   if ( Proceed ) then
      begin
         // TGM AB - Next two lines keep backup copy for use with year spanning reports
         CopyFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'NLFile.db'),pchar(Accsdatamodule.AccsDataBase.Directory + 'NLFile-1.db'),false);
         CopyFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'NLFile.px'),pchar(Accsdatamodule.AccsDataBase.Directory + 'NLFile-1.px'),false);

         // Ch021 start - delete old carried forward files & overwrite with correct versions

         if fileexists(Accsdatamodule.AccsDataBase.Directory + 'SLFile-1.d b') then DeleteFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'SLFile-1.db'));
         if fileexists(Accsdatamodule.AccsDataBase.Directory + 'PLFile-1.db') then DeleteFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'PLFile-1.db'));
         if fileexists(Accsdatamodule.AccsDataBase.Directory + 'SLFile-1.px') then DeleteFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'SLFile-1.px'));
         if fileexists(Accsdatamodule.AccsDataBase.Directory + 'PLFile-1.px') then DeleteFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'PLFile-1.px'));
         if fileexists(Accsdatamodule.AccsDataBase.Directory + 'ProductsTx-1.db') then DeleteFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'ProductsTx-1.db'));
         if fileexists(Accsdatamodule.AccsDataBase.Directory + 'AllocatedVAT-1.db') then DeleteFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'AllocatedVAT-1.db'));

         if fileexists(Accsdatamodule.AccsDataBase.Directory + 'SLFile.db') then CopyFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'SLFile.db'),pchar(Accsdatamodule.AccsDataBase.Directory + 'SLFile-1.db'),false);

         if fileexists(Accsdatamodule.AccsDataBase.Directory + 'SLFile.px') then CopyFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'SLFile.px'),pchar(Accsdatamodule.AccsDataBase.Directory + 'SLFile-1.px'),false);

         if fileexists(Accsdatamodule.AccsDataBase.Directory + 'PLFile.db') then CopyFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'PLFile.db'),pchar(Accsdatamodule.AccsDataBase.Directory + 'PLFile-1.db'),false);

         if fileexists(Accsdatamodule.AccsDataBase.Directory + 'PLFile.px') then CopyFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'PLFile.px'),pchar(Accsdatamodule.AccsDataBase.Directory + 'PLFile-1.px'),false);

         if fileexists(Accsdatamodule.AccsDataBase.Directory + 'ProductsTx.db') then CopyFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'ProductsTx.db'),pchar(Accsdatamodule.AccsDataBase.Directory + 'ProductsTx-1.db'),false);

         if fileexists(Accsdatamodule.AccsDataBase.Directory + 'AllocatedVAT.db') then CopyFile(pchar(Accsdatamodule.AccsDataBase.Directory + 'AllocatedVAT.db'),pchar(Accsdatamodule.AccsDataBase.Directory + 'AllocatedVAT-1.db'),false);

         // Ch021 end

         ProgressLabel.Show;
         ProgressBar.Show;
         RunButton.Enabled := False;
         ExitButton.Enabled := False;
         PROG := EndYear;
         EndPeriod;
         St := ProfitLossedit.Text;
         st := concat ( st );
         ModalResult := mrNone;
         RunButton.Enabled := False;
         ExitButton.Enabled := True;
         ProgressBar.Hide;
         ProgressLabel.Caption := '';

         // TGM AB 07/03/03 Calculate individual Months
         if ( recalculate ) then
            begin
                 CalculateMonths.UpdateNLMonthlyLastYearFigures;
                 if CopyBalanceCheck.Checked = True then CalculateMonths.UpdateBudgetFigures;
            end;
         // Need to run reset pointer
         try
            Application.CreateForm(TAuditFiles, AuditFiles);
         except

         end;
         FullAudit.RunAuditFiles(NLFile,1,Accsdatamodule.NLFileDB.RecordCount,1,1,false);
         FullAudit.RunAuditFiles(SLFile,1,Accsdatamodule.SLFileDB.RecordCount,1,1,false);
         FullAudit.RunAuditFiles(PLFile,1,Accsdatamodule.PLFileDB.RecordCount,1,1,false);
         // End TGM AB

         if FileExists(Accsdata.AccsDataModule.AccsDataBase.Directory + 'YearEnd.Txt') then DeleteFile(pchar(Accsdata.AccsDataModule.AccsDataBase.Directory + 'YearEnd.Txt'));  // TGM AB 27/01/17   - deletes the file left in this years data folder sfter files get copied to archive folder

         Cash1.XMONTHNO := Cash1.XFINMONTH;
         Defwrite(11);
         // set year end flag
         Cash1.XYEAREND := false;
         Defwrite(0);
         //If sender <> PointInTimeYEForm then
         MessageDlg('Year End Complete',mtInformation, [mbOK], 0);           //Ch022
         FMainscreen.LoadTransactionGrid;
         Close;
      end;
end;

procedure TYearEndForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     MessageDlg('OK To Proceed ?', mtInformation, [mbYes, mbNo], 0);
     ModalResult := mrNone;
     YearEndForm.GroupBox1.SetFocus;
end;

procedure TYearEndForm.CheckFlags ( Sender : TObject );
begin
   //   14/11/16 [V4.2 R4.4] /MK Bug Fix - Run button should only be enabled where the user ticks CheckBacked.
   RunButton.Enabled := ( CheckBacked.Checked );
   {
   RunButton.Enabled := ( (CheckBacked.Checked) and (not(ArchiveCheck.Checked)) );
                        ( (CheckBacked.Checked) and (ArchiveCheck.Checked) and (CheckArchive) );
   }
end;

procedure TYearEndForm.CheckBackedClick(Sender: TObject);
begin
   CheckFlags ( Sender );
end;

function TYearEndForm.CheckArchive : Boolean;
Var
   ior : Integer;
   LSearchRec : TSearchRec;
begin
   Result := False;
   {$I-}
   MkDir(ArchiveEdit.Text);
   ior := ioresult;
   Result := ( ior = 0 );
   if ( not(Result) ) then
      Result := ( FindFirst(ArchiveEdit.Text,faDirectory,LSearchRec) = 0 );
end;

procedure TYearEndForm.FormActivate(Sender: TObject);
var
   st2,
   st : String;
begin
   st := Monthname [Cash1.xmonthno];
   st2 := Inttostr(cash1.xfinyear);
   caption := 'Year End'; {+ ' - ' + st + ' : ' + st2;}
   YearStatusBar.Panels.Items[0].Text := 'Financial Time ';
   YearStatusBar.Panels.Items[1].Text := 'Current Month : ' + st;
   YearStatusBar.Panels.Items[2].Text := 'Current Year : ' + st2;
end;

procedure TYearEndForm.HelpClick(Sender: TObject);
begin
   AccsDataModule.HTMLHelp('yearEnd.htm');
end;

procedure TYearEndForm.btnSendDataToAccountantClick(Sender: TObject);
begin
   if not (KAC.Active) then
      TfmDataBackup.Execute(daSendToAccountant)
   else
      MessageDlg('This feature is unavailable.',mtWarning,[mbOK],0)

end;

procedure TYearEndForm.CreateArchiveRecordFile;           // TGM AB 27/01/17
var
      Archivefile :textfile;

begin
      // Creates text file with record of highest Tx No when year end is run
      Assignfile(Archivefile, Accsdata.AccsDataModule.AccsDataBase.Directory + 'YearEnd.Txt');
      Rewrite(Archivefile);

      WriteLn(Archivefile,'Kingswood Year End Log File');
      WriteLn(Archivefile,'===================');
      Writeln(Archivefile,'');
      Writeln(Archivefile,'Set of Accounts - ' + Accsdata.AccsDataModule.AccsDataBase.AliasName);
      Writeln(Archivefile,'');
      SetDB(TxFile);
      Writeln(Archivefile,'Last Tx No - ' + vartostr(db1.dbrechigh));
      Writeln(Archivefile,'');
      Writeln(Archivefile,'Cashbook Date - ' + cash1.XDATE);
      Writeln(Archivefile,'');
      Writeln(Archivefile,'Computer Date - ' + datetostr(now));
      Writeln(Archivefile,'');
      closefile(Archivefile);



end;

procedure TYearEndForm.CoOpPointerFix;               // Ch033
var
        FirstTx : Integer;
begin

        FirstTx := xFirstTx;         // save the current first tx of the year

        // Reset pointers with FirstTx set to 1

        Auditfiles.OnShow(self);
        Auditfiles.OnActivate(self);

        AuditFiles.SuppressPrompts := true;

        Auditfiles.PassMask.Text := 'config';
        Auditfiles.ResetSales.Checked := True;
        Auditfiles.ResetPurchase.Checked := True;
        Auditfiles.ResetNominal.Checked := True;
        Auditfiles.SalesFrom.text := '1';
        Auditfiles.SalesTo.text := vartostr(Accsdatamodule.SLFileDB.recordcount);
        Auditfiles.PurchaseFrom.text := '1';
        Auditfiles.PurchaseTo.text := vartostr(Accsdatamodule.PLFileDB.recordcount);
        Auditfiles.ResetFirstGroup.ItemIndex := 1;
        Auditfiles.LowestTx.text := '1';
        Auditfiles.ConfirmBtnClick(self);

        // Reset pointers to saved First Tx

        Auditfiles.OnShow(self);
        Auditfiles.OnActivate(self);

        AuditFiles.SuppressPrompts := true;

        Auditfiles.PassMask.Text := 'config';
        Auditfiles.ResetSales.Checked := True;
        Auditfiles.ResetPurchase.Checked := True;
        Auditfiles.ResetNominal.Checked := True;
        Auditfiles.SalesFrom.text := '1';
        Auditfiles.SalesTo.text := vartostr(Accsdatamodule.SLFileDB.recordcount);
        Auditfiles.PurchaseFrom.text := '1';
        Auditfiles.PurchaseTo.text := vartostr(Accsdatamodule.PLFileDB.recordcount);
        Auditfiles.ResetFirstGroup.ItemIndex := 1;
        Auditfiles.LowestTx.text := vartostr(FirstTx);
        Auditfiles.ConfirmBtnClick(self);

end;


procedure TYearEndForm.Button1Click(Sender: TObject);               // Ch022
begin

 (*  if (cash2.xAllocation or cash2.XPaymentVAT) then begin
       showmessage('Currently only works with Invoicing Data Only');
       exit;
   end;
   *)

   //if not bool(PointInTimeYEForm) then Application.CreateForm(TPointInTimeYEForm, PointInTimeYEForm);
   //PointInTimeYEForm.show;

end;

end.
