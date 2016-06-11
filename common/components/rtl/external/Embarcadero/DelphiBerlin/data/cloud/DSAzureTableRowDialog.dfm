object TAzureTableRowDialog: TTAzureTableRowDialog
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Entity Property Dialog'
  ClientHeight = 141
  ClientWidth = 384
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 281
    Height = 125
    Shape = bsFrame
  end
  object nameLabel: TLabel
    Left = 16
    Top = 23
    Width = 31
    Height = 13
    Caption = 'Name:'
  end
  object valueLabel: TLabel
    Left = 17
    Top = 50
    Width = 30
    Height = 13
    Caption = 'Value:'
  end
  object datatypeLabel: TLabel
    Left = 17
    Top = 77
    Width = 54
    Height = 13
    Caption = 'Data Type:'
  end
  object errorLabel: TLabel
    Left = 17
    Top = 112
    Width = 100
    Height = 13
    Color = clBtnFace
    Constraints.MinWidth = 100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object OKBtn: TButton
    Left = 301
    Top = 8
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 300
    Top = 38
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object nameField: TEdit
    Left = 88
    Top = 20
    Width = 193
    Height = 21
    TabOrder = 2
    OnChange = nameFieldChange
  end
  object valueField: TEdit
    Left = 88
    Top = 47
    Width = 193
    Height = 21
    TabOrder = 3
    OnChange = valueFieldChange
  end
  object datatypeCombo: TComboBox
    Left = 88
    Top = 74
    Width = 193
    Height = 21
    Style = csDropDownList
    TabOrder = 4
    OnChange = datatypeComboChange
    Items.Strings = (
      'String'
      'Boolean'
      'Int32'
      'Int64'
      'Double'
      'DateTime'
      'Binary'
      'Guid')
  end
end
