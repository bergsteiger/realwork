object frmFind: TfrmFind
  Left = 368
  Top = 293
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
  ClientHeight = 226
  ClientWidth = 305
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 49
    Height = 13
    Caption = #1055#1086' '#1080#1084#1077#1085#1080
  end
  object Bevel1: TBevel
    Left = 8
    Top = 48
    Width = 289
    Height = 10
    Shape = bsBottomLine
  end
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 28
    Height = 13
    Caption = #1055#1086' ID'
  end
  object Bevel2: TBevel
    Left = 8
    Top = 104
    Width = 289
    Height = 10
    Shape = bsBottomLine
  end
  object Label3: TLabel
    Left = 8
    Top = 120
    Width = 51
    Height = 13
    Caption = #1055#1086' '#1083#1086#1075#1080#1085#1091
  end
  object edFindName: TComboBox
    Left = 8
    Top = 24
    Width = 201
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    OnChange = edFindNameChange
    OnEnter = edFindNameEnter
  end
  object btnFindName: TButton
    Left = 221
    Top = 22
    Width = 75
    Height = 25
    Caption = #1048#1089#1082#1072#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = btnFindNameClick
  end
  object edFindID: TComboBox
    Left = 8
    Top = 80
    Width = 201
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    OnChange = edFindIDChange
    OnEnter = edFindIDEnter
  end
  object btnFindID: TButton
    Left = 221
    Top = 78
    Width = 75
    Height = 25
    Caption = #1048#1089#1082#1072#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = btnFindIDClick
  end
  object edFindLogin: TComboBox
    Left = 8
    Top = 136
    Width = 201
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    OnChange = edFindLoginChange
    OnEnter = edFindLoginEnter
  end
  object btnFindLogin: TButton
    Left = 221
    Top = 134
    Width = 75
    Height = 25
    Caption = #1048#1089#1082#1072#1090#1100
    Enabled = False
    TabOrder = 5
    OnClick = btnFindLoginClick
  end
  object btnCancel: TButton
    Left = 221
    Top = 192
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 6
  end
end
