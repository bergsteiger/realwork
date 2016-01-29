object enUserPropertiesForm: TenUserPropertiesForm
  Left = 422
  Top = 253
  Width = 499
  Height = 215
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  UserTypes = <
    item
      Name = 'utUserProperties'
      Caption = #1044#1072#1085#1085#1099#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
    end>
  OnChangedDataSource = vcmEntityFormChangedDataSource
  DesignSize = (
    483
    179)
  PixelsPerInch = 96
  TextHeight = 16
  object lblID: TLabel
    Left = 8
    Top = 8
    Width = 24
    Height = 15
    Caption = 'lblID'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edName: TLabeledEdit
    Left = 8
    Top = 48
    Width = 465
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 25
    EditLabel.Height = 16
    EditLabel.Caption = #1048#1084#1103
    TabOrder = 0
    OnChange = edNameChange
  end
  object edLogin: TLabeledEdit
    Left = 8
    Top = 96
    Width = 153
    Height = 24
    EditLabel.Width = 35
    EditLabel.Height = 16
    EditLabel.Caption = #1051#1086#1075#1080#1085
    TabOrder = 1
    OnChange = edLoginChange
  end
  object btnPassword: TBitBtn
    Left = 168
    Top = 94
    Width = 97
    Height = 25
    Caption = #1055#1072#1088#1086#1083#1100
    TabOrder = 2
    OnClick = btnPasswordClick
  end
  object cbIsAdmin: TCheckBox
    Left = 8
    Top = 128
    Width = 121
    Height = 17
    Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088
    TabOrder = 3
    OnClick = cbIsAdminClick
  end
  object cbIsActive: TCheckBox
    Left = 8
    Top = 152
    Width = 97
    Height = 17
    Caption = #1040#1082#1090#1080#1074#1077#1085
    TabOrder = 4
    OnClick = cbIsActiveClick
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
    Left = 234
    Top = 10
  end
end
