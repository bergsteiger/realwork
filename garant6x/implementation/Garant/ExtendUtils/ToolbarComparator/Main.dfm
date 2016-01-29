object fmMain: TfmMain
  Left = 257
  Top = 242
  Width = 870
  Height = 640
  Caption = #1057#1088#1072#1074#1085#1077#1085#1080#1077' '#1090#1091#1083#1073#1072#1088#1086#1074
  Color = $00F9F8FA
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object TopPanel: TvtPanel
    Left = 0
    Top = 0
    Width = 852
    Height = 69
    Align = alTop
    TabOrder = 0
    object SourceLabel: TvtLabel
      Left = 6
      Top = 12
      Width = 134
      Height = 16
      Alignment = taRightJustify
      Caption = #1048#1079#1085#1072#1095#1072#1083#1100#1085#1099#1081' '#1092#1072#1081#1083
    end
    object TargetLabel: TvtLabel
      Left = 6
      Top = 40
      Width = 134
      Height = 16
      Alignment = taRightJustify
      Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1085#1099#1081' '#1092#1072#1081#1083
    end
    object RunBtn: TButton
      Left = 627
      Top = 8
      Width = 86
      Height = 53
      Caption = #1057#1088#1072#1074#1085#1080#1090#1100
      TabOrder = 6
      OnClick = RunBtnClick
    end
    object NewEdit: TvtComboBox
      Left = 143
      Top = 36
      Width = 345
      Height = 24
      Style = csSimple
      ItemHeight = 16
      TabOrder = 2
    end
    object SourceEdit: TvtComboBox
      Left = 143
      Top = 8
      Width = 345
      Height = 24
      Style = csSimple
      ItemHeight = 16
      TabOrder = 0
    end
    object SourceBtn: TButton
      Left = 491
      Top = 10
      Width = 69
      Height = 26
      Caption = #1054#1090#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = SourceBtnClick
    end
    object NewBtn: TButton
      Left = 491
      Top = 35
      Width = 69
      Height = 26
      Caption = #1054#1090#1082#1088#1099#1090#1100
      TabOrder = 4
      OnClick = NewBtnClick
    end
    object ClearBtn: TButton
      Left = 712
      Top = 8
      Width = 117
      Height = 53
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1083#1086#1075
      TabOrder = 7
      OnClick = ClearBtnClick
    end
    object SourceCheck: TeeCheckBox
      Left = 564
      Top = 12
      Width = 61
      Height = 17
      Caption = #1086#1090' 72'
      TabOrder = 3
    end
    object NewCheck: TeeCheckBox
      Left = 564
      Top = 40
      Width = 61
      Height = 17
      Caption = #1086#1090' 72'
      TabOrder = 5
    end
  end
  object BottomPanel: TvtPanel
    Left = 0
    Top = 69
    Width = 852
    Height = 528
    Align = alClient
    TabOrder = 1
    object ResultsMemo: TevMemo
      Left = 1
      Top = 1
      Width = 850
      Height = 526
      Align = alClient
      ScrollStyle = ssBoth
      ReadOnly = True
      Font.Charset = DEFAULT_CHARSET
      Font.Name = 'Courier New'
      Wrap = False
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'XML'
    Filter = #1060#1072#1081#1083#1099' XML|*.xml'
    Options = [ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 740
    Top = 16
  end
end
