object ddTuneBlocksDialog: TddTuneBlocksDialog
  Left = 305
  Top = 123
  Width = 532
  Height = 414
  Anchors = [akLeft]
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1089#1090#1088#1091#1082#1090#1091#1088#1099' '#1073#1083#1086#1082#1086#1074
  Color = clBtnFace
  Constraints.MinHeight = 282
  Constraints.MinWidth = 486
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  DesignSize = (
    516
    378)
  PixelsPerInch = 96
  TextHeight = 15
  object BlockTree: TvtOutliner
    Left = 8
    Top = 8
    Width = 505
    Height = 324
    AutoRowHeight = False
    Header.Left = 0
    Header.Top = 0
    Header.Width = 501
    Header.Height = 18
    Header.Sections = <
      item
        Caption = #1044#1086#1082#1091#1084#1077#1085#1090
        Width = 75
        AutoResize = False
        MinWidth = 20
        MaxWidth = 2147483647
      end>
    Header.Font.Name = 'Arial CYR'
    MultiSelect = True
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clBtnFace
    SelectNonFocusColor.TextColor = clBtnText
    OnGetItemImage = BlockTreeGetItemImage
    OnGetItemFont = BlockTreeGetItemFont
    OnSelectChange = BlockTreeSelectChange
    OnCurrentChanged = BlockTreeCurrentChanged
    OnIsCommandProcessed = BlockTreeIsCommandProcessed
    Font.Height = -12
    ParentColor = False
    TabOrder = 0
    TabStop = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    OnMouseDown = BlockTreeMouseDown
  end
  object UpButton: TButton
    Left = 8
    Top = 343
    Width = 75
    Height = 25
    Action = actUp
    Anchors = [akLeft, akBottom]
    TabOrder = 1
  end
  object DownButton: TButton
    Left = 88
    Top = 343
    Width = 75
    Height = 25
    Action = actDown
    Anchors = [akLeft, akBottom]
    TabOrder = 2
  end
  object DelButton: TButton
    Left = 168
    Top = 343
    Width = 75
    Height = 25
    Action = actDelete
    Anchors = [akLeft, akBottom]
    TabOrder = 3
  end
  object BitBtn1: TBitBtn
    Left = 340
    Top = 344
    Width = 81
    Height = 25
    Anchors = [akRight, akBottom]
    TabOrder = 4
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 428
    Top = 344
    Width = 85
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 5
    OnClick = BitBtn1Click
    Kind = bkCancel
  end
  object ActionList1: TActionList
    OnUpdate = ActionList1Update
    Left = 418
    Top = 209
    object actUp: TAction
      Caption = '<'
      OnExecute = UpButtonClick
    end
    object actDown: TAction
      Caption = '>'
      OnExecute = DownButtonClick
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = DelButtonClick
    end
  end
end
