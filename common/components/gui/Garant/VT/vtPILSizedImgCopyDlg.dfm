object vtPILCopySizedDlg: TvtPILCopySizedDlg
  Left = 567
  Top = 311
  BorderStyle = bsDialog
  Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
  ClientHeight = 187
  ClientWidth = 217
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 137
    Height = 13
    Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103' :'
  end
  object Image1: TImage
    Left = 98
    Top = 72
    Width = 16
    Height = 16
    Picture.Data = {
      07544269746D617036030000424D360300000000000036000000280000001000
      000010000000010018000000000000030000120B0000120B0000000000000000
      0000008080008080008080008080008080008080008080008080008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000808000808000808000808000808000
      8080008080008080008080008080008080008080008080008080008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000808000808000808000808000808000
      8080008080008080008080008080008080008080000000000000008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      800080800000000000FF00000000000000808000808000808000808000808000
      80800080800080800080800080800080800080800000000000FF0000FF0000FF
      0000000000000080800080800080800080800000000000000000000000000000
      000000000000000000FF0000FF0000FF0000FF0000FF00000000000000808000
      80800000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
      0000FF0000FF0000FF0000FF0000000000000000000000000000000000000000
      000000000000000000FF0000FF0000FF0000FF0000FF00000000000000808000
      80800080800080800080800080800080800080800000000000FF0000FF0000FF
      0000000000000080800080800080800080800080800080800080800080800080
      800080800000000000FF00000000000000808000808000808000808000808000
      8080008080008080008080008080008080008080000000000000008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000808000808000808000808000808000
      8080008080008080008080008080008080008080008080008080008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000808000808000808000808000808000
      8080}
    Transparent = True
  end
  object Bevel1: TBevel
    Left = 16
    Top = 128
    Width = 185
    Height = 9
    Shape = bsTopLine
  end
  object cbxFrom: TGroupBox
    Left = 16
    Top = 32
    Width = 73
    Height = 89
    Caption = ' '#1048#1047' '
    TabOrder = 0
    object rb16from: TRadioButton
      Left = 8
      Top = 16
      Width = 57
      Height = 17
      Caption = '16x16'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rb16fromClick
    end
    object rb24from: TRadioButton
      Left = 8
      Top = 40
      Width = 57
      Height = 17
      Caption = '24x24'
      TabOrder = 1
      OnClick = rb24fromClick
    end
    object rb32from: TRadioButton
      Left = 8
      Top = 64
      Width = 57
      Height = 17
      Caption = '32x32'
      TabOrder = 2
      OnClick = rb32fromClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 128
    Top = 32
    Width = 73
    Height = 89
    Caption = ' '#1042' '
    TabOrder = 1
    object rb16to: TRadioButton
      Left = 8
      Top = 16
      Width = 57
      Height = 17
      Caption = '16x16'
      Enabled = False
      TabOrder = 0
      OnClick = rb16toClick
    end
    object rb24to: TRadioButton
      Left = 8
      Top = 40
      Width = 57
      Height = 17
      Caption = '24x24'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = rb24toClick
    end
    object rb32to: TRadioButton
      Left = 8
      Top = 64
      Width = 57
      Height = 17
      Caption = '32x32'
      TabOrder = 2
      OnClick = rb32toClick
    end
  end
  object Button1: TButton
    Left = 16
    Top = 144
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 126
    Top = 144
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
end
