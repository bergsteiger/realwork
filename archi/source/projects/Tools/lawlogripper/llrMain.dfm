object Form1: TForm1
  Left = 224
  Top = 235
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1086#1080#1089#1082' '#1087#1086#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1081' '#1087#1086' '#1083#1086#1075#1072#1084
  ClientHeight = 360
  ClientWidth = 715
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 312
    Width = 715
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      715
      48)
    object btnStart: TButton
      Left = 542
      Top = 13
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1053#1072#1095#1072#1090#1100
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnCancel: TButton
      Left = 630
      Top = 13
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 300
    Width = 715
    Height = 12
    Align = alBottom
    TabOrder = 1
  end
  object pnlControls: TPanel
    Left = 0
    Top = 0
    Width = 715
    Height = 300
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
  end
end
