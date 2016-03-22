object Form1: TForm1
  Left = 403
  Top = 326
  BorderStyle = bsDialog
  Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077' '#1085#1086#1084#1077#1088#1086#1074
  ClientHeight = 165
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Arial Narrow'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 4
    Width = 81
    Height = 16
    Caption = #1048#1089#1093#1086#1076#1085#1099#1081' '#1092#1072#1081#1083
  end
  object Label2: TLabel
    Left = 8
    Top = 44
    Width = 119
    Height = 16
    Caption = #1056#1077#1079#1091#1083#1100#1090#1080#1088#1091#1102#1097#1080#1081' '#1092#1072#1081#1083
  end
  object Button1: TButton
    Left = 344
    Top = 16
    Width = 141
    Height = 49
    Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1085#1086#1084#1077#1088#1072
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object EditSource: TEdit
    Left = 8
    Top = 24
    Width = 297
    Height = 24
    TabOrder = 1
  end
  object ButtonLookSrc: TButton
    Left = 312
    Top = 24
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 2
    OnClick = ButtonLookSrcClick
  end
  object EditDestination: TEdit
    Left = 8
    Top = 64
    Width = 297
    Height = 24
    TabOrder = 3
  end
  object ButtonLookdest: TButton
    Left = 312
    Top = 64
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 4
    OnClick = ButtonLookdestClick
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 96
    Width = 329
    Height = 41
    Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #1042#1085#1077#1096#1085#1080#1077' -> '#1042#1085#1091#1090#1088#1077#1085#1085#1080#1077
      #1042#1085#1091#1090#1088#1077#1085#1085#1080#1077' -> '#1042#1085#1077#1096#1085#1080#1077)
    TabOrder = 5
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 144
    Width = 329
    Height = 17
    TabOrder = 6
    Visible = False
  end
end
