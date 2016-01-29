object EditorWindow: TEditorWindow
  Left = 251
  Top = 248
  Width = 584
  Height = 382
  ActiveControl = Editor1
  Caption = 'EditorWindow'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010002002020100000000000E80200002600000020200200000000003001
    00000E0300002800000020000000400000000100040000000000000200000000
    000000000000000000000000000000000000000080000080000000C0C0008000
    0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000FFFFFFFFFFFFFFFF000090000000
    0000FFFFFFFFFFFFFFFF00099900000000F0FF000000F00000FF009990000000
    00F0FFFFFFFFFFFFFFFF0B0900000000F0F0FF000F0000F000F0BBB000000000
    F0F0FFFFFFFFFFFFFF0BBB0000000000F0F0FF00F0000F0000BBB00000000000
    F0F0FFFFFFFFFFFF0BBB000000000000F0F0FF000F0000F0BBB0000000000000
    F0F0FFFFFFFFFF0BBB0F000000000000F0F0FF00F00000BBB0FF000000000000
    F0F0FFFFFFFF0BBB0FFF000000000000F0F0FF000F00BBB000FF000000000000
    F0F0FFFFFF0BBB0FFFFF000000000000F0F0FF00F0BBB00000FF000000000000
    F0F0FFFFF80B0FFFFFFF000000000000F0F0FF0F8880F00F00FF000000000000
    F0F0FFFF88FFFFFFFFFF000000000000F0F0FFF8FF00F00000FF000000000000
    F0F0FFFFFFFFFFFFFFFF000000000000F0F0FFFFFFFFFFFFFFFF000000000000
    F0F00000000000000000000000000000F0FFFFFFFFFFFFFFFF00000000000000
    F0000000000000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFE000077FE00
    0063F8000041F8000003E0000007E000000FE000001FE000003FE000007FE000
    007FE000007FE000007FE000007FE000007FE000007FE000007FE000007FE000
    007FE000007FE000007FE000007FE000007FE000007FE00001FFE00001FFE000
    07FFE00007FFFFFFFFFFFFFFFFFF280000002000000040000000010001000000
    0000800000000000000000000000000000000000000000000000FFFFFF000000
    000000000000000000000000000000FFFF0000FFFF0002C0830002FFFF400AC4
    22E00AFFFDC00AC843800AFFF7000AC42E000AFFDD000AC83B000AFF77000AC4
    E3000AFDDF000AC883000AF87F000AD093000AF3FF000AEC83000AFFFF000AFF
    FF000A0000000BFFFC00080000000FFFF000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFE000077FE000063F8000041F8000003E0000007E000
    000FE000001FE000003FE000007FE000007FE000007FE000007FE000007FE000
    007FE000007FE000007FE000007FE000007FE000007FE000007FE000007FE000
    007FE000007FE00001FFE00001FFE00007FFE00007FFFFFFFFFFFFFFFFFF}
  OldCreateOrder = True
  Position = poDefault
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object pnWorkplace: TPanel
    Left = 0
    Top = 31
    Width = 568
    Height = 313
    Align = alClient
    TabOrder = 0
    object pnEditors: TPanel
      Left = 91
      Top = 1
      Width = 476
      Height = 311
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object pnEditor1: TPanel
        Left = 0
        Top = 74
        Width = 476
        Height = 215
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnEditor1'
        TabOrder = 2
        object Editor1: TevEditor
          Left = 30
          Top = 26
          Width = 446
          Height = 189
          Align = alClient
          VSubPanel = VSubPanel1
          ScrollStyle = ssVertical
          HRuler = HRuler1
          VRuler = VRuler1
          OnFontChange = Editor1FontChange
          OnStyleChange = Editor1StyleChange
          OnGetMonikerSink = Editor1GetMonikerSink
          OnReplaceConfirm = Editor1ReplaceConfirm
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 0
          TabStop = True
          OnEnter = Editor2Enter
        end
        object VRuler1: TevRuler
          Left = 8
          Top = 26
          Width = 22
          Height = 189
          Align = alLeft
          BevelInner = bvLowered
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Small Fonts'
          ParentCtl3D = False
          PopupMenu = pmUnits
          TabOrder = 1
          CharWidth = 8
          Units = ev_unCm
          Orientation = ev_orVertical
          SmallFont.Charset = DEFAULT_CHARSET
          SmallFont.Color = clBlack
          SmallFont.Height = -8
          SmallFont.Name = 'Small Fonts'
          SmallFont.Style = []
        end
        object VSubPanel1: TevSubPanel
          Left = 0
          Top = 26
          Height = 189
          Align = alLeft
          BevelInner = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Wingdings'
          TabOrder = 2
          OnResize = VSubPanel1Resize
          OnClickSub = VSubPanel2ClickSub
          OnMenuSub = VSubPanel1MenuSub
        end
        object splEditor1: TRxSplitter
          Left = 5
          Top = 26
          Width = 3
          Height = 189
          ControlFirst = VSubPanel1
          Align = alLeft
        end
        object HRuler1: TevRuler
          Left = 0
          Top = 0
          Width = 476
          Height = 26
          Align = alTop
          BevelInner = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Small Fonts'
          PopupMenu = pmUnits
          TabOrder = 4
          OnDblClick = HRuler1DblClick
          CharWidth = 11650
          Units = ev_unCm
          SmallFont.Charset = DEFAULT_CHARSET
          SmallFont.Color = clBlack
          SmallFont.Height = -7
          SmallFont.Name = 'Small Fonts'
          SmallFont.Style = []
        end
      end
      object pnEditor2: TPanel
        Left = 0
        Top = 0
        Width = 476
        Height = 71
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnEditor2'
        TabOrder = 1
        object Editor2: TevEditor
          Left = 30
          Top = 26
          Width = 446
          Height = 45
          Align = alClient
          VSubPanel = VSubPanel2
          ScrollStyle = ssVertical
          HRuler = HRuler2
          VRuler = VRuler2
          OnFontChange = Editor1FontChange
          OnStyleChange = Editor1StyleChange
          OnReplaceConfirm = Editor1ReplaceConfirm
          TabOrder = 0
          TabStop = True
          OnEnter = Editor2Enter
        end
        object VRuler2: TevRuler
          Left = 8
          Top = 26
          Width = 22
          Height = 45
          Align = alLeft
          BevelInner = bvLowered
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Small Fonts'
          ParentCtl3D = False
          PopupMenu = pmUnits
          TabOrder = 1
          CharWidth = 8
          Units = ev_unCm
          Orientation = ev_orVertical
          SmallFont.Charset = DEFAULT_CHARSET
          SmallFont.Color = clBlack
          SmallFont.Height = -8
          SmallFont.Name = 'Small Fonts'
          SmallFont.Style = []
        end
        object VSubPanel2: TevSubPanel
          Left = 0
          Top = 26
          Height = 45
          Align = alLeft
          BevelInner = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Wingdings'
          TabOrder = 2
          OnResize = VSubPanel2Resize
          OnClickSub = VSubPanel2ClickSub
          OnMenuSub = VSubPanel1MenuSub
        end
        object splEditor2: TRxSplitter
          Left = 5
          Top = 26
          Width = 3
          Height = 45
          ControlFirst = VSubPanel2
          Align = alLeft
        end
        object HRuler2: TevRuler
          Left = 0
          Top = 0
          Width = 476
          Height = 26
          Align = alTop
          BevelInner = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -9
          Font.Name = 'Small Fonts'
          PopupMenu = pmUnits
          TabOrder = 4
          OnDblClick = HRuler2DblClick
          CharWidth = 11650
          Units = ev_unCm
          SmallFont.Charset = DEFAULT_CHARSET
          SmallFont.Color = clBlack
          SmallFont.Height = -7
          SmallFont.Name = 'Small Fonts'
          SmallFont.Style = []
        end
      end
      object splEditors: TRxSplitter
        Left = 0
        Top = 71
        Width = 476
        Height = 3
        ControlFirst = pnEditor2
        ControlSecond = pnEditor1
        Align = alTop
        TopLeftLimit = 0
        BottomRightLimit = 0
        OnPosChanged = splEditorsPosChanged
      end
      object FooterPanel: TPanel
        Left = 0
        Top = 289
        Width = 476
        Height = 22
        Align = alBottom
        TabOrder = 0
        object pnMeter: TPanel
          Left = 1
          Top = 1
          Width = 159
          Height = 20
          Align = alLeft
          BevelOuter = bvLowered
          ParentColor = True
          TabOrder = 0
          object sbUndoContents: TSpeedButton
            Left = 136
            Top = -2
            Width = 22
            Height = 22
            Caption = 'U'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'MS Serif'
            Font.Style = []
            ParentFont = False
            OnClick = sbUndoContentsClick
          end
          object W95Meter: TvtW95Meter
            Left = 1
            Top = 1
            Width = 155
            Height = 17
            OnSetStr = W95MeterSetStr
            EdgeStyle = st95None
            HideInactive = True
          end
        end
        object pnModified: TPanel
          Left = 160
          Top = 1
          Width = 26
          Height = 20
          Align = alLeft
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -17
          Font.Name = 'System'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
        end
        object pnHScrollBar: TPanel
          Left = 340
          Top = 1
          Width = 135
          Height = 20
          Align = alRight
          BevelOuter = bvLowered
          TabOrder = 2
        end
        object pnStatus: TPanel
          Left = 186
          Top = 1
          Width = 119
          Height = 20
          Align = alClient
          Alignment = taLeftJustify
          BevelOuter = bvLowered
          TabOrder = 3
        end
        object pnPos: TPanel
          Left = 305
          Top = 1
          Width = 35
          Height = 20
          Align = alRight
          BevelOuter = bvLowered
          TabOrder = 4
        end
      end
    end
    object splExplorer: TRxSplitter
      Left = 88
      Top = 1
      Width = 3
      Height = 311
      ControlFirst = pnEditors
      ControlSecond = outExplorer
      Align = alLeft
    end
    object outExplorer: TvtOutliner
      Left = 1
      Top = 1
      Width = 87
      Height = 311
      AutoRowHeight = False
      IntegralHeight = False
      MultiStrokeItem = True
      ProtectColor.BackColor = clRed
      ProtectColor.TextColor = clWhite
      RowHeight = 20
      SelectColor.BackColor = clHighlight
      SelectColor.TextColor = clHighlightText
      SelectNonFocusColor.BackColor = clBtnFace
      SelectNonFocusColor.TextColor = clBtnText
      OnGetItemImage = outExplorerGetItemImage
      OnGetItemFont = outExplorerGetItemFont
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      ParentColor = False
      TabOrder = 2
      TabStop = True
      OnActionElement = outExplorerActionElement
    end
  end
  object pnToolbar: TPanel
    Left = 0
    Top = 0
    Width = 568
    Height = 31
    Align = alTop
    TabOrder = 1
    Visible = False
    object cbParts: TComboBox
      Left = 5
      Top = 5
      Width = 127
      Height = 22
      ItemHeight = 14
      TabOrder = 0
      Text = 'cbParts'
      OnChange = cbPartsChange
    end
  end
  object pmUnits: TPopupMenu
    OnPopup = pmUnitsPopup
    Left = 151
    Top = 72
    object miInch: TMenuItem
      Caption = #1044#1102#1081#1084#1099
      RadioItem = True
      OnClick = miUnitsClick
    end
    object miCm: TMenuItem
      Caption = #1057#1072#1085#1090#1080#1084#1077#1090#1088#1099
      Checked = True
      RadioItem = True
      OnClick = miUnitsClick
    end
    object miChar: TMenuItem
      Caption = #1057#1080#1084#1074#1086#1083#1099
      RadioItem = True
      OnClick = miUnitsClick
    end
    object miPixel: TMenuItem
      Caption = #1058#1086#1095#1082#1080
      RadioItem = True
      OnClick = miUnitsClick
    end
  end
end
