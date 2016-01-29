object RegionChooseDlg: TRegionChooseDlg
  Left = 541
  Top = 312
  BorderStyle = bsDialog
  Caption = 'RegionChooseDlg'
  ClientHeight = 149
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 56
    Width = 36
    Height = 13
    Caption = '&'#1056#1077#1075#1080#1086#1085
    FocusControl = cbRegion
  end
  object Label2: TLabel
    Left = 16
    Top = 8
    Width = 57
    Height = 13
    Caption = '&'#1048#1084#1103' '#1092#1072#1081#1083#1072
    FocusControl = feFilename
  end
  object cbRegion: TComboBox
    Left = 16
    Top = 72
    Width = 297
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = #1042#1089#1077' '#1088#1077#1075#1080#1086#1085#1099
    OnSelect = cbRegionSelect
    Items.Strings = (
      #1042#1089#1077' '#1088#1077#1075#1080#1086#1085#1099
      #1058#1077#1082#1091#1097#1080#1081' '#1088#1077#1075#1080#1086#1085
      '---------------------')
  end
  object btnOK: TButton
    Left = 152
    Top = 104
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 240
    Top = 104
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object feFilename: TFilenameEdit
    Left = 16
    Top = 24
    Width = 297
    Height = 21
    DefaultExt = 'csv'
    Filter = #1057#1087#1080#1089#1082#1080' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081' (*.csv)|*.csv'
    NumGlyphs = 1
    TabOrder = 3
    OnChange = feFilenameChange
  end
end
