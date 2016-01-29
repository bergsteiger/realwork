object Form1: TForm1
  Left = 318
  Top = 154
  BorderStyle = bsDialog
  Caption = #1058#1072#1073#1091#1083#1103#1094#1080#1080' '#1074' '#1087#1088#1086#1073#1077#1083#1099
  ClientHeight = 157
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 8
    Top = 84
    Width = 134
    Height = 14
    Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077' '#1092#1086#1088#1084#1072#1090#1072
  end
  object Label2: TLabel
    Left = 8
    Top = 104
    Width = 159
    Height = 14
    Caption = #1042#1099#1095#1080#1089#1083#1077#1085#1080#1077' '#1083#1080#1096#1085#1080#1093' '#1089#1080#1084#1074#1086#1083#1086#1074
  end
  object Label3: TLabel
    Left = 8
    Top = 124
    Width = 145
    Height = 14
    Caption = #1059#1076#1072#1083#1077#1085#1080#1077' '#1083#1080#1096#1085#1080#1093' '#1089#1080#1084#1074#1086#1083#1086#1074
  end
  object Label4: TLabel
    Left = 8
    Top = 56
    Width = 101
    Height = 14
    Caption = #1057#1080#1084#1074#1086#1083#1086#1074' '#1074' '#1089#1090#1088#1086#1082#1077
  end
  object Label5: TLabel
    Left = 0
    Top = 143
    Width = 405
    Height = 14
    Align = alBottom
    Alignment = taRightJustify
    Caption = 'Label5'
    Enabled = False
  end
  object Step1LED: TLED
    Left = 388
    Top = 84
    Color = lcGreen
  end
  object Step2Led: TLED
    Left = 388
    Top = 104
    Color = lcGreen
  end
  object Step3Led: TLED
    Left = 388
    Top = 124
    Color = lcGreen
  end
  object Label9: TLabel
    Left = 8
    Top = 8
    Width = 166
    Height = 14
    Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072' '#1076#1083#1103' '#1087#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103
  end
  object editInFile: TFilenameEdit
    Left = 8
    Top = 24
    Width = 229
    Height = 21
    DefaultExt = '*.rtf'
    Filter = #1044#1086#1082#1091#1084#1077#1085#1090#1099' Microsoft Word|*.doc;*.rtf'
    NumGlyphs = 1
    TabOrder = 0
    OnChange = editInFileChange
  end
  object Button1: TButton
    Left = 252
    Top = 8
    Width = 133
    Height = 37
    Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object RxSpinEdit1: TRxSpinEdit
    Left = 172
    Top = 52
    Width = 77
    Height = 22
    ButtonKind = bkStandard
    Value = 205.000000000000000000
    TabOrder = 2
  end
  object cbBorders: TCheckBox
    Left = 256
    Top = 56
    Width = 129
    Height = 17
    Caption = #1042#1089#1090#1072#1074#1083#1103#1090#1100' '#1089#1077#1090#1082#1091
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object ProgressBar1: TProgressBar
    Left = 172
    Top = 80
    Width = 213
    Height = 17
    TabOrder = 4
  end
  object ProgressBar2: TProgressBar
    Left = 172
    Top = 100
    Width = 213
    Height = 17
    TabOrder = 5
  end
  object ProgressBar3: TProgressBar
    Left = 172
    Top = 120
    Width = 213
    Height = 17
    TabOrder = 6
  end
  object InFiler: TevDOSFiler
    NeedProcessMessages = True
    Indicator.NeedProgressProc = True
    Left = 88
    Top = 72
  end
  object OutFiler: TevDOSFiler
    NeedProcessMessages = True
    Indicator.NeedProgressProc = True
    Left = 148
    Top = 72
  end
  object OvcController1: TOvcController
    EntryCommands.TableList = (
      'Default'
      True
      ()
      'WordStar'
      False
      ()
      'Grid'
      False
      ())
    Left = 252
    Top = 72
  end
  object FinalFiler: TevDOSFiler
    NeedProcessMessages = True
    Left = 200
    Top = 72
  end
  object evDOSFiler1: TevDOSFiler
    NeedProcessMessages = True
    Indicator.NeedProgressProc = True
    Left = 36
    Top = 72
  end
  object XPManifest1: TXPManifest
    Left = 316
    Top = 76
  end
end
