object Form1: TForm1
  Left = 226
  Top = 181
  BorderStyle = bsDialog
  Caption = 'ConvertTo'
  ClientHeight = 211
  ClientWidth = 439
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label13: TLabel
    Left = 3
    Top = 47
    Width = 43
    Height = 13
    Caption = 'Input file:'
  end
  object Label14: TLabel
    Left = 3
    Top = 76
    Width = 48
    Height = 13
    Caption = 'Ouput file:'
  end
  object Label75: TLabel
    Left = 139
    Top = 12
    Width = 140
    Height = 20
    Caption = 'Convert To Demo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 52
    Top = 101
    Width = 291
    Height = 103
    Caption = 'Convert PDF to'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 49
      Height = 13
      Caption = 'Convert to'
    end
    object Label2: TLabel
      Left = 160
      Top = 32
      Width = 35
      Height = 13
      Caption = 'Page #'
    end
    object cbFormat: TComboBox
      Left = 80
      Top = 29
      Width = 57
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        'BMP'
        'JPEG'
        'EMF')
    end
    object chkOpenAfterCreate: TCheckBox
      Left = 16
      Top = 65
      Width = 121
      Height = 17
      Caption = 'Open converted file'
      TabOrder = 1
    end
    object btnConvert: TButton
      Left = 213
      Top = 56
      Width = 75
      Height = 25
      Caption = 'Convert'
      TabOrder = 2
      OnClick = btnConvertClick
    end
    object cbConvertPageno: TComboBox
      Left = 224
      Top = 29
      Width = 57
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
    end
  end
  object edPDFfilename: TEdit
    Left = 58
    Top = 42
    Width = 284
    Height = 21
    TabOrder = 1
  end
  object edSavePDFTo: TEdit
    Left = 58
    Top = 73
    Width = 284
    Height = 21
    TabOrder = 2
    Text = 'C:\Output'
  end
  object btnSaveFileName: TButton
    Left = 348
    Top = 73
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 3
    OnClick = btnSaveFileNameClick
  end
  object btnLoadPDF: TButton
    Left = 347
    Top = 42
    Width = 84
    Height = 25
    Caption = 'Load Document'
    TabOrder = 4
    OnClick = btnLoadPDFClick
  end
  object btnReset: TButton
    Left = 348
    Top = 179
    Width = 84
    Height = 25
    Caption = 'Reset'
    TabOrder = 5
    OnClick = btnResetClick
  end
  object gtPDFDocument1: TgtPDFDocument
    About = 'Gnostice PDFtoolkit (www.gnostice.com)'
    Version = '3.0'
    OpenAfterSave = False
    MergeOptions = []
    EMailAfterSave = False
    ShowSetupDialog = False
    Left = 348
    Top = 99
  end
  object OpenDialog1: TOpenDialog
    Left = 348
    Top = 131
  end
  object SaveDialog1: TSaveDialog
    Left = 384
    Top = 72
  end
end
