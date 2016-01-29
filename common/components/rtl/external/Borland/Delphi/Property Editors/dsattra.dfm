object AssociateAttributes: TAssociateAttributes
  Left = 337
  Top = 113
  BorderStyle = bsDialog
  Caption = 'Associate attributes'
  ClientHeight = 199
  ClientWidth = 235
  ParentFont = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 156
    Top = 6
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 156
    Top = 37
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    OnClick = CancelBtnClick
  end
  object HelpBtn: TButton
    Left = 156
    Top = 69
    Width = 75
    Height = 25
    Caption = '&Help'
    Enabled = False
    TabOrder = 3
    Visible = False
    OnClick = HelpBtnClick
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 1
    Width = 148
    Height = 193
    Caption = 'Attribute set name'
    TabOrder = 0
    object Edit: TEdit
      Left = 8
      Top = 16
      Width = 129
      Height = 21
      TabOrder = 0
      OnChange = EditChange
      OnKeyDown = EditKeyDown
    end
    object AttributeNamesList: TListBox
      Left = 8
      Top = 40
      Width = 129
      Height = 145
      ItemHeight = 13
      Sorted = True
      TabOrder = 1
      OnClick = ListBoxClick
      OnDblClick = ListBoxDblClick
    end
  end
end
