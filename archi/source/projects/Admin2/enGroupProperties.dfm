object enUserGroupPropetriesForm: TenUserGroupPropetriesForm
  Left = 437
  Top = 291
  Width = 398
  Height = 190
  Anchors = [akLeft]
  Color = clBtnFace
  UserTypes = <
    item
      Name = 'utUserGroupPropetries'
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1075#1088#1091#1087#1087#1099
    end>
  OnChangedDataSource = vcmEntityFormChangedDataSource
  DesignSize = (
    382
    154)
  PixelsPerInch = 96
  TextHeight = 13
  object edName: TLabeledEdit
    Left = 7
    Top = 20
    Width = 368
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 103
    EditLabel.Height = 16
    EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1088#1091#1087#1087#1099
    TabOrder = 0
    OnChange = edNameChange
  end
  object lstFlags: TvtStringLister
    Left = 7
    Top = 46
    Width = 368
    Height = 36
    Items.Strings = (
      #1055#1088#1080#1085#1072#1076#1083#1077#1078#1085#1086#1089#1090#1100' '#1082' '#1073#1072#1079#1072#1084
      #1059#1076#1072#1083#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074)
    Sorted = False
    AlienSource = False
    AutoRowHeight = False
    BorderStyle = bsNone
    MultiSelect = True
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    RowHeight = 18
    ScrollStyle = ssNone
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clBtnFace
    SelectNonFocusColor.TextColor = clBtnText
    PickedList = True
    TriplePicked = True
    OnIsSelected = lstFlagsIsSelected
    OnSelect = lstFlagsSelect
    Color = clBtnFace
    ParentColor = False
    TabOrder = 1
    TabStop = True
    Anchors = [akLeft, akTop, akRight]
  end
  object GroupBox3: TGroupBox
    Left = 7
    Top = 90
    Width = 368
    Height = 55
    Anchors = [akLeft, akTop, akRight]
    Caption = ' '#1055#1088#1080#1086#1088#1080#1090#1077#1090#1099' '#1079#1072#1076#1072#1085#1080#1081' '
    TabOrder = 2
    object Label2: TLabel
      Left = 10
      Top = 25
      Width = 44
      Height = 16
      Caption = #1048#1084#1087#1086#1088#1090
    end
    object Label5: TLabel
      Left = 194
      Top = 25
      Width = 48
      Height = 16
      Caption = #1069#1082#1089#1087#1086#1088#1090
    end
    object cbImportPriority: TComboBox
      Left = 62
      Top = 21
      Width = 108
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      ItemIndex = 2
      TabOrder = 0
      Text = #1053#1086#1088#1084#1072#1083#1100#1085#1099#1081
      OnChange = cbImportPriorityChange
      Items.Strings = (
        #1053#1072#1080#1074#1099#1089#1096#1080#1081
        #1042#1099#1089#1086#1082#1080#1081
        #1053#1086#1088#1084#1072#1083#1100#1085#1099#1081
        #1053#1080#1079#1082#1080#1081
        #1053#1080#1079#1096#1080#1081)
    end
    object cbExportPriority: TComboBox
      Left = 248
      Top = 21
      Width = 108
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      ItemIndex = 2
      TabOrder = 1
      Text = #1053#1086#1088#1084#1072#1083#1100#1085#1099#1081
      OnChange = cbExportPriorityChange
      Items.Strings = (
        #1053#1072#1080#1074#1099#1089#1096#1080#1081
        #1042#1099#1089#1086#1082#1080#1081
        #1053#1086#1088#1084#1072#1083#1100#1085#1099#1081
        #1053#1080#1079#1082#1080#1081
        #1053#1080#1079#1096#1080#1081)
    end
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
    Left = 202
    Top = 10
  end
end
