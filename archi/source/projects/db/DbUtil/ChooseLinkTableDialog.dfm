object ChooseLinkTableDlg: TChooseLinkTableDlg
  Left = 282
  Top = 121
  BorderStyle = bsDialog
  Caption = #1047#1072#1084#1077#1085#1072' '#1089#1089#1099#1083#1086#1082' '#1085#1072' '#1101#1083#1077#1084#1077#1085#1090' '#1089#1083#1086#1074#1072#1088#1103
  ClientHeight = 141
  ClientWidth = 345
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
    Top = 16
    Width = 51
    Height = 13
    Caption = #1042' '#1090#1072#1073#1083#1080#1094#1077
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 99
    Height = 13
    Caption = #1047#1072#1084#1077#1085#1080#1090#1100' '#1089#1089#1099#1083#1082#1091' '#1089
  end
  object Label3: TLabel
    Left = 8
    Top = 72
    Width = 12
    Height = 13
    Caption = #1085#1072
  end
  object ComboBox1: TComboBox
    Left = 64
    Top = 16
    Width = 169
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object vtSpinEdit1: TvtSpinEdit
    Left = 112
    Top = 48
    Width = 121
    Height = 21
    UseMaxValue = False
    UseMinValue = False
    TabOrder = 1
  end
  object vtSpinEdit2: TvtSpinEdit
    Left = 112
    Top = 72
    Width = 121
    Height = 21
    UseMaxValue = False
    UseMinValue = False
    TabOrder = 2
  end
  object Button1: TButton
    Left = 256
    Top = 16
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object Button2: TButton
    Left = 256
    Top = 48
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 4
  end
end
