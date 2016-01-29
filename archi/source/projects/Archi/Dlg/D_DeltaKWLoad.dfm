object DeltaKWDialog: TDeltaKWDialog
  Left = 550
  Top = 107
  Width = 696
  Height = 480
  Caption = #1059#1076#1072#1083#1103#1077#1084#1099#1077' '#1082#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072' '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ListPanel: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 137
    Align = alTop
    Caption = 'ListPanel'
    TabOrder = 0
    object KeywordsList: TListBox
      Left = 1
      Top = 1
      Width = 686
      Height = 135
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
      OnClick = KeywordsListClick
      OnKeyDown = KeywordsListKeyDown
    end
  end
  object DocumentPanel: TPanel
    Left = 0
    Top = 137
    Width = 688
    Height = 316
    Align = alClient
    Caption = 'DocumentPanel'
    TabOrder = 1
    inline DocumentList1: TDocumentList
      Left = 1
      Top = 1
      Width = 686
      Height = 314
      Align = alClient
      TabOrder = 0
      inherited Split1: TvtSplitter
        Top = 170
        Width = 686
      end
      inherited SrchResultLister: TvtLister
        Width = 686
        Height = 170
      end
      inherited SubList: TvtDStringLister
        Top = 174
        Width = 686
      end
      inherited FooterPanel: TvtStatusBar
        Top = 294
        Width = 686
      end
      inherited pmSrch: TPopupMenu
        Left = 71
        Top = 22
      end
      inherited alDocList: TActionList
        Left = 188
        Top = 24
        inherited acRemoveItem: TAction
          Enabled = False
          ShortCut = 0
        end
      end
    end
  end
end
