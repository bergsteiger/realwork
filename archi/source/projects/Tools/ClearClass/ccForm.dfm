object ClearClassForm: TClearClassForm
  Left = 528
  Top = 348
  BorderStyle = bsDialog
  Caption = #1057#1073#1088#1086#1089' '#1101#1090#1072#1087#1072' '#1050#1083#1072#1089#1089#1080#1092#1080#1082#1072#1094#1080#1103
  ClientHeight = 138
  ClientWidth = 590
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 97
    Width = 590
    Height = 41
    Align = alBottom
    Anchors = [akLeft, akBottom]
    TabOrder = 0
    DesignSize = (
      590
      41)
    object GoButton: TButton
      Left = 416
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = GoButtonClick
    end
    object CancelButton: TButton
      Left = 504
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #1042#1099#1093#1086#1076
      ModalResult = 2
      TabOrder = 1
      OnClick = CancelButtonClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 590
    Height = 97
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      590
      97)
    object ProgressLabel: TLabel
      Left = 8
      Top = 84
      Width = 577
      Height = 13
      Anchors = [akLeft, akBottom]
      AutoSize = False
    end
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 100
      Height = 13
      Caption = #1057#1087#1080#1089#1086#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
    end
    object ProgressBar: TProgressBar
      Left = 8
      Top = 68
      Width = 577
      Height = 17
      Anchors = [akLeft, akBottom]
      Smooth = True
      TabOrder = 0
    end
    object feTopicList: TFilenameEdit
      Left = 8
      Top = 24
      Width = 577
      Height = 21
      Filter = #1060#1072#1081#1083#1099' '#1089#1087#1080#1089#1086#1082#1074' (*.lst)|*.lst'
      NumGlyphs = 1
      TabOrder = 1
    end
  end
end
