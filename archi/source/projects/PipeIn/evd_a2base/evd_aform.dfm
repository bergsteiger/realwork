object ImportEVDForm: TImportEVDForm
  Left = 338
  Top = 177
  BorderStyle = bsDialog
  Caption = #1048#1084#1087#1086#1088#1090' '#1087#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1085#1099#1093' '#1087#1086#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1081
  ClientHeight = 351
  ClientWidth = 590
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object WorkPanel: TPanel
    Left = 0
    Top = 0
    Width = 590
    Height = 281
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 310
    Width = 590
    Height = 41
    Align = alBottom
    Anchors = [akLeft, akBottom]
    TabOrder = 1
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
    Top = 281
    Width = 590
    Height = 29
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      590
      29)
    object ProgressLabel: TLabel
      Left = 8
      Top = 16
      Width = 577
      Height = 13
      Anchors = [akLeft, akBottom]
      AutoSize = False
    end
    object ProgressBar: TProgressBar
      Left = 8
      Top = 0
      Width = 577
      Height = 17
      Anchors = [akLeft, akBottom]
      Smooth = True
      TabOrder = 0
    end
  end
end
