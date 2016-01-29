object ddAboutDialog: TddAboutDialog
  Left = 282
  Top = 114
  BorderStyle = bsDialog
  Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
  ClientHeight = 214
  ClientWidth = 465
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  object imgIcon: TImage
    Left = 8
    Top = 8
    Width = 81
    Height = 121
    Center = True
    Proportional = True
    Stretch = True
  end
  object lblAppTitle: TLabel
    Left = 96
    Top = 16
    Width = 81
    Height = 19
    Caption = 'lblAppTitle'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVersion: TLabel
    Left = 96
    Top = 40
    Width = 48
    Height = 14
    Caption = 'lblVersion'
  end
  object lblDescription: TLabel
    Left = 96
    Top = 56
    Width = 64
    Height = 14
    Caption = 'lblDescription'
  end
  object lblCompany: TLabel
    Left = 96
    Top = 72
    Width = 55
    Height = 14
    Caption = 'lblCompany'
  end
  object Button1: TButton
    Left = 384
    Top = 104
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object memAdditional: TMemo
    Left = 8
    Top = 136
    Width = 449
    Height = 69
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
