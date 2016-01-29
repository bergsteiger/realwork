object RegionEditDlg: TRegionEditDlg
  Left = 1910
  Top = 235
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1099#1081' '#1080#1089#1090#1086#1095#1085#1080#1082' '#1076#1077#1083#1100#1090
  ClientHeight = 261
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = '@Arial Unicode MS'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 12
    Width = 51
    Height = 15
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077
  end
  object Label6: TLabel
    Left = 16
    Top = 172
    Width = 111
    Height = 15
    Caption = #1064#1072#1073#1083#1086#1085' '#1080#1084#1077#1085#1080' '#1092#1072#1081#1083#1072
  end
  object Label7: TLabel
    Left = 16
    Top = 200
    Width = 102
    Height = 15
    Caption = #1040#1076#1088#1077#1089' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103
  end
  object editDescription: TEdit
    Left = 132
    Top = 8
    Width = 273
    Height = 23
    TabOrder = 0
    OnChange = editDescriptionChange
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 36
    Width = 401
    Height = 127
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' FTP'
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 22
      Width = 38
      Height = 15
      Caption = #1057#1077#1088#1074#1077#1088
    end
    object Label3: TLabel
      Left = 8
      Top = 46
      Width = 72
      Height = 15
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object Label4: TLabel
      Left = 8
      Top = 74
      Width = 38
      Height = 15
      Caption = #1055#1072#1088#1086#1083#1100
    end
    object Label5: TLabel
      Left = 8
      Top = 98
      Width = 91
      Height = 15
      Caption = #1055#1072#1087#1082#1072' '#1085#1072' '#1089#1077#1088#1074#1077#1088#1077
    end
    object editFTPServer: TEdit
      Left = 124
      Top = 18
      Width = 261
      Height = 23
      TabOrder = 0
    end
    object editFTPLogin: TEdit
      Left = 124
      Top = 44
      Width = 261
      Height = 23
      TabOrder = 1
    end
    object editFTPPassword: TEdit
      Left = 124
      Top = 70
      Width = 261
      Height = 23
      PasswordChar = '*'
      TabOrder = 2
    end
    object editFTPFolder: TEdit
      Left = 124
      Top = 94
      Width = 261
      Height = 23
      TabOrder = 3
    end
  end
  object editFileNameMask: TEdit
    Left = 132
    Top = 170
    Width = 277
    Height = 23
    TabOrder = 2
  end
  object Button1: TButton
    Left = 244
    Top = 226
    Width = 75
    Height = 25
    Caption = #1054#1050
    ModalResult = 1
    TabOrder = 4
  end
  object Button2: TButton
    Left = 336
    Top = 226
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 5
  end
  object editNotifyAddress: TEdit
    Left = 132
    Top = 196
    Width = 277
    Height = 23
    TabOrder = 3
  end
end
