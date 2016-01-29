object SaveAttributesAs: TSaveAttributesAs
  Left = 426
  Top = 119
  BorderStyle = bsDialog
  Caption = 'Save %s attributes as'
  ClientHeight = 119
  ClientWidth = 274
  ParentFont = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 2
    Top = 8
    Width = 183
    Height = 105
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 10
    Top = 16
    Width = 88
    Height = 13
    Caption = '&Attribute set name:'
    FocusControl = AttributeNameEdit
  end
  object Label2: TLabel
    Left = 10
    Top = 64
    Width = 48
    Height = 13
    Caption = '&Based on:'
    FocusControl = BasedOnList
  end
  object BasedOnList: TComboBox
    Left = 10
    Top = 80
    Width = 167
    Height = 21
    ItemHeight = 13
    TabOrder = 1
  end
  object AttributeNameEdit: TEdit
    Left = 10
    Top = 32
    Width = 167
    Height = 21
    TabOrder = 0
  end
  object OKBtn: TButton
    Left = 192
    Top = 8
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 192
    Top = 40
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
    OnClick = CancelBtnClick
  end
  object HelpBtn: TButton
    Left = 192
    Top = 72
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 4
    OnClick = HelpBtnClick
  end
end
