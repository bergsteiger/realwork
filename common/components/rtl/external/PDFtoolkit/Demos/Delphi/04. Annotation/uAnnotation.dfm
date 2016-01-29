object Form1: TForm1
  Left = 201
  Top = 127
  BorderStyle = bsDialog
  Caption = 'Annotation Demo'
  ClientHeight = 502
  ClientWidth = 570
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
    Left = 19
    Top = 44
    Width = 43
    Height = 13
    Caption = 'Input file:'
  end
  object Label75: TLabel
    Left = 219
    Top = 14
    Width = 119
    Height = 16
    Alignment = taCenter
    Anchors = [akLeft, akRight]
    Caption = 'Annotation Demo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label14: TLabel
    Left = 19
    Top = 80
    Width = 48
    Height = 13
    Caption = 'Ouput file:'
  end
  object edPDFfilename: TEdit
    Left = 89
    Top = 39
    Width = 284
    Height = 21
    TabOrder = 0
  end
  object btnLoadPDF: TButton
    Left = 381
    Top = 36
    Width = 89
    Height = 25
    Caption = 'Load document'
    TabOrder = 1
    OnClick = btnLoadPDFClick
  end
  object edSavePDFTo: TEdit
    Left = 89
    Top = 77
    Width = 284
    Height = 21
    TabOrder = 2
    Text = 'C:\Output.pdf'
  end
  object btnSaveFileName: TButton
    Left = 380
    Top = 77
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 3
    OnClick = btnSaveFileNameClick
  end
  object btnSave: TButton
    Left = 492
    Top = 472
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 4
    OnClick = btnSaveClick
  end
  object pgncntrlEnhancement: TPageControl
    Left = 5
    Top = 111
    Width = 562
    Height = 357
    ActivePage = tbshAnnot
    TabOrder = 5
    object tbshAnnot: TTabSheet
      Caption = 'Annotation'
      ImageIndex = 3
      object Label98: TLabel
        Left = 6
        Top = 126
        Width = 90
        Height = 13
        Caption = 'Annotation settings'
      end
      object Label112: TLabel
        Left = 6
        Top = 302
        Width = 84
        Height = 13
        Caption = 'Measurement unit'
      end
      object rgrpAnnotation: TRadioGroup
        Left = 6
        Top = 4
        Width = 546
        Height = 118
        Caption = 'Annotation'
        Columns = 4
        ItemIndex = 0
        Items.Strings = (
          'Text Annotation'
          'FreeText Annotation'
          'Link Annotation'
          'Line Annotation'
          'Circle Annotation'
          'Square Annotation'
          'Stamp Annotation'
          'Markup Annotation'
          'Caret Annotation'
          'Polygon Annotation'
          'Polyline Annotation'
          'Ink Annotation')
        TabOrder = 0
        OnClick = rgrpAnnotationClick
      end
      object btnAddAnnotation: TButton
        Left = 460
        Top = 298
        Width = 91
        Height = 25
        Caption = 'Add Annotation'
        TabOrder = 1
        OnClick = btnAddAnnotationClick
      end
      object PageCtrlAnnotate: TPageControl
        Left = 6
        Top = 144
        Width = 545
        Height = 148
        ActivePage = tbshTextannot
        TabOrder = 2
        object tbshTextannot: TTabSheet
          Caption = 'tbshTextannot'
          TabVisible = False
          object Label206: TLabel
            Left = 5
            Top = 13
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label207: TLabel
            Left = 99
            Top = 13
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label208: TLabel
            Left = 5
            Top = 44
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label209: TLabel
            Left = 99
            Top = 44
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label210: TLabel
            Left = 3
            Top = 108
            Width = 42
            Height = 13
            Caption = 'Contents'
          end
          object Label211: TLabel
            Left = 212
            Top = 43
            Width = 20
            Height = 13
            Caption = 'Title'
          end
          object Label212: TLabel
            Left = 212
            Top = 13
            Width = 28
            Height = 13
            Caption = 'Name'
          end
          object Label215: TLabel
            Left = 389
            Top = 77
            Width = 59
            Height = 13
            Caption = 'Border width'
          end
          object Label216: TLabel
            Left = 390
            Top = 108
            Width = 35
            Height = 13
            Caption = 'Page #'
          end
          object Label217: TLabel
            Left = 389
            Top = 13
            Width = 78
            Height = 13
            Caption = 'H Corner Radius'
          end
          object Label218: TLabel
            Left = 389
            Top = 43
            Width = 77
            Height = 13
            Caption = 'V Corner Radius'
          end
          object edTextannotLeft: TEdit
            Left = 36
            Top = 8
            Width = 49
            Height = 21
            TabOrder = 0
          end
          object edTextannotTop: TEdit
            Left = 143
            Top = 8
            Width = 49
            Height = 21
            TabOrder = 1
          end
          object edTextannotRight: TEdit
            Left = 36
            Top = 41
            Width = 49
            Height = 21
            TabOrder = 2
          end
          object edTextannotBottom: TEdit
            Left = 143
            Top = 41
            Width = 49
            Height = 21
            TabOrder = 3
          end
          object edTextannotName: TEdit
            Left = 245
            Top = 8
            Width = 130
            Height = 21
            TabOrder = 4
          end
          object edTextannotTitle: TEdit
            Left = 245
            Top = 41
            Width = 130
            Height = 21
            TabOrder = 5
          end
          object edTextannotContents: TEdit
            Left = 53
            Top = 104
            Width = 139
            Height = 21
            TabOrder = 6
          end
          object spedTextannotBwidth: TSpinEdit
            Left = 457
            Top = 73
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 7
            Value = 1
          end
          object cbTextannotPageno: TComboBox
            Left = 457
            Top = 105
            Width = 47
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 8
          end
          object chkTextannotOpen: TCheckBox
            Left = 212
            Top = 104
            Width = 52
            Height = 17
            Caption = 'Open'
            TabOrder = 9
          end
          object spedTextannotVCR: TSpinEdit
            Left = 481
            Top = 41
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 10
            Value = 1
          end
          object spedTextannotHCR: TSpinEdit
            Left = 481
            Top = 8
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 11
            Value = 1
          end
        end
        object tbshFreeTextAnnot: TTabSheet
          Caption = 'tbshFreeTextAnnot'
          ImageIndex = 1
          TabVisible = False
          object Label219: TLabel
            Left = 5
            Top = 13
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label220: TLabel
            Left = 116
            Top = 13
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label221: TLabel
            Left = 229
            Top = 13
            Width = 42
            Height = 13
            Caption = 'Contents'
          end
          object Label222: TLabel
            Left = 229
            Top = 43
            Width = 20
            Height = 13
            Caption = 'Title'
          end
          object Label223: TLabel
            Left = 116
            Top = 44
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label224: TLabel
            Left = 5
            Top = 44
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label226: TLabel
            Left = 5
            Top = 108
            Width = 28
            Height = 13
            Caption = 'Name'
          end
          object Label228: TLabel
            Left = 414
            Top = 77
            Width = 59
            Height = 13
            Caption = 'Border width'
          end
          object Label229: TLabel
            Left = 414
            Top = 108
            Width = 35
            Height = 13
            Caption = 'Page #'
          end
          object Label230: TLabel
            Left = 229
            Top = 108
            Width = 89
            Height = 13
            Caption = 'Free text alignment'
          end
          object edFreeAnnotLeft: TEdit
            Left = 53
            Top = 8
            Width = 49
            Height = 21
            TabOrder = 0
          end
          object edFreeAnnotTop: TEdit
            Left = 160
            Top = 8
            Width = 49
            Height = 21
            TabOrder = 1
          end
          object edFreeAnnotContents: TEdit
            Left = 279
            Top = 8
            Width = 249
            Height = 21
            TabOrder = 2
          end
          object edFreeAnnotTitle: TEdit
            Left = 279
            Top = 41
            Width = 249
            Height = 21
            TabOrder = 3
          end
          object edFreeAnnotBottom: TEdit
            Left = 160
            Top = 41
            Width = 49
            Height = 21
            TabOrder = 4
          end
          object edFreeAnnotRight: TEdit
            Left = 53
            Top = 41
            Width = 49
            Height = 21
            TabOrder = 5
          end
          object edFreeAnnotName: TEdit
            Left = 53
            Top = 104
            Width = 156
            Height = 21
            TabOrder = 6
          end
          object spedFreeBWidth: TSpinEdit
            Left = 481
            Top = 73
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 7
            Value = 1
          end
          object cbFreeAnnotPageno: TComboBox
            Left = 481
            Top = 105
            Width = 47
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 8
          end
          object cbFreeAnnotAlign: TComboBox
            Left = 326
            Top = 104
            Width = 76
            Height = 21
            ItemHeight = 13
            TabOrder = 9
            Text = 'LeftJustified '
            Items.Strings = (
              'LeftJustified '
              'Centered '
              'RightJustified')
          end
        end
        object tbshLinkAnnot: TTabSheet
          Caption = 'tbshLinkAnnot'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Colorbox'
          Font.Style = []
          ImageIndex = 2
          ParentFont = False
          TabVisible = False
          object Label2: TLabel
            Left = 8
            Top = 13
            Width = 19
            Height = 14
            Caption = 'Left'
          end
          object Label3: TLabel
            Left = 8
            Top = 44
            Width = 24
            Height = 14
            Caption = 'Right'
          end
          object Label4: TLabel
            Left = 116
            Top = 13
            Width = 18
            Height = 14
            Caption = 'Top'
          end
          object Label5: TLabel
            Left = 116
            Top = 44
            Width = 33
            Height = 14
            Caption = 'Bottom'
          end
          object Label6: TLabel
            Left = 244
            Top = 13
            Width = 19
            Height = 14
            Caption = 'Title'
          end
          object Name: TLabel
            Left = 8
            Top = 108
            Width = 27
            Height = 14
            Caption = 'Name'
          end
          object Label7: TLabel
            Left = 433
            Top = 109
            Width = 33
            Height = 14
            Caption = 'Page #'
          end
          object Label8: TLabel
            Left = 244
            Top = 109
            Width = 63
            Height = 14
            Caption = 'Border width'
          end
          object Label9: TLabel
            Left = 244
            Top = 43
            Width = 50
            Height = 14
            Caption = 'URI Action'
          end
          object Label11: TLabel
            Left = 472
            Top = 44
            Width = 49
            Height = 14
            Caption = 'URL name'
          end
          object edLinkLeft: TEdit
            Left = 48
            Top = 8
            Width = 49
            Height = 22
            TabOrder = 0
          end
          object edLinkRight: TEdit
            Left = 48
            Top = 41
            Width = 49
            Height = 22
            TabOrder = 1
          end
          object edLinkBottom: TEdit
            Left = 160
            Top = 41
            Width = 49
            Height = 22
            TabOrder = 2
          end
          object edLinkTop: TEdit
            Left = 160
            Top = 8
            Width = 49
            Height = 22
            TabOrder = 3
          end
          object edLinkTitle: TEdit
            Left = 300
            Top = 8
            Width = 168
            Height = 22
            TabOrder = 4
          end
          object edLinkURIAction: TEdit
            Left = 300
            Top = 41
            Width = 168
            Height = 22
            TabOrder = 5
            Text = 'www.gnostice.com'
          end
          object edLinkName: TEdit
            Left = 48
            Top = 105
            Width = 161
            Height = 22
            TabOrder = 6
          end
          object cbLinkPageno: TComboBox
            Left = 472
            Top = 105
            Width = 49
            Height = 22
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 7
          end
          object spedLinkBorderwidth: TSpinEdit
            Left = 333
            Top = 104
            Width = 47
            Height = 23
            MaxValue = 100
            MinValue = 0
            TabOrder = 8
            Value = 1
          end
        end
        object tbshLineAnnot: TTabSheet
          Caption = 'tbshLineAnnot'
          ImageIndex = 3
          TabVisible = False
          object Label100: TLabel
            Left = 6
            Top = 8
            Width = 50
            Height = 13
            Caption = 'Initial point'
          end
          object Label101: TLabel
            Left = 80
            Top = 8
            Width = 13
            Height = 13
            Caption = 'X1'
          end
          object Label105: TLabel
            Left = 149
            Top = 8
            Width = 13
            Height = 13
            Caption = 'Y1'
          end
          object Label104: TLabel
            Left = 6
            Top = 38
            Width = 45
            Height = 13
            Caption = 'End point'
          end
          object Label106: TLabel
            Left = 78
            Top = 38
            Width = 13
            Height = 13
            Caption = 'X2'
          end
          object Label103: TLabel
            Left = 149
            Top = 38
            Width = 13
            Height = 13
            Caption = 'Y2'
          end
          object Label111: TLabel
            Left = 269
            Top = 114
            Width = 32
            Height = 13
            Caption = 'Page#'
          end
          object Label107: TLabel
            Left = 269
            Top = 8
            Width = 42
            Height = 13
            Caption = 'Contents'
          end
          object Label108: TLabel
            Left = 5
            Top = 85
            Width = 28
            Height = 13
            Caption = 'Name'
          end
          object Label109: TLabel
            Left = 269
            Top = 85
            Width = 59
            Height = 13
            Caption = 'Border width'
          end
          object Label110: TLabel
            Left = 5
            Top = 114
            Width = 20
            Height = 13
            Caption = 'Title'
          end
          object edAnnotLineY1: TEdit
            Left = 169
            Top = 5
            Width = 32
            Height = 21
            TabOrder = 0
          end
          object edAnnotLineY2: TEdit
            Left = 169
            Top = 35
            Width = 32
            Height = 21
            TabOrder = 1
          end
          object edAnnotLineContents: TEdit
            Left = 319
            Top = 5
            Width = 208
            Height = 21
            TabOrder = 2
          end
          object edAnnotLineName: TEdit
            Left = 44
            Top = 82
            Width = 157
            Height = 21
            TabOrder = 3
          end
          object edAnnotLinetitle: TEdit
            Left = 44
            Top = 110
            Width = 157
            Height = 21
            TabOrder = 4
          end
          object edAnnotLineX1: TEdit
            Left = 99
            Top = 5
            Width = 33
            Height = 21
            TabOrder = 5
          end
          object edAnnotLineX2: TEdit
            Left = 99
            Top = 35
            Width = 33
            Height = 21
            TabOrder = 6
          end
          object cbLineAnnotPageno: TComboBox
            Left = 333
            Top = 110
            Width = 49
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 7
          end
          object spedLineAnnotBorderwidth: TSpinEdit
            Left = 333
            Top = 82
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 8
            Value = 1
          end
        end
        object tbshCircleAnnot: TTabSheet
          Caption = 'tbshCircleAnnot'
          ImageIndex = 4
          TabVisible = False
          object Label113: TLabel
            Left = 6
            Top = 12
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label114: TLabel
            Left = 103
            Top = 12
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label116: TLabel
            Left = 103
            Top = 45
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label115: TLabel
            Left = 6
            Top = 45
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label121: TLabel
            Left = 370
            Top = 12
            Width = 39
            Height = 13
            Caption = 'Intensity'
          end
          object Label117: TLabel
            Left = 370
            Top = 45
            Width = 35
            Height = 13
            Caption = 'Page #'
          end
          object Label131: TLabel
            Left = 6
            Top = 110
            Width = 42
            Height = 13
            Caption = 'Contents'
          end
          object edtcircleLeft: TEdit
            Left = 53
            Top = 7
            Width = 33
            Height = 21
            TabOrder = 0
          end
          object edtCircleTop: TEdit
            Left = 151
            Top = 8
            Width = 33
            Height = 21
            TabOrder = 1
          end
          object edtCircleBottom: TEdit
            Left = 151
            Top = 44
            Width = 33
            Height = 21
            TabOrder = 2
          end
          object edtCircleRight: TEdit
            Left = 53
            Top = 44
            Width = 33
            Height = 21
            TabOrder = 3
          end
          object ChkCircleCloudy: TCheckBox
            Left = 370
            Top = 76
            Width = 54
            Height = 25
            Caption = 'Cloudy'
            TabOrder = 4
          end
          object edtCircleAnnotContents: TEdit
            Left = 53
            Top = 107
            Width = 300
            Height = 21
            TabOrder = 5
          end
          object spedCirclannotIntensity: TSpinEdit
            Left = 423
            Top = 7
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 6
            Value = 1
          end
          object cbCircleAnnotPageno: TComboBox
            Left = 423
            Top = 44
            Width = 49
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 7
          end
        end
        object tbshSquareannot: TTabSheet
          Caption = 'tbshSquareannot'
          ImageIndex = 5
          TabVisible = False
          object Label122: TLabel
            Left = 6
            Top = 12
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label125: TLabel
            Left = 6
            Top = 41
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label124: TLabel
            Left = 99
            Top = 12
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label126: TLabel
            Left = 99
            Top = 41
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label123: TLabel
            Left = 376
            Top = 40
            Width = 39
            Height = 13
            Caption = 'Intensity'
          end
          object Label127: TLabel
            Left = 376
            Top = 74
            Width = 32
            Height = 13
            Caption = 'Page#'
          end
          object Label132: TLabel
            Left = 7
            Top = 107
            Width = 42
            Height = 13
            Caption = 'Contents'
          end
          object edtSqAnnotLeft: TEdit
            Left = 43
            Top = 9
            Width = 33
            Height = 21
            TabOrder = 0
          end
          object edtSqAnnotRight: TEdit
            Left = 43
            Top = 37
            Width = 33
            Height = 21
            TabOrder = 1
          end
          object edtSqAnnotTop: TEdit
            Left = 144
            Top = 9
            Width = 33
            Height = 21
            TabOrder = 2
          end
          object edtSqAnnotBottom: TEdit
            Left = 144
            Top = 37
            Width = 33
            Height = 21
            TabOrder = 3
          end
          object edtSqAnnotContents: TEdit
            Left = 57
            Top = 101
            Width = 293
            Height = 21
            TabOrder = 4
          end
          object cbSqAnnotCloudy: TCheckBox
            Left = 376
            Top = 8
            Width = 54
            Height = 25
            Caption = 'Cloudy'
            TabOrder = 5
          end
          object spedSquareIntensity: TSpinEdit
            Left = 436
            Top = 37
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 6
            Value = 1
          end
          object cbSquareAnnotPageno: TComboBox
            Left = 436
            Top = 70
            Width = 49
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 7
          end
        end
        object tbshStampAnnot: TTabSheet
          Caption = 'tbshStampAnnot'
          ImageIndex = 6
          TabVisible = False
          object Label183: TLabel
            Left = 5
            Top = 13
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label184: TLabel
            Left = 116
            Top = 13
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label185: TLabel
            Left = 229
            Top = 13
            Width = 42
            Height = 13
            Caption = 'Contents'
          end
          object Label186: TLabel
            Left = 229
            Top = 43
            Width = 20
            Height = 13
            Caption = 'Title'
          end
          object Label187: TLabel
            Left = 116
            Top = 44
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label188: TLabel
            Left = 5
            Top = 44
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label190: TLabel
            Left = 5
            Top = 108
            Width = 28
            Height = 13
            Caption = 'Name'
          end
          object Label192: TLabel
            Left = 414
            Top = 77
            Width = 59
            Height = 13
            Caption = 'Border width'
          end
          object Label193: TLabel
            Left = 414
            Top = 108
            Width = 35
            Height = 13
            Caption = 'Page #'
          end
          object Label194: TLabel
            Left = 229
            Top = 107
            Width = 54
            Height = 13
            Caption = 'BorderStyle'
          end
          object edStampAnnotLeft: TEdit
            Left = 53
            Top = 8
            Width = 49
            Height = 21
            TabOrder = 0
          end
          object edStampAnnotTop: TEdit
            Left = 160
            Top = 8
            Width = 49
            Height = 21
            TabOrder = 1
          end
          object edStampAnnotContents: TEdit
            Left = 287
            Top = 8
            Width = 241
            Height = 21
            TabOrder = 2
          end
          object edStampAnnotTitle: TEdit
            Left = 287
            Top = 41
            Width = 241
            Height = 21
            TabOrder = 3
          end
          object edStampAnnotBottom: TEdit
            Left = 160
            Top = 41
            Width = 49
            Height = 21
            TabOrder = 4
          end
          object edStampAnnotRight: TEdit
            Left = 53
            Top = 41
            Width = 49
            Height = 21
            TabOrder = 5
          end
          object edStampAnnotStampName: TEdit
            Left = 53
            Top = 104
            Width = 156
            Height = 21
            TabOrder = 6
          end
          object spedStampAnnotBWidth: TSpinEdit
            Left = 481
            Top = 73
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 7
            Value = 1
          end
          object cbStampAnnotPageno: TComboBox
            Left = 481
            Top = 105
            Width = 47
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 8
          end
          object cbStampAnnotBStyle: TComboBox
            Left = 287
            Top = 104
            Width = 81
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 9
            Items.Strings = (
              'bsSolid'
              'bsDashed '
              'bsBeveled '
              'bsInset '
              'bsUnderline')
          end
        end
        object tbshMarkupannot: TTabSheet
          Caption = 'tbshMarkupannot'
          ImageIndex = 7
          TabVisible = False
          object Label195: TLabel
            Left = 5
            Top = 18
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label196: TLabel
            Left = 93
            Top = 18
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label197: TLabel
            Left = 93
            Top = 48
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label198: TLabel
            Left = 5
            Top = 48
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label199: TLabel
            Left = 196
            Top = 50
            Width = 42
            Height = 13
            Caption = 'Contents'
          end
          object Label200: TLabel
            Left = 196
            Top = 79
            Width = 20
            Height = 13
            Caption = 'Title'
          end
          object Label201: TLabel
            Left = 5
            Top = 111
            Width = 28
            Height = 13
            Caption = 'Name'
          end
          object Label203: TLabel
            Left = 414
            Top = 79
            Width = 59
            Height = 13
            Caption = 'Border width'
          end
          object Label204: TLabel
            Left = 414
            Top = 111
            Width = 35
            Height = 13
            Caption = 'Page #'
          end
          object Label205: TLabel
            Left = 196
            Top = 18
            Width = 52
            Height = 13
            Caption = 'Quad point'
          end
          object edMarkAnnotLeft: TEdit
            Left = 36
            Top = 13
            Width = 49
            Height = 21
            TabOrder = 0
          end
          object edMarkAnnotTop: TEdit
            Left = 132
            Top = 13
            Width = 49
            Height = 21
            TabOrder = 1
          end
          object edMarkAnnotBottom: TEdit
            Left = 132
            Top = 45
            Width = 49
            Height = 21
            TabOrder = 2
          end
          object edMarkAnnotRight: TEdit
            Left = 36
            Top = 45
            Width = 49
            Height = 21
            TabOrder = 3
          end
          object edMarkAnnotContents: TEdit
            Left = 254
            Top = 45
            Width = 274
            Height = 21
            TabOrder = 4
          end
          object edMarkAnnotTitle: TEdit
            Left = 254
            Top = 75
            Width = 107
            Height = 21
            TabOrder = 5
          end
          object edMarkAnnotName: TEdit
            Left = 36
            Top = 107
            Width = 145
            Height = 21
            TabOrder = 6
          end
          object spedMarkAnnotBWidth: TSpinEdit
            Left = 481
            Top = 75
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 7
            Value = 1
          end
          object cbMarkAnnotPageno: TComboBox
            Left = 481
            Top = 108
            Width = 47
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 8
          end
          object edMarkAnnotx1: TEdit
            Left = 254
            Top = 13
            Width = 28
            Height = 21
            TabOrder = 9
          end
          object edMarkAnnotY4: TEdit
            Left = 502
            Top = 13
            Width = 26
            Height = 21
            TabOrder = 10
          end
          object edMarkAnnotx4: TEdit
            Left = 466
            Top = 13
            Width = 26
            Height = 21
            TabOrder = 11
          end
          object edMarkAnnotY3: TEdit
            Left = 431
            Top = 13
            Width = 25
            Height = 21
            TabOrder = 12
          end
          object edMarkAnnotX3: TEdit
            Left = 394
            Top = 13
            Width = 27
            Height = 21
            TabOrder = 13
          end
          object edMarkAnnotY2: TEdit
            Left = 359
            Top = 13
            Width = 26
            Height = 21
            TabOrder = 14
          end
          object edMarkAnnotX2: TEdit
            Left = 323
            Top = 13
            Width = 26
            Height = 21
            TabOrder = 15
          end
          object edMarkAnnotY1: TEdit
            Left = 290
            Top = 13
            Width = 24
            Height = 21
            TabOrder = 16
          end
        end
        object tbshCaretannot: TTabSheet
          Caption = 'tbshCaretannot'
          ImageIndex = 8
          TabVisible = False
          object Label34: TLabel
            Left = 5
            Top = 13
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label35: TLabel
            Left = 116
            Top = 13
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label36: TLabel
            Left = 414
            Top = 108
            Width = 35
            Height = 13
            Caption = 'Page #'
          end
          object Label37: TLabel
            Left = 414
            Top = 77
            Width = 59
            Height = 13
            Caption = 'Border width'
          end
          object Label38: TLabel
            Left = 116
            Top = 44
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label39: TLabel
            Left = 5
            Top = 44
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label82: TLabel
            Left = 229
            Top = 43
            Width = 20
            Height = 13
            Caption = 'Title'
          end
          object Label83: TLabel
            Left = 229
            Top = 13
            Width = 42
            Height = 13
            Caption = 'Contents'
          end
          object Label84: TLabel
            Left = 5
            Top = 108
            Width = 28
            Height = 13
            Caption = 'Name'
          end
          object Label94: TLabel
            Left = 229
            Top = 108
            Width = 34
            Height = 13
            Caption = 'Symbol'
          end
          object edCaretAnnotLeft: TEdit
            Left = 53
            Top = 8
            Width = 49
            Height = 21
            TabOrder = 0
          end
          object edCaretAnnotTop: TEdit
            Left = 160
            Top = 8
            Width = 49
            Height = 21
            TabOrder = 1
          end
          object edCaretAnnotBottom: TEdit
            Left = 160
            Top = 41
            Width = 49
            Height = 21
            TabOrder = 2
          end
          object edCaretAnnotright: TEdit
            Left = 53
            Top = 41
            Width = 49
            Height = 21
            TabOrder = 3
          end
          object edCaretAnnotTitle: TEdit
            Left = 279
            Top = 41
            Width = 249
            Height = 21
            TabOrder = 4
          end
          object edCaretAnnotContents: TEdit
            Left = 279
            Top = 8
            Width = 249
            Height = 21
            TabOrder = 5
          end
          object edCaretAnnotName: TEdit
            Left = 53
            Top = 104
            Width = 156
            Height = 21
            TabOrder = 6
          end
          object cbCaretSymbol: TComboBox
            Left = 279
            Top = 104
            Width = 89
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            TabOrder = 7
            Items.Strings = (
              'caParagraph'
              'caNoSymbol')
          end
          object cbCaretAnnotPageno: TComboBox
            Left = 481
            Top = 105
            Width = 47
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 8
          end
          object spedCaretAnnotBorderwidth: TSpinEdit
            Left = 481
            Top = 73
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 9
            Value = 1
          end
        end
        object tbshPolygonannot: TTabSheet
          Caption = 'tbshPolygonannot'
          ImageIndex = 9
          TabVisible = False
          object Label12: TLabel
            Left = 5
            Top = 13
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label15: TLabel
            Left = 93
            Top = 13
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label16: TLabel
            Left = 93
            Top = 44
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label17: TLabel
            Left = 5
            Top = 44
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label18: TLabel
            Left = 194
            Top = 13
            Width = 20
            Height = 13
            Caption = 'Title'
          end
          object Label19: TLabel
            Left = 194
            Top = 45
            Width = 28
            Height = 13
            Caption = 'Name'
          end
          object Label20: TLabel
            Left = 415
            Top = 109
            Width = 35
            Height = 13
            Caption = 'Page #'
          end
          object Label21: TLabel
            Left = 415
            Top = 44
            Width = 59
            Height = 13
            Caption = 'Border width'
          end
          object Label23: TLabel
            Left = 415
            Top = 74
            Width = 39
            Height = 13
            Caption = 'Intensity'
          end
          object Label24: TLabel
            Left = 4
            Top = 108
            Width = 42
            Height = 13
            Caption = 'Contents'
          end
          object Label138: TLabel
            Left = 194
            Top = 75
            Width = 38
            Height = 13
            Caption = 'Vertices'
          end
          object edPolygonLeft: TEdit
            Left = 35
            Top = 8
            Width = 49
            Height = 21
            TabOrder = 0
          end
          object edPolygontop: TEdit
            Left = 134
            Top = 8
            Width = 49
            Height = 21
            TabOrder = 1
          end
          object edPolygonBottom: TEdit
            Left = 134
            Top = 41
            Width = 49
            Height = 21
            TabOrder = 2
          end
          object edPolygonRight: TEdit
            Left = 35
            Top = 41
            Width = 49
            Height = 21
            TabOrder = 3
          end
          object edPolygonTitle: TEdit
            Left = 236
            Top = 9
            Width = 156
            Height = 21
            TabOrder = 4
          end
          object edPolygonName: TEdit
            Left = 236
            Top = 41
            Width = 156
            Height = 21
            TabOrder = 5
          end
          object chkIsCloudy: TCheckBox
            Left = 415
            Top = 13
            Width = 97
            Height = 17
            Caption = 'Is Cloudy'
            TabOrder = 6
          end
          object edPolygonContents: TEdit
            Left = 54
            Top = 105
            Width = 129
            Height = 21
            TabOrder = 7
          end
          object edPolygonVertices: TEdit
            Left = 236
            Top = 72
            Width = 156
            Height = 21
            TabOrder = 8
            Text = 'X1,Y1,X2,Y2...'
          end
          object cbPolygonAnnotPageno: TComboBox
            Left = 479
            Top = 105
            Width = 49
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 9
          end
          object spedPolygonAnnotBorderwidth: TSpinEdit
            Left = 479
            Top = 41
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 10
            Value = 1
          end
          object spedIntensity: TSpinEdit
            Left = 479
            Top = 72
            Width = 49
            Height = 22
            MaxValue = 100
            MinValue = 1
            TabOrder = 11
            Value = 1
          end
        end
        object tbshPolylineannot: TTabSheet
          Caption = 'tbshPolylineannot'
          ImageIndex = 10
          TabVisible = False
          object Label25: TLabel
            Left = 5
            Top = 13
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label26: TLabel
            Left = 116
            Top = 13
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label27: TLabel
            Left = 219
            Top = 44
            Width = 35
            Height = 13
            Caption = 'Page #'
          end
          object Label30: TLabel
            Left = 5
            Top = 44
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label31: TLabel
            Left = 116
            Top = 44
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label32: TLabel
            Left = 219
            Top = 74
            Width = 59
            Height = 13
            Caption = 'Border width'
          end
          object Label139: TLabel
            Left = 219
            Top = 109
            Width = 20
            Height = 13
            Caption = 'Title'
          end
          object Label171: TLabel
            Left = 5
            Top = 109
            Width = 42
            Height = 13
            Caption = 'Contents'
          end
          object Label172: TLabel
            Left = 219
            Top = 12
            Width = 28
            Height = 13
            Caption = 'Name'
          end
          object Label173: TLabel
            Left = 364
            Top = 11
            Width = 38
            Height = 13
            Caption = 'Vertices'
          end
          object edPolylineAnnotLeft: TEdit
            Left = 53
            Top = 8
            Width = 49
            Height = 21
            TabOrder = 0
          end
          object edPolylineAnnotTop: TEdit
            Left = 160
            Top = 8
            Width = 49
            Height = 21
            TabOrder = 1
          end
          object edPolylineAnnotRight: TEdit
            Left = 53
            Top = 41
            Width = 49
            Height = 21
            TabOrder = 2
          end
          object edPolylineAnnotBottom: TEdit
            Left = 160
            Top = 41
            Width = 49
            Height = 21
            TabOrder = 3
          end
          object edPolylineAnnotTitle: TEdit
            Left = 282
            Top = 105
            Width = 156
            Height = 21
            TabOrder = 4
          end
          object edPolylineAnnotContents: TEdit
            Left = 53
            Top = 105
            Width = 156
            Height = 21
            TabOrder = 5
          end
          object edPolylineAnnotName: TEdit
            Left = 282
            Top = 9
            Width = 76
            Height = 21
            TabOrder = 6
          end
          object edpolylineVertices: TEdit
            Left = 446
            Top = 9
            Width = 81
            Height = 21
            TabOrder = 7
            Text = 'X1,Y1,X2,Y2..'
          end
          object spedPolylineAnnotBorderWidth: TSpinEdit
            Left = 282
            Top = 71
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 1
            TabOrder = 8
            Value = 1
          end
          object cbPolylineannotPageno: TComboBox
            Left = 282
            Top = 41
            Width = 49
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 9
          end
        end
        object tbshInkannot: TTabSheet
          Caption = 'tbshInkannot'
          ImageIndex = 11
          TabVisible = False
          object Label174: TLabel
            Left = 5
            Top = 13
            Width = 18
            Height = 13
            Caption = 'Left'
          end
          object Label176: TLabel
            Left = 116
            Top = 13
            Width = 19
            Height = 13
            Caption = 'Top'
          end
          object Label177: TLabel
            Left = 116
            Top = 44
            Width = 33
            Height = 13
            Caption = 'Bottom'
          end
          object Label178: TLabel
            Left = 5
            Top = 44
            Width = 25
            Height = 13
            Caption = 'Right'
          end
          object Label179: TLabel
            Left = 5
            Top = 108
            Width = 28
            Height = 13
            Caption = 'Name'
          end
          object Label180: TLabel
            Left = 229
            Top = 13
            Width = 42
            Height = 13
            Caption = 'Contents'
          end
          object Label181: TLabel
            Left = 229
            Top = 43
            Width = 20
            Height = 13
            Caption = 'Title'
          end
          object Label225: TLabel
            Left = 414
            Top = 77
            Width = 59
            Height = 13
            Caption = 'Border width'
          end
          object Label231: TLabel
            Left = 414
            Top = 108
            Width = 35
            Height = 13
            Caption = 'Page #'
          end
          object Label232: TLabel
            Left = 229
            Top = 107
            Width = 27
            Height = 13
            Caption = 'Inklist'
          end
          object edInkAnnotLeft: TEdit
            Left = 53
            Top = 8
            Width = 49
            Height = 21
            TabOrder = 0
          end
          object edInkAnnotTop: TEdit
            Left = 160
            Top = 8
            Width = 49
            Height = 21
            TabOrder = 1
          end
          object edInkAnnotBottom: TEdit
            Left = 160
            Top = 41
            Width = 49
            Height = 21
            TabOrder = 2
          end
          object edInkAnnotRight: TEdit
            Left = 53
            Top = 41
            Width = 49
            Height = 21
            TabOrder = 3
          end
          object edInkAnnotName: TEdit
            Left = 53
            Top = 104
            Width = 156
            Height = 21
            TabOrder = 4
          end
          object edInkAnnotContents: TEdit
            Left = 279
            Top = 8
            Width = 249
            Height = 21
            TabOrder = 5
          end
          object edInkAnnotTitle: TEdit
            Left = 279
            Top = 41
            Width = 249
            Height = 21
            TabOrder = 6
          end
          object spedInkAnnotBwidth: TSpinEdit
            Left = 481
            Top = 73
            Width = 47
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 7
            Value = 1
          end
          object cbInkAnnotPageno: TComboBox
            Left = 481
            Top = 105
            Width = 47
            Height = 21
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 8
          end
          object edInkAnnotInklist: TEdit
            Left = 279
            Top = 104
            Width = 113
            Height = 21
            TabOrder = 9
          end
        end
      end
      object cbMeasurement: TComboBox
        Left = 98
        Top = 298
        Width = 103
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
    end
  end
  object btnReset: TButton
    Left = 5
    Top = 472
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 6
    OnClick = btnResetClick
  end
  object cbOpenAfterCreate: TCheckBox
    Left = 376
    Top = 475
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
    Top = 32
  end
  object OpenDialog1: TOpenDialog
    Left = 488
    Top = 32
  end
  object SaveDialog1: TSaveDialog
    Left = 488
    Top = 64
  end
end
