object AddActionDialog: TAddActionDialog
  Left = 225
  Top = 109
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Add Action'
  ClientHeight = 160
  ClientWidth = 336
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 2
    Width = 22
    Height = 13
    Caption = '&URL'
    FocusControl = URLEdit
  end
  object Label2: TLabel
    Left = 8
    Top = 42
    Width = 85
    Height = 13
    Caption = '&Component Name'
    FocusControl = ComponentEdit
  end
  object Label3: TLabel
    Left = 8
    Top = 82
    Width = 81
    Height = 13
    Caption = 'Component &Type'
  end
  object URLEdit: TEdit
    Left = 8
    Top = 16
    Width = 321
    Height = 21
    Color = clWindow
    TabOrder = 0
  end
  object ComponentEdit: TEdit
    Left = 8
    Top = 56
    Width = 321
    Height = 21
    Color = clWindow
    TabOrder = 1
  end
  object Button1: TButton
    Left = 96
    Top = 128
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 176
    Top = 128
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object Button3: TButton
    Left = 256
    Top = 128
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 4
  end
  object TypeComboBox: TComboBox
    Left = 8
    Top = 96
    Width = 321
    Height = 21
    Style = csDropDownList
    Color = clWindow
    ItemHeight = 13
    ItemIndex = -1
    TabOrder = 5
    OnChange = TypeComboBoxChange
  end
end
