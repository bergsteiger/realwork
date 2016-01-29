inherited MainEditorForm: TMainEditorForm
  Left = 330
  OldCreateOrder = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object tsDocuments: TTabSet [0]
    Left = 0
    Top = 426
    Width = 680
    Height = 16
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    TabHeight = 19
    Visible = False
    OnChange = tsDocumentsChange
  end
  inherited OpenDialog: TOpenDialog
    Filter = 
      #1044#1086#1082#1091#1084#1077#1085#1090#1099' '#1069#1074#1077#1088#1077#1089#1090' (*.evd;*.evr)|*.evr;*.evd|'#1058#1072#1073#1083#1080#1094#1099' '#1089#1090#1080#1083#1077#1081' '#1069#1074#1077#1088#1077 +
      #1089#1090' (*.evs)|*.evs|'#1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' c '#1092#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1085#1080#1077#1084' (*.txt)|*.txt' +
      '|'#1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' AS IS (*.txt)|*.txt|'#1048#1089#1093#1086#1076#1085#1080#1082#1080' '#1043#1072#1088#1072#1085#1090#1072' (*.nsr)|*' +
      '.nsr|'#1044#1086#1082#1091#1084#1077#1085#1090#1099' RTF (*.rtf)|*.rtf|'#1044#1086#1082#1091#1084#1077#1085#1090#1099' RTF ('#1073#1077#1079' '#1086#1092#1086#1088#1084#1083#1077#1085#1080#1103') ' +
      '(*.rtf)|*.rtf|'#1044#1086#1082#1091#1084#1077#1085#1090#1099' MS Word (*.doc, *.docx)|*.doc,*.docx|HTM' +
      'L-'#1089#1090#1088#1072#1085#1080#1094#1099' (*.htm;*.html)|*.htm;*.html|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
  end
  object OvcController1: TOvcController
    EntryCommands.TableList = (
      'Default'
      True
      (
        1037
        0)
      'WordStar'
      True
      ()
      'Grid'
      False
      ()
      'List'
      True
      ())
    Left = 360
    Top = 137
  end
  object EverestWriter: TevdNativeWriter
    Filer = DOSFiler
    Left = 467
    Top = 361
  end
  object EverestReader: TevEvdReader
    Filer = DOSFiler
    Left = 462
    Top = 313
  end
  object Everest: TDdeServerConv
    OnExecuteMacro = EverestExecuteMacro
    Left = 553
    Top = 139
  end
  object DOSFiler: Tl3DOSFiler
    TimeOut = 0
    Left = 358
    Top = 256
  end
  object PrintDialog: TPrintDialog
    Left = 529
    Top = 197
  end
  object theActions: TActionList
    Images = dmStandardRes.ilOffice
    Left = 24
    Top = 384
    object acInsertFile: TAction
      Category = #1042#1089#1090#1072#1074#1082#1072
      Caption = #1060#1072#1081#1083'...'
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1092#1072#1081#1083
      ImageIndex = 233
      ShortCut = 32850
      OnExecute = acInsertFileExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acANSIDOS: TAction
      Tag = 2
      Category = #1060#1086#1088#1084#1072#1090
      Caption = #1052#1086#1085#1086#1096#1080#1088#1080#1085#1085#1099#1081
      ImageIndex = 240
      ShortCut = 32818
      OnExecute = acColorSelectionExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acNormal: TAction
      Tag = 3
      Category = #1060#1086#1088#1084#1072#1090
      Caption = #1053#1086#1088#1084#1072#1083#1100#1085#1099#1081
      ImageIndex = 240
      ShortCut = 32819
      OnExecute = acColorSelectionExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acNormalOEM: TAction
      Tag = 4
      Category = #1060#1086#1088#1084#1072#1090
      Caption = #1053#1086#1088#1084#1072#1083#1100#1085#1099#1081' (OEM)'
      ImageIndex = 240
      ShortCut = 32820
      OnExecute = acColorSelectionExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acHeading1: TAction
      Tag = 5
      Category = #1060#1086#1088#1084#1072#1090
      Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082' 1'
      ImageIndex = 240
      ShortCut = 32821
      OnExecute = acColorSelectionExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acAppHeader: TAction
      Category = #1060#1086#1088#1084#1072#1090
      Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
      ImageIndex = 239
      ShortCut = 32833
      OnExecute = acEditStylesExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acArticleHeading: TAction
      Tag = 6
      Category = #1060#1086#1088#1084#1072#1090
      Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082' '#1089#1090#1072#1090#1100#1080
      ImageIndex = 240
      ShortCut = 32822
      OnExecute = acColorSelectionExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acOutOfDate: TAction
      Tag = 7
      Category = #1060#1086#1088#1084#1072#1090
      Caption = #1059#1090#1088#1072#1090#1080#1083' '#1089#1080#1083#1091
      ImageIndex = 239
      ShortCut = 32823
      OnExecute = acColorSelectionExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acComment: TAction
      Tag = 8
      Category = #1060#1086#1088#1084#1072#1090
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
      ImageIndex = 240
      ShortCut = 32824
      OnExecute = acColorSelectionExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acNotInPower: TAction
      Category = #1060#1086#1088#1084#1072#1090
      Caption = #1053#1077' '#1074#1089#1090#1091#1087#1080#1083' '#1074' '#1089#1080#1083#1091
      ImageIndex = 240
      ShortCut = 32838
      OnExecute = acColorSelectionExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acHyperlinkCont: TAction
      Tag = 9
      Category = #1060#1086#1088#1084#1072#1090
      Caption = #1055#1088#1086#1076#1086#1083#1078#1077#1085#1080#1077' '#1089#1089#1099#1083#1082#1080
      ImageIndex = 239
      ShortCut = 32825
      OnExecute = acColorSelectionExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acVersInfo: TAction
      Tag = 10
      Category = #1060#1086#1088#1084#1072#1090
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1074#1077#1088#1089#1080#1080
      ImageIndex = 239
      ShortCut = 32854
      OnExecute = acColorSelectionExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acLeft: TAction
      Category = #1060#1086#1088#1084#1072#1090
      Caption = #1055#1088#1080#1078#1072#1090#1099#1081' '#1074#1083#1077#1074#1086
      ImageIndex = 240
      ShortCut = 32816
      OnExecute = acColorSelectionExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acInsertPicture: TAction
      Category = #1042#1089#1090#1072#1074#1082#1072
      Caption = #1056#1080#1089#1091#1085#1086#1082'...'
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1088#1080#1089#1091#1085#1086#1082
      ImageIndex = 83
      OnExecute = acInsertPictureExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acSubProperties: TAction
      Category = #1052#1077#1090#1082#1072
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072'...'
      Hint = #1057#1074#1086#1081#1089#1090#1074#1072' '#1084#1077#1090#1082#1080
      ImageIndex = 231
      OnExecute = acSubPropertiesExecute
      OnUpdate = acSubPropertiesUpdate
    end
    object acSubDelete: TAction
      Category = #1052#1077#1090#1082#1072
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1084#1077#1090#1082#1091
      ImageIndex = 206
      OnExecute = acSubDeleteExecute
      OnUpdate = CurrentTargetActionUpdate
    end
    object acDocumentPartMerge: TAction
      Category = #1052#1077#1090#1082#1072
      Caption = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100
      Hint = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1089#1086' '#1089#1083#1077#1076#1091#1102#1097#1080#1084
      OnExecute = acDocumentPartMergeExecute
      OnUpdate = DocumentPartActionUpdate
    end
    object acCellMerge: TAction
      Category = #1071#1095#1077#1081#1082#1072
      Caption = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100
      Hint = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1089' '#1089#1086#1089#1077#1076#1085#1077#1081' '#1103#1095#1077#1081#1082#1086#1081
      ImageIndex = 184
      OnExecute = acCellMergeExecute
      OnUpdate = CurrentTargetActionUpdate
    end
    object acCellDelete: TAction
      Category = #1071#1095#1077#1081#1082#1072
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1103#1095#1077#1081#1082#1091
      ImageIndex = 206
      OnExecute = acCellDeleteExecute
      OnUpdate = CurrentTargetActionUpdate
    end
    object acHyperlinkProperties: TAction
      Category = #1057#1089#1099#1083#1082#1072
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072'...'
      Hint = #1057#1074#1086#1081#1089#1090#1074#1072' '#1089#1089#1099#1083#1082#1080
      ImageIndex = 231
      OnExecute = acHyperlinkPropertiesExecute
      OnUpdate = CurrentTargetActionUpdate
    end
    object acHyperlinkFollow: TAction
      Category = #1057#1089#1099#1083#1082#1072
      Caption = #1055#1077#1088#1077#1081#1090#1080
      Hint = #1055#1077#1088#1077#1081#1090#1080' '#1087#1086' '#1089#1089#1099#1083#1082#1077
      ImageIndex = 224
      OnExecute = acHyperlinkFollowExecute
      OnUpdate = CurrentTargetActionUpdate
    end
    object acHyperlinkDelete: TAction
      Category = #1057#1089#1099#1083#1082#1072
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1089#1089#1099#1083#1082#1091
      ImageIndex = 206
      OnExecute = acHyperlinkDeleteExecute
      OnUpdate = CurrentTargetActionUpdate
    end
    object acSectionPortrait: TAction
      Category = #1056#1072#1079#1076#1077#1083
      AutoCheck = True
      Caption = #1050#1085#1080#1078#1085#1072#1103
      Checked = True
      GroupIndex = 1
      Hint = #1050#1085#1080#1078#1085#1072#1103' '#1086#1088#1080#1077#1085#1090#1072#1094#1080#1103
      ImageIndex = 211
      OnExecute = acSectionPortraitExecute
      OnUpdate = SectionActionUpdate
    end
    object acSectionLandscape: TAction
      Category = #1056#1072#1079#1076#1077#1083
      AutoCheck = True
      Caption = #1040#1083#1100#1073#1086#1084#1085#1072#1103
      GroupIndex = 1
      Hint = #1040#1083#1100#1073#1086#1084#1085#1072#1103' '#1086#1088#1080#1077#1085#1090#1072#1094#1080#1103
      ImageIndex = 210
      OnExecute = acSectionLandscapeExecute
      OnUpdate = SectionActionUpdate
    end
    object acSectionA4Size: TAction
      Category = #1056#1072#1079#1076#1077#1083
      AutoCheck = True
      Caption = #1040'4'
      Checked = True
      GroupIndex = 2
      Hint = #1060#1086#1088#1084#1072#1090' '#1040'4'
      OnExecute = acSectionA4SizeExecute
      OnUpdate = SectionActionUpdate
    end
    object acSectionA3Size: TAction
      Category = #1056#1072#1079#1076#1077#1083
      AutoCheck = True
      Caption = #1040'3'
      GroupIndex = 2
      Hint = #1060#1086#1088#1084#1072#1090' '#1040'3'
      OnExecute = acSectionA3SizeExecute
      OnUpdate = SectionActionUpdate
    end
    object acGotoSub: TAction
      Category = #1052#1077#1090#1082#1072
      Caption = #1055#1077#1088#1077#1081#1090#1080
      Hint = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1084#1077#1090#1082#1077
      ImageIndex = 224
      OnExecute = acGotoSubExecute
      OnUpdate = CurrentTargetActionUpdate
    end
    object acBuildDocumentStructure: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1056#1072#1079#1073#1080#1090#1100' '#1085#1072' '#1073#1083#1086#1082#1080
      Hint = #1056#1072#1079#1073#1080#1090#1100' '#1085#1072' '#1073#1083#1086#1082#1080
      OnExecute = acBuildDocumentStructureExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acSendDocument: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100'...'
      Hint = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1086' '#1087#1086#1095#1090#1077
      ImageIndex = 14
      OnExecute = acSendDocumentExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acEditStyles: TAction
      Category = #1060#1086#1088#1084#1072#1090
      Caption = #1057#1090#1080#1083#1080'...'
      Hint = #1056#1077#1076#1072#1082#1090#1086#1088' '#1090#1072#1073#1083#1080#1094#1099' '#1089#1090#1080#1083#1077#1081
      ImageIndex = 238
      OnExecute = acEditStylesExecute
    end
    object acColorSelection: TAction
      Tag = 1
      Category = #1060#1086#1088#1084#1072#1090
      Caption = #1062#1074#1077#1090#1086#1074#1086#1077' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
      ImageIndex = 239
      ShortCut = 32817
      OnExecute = acColorSelectionExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acAdjustMargin: TAction
      Category = #1042#1080#1076
      AutoCheck = True
      Caption = 'M'
      Hint = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1090#1100' '#1087#1086' '#1083#1077#1074#1086#1084#1091' '#1087#1086#1083#1102' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      OnExecute = acAdjustMarginExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acInsertBlock: TAction
      Category = #1042#1089#1090#1072#1074#1082#1072
      Caption = #1041#1083#1086#1082
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1073#1083#1086#1082
      ImageIndex = 236
      ShortCut = 49218
      OnExecute = acInsertBlockExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acConvertTextToTable: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1058#1077#1082#1089#1090' '#1074' '#1090#1072#1073#1083#1080#1094#1091'...'
      Hint = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1090#1077#1082#1089#1090' '#1074' '#1090#1072#1073#1083#1080#1094#1091
      ShortCut = 32851
      OnExecute = acConvertTextToTableExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acLo2Up: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1042#1077#1088#1093#1085#1080#1081' '#1088#1077#1075#1080#1089#1090#1088
      ImageIndex = 104
      ShortCut = 24661
      OnExecute = acLo2UpExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acUp2Lo: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1053#1080#1078#1085#1080#1081' '#1088#1077#1075#1080#1089#1090#1088
      ImageIndex = 105
      ShortCut = 24652
      OnExecute = acUp2LoExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acSwapLoUp: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1048#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1088#1077#1075#1080#1089#1090#1088
      ImageIndex = 108
      OnExecute = acSwapLoUpExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acText2Para: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1074' '#1087#1072#1088#1072#1075#1088#1072#1092
      Hint = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1090#1077#1082#1089#1090' '#1074' '#1087#1072#1088#1072#1075#1088#1072#1092
      ShortCut = 32847
      OnExecute = acText2ParaExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acBuildContents: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1086#1075#1083#1072#1074#1083#1077#1085#1080#1077
      Hint = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1086#1075#1083#1072#1074#1083#1077#1085#1080#1077
      OnExecute = acBuildContentsExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acMDIChildList: TAction
      Category = #1054#1082#1085#1072
      Caption = #1057#1087#1080#1089#1086#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      Hint = #1057#1087#1080#1089#1086#1082' '#1086#1090#1082#1088#1099#1090#1099#1093' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      ImageIndex = 214
      ShortCut = 32880
      SecondaryShortCuts.Strings = (
        'Ctrl+Alt+0')
      OnExecute = acMDIChildListExecute
      OnUpdate = acMDIChildListUpdate
    end
    object acDeleteAllDocumentParts: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077' '#1073#1083#1086#1082#1080
      OnExecute = acDeleteAllDocumentPartsExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acBullet: TevAction
      Operation = ev_ccBullet
      ImageIndex = 122
    end
    object acNumber: TevAction
      Operation = ev_ccNumber
      ImageIndex = 121
    end
    object acDecIndent: TevAction
      Operation = ev_ccDecIndent
      ImageIndex = 119
    end
    object acIncIndent: TevAction
      Operation = ev_ccIncIndent
      ImageIndex = 120
    end
    object acSectionA2Size: TAction
      Category = #1056#1072#1079#1076#1077#1083
      Caption = 'A2'
      GroupIndex = 2
      Hint = #1060#1086#1088#1084#1072#1090' '#1040'2'
      OnExecute = acSectionA2SizeExecute
      OnUpdate = SectionActionUpdate
    end
    object acSectionA1Size: TAction
      Category = #1056#1072#1079#1076#1077#1083
      Caption = 'A1'
      GroupIndex = 2
      Hint = #1060#1086#1088#1084#1072#1090' '#1040'1'
      OnExecute = acSectionA1SizeExecute
      OnUpdate = SectionActionUpdate
    end
    object acHideHyperlinks: TAction
      Category = #1060#1086#1088#1084#1072#1090
      AutoCheck = True
      Caption = #1042#1099#1082#1083#1102#1095#1080#1090#1100' '#1075#1080#1087#1077#1088#1089#1089#1099#1083#1082#1080
      GroupIndex = 16
      Hint = #1042#1099#1082#1083#1102#1095#1080#1090#1100' '#1075#1080#1087#1077#1088#1089#1089#1099#1083#1082#1080
      ImageIndex = 82
      OnExecute = acHideHyperlinksExecute
      OnUpdate = acHideHyperlinksUpdate
    end
    object acAutoCompleteSetup: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1072#1074#1090#1086#1079#1072#1084#1077#1085#1099'...'
      ShortCut = 49242
      OnExecute = acAutoCompleteSetupExecute
    end
    object acAutoComplete: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1040#1074#1090#1086#1079#1072#1084#1077#1085#1072
      ShortCut = 32807
      OnExecute = acAutoCompleteExecute
    end
    object acToolsCnvRusCharset: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1056#1091#1089#1089#1082#1072#1103' '#1088#1072#1089#1082#1083#1072#1076#1082#1072
      OnExecute = acToolsCnvRusCharsetExecute
    end
    object acToolsCnvEngCharset: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1040#1085#1075#1083#1080#1081#1089#1082#1072#1103' '#1088#1072#1089#1082#1083#1072#1076#1082#1072
      OnExecute = acToolsCnvEngCharsetExecute
    end
    object acToolsCnvOEM2ANSI: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = 'OEM '#1074' ANSI'
      OnExecute = acToolsCnvOEM2ANSIExecute
    end
    object acToolsCnvANSI2OEM: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = 'ANSI '#1074' OEM'
      OnExecute = acToolsCnvANSI2OEMExecute
    end
    object acToolsCnvDate2Text: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1044#1072#1090#1072' '#1074' '#1090#1077#1082#1089#1090
      ShortCut = 24644
      OnExecute = acToolsCnvDate2TextExecute
    end
    object acToolsCnvMergePara: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1072#1073#1079#1072#1094#1099
      ShortCut = 24655
      OnExecute = acToolsCnvMergeParaExecute
    end
    object acInsertFormula: TAction
      Category = #1042#1089#1090#1072#1074#1082#1072
      Caption = #1060#1086#1088#1084#1091#1083#1072'...'
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1092#1086#1088#1084#1091#1083#1091
      ImageIndex = 90
      ShortCut = 24646
      OnExecute = acInsertFormulaExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acPrintPreview: TAction
      Category = #1055#1077#1095#1072#1090#1100
      Caption = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1087#1088#1086#1089#1084#1086#1090#1088'...'
      OnExecute = acPrintPreviewExecute
      OnUpdate = acActiveEditorUpdate
    end
    object acAlignCellsBoundary: TAction
      Category = #1058#1072#1073#1083#1080#1094#1072
      Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077' '#1075#1088#1072#1085#1080#1094' '#1103#1095#1077#1077#1082
      ShortCut = 16471
      OnExecute = acAlignCellsBoundaryExecute
    end
    object acAjustColumnWidth: TAction
      Category = #1058#1072#1073#1083#1080#1094#1072
      Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077' '#1096#1080#1088#1080#1085#1099' '#1082#1086#1083#1086#1085#1086#1082' '#1089' '#1095#1080#1089#1083#1072#1084#1080
      OnExecute = acAjustColumnWidthExecute
    end
    object acSetCellWidth: TAction
      Category = #1058#1072#1073#1083#1080#1094#1072
      Caption = #1047#1072#1076#1072#1090#1100' '#1096#1080#1088#1080#1085#1091' '#1103#1095#1077#1077#1082
      OnExecute = acSetCellWidthExecute
    end
    object acBordersAndShade: TevAction
      Operation = ev_ccBordersAndShade
      ImageIndex = 237
    end
    object acAlignWithSeparator: TevAction
      Operation = ev_ccAlignWithSeparator
      ImageIndex = 249
    end
    object acHelpAbout: TAction
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
      OnExecute = acHelpAboutExecute
    end
    object acDocInfo: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1077
      ShortCut = 32841
      OnExecute = acDocInfoExecute
    end
    object acJump2Sub: TAction
      Category = #1057#1089#1099#1083#1082#1072
      Caption = #1055#1077#1088#1077#1093#1086#1076' '#1085#1072' '#1084#1077#1090#1082#1091
      ShortCut = 49226
      OnExecute = acJump2SubExecute
    end
    object acTblSetFrame: TAction
      Category = #1058#1072#1073#1083#1080#1094#1072
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1088#1072#1084#1082#1080
      ShortCut = 32851
      OnExecute = acTblSetFrameExecute
    end
    object acTblDelFrame: TAction
      Category = #1058#1072#1073#1083#1080#1094#1072
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1088#1072#1084#1082#1080
      ShortCut = 32836
      OnExecute = acTblDelFrameExecute
    end
    object acFindTable: TAction
      Category = 'Everest'
      Caption = #1053#1072#1081#1090#1080' '#1090#1072#1073#1083#1080#1094#1091
      ShortCut = 32852
      OnExecute = acFindTableExecute
    end
    object acCopyWidths: TAction
      Category = #1058#1072#1073#1083#1080#1094#1072
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100' '#1096#1080#1088#1080#1085#1091' '#1103#1095#1077#1077#1082
      ShortCut = 16461
      OnExecute = acCopyWidthsExecute
    end
    object acApplyWidth: TAction
      Category = #1058#1072#1073#1083#1080#1094#1072
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1096#1080#1088#1080#1085#1091' '#1103#1095#1077#1077#1082
      ShortCut = 16463
      OnExecute = acApplyWidthExecute
      OnUpdate = acApplyWidthUpdate
    end
    object acAAC: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1055#1086#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1103' '#1040#1040#1057
      OnExecute = acAACExecute
      OnUpdate = acAACUpdate
    end
    object acSetTextNonPrintable: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1055#1086#1084#1077#1090#1080#1090#1100' '#1082#1072#1082' '#1085#1077#1087#1077#1095#1072#1090#1072#1077#1084#1099#1081
      OnExecute = acSetTextNonPrintableExecute
    end
    object acSetTextPrintable: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1055#1086#1084#1077#1090#1080#1090#1100' '#1082#1072#1082' '#1087#1077#1095#1072#1090#1072#1077#1084#1099#1081
      OnExecute = acSetTextPrintableExecute
    end
    object acTranslate2Text: TevAction
      Operation = ev_ccTranslate2Text
    end
    object acToolsSetSections: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1056#1072#1089#1089#1090#1072#1085#1086#1074#1082#1072' '#1088#1072#1079#1076#1077#1083#1086#1074
      OnExecute = acToolsSetSectionsExecute
    end
    object acInsertSub: TAction
      Category = #1042#1089#1090#1072#1074#1082#1072
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1084#1077#1090#1082#1091
      ImageIndex = 251
      ShortCut = 121
      OnExecute = acInsertSubExecute
      OnUpdate = acActiveEditorUpdate
    end
  end
end
