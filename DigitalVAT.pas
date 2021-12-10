unit DigitalVAT;

{

Ch006 - New unit created for UK Digital VAT returns

30/09/19 Ch014 - Report filters updated to show all codes for Northern Ireland Audit Report with exempt codes identifed & totals split out at the bottom between included & exempt.

18/09/20 CH006(P) - Added in procedures to generate MTD figures for Payment Based VAT Customers

}

interface

   Type TVatArray = record
      VatCode : String[1];
      VatRate : String;
      VatPercent : String;
      SalesNet : Real;
      SalesVat : Real;
      PurchNet : Real;
      PurchVat : Real;
      NIInclude : boolean;
   end;
   Type TNICodeArray = record
      Box1 : Real;                // VAT Due Sales
      Box2 : Real;                // VAT Due Sales from EC States
      Box3 : Real;                // Total VAT Due
      Box4 : Real;                // VAT Reclaimed (Ine EC States)
      Box5 : Real;                // NET VAT
      Box6 : Real;                // Total Sales Ex VAT
      Box7 : Real;                // Total Purchases Ex VAT
      Box8 : Real;                // Total EC Supplies Ex VAT
      Box9 : Real;                // Total EC Acquisitions Ex VAT
   end;


   Var
   VatCodeArray:array[0..9] of TVatArray;
   NICodeArray:array[0..1] of TNICodeArray;
   FROMDT : TDateTime;
   TODT : TDateTime;
   SalesCount, Purchcount : integer;
   SpanYears : Boolean;


   procedure InitialiseReport(FromDate,ToDate : String);
   procedure CloseReportTable;
   Procedure InvoiceVatAuditTrail(SalePurch : Char; MarkasClaimed : Boolean; ClaimID : Integer; SpanYear : Boolean);
   Procedure GenerateNIFigures;
   Function GetLastSubmissionDate : TDateTime;
   Procedure PaymentVatAuditTrail(SalePurch : Char; MarkasClaimed : Boolean; ClaimID : Integer; SpanYear : Boolean);
   Procedure AddPaymentVATTotals;                     // Ch006(P)
   Function OverpaymentCheck : Boolean;               // Ch006(P)
   Procedure MarkInvoicesAsClaimed(ClaimID : Integer);   //Ch036


implementation

// General Setup / Configuration Procedures

uses AccsData, Vars, SysUtils, FullAudit, Calcs, Clears, DBGen, Types, Dialogs, DBCore, UPaymentVAT, uVATReps, DBTables, uDigitalVATForm;   // Ch006(P)

procedure InitialiseReport(FromDate,ToDate : String);
var
        i : integer;
        temprate : real;

begin

        Accsdatamodule.TempVATDB.close;
        Accsdatamodule.TempVATDB.EmptyTable;
        Accsdatamodule.TempVATDB.open;
        Accsdatamodule.TempVATDB.edit;

        // Initialise VAT Array

        for i:= 0 to 9 do begin
         VatCodeArray[i].VatCode := '';
         VatCodeArray[i].VatRate := '';
         VatCodeArray[i].VatPercent := '';
         VatCodeArray[i].SalesNet := 0;
         VatCodeArray[i].SalesVat := 0;
         VatCodeArray[i].PurchNet := 0;
         VatCodeArray[i].PurchVat := 0;
        end;

        for i:= 0 to 9 do Begin
                       VatCodeArray[i].VatCode := Cash1.xTaxIds[i];
                       TempRate := Cash1.xTaxRates[i] / 100;
                       VatCodeArray[i].VatRate := vartostr(Format ( '%f', [TempRate]));
                       if TempRate = 0 then VatCodeArray[i].VatPercent := 'Zero'
                        else VatCodeArray[i].VatPercent := VatCodeArray[i].VatRate + '%';
                       if Cash2.Vat_inc_exc[i] = 'I' then VatCodeArray[i].NIInclude := True
                        else VatCodeArray[i].NIInclude := false;
        End ;



        if FromDate <> '' then begin

                try FROMDT := strtodatetime(FromDate);
                except FROMDT := 0;
                end;

        end;

     //   if  FROMDT < then SpanYears := True;
      //      else SpanYears := False;

   //   CheckDateRange ( TestDate, True, DateBefore, True )

        if ToDate <> '' then begin

                try TODT := strtodatetime(ToDate);
                except TODT := 99999;
                end;

        end;

        SalesCount := 0;
        Purchcount := 0;


        for i:= 0 to 9 do begin                                // Ch006(P)
         uvatreps.VatArray[i].VatCode := '';
         uvatreps.VatArray[i].VatRate := '';
         uvatreps.VatArray[i].VatPercent := '';
         uvatreps.VatArray[i].SalesNet := 0;
         uvatreps.VatArray[i].SalesVat := 0;
         uvatreps.VatArray[i].PurchNet := 0;
         uvatreps.VatArray[i].PurchVat := 0;
        end;                                                   // Ch006(P)

        

end;


procedure CloseReportTable;
begin

        Accsdatamodule.TempVATDB.close;
        if FileExists(Accsdata.AccsDataModule.AccsDataBase.Directory + 'TempVAT.db') then deletefile(PCHAR(Accsdata.AccsDataModule.AccsDataBase.Directory + 'TempVAT.db'));



end;




Function GetLastSubmissionDate : TDateTime;
var
        i : integer;
begin


     Result := 0;
     AccsDataModule.VATReturnDB.Open;
     AccsDataModule.VATReturnDB.first;
     for i:= 1 to AccsDataModule.VATReturnDB.recordcount do begin
             if AccsDataModule.VATReturnDB['ReturnDate'] > result then Result :=  AccsDataModule.VATReturnDB['ReturnDate'];
     end;

end;


Procedure GenerateNIFigures;
var
        i, code : integer;
        TextRate : shortstring;
        EuroTransactions : boolean;
        Rate : real;
        TempReal : real;
begin

        NICodeArray[0].Box1 := 0;
        NICodeArray[0].Box2 := 0;
        NICodeArray[0].Box3 := 0;
        NICodeArray[0].Box4 := 0;
        NICodeArray[0].Box5 := 0;
        NICodeArray[0].Box6 := 0;
        NICodeArray[0].Box7 := 0;
        NICodeArray[0].Box8 := 0;
        NICodeArray[0].Box9 := 0;
        EuroTransactions := false;

        for I:= 0 to 9 do Begin
                if VatCodeArray[i].NIInclude then begin
                    NICodeArray[0].Box1 := NICodeArray[0].Box1 + VatCodeArray[i].SalesVat;
                    if ((cash2.XPaymentVAT) and (cash11.xSalesPaymentVAT = 'Y')) then NICodeArray[0].Box6 := NICodeArray[0].Box6 + VatCodeArray[i].SalesNet - VatCodeArray[i].SalesVat
                        else NICodeArray[0].Box6 := NICodeArray[0].Box6 + VatCodeArray[i].SalesNet;
                    NICodeArray[0].Box4 := NICodeArray[0].Box4 + VatCodeArray[i].PurchVat;
                    if ((cash2.XPaymentVAT) and (cash11.xPurchPaymentVAT = 'Y')) then NICodeArray[0].Box7 := NICodeArray[0].Box7 + VatCodeArray[i].PurchNet - VatCodeArray[i].PurchVat
                        else NICodeArray[0].Box7 := NICodeArray[0].Box7 + VatCodeArray[i].PurchNet;
                end;
                if VatCodeArray[i].VatCode = 'E' then begin
                   if ((VatCodeArray[i].PurchNet <> 0.00) or (VatCodeArray[i].SalesNet <> 0)) then EuroTransactions := True;
                end;
        End ;


        if Eurotransactions then begin
        showmessage('Box 9 on your VAT form has a value.' + #13#10
              + 'This comes from transactions entered with VAT Code E.' + #13#10
              + 'VAT Code E should only be used for goods imported from other EC States,' + #13#10
              + 'where these goods would be subject to standard Rate VAT if purchased in UK.' + #13#10
              + 'If you did not import goods in this category, please exit this report and edit the entries where you used VAT Code E, changing the Code E to a UK VAT Code' + #13#10
              + 'otherwise continue, entering the standard rate for VAT when prompted.');
        TextRate := InputBox('VAT Rate For Imports From EC States', 'What VAT Rate to be used for Code E, (Box 9)', '20.0');
        Rate := 0;
        Val(TextRate,Rate,code);
        Rate := (Rate / 100);
                for I:= 0 to 9 do Begin
                        if VatCodeArray[i].VatCode = 'E' then begin
                           Tempreal := (VatCodeArray[i].PurchNet * Rate);

                            // SP 04/04/19 - Round to 2 decimal places
                           Tempreal := Round(Tempreal*100)/100;

                           NICodeArray[0].Box2 := Tempreal;
                           NICodeArray[0].Box4 := NICodeArray[0].box4 + tempreal;
                           NICodeArray[0].Box9 := VatCodeArray[i].PurchNet;
                           NICodeArray[0].Box8 := VatCodeArray[i].SalesNet;
                end;
        End;

        end;

        NICodeArray[0].Box3 := NICodeArray[0].Box1 + NICodeArray[0].Box2;

        // SP 07/05/19 - Round to 2 decimal places
        NICodeArray[0].Box4 := Round(NICodeArray[0].Box4*100)/100;

        NICodeArray[0].box5 := (round(NICodeArray[0].box3*100) - round(NICodeArray[0].box4*100))/100;


end;









// These Procedures are all for Invoice Based VAT


Procedure InvoiceVatAuditTrail(SalePurch : Char; MarkasClaimed : Boolean; ClaimID : Integer; SpanYear : Boolean);
var

    TESTDT : TDateTime;
    i, j, ID : integer;
    TxRecord : Integer;
    OKTOPRINT : Boolean;
    Check_9_Types : Boolean;
    RecordType : Integer;
    Sub : INTEGER;
    NEG : BOOLEAN;
    TempInt, TxType, OrigType : Integer;
    Tempstr, tempstring : string;
    AMT     : real;
    VatCode, PreviousVatCode : string[1];
    RunningAmount, RunningVat : real;
    RunningCount : integer;
    st : shortstring;
    TotalAmount, TotalVat : real;


begin

  



    VatCode := '';
    PreviousVatCode := '';
    RunningAmount := 0;
    RunningVat := 0;
    RunningCount := 0;
    tempstr := '';


    Accsdatamodule.TransactionsDB.close;

 //   Accsdatamodule.SQLUpdate.sql.clear;
 //   Accsdatamodule.SQLUpdate.sql.Add('Alter Table Transactions Drop Index ByTaxCode.Primary');
 //   Accsdatamodule.SQLUpdate.ExecSQL;

    Accsdatamodule.SQLUpdate.sql.clear;
    Accsdatamodule.SQLUpdate.sql.Add('CREATE INDEX ByTaxCode ON Transactions (TaxCode,TxDate)');
    Accsdatamodule.SQLUpdate.ExecSQL;

    Accsdatamodule.TransactionsDB.IndexName := 'ByTaxCode';

    Accsdatamodule.TransactionsDB.open;

    for I := 0 to Accsdatamodule.TransactionsDB.IndexFieldCount - 1 do
        if Accsdatamodule.TransactionsDB.IndexFields[I].Name = 'ByTaxCode' then
           begin
                Accsdatamodule.TransactionsDB.IndexName := Accsdatamodule.TransactionsDB.IndexDefs.Items[I].Name;
           end;

    Accsdatamodule.TransactionsDB.last;

    Accsdatamodule.TempVATDB.last;
    // Accsdatamodule.TempVATDB.edit;             // Ch036

    if SalePurch = 'S' then begin

                        Accsdatamodule.TempVATDB.append;
                        Accsdatamodule.TempVATDB.post;
                        Accsdatamodule.TempVATDB.append;
                        Accsdatamodule.TempVATDB['Label'] := 'SALES INVOICE VAT AUDIT TRAIL';
                        Accsdatamodule.TempVATDB.post;
                        Accsdatamodule.TempVATDB.append;
                        Accsdatamodule.TempVATDB['Label'] := '======================================';
                        Accsdatamodule.TempVATDB.post;
                        Accsdatamodule.TempVATDB.append;
                        Accsdatamodule.TempVATDB.post;

                     end
        else begin
                        Accsdatamodule.TempVATDB.append;
                        Accsdatamodule.TempVATDB.post;
                        Accsdatamodule.TempVATDB.append;
                        Accsdatamodule.TempVATDB['Label'] := '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------';
                        Accsdatamodule.TempVATDB.post;
                        Accsdatamodule.TempVATDB.append;
                        Accsdatamodule.TempVATDB['Label'] := 'PURCHASE INVOICE VAT AUDIT TRAIL';
                        Accsdatamodule.TempVATDB.post;
                        Accsdatamodule.TempVATDB.append;
                        Accsdatamodule.TempVATDB['Label'] := '======================================';
                        Accsdatamodule.TempVATDB.post;
                        Accsdatamodule.TempVATDB.append;
                        Accsdatamodule.TempVATDB.post;
             end;


    // Pick-up Transactions from Last Year

    if SpanYear then begin

     if FileExists(Accsdata.AccsDataModule.AccsDataBase.Directory + 'Year-1.db') then begin


     Accsdatamodule.TransactionsYr1DB.close;


     Accsdatamodule.SQLUpdate.sql.clear;
     Accsdatamodule.SQLUpdate.sql.Add('CREATE INDEX ByTaxCode ON "Year-1" (TaxCode,TxDate)');
     Accsdatamodule.SQLUpdate.ExecSQL;

     Accsdatamodule.TransactionsYr1DB.IndexName := 'ByTaxCode';

     Accsdatamodule.TransactionsYr1DB.open;

     for I := 0 to Accsdatamodule.TransactionsYr1DB.IndexFieldCount - 1 do
        if Accsdatamodule.TransactionsYr1DB.IndexFields[I].Name = 'ByTaxCode' then
           begin
                Accsdatamodule.TransactionsYr1DB.IndexName := Accsdatamodule.TransactionsYr1DB.IndexDefs.Items[I].Name;
           end;

     Accsdatamodule.TransactionsYr1DB.last;


     SchRecf  := 1;                             // doesn't matter a only going back partially in the year
     SchRect  := Accsdatamodule.TransactionsYr1DB.RecordCount;

     for i:= Accsdatamodule.TransactionsYr1DB.RecordCount downto 1 do begin

     TxRecord := Accsdatamodule.TransactionsYr1DB['TxNo'];

      IF (TxRecord>=SCHRECF) AND (TxRecord<=SCHRECT) THEN
	BEGIN

              OKTOPRINT:=TRUE;

	      // Check the next record to see if its a VAT Record
	      Check_9_Types := false;
              RecordType := Accsdatamodule.TransactionsYr1DB['TxType'];
              tempstr := '';
              try tempstr := vartostr(Accsdatamodule.TransactionsYr1DB['TaxCode']);
              except
              end;


              if tempstr = '' then oktoprint := false;
              if tempstr = ' ' then oktoprint := false;

        { Ch014

              if cash2.XCOUNTRY = 1 then begin
                  for j := 0 to 9 do begin
                      if VatCodeArray[j].Vatcode = tempstr then begin
                          if VatCodeArray[j].NIInclude = false then oktoprint := false;
                      end;
                  end;
              end;

        end Ch014}

        // Ch017
        if (cash2.XCOUNTRY = 1) then begin
               if (DigitalVATForm.IncludeExemptCB.Checked = False) then begin
                  for j := 0 to 9 do begin
                      if VatCodeArray[j].Vatcode = tempstr then begin
                          if VatCodeArray[j].NIInclude = false then oktoprint := false;
                      end;
                  end;
              end;
        end;
       // end Ch017

              if ((RecordType = 9) and (length (tempstr) = 1)) then begin
                  Accsdatamodule.TransactionsYr1DB.prior;
       			if ((vartostr(Accsdatamodule.TransactionsYr1DB['TaxCode']) <> '') and (vartostr(Accsdatamodule.TransactionsYr1DB['TaxCode']) <> ' ')) then begin  // was ' '
                           if Accsdatamodule.TransactionsYr1DB['TxType'] = 0 then Check_9_Types := True;
                        end;
                  Accsdatamodule.TransactionsYr1DB.Locate('TxNo',Txrecord, []);;
              end;

             RecordType := Accsdatamodule.TransactionsYr1DB['TxType'];
             if not ((RecordType = 0) or (RecordType = 10)) then OKTOPRINT:=FALSE;

             try TESTDT := Accsdatamodule.TransactionsYr1DB['TxDate'];
             except TESTDT := 0;
             end;

             IF (TESTDT>TODT) THEN OKTOPRINT:=FALSE;

             // Check if already claimed

             If Accsdatamodule.TransactionsYr1DB['VATProcessed'] = True then OKTOPRINT := False;

       	     IF OKTOPRINT THEN
		BEGIN
                  tempint := 0;
	     	  tempint := Accsdatamodule.TransactionsYr1DB['Nominal'];

     	     	  If (( tempint >= Cash1.xnomprvinc ) And ( tempint <= Cash1.xnomprvexp+Cash11.xno_of_partners )) Then oktoprint := False;

                  tempstr := '';
                  try tempstr := vartostr(Accsdatamodule.TransactionsYr1DB['EditStat']);
                  except
                  end;
                  If ((ansilowercase(tempstr) = 'e') or (ansilowercase(tempstr) = 'r')) then oktoprint := False;


      		  IF OKTOPRINT THEN
		     BEGIN
		      SUB:=0;
		      NEG:=FALSE;
                      TxType := Accsdatamodule.TransactionsYr1DB['TxType'];

   		      If ( TxType=0 ) Or (( Cash2.xcountry In [1,2] ) And
			 ( check_9_types )) THEN
			BEGIN
                          OrigType := Accsdatamodule.TransactionsYr1DB['OrigType'];
     			  IF OrigType IN [1,2,3,4,11,12] THEN SUB:=1;
			  IF OrigType IN [5,6,7,8,15,16] THEN SUB:=2;
			END;
		      IF OrigType=10 THEN SUB:=1;
              	      IF SUB>0 THEN
			BEGIN
			  AMT:=Accsdatamodule.TransactionsYr1DB['Amount'];
                          TxType := Accsdatamodule.TransactionsYr1DB['TxType'];

			  IF ( TxType=0 )  Or (( Cash2.xcountry In [1,2] ) And
			     ( check_9_types )) THEN
			    IF ((NOT (OrigType IN [3,7])) AND (AMT<0))
			    OR ((     OrigType IN [3,7] ) AND (AMT>0)) THEN
			      BEGIN
				IF SUB=1 THEN SUB:=2 ELSE SUB:=1;
				NEG:=TRUE;
			      END;
			  IF TxType=10 THEN NEG:=TRUE;
		        END;
		      IF ((SalePurch = 'S') AND (SUB<>1))
		      OR ((SalePurch = 'P') AND (SUB<>2)) THEN OKTOPRINT:=FALSE;

	  	     END;
	   	END;
                if oktoprint then begin


                                        VatCode := vartostr(Accsdatamodule.TransactionsYr1DB['TaxCode']);

                                        if MarkasClaimed then begin

                                              ID :=  Accsdatamodule.TransactionsYr1DB['TxNo'];

                                              Accsdatamodule.SQLUpdate.sql.clear;
                                              Accsdatamodule.SQLUpdate.sql.Add('Update "Year-1" set VATProcessed = true, ReturnID = ' + vartostr(ClaimID) + ' where Txno = ' + vartostr(ID));
                                              Accsdatamodule.SQLUpdate.ExecSQL;



                                        end;

                                        if PreviousVatCode <> '' then begin  // not the first record

                                           if PreviousVatCode <> VatCode then begin
                                            if RunningCount <> 0 then begin
                                               Accsdatamodule.TempVATDB.append;
                                               Accsdatamodule.TempVATDB['Label'] := '-----------------------------------------------------------------------------------------------------------------------------------------';     // TGM AB 24/07/15
                                               Accsdatamodule.TempVATDB.post;
                                               Accsdatamodule.TempVATDB.append;
                                               for j:= 0 to 9 do Begin
                                                   if Cash1.xTaxIds[j] = PreviousVatCode then TempString := VatCodeArray[j].VatPercent;
                                               End;
                                               Accsdatamodule.TempVATDB['Label'] := 'Total For V-A-T Code ' + PreviousVatCode + ' In Previous Year (' + vartostr(RunningCount) + ' Records) ..... ' + TempString;

                                               // Ch014 start
                                               if cash2.XCOUNTRY = 1 then begin   //Ch015
                                                  st := '';
                                                  for j:= 0 to 9 do Begin
                                                      if Cash1.xTaxIds[j] = PreviousVatCode then begin
                                                                if Cash2.Vat_inc_exc[j] <> 'I' then st := '    (Exempt VAT Code)';
                                                      end;
                                                  end;
                                                  Accsdatamodule.TempVATDB['Label'] :=  Accsdatamodule.TempVATDB['Label'] + ' ' + st;
                                               end;     // Ch015
                                               // Ch014 end

                                               st := '';
                                               DoubleToStr (RunningAmount,st,'%8.2f', true, false, 20, True);
                                               slimleft (st);
                                               Accsdatamodule.TempVATDB['AmountText'] := st;
                                               Accsdatamodule.TempVATDB['Amount'] := RunningAmount;
                                               st := '';
                                               DoubleToStr (RunningVat,st,'%8.2f', true, false, 20, True);
                                               slimleft (st);
                                               Accsdatamodule.TempVATDB['VATText'] := st;
                                               Accsdatamodule.TempVATDB['VAT'] := RunningVat;
                                               Accsdatamodule.TempVATDB.post;
                                               Accsdatamodule.TempVATDB.append;
                                               Accsdatamodule.TempVATDB['Label'] := '-----------------------------------------------------------------------------------------------------------------------------------------';       // TGM AB 24/07/15
                                               Accsdatamodule.TempVATDB.post;
                                               for j:= 0 to 9 do Begin
                                                    if VatCodeArray[j].VatCode = PreviousVatCode then begin
                                                       if SalePurch = 'S' then begin
                                                                VatCodeArray[j].SalesNet := RunningAmount;
                                                                VatCodeArray[j].SalesVat := RunningVat;
                                                       end else begin
                                                                VatCodeArray[j].PurchNet := RunningAmount;
                                                                VatCodeArray[j].PurchVat := RunningVat;
                                                                end;
                                                    end;
                                               End ;
                                               if SalePurch = 'S' then SalesCount := SalesCount + RunningCount
                                                  else Purchcount := Purchcount + RunningCount;
                                               RunningAmount := 0;
                                               RunningVat := 0;
                                               RunningCount := 0;
                                            end; // RunningCount
                                           end;

                                           Accsdatamodule.TempVATDB.append;
                                           Accsdatamodule.TempVATDB['Record'] := Accsdatamodule.TransactionsYr1DB['TxNo'];
                                           Accsdatamodule.TempVATDB['TxDate'] := Accsdatamodule.TransactionsYr1DB['TxDate'];
                                           Accsdatamodule.TempVATDB['Description'] := Accsdatamodule.TransactionsYr1DB['Descript'];
                                           Accsdatamodule.TempVATDB['PreviousYear'] := '*';
                                           if OrigType IN [1,2,3,4,11,12]  then Accsdatamodule.TempVATDB['Account'] := GetSLPLAccountName ( SlFile, Accsdatamodule.TransactionsYr1DB['Account'])
                                                else Accsdatamodule.TempVATDB['Account'] := GetSLPLAccountName ( PlFile, Accsdatamodule.TransactionsYr1DB['Account']);
                                           Accsdatamodule.TempVATDB['Reference'] := Accsdatamodule.TransactionsYr1DB['Reference'];

                                           if NEG then begin
                                                        Accsdatamodule.TempVATDB['Amount'] := ((Accsdatamodule.TransactionsYr1DB['Amount']) * -1);
                                                        st := '';
                                                        DoubleToStr (((Accsdatamodule.TransactionsYr1DB['Amount'])*-1),st,'%8.2f', true, false, 20, True);
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['AmountText'] := st;
                                                        Accsdatamodule.TempVATDB['VAT'] := ((Accsdatamodule.TransactionsYr1DB['TaxDisc']) * -1);
                                                        st := '';
                                                        DoubleToStr (((Accsdatamodule.TransactionsYr1DB['TaxDisc'])*-1),st,'%8.2f', true, false, 20, True);
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['VATText'] := st;
                                                        Accsdatamodule.TempVATDB['VATCode'] := Accsdatamodule.TransactionsYr1DB['TaxCode'];
                                                        Accsdatamodule.TempVATDB.post;
                                                        RunningAmount := RunningAmount - Accsdatamodule.TransactionsYr1DB['Amount'];
                                                        RunningVat := RunningVat - Accsdatamodule.TransactionsYr1DB['TaxDisc'];
                                           end
                                                else begin
                                                        Accsdatamodule.TempVATDB['Amount'] := Accsdatamodule.TransactionsYr1DB['Amount'];
                                                        st := '';
                                                        DoubleToStr (Accsdatamodule.TransactionsYr1DB['Amount'],st,'%8.2f', true, false, 20, True);
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['AmountText'] := st;
                                                        Accsdatamodule.TempVATDB['VAT'] := Accsdatamodule.TransactionsYr1DB['TaxDisc'];
                                                        st := '';
                                                        DoubleToStr (Accsdatamodule.TransactionsYr1DB['TaxDisc'],st,'%8.2f', true, false, 20, True);      // TGM AB 19/04/19
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['VATText'] := st;
                                                        Accsdatamodule.TempVATDB['VATCode'] := Accsdatamodule.TransactionsYr1DB['TaxCode'];
                                                        Accsdatamodule.TempVATDB.post;
                                                        RunningAmount := RunningAmount + Accsdatamodule.TransactionsYr1DB['Amount'];
                                                        RunningVat := RunningVat + Accsdatamodule.TransactionsYr1DB['TaxDisc'];
                                                end;



                                        end
                                            else begin

                                            Accsdatamodule.TempVATDB.append;
                                            Accsdatamodule.TempVATDB['Record'] := Accsdatamodule.TransactionsYr1DB['TxNo'];
                                            Accsdatamodule.TempVATDB['TxDate'] := Accsdatamodule.TransactionsYr1DB['TxDate'];
                                            Accsdatamodule.TempVATDB['Description'] := Accsdatamodule.TransactionsYr1DB['Descript'];
                                            Accsdatamodule.TempVATDB['PreviousYear'] := '*';
                                            if OrigType IN [1,2,3,4,11,12] then Accsdatamodule.TempVATDB['Account'] := GetSLPLAccountName ( SlFile, Accsdatamodule.TransactionsYr1DB['Account'])
                                                else Accsdatamodule.TempVATDB['Account'] := GetSLPLAccountName ( PlFile, Accsdatamodule.TransactionsYr1DB['Account']);
                                            Accsdatamodule.TempVATDB['Reference'] := Accsdatamodule.TransactionsYr1DB['Reference'];
                                            if NEG then begin
                                                        Accsdatamodule.TempVATDB['Amount'] := ((Accsdatamodule.TransactionsYr1DB['Amount']) * -1);
                                                        st := '';
                                                        DoubleToStr (((Accsdatamodule.TransactionsYr1DB['Amount'])*-1),st,'%8.2f', true, false, 20, True);
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['AmountText'] := st;
                                                        Accsdatamodule.TempVATDB['VAT'] := ((Accsdatamodule.TransactionsYr1DB['TaxDisc']) * -1);
                                                        st := '';
                                                        DoubleToStr (((Accsdatamodule.TransactionsYr1DB['TaxDisc'])*-1),st,'%8.2f', true, false, 20, True);
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['VATText'] := st;
                                                        Accsdatamodule.TempVATDB['VATCode'] := Accsdatamodule.TransactionsYr1DB['TaxCode'];
                                                        Accsdatamodule.TempVATDB.post;
                                                        RunningAmount := RunningAmount - Accsdatamodule.TransactionsYr1DB['Amount'];
                                                        RunningVat := RunningVat - Accsdatamodule.TransactionsYr1DB['TaxDisc'];
                                           end
                                                else begin
                                                        Accsdatamodule.TempVATDB['Amount'] := Accsdatamodule.TransactionsYr1DB['Amount'];
                                                        st := '';
                                                        DoubleToStr (Accsdatamodule.TransactionsYr1DB['Amount'],st,'%8.2f', true, false, 20, True);
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['AmountText'] := st;
                                                        Accsdatamodule.TempVATDB['VAT'] := Accsdatamodule.TransactionsYr1DB['TaxDisc'];
                                                        st := '';
                                                        DoubleToStr (Accsdatamodule.TransactionsYr1DB['TaxDisc'],st,'%8.2f', true, false, 20, True);
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['VATText'] := st;
                                                        Accsdatamodule.TempVATDB['VATCode'] := Accsdatamodule.TransactionsYr1DB['TaxCode'];
                                                        Accsdatamodule.TempVATDB.post;
                                                        RunningAmount := RunningAmount + Accsdatamodule.TransactionsYr1DB['Amount'];
                                                        RunningVat := RunningVat + Accsdatamodule.TransactionsYr1DB['TaxDisc'];
                                                end;



                                            end;
                                        inc(RunningCount);

                                        PreviousVatCode := VatCode;
                                end;
	   END; // S or P


        if i = 1 then begin
          if RunningCount <> 0 then begin
             Accsdatamodule.TempVATDB.edit;
             Accsdatamodule.TempVATDB.append;
             Accsdatamodule.TempVATDB['Label'] := '-----------------------------------------------------------------------------------------------------------------------------------------';           // TGM AB 24/07/15
             Accsdatamodule.TempVATDB.post;
             Accsdatamodule.TempVATDB.append;
             for j:= 0 to 9 do Begin
                 if Cash1.xTaxIds[j] = PreviousVatCode then TempString := VatCodeArray[j].VatPercent;
             End;
             Accsdatamodule.TempVATDB['Label'] := 'Total For V-A-T Code ' + PreviousVatCode + ' In Previous Year (' + vartostr(RunningCount) + ' Records) ..... ' + TempString;

             // Ch014 start
             if cash2.XCOUNTRY = 1 then begin   //Ch015
             st := '';
             for j:= 0 to 9 do Begin
                if Cash1.xTaxIds[j] = PreviousVatCode then begin
                        if Cash2.Vat_inc_exc[j] <> 'I' then st := '    (Exempt VAT Code)';
                        end;
                end;
             Accsdatamodule.TempVATDB['Label'] :=  Accsdatamodule.TempVATDB['Label'] + ' ' + st;
             end;       //Ch015
             // Ch014 end

             st := '';
             DoubleToStr (RunningAmount,st,'%8.2f', true, false, 20, True);
             slimleft (st);
             Accsdatamodule.TempVATDB['AmountText'] := st;
             Accsdatamodule.TempVATDB['Amount'] := RunningAmount;
             st := '';
             DoubleToStr (RunningVat,st,'%8.2f', true, false, 20, True);
             slimleft (st);
             Accsdatamodule.TempVATDB['VATText'] := st;
             Accsdatamodule.TempVATDB['VAT'] := RunningVat;
             Accsdatamodule.TempVATDB.post;
             Accsdatamodule.TempVATDB.append;
             Accsdatamodule.TempVATDB['Label'] := '-----------------------------------------------------------------------------------------------------------------------------------------';          // TGM AB 24/07/15
             Accsdatamodule.TempVATDB.post;
             for j:= 0 to 9 do Begin
                  if VatCodeArray[j].VatCode = PreviousVatCode then begin
                        if SalePurch = 'S' then begin
                                                                VatCodeArray[j].SalesNet := RunningAmount;
                                                                VatCodeArray[j].SalesVat := RunningVat;
                                                       end else begin
                                                                VatCodeArray[j].PurchNet := RunningAmount;
                                                                VatCodeArray[j].PurchVat := RunningVat;
                                                                end;
                        end;
             End;
             if SalePurch = 'S' then SalesCount := SalesCount + RunningCount
                else PurchCount := PurchCount + RunningCount;
             RunningAmount := 0;
             RunningVat := 0;
             RunningCount := 0;
            end; // RunningCount
           end;
        Accsdatamodule.TransactionsYr1DB.prior;

     end; // For i:=

     end;   // if file exists

    end;   // SpanYear




    // Pick-up Transactions from This Year

    // Set-up Variables

    VatCode := '';
    PreviousVatCode := '';
    RunningCount := 0;
    tempstr := '';

    SchRecf  := AuditFiles.FirstTxThisYear;
    SchRect  := Accsdatamodule.TransactionsDB.RecordCount;

    Accsdatamodule.TransactionsDB.last;

    for i:= Accsdatamodule.TransactionsDB.RecordCount downto 1 do begin

      TxRecord := Accsdatamodule.TransactionsDB['TxNo'];

      IF (TxRecord>=SCHRECF) AND (TxRecord<=SCHRECT) THEN
	BEGIN

              OKTOPRINT:=TRUE;

	      // Check the next record to see if its a VAT Record
	      Check_9_Types := false;
              RecordType := Accsdatamodule.TransactionsDB['TxType'];
              tempstr := '';
              try tempstr := vartostr(Accsdatamodule.TransactionsDB['TaxCode']);
              except
              end;


              if tempstr = '' then oktoprint := false;
              if tempstr = ' ' then oktoprint := false;

       {  Ch014

              if cash2.XCOUNTRY = 1 then begin
                  for j := 0 to 9 do begin
                      if VatCodeArray[j].Vatcode = tempstr then begin
                          if VatCodeArray[j].NIInclude = false then oktoprint := false;
                      end;
                  end;
              end;
        end CH014  }

        // Ch017
        if (cash2.XCOUNTRY = 1) then begin
               if (DigitalVATForm.IncludeExemptCB.Checked = False) then begin
                  for j := 0 to 9 do begin
                      if VatCodeArray[j].Vatcode = tempstr then begin
                          if VatCodeArray[j].NIInclude = false then oktoprint := false;
                      end;
                  end;
              end;
        end;
       // end Ch017

              if ((RecordType = 9) and (length (tempstr) = 1)) then begin
                  Accsdatamodule.TransactionsDB.prior;
       			if ((vartostr(Accsdatamodule.TransactionsDB['TaxCode']) <> '') and (vartostr(Accsdatamodule.TransactionsDB['TaxCode']) <> ' ')) then begin  // was ' '
                           if Accsdatamodule.TransactionsDB['TxType'] = 0 then Check_9_Types := True;
                        end;
                  Accsdatamodule.TransactionsDB.Locate('TxNo',Txrecord, []);;
              end;

             RecordType := Accsdatamodule.TransactionsDB['TxType'];
             if not ((RecordType = 0) or (RecordType = 10)) then OKTOPRINT:=FALSE;

             try TESTDT := Accsdatamodule.TransactionsDB['TxDate'];
             except TESTDT := 0;
             end;

             IF (TESTDT>TODT) THEN OKTOPRINT:=FALSE;

             // Check if already claimed

             If Accsdatamodule.TransactionsDB['VATProcessed'] = True then OKTOPRINT := False;

   	     IF OKTOPRINT THEN
		BEGIN
                  tempint := 0;
	     	  tempint := Accsdatamodule.TransactionsDB['Nominal'];

     	     	  If (( tempint >= Cash1.xnomprvinc ) And ( tempint <= Cash1.xnomprvexp+Cash11.xno_of_partners )) Then oktoprint := False;

                  tempstr := '';
                  try tempstr := vartostr(Accsdatamodule.TransactionsDB['EditStat']);
                  except
                  end;
                  If ((ansilowercase(tempstr) = 'e') or (ansilowercase(tempstr) = 'r')) then oktoprint := False;


      		  IF OKTOPRINT THEN
		     BEGIN
		      SUB:=0;
		      NEG:=FALSE;
                      TxType := Accsdatamodule.TransactionsDB['TxType'];

   		      If ( TxType=0 ) Or (( Cash2.xcountry In [1,2] ) And
			 ( check_9_types )) THEN
			BEGIN
                          OrigType := Accsdatamodule.TransactionsDB['OrigType'];
     			  IF OrigType IN [1,2,3,4,11,12] THEN SUB:=1;
			  IF OrigType IN [5,6,7,8,15,16] THEN SUB:=2;
			END;
		      IF OrigType=10 THEN SUB:=1;
              	      IF SUB>0 THEN
			BEGIN
			  AMT:=Accsdatamodule.TransactionsDB['Amount'];
                          TxType := Accsdatamodule.TransactionsDB['TxType'];

			  IF ( TxType=0 )  Or (( Cash2.xcountry In [1,2] ) And
			     ( check_9_types )) THEN
			    IF ((NOT (OrigType IN [3,7])) AND (AMT<0))
			    OR ((     OrigType IN [3,7] ) AND (AMT>0)) THEN
			      BEGIN
				IF SUB=1 THEN SUB:=2 ELSE SUB:=1;
				NEG:=TRUE;
			      END;
			  IF TxType=10 THEN NEG:=TRUE;
		        END;
		      IF ((SalePurch = 'S') AND (SUB<>1))
		      OR ((SalePurch = 'P') AND (SUB<>2)) THEN OKTOPRINT:=FALSE;

	  	     END;
	   	END;
                if oktoprint then begin


                                        VatCode := vartostr(Accsdatamodule.TransactionsDB['TaxCode']);

                                        if MarkasClaimed then begin

                                              ID :=  Accsdatamodule.TransactionsDB['TxNo'];

                                              Accsdatamodule.SQLUpdate.sql.clear;
                                              Accsdatamodule.SQLUpdate.sql.Add('Update Transactions set VATProcessed = true, ReturnID = ' + vartostr(ClaimID) + ' where Txno = ' + vartostr(ID));
                                              Accsdatamodule.SQLUpdate.ExecSQL;



                                        end;

                                        if PreviousVatCode <> '' then begin  // not the first record

                                           if PreviousVatCode <> VatCode then begin
                                               Accsdatamodule.TempVATDB.append;
                                               Accsdatamodule.TempVATDB['Label'] := '-----------------------------------------------------------------------------------------------------------------------------------------';     // TGM AB 24/07/15
                                               Accsdatamodule.TempVATDB.post;
                                               Accsdatamodule.TempVATDB.append;
                                               for j:= 0 to 9 do Begin
                                                   if Cash1.xTaxIds[j] = PreviousVatCode then TempString := VatCodeArray[j].VatPercent;
                                               End;
                                               Accsdatamodule.TempVATDB['Label'] := 'Total For V-A-T Code ' + PreviousVatCode + ' (' + vartostr(RunningCount) + ' Records) ..... ' + TempString;

                                               // Ch014 start
                                               if cash2.XCOUNTRY = 1 then begin   //Ch015
                                                  st := '';
                                                  for j:= 0 to 9 do Begin
                                                      if Cash1.xTaxIds[j] = PreviousVatCode then begin
                                                                if Cash2.Vat_inc_exc[j] <> 'I' then st := '    (Exempt VAT Code)';
                                                      end;
                                                  end;
                                                  Accsdatamodule.TempVATDB['Label'] :=  Accsdatamodule.TempVATDB['Label'] + ' ' + st;
                                               end;       //Ch015
                                               // Ch014 end

                                               st := '';
                                               DoubleToStr (RunningAmount,st,'%8.2f', true, false, 20, True);
                                               slimleft (st);
                                               Accsdatamodule.TempVATDB['AmountText'] := st;
                                               Accsdatamodule.TempVATDB['Amount'] := RunningAmount;
                                               st := '';
                                               DoubleToStr (RunningVat,st,'%8.2f', true, false, 20, True);
                                               slimleft (st);
                                               Accsdatamodule.TempVATDB['VATText'] := st;
                                               Accsdatamodule.TempVATDB['VAT'] := RunningVat;
                                               Accsdatamodule.TempVATDB.post;
                                               Accsdatamodule.TempVATDB.append;
                                               Accsdatamodule.TempVATDB['Label'] := '-----------------------------------------------------------------------------------------------------------------------------------------';       // TGM AB 24/07/15
                                               Accsdatamodule.TempVATDB.post;
                                               for j:= 0 to 9 do Begin
                                                    if VatCodeArray[j].VatCode = PreviousVatCode then begin
                                                       if SalePurch = 'S' then begin
                                                                VatCodeArray[j].SalesNet := VatCodeArray[j].SalesNet + RunningAmount;
                                                                VatCodeArray[j].SalesVat := VatCodeArray[j].SalesVat + RunningVat;
                                                       end else begin
                                                                VatCodeArray[j].PurchNet := VatCodeArray[j].PurchNet + RunningAmount;
                                                                VatCodeArray[j].PurchVat := VatCodeArray[j].PurchVat + RunningVat;
                                                                end;
                                                    end;
                                               End ;
                                               if SalePurch = 'S' then SalesCount := SalesCount + RunningCount
                                                  else Purchcount := Purchcount + RunningCount;
                                               RunningAmount := 0;
                                               RunningVat := 0;
                                               RunningCount := 0;
                                           end;

                                           Accsdatamodule.TempVATDB.append;
                                           Accsdatamodule.TempVATDB['Record'] := Accsdatamodule.TransactionsDB['TxNo'];
                                           Accsdatamodule.TempVATDB['TxDate'] := Accsdatamodule.TransactionsDB['TxDate'];
                                           Accsdatamodule.TempVATDB['Description'] := Accsdatamodule.TransactionsDB['Descript'];
                                           if OrigType IN [1,2,3,4,11,12]  then Accsdatamodule.TempVATDB['Account'] := GetSLPLAccountName ( SlFile, Accsdatamodule.TransactionsDB['Account'])
                                                else Accsdatamodule.TempVATDB['Account'] := GetSLPLAccountName ( PlFile, Accsdatamodule.TransactionsDB['Account']);
                                           Accsdatamodule.TempVATDB['Reference'] := Accsdatamodule.TransactionsDB['Reference'];

                                           if NEG then begin
                                                        Accsdatamodule.TempVATDB['Amount'] := ((Accsdatamodule.TransactionsDB['Amount']) * -1);
                                                        st := '';
                                                        DoubleToStr (((Accsdatamodule.TransactionsDB['Amount'])*-1),st,'%8.2f', true, false, 20, True);
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['AmountText'] := st;
                                                        Accsdatamodule.TempVATDB['VAT'] := ((Accsdatamodule.TransactionsDB['TaxDisc']) * -1);
                                                        st := '';
                                                        DoubleToStr (((Accsdatamodule.TransactionsDB['TaxDisc'])*-1),st,'%8.2f', true, false, 20, True);
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['VATText'] := st;
                                                        Accsdatamodule.TempVATDB['VATCode'] := Accsdatamodule.TransactionsDB['TaxCode'];
                                                        Accsdatamodule.TempVATDB.post;
                                                        RunningAmount := RunningAmount - Accsdatamodule.TransactionsDB['Amount'];
                                                        RunningVat := RunningVat - Accsdatamodule.TransactionsDB['TaxDisc'];
                                           end
                                                else begin
                                                        Accsdatamodule.TempVATDB['Amount'] := Accsdatamodule.TransactionsDB['Amount'];
                                                        st := '';
                                                        DoubleToStr (Accsdatamodule.TransactionsDB['Amount'],st,'%8.2f', true, false, 20, True);
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['AmountText'] := st;
                                                        Accsdatamodule.TempVATDB['VAT'] := Accsdatamodule.TransactionsDB['TaxDisc'];
                                                        st := '';
                                                        DoubleToStr (Accsdatamodule.TransactionsDB['TaxDisc'],st,'%8.2f', true, false, 20, True);
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['VATText'] := st;
                                                        Accsdatamodule.TempVATDB['VATCode'] := Accsdatamodule.TransactionsDB['TaxCode'];
                                                        Accsdatamodule.TempVATDB.post;
                                                        RunningAmount := RunningAmount + Accsdatamodule.TransactionsDB['Amount'];
                                                        RunningVat := RunningVat + Accsdatamodule.TransactionsDB['TaxDisc'];
                                                end;



                                        end
                                            else begin

                                            Accsdatamodule.TempVATDB.append;
                                            Accsdatamodule.TempVATDB['Record'] := Accsdatamodule.TransactionsDB['TxNo'];
                                            Accsdatamodule.TempVATDB['TxDate'] := Accsdatamodule.TransactionsDB['TxDate'];
                                            Accsdatamodule.TempVATDB['Description'] := Accsdatamodule.TransactionsDB['Descript'];
                                      //      if Act = 11 then Accsdatamodule.TempVATDB['Account'] := GetSLPLAccountName ( SlFile, Accsdatamodule.TransactionsDB['Account'])
                                      //          else Accsdatamodule.TempVATDB['Account'] := GetSLPLAccountName ( PlFile, Accsdatamodule.TransactionsDB['Account']);
                                            if OrigType IN [1,2,3,4,11,12] then Accsdatamodule.TempVATDB['Account'] := GetSLPLAccountName ( SlFile, Accsdatamodule.TransactionsDB['Account'])
                                                else Accsdatamodule.TempVATDB['Account'] := GetSLPLAccountName ( PlFile, Accsdatamodule.TransactionsDB['Account']);
                                            Accsdatamodule.TempVATDB['Reference'] := Accsdatamodule.TransactionsDB['Reference'];
                                            if NEG then begin
                                                        Accsdatamodule.TempVATDB['Amount'] := ((Accsdatamodule.TransactionsDB['Amount']) * -1);
                                                        st := '';
                                                        DoubleToStr (((Accsdatamodule.TransactionsDB['Amount'])*-1),st,'%8.2f', true, false, 20, True);
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['AmountText'] := st;
                                                        Accsdatamodule.TempVATDB['VAT'] := ((Accsdatamodule.TransactionsDB['TaxDisc']) * -1);
                                                        st := '';
                                                        DoubleToStr (((Accsdatamodule.TransactionsDB['TaxDisc'])*-1),st,'%8.2f', true, false, 20, True);
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['VATText'] := st;
                                                        Accsdatamodule.TempVATDB['VATCode'] := Accsdatamodule.TransactionsDB['TaxCode'];
                                                        Accsdatamodule.TempVATDB.post;
                                                        RunningAmount := RunningAmount - Accsdatamodule.TransactionsDB['Amount'];
                                                        RunningVat := RunningVat - Accsdatamodule.TransactionsDB['TaxDisc'];
                                           end
                                                else begin
                                                        Accsdatamodule.TempVATDB['Amount'] := Accsdatamodule.TransactionsDB['Amount'];
                                                        st := '';
                                                        DoubleToStr (Accsdatamodule.TransactionsDB['Amount'],st,'%8.2f', true, false, 20, True);
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['AmountText'] := st;
                                                        Accsdatamodule.TempVATDB['VAT'] := Accsdatamodule.TransactionsDB['TaxDisc'];
                                                        st := '';
                                                        DoubleToStr (Accsdatamodule.TransactionsDB['TaxDisc'],st,'%8.2f', true, false, 20, True);
                                                        slimleft (st);
                                                        Accsdatamodule.TempVATDB['VATText'] := st;
                                                        Accsdatamodule.TempVATDB['VATCode'] := Accsdatamodule.TransactionsDB['TaxCode'];
                                                        Accsdatamodule.TempVATDB.post;
                                                        RunningAmount := RunningAmount + Accsdatamodule.TransactionsDB['Amount'];
                                                        RunningVat := RunningVat + Accsdatamodule.TransactionsDB['TaxDisc'];
                                                end;


                                         (*   Accsdatamodule.TempVATDB['Amount'] := Accsdatamodule.TransactionsDB['Amount'];
                                            st := '';
                                            DoubleToStr (Accsdatamodule.TransactionsDB['Amount'],st,'%8.2f', true, false, 20, True);
                                            slimleft (st);
                                            Accsdatamodule.TempVATDB['AmountText'] := st;
                                            Accsdatamodule.TempVATDB['VAT'] := Accsdatamodule.TransactionsDB['TaxDisc'];
                                            st := '';
                                            DoubleToStr (Accsdatamodule.TransactionsDB['TaxDisc'],st,'%8.2f', true, false, 20, True);
                                            slimleft (st);
                                            Accsdatamodule.TempVATDB['VATText'] := st;
                                            Accsdatamodule.TempVATDB['VATCode'] := Accsdatamodule.TransactionsDB['TaxCode'];
                                            Accsdatamodule.TempVATDB.post;
                                            RunningAmount := RunningAmount + Accsdatamodule.TransactionsDB['Amount'];
                                            RunningVat := RunningVat + Accsdatamodule.TransactionsDB['TaxDisc'];
                                           *)
                                            end;
                                        inc(RunningCount);

                                        PreviousVatCode := VatCode;
                                end;
	   END; // S or P


        if i = 1 then begin
             Accsdatamodule.TempVATDB.edit;
             Accsdatamodule.TempVATDB.append;
             Accsdatamodule.TempVATDB['Label'] := '-----------------------------------------------------------------------------------------------------------------------------------------';           // TGM AB 24/07/15
             Accsdatamodule.TempVATDB.post;
             Accsdatamodule.TempVATDB.append;
             for j:= 0 to 9 do Begin
                 if Cash1.xTaxIds[j] = PreviousVatCode then TempString := VatCodeArray[j].VatPercent;
             End;
             Accsdatamodule.TempVATDB['Label'] := 'Total For V-A-T Code ' + PreviousVatCode + ' (' + vartostr(RunningCount) + ' Records) ..... ' + TempString;

             // Ch014 start
             if cash2.XCOUNTRY = 1 then begin   //Ch015
             st := '';
             for j:= 0 to 9 do Begin
                if Cash1.xTaxIds[j] = PreviousVatCode then begin
                        if Cash2.Vat_inc_exc[j] <> 'I' then st := '    (Exempt VAT Code)';
                        end;
                end;
             Accsdatamodule.TempVATDB['Label'] :=  Accsdatamodule.TempVATDB['Label'] + ' ' + st;
             end;    //Ch015
             // Ch014 end

             st := '';
             DoubleToStr (RunningAmount,st,'%8.2f', true, false, 20, True);
             slimleft (st);
             Accsdatamodule.TempVATDB['AmountText'] := st;
             Accsdatamodule.TempVATDB['Amount'] := RunningAmount;
             st := '';
             DoubleToStr (RunningVat,st,'%8.2f', true, false, 20, True);
             slimleft (st);
             Accsdatamodule.TempVATDB['VATText'] := st;
             Accsdatamodule.TempVATDB['VAT'] := RunningVat;
             Accsdatamodule.TempVATDB.post;
             Accsdatamodule.TempVATDB.append;
             Accsdatamodule.TempVATDB['Label'] := '-----------------------------------------------------------------------------------------------------------------------------------------';          // TGM AB 24/07/15
             Accsdatamodule.TempVATDB.post;
             for j:= 0 to 9 do Begin
                  if VatCodeArray[j].VatCode = PreviousVatCode then begin
                        if SalePurch = 'S' then begin
                                                                VatCodeArray[j].SalesNet := VatCodeArray[j].SalesNet + RunningAmount;
                                                                VatCodeArray[j].SalesVat := VatCodeArray[j].SalesVat + RunningVat;
                                                       end else begin
                                                                VatCodeArray[j].PurchNet := VatCodeArray[j].PurchNet + RunningAmount;
                                                                VatCodeArray[j].PurchVat := VatCodeArray[j].PurchVat + RunningVat;
                                                                end;
                        end;
             End;
             if SalePurch = 'S' then SalesCount := SalesCount + RunningCount
                else PurchCount := PurchCount + RunningCount;
             RunningAmount := 0;
             RunningVat := 0;
             RunningCount := 0;
           end;
        Accsdatamodule.TransactionsDB.prior;

        end; // For i:=

        Accsdatamodule.TransactionsDB.IndexName := '';

        if SalePurch = 'S' then begin
              Accsdatamodule.TempVATDB.edit;
              Accsdatamodule.TempVATDB.append;
              Accsdatamodule.TempVATDB.post;
              Accsdatamodule.TempVATDB.append;
              Accsdatamodule.TempVATDB['Label'] := 'Totals ...';
              Accsdatamodule.TempVATDB.post;
              Accsdatamodule.TempVATDB.append;
              Accsdatamodule.TempVATDB.post;
              Accsdatamodule.TempVATDB.append;
              Accsdatamodule.TempVATDB['Label'] := 'Number Of Records .... ' + VarTostr(SalesCount);
              Accsdatamodule.TempVATDB.post;
              TotalAmount := 0;
              TotalVat := 0;

              for j:= 0 to 9 do Begin
                          if cash2.XCOUNTRY = 1 then begin
                              if VatCodeArray[j].NIInclude = True then begin
                                       TotalAmount := TotalAmount + VatCodeArray[j].SalesNet;
                                       TotalVat := TotalVat + VatCodeArray[j].SalesVat;
                              end;
                          end
                                else begin
                                       TotalAmount := TotalAmount + VatCodeArray[j].SalesNet;
                                       TotalVat := TotalVat + VatCodeArray[j].SalesVat;
                          end;

              end;
              Accsdatamodule.TempVATDB.append;
              Accsdatamodule.TempVATDB.post;
              Accsdatamodule.TempVATDB.append;
              //Ch015                  Accsdatamodule.TempVATDB['Label'] := 'Amount Total (Included in VAT Return) .... ';            //Ch014 was  'Amount Total .... '
              if cash2.XCOUNTRY = 1 then Accsdatamodule.TempVATDB['Label'] := 'Amount Total (Included in VAT Return) .... '           //Ch015
                    else Accsdatamodule.TempVATDB['Label'] := 'Amount Total .... ';                                                   //Ch015
              st := '';
              DoubleToStr (TotalAmount,st,'%8.2f', true, false, 20, True);
              slimleft (st);
              Accsdatamodule.TempVATDB['AmountText'] := st;
              Accsdatamodule.TempVATDB.post;
              Accsdatamodule.TempVATDB.append;
              //Ch015                  Accsdatamodule.TempVATDB['Label'] := 'VAT / Discount (Included in VAT Return) .... ';          //Ch014 was 'VAT / Discount .... '
              if cash2.XCOUNTRY = 1 then Accsdatamodule.TempVATDB['Label'] := 'VAT / Discount (Included in VAT Return) .... '           //Ch015
                    else Accsdatamodule.TempVATDB['Label'] := 'VAT / Discount .... ';                                                   //Ch015
              st := '';
              DoubleToStr (TotalVat,st,'%8.2f', true, false, 20, True);
              slimleft (st);
              Accsdatamodule.TempVATDB['AmountText'] := st;
              Accsdatamodule.TempVATDB.post;
              Accsdatamodule.TempVATDB.append;
              //Ch015                  Accsdatamodule.TempVATDB['Label'] := 'Grand Total (Included in VAT Return) .... ';             //Ch014 was 'Grand Total .... ';
              if cash2.XCOUNTRY = 1 then Accsdatamodule.TempVATDB['Label'] := 'Grand Total (Included in VAT Return) .... '           //Ch015
                    else Accsdatamodule.TempVATDB['Label'] := 'Grand Total .... ';                                                   //Ch015
              st := '';
              DoubleToStr ((TotalAmount+TotalVat),st,'%8.2f', true, false, 20, True);
              slimleft (st);
              Accsdatamodule.TempVATDB['AmountText'] := st;
              Accsdatamodule.TempVATDB.post;
              Accsdatamodule.TempVATDB.append;

              // Ch014 start
              if cash2.XCOUNTRY = 1 then begin
                TotalAmount := 0;
                for j:= 0 to 9 do Begin

                        if VatCodeArray[j].NIInclude = False then begin
                                       TotalAmount := TotalAmount + VatCodeArray[j].SalesNet;
                        end;
                end;

                if TotalAmount <> 0 then begin

                     Accsdatamodule.TempVATDB.edit;
                     Accsdatamodule.TempVATDB.append;
                     Accsdatamodule.TempVATDB.post;
                     Accsdatamodule.TempVATDB.append;
                     Accsdatamodule.TempVATDB['Label'] := 'Exempt Total (Not Included in VAT Return) .... ';
                     st := '';
                     DoubleToStr (TotalAmount,st,'%8.2f', true, false, 20, True);
                     slimleft (st);
                     Accsdatamodule.TempVATDB['AmountText'] := st;
                     Accsdatamodule.TempVATDB.post;

                end

              end;
              // Ch014 end

        end
           else begin
              Accsdatamodule.TempVATDB.edit;
              Accsdatamodule.TempVATDB.append;
              Accsdatamodule.TempVATDB.post;
              Accsdatamodule.TempVATDB.append;
              Accsdatamodule.TempVATDB['Label'] := 'Totals ...';
              Accsdatamodule.TempVATDB.post;
              Accsdatamodule.TempVATDB.append;
              Accsdatamodule.TempVATDB.post;
              Accsdatamodule.TempVATDB.append;
              Accsdatamodule.TempVATDB['Label'] := 'Number Of Records .... ' + VarTostr(PurchCount);
              Accsdatamodule.TempVATDB.post;
              TotalAmount := 0;
              TotalVat := 0;

              for j:= 0 to 9 do Begin
                          if cash2.XCOUNTRY = 1 then begin
                              if VatCodeArray[j].NIInclude = True then begin
                                       TotalAmount := TotalAmount + VatCodeArray[j].PurchNet;
                                       TotalVat := TotalVat + VatCodeArray[j].PurchVat;
                              end;
                          end
                                else begin
                                       TotalAmount := TotalAmount + VatCodeArray[j].PurchNet;
                                       TotalVat := TotalVat + VatCodeArray[j].PurchVat;
                          end;
              end;
              Accsdatamodule.TempVATDB.append;
              Accsdatamodule.TempVATDB.post;
              Accsdatamodule.TempVATDB.append;
              //Ch015                  Accsdatamodule.TempVATDB['Label'] := 'Amount Total  (Included in VAT Return) .... ';                 //Ch014 was  'Amount Total .... '
              if cash2.XCOUNTRY = 1 then Accsdatamodule.TempVATDB['Label'] := 'Amount Total (Included in VAT Return) .... '           //Ch015
                    else Accsdatamodule.TempVATDB['Label'] := 'Amount Total .... ';                                                   //Ch015
              st := '';
              DoubleToStr (TotalAmount,st,'%8.2f', true, false, 20, True);
              slimleft (st);
              Accsdatamodule.TempVATDB['AmountText'] := st;
              Accsdatamodule.TempVATDB.post;
              Accsdatamodule.TempVATDB.append;
              //Ch015                  Accsdatamodule.TempVATDB['Label'] := 'VAT / Discount  (Included in VAT Return) .... ';               //Ch014 was 'VAT / Discount .... '
              if cash2.XCOUNTRY = 1 then Accsdatamodule.TempVATDB['Label'] := 'VAT / Discount (Included in VAT Return) .... '           //Ch015
                    else Accsdatamodule.TempVATDB['Label'] := 'VAT / Discount .... ';                                                   //Ch015
              st := '';
              DoubleToStr (TotalVat,st,'%8.2f', true, false, 20, True);
              slimleft (st);
              Accsdatamodule.TempVATDB['AmountText'] := st;
              Accsdatamodule.TempVATDB.post;
              Accsdatamodule.TempVATDB.append;
              //Ch015                  Accsdatamodule.TempVATDB['Label'] := 'Grand Total  (Included in VAT Return) .... ';                  //Ch014 was 'Grand Total .... ';
              if cash2.XCOUNTRY = 1 then Accsdatamodule.TempVATDB['Label'] := 'Grand Total (Included in VAT Return) .... '           //Ch015
                    else Accsdatamodule.TempVATDB['Label'] := 'Grand Total .... ';                                                   //Ch015
              st := '';
              DoubleToStr ((TotalAmount+TotalVat),st,'%8.2f', true, false, 20, True);
              slimleft (st);
              Accsdatamodule.TempVATDB['AmountText'] := st;
              Accsdatamodule.TempVATDB.post;
              Accsdatamodule.TempVATDB.append;

              // Ch014 start
              if cash2.XCOUNTRY = 1 then begin
                TotalAmount := 0;
                for j:= 0 to 9 do Begin

                        if VatCodeArray[j].NIInclude = False then begin
                                       TotalAmount := TotalAmount + VatCodeArray[j].PurchNet;
                        end;
                end;

                if TotalAmount <> 0 then begin

                     Accsdatamodule.TempVATDB.edit;
                     Accsdatamodule.TempVATDB.append;
                     Accsdatamodule.TempVATDB.post;
                     Accsdatamodule.TempVATDB.append;
                     Accsdatamodule.TempVATDB['Label'] := 'Exempt Total (Not Included in VAT Return) .... ';
                     st := '';
                     DoubleToStr (TotalAmount,st,'%8.2f', true, false, 20, True);
                     slimleft (st);
                     Accsdatamodule.TempVATDB['AmountText'] := st;
                     Accsdatamodule.TempVATDB.post;

                end

              end;
              // Ch014 end

           end;



  //   Accsdatamodule.SQLUpdate.sql.clear;
  //   Accsdatamodule.SQLUpdate.sql.Add('alter table "Year-1"');
  //   Accsdatamodule.SQLUpdate.sql.Add('Drop INDEX ByTaxCode');
  //   Accsdatamodule.SQLUpdate.ExecSQL;

  //   Accsdatamodule.SQLUpdate.sql.clear;
  //   Accsdatamodule.SQLUpdate.sql.Add('Drop INDEX ON "Transactions"');
  //   Accsdatamodule.SQLUpdate.ExecSQL;


        

end;



// End Invoice based VAT

// Ch006(P) Start

// These Procedures are all for Payment Based VAT

Procedure PaymentVatAuditTrail(SalePurch : Char; MarkasClaimed : Boolean; ClaimID : Integer; SpanYear : Boolean);
Type TTempArray = record
      VatCode : String[1];
      Total : Real;
      VAT : Real;
   end;

var
        i,j,K, ID : integer;
        st : shortstring;
        SalesTotal, SalesVAT, TempVAT : real;
        PurchaseTotal, PurchaseVAT : real;
        QueryDateFrom, QueryDateTo : String;
        TempArray:array[0..9] of TTempArray;
        TotalAmount, TotalVAT : Real;
        TotalExempt : Real;



begin
  //      if SalePurch = 'S' then Showmessage('Code goes here to generate Sales Payment Based Figures');
  //      if SalePurch = 'P' then Showmessage('Code goes here to generate Purchase Payment Based Figures');


     QueryDateFrom :=  formatdatetime('mm/dd/yy', FromDT);
     QueryDateTo :=  formatdatetime('mm/dd/yy', ToDT);

    // Initialising The Temp Array
                                                                                  
    for j:= 0 to 9 do Begin
                       uPaymentVAT.TempArray[j].VatCode := Cash1.xTaxIds[j];
                       uPaymentVAT.TempArray[j].Total := 0;
                       uPaymentVAT.TempArray[j].VAT := 0;
    end;

    for j:= 0 to 9 do Begin
                       uvatreps.VatArray[j].VatCode := Cash1.xTaxIds[j];
                       if Cash2.Vat_inc_exc[j] = 'I' then uvatreps.VatArray[j].NIInclude := True
                        else uvatreps.VatArray[j].NIInclude := false;
    End;


     AccsDatamodule.AllocatedVATDB.Open;
    
     // sales

     if (SalePurch = 'S' ) then begin

     SalesTotal := 0;
     SalesVAT := 0;

     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB['Label'] := 'SALES RECEIPT AUDIT TRAIL';
     Accsdatamodule.TempVATDB['Description'] := '*/# Denotes Previous Yrs';
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB['Label'] := '========================================';
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB.post;

     // Process Previous Year

     if ((SpanYear) and (FileExists(Accsdata.AccsDataModule.AccsDataBase.Directory + 'AllocatedVAT-1.db'))) then begin

     AccsDatamodule.VATReportQuery.close;
     AccsDatamodule.VATReportQuery.SQL.Clear;

     AccsDatamodule.VATReportQuery.SQL.add('Select * from "Year-1"');
     AccsDatamodule.VATReportQuery.SQL.add('where ((TxType = 2) or (TxType = 12))');
     AccsDatamodule.VATReportQuery.SQL.add('and (txdate <= ''' + QueryDateTo + ''')');
     AccsDatamodule.VATReportQuery.SQL.add('order by txno desc');
     AccsDatamodule.VATReportQuery.open;

     AccsDatamodule.VATReportQuery.first;

     for i:=1 to AccsDatamodule.VATReportQuery.recordcount do begin
        // try and locate record in allocatedVAT table otherwise leave the transaction out

        AccsDatamodule.AllocatedVATDBYr1.open;

        AccsDatamodule.AllocatedVATDBYr1.filter := 'PaymentID = ' + vartostr(AccsDatamodule.VATReportQuery['TxNo']);
        AccsDatamodule.AllocatedVATDBYr1.filtered := true;

        if  AccsDatamodule.AllocatedVATDBYr1.RecordCount > 0 then begin

        if AccsDatamodule.AllocatedVATDBYr1['VATProcessed'] <> True then begin

          if MarkasClaimed then begin

                ID :=  AccsDatamodule.VATReportQuery['TxNo'];

                Accsdatamodule.SQLUpdate.sql.clear;
                Accsdatamodule.SQLUpdate.sql.Add('Update "AllocatedVAT-1" set VATProcessed = true, ReturnID = ' + vartostr(ClaimID) + ' where InvoiceID <> 0 and PaymentID = ' + vartostr(ID));
                Accsdatamodule.SQLUpdate.ExecSQL;

          end;

          Accsdatamodule.TempVATDB.append;
          Accsdatamodule.TempVATDB['Record'] := AccsDatamodule.VATReportQuery['TxNo'];
          Accsdatamodule.TempVATDB['TxDate'] := AccsDatamodule.VATReportQuery['TxDate'];
          Accsdatamodule.TempVATDB['Reference'] := AccsDatamodule.VATReportQuery['Reference'];
          Accsdatamodule.TempVATDB['Description'] := AccsDatamodule.VATReportQuery['Descript'];
          Accsdatamodule.TempVATDB['PreviousYear'] := '*';
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

          uPaymentVAT.GatherInvoicesYr1(AccsDatamodule.VATReportQuery['TxNo']);


        end; // if not processed

        end; // >0


          AccsDatamodule.AllocatedVATDBYr1.filtered := false;
          AccsDatamodule.AllocatedVATDBYr1.filter := '';
          AccsDatamodule.VATReportQuery.next;

     end;

     end;  // span year

     // Process this year


     AccsDatamodule.VATReportQuery.close;
     AccsDatamodule.VATReportQuery.SQL.Clear;

     AccsDatamodule.VATReportQuery.SQL.add('Select * From Transactions');
     AccsDatamodule.VATReportQuery.SQL.add('where ((TxType = 2) or (TxType = 12))');
     AccsDatamodule.VATReportQuery.SQL.add('and (txdate <= ''' + QueryDateTo + ''')');
     AccsDatamodule.VATReportQuery.SQL.add('order by txno desc');
     AccsDatamodule.VATReportQuery.open;

     AccsDatamodule.VATReportQuery.first;

     for i:=1 to AccsDatamodule.VATReportQuery.recordcount do begin
        // try and locate record in allocatedVAT table otherwise leave the transaction out

        AccsDatamodule.AllocatedVATDB.filter := 'PaymentID = ' + vartostr(AccsDatamodule.VATReportQuery['TxNo']);
        AccsDatamodule.AllocatedVATDB.filtered := true;

        if  AccsDatamodule.AllocatedVATDB.RecordCount > 0 then begin

        AccsDatamodule.AllocatedVATDB.First;

  //    Ch015bf     for K:= 1 to AccsDatamodule.AllocatedVATDB.RecordCount do begin              // uPaymentVAT.GatherInvoices gathers all the invoices so as long as there is one line (don't need to repeat for each line)

        if AccsDatamodule.AllocatedVATDB['VATProcessed'] <> True then begin

          if MarkasClaimed then begin

                ID :=  AccsDatamodule.VATReportQuery['TxNo'];

                Accsdatamodule.SQLUpdate.sql.clear;
                Accsdatamodule.SQLUpdate.sql.Add('Update "AllocatedVAT" set VATProcessed = true, ReturnID = ' + vartostr(ClaimID) + ' where InvoiceID <> 0 and PaymentID = ' + vartostr(ID));
                Accsdatamodule.SQLUpdate.ExecSQL;

          end;

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

          uPaymentVAT.GatherInvoices(AccsDatamodule.VATReportQuery['TxNo']);

        end; // if not processed

   //    Ch015bf     AccsDatamodule.AllocatedVATDB.next;

   //    Ch015bf     end; // for k

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

     TotalAmount := 0;
     TotalVAT := 0;
     TotalExempt := 0;

    end;   // sales


     // purchases

     if (SalePurch = 'P' ) then begin

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
     Accsdatamodule.TempVATDB['Description'] := '*/# Denotes Previous Yrs';
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB['Label'] := '========================================';
     Accsdatamodule.TempVATDB.post;
     Accsdatamodule.TempVATDB.append;
     Accsdatamodule.TempVATDB.post;


     // Process Previous Year

     if ((SpanYear) and (FileExists(Accsdata.AccsDataModule.AccsDataBase.Directory + 'AllocatedVAT-1.db'))) then begin


     AccsDatamodule.VATReportQuery.close;
     AccsDatamodule.VATReportQuery.SQL.Clear;

     AccsDatamodule.VATReportQuery.SQL.add('Select * From "Year-1"');
     AccsDatamodule.VATReportQuery.SQL.add('where ((TxType = 6) or (TxType = 16))');
     AccsDatamodule.VATReportQuery.SQL.add('and (txdate <= ''' + QueryDateTo + ''')');
     AccsDatamodule.VATReportQuery.SQL.add('order by txno desc');
     AccsDatamodule.VATReportQuery.open;

     AccsDatamodule.VATReportQuery.first;

     for i:=1 to AccsDatamodule.VATReportQuery.recordcount do begin
        // try and locate record in allocatedVAT table otherwise leave the transaction out

        AccsDatamodule.AllocatedVATDBYr1.filter := 'PaymentID = ' + vartostr(AccsDatamodule.VATReportQuery['TxNo']);
        AccsDatamodule.AllocatedVATDBYr1.filtered := true;

        if  AccsDatamodule.AllocatedVATDBYr1.RecordCount > 0 then begin

        if AccsDatamodule.AllocatedVATDBYr1['VATProcessed'] <> True then begin

          if MarkasClaimed then begin

                ID :=  AccsDatamodule.VATReportQuery['TxNo'];

                Accsdatamodule.SQLUpdate.sql.clear;
                Accsdatamodule.SQLUpdate.sql.Add('Update "AllocatedVAT-1" set VATProcessed = true, ReturnID = ' + vartostr(ClaimID) + ' where InvoiceID <> 0 and PaymentID = ' + vartostr(ID));
                Accsdatamodule.SQLUpdate.ExecSQL;

          end;

          Accsdatamodule.TempVATDB.append;
          Accsdatamodule.TempVATDB['Record'] := AccsDatamodule.VATReportQuery['TxNo'];
          Accsdatamodule.TempVATDB['TxDate'] := AccsDatamodule.VATReportQuery['TxDate'];
          Accsdatamodule.TempVATDB['Reference'] := AccsDatamodule.VATReportQuery['Reference'];
          Accsdatamodule.TempVATDB['Description'] := AccsDatamodule.VATReportQuery['Descript'];
          Accsdatamodule.TempVATDB['PreviousYear'] := '*';
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

          uPaymentVAT.GatherInvoicesYr1(AccsDatamodule.VATReportQuery['TxNo']);

        end; // if not processed

        end; // >0

          AccsDatamodule.AllocatedVATDBYr1.filtered := false;
          AccsDatamodule.AllocatedVATDBYr1.filter := '';
          AccsDatamodule.VATReportQuery.next;

     end;


    end;



     // Process this year

     AccsDatamodule.VATReportQuery.close;
     AccsDatamodule.VATReportQuery.SQL.Clear;

     AccsDatamodule.VATReportQuery.SQL.add('Select * From Transactions');
     AccsDatamodule.VATReportQuery.SQL.add('where ((TxType = 6) or (TxType = 16))');
     AccsDatamodule.VATReportQuery.SQL.add('and (txdate <= ''' + QueryDateTo + ''')');
     AccsDatamodule.VATReportQuery.SQL.add('order by txno desc');
     AccsDatamodule.VATReportQuery.open;

     AccsDatamodule.VATReportQuery.first;

     for i:=1 to AccsDatamodule.VATReportQuery.recordcount do begin
        // try and locate record in allocatedVAT table otherwise leave the transaction out

        AccsDatamodule.AllocatedVATDB.filter := 'PaymentID = ' + vartostr(AccsDatamodule.VATReportQuery['TxNo']);
        AccsDatamodule.AllocatedVATDB.filtered := true;

        if  AccsDatamodule.AllocatedVATDB.RecordCount > 0 then begin

        if AccsDatamodule.AllocatedVATDB['VATProcessed'] <> True then begin

          if MarkasClaimed then begin

                ID :=  AccsDatamodule.VATReportQuery['TxNo'];

                Accsdatamodule.SQLUpdate.sql.clear;
                Accsdatamodule.SQLUpdate.sql.Add('Update "AllocatedVAT" set VATProcessed = true, ReturnID = ' + vartostr(ClaimID) + ' where InvoiceID <> 0 and PaymentID = ' + vartostr(ID));
                Accsdatamodule.SQLUpdate.ExecSQL;

          end;

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

          uPaymentVAT.GatherInvoices(AccsDatamodule.VATReportQuery['TxNo']);

        end; // if not processed

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



  end;        // Purchases



end;

Procedure AddPaymentVATTotals;
var
        j : integer;
begin


     // This adds the payment totals into the overall VAT totals

     for j := 0 to 9 do begin

           VatCodeArray[j].SalesNet := VatCodeArray[j].SalesNet +  uVATReps.VatArray[j].SalesNet;
           VatCodeArray[j].SalesVat := VatCodeArray[j].SalesVAT +  uVATReps.VatArray[j].SalesVAT;
           VatCodeArray[j].PurchNet := VatCodeArray[j].PurchNet +  uVATReps.VatArray[j].PurchNet;
           VatCodeArray[j].PurchVat := VatCodeArray[j].PurchVAT +  uVATReps.VatArray[j].PurchVAT;


      end;

end;


Function OverpaymentCheck : Boolean;
var
        MyQuery : TQuery;

begin


     // This checks for any payments with overpayments

               Result := False;

               MyQuery := TQuery.create(nil);
               Myquery.DatabaseName := accsdatamodule.AccsDataBase.databasename;
               MyQuery.SQL.clear;
               MyQuery.SQL.add ('Select * From TempVAT where Description = ''Overpayment''');
               MyQuery.open;



               if MyQuery.recordcount > 0 then Result := True;

               MyQuery.close;
               MyQuery.free;


end;




// End Payment based VAT

// Ch006(P) End



// Ch036 start

Procedure MarkInvoicesAsClaimed(ClaimID : Integer);   //Ch036
begin


        Accsdatamodule.TempVATDB.open;
        Accsdatamodule.TempVATDB.first;

        Accsdatamodule.TransactionsYr1DB.open;


        while not Accsdatamodule.TempVATDB.eof do begin

                // filter out the lines that have transactions only

                if Accsdatamodule.TempVATDB.fieldbyname('Record').asstring <> null then begin

                        if Accsdatamodule.TempVATDB.fieldbyname('PreviousYear').asstring = null then begin    // Tx's in this year

                                if Accsdatamodule.TransactionsDB.locate('TxNo',Accsdatamodule.TempVATDB['Record'],[]) then begin
                                        Accsdatamodule.TransactionsDB.Edit;
                                        Accsdatamodule.TransactionsDB['VATProcessed'] := true;
                                        Accsdatamodule.TransactionsDB['ReturnID'] := ClaimID;
                                        Accsdatamodule.TransactionsDB.post;
                                end;


                        end else begin      // Tx's in last year

                                if Accsdatamodule.TransactionsYr1DB.locate('TxNo',Accsdatamodule.TempVATDB['Record'],[]) then begin
                                        Accsdatamodule.TransactionsYr1DB.Edit;
                                        Accsdatamodule.TransactionsYr1DB['VATProcessed'] := true;
                                        Accsdatamodule.TransactionsYr1DB['ReturnID'] := ClaimID;
                                        Accsdatamodule.TransactionsYr1DB.post;
                                end;


                        end;

                end;   // <> null

               Accsdatamodule.TempVATDB.next;

          end;


end;


//Ch036 End

end.
