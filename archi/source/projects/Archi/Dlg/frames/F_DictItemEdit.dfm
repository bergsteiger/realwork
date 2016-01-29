object DictItemEditFrame: TDictItemEditFrame
  Left = 0
  Top = 0
  Width = 509
  Height = 353
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object pnlName: TPanel
    Left = 0
    Top = 0
    Width = 509
    Height = 236
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    OnResize = pnlNameResize
    DesignSize = (
      509
      236)
    object lblNameRus: TLabel
      Left = 10
      Top = 12
      Width = 458
      Height = 16
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1085#1072' '#1088#1091#1089#1089#1082#1086#1084
    end
    object sbSpellChecker: TSpeedButton
      Left = 475
      Top = 6
      Width = 25
      Height = 25
      Hint = #1055#1088#1086#1074#1077#1088#1082#1072' '#1086#1088#1092#1086#1075#1088#1072#1092#1080#1080'|'
      Anchors = [akTop, akRight]
      Enabled = False
      Glyph.Data = {
        F2010000424DF201000000000000760000002800000026000000130000000100
        0400000000007C01000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        77777777777777777777777777007777777777777777777777FFFFFFFFFFFF77
        7700770000000000007777777888888888888F777700770FFFFFFFFFF0777777
        78F7777777778F777700770FFFFF9FFFF077777778FFF778FFF78F777700770F
        00F99F00F077777778F88788F8878F777700770FFFF999FFF077777778F77788
        8F778F777700770F0F99F99FF077777778F8788F88F78F777700770FFF99FF99
        F077777778F7788FF88F8F777700770F0F9F00F99F77777778F878F88788F777
        7700770FFFFFFFFF9977777778FFFFFFFF788F777700770F0000000FF9977777
        78F88888887788F77700770FFFFFFFFFFF97777778F7F7F77FFFF8F77700770F
        0000FF000077777778F8888778888F777700770FFFFFFF070777777778F77777
        78F8F7777700770FFFFFFF007777777778FFFFFFF88F77777700770000000007
        777777777888888888F777777700777777777777777777777777777777777777
        77007777777777777777777777777777777777777700}
      Margin = 3
      NumGlyphs = 2
    end
    object lblNameEng: TLabel
      Left = 9
      Top = 122
      Width = 490
      Height = 16
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1085#1072' '#1072#1085#1075#1083#1080#1081#1089#1082#1086#1084
    end
    object mNameRus: TevMemo
      Left = 9
      Top = 35
      Width = 492
      Height = 82
      TextSource.OnBruttoCharCountChange = mNameTextSourceBruttoCharCountChange
      Anchors = [akLeft, akTop, akRight]
      RMargin = 8
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      TabStop = True
      BorderStyle = bsSingle
    end
    object mNameEng: TevMemo
      Left = 9
      Top = 144
      Width = 492
      Height = 82
      TextSource.OnBruttoCharCountChange = mNameTextSourceBruttoCharCountChange
      Anchors = [akLeft, akTop, akRight]
      RMargin = 8
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 1
      TabStop = True
      BorderStyle = bsSingle
    end
  end
  object AddedDataPanel: TPanel
    Left = 0
    Top = 236
    Width = 509
    Height = 117
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object pnlExtCode: TPanel
      Left = 0
      Top = 0
      Width = 509
      Height = 60
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        509
        60)
      object Label2: TLabel
        Left = 8
        Top = 7
        Width = 24
        Height = 16
        Caption = #1050#1086#1076
      end
      object edtCode: TEdit
        Left = 7
        Top = 27
        Width = 496
        Height = 24
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
    end
    object pnlExtPrivate: TPanel
      Left = 0
      Top = 60
      Width = 509
      Height = 52
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object cbxPrivate: TCheckBox
        Left = 8
        Top = 4
        Width = 378
        Height = 17
        Caption = #1058#1086#1083#1100#1082#1086' '#1076#1083#1103' '#1074#1085#1091#1090#1088#1077#1085#1085#1077#1075#1086' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103
        TabOrder = 0
      end
      object cbxIsNonPeriodic: TCheckBox
        Left = 8
        Top = 28
        Width = 378
        Height = 17
        Caption = #1053#1077#1087#1077#1088#1080#1086#1076#1080#1095#1077#1089#1082#1086#1077' '#1080#1079#1076#1072#1085#1080#1077
        TabOrder = 1
      end
    end
  end
end
