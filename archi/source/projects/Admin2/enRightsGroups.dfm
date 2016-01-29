object enGroupRightsForm: TenGroupRightsForm
  Left = 771
  Top = 208
  Width = 222
  Height = 279
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  UserTypes = <
    item
      Name = 'utGroupRights'
    end>
  OnChangedDataSource = vcmEntityFormChangedDataSource
  PixelsPerInch = 96
  TextHeight = 16
  object lstDocGroups: TvtLister
    Left = 0
    Top = 25
    Width = 206
    Height = 218
    AutoRowHeight = False
    IntegralHeight = False
    InternalSelector = False
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    RowHeight = 18
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clBtnFace
    SelectNonFocusColor.TextColor = clBtnText
    OnGetStrItem = lstDocGroupsGetStrItem
    OnGetItemFont = lstDocGroupsGetItemFont
    OnCurrentChanged = lstDocGroupsCurrentChanged
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    ParentColor = False
    TabOrder = 0
    TabStop = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 206
    Height = 25
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = ' '#1043#1088#1091#1087#1087#1099' '#1076#1086#1089#1090#1091#1087#1072
    TabOrder = 1
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
    Left = 26
    Top = 114
  end
end
