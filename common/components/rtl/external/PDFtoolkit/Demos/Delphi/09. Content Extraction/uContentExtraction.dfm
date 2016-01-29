object Form1: TForm1
  Left = 266
  Top = 236
  BorderStyle = bsDialog
  Caption = 'Content Extraction'
  ClientHeight = 217
  ClientWidth = 355
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
    Left = 9
    Top = 51
    Width = 43
    Height = 13
    Caption = 'Input file:'
  end
  object Label75: TLabel
    Left = 110
    Top = 13
    Width = 129
    Height = 16
    Caption = 'Content Extraction '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 7
    Top = 74
    Width = 342
    Height = 111
    Caption = 'Export to text'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 23
      Width = 35
      Height = 13
      Caption = 'Page #'
    end
    object Label2: TLabel
      Left = 8
      Top = 54
      Width = 40
      Height = 13
      Caption = 'Save to '
    end
    object edExtractionSave: TEdit
      Left = 52
      Top = 50
      Width = 253
      Height = 21
      TabOrder = 0
    end
    object btnOpenTxtfile: TButton
      Left = 308
      Top = 50
      Width = 25
      Height = 21
      Caption = '...'
      TabOrder = 1
      OnClick = btnOpenTxtfileClick
    end
    object btnExtractText: TButton
      Left = 258
      Top = 77
      Width = 75
      Height = 25
      Caption = 'Extract text'
      TabOrder = 2
      OnClick = btnExtractTextClick
    end
    object cbExtractPageno: TComboBox
      Left = 52
      Top = 19
      Width = 49
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
    end
  end
  object edPDFfilename: TEdit
    Left = 59
    Top = 46
    Width = 201
    Height = 21
    TabOrder = 1
  end
  object btnLoadPDF: TButton
    Left = 265
    Top = 43
    Width = 84
    Height = 25
    Caption = 'Load document'
    TabOrder = 2
    OnClick = btnLoadPDFClick
  end
  object btnReset: TButton
    Left = 7
    Top = 188
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 3
    OnClick = btnResetClick
  end
  object gtPDFDocument1: TgtPDFDocument
    About = 'Gnostice PDFtoolkit (www.gnostice.com)'
    Version = '3.2'
    OpenAfterSave = False
    MergeOptions = []
    EMailAfterSave = False
    ShowSetupDialog = False
    Left = 307
    Top = 6
  end
  object OpenDialog1: TOpenDialog
    Left = 275
    Top = 8
  end
  object SaveDialog1: TSaveDialog
    Left = 312
    Top = 184
  end
end
