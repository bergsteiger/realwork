object TextEditorWin: TTextEditorWin
  Left = 0
  Top = 0
  Width = 627
  Height = 405
  TabOrder = 0
  object HRuler: TevRuler
    Left = 0
    Top = 0
    Width = 627
    Height = 30
    Align = alTop
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    PopupMenu = pmRuller
    TabOrder = 0
    CharWidth = 9320
    Units = ev_unCm
    SmallFont.Charset = DEFAULT_CHARSET
    SmallFont.Color = clWindowText
    SmallFont.Height = -5
    SmallFont.Name = 'Small Fonts'
    SmallFont.Style = []
  end
  object VRuler: TevRuler
    Left = 0
    Top = 30
    Width = 30
    Height = 355
    Align = alLeft
    BevelInner = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -9
    Font.Name = 'Small Fonts'
    TabOrder = 1
    Visible = False
    CharWidth = 8
    Units = ev_unCm
    Orientation = ev_orVertical
    SmallFont.Charset = DEFAULT_CHARSET
    SmallFont.Color = clWindowText
    SmallFont.Height = -5
    SmallFont.Name = 'Small Fonts'
    SmallFont.Style = []
  end
  object SubShowPanel: TevSubPanel
    Left = 30
    Top = 30
    Height = 355
    Align = alLeft
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    TabOrder = 2
  end
  object DocEditor: TevEditor
    Left = 35
    Top = 30
    Width = 592
    Height = 355
    Align = alClient
    LeftIndentDelta = 16
    VSubPanel = SubShowPanel
    ScrollStyle = ssVertical
    HRuler = HRuler
    VRuler = VRuler
    OnCursorChange = DocEditorCursorChange
    OnMakeTextSource = DocEditorMakeTextSource
    TabOrder = 3
    TabStop = True
    OnResize = DocEditorResize
  end
  object FooterPanel: TvtStatusBar
    Left = 0
    Top = 385
    Width = 627
    Height = 20
    Panels = <
      item
        Alignment = taCenter
        Width = 150
      end
      item
        Alignment = taCenter
        Width = 20
      end
      item
        Width = 50
      end>
    object PercentMeter: TW95Meter
      Left = 2
      Top = 3
      Width = 147
      Height = 16
      OnSetStr = PercentMeterSetStr
      EdgeStyle = st95None
      SegmentWidth = 4
      Percent = 33
      BorderStyle = bsNone
      HideInactive = True
    end
    object ScrollerPanel: TPanel
      Left = 403
      Top = 3
      Width = 159
      Height = 18
      TabOrder = 1
    end
  end
  object pmRuller: TPopupMenu
    OnPopup = pmRullerPopup
    Left = 438
    Top = 140
    object miInch: TMenuItem
      Caption = #1044#1102#1081#1084#1099
      GroupIndex = 1
      RadioItem = True
      OnClick = miUnitsClick
    end
    object miCm: TMenuItem
      Caption = #1057#1072#1085#1090#1080#1084#1077#1090#1088#1099
      Checked = True
      GroupIndex = 1
      RadioItem = True
      OnClick = miUnitsClick
    end
    object miChar: TMenuItem
      Caption = #1057#1080#1084#1074#1086#1083#1099
      GroupIndex = 1
      RadioItem = True
      OnClick = miUnitsClick
    end
  end
end
