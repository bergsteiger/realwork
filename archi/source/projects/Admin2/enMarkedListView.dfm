object enMarkedListForm: TenMarkedListForm
  Left = 377
  Top = 262
  Width = 247
  Height = 282
  HelpType = htKeyword
  Caption = 'a'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  OldCreateOrder = True
  UserTypes = <
    item
      Name = 'utGroupsList'
      Caption = #1043#1088#1091#1087#1087#1099' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
    end
    item
      Name = 'utUsersList'
      Caption = #1057#1087#1080#1089#1086#1082' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
    end>
  OnChangedDataSource = vcmEntityFormChangedDataSource
  PixelsPerInch = 96
  TextHeight = 13
  object MarkedList: TvtLister
    Left = 0
    Top = 0
    Width = 239
    Height = 255
    AutoRowHeight = False
    Header.Left = 0
    Header.Top = 0
    Header.Width = 235
    Header.Height = 18
    IntegralHeight = False
    MultiSelect = True
    InternalSelector = False
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clBtnFace
    SelectNonFocusColor.TextColor = clBtnText
    PickedList = True
    ReadOnly = False
    OnGetStrItem = MarkedListGetStrItem
    OnIsSelected = MarkedListIsSelected
    OnSelect = MarkedListSelect
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Height = -13
    Font.Name = 'Arial'
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    TabStop = True
  end
  object Entities: TvcmEntities
    Entities = <
      item
        Name = 'enTest'
        Operations = <
          item
            Name = 'opTest'
          end>
      end>
    Left = 18
    Top = 26
  end
end
