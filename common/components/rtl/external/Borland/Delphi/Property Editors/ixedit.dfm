object IndexFiles: TIndexFiles
  Left = 236
  Top = 118
  BorderStyle = bsDialog
  Caption = 'Index Files'
  ClientHeight = 203
  ClientWidth = 248
  ParentFont = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 4
    Top = 3
    Width = 238
    Height = 152
    Caption = 'Index Files'
    TabOrder = 0
    object ListBox1: TListBox
      Left = 11
      Top = 20
      Width = 217
      Height = 88
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 0
      OnClick = ListBox1Click
    end
    object Add: TButton
      Left = 34
      Top = 116
      Width = 60
      Height = 25
      Caption = '&Add...'
      TabOrder = 1
      OnClick = AddClick
    end
    object Delete: TButton
      Left = 101
      Top = 116
      Width = 60
      Height = 25
      Caption = '&Delete'
      Enabled = False
      TabOrder = 2
      OnClick = DeleteClick
    end
    object Clear: TButton
      Left = 168
      Top = 116
      Width = 60
      Height = 25
      Caption = '&Clear'
      Enabled = False
      TabOrder = 3
      OnClick = ClearClick
    end
  end
  object Ok: TButton
    Left = 6
    Top = 169
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Cancel: TButton
    Left = 87
    Top = 169
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object Help: TButton
    Left = 167
    Top = 169
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 3
    OnClick = HelpClick
  end
  object OpenDialog: TOpenDialog
    Filter = 
      'dBASE Multiple Index (*.MDX)|*.mdx|dBase Index (*.NDX)|*.ndx|Fox' +
      'Pro Index (*.CDX)|*.cdx'
    Title = 'Open'
    Left = 218
    Top = 169
  end
end
