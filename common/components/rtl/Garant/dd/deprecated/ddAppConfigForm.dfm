object ddAppConfigForm: TddAppConfigForm
  Left = 350
  Top = 91
  BorderStyle = bsDialog
  Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103
  ClientHeight = 404
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 14
  object TreePanel: TPanel
    Left = 0
    Top = 0
    Width = 161
    Height = 350
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object ConfigTree: TTreeView
      Left = 8
      Top = 4
      Width = 150
      Height = 344
      BevelInner = bvSpace
      BevelOuter = bvSpace
      BevelKind = bkFlat
      BorderWidth = 1
      HideSelection = False
      Indent = 19
      ReadOnly = True
      TabOrder = 0
      OnChange = ConfigTreeChange
      OnChanging = ConfigTreeChanging
    end
  end
  object WorkPanel: TPanel
    Left = 161
    Top = 0
    Width = 399
    Height = 350
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 4
    TabOrder = 1
    object CaptionPanel: TPanel
      Left = 4
      Top = 4
      Width = 391
      Height = 41
      Align = alTop
      BevelWidth = 2
      Caption = 'CaptionPanel'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object ComponentsPanel: TPanel
      Left = 4
      Top = 45
      Width = 391
      Height = 301
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object ButtonsPanel: TPanel
    Left = 0
    Top = 350
    Width = 560
    Height = 54
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      560
      54)
    object Bevel1: TBevel
      Left = 8
      Top = 10
      Width = 543
      Height = 2
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
    end
    object HelpButton: TButton
      Left = 12
      Top = 20
      Width = 75
      Height = 25
      Caption = #1055#1086#1084#1086#1097#1100
      Enabled = False
      TabOrder = 0
    end
    object OkButton: TButton
      Left = 310
      Top = 20
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1050
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
    object CancelButton: TButton
      Left = 394
      Top = 20
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 2
    end
    object ApplyButton: TButton
      Left = 474
      Top = 20
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      Enabled = False
      TabOrder = 3
      OnClick = ApplyButtonClick
    end
  end
end
