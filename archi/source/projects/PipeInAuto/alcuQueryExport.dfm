object alcuQueryExportDlg: TalcuQueryExportDlg
  Left = 313
  Top = 207
  Width = 624
  Height = 242
  Caption = 'alcuQueryExportDlg'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 50
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 37
    Height = 13
    Caption = #1047#1072#1087#1088#1086#1089
  end
  object Label3: TLabel
    Left = 8
    Top = 64
    Width = 42
    Height = 13
    Caption = #1060#1086#1088#1084#1072#1090
  end
  object Label4: TLabel
    Left = 8
    Top = 88
    Width = 39
    Height = 13
    Caption = #1056#1072#1079#1084#1077#1088
  end
  object Label5: TLabel
    Left = 8
    Top = 112
    Width = 32
    Height = 13
    Caption = #1055#1072#1087#1082#1072
  end
  object EditCaption: TEdit
    Left = 104
    Top = 8
    Width = 361
    Height = 21
    TabOrder = 0
    Text = 'editCaption'
  end
  object comboQuery: TComboBox
    Left = 104
    Top = 35
    Width = 281
    Height = 21
    ItemHeight = 13
    TabOrder = 1
    Text = 'comboQuery'
  end
  object ButtonImport: TButton
    Left = 392
    Top = 32
    Width = 75
    Height = 25
    Caption = #1048#1084#1087#1086#1088#1090
    Enabled = False
    TabOrder = 2
    OnClick = ButtonImportClick
  end
  object ComboFormat: TComboBox
    Left = 104
    Top = 64
    Width = 361
    Height = 21
    ItemHeight = 13
    TabOrder = 3
    Text = 'ComboFormat'
  end
  object EditPartSize: TEdit
    Left = 104
    Top = 88
    Width = 361
    Height = 21
    TabOrder = 4
    Text = 'EditPartSize'
  end
  object EditFolder: TEdit
    Left = 104
    Top = 112
    Width = 361
    Height = 21
    TabOrder = 5
    Text = 'EditFolder'
  end
  object Button2: TButton
    Left = 520
    Top = 8
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object Button3: TButton
    Left = 520
    Top = 40
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 7
  end
end
