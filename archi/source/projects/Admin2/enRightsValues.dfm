object enRigthsValuesForm: TenRigthsValuesForm
  Left = 612
  Top = 234
  Width = 201
  Height = 323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Height = -13
  Font.Name = 'Arial'
  UserTypes = <
    item
      Name = 'utRightsValues'
    end>
  OnChangedDataSource = vcmEntityFormChangedDataSource
  PixelsPerInch = 96
  TextHeight = 16
  object lstRightsValues: TvtLister
    Left = 0
    Top = 25
    Width = 193
    Height = 264
    AutoRowHeight = False
    IntegralHeight = False
    MultiSelect = True
    InternalSelector = False
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    RowHeight = 18
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clBtnFace
    SelectNonFocusColor.TextColor = clBtnText
    PickedList = True
    TriplePicked = True
    ReadOnly = False
    OnGetStrItem = lstRightsValuesGetStrItem
    OnIsSelected = lstRightsValuesIsSelected
    OnSelect = lstRightsValuesSelect
    Align = alClient
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Height = -13
    Font.Name = 'Arial'
    ParentColor = False
    TabOrder = 0
    TabStop = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 193
    Height = 25
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = ' '#1057#1087#1080#1089#1086#1082' '#1087#1088#1072#1074
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
    Top = 170
  end
end
