object HeaderControlEditor: THeaderControlEditor
  Left = 200
  Top = 108
  HelpContext = 26120
  BorderStyle = bsDialog
  Caption = 'HeaderControl Sections Editor'
  ClientHeight = 210
  ClientWidth = 441
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object HelpButton: TButton
    Left = 358
    Top = 176
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 5
    OnClick = HelpButtonClick
  end
  object ApplyButton: TButton
    Left = 278
    Top = 176
    Width = 75
    Height = 25
    Caption = '&Apply'
    Enabled = False
    TabOrder = 4
    OnClick = ApplyButtonClick
  end
  object CancelButton: TButton
    Left = 198
    Top = 176
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = CancelButtonClick
  end
  object OkButton: TButton
    Left = 118
    Top = 176
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = OkButtonClick
  end
  object GroupBox2: TGroupBox
    Left = 152
    Top = 4
    Width = 281
    Height = 157
    Caption = 'Section properties'
    TabOrder = 1
    object Label1: TLabel
      Left = 12
      Top = 21
      Width = 24
      Height = 13
      Caption = '&Text:'
      FocusControl = SectionText
    end
    object Label2: TLabel
      Left = 12
      Top = 47
      Width = 31
      Height = 13
      Caption = '&Width:'
      FocusControl = SectionWidth
    end
    object Label3: TLabel
      Left = 12
      Top = 73
      Width = 26
      Height = 13
      Caption = '&Style:'
      FocusControl = SectionStyle
    end
    object Label5: TLabel
      Left = 12
      Top = 99
      Width = 49
      Height = 13
      Caption = 'A&lignment:'
      FocusControl = SectionAlignment
    end
    object Label4: TLabel
      Left = 120
      Top = 48
      Width = 45
      Height = 13
      Caption = '&Min/Max:'
      FocusControl = SectionMinWidth
    end
    object SectionAlignment: TComboBox
      Left = 68
      Top = 96
      Width = 147
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      OnChange = SectionComboChange
      OnExit = SectionControlExit
      Items.Strings = (
        'Left justify'
        'Right justify'
        'Center')
    end
    object SectionStyle: TComboBox
      Left = 68
      Top = 70
      Width = 147
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      OnChange = SectionComboChange
      OnExit = SectionControlExit
      Items.Strings = (
        'Text'
        'OwnerDraw')
    end
    object SectionMaxWidth: TEdit
      Left = 220
      Top = 44
      Width = 45
      Height = 21
      TabOrder = 3
      OnChange = SectionEditChange
      OnExit = SectionControlExit
    end
    object SectionMinWidth: TEdit
      Left = 170
      Top = 44
      Width = 45
      Height = 21
      TabOrder = 2
      OnChange = SectionEditChange
      OnExit = SectionControlExit
    end
    object SectionWidth: TEdit
      Left = 68
      Top = 44
      Width = 45
      Height = 21
      TabOrder = 1
      OnChange = SectionEditChange
      OnExit = SectionControlExit
    end
    object SectionText: TEdit
      Left = 68
      Top = 18
      Width = 197
      Height = 21
      TabOrder = 0
      OnChange = SectionEditChange
      OnExit = SectionControlExit
    end
    object SectionAllowClick: TCheckBox
      Left = 68
      Top = 124
      Width = 79
      Height = 17
      Caption = 'Allow &click'
      TabOrder = 6
      OnClick = SectionComboChange
      OnExit = SectionControlExit
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 4
    Width = 137
    Height = 157
    Caption = 'S&ections'
    TabOrder = 0
    object SectionList: TListBox
      Left = 8
      Top = 16
      Width = 121
      Height = 101
      ItemHeight = 13
      TabOrder = 0
      OnClick = SectionListClick
      OnDragDrop = SectionListDragDrop
      OnDragOver = SectionListDragOver
      OnMouseDown = SectionListMouseDown
    end
    object NewButton: TButton
      Left = 8
      Top = 124
      Width = 57
      Height = 25
      Caption = '&New'
      TabOrder = 1
      OnClick = NewButtonClick
    end
    object DeleteButton: TButton
      Left = 72
      Top = 124
      Width = 57
      Height = 25
      Caption = '&Delete'
      TabOrder = 2
      OnClick = DeleteButtonClick
    end
  end
end
