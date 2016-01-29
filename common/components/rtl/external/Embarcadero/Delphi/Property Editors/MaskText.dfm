object MaskTextForm: TMaskTextForm
  Left = 225
  Top = 200
  ActiveControl = TestEdit
  BorderStyle = bsDialog
  Caption = 'Masked Text Editor'
  ClientHeight = 92
  ClientWidth = 286
  ParentFont = True
  PixelsPerInch = 96
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 10
    Width = 51
    Height = 13
    Caption = '&Input Text:'
    FocusControl = TestEdit
    IsControl = True
  end
  object Label1: TLabel
    Left = 8
    Top = 36
    Width = 50
    Height = 13
    Caption = 'Edit Mask:'
    IsControl = True
  end
  object EditMask: TLabel
    Left = 76
    Top = 36
    Width = 200
    Height = 13
    AutoSize = False
    Caption = 'None'
    IsControl = True
  end
  object TestEdit: TMaskEdit
    Left = 76
    Top = 8
    Width = 200
    Height = 21
    MaxLength = 0
    TabOrder = 0
    IsControl = True
  end
  object OKButton: TButton
    Left = 40
    Top = 62
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelButton: TButton
    Left = 119
    Top = 62
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object HelpButton: TButton
    Left = 200
    Top = 62
    Width = 75
    Height = 25
    Caption = 'Help'
    TabOrder = 3
    OnClick = HelpButtonClick
  end
end
