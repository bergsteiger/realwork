object Form1: TForm1
  Left = 192
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Add Thumbnail'
  ClientHeight = 306
  ClientWidth = 460
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
    Left = 6
    Top = 44
    Width = 43
    Height = 13
    Caption = 'Input file:'
  end
  object Label75: TLabel
    Left = 153
    Top = 8
    Width = 150
    Height = 16
    Caption = 'Add Thumbnail Demo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label14: TLabel
    Left = 6
    Top = 80
    Width = 48
    Height = 13
    Caption = 'Ouput file:'
  end
  object edPDFfilename: TEdit
    Left = 76
    Top = 39
    Width = 284
    Height = 21
    TabOrder = 0
  end
  object btnLoadPDF: TButton
    Left = 366
    Top = 36
    Width = 89
    Height = 25
    Caption = 'Load document'
    TabOrder = 1
    OnClick = btnLoadPDFClick
  end
  object edSavePDFTo: TEdit
    Left = 76
    Top = 77
    Width = 284
    Height = 21
    TabOrder = 2
    Text = 'C:\Output.pdf'
  end
  object btnSaveFileName: TButton
    Left = 365
    Top = 77
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 3
    OnClick = btnSaveFileNameClick
  end
  object btnSave: TButton
    Left = 380
    Top = 277
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 4
    OnClick = btnSaveClick
  end
  object pgncntrlEnhancement: TPageControl
    Left = 6
    Top = 111
    Width = 449
    Height = 162
    ActivePage = tbshThumbnail
    TabOrder = 5
    object tbshBookMark: TTabSheet
      Caption = 'BookMark'
      ImageIndex = 1
      TabVisible = False
    end
    object tbshThumbnail: TTabSheet
      Caption = 'Thumbnail'
      ImageIndex = 2
      object GroupBox11: TGroupBox
        Left = 5
        Top = 4
        Width = 436
        Height = 110
        Caption = 'Thumbnail'
        TabOrder = 0
        object Label28: TLabel
          Left = 13
          Top = 28
          Width = 29
          Height = 13
          Caption = 'Image'
        end
        object Label29: TLabel
          Left = 13
          Top = 56
          Width = 35
          Height = 13
          Caption = 'Page #'
        end
        object btnAddthumbnail: TButton
          Left = 339
          Top = 77
          Width = 90
          Height = 25
          Caption = 'Add thumbnail'
          TabOrder = 0
          OnClick = btnAddthumbnailClick
        end
        object edImageName: TEdit
          Left = 64
          Top = 24
          Width = 337
          Height = 21
          TabOrder = 1
          Text = 'BMP or JPEG'
        end
        object btnOpenImage: TButton
          Left = 409
          Top = 24
          Width = 19
          Height = 21
          Caption = '...'
          TabOrder = 2
          OnClick = btnOpenImageClick
        end
        object cbThumbPageNo: TComboBox
          Left = 64
          Top = 53
          Width = 57
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 3
        end
      end
    end
  end
  object btnReset: TButton
    Left = 5
    Top = 277
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 6
    OnClick = btnResetClick
  end
  object cbOpenAfterCreate: TCheckBox
    Left = 263
    Top = 282
    Width = 114
    Height = 17
    Caption = 'Open After Create'
    TabOrder = 7
  end
  object gtPDFDocument1: TgtPDFDocument
    About = 'Gnostice PDFtoolkit (www.gnostice.com)'
    Version = '3.0'
    OpenAfterSave = False
    MergeOptions = []
    EMailAfterSave = False
    ShowSetupDialog = False
    Left = 403
    Top = 72
  end
  object OpenDialog1: TOpenDialog
    Left = 427
    Top = 72
  end
  object SaveDialog1: TSaveDialog
    Left = 416
    Top = 8
  end
end
