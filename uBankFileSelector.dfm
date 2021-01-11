object fmBankFileSelector: TfmBankFileSelector
  Left = 484
  Top = 239
  BorderStyle = bsDialog
  Caption = 'Bank File Import'
  ClientHeight = 460
  ClientWidth = 590
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 17
  object BankFileGrid: TcxGrid
    Left = 24
    Top = 198
    Width = 545
    Height = 158
    TabOrder = 0
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = False
    object BankFileGridTableView: TcxGridTableView
      NavigatorButtons.ConfirmDelete = False
      NavigatorButtons.First.Visible = True
      NavigatorButtons.PriorPage.Visible = True
      NavigatorButtons.Prior.Visible = True
      NavigatorButtons.Next.Visible = True
      NavigatorButtons.NextPage.Visible = True
      NavigatorButtons.Last.Visible = True
      NavigatorButtons.Insert.Visible = True
      NavigatorButtons.Delete.Visible = True
      NavigatorButtons.Edit.Visible = True
      NavigatorButtons.Post.Visible = True
      NavigatorButtons.Cancel.Visible = True
      NavigatorButtons.Refresh.Visible = True
      NavigatorButtons.SaveBookmark.Visible = True
      NavigatorButtons.GotoBookmark.Visible = True
      NavigatorButtons.Filter.Visible = True
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsSelection.UnselectFocusedRecordOnExit = False
      OptionsView.DataRowHeight = 24
      OptionsView.GridLines = glNone
      OptionsView.GroupByBox = False
      OptionsView.HeaderHeight = 28
      OptionsView.Indicator = True
      object BankFileGridTableViewFileName: TcxGridColumn
        Caption = 'Name'
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Options.Focusing = False
        Width = 255
      end
      object BankFileGridTableViewFileFormat: TcxGridColumn
        Caption = 'Bank'
        RepositoryItem = AccsDataModule.erBankLookup
        HeaderAlignmentVert = vaCenter
        Width = 145
      end
      object BankFileGridTableViewFileDateTime: TcxGridColumn
        Caption = 'Created On'
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Options.Focusing = False
        SortIndex = 0
        SortOrder = soDescending
        Width = 125
      end
    end
    object BankFileGridLevel: TcxGridLevel
      GridView = BankFileGridTableView
    end
  end
  object btnClose: TcxButton
    Left = 479
    Top = 404
    Width = 90
    Height = 32
    Action = actCancel
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 1
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000420B0000420B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FF4A5E8642557C313F5BFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4A5E8642557C38619038
      6190313F5BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      4A5E8642557C3F67973C6594396291386190313F5B394A6B394A6B394A6B394A
      6B394A6B394A6BFF00FFFF00FFFF00FF4A5E86446D9C416A993F67973C65943A
      6392313F5B3A577A42638C42638C42638C42638C394A6BFF00FFFF00FFFF00FF
      4A5E86476F9F446D9C416A993F67973D6695313F5B0F49340F47320F46320F45
      31104531394A6BFF00FFFF00FFFF00FF4A5E864A72A2476F9F446D9C416A9940
      6998313F5B164D38164A36154935164633154431394A6BFF00FFFF00FFFF00FF
      4A5E864D75A54A72A2476F9F446D9C436B9B313F5B1C7A5B1C7C5E1D7D601E78
      5B1E7257394A6BFF00FFFF00FFFF00FF4A5E864F77A74D75A56188B96188B946
      6E9E313F5B1F83601E79581E6E4F1D6245205E43394A6BFF00FFFF00FFFF00FF
      4A5E86527AAA4F77A76188B9FFFFFF4871A0313F5B5A7662798370959484AF9C
      8ABB9887394A6BFF00FFFF00FFFF00FF4A5E86567EAE527AAA4F77A74E76A64B
      73A3313F5BF0BAA4F0B297F1BFA8F0BFA8F1BFA9394A6BFF00FFFF00FFFF00FF
      4A5E865A81B2567EAE527AAA5179A94E76A6313F5BF0B79EF2BFA9F4E0D7F2C6
      AEF1A581394A6BFF00FFFF00FFFF00FF4A5E865D85B55A81B2567EAE547CAC51
      79A9313F5BEE7B45F0A27DF1A986EF7D45F08956394A6BFF00FFFF00FFFF00FF
      4A5E866188B95D85B55A81B2587FB0547CAC313F5BED733BEC6F34EB6F33EC6E
      32EE8655394A6BFF00FFFF00FFFF00FF42557C4A5E866188B95D85B55B83B358
      7FB0313F5BE96F3CE65F24E76731EE9D7BED946D394A6BFF00FFFF00FFFF00FF
      FF00FFFF00FF4A5E8642557C5F86B75B83B3313F5B394A6B394A6B394A6B394A
      6B394A6B394A6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4A5E8642
      557C313F5BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    LookAndFeel.NativeStyle = True
  end
  object cxButton1: TcxButton
    Left = 24
    Top = 404
    Width = 90
    Height = 32
    Action = actSettings
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000130B0000130B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FF94A8A89AA3A3FF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF829B9B839C9CA8C3C69A
      C4C191AAAA9EA3A3A6B7BAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      9C9F9F92A8AA749397728C8D88A3A26F91948BA5A4B4CBCBA6C4C8FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF6B807F748D8B7C979B748F907897968C
      ABAF7B959292ACAC96B2B29BA9AAA0AFB0A8BBBEFF00FFFF00FFFF00FF8F9F9F
      768F946881816F8888809F9D84A6A587A9A792BBB79BBFC099B9B791ABAAB1C8
      CBFF00FFFF00FFFF00FFFF00FF8D95946B838273898889A2A088A3A187A8A59D
      C5C19BC4C182A8A770928F8DA3A4A3C0C59AAAACA1A7A7FF00FFA2A7A78CA2A2
      768D8B728B89728D8B738D8A79959289ADA984A8A4799A988AACA9A7C5C988AD
      B196B6B7B1C5C4FF00FF9EA3A3899E9D7C9492849F9F849F9F79908E89999682
      8E8C87A4A088AEAA9FC0BF93BCB9668886A0B9B8FF00FFFF00FFFF00FF969A9A
      9AB0AE88A3A37992937388888197969EA2A27C918D91B6B2B4D7D6B8DEDB98B7
      B895B4B7ABC5C8A9AFAFFF00FF8E9A999FB2B07B9796748D8E6E838468808069
      7D7B6F848196B2AEBFE3E0C4E4E49DBDBF8DB3B6C4E1E1BACBC9FF00FF8F9595
      9BAFAC8DA8A75C797A5670734761634E6666617C7A8FAAA7C7E6E6AACFCF7798
      958AA7A6AEB9B9FF00FFFF00FFFF00FF98A6A496B0B3597A7C415D62425E6047
      605F6B888691AFADAFD0D195B4B38CA8AB9FBEC3A7B5B6FF00FFFF00FFFF00FF
      8F95947E93908CA9AC819C9F6D8787708D8C7F9C9A86A1A0698682688B869ABC
      BFBCDBD9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF989F9F849F9E869F9E80
      9B98728C89647C7A88A4A291B2B29CB7B6A9AEAEFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF8F9998FF00FF7B8A89A0B5B685939499B0AEB0C0C0FF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF94
      9999A0A8A7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    LookAndFeel.NativeStyle = True
  end
  object cxLabel1: TcxLabel
    Left = 24
    Top = 14
    AutoSize = False
    Caption = 
      'The program has identified the following files which may be bank' +
      ' statement files that you have downloaded via online banking.  '#13 +
      #10#13#10'Before clicking the '#39'Import'#39' button make sure the correct Ban' +
      'k is selected for the file you are importing. If required, you c' +
      'an change the default Bank by clicking into the Bank column and ' +
      'choosing another Bank.'#13#10#13#10'Click Ignore File if the file is not a' +
      ' bank file or has been read in already. This will permanently re' +
      'move the file from BankLink.'#13#10
    ParentColor = False
    Properties.Alignment.Horz = taLeftJustify
    Properties.Alignment.Vert = taVCenter
    Properties.WordWrap = True
    Style.Color = clInfoBk
    Style.TextColor = clNavy
    Height = 169
    Width = 549
  end
  object btnImport: TcxButton
    Left = 384
    Top = 404
    Width = 90
    Height = 32
    Action = actImport
    Default = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000320B0000320B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAFAFAF9B9EA09B9EA09B9EA09B9E
      A09B9EA09B9EA09B9EA0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFAFAFAFFEFEFDFBFBFAF5F5F4EEEEEDE8E8E7D2D2D29B9EA0FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAFAFAF0086C10086C10086C10086
      C10086C1EBEBEA9B9EA0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFAFAFAF0097DE5FE3FF00D6FF00C4EE0097DEF1F1F09B9EA0FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAFAFAFCDF0FF0097DE00D6FF0097
      DECDF0FFF8F8F79B9EA0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFAFAFAFFEFEFD00ABFA5FE3FF0097DEFEFEFDFEFEFD9B9EA044B1E4107FAD
      107FAD107FAD107FAD107FAD107FAD107FADAFAFAFFEFEFDCDF0FF0097DECDF0
      FF9B9EA09B9EA09B9EA044B1E4FEFEFDFBFBFAF5F5F4EEEEEDE8E8E7D2D2D210
      7FADAFAFAFFEFEFDFEFEFDFEFEFDFEFEFD9B9EA0969696FF00FF44B1E4FEFEFD
      FEFEFD0021ADF5F5F4EEEEEDEBEBEA107FADAFAFAF9B9EA09B9EA09B9EA00470
      099B9EA0FF00FFFF00FF44B1E4FEFEFD0021AD2152E70021ADF8F8F7F1F1F010
      7FADFF00FFFF00FFFF00FF04700917C762047009FF00FFFF00FF44B1E41839DE
      6373E72152E72152E70021ADF8F8F7107FADFF00FFFF00FF04700917C76210A5
      1B0F951C047009FF00FF44B1E4FEFEFD1839DE6373E70021ADFEFEFDFEFEFD10
      7FADFF00FF04700917C76210A51B10A51B10A51B0F951C04700944B1E4FEFEFD
      FEFEFD1839DEFEFEFDFEFEFDFEFEFD107FADFF00FFFF00FFFF00FF10A51B0F95
      1C098311FF00FFFF00FF44B1E4FEFEFDFEFEFDFEFEFDFEFEFD107FAD107FAD10
      7FADFF00FFFF00FFFF00FF10A51B098311FF00FFFF00FFFF00FF44B1E4FEFEFD
      FEFEFDFEFEFDFEFEFD107FAD209FDAFF00FFFF00FFFF00FF1894290F951C0983
      11FF00FFFF00FFFF00FF44B1E444B1E444B1E444B1E444B1E4107FADFF00FF18
      94290F951C0F951C0F951C098311FF00FFFF00FFFF00FFFF00FF}
    LookAndFeel.NativeStyle = True
  end
  object FileDirectoryLabel: TcxLabel
    Left = 24
    Top = 357
    AutoSize = False
    Caption = 'FileDirectoryLabel'
    Style.TextColor = clBlue
    Height = 37
    Width = 548
  end
  object cxButton2: TcxButton
    Left = 120
    Top = 404
    Width = 90
    Height = 32
    Action = actIgnore
    Caption = '&Ignore File'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
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
    LookAndFeel.NativeStyle = True
  end
  object ActionList1: TActionList
    Left = 166
    Top = 278
    object actImport: TAction
      Caption = '&Import'
      Enabled = False
      OnExecute = actImportExecute
    end
    object actSettings: TAction
      Caption = '&Settings'
      OnExecute = actSettingsExecute
    end
    object actCancel: TAction
      Caption = '&Cancel'
      OnExecute = actCancelExecute
    end
    object actIgnore: TAction
      Caption = '&Ignore'
      OnExecute = actIgnoreExecute
      OnUpdate = actIgnoreUpdate
    end
  end
  object EnableImportTimer: TTimer
    Enabled = False
    Interval = 250
    OnTimer = EnableImportTimerTimer
    Left = 266
    Top = 396
  end
end
