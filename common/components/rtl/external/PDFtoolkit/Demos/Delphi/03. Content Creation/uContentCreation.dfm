object Form1: TForm1
  Left = 221
  Top = 129
  BorderStyle = bsDialog
  Caption = 'Content Creation'
  ClientHeight = 492
  ClientWidth = 568
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label13: TLabel
    Left = 18
    Top = 47
    Width = 43
    Height = 13
    Caption = 'Input file:'
  end
  object Label14: TLabel
    Left = 18
    Top = 76
    Width = 48
    Height = 13
    Caption = 'Ouput file:'
  end
  object Label15: TLabel
    Left = 197
    Top = 11
    Width = 115
    Height = 16
    Alignment = taCenter
    Anchors = [akLeft, akRight]
    Caption = 'Content Creation'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object pgcntrlContentCreation: TPageControl
    Left = 3
    Top = 99
    Width = 561
    Height = 361
    ActivePage = tbchcontCreationMaskNTexout
    TabOrder = 5
    OnChange = pgcntrlContentCreationChange
    object tbchcontCreationMaskNTexout: TTabSheet
      Caption = 'Insert blank page'
      object GroupBox1: TGroupBox
        Left = 3
        Top = 0
        Width = 224
        Height = 135
        Caption = 'Insert blank page'
        TabOrder = 0
        object Label1: TLabel
          Left = 11
          Top = 22
          Width = 104
          Height = 13
          Caption = 'Insert page at position'
        end
        object Label2: TLabel
          Left = 12
          Top = 52
          Width = 53
          Height = 13
          Caption = 'Page width'
        end
        object Label3: TLabel
          Left = 11
          Top = 81
          Width = 57
          Height = 13
          Caption = 'Page height'
        end
        object Label162: TLabel
          Left = 10
          Top = 109
          Width = 19
          Height = 13
          Caption = 'Unit'
        end
        object edInsertBlankPage: TEdit
          Left = 138
          Top = 19
          Width = 75
          Height = 21
          TabOrder = 0
        end
        object btnInsertBlankPage: TButton
          Left = 139
          Top = 104
          Width = 75
          Height = 25
          Caption = 'Insert'
          TabOrder = 1
          OnClick = btnInsertBlankPageClick
        end
        object edPageWidth: TEdit
          Left = 138
          Top = 49
          Width = 75
          Height = 21
          TabOrder = 2
        end
        object edPageHeight: TEdit
          Left = 138
          Top = 78
          Width = 75
          Height = 21
          TabOrder = 3
        end
        object cbBlankMeasure: TComboBox
          Left = 36
          Top = 106
          Width = 62
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 4
          Items.Strings = (
            'Pixels'
            'Points'
            'Inches'
            'MM'
            'Twips')
        end
      end
    end
    object tbshFileAttachment: TTabSheet
      Caption = 'Mask, Textout and others'
      ImageIndex = 1
      object Label10: TLabel
        Left = 218
        Top = 295
        Width = 9
        Height = 13
        Caption = '<-'
      end
      object GroupBox12: TGroupBox
        Left = 236
        Top = 0
        Width = 312
        Height = 134
        Caption = 'Mask an area on the PDF'
        TabOrder = 0
        object Label30: TLabel
          Left = 11
          Top = 78
          Width = 23
          Height = 13
          Caption = 'Rect'
        end
        object Label32: TLabel
          Left = 11
          Top = 21
          Width = 35
          Height = 13
          Caption = 'Page #'
        end
        object Label31: TLabel
          Left = 63
          Top = 78
          Width = 6
          Height = 13
          Caption = 'L'
        end
        object Label33: TLabel
          Left = 188
          Top = 78
          Width = 8
          Height = 13
          Caption = 'R'
        end
        object Label34: TLabel
          Left = 247
          Top = 78
          Width = 7
          Height = 13
          Caption = 'B'
        end
        object Label35: TLabel
          Left = 123
          Top = 78
          Width = 7
          Height = 13
          Caption = 'T'
        end
        object Label36: TLabel
          Left = 11
          Top = 50
          Width = 24
          Height = 13
          Caption = 'Color'
        end
        object edMasKTop: TEdit
          Left = 135
          Top = 76
          Width = 44
          Height = 21
          TabOrder = 0
          Text = '0'
        end
        object edMasKLeft: TEdit
          Left = 73
          Top = 76
          Width = 44
          Height = 21
          TabOrder = 1
          Text = '0'
        end
        object edMasKRight: TEdit
          Left = 198
          Top = 76
          Width = 44
          Height = 21
          TabOrder = 2
          Text = '0'
        end
        object edMasKBottom: TEdit
          Left = 258
          Top = 76
          Width = 44
          Height = 21
          TabOrder = 3
          Text = '0'
        end
        object btnMaskRect: TButton
          Left = 227
          Top = 103
          Width = 75
          Height = 25
          Caption = 'Mask'
          TabOrder = 4
          OnClick = btnMaskRectClick
        end
        object cbMaskPageno: TComboBox
          Left = 73
          Top = 17
          Width = 56
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 5
        end
      end
      object GroupBox10: TGroupBox
        Left = 7
        Top = 0
        Width = 223
        Height = 134
        Caption = 'Add custom info'
        TabOrder = 1
        object Label25: TLabel
          Left = 13
          Top = 25
          Width = 28
          Height = 13
          Caption = 'Name'
        end
        object Label26: TLabel
          Left = 13
          Top = 51
          Width = 27
          Height = 13
          Caption = 'Value'
        end
        object Label27: TLabel
          Left = 13
          Top = 80
          Width = 39
          Height = 13
          Caption = 'Schema'
        end
        object btnAddCstInfo: TButton
          Left = 116
          Top = 103
          Width = 97
          Height = 25
          Caption = 'Add custom info'
          TabOrder = 0
          OnClick = btnAddCstInfoClick
        end
        object edDocName: TEdit
          Left = 64
          Top = 21
          Width = 149
          Height = 21
          TabOrder = 1
        end
        object edDocValue: TEdit
          Left = 64
          Top = 48
          Width = 149
          Height = 21
          TabOrder = 2
        end
        object cbSchema: TComboBox
          Left = 64
          Top = 77
          Width = 149
          Height = 21
          ItemHeight = 13
          TabOrder = 3
          Text = 'scAdobePDF'
          Items.Strings = (
            'scAdobePDF'
            'scBasic'
            'scDublinCore'
            'scJobTicket'
            'scRightsManagement'
            'scPagedText')
        end
      end
      object GroupBox2: TGroupBox
        Left = 7
        Top = 137
        Width = 541
        Height = 184
        Caption = 'HTML Textout'
        TabOrder = 2
        object Label82: TLabel
          Left = 9
          Top = 132
          Width = 7
          Height = 13
          Caption = 'X'
        end
        object Label83: TLabel
          Left = 121
          Top = 132
          Width = 7
          Height = 13
          Caption = 'Y'
        end
        object Label85: TLabel
          Left = 9
          Top = 159
          Width = 30
          Height = 13
          Caption = 'Pages'
        end
        object Label9: TLabel
          Left = 121
          Top = 160
          Width = 51
          Height = 13
          Caption = 'Ex: 2-6,4,8'
        end
        object Label11: TLabel
          Left = 295
          Top = 128
          Width = 205
          Height = 42
          AutoSize = False
          Caption = 
            'The HTML tags supported are <B>, <I>, <Font>, <Strikeout> and <U' +
            '>'
          WordWrap = True
        end
        object Label12: TLabel
          Left = 214
          Top = 161
          Width = 84
          Height = 13
          Caption = 'Measurement unit'
        end
        object mmHTMLText: TMemo
          Left = 9
          Top = 17
          Width = 522
          Height = 105
          Lines.Strings = (
            '')
          TabOrder = 0
        end
        object edHTMLX: TEdit
          Left = 44
          Top = 128
          Width = 68
          Height = 21
          TabOrder = 1
        end
        object edHTMLY: TEdit
          Left = 137
          Top = 128
          Width = 68
          Height = 21
          TabOrder = 2
        end
        object edHTMLPages: TEdit
          Left = 44
          Top = 156
          Width = 68
          Height = 21
          TabOrder = 3
        end
        object btnTextout: TButton
          Left = 456
          Top = 153
          Width = 75
          Height = 25
          Caption = 'Text out'
          TabOrder = 4
          OnClick = btnTextoutClick
        end
        object cmHTMLMeasure: TComboBox
          Left = 308
          Top = 157
          Width = 62
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 5
          Items.Strings = (
            'Pixels'
            'Points'
            'Inches'
            'MM'
            'Twips')
        end
      end
      object btnSelectColor: TButton
        Left = 309
        Top = 45
        Width = 67
        Height = 25
        Caption = 'Select Color'
        TabOrder = 3
        OnClick = btnSelectColorClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'File attachment'
      ImageIndex = 2
      object GroupBox13: TGroupBox
        Left = 5
        Top = 4
        Width = 356
        Height = 218
        Caption = 'File attachment'
        TabOrder = 0
        object Label37: TLabel
          Left = 11
          Top = 28
          Width = 45
          Height = 13
          Caption = 'File name'
        end
        object Label38: TLabel
          Left = 11
          Top = 51
          Width = 28
          Height = 13
          Caption = 'Name'
        end
        object Label39: TLabel
          Left = 11
          Top = 76
          Width = 21
          Height = 13
          Caption = 'Icon'
        end
        object Label4: TLabel
          Left = 11
          Top = 103
          Width = 35
          Height = 13
          Caption = 'Page #'
        end
        object Label5: TLabel
          Left = 11
          Top = 132
          Width = 18
          Height = 13
          Caption = 'Left'
        end
        object Label6: TLabel
          Left = 121
          Top = 132
          Width = 19
          Height = 13
          Caption = 'Top'
        end
        object Label7: TLabel
          Left = 11
          Top = 156
          Width = 25
          Height = 13
          Caption = 'Right'
        end
        object Label8: TLabel
          Left = 121
          Top = 156
          Width = 33
          Height = 13
          Caption = 'Bottom'
        end
        object btnFileAttach: TButton
          Left = 271
          Top = 180
          Width = 75
          Height = 25
          Caption = 'Attach'
          TabOrder = 0
          OnClick = btnFileAttachClick
        end
        object edFileAttach: TEdit
          Left = 59
          Top = 24
          Width = 256
          Height = 21
          TabOrder = 1
        end
        object btnattachOpn: TButton
          Left = 321
          Top = 24
          Width = 25
          Height = 22
          Caption = '...'
          TabOrder = 2
          OnClick = btnattachOpnClick
        end
        object edAttachName: TEdit
          Left = 59
          Top = 50
          Width = 121
          Height = 21
          TabOrder = 3
        end
        object cbattachIcon: TComboBox
          Left = 59
          Top = 76
          Width = 72
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 4
          Items.Strings = (
            'faGraph'
            'faPaperclip'
            'faPushPin'
            'faTag')
        end
        object edAttachLeft: TEdit
          Left = 58
          Top = 127
          Width = 49
          Height = 21
          TabOrder = 5
        end
        object edAttachTop: TEdit
          Left = 165
          Top = 128
          Width = 49
          Height = 21
          TabOrder = 6
        end
        object edAttachright: TEdit
          Left = 58
          Top = 153
          Width = 49
          Height = 21
          TabOrder = 7
        end
        object edAttachBottom: TEdit
          Left = 165
          Top = 153
          Width = 49
          Height = 21
          TabOrder = 8
        end
        object cbAttachmentPageno: TComboBox
          Left = 59
          Top = 102
          Width = 48
          Height = 21
          Style = csDropDownList
          ItemHeight = 0
          TabOrder = 9
        end
      end
    end
  end
  object edPDFfilename: TEdit
    Left = 88
    Top = 42
    Width = 284
    Height = 21
    TabOrder = 0
  end
  object edSavePDFTo: TEdit
    Left = 88
    Top = 73
    Width = 284
    Height = 21
    TabOrder = 1
    Text = 'C:\Output.pdf'
  end
  object btnSaveFileName: TButton
    Left = 379
    Top = 73
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 2
    OnClick = btnSaveFileNameClick
  end
  object btnLoadPDF: TButton
    Left = 380
    Top = 39
    Width = 89
    Height = 25
    Caption = 'Load document'
    TabOrder = 3
    OnClick = btnLoadPDFClick
  end
  object btnSave: TButton
    Left = 488
    Top = 463
    Width = 76
    Height = 25
    Caption = 'Save'
    TabOrder = 4
    OnClick = btnSaveClick
  end
  object btnReset: TButton
    Left = 3
    Top = 463
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 6
    OnClick = btnResetClick
  end
  object cbOpenAfterCreate: TCheckBox
    Left = 369
    Top = 466
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
    Left = 520
    Top = 41
  end
  object OpenDialog1: TOpenDialog
    Left = 488
    Top = 33
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Left = 520
    Top = 146
  end
  object SaveDialog1: TSaveDialog
    Left = 488
    Top = 64
  end
end
