object frmMain: TfrmMain
  Left = 228
  Top = 163
  BorderStyle = bsDialog
  Caption = 'FIRENA - File Renamer'
  ClientHeight = 234
  ClientWidth = 419
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 8
    Top = 144
    Width = 104
    Height = 13
    Caption = #1056#1072#1073#1086#1095#1072#1103' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1103
  end
  object Label6: TLabel
    Left = 304
    Top = 144
    Width = 74
    Height = 13
    Caption = #1052#1072#1089#1082#1072' '#1092#1072#1081#1083#1086#1074
  end
  object edWorkDir: TDirectoryEdit
    Left = 8
    Top = 160
    Width = 281
    Height = 21
    DialogKind = dkWin32
    NumGlyphs = 1
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 401
    Height = 121
    Caption = ' '#1053#1072#1089#1090#1088#1086#1081#1082#1080' '
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 211
      Height = 13
      Caption = #1044#1080#1072#1087#1072#1079#1086#1085' '#1079#1085#1072#1095#1077#1085#1080#1081' '#1076#1083#1103' '#1087#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1085#1080#1103
    end
    object Label2: TLabel
      Left = 8
      Top = 72
      Width = 105
      Height = 13
      Caption = #1053#1072#1095#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
    end
    object Label3: TLabel
      Left = 160
      Top = 72
      Width = 46
      Height = 13
      Caption = #1055#1088#1077#1092#1080#1082#1089
    end
    object Label4: TLabel
      Left = 272
      Top = 72
      Width = 39
      Height = 13
      Caption = #1064#1080#1088#1080#1085#1072
    end
    object edRange: TEdit
      Left = 8
      Top = 40
      Width = 385
      Height = 21
      TabOrder = 0
    end
    object edStartNum: TEdit
      Left = 8
      Top = 88
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object edPrefix: TEdit
      Left = 160
      Top = 88
      Width = 81
      Height = 21
      TabOrder = 2
    end
    object edNumWidth: TEdit
      Left = 272
      Top = 88
      Width = 121
      Height = 21
      TabOrder = 3
      Text = '5'
    end
  end
  object Button1: TButton
    Left = 8
    Top = 200
    Width = 401
    Height = 25
    Caption = #1054#1073#1088#1072#1073#1086#1090#1072#1090#1100
    TabOrder = 2
    OnClick = Button1Click
  end
  object edFileMask: TEdit
    Left = 304
    Top = 160
    Width = 105
    Height = 21
    TabOrder = 3
    Text = '*.*'
  end
  object FormStorage1: TFormStorage
    Options = [fpPosition]
    StoredProps.Strings = (
      'edRange.Text'
      'edStartNum.Text'
      'edNumWidth.Text'
      'edPrefix.Text'
      'edWorkDir.Text'
      'edFileMask.Text')
    StoredValues = <>
    Left = 384
    Top = 8
  end
end
