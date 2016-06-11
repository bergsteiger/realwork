object MaskForm: TMaskForm
  Left = 245
  Top = 153
  ActiveControl = InputMask
  BorderStyle = bsDialog
  Caption = 'Input Mask Editor'
  ClientHeight = 211
  ClientWidth = 488
  ParentFont = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 124
    Width = 193
    Height = 50
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 56
    Height = 13
    Caption = '&Input Mask:'
    FocusControl = InputMask
    IsControl = True
  end
  object Label2: TLabel
    Left = 208
    Top = 8
    Width = 72
    Height = 13
    Caption = '&Sample Masks:'
    FocusControl = ListBox1
    IsControl = True
  end
  object Label3: TLabel
    Left = 12
    Top = 128
    Width = 51
    Height = 13
    Caption = '&Test Input:'
    FocusControl = TestEdit
    IsControl = True
  end
  object Label4: TLabel
    Left = 24
    Top = 60
    Width = 99
    Height = 13
    Caption = 'Character for &Blanks:'
    FocusControl = Blanks
    IsControl = True
  end
  object InputMask: TEdit
    Left = 8
    Top = 24
    Width = 192
    Height = 21
    TabOrder = 0
    Text = 'InputMask'
    OnChange = InputMaskChange
    IsControl = True
  end
  object ListBox1: TListBox
    Left = 208
    Top = 24
    Width = 268
    Height = 149
    ItemHeight = 16
    Items.Strings = (
      'Phone | 4155551212 | !\(999\)000-0000;1;_'
      'Extension | 15450 | !99999;1;_'
      'Social Security | 555555555 | 000\-00\-0000;1;_'
      'Short Zip Code | 90504 | 00000;1;_'
      'Long Zip Code | 905040000 | 00000\-9999;1;_'
      'Date | 062794 | !99/99/00;1;_'
      'Long Time | 090515PM | !90:00:00>LL;1;_'
      'Short Time | 1345 | !90:00;1;_')
    Style = lbOwnerDrawFixed
    TabOrder = 4
    OnClick = ListBoxSelect
    OnDrawItem = ListDrawItem
    IsControl = True
  end
  object TestEdit: TMaskEdit
    Left = 12
    Top = 148
    Width = 185
    Height = 21
    MaxLength = 0
    TabOrder = 3
    IsControl = True
  end
  object Blanks: TEdit
    Left = 152
    Top = 56
    Width = 33
    Height = 21
    MaxLength = 1
    TabOrder = 1
    Text = '_'
    OnChange = BlanksChange
    IsControl = True
  end
  object SaveMaskCheck: TCheckBox
    Left = 8
    Top = 84
    Width = 177
    Height = 20
    Caption = 'Save &Literal Characters'
    TabOrder = 2
    OnClick = BlanksChange
    IsControl = True
  end
  object Masks: TButton
    Left = 16
    Top = 181
    Width = 75
    Height = 25
    Caption = '&Masks...'
    TabOrder = 5
    OnClick = MasksClick
  end
  object OKButton: TButton
    Left = 241
    Top = 181
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object CancelButton: TButton
    Left = 321
    Top = 181
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 7
  end
  object HelpButton: TButton
    Left = 401
    Top = 181
    Width = 75
    Height = 25
    Caption = 'Help'
    TabOrder = 8
    OnClick = HelpButtonClick
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'dem'
    Filter = 'Edit Masks (*.dem)|*.dem|All Files (*.*)|*.*'
    Title = 'Open Mask File'
    Left = 112
    Top = 184
  end
end
