object MainForm: TMainForm
  Left = 400
  Top = 163
  BorderStyle = bsDialog
  Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1087#1086' '#1088#1072#1073#1086#1090#1077' '#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1084#1080
  ClientHeight = 213
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 8
    Top = 102
    Width = 91
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082
  end
  object Label7: TLabel
    Left = 12
    Top = 136
    Width = 88
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1069#1090#1072#1087
  end
  object Label4: TLabel
    Left = 56
    Top = 12
    Width = 41
    Height = 16
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1044#1072#1090#1099
  end
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 443
    Height = 167
    Align = alTop
  end
  object bGo: TButton
    Left = 30
    Top = 180
    Width = 75
    Height = 25
    Caption = #1055#1086#1080#1089#1082
    TabOrder = 0
    OnClick = bGoClick
  end
  object bClose: TButton
    Left = 344
    Top = 180
    Width = 75
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 1
    OnClick = bCloseClick
  end
  object cbUser: TComboBox
    Left = 107
    Top = 99
    Width = 299
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
  object cbStage: TComboBox
    Left = 107
    Top = 131
    Width = 299
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
  end
  object GroupBox2: TGroupBox
    Left = 106
    Top = 3
    Width = 300
    Height = 85
    TabOrder = 4
    object Label9: TLabel
      Left = 13
      Top = 26
      Width = 30
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1057
    end
    object Label10: TLabel
      Left = 8
      Top = 55
      Width = 37
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1055#1054
    end
    object edtLowDate: TvtDateEdit
      Left = 57
      Top = 23
      Width = 121
      Height = 21
      Style = csDropDown
      TabOrder = 0
    end
    object edtHighDate: TvtDateEdit
      Left = 57
      Top = 52
      Width = 121
      Height = 21
      Style = csDropDown
      TabOrder = 1
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    FileName = 'JobStats.txt'
    Filter = 'Text files (*.txt)|*.TXT'
    Title = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1074' '#1087#1086#1080#1089#1082#1072
    Left = 110
    Top = 182
  end
  object XPManifest1: TXPManifest
    Left = 8
    Top = 8
  end
end
