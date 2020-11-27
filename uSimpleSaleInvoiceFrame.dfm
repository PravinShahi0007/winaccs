inherited SimpleSaleInvoiceFrame: TSimpleSaleInvoiceFrame
  Width = 1222
  Height = 663
  Font.Height = -13
  Font.Name = 'Segoe UI'
  object GridContainerPanel: TPanel [0]
    Left = 0
    Top = 118
    Width = 1222
    Height = 545
    Align = alClient
    BevelOuter = bvNone
    Caption = 'GridContainerPanel'
    TabOrder = 0
    object SalesInvoiceGrid: TcxGrid
      Left = 55
      Top = 0
      Width = 1112
      Height = 471
      Align = alClient
      PopupMenu = PopupMenu
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      object SalesInvoiceGridTableView: TcxGridTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoFocusTopRowAfterSorting, dcoImmediatePost]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        DataController.OnAfterInsert = SalesInvoiceGridTableViewDataControllerAfterInsert
        OptionsData.Appending = True
        OptionsSelection.HideFocusRectOnExit = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.UnselectFocusedRecordOnExit = False
        OptionsView.ShowEditButtons = gsebAlways
        OptionsView.ColumnAutoWidth = True
        OptionsView.DataRowHeight = 22
        OptionsView.GroupByBox = False
        OptionsView.HeaderHeight = 40
        OptionsView.Indicator = True
        OptionsView.IndicatorWidth = 15
      end
      object SalesInvoiceGridLevel: TcxGridLevel
        GridView = SalesInvoiceGridTableView
      end
    end
    object LeftPanel: TPanel
      Left = 0
      Top = 0
      Width = 55
      Height = 471
      Align = alLeft
      BevelOuter = bvNone
      Color = clMenu
      TabOrder = 1
    end
    object RightPanel: TPanel
      Left = 1167
      Top = 0
      Width = 55
      Height = 471
      Align = alRight
      BevelOuter = bvNone
      Color = clMenu
      TabOrder = 2
    end
    object FooterPanel: TPanel
      Left = 0
      Top = 471
      Width = 1222
      Height = 74
      Align = alBottom
      BevelOuter = bvNone
      Color = clMenu
      TabOrder = 3
    end
  end
  object HeaderPanel: TPanel [1]
    Left = 0
    Top = 0
    Width = 1222
    Height = 118
    Align = alTop
    BevelOuter = bvNone
    Color = clMenu
    TabOrder = 1
    object SaleInvHeadBevel: TBevel
      Left = 55
      Top = 9
      Width = 1113
      Height = 112
      Anchors = [akLeft, akTop, akRight]
      Shape = bsFrame
    end
    object Label1: TLabel
      Left = 404
      Top = 32
      Width = 99
      Height = 17
      Caption = 'No. Of Invoices:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 584
      Top = 32
      Width = 152
      Height = 17
      Caption = 'Current Invoice Amount:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel2: TBevel
      Left = 384
      Top = 24
      Width = 1
      Height = 34
      Shape = bsLeftLine
    end
    object InvoiceCountTextEdit: TcxTextEdit
      Left = 516
      Top = 26
      TabStop = False
      ParentFont = False
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      Properties.ReadOnly = True
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      Text = '0'
      Width = 45
    end
    object CurrentInvoiceTotalAmountTextEdit: TcxTextEdit
      Left = 744
      Top = 26
      TabStop = False
      ParentFont = False
      Properties.Alignment.Horz = taCenter
      Properties.ReadOnly = True
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 1
      Text = '0'
      Width = 89
    end
    object cxButton1: TcxButton
      Left = 71
      Top = 21
      Width = 145
      Height = 38
      Action = actCreateInvoice
      TabOrder = 2
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0029944A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0029944A0031A54A0029944A00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00399C630031A54A0031A54A0031A54A0029944A00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0029944A0031A54A0031B5520031A55A0031A54A0029944A00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003994
        630031A54A0031B55200298C5A00298C5A0031B5520042A5420031B55200FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002994
        4A0031B55200298C5A00FF00FF00FF00FF00298C5A0031B5520029944A00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00298C5A00FF00FF00FF00FF00FF00FF00FF00FF00298C5A0031B552002994
        4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00298C5A0031B5
        520031B55200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00298C
        5A0031A54A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00298C5A0031A54A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00298C5A0031A54A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00298C5A0031A54A00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00298C5A0031A54A00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00298C5A00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      LookAndFeel.Kind = lfOffice11
    end
    object cxButton2: TcxButton
      Left = 871
      Top = 25
      Width = 137
      Height = 32
      Caption = 'Store Grid Data'
      TabOrder = 3
      Visible = False
      OnClick = cxButton2Click
      LookAndFeel.Kind = lfOffice11
    end
    object cxButton3: TcxButton
      Left = 1015
      Top = 25
      Width = 137
      Height = 32
      Caption = 'Restore Grid Data'
      TabOrder = 4
      Visible = False
      OnClick = cxButton3Click
      LookAndFeel.Kind = lfOffice11
    end
    object cxButton4: TcxButton
      Left = 71
      Top = 21
      Width = 145
      Height = 38
      Action = actUpdateInvoice
      TabOrder = 5
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0029944A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0029944A0031A54A0029944A00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00399C630031A54A0031A54A0031A54A0029944A00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0029944A0031A54A0031B5520031A55A0031A54A0029944A00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF003994
        630031A54A0031B55200298C5A00298C5A0031B5520042A5420031B55200FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF002994
        4A0031B55200298C5A00FF00FF00FF00FF00298C5A0031B5520029944A00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00298C5A00FF00FF00FF00FF00FF00FF00FF00FF00298C5A0031B552002994
        4A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00298C5A0031B5
        520031B55200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00298C
        5A0031A54A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00298C5A0031A54A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00298C5A0031A54A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00298C5A0031A54A00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00298C5A0031A54A00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00298C5A00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      LookAndFeel.Kind = lfOffice11
    end
    object cxButton5: TcxButton
      Left = 222
      Top = 21
      Width = 145
      Height = 38
      Action = actCancelInvoice
      TabOrder = 6
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000029E700184AFF00FF00FF00184A
        FF000029E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000029E700184AFF00FF00FF00FF00FF00184A
        FF00395AFF000029E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF000029E700184AFF00FF00FF00FF00FF00FF00FF00184A
        FF00184AFF00395AFF000029E700FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000029E700184AFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00395AFF00184AFF00395AFF000029E700FF00FF00FF00FF00FF00FF00FF00
        FF000029E700184AFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00184AFF00395AFF000029E700FF00FF00FF00FF000029
        E7000029E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00184AFF00395AFF000029E7000029E7000029
        E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00184AFF00184AFF00184AFF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00184AFF00395AFF00184AFF00395AFF000029
        E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00184AFF00395AFF000029E700FF00FF00FF00FF00184A
        FF000029E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00184AFF00395AFF000029E700FF00FF00FF00FF00FF00FF00FF00
        FF00184AFF000029E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00184AFF00395AFF000029E700FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00184AFF000029E700FF00FF00FF00FF00FF00FF00FF00FF00184A
        FF006384FF000029E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF000029E700FF00FF00FF00FF00184AFF006384
        FF000029E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00184AFF00184A
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      LookAndFeel.Kind = lfOffice11
    end
    object pSaleInvInfo: TPanel
      Left = 73
      Top = 65
      Width = 762
      Height = 45
      BevelOuter = bvNone
      Color = clInfoBk
      TabOrder = 7
      object imgSaleInvInfo: TImage
        Left = 0
        Top = 0
        Width = 33
        Height = 45
        Align = alLeft
        Center = True
        Picture.Data = {
          07544269746D617036030000424D360300000000000036000000280000001000
          000010000000010018000000000000030000E30E0000E30E0000000000000000
          0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAB896F
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFBD9C7BAB896FFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD9C7BE1BC99B18F75
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFD8C0
          A6BD9C7BBD9C7BECCBA9EBC8A6D9B797BD9C7BCFAD8EFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFD8C0A6F7D9B9F7D9B9DCAD8EE2A882E1A780DCAB88
          EBC9A6E3BF9BBD9C7BFF00FFFF00FFFF00FFFF00FFFF00FFD9C0A7F2D5B7F8DD
          BFF8DDBFDEB499BC6238B75E38E2B594F2D1AFEBC9A6DAB795BD9C7BFF00FFFF
          00FFFF00FFEED7BEFAE0C3FBE1C6FBE2C6FBE2C6FCE4CABC6D46B16346FADFC3
          F6D7B7F3D3B1E9C6A4DFBA97CFAD8EFF00FFFF00FFE4CDB4FCE3C9FDE5CEFDE6
          D0FDE6D0FDE7D1BC6D46B26446FAE0C6F7D9BAF6D7B6EFCEABE5C29ECDAE92FF
          00FFFF00FFEED7BEFDE9D4FEECDAFEEEDFFEEEDFFEE9D5BC6D46B26446FBE2C9
          F9DCBEF7D9B9F3D3B1EBC9A6CCA98BFF00FFFF00FFEFDAC3FEEDDDFEF2E5FEF4
          E9FEEEDED4A284A03D17AB5E46FCE4CBF9DEC1F8DABBF5D5B4EECCAACFAD8EFF
          00FFFF00FFEFDCC7FEF2E5FEF5ECFEF8F2F6EFE5BC9F8DAD856DBD987FFCE5CD
          FAE0C3F8DCBDF6D7B6F0CFADD2B090FF00FFFF00FFE6D6C4FEF3E7FEF7EFFEFB
          F7FEFBF7F3E6DDC88C6FF2BD9BFCE5CDFAE0C3F8DCBDF6D7B6F0CFADCAB19CFF
          00FFFF00FFEED7BEF4E7D8FEF6EDFEF9F4FEF9F4CBB4AD812B109F563DEDD3BC
          FAE0C3F8DCBDF6D7B6CCA98BFF00FFFF00FFFF00FFFF00FFEED7BEF4E8DAFEF6
          EDFEF6EDEBE0D8AD9089C3A89DF8E0C8F9DFC2F8DBBCF0CFADE0BFA0FF00FFFF
          00FFFF00FFFF00FFFF00FFEED7BEEFE0CFF9EBDBFEEEDDFDEAD7FCE5CCFBE1C6
          F0D4B7CCA98BE0BFA0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFEED7
          BEE6D6C4E1CCB4E1CBB2E0C9AFE0C8AED6BEA6FF00FFFF00FFFF00FFFF00FFFF
          00FF}
        Transparent = True
      end
      object lSaleInvEntryInfo: TcxLabel
        Left = 33
        Top = 0
        Align = alLeft
        AutoSize = False
        Caption = 
          'Pressing the tab key at the end of the row starts a new invoice.' +
          ' Pressing the down arrow key at the end of the row starts a new ' +
          'line for multiline entry.'
        ParentColor = False
        ParentFont = False
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taVCenter
        Properties.WordWrap = True
        Style.Color = clInfoBk
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Segoe UI Semibold'
        Style.Font.Style = [fsBold]
        Style.TextColor = clNavy
        Style.TextStyle = [fsBold]
        Style.IsFontAssigned = True
        Transparent = True
        Height = 45
        Width = 657
      end
    end
  end
  inherited FocusGridItemTimer: TTimer
    Left = 1068
    Top = 80
  end
  inherited PopupMenu: TPopupMenu
    Left = 1098
    Top = 80
  end
  object MyTimer: TTimer
    Enabled = False
    OnTimer = MyTimerTimer
    Left = 1129
    Top = 80
  end
end
