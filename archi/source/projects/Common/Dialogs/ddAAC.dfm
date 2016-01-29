object ddAACForm: TddAACForm
  Left = 335
  Top = 167
  Width = 664
  Height = 588
  Caption = #1040#1090#1088#1080#1073#1091#1090#1099' '#1087#1086#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1103' '#1040#1040#1057
  Color = clBtnFace
  DefaultMonitor = dmPrimary
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object BtnPanel: TPanel
    Left = 0
    Top = 511
    Width = 648
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object OkBTN: TBitBtn
      Left = 32
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1050
      Default = True
      ModalResult = 7
      TabOrder = 0
      OnClick = OkBTNClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object CancelBTN: TBitBtn
      Left = 128
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = CancelBTNClick
      Kind = bkCancel
    end
    object AddBitBtn: TBitBtn
      Left = 448
      Top = 8
      Width = 75
      Height = 25
      Action = AddRow
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 2
    end
    object DeleteBitBtn: TBitBtn
      Left = 544
      Top = 8
      Width = 75
      Height = 25
      Action = DelRow
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 3
    end
  end
  object vtDateGroupBox: TvtGroupBox
    Left = 0
    Top = 71
    Width = 648
    Height = 151
    Align = alTop
    Caption = ' '#1044#1072#1090#1099'-'#1085#1086#1084#1077#1088#1072': '
    TabOrder = 1
    object NuberLabel: TvtLabel
      Left = 18
      Top = 120
      Width = 76
      Height = 16
      Caption = #1053#1086#1084#1077#1088' '#1076#1077#1083#1072':'
    end
    object NumberEdit: TevEdit
      Left = 106
      Top = 117
      Width = 263
      Height = 25
      LMargin = 1
      TabOrder = 1
      TabStop = True
      BorderStyle = bsSingle
    end
    object vtGroupBox3: TvtGroupBox
      Left = 18
      Top = 18
      Width = 367
      Height = 90
      Caption = ' '#1048#1079#1076#1072#1085': '
      TabOrder = 0
      object vtDateLabel: TvtLabel
        Left = 22
        Top = 23
        Width = 32
        Height = 16
        Caption = #1044#1072#1090#1072':'
      end
      object vtIzdanLabel: TvtLabel
        Left = 22
        Top = 58
        Width = 43
        Height = 16
        Caption = #1053#1086#1084#1077#1088':'
      end
      object IzdanNumberEdit: TevEdit
        Left = 80
        Top = 54
        Width = 273
        Height = 25
        LMargin = 1
        TabOrder = 1
        TabStop = True
        BorderStyle = bsSingle
      end
      object vtDateEdit: TvtDateEdit
        Left = 80
        Top = 16
        Width = 273
        Height = 24
        Style = csDropDown
        TabOrder = 0
      end
    end
  end
  object vtListGroupBox: TvtGroupBox
    Left = 0
    Top = 222
    Width = 648
    Height = 289
    Align = alClient
    Caption = ' '#1059#1095#1072#1089#1090#1085#1080#1082#1080' '#1076#1077#1083#1072': '
    TabOrder = 2
  end
  object TypePanel: TPanel
    Left = 0
    Top = 0
    Width = 648
    Height = 71
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object TypeLable: TvtLabel
      Left = 8
      Top = 11
      Width = 92
      Height = 16
      Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072':'
    end
    object vtLabel1: TvtLabel
      Left = 8
      Top = 45
      Width = 112
      Height = 16
      Caption = #1048#1089#1093#1086#1076#1103#1097#1080#1081' '#1086#1088#1075#1072#1085':'
    end
    object vtTypeCB: TvtComboBox
      Left = 134
      Top = 9
      Width = 371
      Height = 24
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
    end
    object vtOrganCB: TvtComboBox
      Left = 134
      Top = 43
      Width = 371
      Height = 24
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 1
    end
  end
  object ActionList1: TActionList
    Left = 336
    Top = 174
    object AddRow: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnExecute = AddRowExecute
      OnUpdate = AddRowUpdate
    end
    object DelRow: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = DelRowExecute
      OnUpdate = DelRowUpdate
    end
  end
end
