object StatusBarEditor: TStatusBarEditor
  Left = 200
  Top = 108
  HelpContext = 26130
  BorderStyle = bsDialog
  Caption = 'StatusBar Panels Editor'
  ClientHeight = 210
  ClientWidth = 393
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object HelpButton: TButton
    Left = 310
    Top = 176
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 5
    OnClick = HelpButtonClick
  end
  object ApplyButton: TButton
    Left = 230
    Top = 176
    Width = 75
    Height = 25
    Caption = '&Apply'
    Enabled = False
    TabOrder = 4
    OnClick = ApplyButtonClick
  end
  object CancelButton: TButton
    Left = 150
    Top = 176
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = CancelButtonClick
  end
  object OkButton: TButton
    Left = 70
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
    Width = 233
    Height = 157
    Caption = 'Panel properties'
    TabOrder = 1
    object Label1: TLabel
      Left = 12
      Top = 21
      Width = 24
      Height = 13
      Caption = '&Text:'
      FocusControl = PanelText
    end
    object Label2: TLabel
      Left = 12
      Top = 47
      Width = 31
      Height = 13
      Caption = '&Width:'
      FocusControl = PanelWidth
    end
    object Label3: TLabel
      Left = 12
      Top = 73
      Width = 26
      Height = 13
      Caption = '&Style:'
      FocusControl = PanelStyle
    end
    object Label4: TLabel
      Left = 12
      Top = 99
      Width = 30
      Height = 13
      Caption = '&Bevel:'
      FocusControl = PanelBevel
    end
    object Label5: TLabel
      Left = 12
      Top = 125
      Width = 49
      Height = 13
      Caption = 'A&lignment:'
      FocusControl = PanelAlignment
    end
    object PanelText: TEdit
      Left = 68
      Top = 18
      Width = 145
      Height = 21
      TabOrder = 0
      OnChange = PanelEditChange
      OnExit = PanelControlExit
    end
    object PanelWidth: TEdit
      Left = 68
      Top = 44
      Width = 145
      Height = 21
      TabOrder = 1
      OnChange = PanelEditChange
      OnExit = PanelControlExit
    end
    object PanelStyle: TComboBox
      Left = 68
      Top = 70
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = PanelComboChange
      OnExit = PanelControlExit
      Items.Strings = (
        'Text'
        'OwnerDraw')
    end
    object PanelBevel: TComboBox
      Left = 68
      Top = 96
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnChange = PanelComboChange
      OnExit = PanelControlExit
      Items.Strings = (
        'None'
        'Lowered'
        'Raised')
    end
    object PanelAlignment: TComboBox
      Left = 68
      Top = 122
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      OnChange = PanelComboChange
      OnExit = PanelControlExit
      Items.Strings = (
        'Left justify'
        'Right justify'
        'Center')
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 4
    Width = 137
    Height = 157
    Caption = '&Panels'
    TabOrder = 0
    object PanelList: TListBox
      Left = 8
      Top = 16
      Width = 121
      Height = 101
      ItemHeight = 13
      TabOrder = 0
      OnClick = PanelListClick
      OnDragDrop = PanelListDragDrop
      OnDragOver = PanelListDragOver
      OnMouseDown = PanelListMouseDown
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
