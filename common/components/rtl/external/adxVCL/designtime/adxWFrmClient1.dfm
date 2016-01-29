inherited frmClient1: TfrmClient1
  Left = 417
  Top = 212
  ActiveControl = edProjectName
  Caption = 'frmClient1'
  ClientHeight = 226
  ClientWidth = 483
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblComment: TLabel
    Top = 28
    Width = 448
    Height = 88
    ParentFont = False
  end
  object LabelProjectFolder: TLabel [1]
    Left = 15
    Top = 199
    Width = 62
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Project &folder'
    FocusControl = edDst
  end
  object LabelProjectName: TLabel [2]
    Left = 15
    Top = 122
    Width = 62
    Height = 13
    Caption = 'Project n&ame'
    FocusControl = edProjectName
  end
  object LabelCoClassName: TLabel
    Left = 15
    Top = 149
    Width = 67
    Height = 13
    Caption = '&CoClass name'
    FocusControl = edCoClass
    Visible = False
  end
  object edDst: TEdit
    Left = 105
    Top = 198
    Width = 292
    Height = 21
    Anchors = [akLeft, akBottom]
    TabOrder = 2
  end
  object btnBrowse: TButton
    Left = 403
    Top = 195
    Width = 59
    Height = 21
    Anchors = [akLeft, akBottom]
    Caption = 'Br&owse...'
    TabOrder = 3
    OnClick = btnBrowseClick
  end
  object edProjectName: TEdit
    Left = 105
    Top = 121
    Width = 175
    Height = 21
    TabOrder = 0
  end
  object edCoClass: TEdit
    Left = 105
    Top = 150
    Width = 175
    Height = 21
    TabOrder = 1
    Visible = False
  end
  object rgInstall: TRadioGroup
    Left = 294
    Top = 115
    Width = 167
    Height = 50
    Caption = ' Register with: '
    ItemIndex = 0
    Items.Strings = (
      'A&dmin privileges'
      '&User privileges')
    TabOrder = 4
  end
  object cbInnoSetup: TCheckBox
    Left = 294
    Top = 166
    Width = 178
    Height = 17
    Caption = 'Create InnoSetup setup project'
    Enabled = False
    TabOrder = 5
  end
  object cbWiX: TCheckBox
    Left = 294
    Top = 181
    Width = 178
    Height = 17
    Caption = 'Create WiX setup project'
    Enabled = False
    TabOrder = 6
  end
end
