object DictEntryWindow: TDictEntryWindow
  Left = 1859
  Top = 210
  Width = 614
  Height = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 16
  object nbkDocPages: TPageControl
    Left = 0
    Top = 0
    Width = 606
    Height = 499
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1040#1090#1088#1080#1073#1091#1090#1099
      inline MainAttrExplorer: TAttrExplorer
        Left = 0
        Top = 0
        Width = 598
        Height = 468
        Align = alClient
        TabOrder = 0
        inherited otlAttributes: TvtOutliner
          Width = 598
          Height = 449
          Font.Charset = DEFAULT_CHARSET
          ParentFont = True
        end
        inherited AttrFooter: TvtStatusBar
          Top = 449
          Width = 598
          Height = 19
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1058#1077#1082#1089#1090
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 182
        Width = 598
        Height = 286
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        inline DocTextEditor: TTextEditorWin
          Left = 0
          Top = 16
          Width = 598
          Height = 270
          Align = alClient
          TabOrder = 0
          inherited HRuler: TevRuler
            Width = 598
            Height = 24
            Font.Height = -8
            Visible = False
          end
          inherited VRuler: TevRuler
            Top = 24
            Width = 24
            Height = 227
            Font.Height = -8
          end
          inherited SubShowPanel: TevSubPanel
            Left = 24
            Top = 24
            Width = 19
            Height = 227
            Font.Height = -9
          end
          inherited DocEditor: TevEditor
            Left = 43
            Top = 24
            Width = 555
            Height = 227
            OnStyleChange = DocTextEditorDocEditorStyleChange
            OnJumpTo = DocTextEditorDocEditorJumpTo
            PopupMenu = HyperTextPopupMenu
            BorderStyle = bsSingle
          end
          inherited FooterPanel: TvtStatusBar
            Top = 251
            Width = 598
            Height = 19
            inherited PercentMeter: TW95Meter
              Left = 4
              Width = 119
              Height = 15
            end
          end
        end
        object vtGroupBoxEx1: TvtGroupBoxEx
          Left = 0
          Top = 0
          Width = 598
          Height = 16
          Align = alTop
          Caption = ' '#1058#1086#1083#1082#1086#1074#1072#1085#1080#1077' '
          TabOrder = 1
          ShapeType = stLine
        end
      end
      object GroupBox1: TvtGroupBoxEx
        Left = 0
        Top = 0
        Width = 598
        Height = 182
        Align = alTop
        Caption = ' '#1058#1077#1088#1084#1080#1085' '
        TabOrder = 0
        ShapeType = stLine
        DesignSize = (
          598
          182)
        object Label1: TLabel
          Left = 45
          Top = 21
          Width = 50
          Height = 16
          Caption = #1056#1091#1089#1089#1082#1080#1081
          FocusControl = edtShortName1
        end
        object Label2: TLabel
          Left = 22
          Top = 47
          Width = 69
          Height = 16
          Caption = #1040#1085#1075#1083#1080#1081#1089#1082#1080#1081
          FocusControl = edtShortName2
        end
        object Label3: TLabel
          Left = 10
          Top = 74
          Width = 79
          Height = 16
          Caption = #1060#1088#1072#1085#1094#1091#1079#1089#1082#1080#1081
          FocusControl = edtShortName3
        end
        object Label4: TLabel
          Left = 33
          Top = 103
          Width = 59
          Height = 16
          Caption = #1053#1077#1084#1077#1094#1082#1080#1081
          FocusControl = edtShortName4
        end
        object Label5: TLabel
          Left = 14
          Top = 130
          Width = 76
          Height = 16
          Caption = #1048#1090#1072#1083#1100#1103#1085#1089#1082#1080#1081
          FocusControl = edtShortName5
        end
        object Label6: TLabel
          Left = 28
          Top = 157
          Width = 64
          Height = 16
          Caption = #1048#1089#1087#1072#1085#1089#1082#1080#1081
          FocusControl = edtShortName6
        end
        object edtShortName2: TevEdit
          Left = 107
          Top = 43
          Width = 486
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          LMargin = 1
          Font.Charset = DEFAULT_CHARSET
          PopupMenu = ClipbrdPopUpMenu
          TabOrder = 1
          TabStop = True
          BorderStyle = bsSingle
        end
        object edtShortName3: TevEdit
          Left = 107
          Top = 70
          Width = 486
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          LMargin = 1
          Font.Charset = DEFAULT_CHARSET
          PopupMenu = ClipbrdPopUpMenu
          TabOrder = 2
          TabStop = True
          BorderStyle = bsSingle
        end
        object edtShortName1: TevEdit
          Left = 107
          Top = 16
          Width = 486
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          LMargin = 1
          Font.Charset = DEFAULT_CHARSET
          PopupMenu = ClipbrdPopUpMenu
          TabOrder = 0
          TabStop = True
          BorderStyle = bsSingle
        end
        object edtShortName4: TevEdit
          Left = 107
          Top = 98
          Width = 486
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          LMargin = 1
          Font.Charset = DEFAULT_CHARSET
          PopupMenu = ClipbrdPopUpMenu
          TabOrder = 3
          TabStop = True
          BorderStyle = bsSingle
        end
        object edtShortName5: TevEdit
          Left = 107
          Top = 125
          Width = 486
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          LMargin = 1
          Font.Charset = DEFAULT_CHARSET
          PopupMenu = ClipbrdPopUpMenu
          TabOrder = 4
          TabStop = True
          BorderStyle = bsSingle
        end
        object edtShortName6: TevEdit
          Left = 107
          Top = 153
          Width = 486
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          LMargin = 1
          Font.Charset = DEFAULT_CHARSET
          PopupMenu = ClipbrdPopUpMenu
          TabOrder = 5
          TabStop = True
          BorderStyle = bsSingle
        end
      end
    end
  end
  object ClipbrdPopUpMenu: TLinkPopUpMenu
    Active = False
    Left = 352
    Top = 330
    object piCut: TMenuItem
      Action = MainForm.acCut
    end
    object piCopy: TMenuItem
      Action = MainForm.acCopy
    end
    object piPaste: TMenuItem
      Action = MainForm.acPaste
    end
    object piAddToClipboard: TevMenuItem
      Action = MainForm.acAdd2Clipbrd
      Operation = ev_ccAdd
    end
    object N4: TMenuItem
      Caption = '-'
    end
  end
  object MainMenu: TMainMenu
    Left = 305
    Top = 65535
    object miText: TMenuItem
      Action = MainForm.acCut
      GroupIndex = 5
      object miSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        ShortCut = 113
        OnClick = miSaveClick
      end
      object miSaveAs: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082' ...'
        OnClick = miSaveAsClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miSelectAll: TMenuItem
        Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
        ShortCut = 16449
        OnClick = miSelectAllClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miUndo: TMenuItem
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100
        Enabled = False
        ShortCut = 16474
      end
      object miRedo: TMenuItem
        Caption = #1042#1077#1088#1085#1091#1090#1100
        Enabled = False
        ShortCut = 24666
      end
      object miSplitLine: TMenuItem
        Caption = '-'
      end
      object miCut: TMenuItem
        Caption = #1042#1099#1088#1077#1079#1072#1090#1100
        ShortCut = 16472
      end
      object miCopy: TMenuItem
        Action = MainForm.acCopy
      end
      object miPaste: TMenuItem
        Action = MainForm.acPaste
      end
      object miAddToClipboard: TMenuItem
        Action = MainForm.acAdd2Clipbrd
      end
      object miPasteFromFile: TMenuItem
        Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072' ...'
        Enabled = False
        Visible = False
      end
      object miPasteSpecial: TMenuItem
        Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1072#1103' '#1074#1089#1090#1072#1074#1082#1072' ...'
        Enabled = False
        Visible = False
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object miStyle: TMenuItem
        Caption = #1057#1090#1080#1083#1100
        Enabled = False
        Visible = False
        object miUserColorSegment: TMenuItem
          Tag = 1
          Caption = #1062#1074#1077#1090#1086#1074#1086#1077' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
          ShortCut = 32817
        end
        object miUserMonoWidth: TMenuItem
          Tag = 2
          Caption = #1052#1086#1085#1086#1096#1080#1088#1080#1085#1085#1099#1081
          ShortCut = 32818
        end
        object miUserStyle: TMenuItem
          Tag = 3
          Caption = #1053#1086#1088#1084#1072#1083#1100#1085#1099#1081
          ShortCut = 32819
        end
        object miUserStyle2: TMenuItem
          Tag = 4
          Caption = #1053#1086#1088#1084#1072#1083#1100#1085#1099#1081' (OEM)'
          ShortCut = 32820
        end
        object miUserStyle3: TMenuItem
          Tag = 5
          Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082' 1'
          ShortCut = 32821
        end
        object miUserStyle4: TMenuItem
          Tag = 6
          Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082' '#1089#1090#1072#1090#1100#1080
          ShortCut = 32822
        end
        object miUserStyle5: TMenuItem
          Tag = 7
          Caption = #1059#1090#1088#1072#1090#1080#1083' '#1089#1080#1083#1091
          ShortCut = 32823
        end
        object miUserStyle6: TMenuItem
          Tag = 8
          Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
          ShortCut = 32824
        end
        object miUserStyle7: TMenuItem
          Tag = 9
          Caption = #1055#1088#1086#1076#1086#1083#1078#1077#1085#1080#1077' '#1089#1089#1099#1083#1082#1080
          ShortCut = 32825
        end
        object miUserStyle8: TMenuItem
          Caption = #1055#1088#1080#1078#1072#1090#1099#1081' '#1074#1083#1077#1074#1086
          ShortCut = 32816
        end
        object miUserStyle9: TMenuItem
          Tag = 10
          Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1074#1077#1088#1089#1080#1080
          ShortCut = 32854
        end
        object miUserStyle10: TMenuItem
          Tag = 11
          Caption = #1053#1077' '#1074#1089#1090#1091#1087#1080#1083' '#1074' '#1089#1080#1083#1091
          ShortCut = 32838
        end
      end
      object miSplitLine2: TMenuItem
        Caption = '-'
      end
      object miJustLeft: TMenuItem
        Action = MainForm.acJustifyLeft
        AutoCheck = True
      end
      object miJustCenter: TMenuItem
        Action = MainForm.acJustifyCenter
        AutoCheck = True
      end
      object miJustRight: TMenuItem
        Action = MainForm.acJustifyRight
        AutoCheck = True
      end
      object miJustWide: TMenuItem
        Action = MainForm.acJustifyWidth
        AutoCheck = True
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object miSetTextInvisible: TMenuItem
        Caption = #1055#1086#1084#1077#1090#1080#1090#1100' '#1082#1072#1082' '#1085#1077#1087#1077#1095#1072#1090#1072#1077#1084#1099#1081
        Enabled = False
        Visible = False
      end
      object miSetTextVisible: TMenuItem
        Caption = #1055#1086#1084#1077#1090#1080#1090#1100' '#1082#1072#1082' '#1087#1077#1095#1072#1090#1072#1077#1084#1099#1081
        Enabled = False
        Visible = False
      end
    end
    object miHyperText: TMenuItem
      Caption = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      GroupIndex = 5
      object mi_SetSub: TMenuItem
        Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1084#1077#1090#1082#1091
        Enabled = False
        ShortCut = 121
        Visible = False
      end
      object mi_RemoveSub: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1084#1077#1090#1082#1091
        Enabled = False
        ShortCut = 32889
        Visible = False
      end
      object N11: TMenuItem
        Enabled = False
        Visible = False
      end
      object N12: TMenuItem
        Caption = '-'
        Visible = False
      end
      object miSetReference: TMenuItem
        Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1089#1099#1083#1082#1091
        ShortCut = 122
        OnClick = miSetReferenceClick
      end
      object miSetReferenceDirect: TMenuItem
        Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1089#1099#1083#1082#1091' "'#1074#1088#1091#1095#1085#1091#1102'"'
        Enabled = False
        ShortCut = 32886
        Visible = False
      end
      object mi_RemoveReference: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1089#1099#1083#1082#1091
        ShortCut = 32814
        OnClick = mi_RemoveReferenceClick
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object miGoByRef: TMenuItem
        Caption = #1055#1077#1088#1077#1081#1090#1080' '#1087#1086' '#1089#1089#1099#1083#1082#1077
        ShortCut = 32781
        OnClick = miGoByRefClick
      end
      object N14: TMenuItem
        Caption = '-'
        Visible = False
      end
      object N15: TMenuItem
        Enabled = False
        Visible = False
      end
      object N16: TMenuItem
        Enabled = False
        Visible = False
      end
    end
    object miSearch: TMenuItem
      Caption = #1055#1086#1080#1089#1082
      GroupIndex = 5
      object miFind: TMenuItem
        Caption = #1053#1072#1081#1090#1080
        ShortCut = 16454
        OnClick = miFindClick
      end
      object miReplace: TMenuItem
        Caption = #1047#1072#1084#1077#1085#1080#1090#1100
        ShortCut = 16466
        OnClick = miReplaceClick
      end
      object miSrchAgain: TMenuItem
        Caption = #1055#1086#1074#1090#1086#1088#1080#1090#1100' '#1087#1086#1080#1089#1082
        ShortCut = 16460
        OnClick = miSrchAgainClick
      end
      object miFindDictEntryBySelect: TMenuItem
        Caption = #1055#1086#1080#1089#1082' '#1090#1086#1083#1082#1086#1074#1072#1085#1080#1103
        ShortCut = 49220
        OnClick = piFindDictEntryBySelectClick
      end
      object miSplit: TMenuItem
        Caption = '-'
      end
      object miGotoNextOccur: TMenuItem
        Action = MainForm.acGotoNextOccur
      end
    end
  end
  object HyperTextPopupMenu: TLinkPopUpMenu
    PrimaryPopUpMenu = ClipbrdPopUpMenu
    Active = False
    Left = 312
    Top = 330
    object pmSetReference: TMenuItem
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1089#1099#1083#1082#1091
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      ImageIndex = 24
      ShortCut = 122
      OnClick = miSetReferenceClick
    end
    object pmRemoveReference: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1089#1099#1083#1082#1091
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      ImageIndex = 25
      ShortCut = 32814
      OnClick = mi_RemoveReferenceClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object piFindDictEntryBySelect: TMenuItem
      Caption = #1055#1086#1080#1089#1082' '#1090#1086#1082#1086#1074#1072#1085#1080#1103
      ShortCut = 49220
      OnClick = piFindDictEntryBySelectClick
    end
    object N7: TMenuItem
      Caption = '-'
    end
  end
end
