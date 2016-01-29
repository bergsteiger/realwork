object Form1: TForm1
  Left = 207
  Top = 118
  BorderStyle = bsDialog
  Caption = 'Page Operations'
  ClientHeight = 454
  ClientWidth = 572
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
    Left = 11
    Top = 47
    Width = 43
    Height = 13
    Caption = 'Input file:'
  end
  object Label75: TLabel
    Left = 169
    Top = 8
    Width = 166
    Height = 16
    Caption = 'Merge/Split/Reorganize'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label14: TLabel
    Left = 11
    Top = 83
    Width = 48
    Height = 13
    Caption = 'Ouput file:'
  end
  object pgeCntrlMergeSplit: TPageControl
    Left = 5
    Top = 108
    Width = 562
    Height = 314
    ActivePage = tbshMerge
    TabOrder = 0
    object tbshMerge: TTabSheet
      Caption = 'Merge'
      OnShow = tbshMergeShow
      object GroupBox8: TGroupBox
        Left = 6
        Top = 9
        Width = 406
        Height = 123
        Caption = 'Merge documents'
        TabOrder = 0
        object Label23: TLabel
          Left = 11
          Top = 24
          Width = 51
          Height = 13
          Caption = 'Input file(s)'
        end
        object Label10: TLabel
          Left = 11
          Top = 59
          Width = 48
          Height = 13
          Caption = 'Output file'
        end
        object btnMergeOpen1: TButton
          Left = 370
          Top = 24
          Width = 25
          Height = 22
          Caption = '...'
          TabOrder = 0
          OnClick = btnMergeOpen1Click
        end
        object btnMerge: TButton
          Left = 296
          Top = 86
          Width = 99
          Height = 25
          Caption = 'Merge and Save'
          TabOrder = 1
          OnClick = btnMergeClick
        end
        object edMerge1: TEdit
          Left = 70
          Top = 24
          Width = 291
          Height = 21
          TabOrder = 2
        end
        object edMergeoutfile: TEdit
          Left = 70
          Top = 56
          Width = 291
          Height = 21
          TabOrder = 3
        end
        object btnMergeSave: TButton
          Left = 370
          Top = 56
          Width = 25
          Height = 21
          Caption = '...'
          TabOrder = 4
          OnClick = btnMergeSaveClick
        end
      end
    end
    object tbshSplit: TTabSheet
      Caption = 'Split'
      ImageIndex = 1
      OnShow = tbshSplitShow
      object GroupBox9: TGroupBox
        Left = 6
        Top = 5
        Width = 363
        Height = 100
        Caption = 'Split'
        TabOrder = 0
        object Label21: TLabel
          Left = 13
          Top = 18
          Width = 45
          Height = 13
          Caption = 'Extract to'
        end
        object Label22: TLabel
          Left = 13
          Top = 47
          Width = 55
          Height = 13
          Caption = 'Page range'
        end
        object Label9: TLabel
          Left = 160
          Top = 47
          Width = 51
          Height = 13
          Caption = 'Ex: 2-6,4,8'
        end
        object edExtractPages: TEdit
          Left = 73
          Top = 17
          Width = 240
          Height = 21
          TabOrder = 0
        end
        object edExtractPageRange: TEdit
          Left = 73
          Top = 45
          Width = 80
          Height = 21
          TabOrder = 1
          Text = '1'
        end
        object btnExtract: TButton
          Left = 278
          Top = 66
          Width = 75
          Height = 25
          Caption = 'Extract'
          TabOrder = 2
          OnClick = btnExtractClick
        end
        object btnSplitSave: TButton
          Left = 320
          Top = 15
          Width = 33
          Height = 25
          Caption = '...'
          TabOrder = 3
          OnClick = btnSplitSaveClick
        end
      end
    end
    object tbshReorganize: TTabSheet
      Caption = 'Reorganize'
      ImageIndex = 2
      OnShow = tbshReorganizeShow
      object GroupBox6: TGroupBox
        Left = 5
        Top = 3
        Width = 316
        Height = 80
        Caption = 'Delete pages'
        TabOrder = 0
        object Label19: TLabel
          Left = 13
          Top = 19
          Width = 55
          Height = 13
          Caption = 'Page range'
        end
        object Label6: TLabel
          Left = 248
          Top = 20
          Width = 51
          Height = 13
          Caption = 'Ex: 2-6,4,8'
        end
        object edDeletePageRange: TEdit
          Left = 81
          Top = 17
          Width = 136
          Height = 21
          TabOrder = 0
        end
        object btnDelete: TButton
          Left = 232
          Top = 47
          Width = 75
          Height = 25
          Caption = 'Delete'
          TabOrder = 1
          OnClick = btnDeleteClick
        end
      end
      object GroupBox5: TGroupBox
        Left = 5
        Top = 89
        Width = 318
        Height = 81
        Caption = 'Append Pages'
        TabOrder = 1
        object Label1: TLabel
          Left = 11
          Top = 22
          Width = 63
          Height = 13
          Caption = 'Append From'
        end
        object Label15: TLabel
          Left = 11
          Top = 50
          Width = 60
          Height = 13
          Caption = 'Page Range'
        end
        object edAppendFromFile: TEdit
          Left = 81
          Top = 19
          Width = 192
          Height = 21
          TabOrder = 0
        end
        object edAppendPageRange: TEdit
          Left = 81
          Top = 48
          Width = 80
          Height = 21
          TabOrder = 1
        end
        object btnAppendOpen: TButton
          Left = 281
          Top = 19
          Width = 28
          Height = 21
          Caption = '...'
          TabOrder = 2
          OnClick = btnAppendOpenClick
        end
        object btnAppendPage: TButton
          Left = 234
          Top = 48
          Width = 75
          Height = 25
          Caption = 'Append'
          TabOrder = 3
          OnClick = btnAppendPageClick
        end
      end
      object GroupBox7: TGroupBox
        Left = 5
        Top = 176
        Width = 318
        Height = 100
        Caption = 'Insert Pages'
        TabOrder = 2
        object Label16: TLabel
          Left = 11
          Top = 18
          Width = 49
          Height = 13
          Caption = 'Insert from'
        end
        object Label17: TLabel
          Left = 11
          Top = 47
          Width = 60
          Height = 13
          Caption = 'Page Range'
        end
        object Label18: TLabel
          Left = 11
          Top = 74
          Width = 47
          Height = 13
          Caption = 'AfterPage'
        end
        object edInsertFrom: TEdit
          Left = 81
          Top = 17
          Width = 192
          Height = 21
          TabOrder = 0
        end
        object edInsertPageRange: TEdit
          Left = 81
          Top = 45
          Width = 80
          Height = 21
          TabOrder = 1
        end
        object edInsertAfterPage: TEdit
          Left = 81
          Top = 72
          Width = 80
          Height = 21
          TabOrder = 2
        end
        object btnInsertOpen: TButton
          Left = 281
          Top = 17
          Width = 28
          Height = 21
          Caption = '...'
          TabOrder = 3
          OnClick = btnInsertOpenClick
        end
        object btnInSertPage: TButton
          Left = 234
          Top = 67
          Width = 75
          Height = 25
          Caption = 'Insert '
          TabOrder = 4
          OnClick = btnInSertPageClick
        end
      end
    end
    object tbshOther: TTabSheet
      Caption = 'Others'
      ImageIndex = 3
      OnShow = tbshOtherShow
      object GroupBox2: TGroupBox
        Left = 7
        Top = 5
        Width = 221
        Height = 119
        Caption = 'Stitch pages'
        TabOrder = 0
        object Label2: TLabel
          Left = 12
          Top = 24
          Width = 64
          Height = 13
          Caption = 'Stitch page #'
        end
        object Label3: TLabel
          Left = 12
          Top = 52
          Width = 50
          Height = 13
          Caption = 'To page #'
        end
        object edStitchPage: TEdit
          Left = 83
          Top = 21
          Width = 70
          Height = 21
          TabOrder = 0
        end
        object edSticthToPage: TEdit
          Left = 83
          Top = 51
          Width = 70
          Height = 21
          TabOrder = 1
        end
        object btnStitchPage: TButton
          Left = 12
          Top = 85
          Width = 75
          Height = 21
          Caption = 'Stitch'
          TabOrder = 2
          OnClick = btnStitchPageClick
        end
        object btnStitchPageSideBySide: TButton
          Left = 96
          Top = 85
          Width = 115
          Height = 21
          Caption = 'Stitch side by side'
          TabOrder = 3
          OnClick = btnStitchPageSideBySideClick
        end
      end
    end
  end
  object edPDFfilename: TEdit
    Left = 81
    Top = 42
    Width = 284
    Height = 21
    TabOrder = 1
  end
  object btnLoadPDF: TButton
    Left = 373
    Top = 39
    Width = 89
    Height = 25
    Caption = 'Load document'
    TabOrder = 2
    OnClick = btnLoadPDFClick
  end
  object edSavePDFTo: TEdit
    Left = 81
    Top = 80
    Width = 284
    Height = 21
    TabOrder = 3
    Text = 'C:\Output.pdf'
  end
  object btnSaveFileName: TButton
    Left = 372
    Top = 80
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 4
    OnClick = btnSaveFileNameClick
  end
  object btnSave: TButton
    Left = 492
    Top = 425
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 5
    OnClick = btnSaveClick
  end
  object cbOpenAfterCreate: TCheckBox
    Left = 379
    Top = 430
    Width = 114
    Height = 17
    Caption = 'Open After Create'
    TabOrder = 6
  end
  object btnReset: TButton
    Left = 9
    Top = 425
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 7
    OnClick = btnResetClick
  end
  object gtPDFDocument1: TgtPDFDocument
    About = 'Gnostice PDFtoolkit (www.gnostice.com)'
    Version = '3.0'
    OpenAfterSave = False
    MergeOptions = []
    EMailAfterSave = False
    ShowSetupDialog = False
    Left = 512
    Top = 35
  end
  object OpenDialog1: TOpenDialog
    Left = 480
    Top = 35
  end
  object SaveDialog1: TSaveDialog
    Left = 480
    Top = 64
  end
end
