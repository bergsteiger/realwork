object SearchWin: TSearchWin
  Left = 826
  Top = 234
  Width = 431
  Height = 233
  Caption = #1042#1067#1041#1054#1056#1050#1040' '#1044#1054#1050#1059#1052#1045#1053#1058#1054#1042
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poDefault
  Scaled = False
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  inline DocList: TDocumentList
    Left = 0
    Top = 0
    Width = 415
    Height = 175
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    inherited Split1: TvtSplitter
      Top = 60
      Width = 415
    end
    inherited SrchResultLister: TvtLister
      Width = 415
      Height = 60
      OnCountChanged = DocListSrchResultListerCountChanged
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      TabOrder = 2
    end
    inherited SubList: TvtDStringLister
      Top = 64
      Width = 415
      Height = 91
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      TabOrder = 0
    end
    inherited FooterPanel: TvtStatusBar
      Top = 155
      Width = 415
    end
    inherited pmSrch: TPopupMenu
      Top = 8
      object miSaveDocSet: TMenuItem [2]
        Action = acSaveDocSet
      end
      object N7: TMenuItem [3]
        Action = acSaveDocSetAs
      end
      object miDeleteDoc: TMenuItem
        Action = acDeleteDocument
      end
    end
    inherited alDocList: TActionList
      Left = 6
      Top = 44
      inherited acTypeFilter: TAction
        Caption = #1060#1080#1083#1100#1090#1088'...'
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 38
    Top = 10
    object MIDocSet: TMenuItem
      Caption = #1042#1099#1073#1086#1088#1082#1072
      GroupIndex = 5
      ShortCut = 116
      object miNextDocSet: TMenuItem
        Action = actSpecifySet
      end
      object miAddDocSet: TMenuItem
        Action = actAddSet
      end
      object miAndDocSet: TMenuItem
        Action = actTraverseSet
      end
      object miAndNotDocSet: TMenuItem
        Action = actSubstractSet
      end
      object miNewDocSet: TMenuItem
        Action = actNewSet
      end
      object miAddIDtoDocSet: TMenuItem
        Action = DocList.acInsertDocToObjList
      end
      object N9: TMenuItem
        Action = acRefreshResult
      end
      object N11: TMenuItem
        Action = acExpandEdition
      end
      object N15: TMenuItem
        Action = acGetCorrespondents
      end
      object N21: TMenuItem
        Action = acGetRespondents
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object miStatistic: TMenuItem
        Action = actSearchStats
      end
      object miDocInfo: TMenuItem
        Action = DocList.acDocInfo
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object miSort: TMenuItem
        Action = DocList.acSort
      end
      object miTypeFilter: TMenuItem
        Action = DocList.acTypeFilter
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miOpenDoc: TMenuItem
        Action = actOpenDocument
      end
      object N6: TMenuItem
        Action = actOpenSelectedDocuments
      end
      object miDocPrint: TMenuItem
        Action = DocList.acPrintAll
      end
      object miSaveAs: TMenuItem
        Action = actSaveDocAs
      end
      object N12: TMenuItem
        Action = acSendToServer
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miGroupOperation: TMenuItem
        Caption = #1054#1087#1077#1088#1072#1094#1080#1080' '#1089' '#1075#1088#1091#1087#1087#1086#1081
        object miGroupAdd: TMenuItem
          Action = actGroupAdd
        end
        object miGroupDel: TMenuItem
          Action = actGroupDelete
        end
        object N8: TMenuItem
          Action = acBatchDeleteAttributes
        end
        object miTouchStamp: TMenuItem
          Action = actGroupTouch
        end
        object miChangeHLinks: TMenuItem
          Action = DocList.acChangeHLinks
        end
        object IZM1: TMenuItem
          Action = actIZM
        end
        object N13: TMenuItem
          Action = acKTDocNameChange
        end
        object N16: TMenuItem
          Action = actGroupAutolink
        end
        object N19: TMenuItem
          Action = actGroupSetClone
        end
      end
      object miExport2NSRC: TMenuItem
        Action = actDocExport
      end
      object miSaveToEVD: TMenuItem
        Action = DocList.acSaveToEVD
      end
      object N14: TMenuItem
        Action = actAutoSpell
      end
    end
  end
  object alSearchActions: TActionList
    Left = 70
    Top = 10
    object actOpenDocument: TAction
      Category = 'Open'
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      OnExecute = actOpenDocumentExecute
    end
    object actOpenSelectedDocuments: TAction
      Category = 'Open'
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
      OnExecute = actOpenSelectedDocumentsExecute
    end
    object actSpecifySet: TAction
      Category = 'SetOperations'
      Caption = #1059#1090#1086#1095#1085#1080#1090#1100' '#1074#1099#1073#1086#1088#1082#1091
      OnExecute = actSpecifySetExecute
    end
    object actAddSet: TAction
      Category = 'SetOperations'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1099#1073#1086#1088#1082#1091
      OnExecute = actAddSetExecute
    end
    object actTraverseSet: TAction
      Category = 'SetOperations'
      Caption = #1055#1077#1088#1077#1089#1077#1095#1100' '#1089' '#1074#1099#1073#1086#1088#1082#1086#1081
      OnExecute = actTraverseSetExecute
    end
    object actSubstractSet: TAction
      Category = 'SetOperations'
      Caption = #1042#1099#1095#1077#1089#1090#1100' '#1074#1099#1073#1086#1088#1082#1091
      OnExecute = actSubstractSetExecute
    end
    object actNewSet: TAction
      Category = 'SetOperations'
      Caption = #1053#1086#1074#1072#1103' '#1074#1099#1073#1086#1088#1082#1072
      OnExecute = actNewSetExecute
    end
    object actSearchStats: TAction
      Category = 'Tools'
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1087#1086#1080#1089#1082#1072
      Visible = False
      OnExecute = actSearchStatsExecute
    end
    object actSaveDocAs: TAction
      Category = 'Tools'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
      OnExecute = actSaveDocAsExecute
    end
    object actGroupAdd: TAction
      Category = 'GroupOps'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnExecute = actGroupAddExecute
    end
    object actGroupDelete: TAction
      Category = 'GroupOps'
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = actGroupDeleteExecute
    end
    object actGroupTouch: TAction
      Category = 'GroupOps'
      Caption = #1055#1086#1084#1077#1090#1080#1090#1100' '#1082#1072#1082' '#1080#1079#1084#1077#1085#1077#1085#1085#1099#1077
      OnExecute = actGroupTouchExecute
    end
    object actDocExport: TAction
      Category = 'Tools'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      ShortCut = 49221
      OnExecute = actDocExportExecute
    end
    object actIZM: TAction
      Category = 'GroupOps'
      Caption = #1055#1088#1086#1089#1090#1072#1085#1086#1074#1082#1072' !IZM'
      OnExecute = actIZMExecute
    end
    object acRefreshResult: TAction
      Category = 'SetOperations'
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1087#1086#1080#1089#1082#1072
      ShortCut = 116
      OnExecute = acRefreshResultExecute
    end
    object acExpandEdition: TAction
      Category = 'SetOperations'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1088#1077#1076#1072#1082#1094#1080#1080
      OnExecute = acExpandEditionExecute
    end
    object acKTDocNameChange: TAction
      Category = 'GroupOps'
      Caption = #1056#1072#1089#1089#1090#1072#1074#1080#1090#1100' '#1082#1083#1102#1095#1077#1074#1099#1077' '#1090#1077#1084#1099
      Visible = False
      OnExecute = acKTDocNameChangeExecute
    end
    object actAutoSpell: TAction
      Category = 'Tools'
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1086#1088#1092#1086#1075#1088#1072#1092#1080#1102
      OnExecute = actAutoSpellExecute
    end
    object acGetCorrespondents: TAction
      Category = 'SetOperations'
      Caption = #1050#1086#1088#1088#1077#1089#1087#1086#1085#1076#1077#1085#1090#1099' '#1082' '#1074#1099#1073#1086#1088#1082#1077
      OnExecute = acGetCorrespondentsExecute
    end
    object actGroupAutolink: TAction
      Category = 'GroupOps'
      Caption = #1040#1074#1090#1086#1087#1088#1086#1089#1090#1072#1085#1086#1074#1082#1072' '#1089#1089#1099#1083#1086#1082
      OnExecute = actGroupAutolinkExecute
    end
    object actGroupSetClone: TAction
      Category = 'GroupOps'
      Caption = #1055#1088#1086#1089#1090#1072#1074#1080#1090#1100' '#1084#1077#1090#1082#1091' "'#1082#1083#1086#1085'" '#1080#1089#1090#1086#1095#1085#1080#1082#1072#1084' '#1086#1087#1091#1073#1083#1080#1082#1086#1074#1072#1085#1080#1103
      OnExecute = actGroupSetCloneExecute
    end
    object acGetRespondents: TAction
      Category = 'SetOperations'
      Caption = #1056#1077#1089#1087#1086#1085#1076#1077#1085#1090#1099' '#1082' '#1074#1099#1073#1086#1088#1082#1077
      OnExecute = acGetRespondentsExecute
    end
  end
  object alDocListTools: TActionList
    Left = 8
    Top = 80
    object acSaveDocSet: TAction
      Category = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1099#1073#1086#1088#1082#1091
      Enabled = False
      ImageIndex = 5
      OnExecute = acSaveDocSetExecute
    end
    object acSaveDocSetAs: TAction
      Category = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1099#1073#1086#1088#1082#1091' '#1082#1072#1082'...'
      Enabled = False
      ImageIndex = 7
      OnExecute = acSaveDocSetAsExecute
    end
    object acBatchDeleteAttributes: TAction
      Category = #1059#1076#1072#1083#1077#1085#1080#1077
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1072#1090#1088#1080#1073#1091#1090#1099'...'
      OnExecute = acBatchDeleteAttributesExecute
    end
    object acSendToServer: TAction
      Category = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1085#1072' '#1089#1077#1088#1074#1077#1088#1077
      OnExecute = acSendToServerExecute
    end
    object acDeleteDocument: TAction
      Category = #1059#1076#1072#1083#1077#1085#1080#1077
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      OnExecute = miDeleteDocClick
    end
  end
end
