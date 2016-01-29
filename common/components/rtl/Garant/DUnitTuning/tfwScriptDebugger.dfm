object tfwScriptDebugger_Form: TtfwScriptDebugger_Form
  Left = 46
  Top = 165
  Width = 870
  Height = 640
  Caption = #1054#1090#1083#1072#1076#1095#1080#1082
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
  object edScript: TevMemo
    Left = 0
    Top = 41
    Width = 854
    Height = 309
    Align = alClient
    TabOrder = 0
    TabStop = True
  end
  object pnFooter: TvtSizeablePanel
    Left = 0
    Top = 350
    Width = 854
    Height = 252
    SizeableSides = [szTop]
    Align = alBottom
    TabOrder = 1
    object edOutput: TevMemo
      Left = 1
      Top = 4
      Width = 407
      Height = 247
      Align = alClient
      TabOrder = 0
      TabStop = True
    end
    object pnStack: TvtSizeablePanel
      Left = 408
      Top = 4
      Width = 445
      Height = 247
      SizeableSides = [szLeft]
      Align = alRight
      TabOrder = 1
      object lstStack: TvtLister
        Left = 4
        Top = 1
        Width = 440
        Height = 245
        IntegralHeight = False
        ProtectColor.BackColor = clRed
        ProtectColor.TextColor = clWhite
        SelectColor.BackColor = clHighlight
        SelectColor.TextColor = clHighlightText
        SelectNonFocusColor.BackColor = clBtnFace
        SelectNonFocusColor.TextColor = clBtnText
        OnGetStrItem = lstStackGetStrItem
        Align = alClient
        ParentColor = False
        TabOrder = 0
        TabStop = True
      end
    end
  end
  object pnHeader: TvtSizeablePanel
    Left = 0
    Top = 0
    Width = 854
    Height = 41
    SizeableSides = [szBottom]
    Align = alTop
    TabOrder = 2
    object btRun: TevButton
      Left = 7
      Top = 4
      Width = 64
      Height = 32
      DisplayMode = dmTextOnly
      Caption = 'Run'
      OnClick = btRunClick
    end
    object btClear: TevButton
      Left = 75
      Top = 4
      Width = 64
      Height = 32
      DisplayMode = dmTextOnly
      Caption = 'Clear'
      OnClick = btClearClick
    end
  end
  object tmStack: TTimer
    Interval = 500
    OnTimer = tmStackTimer
    Left = 432
    Top = 396
  end
end
