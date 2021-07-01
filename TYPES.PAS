{
  File	    : U-DB:TYPES.TEXT
  Unit	    : DB_TYPES
  Prefix    :
  Status    : Finished
  Level	    : 1

  DATE'S
  Started   : 23-04-92
  Finished  : 23-04-92

  This unit contains the type declarations for the main program.  This is unit
  level one which means that every other unit and segment procedure need to use
  and access it.

  30/10/18 [V4.3 R2.5] /MK Change - Invoicer is now assigned by module not existence of Invoice file - GL request.

  11/12/18 [V4.3 R3.0] /MK Change - Created a string array of serial numbers from customer interface that have the invoicer module.  
}

Unit TYPES;


{-----------------------------------------------------------------------------}
{--------------------------------  INTERFACE  --------------------------------}
{-----------------------------------------------------------------------------}

Interface

Uses
    Forms,
    StdCtrls,
    SysUtils,
    KRoutines;

Const
  MaxGridLines = 100; // 44 lines is the maximum which can be opened again.  more than this can be saved,
                      // but invoices with more than 44 won't open for editing.
  SysName = 'KINGSWOOD ACCOUNTS';
  VerNo = 'V4.5 R6.1';
  // 'V4.5 R0.0.3'; Changes including Comment on the Simple Invoice Grid, Allow VAT Amount to be changed by user, delete row
  ShortVerNo = '4561';

  // MK 03/09/13 - Add all changes to ChangeLog.txt.

  CDateFrom = -32760;
  CdateTo = 32760;
  CurrLang = 1;
  pass1_level = 'CONFIG';
  pass2_level = 'DOLLY';

  MEMERR      = 'INTERNAL PROGRAM ERROR ';
  SECERR      = 'SECURITY ERROR';
  DEFERR      = 'ACCESSING DEFINITION ';
  SEQERR      = 'ACCESSING SEQUENCE FILE ';
  INVERR      = 'ACCESSING INVOICE DEFINITION ';
  FARMGATE    = 'FARMGATE.DEF';
  //INVOICER    = 'CASHBOOK.INV';
  CASHBOOK    = 'CASHBOOK.DEF';
  helpmenu    = 'CASHMENU.HLP';
  HELPNAME    = 'CASHBOOK.HLP';
  MASTMENU    = 'FARMGATE.MEN';
  SORTWORK    = 'SORTWORK.ACC';
  MISCWORK    = 'MISCWORK.ACC';
  DASH40      = '----------------------------------------';
  NULL	      = '';
  QUERY	      = '?';
  SUFFIX      = 'FDB';
  FILLSPARE   = 162;

  DOS_BLK_MAX = 8;
  MAXITEMS    = 160;
  MAXISIZE    = 64;
  MAXACCS     = 9999;
  MAXINDEX    = 2048;

  loan_scr     = 1;		    { used in loan repayments segment txs }
  interest_scr = 2;		  { used in interest repayments segment txs }
  s_order      = 3;		    {  "    "  standing order	     "	   "  }
  reg_trans    = 4;		    {  "    "  regular transfers     "	   "  }
  user_defined = 5;		    {  "    "  user defined journals "	   "  }
  take_out_scr = 6;		    { take out loan screen		      }
  lease_scr    = 98;		    { take out Lease screen		      }
  take_hp_out  = 99;		    { take out HP screen		      }

  sal_pur      = 5;		    { list sal/purch transactions	      }
  all_nom      = 6;		    { list all nominal codes		      }
  all_supp_cust = 7;		    { list all suppliers/customers	      }
  all_ents     = 8;		    { list all enterprises		      }
  all_vat      = 9;		    { list all Vat code & rates		      }
  all_grp      = 10;		    { list all Stock groups		      }
  all_stk      = 11;		    { list all stock items		      }
  all_anl      = 12;		    { list all analysis codes		      }
  all_live     = 13;		    { list all Livestock codes		      }
  all_rep_grp  = 14;		    { list all the Report Groups	      }
  all_invoice  = 15;		    { list invoice layout		      }
  zero	       = '0';

  { Max_Dbs      = 6;	}	 { max. number of databases allowed }
  MaxDatabases  = 15;       	 { max. number of databases allowed }
  MaxFiles      = 20;
  TDateFormat   = 'DD/MM/YY';	       { Standard date format }
  Space1       = ' ';
  Space2       = '  ';
  Space3       = '   ';
  Space4       = '    ';
  Space5       = '     ';
  Space6       = '      ';
  Space8       = '        ';
  Space10      = '          ';
  Space12      = '            ';
  Space15      = '               ';
  Space20      = '                    ';
  Space25      = '                         ';
  Space30      = '                              ';
  Space40      = '                                        ';

  UPDENT       = 1;
  UPDCUST      = 2;
  UPDSUPP      = 3;
  UPDNOM       = 4;
  ANNBUD       = 5;
  ANALYSE      = 6;
  ENDREP       = 61;
  ENDMONTH     = 62;
  ENDYEAR      = 63;
  ENDWEEK      = 64;
  VATRATE      = 65;		     (* to access VAT RATES *)
  CASHINC      = 11;
  CASHEXP      = 12;
  SALESTX      = 13;
  PURCHTX      = 14;
  JOURNAL      = 15;
  CUSTREP      = 21;
  CUSTSTM      = 22;
  CUSTLED      = 23;
  SUPPREP      = 24;
  SUPPSTM      = 25;
  SUPPLED      = 26;
  ENTREP       = 27;
  SPECREP      = 28;
  CASHREP      = 29;
  EVDIARY      = 32;
  CUSTREC      = 41;
  SUPPREC      = 42;
  CUSTSUM      = 43;
  SUPPSUM      = 44;
  SECRET       = 55;
  CANCEL       = 66;
  live_links   = 43;  { sets prog for livestock links }
  TxFillGrid   = 44;  { Set for Filling Grid }

  { File Identifiers }
  EntFile    = 1;
  TxFile     = 2;
  NewTxFile = 2;
  NlFile     = 3;
  SlFile     = 4;
  PlFile     = 5;
  AnalFile   = 6;

  SlStateFile = 9;
  PlStateFile = 10;
  SortFileNo  = 11;
  TxFileYr1  = 12;
  LastTxFile = 12;
  LastNlFile  = 13;
  ImportFile = 14;
  TxFileYr2 = 15;
  FarmFile   = 16;
  CashFile   = 17;
  HelpFile   = 18;
  WorkFile   = 19;

  MAXACCRANGE = 6;   { Set the last element in TAccRange Type }
  cBankFile = 'BankFile.Dat';

  cCRLF = #13#10;
  cCRLFx2 = cCRLF+cCRLF;
  cCRLFx3 = cCRLFx2+cCRLF;

  cDefaultCurrencyFormat = ',0.00;-0.00';
  cEmptyCurrencyValue = '0.00';

  { Date/Time Format Consts }
  cmmddyyyy = 'mm/dd/yyyy';
  cddmmyyyy = 'dd/mm/yyyy';
  cddmmyyyyhhnn = cddmmyyyy + ' hh:nn';

  { Nominal Account Types }
  cNomAcc_EnterpriseIncome = 'Enterprise Income';
  cNomAcc_NonEnterpriseIncome = 'Non-Enterprise Income';
  cNomAcc_EnterpriseExpenditure = 'Enterprise Expenditure';
  cNomAcc_Overheads = 'Overheads';
  cNomAcc_CurrentAssets = 'Current Assets';
  cNomAcc_FixedAssets = 'Fixed Assets';
  cNomAcc_Liabilities = 'Liabilities';
  cNomAcc_Banks = 'Banks';
  cNomAcc_AllAccounts = 'All Accounts';
  cNomAcc_ControlAccounts = 'Control Accounts';

  cBankRecLow = 801;
  cBankRecHigh = 820;

  cControlAccNo = 854;
  cCurrentBankAccNo = cBankRecLow;

  Months : array[1..12] of string = ('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');
  ShortMonths : array[1..12] of string = ('JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEPT', 'OCT', 'NOV', 'DEC');

  cFileOverwrite = 'File already exists, do you want to overwrite?';
  cFileCreated = 'File succesfully created - "%s"';
  cFileCreateError = 'Error creating file.';

  cDairyEnterpriseName = 'DAIRY';

  cQRPDFLibLocation = 'C:\Windows\System32\qrpdflib.dll';
  cQRPDFLibFile = 'qrpdflib.dll';

  cNomProdRelationship_OnetoOne = 'One to One';
  cNomProdRelationship_OnetoMany = 'One to Many';
  cNomProdRelationship_ManytoMany = 'Many to Many';

  SalesInvoiceLineId          = 1;
  SalesReceiptLineId          = 2;
  SalesCreditNoteLineId       = 3;
  PurchaseInvoiceLineId       = 5;
  PurchasePaymentLineId       = 6;
  PurchaseCreditNoteLineId    = 7;
  DetailLineId                = 9;
  VATDetailLineId             = 0;
  CashBookIncomeHeaderLineId  = 11;
  CashBookIncomeFooterLineId  = 12;
  CashBookExpenseHeaderLineId = 15;
  CashBookExpenseFooterLineId = 16;
  StandingOrderHeaderLineId   = 15; // Same as CashBookExpenseHeaderLineId
  StandingOrderFooterLineId   = 16; // Same as CashBookExpenseFooterLineId

  // SP 06/2016
  ProductUnitTypes : array[0..5] of string = ('ACRE', 'BALE', 'HECTARE', 'HOUR', 'TONNE', 'OTHER');

  SalesTxDescTypes : array[0..4] of Integer = (15, 16, 17, 21, 46);
  PurchaseTxDescTypes : array[0..4] of Integer = (18, 19, 20, 22, 47);

  SerialNosWithInvoicerMod : array [0..201] of String = ('1067','1179','1189','1284','1349','1366','1413','1483','1523','1629','1670','1699','1710','1717','1726',
                                                         '1885','1896','1923','1940','1962','1964','1980','2006','2019','2036','2071','2089','2095','2102','2114',
                                                         '2139','2161','2171','2177','2188','3188','3351','3359','3417','3449','3465','3470','3474','3476','3500',
                                                         '3511','3519','3528','3529','3533','3554','3559','3571','3574','3575','3576','3605','3650','3664','3675',
                                                         '3676','3679','3681','3691','3732','3749','3762','3808','3918','3950','3961','3986','4009','4022','4129',
                                                         '4280','4281','4295','4299','4431','4699','4717','4788','4857','4858','4883','4937','4964','4982','4992',
                                                         '5021','5056','5069','5091','5098','5154','5160','5295','5299','5405','5427','5430','5431','5445','5448',
                                                         '5455','5463','5464','5466','5469','5504','5505','5511','5512','5515','5519','5521','5523','5585','5612',
                                                         '6021','6113','6144','6173','6181','6265','6301','6309','6369','6385','6399','6503','6557','6640','6738',
                                                         '6766','6773','6775','6934','6950','6955','7007','7028','7053','7059','7091','7309','7313','7314','7317',
                                                         '7335','7342','7343','7348','7385','7388','7394','7395','7396','7397','7398','7399','7400','7401','7402',
                                                         '7403','7404','7406','7412','7415','7416','7417','7418','7419','7420','7421','7422','7423','7426','7430',
                                                         '7432','7433','7439','7447','7456','7477','7544','7601','7623','7770','7783','7850','7875','7949','7969',
                                                         '7970','7996','8155','8205','8262','8591','8624');

  AccountSyncFiles : array[0 .. 14] of String = ('FarmSync.exe', 'FarmSync.exe.config', 'Kingswood.CookieManager.dll', 'Kingswood.Encryption.dll',
                                                 'Kingswood.Extensions.dll', 'Kingswood.Farm.Client.Services.dll', 'Kingswood.Logger.dll',
                                                 'Kingswood.Messaging.dll', 'Newtonsoft.Json.dll', 'Newtonsoft.Json.xml', 'System.Net.Http.dll',
                                                 'System.Net.Http.Formatting.dll', 'System.Net.Http.Formatting.xml', 'WebApiRestService.WebApiClient.dll',
                                                 'WebApiRestService.WebApiClient.xml');

  cIncome = 'Receipt';
  cExpense = 'Payment';

Type
  TTransactionType = (ttNone, ttIncome, ttExpense, ttOther);
  tBankRec = Record
       BankCode : SmallInt;
       Balance  : Packed Array [1..8] Of Char;
  End;

  // SP
  TJobCardRecord = packed record
     NominalId : Integer;
     NominalDescription : string[255];
     Quantity : Double;
     ProductId : Integer;
     JobDate : TDateTime;
     //   09/04/18 [V4.3 R0.6] /MK Additional Feature - Allow for more than 30 chars to be brought in from JobCard App.
     Comment1,
     Comment2 : string;
     JobReference: string;
  end;

  tBankFile = File Of tBankRec;

  DW_TYPE = Packed Array [1..1024] Of Char;
  ID_TYPE = Packed Array [1..MAXINDEX] Of Char;
  CHAR2   = packed array [0..1] of char;

  DB_STORE_TYPE = Packed Record
    DBFILLS:	  PACKED ARRAY[1..2] OF CHAR;
    DBVERSION:	  SmallInt;
    DBVERSION1:  SmallInt;
    DBVERSION2:  SmallInt;
    DBNAME:	  String[31];
    DBLOCKING:	  String[9];
    DBDATEUPD:	  String[9];
    DBLOCKID:	  String[9];
    DBRECSZ:	  SmallInt;
    DBINDEX1:	  SmallInt;
    DBRECNO:	  CHAR2;
    DBINDEX2:	  SmallInt;
    DBINDSTAT:	  CHAR2;
    DBRECTOT:	  SmallInt;
    DBTABTOT:	  SmallInt;
    DBIND1S:	  SmallInt;
    DBIND1T:	  SmallInt;
    DBIND2S:	  SmallInt;
    DBIND2T:	  SmallInt;
    DBTABS:	  SmallInt;
    DBTABT:	  SmallInt;
    DBDATAS:	  SmallInt;     //
    DBDATAT:	  SmallInt;     //
    DBRECHIGH:	  Integer;   // was smallint
    DBRECBLK:	  SmallInt;
    DBIND1BLK:	  SmallInt;
    DBIND2BLK:	  SmallInt;
    DBSORTWORK:  String[19];
    DBSPARE:	  SmallInt;     //
    DBPAGETHROW: CHAR2;
    DBPASS:	  String[11];
    DBIND3S:	  SmallInt;
    DBIND3T:	  SmallInt;
    DBINDEX3:	  SmallInt;
    DBIND3BLK:	  SmallInt;
    DBUPDPASS:	  PACKED ARRAY[1..3] OF String[11];
    DBMASTPASS:  String[11];
    DBWAIT:	  SmallInt;
    DBITEMTOT:	  SmallInt;
    DBITEMBLKS:  SmallInt;
    DBMUSTART:	  SmallInt;
    DBMUBLKS:	  SmallInt;
    DBSPSTART:	  SmallInt;
    DBSPBLKS:	  SmallInt;
    DBSCRSTART:  SmallInt;
    DBSCRBLKS:	  SmallInt;
    DBBITSTART:  SmallInt;
    DBBITBLKS:	  SmallInt;
    DBUSER:	  PACKED ARRAY[1..20] OF SmallInt;
    DBFILLEND:	  PACKED ARRAY[1..FILLSPARE] OF CHAR;
    DBCFILL:	  PACKED ARRAY[1..88] OF CHAR;

    DBITEMS:	  PACKED ARRAY[1..MAXITEMS] OF RECORD
      DBIFILL:	  PACKED ARRAY[1..2] OF CHAR;
      DBINAME:	  String[11];
      DBITYPE:	  CHAR2;
      DBIOFSET:  SmallInt;
      DBIRECSZ:  SmallInt;
      DBISIZE:	  SmallInt;
      DBICALC:	  PACKED ARRAY[1..10] OF CHAR;
    END;

  End;

  DB_HOLD_TYPE = Packed Record
    HEADER     : DB_STORE_TYPE;
    DATA_WORK  : DW_TYPE;
    INDEX_TYPE : ID_TYPE;
  End;

  { packed array of index reference }
  DOS_FILE  = array[0..49] Of SmallInt;
  DS_DESC   = ^SmallInt;
  DOS_BLK   = Packed array [0..511] Of Char;
  Integer2  = longint;

  STRING80    = ShortString{[80]};
  STRING132   = ShortString{[132]};
  STRING255   = ShortString{[255]};
  ShortLong = longint;	    { small long var used in program }
  Long	    = longint;	    { Long var used throughtout the prg }
  BigLong   = longint;	    { Larger then long var }
  DDOUBLE   = PACKED ARRAY [1..2] OF 0..9;

  TAccRange = Packed Array [1..MAXACCRANGE] Of Integer;
  TRange = ( AllNoms, AllNomsPlusCapital, Liab, FAsset, CAsset, Banks, OverHeads, OverHeadsWithExpense,
             EntRange, AllNomsXBank, Customers, Suppliers, Enterprise, Vat, NonEnt,
             Analysis, CustLedgerCards,SuppLedgerCards, EntAllIncome, EntAllExpend, NonEntToLiab, OverheadsToLiab, AllNomsPlusCapitalLessControl );

  LISTBAL = PACKED ARRAY [1..6] OF Double{LONG};
  LISTCOLS = PACKED ARRAY [1..13] OF Double{LONG};

  YEARVAL  = PACKED ARRAY [1..13] OF Double{LONG};
  GROUPVAL = PACKED ARRAY [1..4]  OF PACKED ARRAY [1..999] OF SmallInt;

  TxEditType = Packed Record
      TransF : LongInt;
      TransT : LongInt;
      TransType : String{[2]};
      NoRecs    : SmallInt;
      TxRow     : SmallInt;
      TxType   : Packed Array [1..((MaxGridLines*2) +2)] Of SmallInt; // TENFOUND 22
      TxNo     : Packed Array [1..((MaxGridLines*2) +2)] Of SmallInt; // TENFOUND 22
  End;

  TDateStyle = (dsIrish, dsUS);

  TDynamicStringArray = array of string;

  TJobCardViewType = (vtToBeImported, vtImported, vtAll);

  procedure CreateAndShowForm ( const WhichForm : TFormClass );
  function Invoicer: Boolean;

{-----------------------------------------------------------------------------}
{-----------------------------	IMPLEMENTATION	------------------------------}
{-----------------------------------------------------------------------------}

Implementation
uses accsdata, Vars;


// Create and Show a Form then when closed it destroys the Form.
procedure CreateAndShowForm ( const WhichForm : TFormClass );
begin
     With WhichForm.Create(nil) Do
     Try
        ShowModal;
     Finally
        Free;
     end;
end;

function Invoicer: boolean;
begin
   //   30/10/18 [V4.3 R2.5] /MK Change - Invoicer is now assigned by module not existence of Invoice file - GL request.
   Result := ( Cash2.XWININV );
end;

Begin
{-----------------------------	INITIALIZATION	------------------------------}

{-------------------------------  TERMINATION  -------------------------------}


End.
