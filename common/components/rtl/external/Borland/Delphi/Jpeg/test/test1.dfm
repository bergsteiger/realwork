object Form1: TForm1
  Left = 954
  Top = 630
  AutoScroll = False
  Caption = 'Form1'
  ClientHeight = 376
  ClientWidth = 488
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poDefaultPosOnly
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 27
    Width = 124
    Height = 349
    Align = alLeft
    TabOrder = 0
    object DirectoryListBox1: TDirectoryListBox
      Left = 1
      Top = 1
      Width = 122
      Height = 79
      Align = alTop
      Ctl3D = True
      FileList = FileListBox1
      ItemHeight = 16
      ParentCtl3D = False
      TabOrder = 0
    end
    object FileListBox1: TFileListBox
      Left = 1
      Top = 80
      Width = 122
      Height = 268
      Align = alClient
      ItemHeight = 13
      TabOrder = 1
      OnClick = FileListBox1DblClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 488
    Height = 27
    Align = alTop
    TabOrder = 1
    object DriveComboBox1: TDriveComboBox
      Left = 7
      Top = 3
      Width = 117
      Height = 19
      DirList = DirectoryListBox1
      TabOrder = 0
    end
    object Scale: TComboBox
      Left = 127
      Top = 3
      Width = 36
      Height = 21
      Hint = 'Scale'
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      TabOrder = 1
      OnClick = SetJPEGOptions
      Items.Strings = (
        '1:1'
        '1:2'
        '1:4'
        '1:8')
    end
    object PixelFormat: TComboBox
      Left = 166
      Top = 3
      Width = 49
      Height = 21
      Hint = 'Pixel Format'
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      TabOrder = 2
      OnClick = SetJPEGOptions
      Items.Strings = (
        '24 bit'
        '8 bit')
    end
    object ColorSpace: TComboBox
      Left = 218
      Top = 3
      Width = 62
      Height = 21
      Hint = 'Color space'
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      TabOrder = 3
      OnClick = SetJPEGOptions
      Items.Strings = (
        'RGB'
        'Grayscale')
    end
    object Performance: TComboBox
      Left = 283
      Top = 3
      Width = 75
      Height = 21
      Hint = 'Performance'
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      TabOrder = 4
      OnClick = SetJPEGOptions
      Items.Strings = (
        'Quality'
        'Speed')
    end
    object ProgressiveDisplay: TCheckBox
      Left = 364
      Top = 1
      Width = 124
      Height = 14
      Caption = 'Progressive JPEG'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = SetJPEGOptions
    end
    object IncrementalDisplay: TCheckBox
      Left = 364
      Top = 12
      Width = 137
      Height = 14
      Caption = 'Incremental Display'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
  end
  object ScrollBox1: TScrollBox
    Left = 124
    Top = 27
    Width = 364
    Height = 349
    Align = alClient
    TabOrder = 2
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 85
      Height = 85
      AutoSize = True
    end
  end
  object MainMenu1: TMainMenu
    Left = 96
    Top = 217
    object File1: TMenuItem
      Caption = '&File'
      object Open1: TMenuItem
        Caption = '&Open...'
        ShortCut = 114
        OnClick = Open1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Print1: TMenuItem
        Caption = '&Print'
        OnClick = Print1Click
      end
      object PrinterSetup1: TMenuItem
        Caption = 'Printer &Setup...'
        OnClick = PrinterSetup1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        ShortCut = 32856
        OnClick = Exit1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Options = [ofPathMustExist, ofFileMustExist]
    Left = 96
    Top = 257
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 96
    Top = 313
  end
  object PrintDialog1: TPrintDialog
    Left = 96
    Top = 377
  end
end
