object ddProcessDialog: TddProcessDialog
  Left = 208
  Top = 177
  BorderStyle = bsSingle
  ClientHeight = 415
  ClientWidth = 551
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    551
    415)
  PixelsPerInch = 96
  TextHeight = 14
  object LabelTitle: TLabel
    Left = 40
    Top = 8
    Width = 473
    Height = 24
    Alignment = taCenter
    AutoSize = False
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1087#1088#1086#1094#1077#1089#1089#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object panelItems: TPanel
    Left = 32
    Top = 32
    Width = 489
    Height = 97
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 0
    object groupItems: TGroupBox
      Left = 0
      Top = 0
      Width = 489
      Height = 97
      Align = alClient
      Caption = #1069#1090#1072#1087#1099' '#1086#1073#1088#1072#1073#1086#1090#1082#1080
      TabOrder = 0
    end
  end
  object butCancel: TButton
    Left = 448
    Top = 384
    Width = 89
    Height = 25
    Caption = #1055#1088#1077#1088#1074#1072#1090#1100
    ModalResult = 2
    TabOrder = 1
    OnClick = butCancelClick
  end
  object PanelProgress: TPanel
    Left = 32
    Top = 328
    Width = 489
    Height = 33
    BevelOuter = bvNone
    TabOrder = 2
    object labelDescript: TLabel
      Left = 0
      Top = 19
      Width = 489
      Height = 14
      Align = alBottom
      Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077' '#1086' '#1090#1077#1082#1091#1097#1077#1084' '#1101#1090#1072#1087#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Progress: TProgressBar
      Left = 0
      Top = 0
      Width = 489
      Height = 17
      Align = alTop
      TabOrder = 0
    end
  end
  object IdleTimer: TTimer
    Enabled = False
    OnTimer = IdleTimerTimer
    Left = 8
    Top = 8
  end
end
