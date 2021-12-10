object DigitalVATForm: TDigitalVATForm
  Left = 474
  Top = 202
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderStyle = bsDialog
  Caption = 'VAT Return'
  ClientHeight = 559
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseDown = FormMouseDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object gbCompleteReturn: TcxGroupBox
    Left = 32
    Top = 64
    Caption = 'VAT Return completion'
    ParentFont = False
    Style.BorderStyle = ebsFlat
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    TabOrder = 10
    Visible = False
    Height = 390
    Width = 500
    object pCompleteReturn: TPanel
      Left = 0
      Top = 32
      Width = 500
      Height = 105
      BevelOuter = bvNone
      TabOrder = 2
      object lEnterFormNumber: TLabel
        Left = 20
        Top = -4
        Width = 316
        Height = 17
        Caption = 'Enter Form Bundle Number to complete VAT Return'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Confirmation: TEdit
        Left = 120
        Top = 24
        Width = 288
        Height = 25
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = ConfirmationChange
      end
      object btnCompleteReturn: TcxButton
        Left = 282
        Top = 51
        Width = 125
        Height = 33
        Action = actCompleteReturn
        Default = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        LookAndFeel.Kind = lfOffice11
      end
      object cxLabel4: TcxLabel
        Left = 20
        Top = 25
        Caption = 'Bundle Number:'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.IsFontAssigned = True
      end
    end
    object pVATReturnError: TPanel
      Left = 38
      Top = 280
      Width = 429
      Height = 65
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      object cxImage2: TcxImage
        Left = 16
        Top = 12
        Style.BorderStyle = ebsNone
        Style.Color = clMenu
        TabOrder = 0
        Height = 44
        Width = 49
      end
      object cxLabel2: TcxLabel
        Left = 62
        Top = 14
        Caption = 'VAT Return was not completed.'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -21
        Style.Font.Name = 'Segoe UI Semibold'
        Style.Font.Style = [fsBold]
        Style.TextColor = 4342527
        Style.IsFontAssigned = True
      end
    end
    object pVATReturnSuccess: TPanel
      Left = 38
      Top = 160
      Width = 429
      Height = 114
      BevelOuter = bvNone
      TabOrder = 0
      object cxImage1: TcxImage
        Left = 16
        Top = 37
        Style.BorderStyle = ebsNone
        Style.Color = clMenu
        TabOrder = 0
        Height = 44
        Width = 49
      end
      object cxLabel1: TcxLabel
        Left = 46
        Top = 39
        Caption = 'VAT Return successfully completed.'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -21
        Style.Font.Name = 'Segoe UI Semibold'
        Style.Font.Style = [fsBold]
        Style.TextColor = 2331736
        Style.IsFontAssigned = True
      end
      object lBundleNumber: TcxLabel
        Left = 0
        Top = 0
        Align = alTop
        Caption = '{Bundle_Number}'
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -21
        Style.Font.Name = 'Segoe UI Semibold'
        Style.Font.Style = [fsBold]
        Style.TextColor = 6381921
        Style.IsFontAssigned = True
      end
    end
  end
  object gbSelectPeriod: TcxGroupBox
    Left = 32
    Top = 64
    Caption = 'Select VAT Return Period '
    ParentFont = False
    Style.BorderStyle = ebsFlat
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    TabOrder = 9
    Height = 390
    Width = 500
    object PeriodLookup: TRxDBLookupCombo
      Left = 120
      Top = 48
      Width = 320
      Height = 28
      DropDownCount = 12
      DisplayAllFields = True
      DisplayEmpty = '<Select>'
      EmptyValue = '<Select>'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ItemHeight = 24
      LookupField = 'ReturnID'
      LookupDisplay = 'DisplayString'
      LookupSource = VATReturnQueryDS
      ParentFont = False
      TabOrder = 1
      OnChange = PeriodLookupChange
    end
    object cxLabel3: TcxLabel
      Left = 35
      Top = 51
      Caption = 'VAT Period:'
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
    end
    object IncludeExemptCB: TcxCheckBox
      Left = 227
      Top = 357
      Caption = 'Include Exempt VAT Code on Audit Trial'
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 2
      Width = 265
    end
  end
  object gbConfigureClientCode: TcxGroupBox
    Left = 32
    Top = 63
    Caption = 'Kingswood MTD Link'
    ParentFont = False
    Style.BorderStyle = ebsFlat
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    TabOrder = 15
    Visible = False
    Height = 390
    Width = 500
    object Label3: TLabel
      Left = 35
      Top = 36
      Width = 285
      Height = 17
      Caption = 'Please enter your Kingswood MTD Client Code:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ClientCodeTextEdit: TcxTextEdit
      Left = 120
      Top = 72
      Properties.OnChange = ClientCodeTextEditPropertiesChange
      Style.TextStyle = []
      TabOrder = 0
      Width = 329
    end
    object btnStoreClientCode: TcxButton
      Left = 325
      Top = 105
      Width = 125
      Height = 33
      Action = actStoreClientCode
      Default = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C30E0000C30E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2B9348FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF2B934831A6482B9348FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF399B6131A64831A64831A6482B9348FF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        2B934831A64837B75533A15831A6482B9348FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF3F946631A64837B7552F8D582F8D5837B75543
        A14637B755FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2B9348
        37B7552F8D58FF00FFFF00FF2F8D5837B7552B9348FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF2F8D58FF00FFFF00FFFF00FFFF00FF2F
        8D5837B7552B9348FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2F8D5837B75537B755FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF2F8D5831A648FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2F8D5831A648FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF2F8D5831A648FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2F8D
        5831A648FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF2F8D5831A648FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF2F8D58FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      LookAndFeel.Kind = lfOffice11
    end
    object cxLabel6: TcxLabel
      Left = 35
      Top = 73
      Caption = 'Client Code:'
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
    end
    object lNewSignupMessageText: TcxMemo
      Left = 20
      Top = 200
      Lines.Strings = (
        '')
      ParentFont = False
      Properties.ReadOnly = True
      Properties.WantReturns = False
      Style.Color = clInfoBk
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = 'Segoe UI Semilight'
      Style.Font.Style = []
      Style.TextColor = clNavy
      Style.IsFontAssigned = True
      TabOrder = 3
      Height = 153
      Width = 457
    end
  end
  object gbNIVatPanel: TcxGroupBox
    Left = 32
    Top = 64
    Caption = 'VAT Return Figures'
    ParentFont = False
    Style.BorderStyle = ebsFlat
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = [fsBold]
    Style.TextStyle = [fsBold]
    Style.TransparentBorder = True
    Style.IsFontAssigned = True
    TabOrder = 12
    Visible = False
    Height = 390
    Width = 500
    object box1lbl: TLabel
      Left = 87
      Top = 32
      Width = 160
      Height = 17
      Alignment = taRightJustify
      Caption = 'VAT Due from Sales (Box 1)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Box2lbl: TLabel
      Left = 29
      Top = 62
      Width = 218
      Height = 17
      Alignment = taRightJustify
      Caption = 'VAT Due from EC Acquisitions (Box 2)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Box3lbl: TLabel
      Left = 120
      Top = 92
      Width = 127
      Height = 17
      Alignment = taRightJustify
      Caption = 'Total VAT Due (Box 3)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Box4lbl: TLabel
      Left = 74
      Top = 122
      Width = 173
      Height = 17
      Alignment = taRightJustify
      Caption = 'VAT Reclaimed inc. EC (Box 4)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object VATLabel: TLabel
      Left = 394
      Top = 152
      Width = 70
      Height = 17
      Alignment = taRightJustify
      Caption = '(Repayable)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Box6lbl: TLabel
      Left = 96
      Top = 182
      Width = 151
      Height = 17
      Alignment = taRightJustify
      Caption = 'Total Sales Ex VAT (Box 6)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Box7lbl: TLabel
      Left = 68
      Top = 212
      Width = 179
      Height = 17
      Alignment = taRightJustify
      Caption = 'Total Purchases Ex VAT (Box 7)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Box8lbl: TLabel
      Left = 58
      Top = 242
      Width = 189
      Height = 17
      Alignment = taRightJustify
      Caption = 'Total EC Supplies Ex VAT (Box 8)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Box9lbl: TLabel
      Left = 38
      Top = 272
      Width = 209
      Height = 17
      Alignment = taRightJustify
      Caption = 'Total EC Acquisitions Ex VAT (Box 9)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 146
      Top = 152
      Width = 101
      Height = 17
      Alignment = taRightJustify
      Caption = 'NET VAT (Box 5)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnCancelReturn: TcxButton
      Left = 12
      Top = 342
      Width = 158
      Height = 33
      Action = actCancelReturn
      Cancel = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000320B0000320B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF002EE41B48FBFF00FF1B48FB002EE4FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF002EE41B48FBFF00FFFF00FF1B48FB
        3E5EFF002EE4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF002E
        E41B48FBFF00FFFF00FFFF00FF1B48FB1B48FB3E5EFF002EE4FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF002EE41B48FBFF00FFFF00FFFF00FFFF00FFFF00FF
        3E5EFF1B48FB3E5EFF002EE4FF00FFFF00FFFF00FFFF00FF002EE41B48FBFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1B48FB3E5EFF002EE4FF
        00FFFF00FF002EE4002EE4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF1B48FB3E5EFF002EE4002EE4002EE4FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1B48FB1B
        48FB1B48FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF1B48FB3E5EFF1B48FB3E5EFF002EE4FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1B48FB3E5EFF002EE4FF
        00FFFF00FF1B48FB002EE4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF1B48FB3E5EFF002EE4FF00FFFF00FFFF00FFFF00FF1B48FB002EE4FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF1B48FB3E5EFF002EE4FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF1B48FB002EE4FF00FFFF00FFFF00FFFF00FF1B48FB
        6482FF002EE4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF002EE4FF00FFFF00FF1B48FB6482FF002EE4FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1B48FB1B48FB
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      LookAndFeel.Kind = lfOffice11
    end
    object btnSubmitReturn: TcxButton
      Left = 328
      Top = 342
      Width = 158
      Height = 33
      Action = actSubmitReturn
      Default = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C30E0000C30E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2B9348FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF2B934831A6482B9348FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF399B6131A64831A64831A6482B9348FF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        2B934831A64837B75533A15831A6482B9348FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF3F946631A64837B7552F8D582F8D5837B75543
        A14637B755FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2B9348
        37B7552F8D58FF00FFFF00FF2F8D5837B7552B9348FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF2F8D58FF00FFFF00FFFF00FFFF00FF2F
        8D5837B7552B9348FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2F8D5837B75537B755FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF2F8D5831A648FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2F8D5831A648FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF2F8D5831A648FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2F8D
        5831A648FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF2F8D5831A648FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF2F8D58FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      LookAndFeel.Kind = lfOffice11
    end
    object Box1: TcxTextEdit
      Left = 270
      Top = 30
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.ReadOnly = True
      Style.TextStyle = []
      TabOrder = 2
      Text = 'Box1'
      Width = 121
    end
    object Box3: TcxTextEdit
      Left = 270
      Top = 90
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.ReadOnly = True
      Style.TextStyle = []
      TabOrder = 3
      Text = 'Box3'
      Width = 121
    end
    object Box2: TcxTextEdit
      Left = 270
      Top = 60
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.ReadOnly = True
      Style.TextStyle = []
      TabOrder = 4
      Text = 'Box2'
      Width = 121
    end
    object Box4: TcxTextEdit
      Left = 270
      Top = 120
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.ReadOnly = True
      Style.TextStyle = []
      TabOrder = 5
      Text = 'Box4'
      Width = 121
    end
    object Box5: TcxTextEdit
      Left = 270
      Top = 150
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.ReadOnly = True
      Style.TextStyle = []
      TabOrder = 6
      Text = 'Box5'
      Width = 121
    end
    object Box6: TcxTextEdit
      Left = 270
      Top = 180
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.ReadOnly = True
      Style.TextStyle = []
      TabOrder = 7
      Text = 'Box6'
      Width = 121
    end
    object Box7: TcxTextEdit
      Left = 270
      Top = 210
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.ReadOnly = True
      Style.TextStyle = []
      TabOrder = 8
      Text = 'Box7'
      Width = 121
    end
    object Box8: TcxTextEdit
      Left = 270
      Top = 240
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.ReadOnly = True
      Style.TextStyle = []
      TabOrder = 9
      Text = 'Box8'
      Width = 121
    end
    object Box9: TcxTextEdit
      Left = 270
      Top = 270
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.ReadOnly = True
      Style.TextStyle = []
      TabOrder = 10
      Text = 'Box9'
      Width = 121
    end
  end
  object FiguresPanel: TGroupBox
    Left = 1144
    Top = 128
    Width = 449
    Height = 593
    Caption = ' VAT Return Figures '
    TabOrder = 2
    Visible = False
    object IRLVATPanel: TPanel
      Left = 16
      Top = 32
      Width = 417
      Height = 545
      TabOrder = 0
      Visible = False
      object Label1: TLabel
        Left = 32
        Top = 8
        Width = 32
        Height = 13
        Caption = 'Sales'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 32
        Top = 272
        Width = 60
        Height = 13
        Caption = 'Purchases'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SalesGrid: TStringGrid
        Left = 32
        Top = 32
        Width = 353
        Height = 225
        ColCount = 4
        DefaultRowHeight = 15
        Enabled = False
        FixedCols = 0
        RowCount = 13
        TabOrder = 0
        OnDrawCell = SalesGridDrawCell
        ColWidths = (
          64
          64
          102
          94)
      end
      object PurchasesGrid: TStringGrid
        Left = 32
        Top = 296
        Width = 353
        Height = 225
        ColCount = 4
        DefaultRowHeight = 15
        Enabled = False
        FixedCols = 0
        RowCount = 13
        TabOrder = 1
        OnDrawCell = PurchasesGridDrawCell
        ColWidths = (
          64
          64
          103
          92)
      end
    end
  end
  object Stage1IrlPanel: TGroupBox
    Left = 1488
    Top = 40
    Width = 337
    Height = 81
    Caption = ' Stage 1 - Select Report Date '
    TabOrder = 0
    Visible = False
    object Label25: TLabel
      Left = 110
      Top = 36
      Width = 71
      Height = 17
      Alignment = taRightJustify
      Caption = 'Report Date'
    end
    object VatRepDate: TMaskEdit
      Left = 196
      Top = 36
      Width = 69
      Height = 25
      HelpContext = 4
      EditMask = '!99/99/99;1;_'
      MaxLength = 8
      TabOrder = 0
      Text = '  /  /  '
      OnExit = VatRepDateExit
    end
    object VatRepDateSearch: TDateTimePicker
      Left = 266
      Top = 33
      Width = 21
      Height = 25
      CalAlignment = dtaRight
      Date = 0.419326851850201
      Time = 0.419326851850201
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
      OnCloseUp = VatRepDateSearchCloseUp
      OnEnter = VatRepDateSearchEnter
    end
  end
  object Stage2Panel: TGroupBox
    Left = 872
    Top = 16
    Width = 433
    Height = 97
    Caption = ' Stage 2 - Generate Figures && Preview / Print Audit Report '
    TabOrder = 1
    Visible = False
    object PrintVatAuditReport: TCheckBox
      Left = 18
      Top = 32
      Width = 159
      Height = 17
      HelpContext = 192
      Alignment = taLeftJustify
      Caption = 'Preview Audit Trail Report'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object RunBtn: TBitBtn
      Left = 296
      Top = 31
      Width = 113
      Height = 31
      Caption = 'Run'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = RunBtnClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000
        73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998
        0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008
        0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008
        0333337F777777737F333308888888880333337F333333337F33330888888888
        03333373FFFFFFFF733333700000000073333337777777773333}
      NumGlyphs = 2
    end
  end
  object Stage3Panel: TGroupBox
    Left = 1336
    Top = 8
    Width = 273
    Height = 25
    Caption = ' Stage 3 - Enter Any Corrections or Adjustments '
    TabOrder = 3
    Visible = False
  end
  object Stage4IRLPanel: TGroupBox
    Left = 880
    Top = 272
    Width = 433
    Height = 137
    Caption = ' Stage 3 - Print Report && Close Period '
    TabOrder = 4
    Visible = False
    object PreviewIRLReport: TBitBtn
      Left = 240
      Top = 31
      Width = 169
      Height = 31
      Caption = 'Print Report'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = PreviewIRLReportClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333330000000
        00003333377777777777333330FFFFFFFFF03FF3F7FFFF33FFF7003000000FF0
        00F077F7777773F77737E00FBFBFB0FFFFF07773333FF7FF33F7E0FBFB00000F
        F0F077F333777773F737E0BFBFBFBFB0FFF077F3333FFFF733F7E0FBFB00000F
        F0F077F333777773F737E0BFBFBFBFB0FFF077F33FFFFFF733F7E0FB0000000F
        F0F077FF777777733737000FB0FFFFFFFFF07773F7F333333337333000FFFFFF
        FFF0333777F3FFF33FF7333330F000FF0000333337F777337777333330FFFFFF
        0FF0333337FFFFFF7F37333330CCCCCC0F033333377777777F73333330FFFFFF
        0033333337FFFFFF773333333000000003333333377777777333}
      NumGlyphs = 2
    end
    object CloseIRLPeriodBtn: TBitBtn
      Left = 240
      Top = 79
      Width = 169
      Height = 31
      Caption = 'Close VAT Period'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = CloseIRLPeriodBtnClick
      Glyph.Data = {
        BE060000424DBE06000000000000360400002800000024000000120000000100
        0800000000008802000000000000000000000001000000010000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A600000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
        0303030303030303030303030303030303030303030303030303030303030303
        03030303030303030303030303030303030303030303FF030303030303030303
        03030303030303040403030303030303030303030303030303F8F8FF03030303
        03030303030303030303040202040303030303030303030303030303F80303F8
        FF030303030303030303030303040202020204030303030303030303030303F8
        03030303F8FF0303030303030303030304020202020202040303030303030303
        0303F8030303030303F8FF030303030303030304020202FA0202020204030303
        0303030303F8FF0303F8FF030303F8FF03030303030303020202FA03FA020202
        040303030303030303F8FF03F803F8FF0303F8FF03030303030303FA02FA0303
        03FA0202020403030303030303F8FFF8030303F8FF0303F8FF03030303030303
        FA0303030303FA0202020403030303030303F80303030303F8FF0303F8FF0303
        0303030303030303030303FA0202020403030303030303030303030303F8FF03
        03F8FF03030303030303030303030303FA020202040303030303030303030303
        0303F8FF0303F8FF03030303030303030303030303FA02020204030303030303
        03030303030303F8FF0303F8FF03030303030303030303030303FA0202020403
        030303030303030303030303F8FF0303F8FF03030303030303030303030303FA
        0202040303030303030303030303030303F8FF03F8FF03030303030303030303
        03030303FA0202030303030303030303030303030303F8FFF803030303030303
        030303030303030303FA0303030303030303030303030303030303F803030303
        0303030303030303030303030303030303030303030303030303030303030303
        0303}
      NumGlyphs = 2
    end
  end
  object Stage4UKPanel: TGroupBox
    Left = 928
    Top = 520
    Width = 433
    Height = 137
    Caption = ' Stage 3 - Print Report && Submit Return '
    TabOrder = 5
    Visible = False
    object PreviewUKReport: TBitBtn
      Left = 240
      Top = 31
      Width = 169
      Height = 31
      Caption = 'Preview Submission Report'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = PreviewUKReportClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333330000000
        00003333377777777777333330FFFFFFFFF03FF3F7FFFF33FFF7003000000FF0
        00F077F7777773F77737E00FBFBFB0FFFFF07773333FF7FF33F7E0FBFB00000F
        F0F077F333777773F737E0BFBFBFBFB0FFF077F3333FFFF733F7E0FBFB00000F
        F0F077F333777773F737E0BFBFBFBFB0FFF077F33FFFFFF733F7E0FB0000000F
        F0F077FF777777733737000FB0FFFFFFFFF07773F7F333333337333000FFFFFF
        FFF0333777F3FFF33FF7333330F000FF0000333337F777337777333330FFFFFF
        0FF0333337FFFFFF7F37333330CCCCCC0F033333377777777F73333330FFFFFF
        0033333337FFFFFF773333333000000003333333377777777333}
      NumGlyphs = 2
    end
    object EnableDebug: TCheckBox
      Left = 32
      Top = 104
      Width = 185
      Height = 17
      Caption = 'Enable Debug Messages'
      TabOrder = 1
    end
    object SubmitUKReturn: TBitBtn
      Left = 240
      Top = 87
      Width = 169
      Height = 31
      Caption = 'Submit Return'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Glyph.Data = {
        BE060000424DBE06000000000000360400002800000024000000120000000100
        0800000000008802000000000000000000000001000000010000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A600000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
        0303030303030303030303030303030303030303030303030303030303030303
        03030303030303030303030303030303030303030303FF030303030303030303
        03030303030303040403030303030303030303030303030303F8F8FF03030303
        03030303030303030303040202040303030303030303030303030303F80303F8
        FF030303030303030303030303040202020204030303030303030303030303F8
        03030303F8FF0303030303030303030304020202020202040303030303030303
        0303F8030303030303F8FF030303030303030304020202FA0202020204030303
        0303030303F8FF0303F8FF030303F8FF03030303030303020202FA03FA020202
        040303030303030303F8FF03F803F8FF0303F8FF03030303030303FA02FA0303
        03FA0202020403030303030303F8FFF8030303F8FF0303F8FF03030303030303
        FA0303030303FA0202020403030303030303F80303030303F8FF0303F8FF0303
        0303030303030303030303FA0202020403030303030303030303030303F8FF03
        03F8FF03030303030303030303030303FA020202040303030303030303030303
        0303F8FF0303F8FF03030303030303030303030303FA02020204030303030303
        03030303030303F8FF0303F8FF03030303030303030303030303FA0202020403
        030303030303030303030303F8FF0303F8FF03030303030303030303030303FA
        0202040303030303030303030303030303F8FF03F8FF03030303030303030303
        03030303FA0202030303030303030303030303030303F8FFF803030303030303
        030303030303030303FA0303030303030303030303030303030303F803030303
        0303030303030303030303030303030303030303030303030303030303030303
        0303}
      NumGlyphs = 2
    end
  end
  object Stage5UKPanel: TGroupBox
    Left = 840
    Top = 672
    Width = 433
    Height = 137
    Caption = 'VAT return completion'
    TabOrder = 6
    Visible = False
    object PrintUKReturn: TBitBtn
      Left = 248
      Top = 90
      Width = 169
      Height = 31
      Caption = 'Print VAT Return Report'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = PrintUKReturnClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333330000000
        00003333377777777777333330FFFFFFFFF03FF3F7FFFF33FFF7003000000FF0
        00F077F7777773F77737E00FBFBFB0FFFFF07773333FF7FF33F7E0FBFB00000F
        F0F077F333777773F737E0BFBFBFBFB0FFF077F3333FFFF733F7E0FBFB00000F
        F0F077F333777773F737E0BFBFBFBFB0FFF077F33FFFFFF733F7E0FB0000000F
        F0F077FF777777733737000FB0FFFFFFFFF07773F7F333333337333000FFFFFF
        FFF0333777F3FFF33FF7333330F000FF0000333337F777337777333330FFFFFF
        0FF0333337FFFFFF7F37333330CCCCCC0F033333377777777F73333330FFFFFF
        0033333337FFFFFF773333333000000003333333377777777333}
      NumGlyphs = 2
    end
    object CompleteUKReturn: TBitBtn
      Left = 248
      Top = 47
      Width = 169
      Height = 31
      Caption = 'Complete Return'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = CompleteUKReturnClick
      Glyph.Data = {
        BE060000424DBE06000000000000360400002800000024000000120000000100
        0800000000008802000000000000000000000001000000010000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A600000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
        0303030303030303030303030303030303030303030303030303030303030303
        03030303030303030303030303030303030303030303FF030303030303030303
        03030303030303040403030303030303030303030303030303F8F8FF03030303
        03030303030303030303040202040303030303030303030303030303F80303F8
        FF030303030303030303030303040202020204030303030303030303030303F8
        03030303F8FF0303030303030303030304020202020202040303030303030303
        0303F8030303030303F8FF030303030303030304020202FA0202020204030303
        0303030303F8FF0303F8FF030303F8FF03030303030303020202FA03FA020202
        040303030303030303F8FF03F803F8FF0303F8FF03030303030303FA02FA0303
        03FA0202020403030303030303F8FFF8030303F8FF0303F8FF03030303030303
        FA0303030303FA0202020403030303030303F80303030303F8FF0303F8FF0303
        0303030303030303030303FA0202020403030303030303030303030303F8FF03
        03F8FF03030303030303030303030303FA020202040303030303030303030303
        0303F8FF0303F8FF03030303030303030303030303FA02020204030303030303
        03030303030303F8FF0303F8FF03030303030303030303030303FA0202020403
        030303030303030303030303F8FF0303F8FF03030303030303030303030303FA
        0202040303030303030303030303030303F8FF03F8FF03030303030303030303
        03030303FA0202030303030303030303030303030303F8FFF803030303030303
        030303030303030303FA0303030303030303030303030303030303F803030303
        0303030303030303030303030303030303030303030303030303030303030303
        0303}
      NumGlyphs = 2
    end
  end
  object CancelBtn: TBitBtn
    Left = 1456
    Top = 272
    Width = 177
    Height = 38
    Caption = 'Cancel Return'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    Glyph.Data = {
      CE070000424DCE07000000000000360000002800000024000000120000000100
      1800000000009807000000000000000000000000000000000000007F7F007F7F
      007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
      7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
      7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
      007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F7F7F7F007F7F007F7F007F
      7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
      7F7F007F7F007F7F007F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F
      007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F0000FF0000
      7F00007F7F7F7F007F7F007F7F007F7F007F7F007F7F0000FF7F7F7F007F7F00
      7F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F7F7F7FFFFFFF007F7F
      007F7F007F7F007F7F007F7F007F7FFFFFFF007F7F007F7F007F7F007F7F007F
      7F007F7F007F7F0000FF00007F00007F00007F7F7F7F007F7F007F7F007F7F00
      00FF00007F00007F7F7F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F
      FFFFFF007F7F7F7F7FFFFFFF007F7F007F7F007F7FFFFFFF7F7F7F7F7F7FFFFF
      FF007F7F007F7F007F7F007F7F007F7F007F7F0000FF00007F00007F00007F00
      007F7F7F7F007F7F0000FF00007F00007F00007F00007F7F7F7F007F7F007F7F
      007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F7F7F7FFFFFFF007F7FFFFF
      FF7F7F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F00
      7F7F0000FF00007F00007F00007F00007F7F7F7F00007F00007F00007F00007F
      00007F7F7F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F
      7F007F7F7F7F7FFFFFFF7F7F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF00
      7F7F007F7F007F7F007F7F007F7F007F7F0000FF00007F00007F00007F00007F
      00007F00007F00007F00007F7F7F7F007F7F007F7F007F7F007F7F007F7F007F
      7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F7F7F7F007F7F007F7F007F7F00
      7F7FFFFFFF7F7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
      0000FF00007F00007F00007F00007F00007F00007F7F7F7F007F7F007F7F007F
      7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F00
      7F7F007F7F007F7F007F7FFFFFFF7F7F7F007F7F007F7F007F7F007F7F007F7F
      007F7F007F7F007F7F007F7F007F7F00007F00007F00007F00007F00007F7F7F
      7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
      7F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F7F7F7F007F7F007F7F
      007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F0000FF0000
      7F00007F00007F00007F7F7F7F007F7F007F7F007F7F007F7F007F7F007F7F00
      7F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F
      7F7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
      7F007F7F0000FF00007F00007F00007F00007F00007F7F7F7F007F7F007F7F00
      7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F
      007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F
      7F007F7F007F7F007F7F007F7F0000FF00007F00007F00007F7F7F7F00007F00
      007F00007F7F7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
      007F7F007F7F7F7F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F
      7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F0000FF00007F00007F00
      007F7F7F7F007F7F0000FF00007F00007F00007F7F7F7F007F7F007F7F007F7F
      007F7F007F7F007F7F007F7F007F7F7F7F7F007F7F007F7F007F7F7F7F7FFFFF
      FF007F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F00
      7F7F0000FF00007F00007F7F7F7F007F7F007F7F007F7F0000FF00007F00007F
      00007F7F7F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7FFFFFFF007F
      7F007F7F7F7F7F007F7F7F7F7FFFFFFF007F7F007F7F7F7F7FFFFFFF007F7F00
      7F7F007F7F007F7F007F7F007F7F007F7F0000FF00007F007F7F007F7F007F7F
      007F7F007F7F0000FF00007F00007F00007F007F7F007F7F007F7F007F7F007F
      7F007F7F7F7F7FFFFFFFFFFFFF7F7F7F007F7F007F7F007F7F7F7F7FFFFFFF00
      7F7F007F7F7F7F7FFFFFFF007F7F007F7F007F7F007F7F007F7F007F7F007F7F
      007F7F007F7F007F7F007F7F007F7F007F7F007F7F0000FF00007F0000FF007F
      7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F7F7F7F007F7F007F7F00
      7F7F007F7F007F7F7F7F7FFFFFFFFFFFFFFFFFFF7F7F7F007F7F007F7F007F7F
      007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
      7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
      7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F7F7F7F7F7F7F7F7F7F
      007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F
      7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F00
      7F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F007F7F
      007F7F007F7F007F7F007F7F007F7F007F7F}
    NumGlyphs = 2
  end
  object NewRtnBtn: TBitBtn
    Left = 1640
    Top = 272
    Width = 177
    Height = 38
    Caption = 'New Return'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = NewRtnBtnClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      0400000000000001000000000000000000001000000010000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
      000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
      00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
      F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
      0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
      FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
      FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
      0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
      00333377737FFFFF773333303300000003333337337777777333}
    NumGlyphs = 2
  end
  object NIVatPanelold: TPanel
    Left = 1440
    Top = 712
    Width = 433
    Height = 329
    TabOrder = 11
    Visible = False
  end
  object gbReports: TcxGroupBox
    Left = 31
    Top = 457
    Caption = 'Reports'
    ParentFont = False
    Style.BorderStyle = ebsFlat
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    TabOrder = 13
    Height = 74
    Width = 500
    object btnAuditTrailReport: TcxButton
      Left = 12
      Top = 24
      Width = 152
      Height = 33
      Action = actViewAuditTrail
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000520B0000520B00000000000000000000FF00FFFF00FF
        AEAEAE999C9E999C9E999C9E999C9E999C9E999C9E999C9E999C9E999C9E999C
        9E999C9E999C9EFF00FFFF00FFFF00FF636B73F7F7F7F4F4F4F2F2F2EFEFEFED
        EDEDEAEAEAE8E8E8E2E2E2DDDDDDD7D7D7D2D2D29C9FA1FF00FFFF00FF636B73
        3775AB636B73F7F7F7F4F4F4F2F2F2EFEFEFEDEDEDEAEAEAE8E8E8E2E2E2DDDD
        DDD7D7D79C9FA1FF00FFFF00FF31A5FF5ABDFF2F76B3636B73F7F7F7F4F4F4F2
        F2F2EFEFEFEDEDEDEAEAEAE8E8E8E2E2E2DDDDDD9C9FA1FF00FFFF00FFFF00FF
        31A5FF5ABDFF2F76B3F7F7F7F7F7F7F4F4F4F2F2F2EFEFEFEDEDEDEAEAEAE8E8
        E8E2E2E29C9FA1FF00FFFF00FFFF00FFAEAEAE31A5FF4A4239E5DAD5DCC3B1CC
        A79DD3B6A3DDC5BAE5DAD5EDEDEDEAEAEAE8E8E89C9FA1FF00FFFF00FFFF00FF
        AEAEAEFFFFFFE5DAD5AD9383E7D6AAF8E8B5F3E4B2E7D4AECCA79DE9E9E9EDED
        EDEAEAEA9C9FA1FF00FFFF00FFFF00FFAEAEAEFFFFFFD7B9B2ECDDADF9E8B6FF
        EFBBFFF1BCFEF0BBECDEADD3BAB4F0F0F0EDEDED9C9FA1FF00FFFF00FFFF00FF
        AEAEAEFFFFFFCCA79DEBDCACF9E8B6FEEDBBFFF0BCFFF1BDFBEBB7CCA79DF3F3
        F3F0F0F09C9FA1FF00FFFF00FFFF00FFAEAEAEFFFFFFD7B9B2E2D4A7F4E5B7FB
        EEC8FCEBBAFCECB9F0E0B0D7B9B2F5F5F5EAEAEA9C9FA1FF00FFFF00FFFF00FF
        AEAEAEFFFFFFE7D5D5DBC8A9EEE1BAF6E9C2F5E5B4EDDEAED7BE9EDFCAC3E2E2
        E2DDDDDD9C9FA1FF00FFFF00FFFF00FFAEAEAEFFFFFFFFFFFFCCA79DD8C3AEDD
        C9A6DFCAA6DABEA2D4B6AEEBEBEB9C9FA19C9FA19C9FA1FF00FFFF00FFFF00FF
        AEAEAEFFFFFFFFFFFFFFFFFFE7D5D5D7B9B2D7B9B2DDCEC7FFFFFFA8A9AAFFFF
        FFE6E6E69C9FA1FF00FFFF00FFFF00FFAEAEAEFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFA8A9AAE6E6E69B9D9DFF00FFFF00FFFF00FFFF00FF
        AEAEAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A9AA9B9D
        9DFF00FFFF00FFFF00FFFF00FFFF00FFAEAEAE9B9B9C9B9B9C9B9B9C9B9B9C9B
        9B9C9B9B9C9B9B9C9B9B9C9C9FA1FF00FFFF00FFFF00FFFF00FF}
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = False
    end
    object btnViewSubmissionReport: TcxButton
      Left = 173
      Top = 24
      Width = 152
      Height = 33
      Action = actViewSubmissionReport
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000520B0000520B00000000000000000000FF00FFFF00FF
        AEAEAE999C9E999C9E999C9E999C9E999C9E999C9E999C9E999C9E999C9E999C
        9E999C9E999C9EFF00FFFF00FFFF00FF636B73F7F7F7F4F4F4F2F2F2EFEFEFED
        EDEDEAEAEAE8E8E8E2E2E2DDDDDDD7D7D7D2D2D29C9FA1FF00FFFF00FF636B73
        3775AB636B73F7F7F7F4F4F4F2F2F2EFEFEFEDEDEDEAEAEAE8E8E8E2E2E2DDDD
        DDD7D7D79C9FA1FF00FFFF00FF31A5FF5ABDFF2F76B3636B73F7F7F7F4F4F4F2
        F2F2EFEFEFEDEDEDEAEAEAE8E8E8E2E2E2DDDDDD9C9FA1FF00FFFF00FFFF00FF
        31A5FF5ABDFF2F76B3F7F7F7F7F7F7F4F4F4F2F2F2EFEFEFEDEDEDEAEAEAE8E8
        E8E2E2E29C9FA1FF00FFFF00FFFF00FFAEAEAE31A5FF4A4239E5DAD5DCC3B1CC
        A79DD3B6A3DDC5BAE5DAD5EDEDEDEAEAEAE8E8E89C9FA1FF00FFFF00FFFF00FF
        AEAEAEFFFFFFE5DAD5AD9383E7D6AAF8E8B5F3E4B2E7D4AECCA79DE9E9E9EDED
        EDEAEAEA9C9FA1FF00FFFF00FFFF00FFAEAEAEFFFFFFD7B9B2ECDDADF9E8B6FF
        EFBBFFF1BCFEF0BBECDEADD3BAB4F0F0F0EDEDED9C9FA1FF00FFFF00FFFF00FF
        AEAEAEFFFFFFCCA79DEBDCACF9E8B6FEEDBBFFF0BCFFF1BDFBEBB7CCA79DF3F3
        F3F0F0F09C9FA1FF00FFFF00FFFF00FFAEAEAEFFFFFFD7B9B2E2D4A7F4E5B7FB
        EEC8FCEBBAFCECB9F0E0B0D7B9B2F5F5F5EAEAEA9C9FA1FF00FFFF00FFFF00FF
        AEAEAEFFFFFFE7D5D5DBC8A9EEE1BAF6E9C2F5E5B4EDDEAED7BE9EDFCAC3E2E2
        E2DDDDDD9C9FA1FF00FFFF00FFFF00FFAEAEAEFFFFFFFFFFFFCCA79DD8C3AEDD
        C9A6DFCAA6DABEA2D4B6AEEBEBEB9C9FA19C9FA19C9FA1FF00FFFF00FFFF00FF
        AEAEAEFFFFFFFFFFFFFFFFFFE7D5D5D7B9B2D7B9B2DDCEC7FFFFFFA8A9AAFFFF
        FFE6E6E69C9FA1FF00FFFF00FFFF00FFAEAEAEFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFA8A9AAE6E6E69B9D9DFF00FFFF00FFFF00FFFF00FF
        AEAEAEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A9AA9B9D
        9DFF00FFFF00FFFF00FFFF00FFFF00FFAEAEAE9B9B9C9B9B9C9B9B9C9B9B9C9B
        9B9C9B9B9C9B9B9C9B9B9C9C9FA1FF00FFFF00FFFF00FFFF00FF}
      LookAndFeel.Kind = lfOffice11
    end
    object btnPrintVATReturnReport: TcxButton
      Left = 179
      Top = 24
      Width = 152
      Height = 33
      Action = actPrintVATReturnReport
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000830F0000830F00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA6A8A99B9B9B9B
        9B9B9B9B9B9B9B9B9B9B9B9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFA6A8A9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9B9B9BFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF737373696969656563929391FFFFFFAF
        AFAFAFAFAFAFAFAFFFFFFF7B7B754F4F4F545454545454FF00FFFF00FF737373
        93979793979775777590918EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7B7B755B5C
        5C787B7B606161545454FF00FF737373939797ADB5B56667665F5F5F77777777
        77777777777777777171715A5A586869697F8282707171545454FF00FF737373
        ADB5B5ADB5B5ADB5B5ADB5B5ADB5B5ADB5B5ADB5B5ADB5B5ADB5B5A2A8A86AA4
        7708B518767878565757FF00FF737373D2D2D2988D91997C809A797BAA8186AA
        7F86AA7E86AD828AA77F859D7C7F8B7D7A5E9063787A7A575858FF00FF737373
        D2D2D2855A62956B6D8A6969896D6D876B6B866A6A886E6D8A706F8D6A699363
        6A9C6C819397975C5D5DFF00FF737373D2D2D26F4952583F415F4C4C74696972
        67677166667166667166665E424254393C8A72749397976C6D6DFF00FF737373
        ADB5B57E686A757272A6A8A9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9B9B9B6E5F
        61988989ADB5B56C6D6DFF00FFFF00FF7373738E81818F8485A6A8A9FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF9B9B9B8473748F85856C6D6DFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFA6A8A9FFFFFFFFFFFFFFFFFFA6A8A99B9B9B9B9B9BFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA6A8A9FFFFFFFF
        FFFFFFFFFFA6A8A9FFFFFF9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFA6A8A9FFFFFFFCFCFCFFFFFFA6A8A99B9B9BFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA6A8A99B9B9B9B
        9B9B9B9B9B9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      LookAndFeel.Kind = lfOffice11
    end
  end
  object KingswoodMTDLink: TcxHyperLinkEdit
    Left = 7
    Top = 535
    TabStop = False
    BeepOnEnter = False
    DragCursor = crHandPoint
    ParentFont = False
    ParentShowHint = False
    Properties.ReadOnly = True
    Properties.SingleClick = True
    Properties.UsePrefix = upNever
    Properties.Prefix = ''
    ShowHint = False
    Style.BorderStyle = ebsNone
    Style.Color = clBtnFace
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.HotTrack = False
    Style.LookAndFeel.Kind = lfFlat
    Style.LookAndFeel.NativeStyle = False
    Style.Shadow = False
    Style.TransparentBorder = False
    Style.IsFontAssigned = True
    StyleDisabled.LookAndFeel.Kind = lfFlat
    StyleDisabled.LookAndFeel.NativeStyle = False
    StyleFocused.BorderStyle = ebsNone
    StyleFocused.Color = clBtnFace
    StyleFocused.LookAndFeel.Kind = lfFlat
    StyleFocused.LookAndFeel.NativeStyle = False
    StyleHot.BorderStyle = ebsNone
    StyleHot.LookAndFeel.Kind = lfFlat
    StyleHot.LookAndFeel.NativeStyle = False
    TabOrder = 14
    Text = 'Your Kingswood MTD Account'
    OnClick = KingswoodMTDLinkClick
    Width = 185
  end
  object pCompletionAPIWaiting: TPanel
    Left = 62
    Top = 216
    Width = 429
    Height = 114
    BevelOuter = bvNone
    TabOrder = 20
    object RetrieveRecieptLabel: TcxLabel
      Left = 0
      Top = 0
      Align = alClient
      AutoSize = False
      Caption = 'Please wait while we process your VAT return '
      ParentFont = False
      Properties.Alignment.Horz = taCenter
      Properties.WordWrap = True
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.TextColor = 6381921
      Style.IsFontAssigned = True
      Height = 114
      Width = 429
    end
    object cxImage3: TcxImage
      Left = 16
      Top = 37
      Style.BorderStyle = ebsNone
      Style.Color = clMenu
      TabOrder = 0
      Height = 44
      Width = 49
    end
    object btnRetrieveReceipt: TcxButton
      Left = 143
      Top = 72
      Width = 129
      Height = 33
      Caption = 'Retrieve Receipt'
      TabOrder = 2
      Visible = False
      OnClick = btnRetrieveReceiptClick
      LookAndFeel.Kind = lfOffice11
      LookAndFeel.NativeStyle = True
    end
  end
  object VATReturnQuery: TQuery
    Left = 464
    Top = 8
  end
  object VATReturnQueryDS: TDataSource
    DataSet = VATReturnQuery
    Left = 504
    Top = 8
  end
  object ActionList1: TActionList
    Left = 440
    Top = 8
    object actViewAuditTrail: TAction
      Caption = 'View Audit Trail'
      OnExecute = actViewAuditTrailExecute
    end
    object actViewSubmissionReport: TAction
      Caption = 'Submission Report'
      Visible = False
      OnExecute = actViewSubmissionReportExecute
    end
    object actCompleteReturn: TAction
      Caption = 'Complete Return'
      OnExecute = actCompleteReturnExecute
    end
    object actPrintVATReturnReport: TAction
      Caption = 'VAT Return Report'
      OnExecute = actPrintVATReturnReportExecute
    end
    object actCancelReturn: TAction
      Caption = 'Cancel Return'
      OnExecute = actCancelReturnExecute
    end
    object actNewReturn: TAction
      Caption = 'New Return'
    end
    object actSubmitReturn: TAction
      Caption = 'Submit Return'
      OnExecute = actSubmitReturnExecute
    end
    object actClose: TAction
      Caption = 'Close'
      OnExecute = actCloseExecute
    end
    object actReports: TAction
      Caption = 'Reports'
      OnExecute = actReportsExecute
    end
    object actSettings: TAction
      Caption = 'Settings'
      OnExecute = actSettingsExecute
    end
    object actHelp: TAction
      Caption = 'Help'
    end
    object actStoreClientCode: TAction
      Caption = 'Accept'
      Enabled = False
      OnExecute = actStoreClientCodeExecute
    end
    object actSync: TAction
      Caption = 'Sync'
    end
  end
  object BarManager: TdxBarManager
    AllowReset = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Bars = <
      item
        AllowClose = False
        AllowCustomizing = False
        AllowQuickCustomizing = False
        AllowReset = False
        Caption = 'Main'
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 301
        FloatTop = 201
        FloatClientWidth = 0
        FloatClientHeight = 0
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        IsMainMenu = True
        ItemLinks = <>
        MultiLine = True
        Name = 'Main'
        OneOnRow = True
        Row = 0
        UseOwnFont = True
        UseRestSpace = True
        Visible = False
        WholeRow = True
      end
      item
        AllowClose = False
        AllowCustomizing = False
        AllowQuickCustomizing = False
        AllowReset = False
        Caption = 'TopToolbar'
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 329
        FloatTop = 599
        FloatClientWidth = 65
        FloatClientHeight = 190
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ItemLinks = <
          item
            Item = blbExit
            Visible = True
          end
          item
            BeginGroup = True
            Item = blbReports
            Visible = True
          end
          item
            BeginGroup = True
            Item = blbSettings
            Visible = True
          end
          item
            BeginGroup = True
            Item = blbSync
            Visible = True
          end
          item
            BeginGroup = True
            Item = blbHelp
            Visible = True
          end>
        Name = 'TopToolbar'
        OneOnRow = True
        Row = 0
        UseOwnFont = True
        UseRestSpace = True
        Visible = True
        WholeRow = True
      end>
    CanCustomize = False
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    HotImages = AccsDataModule.ImageList16x16
    Images = AccsDataModule.ImageList16x16
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = False
    PopupMenuLinks = <>
    Style = bmsUseLookAndFeel
    UseSystemFont = False
    Left = 532
    Top = 64
    DockControlHeights = (
      0
      0
      48
      0)
    object blbExit: TdxBarLargeButton
      Action = actClose
      Category = 0
      AutoGrayScale = False
      Height = 44
      HotImageIndex = 3
      Width = 65
    end
    object blbSettings: TdxBarLargeButton
      Action = actSettings
      Category = 0
      AutoGrayScale = False
      Height = 44
      HotImageIndex = 6
      Width = 75
      SyncImageIndex = False
      ImageIndex = 6
    end
    object bbBankFileFormat: TdxBarButton
      Category = 0
      Visible = ivAlways
    end
    object blbHelp: TdxBarLargeButton
      Action = actHelp
      Category = 0
      AutoGrayScale = False
      Height = 44
      HotImageIndex = 33
      Width = 65
      SyncImageIndex = False
      ImageIndex = 33
    end
    object dxBarButton1: TdxBarButton
      Category = 0
      Visible = ivAlways
    end
    object blbAddLine: TdxBarLargeButton
      Category = 0
      Visible = ivAlways
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000230B0000230B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0FA5280F
        A5280FA5280FA528FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0FA5287EE09E51CD830FA528FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0FA5287E
        E09E38C2730FA528FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0FA5287EE09E38C2730FA528FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0FA5287E
        E09E38C2730FA528FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0FA528
        0FA5280FA5280FA5280FA5280FA5287EE09E38C2730FA5280FA5280FA5280FA5
        280FA5280FA528FF00FFFF00FF0FA5287EE09E38C27338C27338C27338C27338
        C27338C27338C27338C27338C27338C27351CD830FA528FF00FFFF00FF0FA528
        5FD38B5FD38B5FD38B5FD38B5FD38B51CD8338C2735FD38B5FD38B5FD38B5FD3
        8B5FD38B0FA528FF00FFFF00FF0FA5280FA5280FA5280FA5280FA5280FA5287E
        E09E38C2730FA5280FA5280FA5280FA5280FA5280FA528FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0FA5287EE09E38C2730FA528FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0FA5287E
        E09E38C2730FA528FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0FA5287EE09E38C2730FA528FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0FA52851
        CD835FD38B0FA528FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0FA5280FA5280FA5280FA528FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      Height = 45
      LargeGlyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000230B0000230B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0FA5280F
        A5280FA5280FA528FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0FA5287EE09E51CD830FA528FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0FA5287E
        E09E38C2730FA528FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0FA5287EE09E38C2730FA528FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0FA5287E
        E09E38C2730FA528FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0FA528
        0FA5280FA5280FA5280FA5280FA5287EE09E38C2730FA5280FA5280FA5280FA5
        280FA5280FA528FF00FFFF00FF0FA5287EE09E38C27338C27338C27338C27338
        C27338C27338C27338C27338C27338C27351CD830FA528FF00FFFF00FF0FA528
        5FD38B5FD38B5FD38B5FD38B5FD38B51CD8338C2735FD38B5FD38B5FD38B5FD3
        8B5FD38B0FA528FF00FFFF00FF0FA5280FA5280FA5280FA5280FA5280FA5287E
        E09E38C2730FA5280FA5280FA5280FA5280FA5280FA528FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0FA5287EE09E38C2730FA528FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0FA5287E
        E09E38C2730FA528FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0FA5287EE09E38C2730FA528FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0FA52851
        CD835FD38B0FA528FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0FA5280FA5280FA5280FA528FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      Width = 65
    end
    object blbReports: TdxBarLargeButton
      Action = actReports
      Category = 0
      Height = 44
      HotImageIndex = 7
      Width = 75
      SyncImageIndex = False
      ImageIndex = 7
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'New Item'
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object blbSync: TdxBarLargeButton
      Action = actSync
      Category = 0
      AutoGrayScale = False
      Height = 44
      HotImageIndex = 44
      Width = 75
      SyncImageIndex = False
      ImageIndex = 44
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 488
    Top = 96
    object cxStyle1: TcxStyle
    end
  end
end
