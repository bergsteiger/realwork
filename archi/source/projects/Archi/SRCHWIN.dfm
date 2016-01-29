object SearchWin: TSearchWin
  Left = 826
  Top = 234
  Width = 431
  Height = 233
  Caption = '������� ����������'
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
        Caption = '������� ��������'
        OnClick = miDeleteDocClick
      end
    end
    inherited alDocList: TActionList
      Left = 6
      Top = 44
      inherited acTypeFilter: TAction
        Caption = '������...'
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 38
    Top = 10
    object MIDocSet: TMenuItem
      Caption = '�������'
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
        Caption = '�������� � �������'
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
      Caption = '������� ��������'
      OnExecute = actOpenDocumentExecute
    end
    object actOpenSelectedDocuments: TAction
      Category = 'Open'
      Caption = '������� ��������� ���������'
      OnExecute = actOpenSelectedDocumentsExecute
    end
    object actSpecifySet: TAction
      Category = 'SetOperations'
      Caption = '�������� �������'
      OnExecute = actSpecifySetExecute
    end
    object actAddSet: TAction
      Category = 'SetOperations'
      Caption = '�������� �������'
      OnExecute = actAddSetExecute
    end
    object actTraverseSet: TAction
      Category = 'SetOperations'
      Caption = '�������� � ��������'
      OnExecute = actTraverseSetExecute
    end
    object actSubstractSet: TAction
      Category = 'SetOperations'
      Caption = '������� �������'
      OnExecute = actSubstractSetExecute
    end
    object actNewSet: TAction
      Category = 'SetOperations'
      Caption = '����� �������'
      OnExecute = actNewSetExecute
    end
    object actSearchStats: TAction
      Category = 'Tools'
      Caption = '���������� ������'
      Visible = False
      OnExecute = actSearchStatsExecute
    end
    object actSaveDocAs: TAction
      Category = 'Tools'
      Caption = '��������� ���...'
      OnExecute = actSaveDocAsExecute
    end
    object actGroupAdd: TAction
      Category = 'GroupOps'
      Caption = '��������'
      OnExecute = actGroupAddExecute
    end
    object actGroupDelete: TAction
      Category = 'GroupOps'
      Caption = '�������'
      OnExecute = actGroupDeleteExecute
    end
    object actGroupTouch: TAction
      Category = 'GroupOps'
      Caption = '�������� ��� ����������'
      OnExecute = actGroupTouchExecute
    end
    object actDocExport: TAction
      Category = 'Tools'
      Caption = '������� ����������'
      ShortCut = 49221
      OnExecute = actDocExportExecute
    end
    object actIZM: TAction
      Category = 'GroupOps'
      Caption = '����������� !IZM'
      OnExecute = actIZMExecute
    end
    object acRefreshResult: TAction
      Category = 'SetOperations'
      Caption = '�������� ���������� ������'
      ShortCut = 116
      OnExecute = acRefreshResultExecute
    end
    object acExpandEdition: TAction
      Category = 'SetOperations'
      Caption = '�������� ��������'
      OnExecute = acExpandEditionExecute
    end
    object acKTDocNameChange: TAction
      Category = 'GroupOps'
      Caption = '���������� �������� ����'
      Visible = False
      OnExecute = acKTDocNameChangeExecute
    end
    object actAutoSpell: TAction
      Category = 'Tools'
      Caption = '��������� ����������'
      OnExecute = actAutoSpellExecute
    end
    object acGetCorrespondents: TAction
      Category = 'SetOperations'
      Caption = '�������������� � �������'
      OnExecute = acGetCorrespondentsExecute
    end
    object actGroupAutolink: TAction
      Category = 'GroupOps'
      Caption = '��������������� ������'
      OnExecute = actGroupAutolinkExecute
    end
    object actGroupSetClone: TAction
      Category = 'GroupOps'
      Caption = '���������� ����� "����" ���������� �������������'
      OnExecute = actGroupSetCloneExecute
    end
    object acGetRespondents: TAction
      Category = 'SetOperations'
      Caption = '����������� � �������'
      OnExecute = acGetRespondentsExecute
    end
  end
  object alDocListTools: TActionList
    Left = 8
    Top = 80
    object acSaveDocSet: TAction
      Category = '����������'
      Caption = '��������� �������'
      Enabled = False
      ImageIndex = 5
      OnExecute = acSaveDocSetExecute
    end
    object acSaveDocSetAs: TAction
      Category = '����������'
      Caption = '��������� ������� ���...'
      Enabled = False
      ImageIndex = 7
      OnExecute = acSaveDocSetAsExecute
    end
    object acBatchDeleteAttributes: TAction
      Category = '��������'
      Caption = '�������� ��������...'
      OnExecute = acBatchDeleteAttributesExecute
    end
    object acSendToServer: TAction
      Category = '����������'
      Caption = '��������� �� �������'
      OnExecute = acSendToServerExecute
    end
  end
end
