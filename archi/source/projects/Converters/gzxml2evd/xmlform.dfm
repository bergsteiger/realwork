object ConverterForm: TConverterForm
  Left = 333
  Top = 176
  BorderStyle = bsDialog
  Caption = #1050#1086#1085#1074#1077#1088#1090#1077#1088' '#1087#1086#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1081
  ClientHeight = 297
  ClientWidth = 562
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
    Width = 562
    Height = 233
    Align = alTop
    TabOrder = 0
  end
  object ButtonsPanel: TPanel
    Left = 0
    Top = 240
    Width = 562
    Height = 57
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      562
      57)
    object OkButton: TButton
      Left = 385
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight, akBottom]
      Caption = #1054#1082
      Default = True
      TabOrder = 0
      OnClick = OkButtonClick
    end
    object Button2: TButton
      Left = 473
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight, akBottom]
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 233
    Width = 562
    Height = 7
    Align = alClient
    Smooth = True
    TabOrder = 2
  end
end
