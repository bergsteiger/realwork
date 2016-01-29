object Form1: TForm1
  Left = 219
  Top = 154
  BorderStyle = bsDialog
  Caption = 'Document Properties'
  ClientHeight = 481
  ClientWidth = 577
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
  object Label21: TLabel
    Left = 15
    Top = 47
    Width = 43
    Height = 13
    Caption = 'Input file:'
  end
  object Label22: TLabel
    Left = 15
    Top = 76
    Width = 48
    Height = 13
    Caption = 'Ouput file:'
  end
  object Label75: TLabel
    Left = 197
    Top = 9
    Width = 146
    Height = 16
    Caption = 'Document Properties'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object pgcntrlDocProp: TPageControl
    Left = 5
    Top = 103
    Width = 566
    Height = 347
    ActivePage = tbshPageProp
    TabOrder = 0
    object tbshPageProp: TTabSheet
      Caption = 'Page Properties'
      object gbPageAttrib: TGroupBox
        Left = 5
        Top = 79
        Width = 315
        Height = 133
        Caption = 'Page attributes'
        TabOrder = 0
        object lMediaBox: TLabel
          Left = 11
          Top = 50
          Width = 50
          Height = 13
          Caption = 'Media Box'
        end
        object lCropbox: TLabel
          Left = 11
          Top = 77
          Width = 43
          Height = 13
          Caption = 'Crop Box'
        end
        object lPageNo: TLabel
          Left = 11
          Top = 21
          Width = 35
          Height = 13
          Caption = 'Page #'
        end
        object btnGetMediaNCrop: TButton
          Left = 230
          Top = 20
          Width = 76
          Height = 21
          Caption = 'Get '
          TabOrder = 0
          OnClick = btnGetMediaNCropClick
        end
        object edMediaY: TEdit
          Left = 143
          Top = 47
          Width = 44
          Height = 21
          TabOrder = 1
          Text = '0.0'
        end
        object edMediaX: TEdit
          Left = 84
          Top = 47
          Width = 44
          Height = 21
          TabOrder = 2
          Text = '0.0'
        end
        object edMediaW: TEdit
          Left = 202
          Top = 47
          Width = 44
          Height = 21
          TabOrder = 3
          Text = '0.0'
        end
        object edMediaH: TEdit
          Left = 263
          Top = 47
          Width = 44
          Height = 21
          TabOrder = 4
          Text = '0.0'
        end
        object edCropY: TEdit
          Left = 143
          Top = 74
          Width = 44
          Height = 21
          TabOrder = 5
          Text = '0.0'
        end
        object edCropX: TEdit
          Left = 84
          Top = 74
          Width = 44
          Height = 21
          TabOrder = 6
          Text = '0.0'
        end
        object edCropW: TEdit
          Left = 202
          Top = 74
          Width = 44
          Height = 21
          TabOrder = 7
          Text = '0.0'
        end
        object edCropH: TEdit
          Left = 263
          Top = 74
          Width = 44
          Height = 21
          TabOrder = 8
          Text = '0.0'
        end
        object btnSetCropBox: TButton
          Left = 222
          Top = 103
          Width = 85
          Height = 21
          Caption = 'Set CropBox'
          TabOrder = 9
          OnClick = btnSetCropBoxClick
        end
        object cbCropPageno: TComboBox
          Left = 84
          Top = 19
          Width = 61
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 10
        end
        object btnSetMediaBox: TButton
          Left = 102
          Top = 103
          Width = 85
          Height = 21
          Caption = 'Set MediaBox'
          TabOrder = 11
          OnClick = btnSetMediaBoxClick
        end
      end
      object GroupBox2: TGroupBox
        Left = 5
        Top = 216
        Width = 315
        Height = 106
        Caption = 'Page size'
        TabOrder = 1
        object Label2: TLabel
          Left = 11
          Top = 47
          Width = 56
          Height = 13
          Caption = 'Page Width'
        end
        object Label3: TLabel
          Left = 11
          Top = 77
          Width = 57
          Height = 13
          Caption = 'Page height'
        end
        object Label6: TLabel
          Left = 203
          Top = 21
          Width = 35
          Height = 13
          Caption = 'Page #'
        end
        object Label17: TLabel
          Left = 11
          Top = 20
          Width = 84
          Height = 13
          Caption = 'Measurement unit'
        end
        object edPageWidth: TEdit
          Left = 101
          Top = 45
          Width = 77
          Height = 21
          TabOrder = 0
        end
        object edHeight: TEdit
          Left = 101
          Top = 74
          Width = 77
          Height = 21
          TabOrder = 1
        end
        object btnGetPagesize: TButton
          Left = 232
          Top = 74
          Width = 75
          Height = 21
          Caption = 'Get'
          TabOrder = 2
          OnClick = btnGetPagesizeClick
        end
        object cbPageSizeMeasurement: TComboBox
          Left = 101
          Top = 17
          Width = 77
          Height = 21
          ItemHeight = 13
          TabOrder = 3
          Text = 'Pixels'
          Items.Strings = (
            'Pixels'
            'Points'
            'Inches'
            'MM'
            'Twips')
        end
        object cbPageSizePgeNo: TComboBox
          Left = 251
          Top = 17
          Width = 56
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 4
        end
      end
      object GroupBox1: TGroupBox
        Left = 327
        Top = 2
        Width = 220
        Height = 73
        Caption = 'Set page rotation'
        TabOrder = 2
        object Label4: TLabel
          Left = 12
          Top = 20
          Width = 35
          Height = 13
          Caption = 'Page #'
        end
        object Label5: TLabel
          Left = 12
          Top = 45
          Width = 27
          Height = 13
          Caption = 'Angle'
        end
        object btnSetPageRotate: TButton
          Left = 141
          Top = 44
          Width = 75
          Height = 21
          Caption = 'Set'
          TabOrder = 0
          OnClick = btnSetPageRotateClick
        end
        object cbRotateAngle: TComboBox
          Left = 60
          Top = 44
          Width = 72
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          Items.Strings = (
            'ra0'
            'raCW90'
            'raCW180'
            'raCW270'
            'raACW90'
            'raACW180'
            'raACW270')
        end
        object cbSetPageRotPageNo: TComboBox
          Left = 60
          Top = 17
          Width = 72
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
        end
      end
      object GroupBox4: TGroupBox
        Left = 5
        Top = 2
        Width = 315
        Height = 73
        Caption = '# of Pages and version'
        TabOrder = 3
        object Label1: TLabel
          Left = 11
          Top = 20
          Width = 56
          Height = 13
          Caption = 'Total pages'
        end
        object Label15: TLabel
          Left = 11
          Top = 45
          Width = 59
          Height = 13
          Caption = 'PDF Version'
        end
        object edTotalPage: TEdit
          Left = 84
          Top = 17
          Width = 61
          Height = 21
          TabOrder = 0
        end
        object edPDFversion: TEdit
          Left = 84
          Top = 44
          Width = 61
          Height = 21
          TabOrder = 1
        end
      end
      object GroupBox8: TGroupBox
        Left = 327
        Top = 79
        Width = 220
        Height = 77
        Caption = 'Get page rotation'
        TabOrder = 4
        object Label18: TLabel
          Left = 12
          Top = 21
          Width = 35
          Height = 13
          Caption = 'Page #'
        end
        object Label19: TLabel
          Left = 12
          Top = 50
          Width = 27
          Height = 13
          Caption = 'Angle'
        end
        object edAngle: TEdit
          Left = 60
          Top = 47
          Width = 72
          Height = 21
          TabOrder = 0
        end
        object btnPagerotate: TButton
          Left = 141
          Top = 47
          Width = 75
          Height = 21
          Caption = 'Get'
          TabOrder = 1
          OnClick = btnPagerotateClick
        end
        object cbGetRotatePageNo: TComboBox
          Left = 60
          Top = 19
          Width = 72
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
        end
      end
    end
    object tbshDocInfo: TTabSheet
      Caption = 'Document Info'
      ImageIndex = 1
      object GroupBox3: TGroupBox
        Left = 6
        Top = 5
        Width = 539
        Height = 249
        Caption = 'Document info'
        TabOrder = 0
        object Label7: TLabel
          Left = 16
          Top = 24
          Width = 31
          Height = 13
          Caption = 'Author'
        end
        object Label8: TLabel
          Left = 16
          Top = 48
          Width = 43
          Height = 13
          Caption = 'Producer'
        end
        object Label9: TLabel
          Left = 16
          Top = 69
          Width = 34
          Height = 13
          Caption = 'Creator'
        end
        object Label10: TLabel
          Left = 16
          Top = 94
          Width = 57
          Height = 13
          Caption = 'Create Date'
        end
        object Label11: TLabel
          Left = 16
          Top = 117
          Width = 47
          Height = 13
          Caption = 'Mod Date'
        end
        object Label12: TLabel
          Left = 16
          Top = 141
          Width = 20
          Height = 13
          Caption = 'Title'
        end
        object Label13: TLabel
          Left = 16
          Top = 165
          Width = 36
          Height = 13
          Caption = 'Subject'
        end
        object Label14: TLabel
          Left = 16
          Top = 189
          Width = 41
          Height = 13
          Caption = 'Keyword'
        end
        object edAuthor: TEdit
          Left = 84
          Top = 18
          Width = 444
          Height = 21
          TabOrder = 0
        end
        object edProducer: TEdit
          Left = 84
          Top = 43
          Width = 444
          Height = 21
          ReadOnly = True
          TabOrder = 1
        end
        object edCreator: TEdit
          Left = 84
          Top = 67
          Width = 444
          Height = 21
          ReadOnly = True
          TabOrder = 2
        end
        object edCreateDate: TEdit
          Left = 84
          Top = 91
          Width = 444
          Height = 21
          ReadOnly = True
          TabOrder = 3
        end
        object edModDate: TEdit
          Left = 84
          Top = 116
          Width = 444
          Height = 21
          ReadOnly = True
          TabOrder = 4
        end
        object EdTitle: TEdit
          Left = 84
          Top = 140
          Width = 444
          Height = 21
          TabOrder = 5
        end
        object edSubject: TEdit
          Left = 84
          Top = 164
          Width = 444
          Height = 21
          TabOrder = 6
        end
        object edKeyword: TEdit
          Left = 84
          Top = 188
          Width = 444
          Height = 21
          TabOrder = 7
        end
        object btnGetinfo: TButton
          Left = 372
          Top = 217
          Width = 75
          Height = 22
          Caption = 'Get info'
          TabOrder = 8
          OnClick = btnGetinfoClick
        end
        object btnSetInfo: TButton
          Left = 453
          Top = 217
          Width = 75
          Height = 22
          Caption = 'Set info'
          TabOrder = 9
          OnClick = btnSetInfoClick
        end
      end
    end
    object tbshOthers: TTabSheet
      Caption = 'Others'
      ImageIndex = 2
      object GroupBox14: TGroupBox
        Left = 5
        Top = 173
        Width = 250
        Height = 147
        Caption = 'Page transition effect'
        TabOrder = 0
        object Label133: TLabel
          Left = 9
          Top = 25
          Width = 76
          Height = 13
          Caption = 'Transition effect'
        end
        object Label134: TLabel
          Left = 9
          Top = 54
          Width = 55
          Height = 13
          Caption = 'Page range'
        end
        object Label135: TLabel
          Left = 9
          Top = 81
          Width = 40
          Height = 13
          Caption = 'Duration'
        end
        object Label20: TLabel
          Left = 183
          Top = 54
          Width = 51
          Height = 13
          Caption = 'Ex: 2-6,4,8'
        end
        object btnSetPageTransition: TButton
          Left = 128
          Top = 111
          Width = 113
          Height = 25
          Caption = 'Set transition effect'
          TabOrder = 0
          OnClick = btnSetPageTransitionClick
        end
        object cbTransitionEffect: TComboBox
          Left = 96
          Top = 21
          Width = 142
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          Items.Strings = (
            'teNone'
            'teSplitHorizontalInward'
            'teSplitHorizontalOutward'
            'teSplitVerticalInward'
            'teSplitVerticalOutward'
            'teBlindsHorizontal'
            'teBlindsVertical'
            'teBoxInward'
            'teBoxOutward'
            'teWipeLeftToRight '
            'teWipeBottomToTop'
            'teWipeRightToLeft '
            'teWipeTopToBottom '
            'teDissolve'
            'teGlitterLeftToRight '
            'teGlitterTopToBottom'
            'teGlitterTopLeftToBottomRight')
        end
        object edPageTranRange: TEdit
          Left = 96
          Top = 52
          Width = 81
          Height = 21
          TabOrder = 2
        end
        object edTransDuration: TEdit
          Left = 96
          Top = 81
          Width = 81
          Height = 21
          TabOrder = 3
        end
      end
      object GroupBox5: TGroupBox
        Left = 5
        Top = 4
        Width = 541
        Height = 166
        Caption = 'XML metadata'
        TabOrder = 1
        object mmXMLMetadata: TMemo
          Left = 9
          Top = 16
          Width = 523
          Height = 119
          Lines.Strings = (
            '')
          TabOrder = 0
        end
        object btnXMLMatadata: TButton
          Left = 458
          Top = 137
          Width = 75
          Height = 25
          Caption = 'Get'
          TabOrder = 1
          OnClick = btnXMLMatadataClick
        end
      end
      object GroupBox6: TGroupBox
        Left = 261
        Top = 173
        Width = 285
        Height = 85
        Caption = 'Page presentation'
        TabOrder = 2
        object Label16: TLabel
          Left = 12
          Top = 25
          Width = 54
          Height = 13
          Caption = 'Page mode'
        end
        object labelPageAlyout: TLabel
          Left = 12
          Top = 54
          Width = 56
          Height = 13
          Caption = 'Page layout'
        end
        object cbPagemode: TComboBox
          Left = 80
          Top = 21
          Width = 113
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          Items.Strings = (
            'pmNone'
            'pmUseOutlines'
            'pmUseThumbs'
            'pmFullScreen'
            'pmUseAttachments')
        end
        object cbPageLayout: TComboBox
          Left = 80
          Top = 52
          Width = 113
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          Items.Strings = (
            'plNone'
            'plSinglePage'
            'plOneColumn'
            'plTwoColumnLeft'
            'plTwoColumnRight')
        end
        object btnSetPageModeLayout: TButton
          Left = 202
          Top = 52
          Width = 75
          Height = 25
          Caption = 'Set'
          TabOrder = 2
          OnClick = btnSetPageModeLayoutClick
        end
      end
    end
    object tbshViewerPref: TTabSheet
      Caption = 'Viewer Preference'
      ImageIndex = 3
      object GroupBox7: TGroupBox
        Left = 5
        Top = 4
        Width = 150
        Height = 237
        Caption = 'Viewer preference'
        TabOrder = 0
        object chkHideToolbar: TCheckBox
          Left = 16
          Top = 24
          Width = 97
          Height = 17
          Caption = 'HideToolbar'
          TabOrder = 0
        end
        object chkHideMenubar: TCheckBox
          Left = 16
          Top = 52
          Width = 97
          Height = 17
          Caption = 'HideMenubar'
          TabOrder = 1
        end
        object chkHideWindowUI: TCheckBox
          Left = 16
          Top = 81
          Width = 97
          Height = 17
          Caption = 'HideWindowUI'
          TabOrder = 2
        end
        object chkFitWindow: TCheckBox
          Left = 16
          Top = 111
          Width = 97
          Height = 17
          Caption = 'FitWindow'
          TabOrder = 3
        end
        object chkCenterWindow: TCheckBox
          Left = 16
          Top = 140
          Width = 97
          Height = 17
          Caption = 'CenterWindow'
          TabOrder = 4
        end
        object chkDisplayDocTitle: TCheckBox
          Left = 16
          Top = 169
          Width = 97
          Height = 17
          Caption = 'DisplayDocTitle'
          TabOrder = 5
        end
        object btnSetViewerPref: TButton
          Left = 67
          Top = 203
          Width = 75
          Height = 25
          Caption = 'Set'
          TabOrder = 6
          OnClick = btnSetViewerPrefClick
        end
      end
    end
  end
  object edPDFfilename: TEdit
    Left = 85
    Top = 42
    Width = 284
    Height = 21
    TabOrder = 1
  end
  object edSavePDFTo: TEdit
    Left = 85
    Top = 73
    Width = 284
    Height = 21
    TabOrder = 2
    Text = 'C:\Output.pdf'
  end
  object btnSaveFileName: TButton
    Left = 376
    Top = 73
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 3
    OnClick = btnSaveFileNameClick
  end
  object btnLoadPDF: TButton
    Left = 377
    Top = 39
    Width = 89
    Height = 25
    Caption = 'Load document'
    TabOrder = 4
    OnClick = btnLoadPDFClick
  end
  object btnSave: TButton
    Left = 496
    Top = 452
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 5
    OnClick = btnSaveClick
  end
  object cbOpenAfterCreate: TCheckBox
    Left = 378
    Top = 456
    Width = 114
    Height = 17
    Caption = 'Open After Create'
    TabOrder = 6
  end
  object btnReset: TButton
    Left = 5
    Top = 453
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
    Left = 516
    Top = 35
  end
  object OpenDialog1: TOpenDialog
    Left = 484
    Top = 35
  end
  object SaveDialog1: TSaveDialog
    Left = 488
    Top = 64
  end
end
