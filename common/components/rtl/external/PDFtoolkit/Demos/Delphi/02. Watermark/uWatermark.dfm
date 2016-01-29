object Form1: TForm1
  Left = 256
  Top = 154
  BorderStyle = bsDialog
  Caption = 'Watermark'
  ClientHeight = 487
  ClientWidth = 569
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
    Left = 201
    Top = 6
    Width = 121
    Height = 16
    Caption = 'Watermark Demo'
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
    Left = 379
    Top = 37
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
    Left = 453
    Top = 458
    Width = 112
    Height = 25
    Caption = 'Save'
    TabOrder = 4
    OnClick = btnSaveClick
  end
  object pgncntrlEnhancement: TPageControl
    Left = 3
    Top = 104
    Width = 562
    Height = 351
    ActivePage = tbshWatermark
    TabOrder = 5
    object tbshWatermark: TTabSheet
      Caption = 'Watermark'
      object Label40: TLabel
        Left = 5
        Top = 124
        Width = 91
        Height = 13
        Caption = 'Watermark settings'
        Color = clBtnFace
        ParentColor = False
      end
      object Label162: TLabel
        Left = 5
        Top = 300
        Width = 84
        Height = 13
        Caption = 'Measurement unit'
      end
      object rgrpwatermark: TRadioGroup
        Left = 5
        Top = 3
        Width = 546
        Height = 118
        Caption = 'Watermark'
        Columns = 4
        ItemIndex = 0
        Items.Strings = (
          'Text Watermark'
          'Image Watermark'
          'Rectangle Watermark'
          'Circle Watermark'
          'Polygon Watermark'
          'Curve Watermark'
          'Line Watermark'
          'Ellipse Watermark')
        TabOrder = 0
        OnClick = rgrpwatermarkClick
      end
      object pgecntrlWatermark: TPageControl
        Left = 5
        Top = 143
        Width = 546
        Height = 149
        ActivePage = tbshTextWatermark
        TabOrder = 1
        object tbshTextWatermark: TTabSheet
          Caption = 'TextWatermark'
          TabVisible = False
          object Label41: TLabel
            Left = 11
            Top = 8
            Width = 21
            Height = 13
            Caption = 'Text'
          end
          object Label44: TLabel
            Left = 296
            Top = 66
            Width = 36
            Height = 13
            Caption = 'Opacity'
          end
          object Label45: TLabel
            Left = 11
            Top = 37
            Width = 31
            Height = 13
            Caption = 'X cord'
          end
          object Label43: TLabel
            Left = 11
            Top = 65
            Width = 31
            Height = 13
            Caption = 'Y cord'
          end
          object Label120: TLabel
            Left = 296
            Top = 120
            Width = 55
            Height = 13
            Caption = 'Page range'
          end
          object Label168: TLabel
            Left = 433
            Top = 120
            Width = 51
            Height = 13
            Caption = 'Ex: 2-6,4,8'
          end
          object Label163: TLabel
            Left = 127
            Top = 120
            Width = 44
            Height = 13
            Caption = 'Horiz pos'
          end
          object Label164: TLabel
            Left = 127
            Top = 92
            Width = 62
            Height = 13
            Caption = 'Writing mode'
          end
          object Label165: TLabel
            Left = 296
            Top = 36
            Width = 40
            Height = 13
            Caption = 'Vert Poz'
          end
          object Label166: TLabel
            Left = 296
            Top = 92
            Width = 27
            Height = 13
            Caption = 'Angle'
          end
          object edTextWMName: TEdit
            Left = 52
            Top = 5
            Width = 476
            Height = 21
            TabOrder = 0
          end
          object edTextWMXcord: TEdit
            Left = 52
            Top = 33
            Width = 65
            Height = 21
            TabOrder = 1
          end
          object edTextWMYCord: TEdit
            Left = 52
            Top = 61
            Width = 65
            Height = 21
            TabOrder = 2
          end
          object spedTextWMOpacity: TSpinEdit
            Left = 357
            Top = 60
            Width = 52
            Height = 22
            MaxValue = 100
            MinValue = 1
            TabOrder = 3
            Value = 100
          end
          object chkOverlay: TCheckBox
            Left = 453
            Top = 34
            Width = 62
            Height = 17
            Caption = 'Overlay'
            TabOrder = 4
          end
          object edTextWMPageno: TEdit
            Left = 357
            Top = 116
            Width = 68
            Height = 21
            TabOrder = 5
            Text = '1'
          end
          object btnTextWMFont: TButton
            Left = 194
            Top = 60
            Width = 75
            Height = 25
            Caption = 'Font'
            TabOrder = 6
            OnClick = btnTextWMFontClick
          end
          object cbTextWMWritingmode: TComboBox
            Left = 194
            Top = 88
            Width = 89
            Height = 21
            ItemHeight = 13
            TabOrder = 7
            Text = 'wmHorizontal'
            Items.Strings = (
              'wmHorizontal'
              'wmVertical')
          end
          object cbTextWMHorizPos: TComboBox
            Left = 194
            Top = 117
            Width = 89
            Height = 21
            ItemHeight = 13
            ItemIndex = 3
            TabOrder = 8
            Text = 'hpCustom'
            Items.Strings = (
              'hpLeft '
              'hpCenter'
              'hpRight'
              'hpCustom')
          end
          object cbTextWMVertPoz: TComboBox
            Left = 357
            Top = 32
            Width = 85
            Height = 21
            ItemHeight = 13
            ItemIndex = 3
            TabOrder = 9
            Text = 'vpCustom'
            Items.Strings = (
              'vpTop'
              'vpMiddle'
              'vpBottom'
              'vpCustom')
          end
          object edTextWMAngle: TEdit
            Left = 357
            Top = 88
            Width = 52
            Height = 21
            TabOrder = 10
            Text = '0'
          end
        end
        object tbshImageWatermark: TTabSheet
          Caption = 'ImageWatermark'
          ImageIndex = 1
          TabVisible = False
          object Label95: TLabel
            Left = 7
            Top = 8
            Width = 58
            Height = 13
            Caption = 'Image name'
          end
          object Label97: TLabel
            Left = 136
            Top = 38
            Width = 31
            Height = 13
            Caption = 'Y cord'
          end
          object Label96: TLabel
            Left = 7
            Top = 35
            Width = 31
            Height = 13
            Caption = 'X cord'
          end
          object Label102: TLabel
            Left = 7
            Top = 90
            Width = 48
            Height = 13
            Caption = 'Opacity fill'
          end
          object Label169: TLabel
            Left = 7
            Top = 63
            Width = 55
            Height = 13
            Caption = 'Page range'
          end
          object Label170: TLabel
            Left = 169
            Top = 66
            Width = 51
            Height = 13
            Caption = 'Ex: 2-6,4,8'
          end
          object Label141: TLabel
            Left = 364
            Top = 59
            Width = 27
            Height = 13
            Caption = 'Angle'
          end
          object Label167: TLabel
            Left = 364
            Top = 33
            Width = 31
            Height = 13
            Caption = 'Height'
          end
          object Label175: TLabel
            Left = 364
            Top = 8
            Width = 28
            Height = 13
            Caption = 'Width'
          end
          object Label189: TLabel
            Left = 364
            Top = 85
            Width = 38
            Height = 13
            Caption = 'Hor Pos'
          end
          object Label213: TLabel
            Left = 364
            Top = 111
            Width = 39
            Height = 13
            Caption = 'Vert pos'
          end
          object edIamgeWMName: TEdit
            Left = 69
            Top = 6
            Width = 252
            Height = 21
            TabOrder = 0
          end
          object btnIamgeOpen: TButton
            Left = 327
            Top = 3
            Width = 26
            Height = 25
            Caption = '...'
            TabOrder = 1
            OnClick = btnIamgeOpenClick
          end
          object edImageWMY: TEdit
            Left = 172
            Top = 34
            Width = 62
            Height = 21
            TabOrder = 2
          end
          object edImageWMX: TEdit
            Left = 69
            Top = 34
            Width = 62
            Height = 21
            TabOrder = 3
          end
          object chkImageWMOverlay: TCheckBox
            Left = 7
            Top = 118
            Width = 65
            Height = 17
            Caption = 'Overlay'
            TabOrder = 4
          end
          object spedImageWMOpacityFill: TSpinEdit
            Left = 69
            Top = 90
            Width = 44
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 5
            Value = 100
          end
          object edImageWMPageno: TEdit
            Left = 69
            Top = 63
            Width = 91
            Height = 21
            TabOrder = 6
            Text = '1'
          end
          object edImageWMWidth: TEdit
            Left = 415
            Top = 3
            Width = 91
            Height = 21
            TabOrder = 7
          end
          object edImageWMHeight: TEdit
            Left = 415
            Top = 30
            Width = 91
            Height = 21
            TabOrder = 8
          end
          object edImageWMRotation: TEdit
            Left = 415
            Top = 57
            Width = 91
            Height = 21
            TabOrder = 9
          end
          object cbImageWMHorPas: TComboBox
            Left = 415
            Top = 84
            Width = 93
            Height = 21
            ItemHeight = 13
            TabOrder = 10
            Text = 'hpCustom'
            Items.Strings = (
              'hpLeft'
              'hpCenter'
              'hpRight'
              'hpCustom')
          end
          object cbImageWMVertPos: TComboBox
            Left = 415
            Top = 111
            Width = 92
            Height = 21
            ItemHeight = 13
            TabOrder = 11
            Text = 'vpCustom'
            Items.Strings = (
              'vpTop'
              'vpMiddle'
              'vpBottom'
              'vpCustom')
          end
        end
        object tbshRectWatermark: TTabSheet
          Caption = 'RectWatermark'
          ImageIndex = 2
          TabVisible = False
          object Label51: TLabel
            Left = 7
            Top = 14
            Width = 50
            Height = 13
            Caption = 'Initial point'
          end
          object Label42: TLabel
            Left = 71
            Top = 14
            Width = 13
            Height = 13
            Caption = 'X1'
          end
          object Label47: TLabel
            Left = 139
            Top = 14
            Width = 13
            Height = 13
            Caption = 'Y1'
          end
          object Label52: TLabel
            Left = 7
            Top = 46
            Width = 45
            Height = 13
            Caption = 'End point'
          end
          object Label46: TLabel
            Left = 71
            Top = 46
            Width = 13
            Height = 13
            Caption = 'X2'
          end
          object Label48: TLabel
            Left = 139
            Top = 46
            Width = 13
            Height = 13
            Caption = 'Y2'
          end
          object Label53: TLabel
            Left = 212
            Top = 15
            Width = 70
            Height = 13
            Caption = 'Opacity Stroke'
          end
          object Label50: TLabel
            Left = 212
            Top = 77
            Width = 47
            Height = 13
            Caption = 'Pen width'
          end
          object Label49: TLabel
            Left = 212
            Top = 46
            Width = 48
            Height = 13
            Caption = 'Opacity fill'
          end
          object Label99: TLabel
            Left = 212
            Top = 108
            Width = 55
            Height = 13
            Caption = 'Page range'
          end
          object Label142: TLabel
            Left = 360
            Top = 78
            Width = 26
            Height = 13
            Caption = 'pixels'
          end
          object Label145: TLabel
            Left = 360
            Top = 108
            Width = 51
            Height = 13
            Caption = 'Ex: 2-6,4,8'
          end
          object edRectWMX1: TEdit
            Left = 89
            Top = 12
            Width = 33
            Height = 21
            TabOrder = 0
          end
          object edRectWMY1: TEdit
            Left = 157
            Top = 12
            Width = 33
            Height = 21
            TabOrder = 1
          end
          object edRectWMX2: TEdit
            Left = 89
            Top = 42
            Width = 33
            Height = 21
            TabOrder = 2
          end
          object edRectWMY2: TEdit
            Left = 157
            Top = 42
            Width = 33
            Height = 21
            TabOrder = 3
          end
          object spedRectWMPenWidth: TSpinEdit
            Left = 289
            Top = 74
            Width = 59
            Height = 22
            MaxValue = 100
            MinValue = 1
            TabOrder = 4
            Value = 1
          end
          object spedRectWMOpacity: TSpinEdit
            Left = 289
            Top = 43
            Width = 59
            Height = 22
            MaxValue = 100
            MinValue = 1
            TabOrder = 5
            Value = 100
          end
          object spedRectWMOpacityStroke: TSpinEdit
            Left = 289
            Top = 12
            Width = 59
            Height = 22
            MaxValue = 100
            MinValue = 1
            TabOrder = 6
            Value = 100
          end
          object edRectWMPageno: TEdit
            Left = 289
            Top = 105
            Width = 59
            Height = 21
            TabOrder = 7
            Text = '1'
          end
        end
        object tbshCircleWatermark: TTabSheet
          Caption = 'CircleWatermark'
          ImageIndex = 3
          TabVisible = False
          object Label71: TLabel
            Left = 11
            Top = 8
            Width = 31
            Height = 13
            Caption = 'X cord'
          end
          object Label70: TLabel
            Left = 134
            Top = 8
            Width = 31
            Height = 13
            Caption = 'Y cord'
          end
          object Label69: TLabel
            Left = 11
            Top = 104
            Width = 36
            Height = 13
            Caption = 'Opacity'
          end
          object Label68: TLabel
            Left = 11
            Top = 54
            Width = 33
            Height = 13
            Caption = 'Radius'
          end
          object Label67: TLabel
            Left = 134
            Top = 104
            Width = 47
            Height = 13
            Caption = 'Pen width'
          end
          object Label133: TLabel
            Left = 134
            Top = 54
            Width = 55
            Height = 13
            Caption = 'Page range'
          end
          object Label146: TLabel
            Left = 256
            Top = 54
            Width = 51
            Height = 13
            Caption = 'Ex: 2-6,4,8'
          end
          object Label147: TLabel
            Left = 256
            Top = 104
            Width = 27
            Height = 13
            Caption = 'Pixels'
          end
          object edCircleX: TEdit
            Left = 70
            Top = 6
            Width = 54
            Height = 21
            TabOrder = 0
          end
          object edCircleY: TEdit
            Left = 194
            Top = 6
            Width = 54
            Height = 21
            TabOrder = 1
          end
          object edCircleWMPageno: TEdit
            Left = 194
            Top = 51
            Width = 54
            Height = 21
            TabOrder = 2
            Text = '1'
          end
          object spedCircleRadius: TSpinEdit
            Left = 70
            Top = 51
            Width = 54
            Height = 22
            MaxValue = 100
            MinValue = 1
            TabOrder = 3
            Value = 3
          end
          object spedCircleOpacity: TSpinEdit
            Left = 70
            Top = 101
            Width = 54
            Height = 22
            MaxValue = 100
            MinValue = 1
            TabOrder = 4
            Value = 50
          end
          object spedCirclePenWidth: TSpinEdit
            Left = 194
            Top = 101
            Width = 54
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 5
            Value = 2
          end
        end
        object tbshPolygonWatermark: TTabSheet
          Caption = 'PolygonWatermark'
          ImageIndex = 4
          TabVisible = False
          object Label77: TLabel
            Left = 11
            Top = 8
            Width = 31
            Height = 13
            Caption = 'X cord'
          end
          object Label78: TLabel
            Left = 152
            Top = 8
            Width = 31
            Height = 13
            Caption = 'Y cord'
          end
          object Label80: TLabel
            Left = 11
            Top = 59
            Width = 61
            Height = 13
            Caption = 'Num of sides'
          end
          object Label79: TLabel
            Left = 11
            Top = 106
            Width = 53
            Height = 13
            Caption = 'Side length'
          end
          object Label81: TLabel
            Left = 152
            Top = 59
            Width = 47
            Height = 13
            Caption = 'Pen width'
          end
          object Label134: TLabel
            Left = 152
            Top = 106
            Width = 55
            Height = 13
            Caption = 'Page range'
          end
          object Label150: TLabel
            Left = 276
            Top = 106
            Width = 51
            Height = 13
            Caption = 'Ex: 2-6,4,8'
          end
          object Label151: TLabel
            Left = 276
            Top = 59
            Width = 27
            Height = 13
            Caption = 'Pixels'
          end
          object edPolygonX: TEdit
            Left = 77
            Top = 6
            Width = 54
            Height = 21
            TabOrder = 0
          end
          object edPolygonY: TEdit
            Left = 216
            Top = 6
            Width = 54
            Height = 21
            TabOrder = 1
          end
          object edPolygomWMPageno: TEdit
            Left = 216
            Top = 103
            Width = 54
            Height = 21
            TabOrder = 2
            Text = '1'
          end
          object spedPolygonPenWidth: TSpinEdit
            Left = 216
            Top = 56
            Width = 53
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 3
            Value = 3
          end
          object spedPolygonSideLen: TSpinEdit
            Left = 78
            Top = 103
            Width = 53
            Height = 22
            MaxValue = 100
            MinValue = 1
            TabOrder = 4
            Value = 5
          end
          object spedPolygonNumofSides: TSpinEdit
            Left = 78
            Top = 56
            Width = 53
            Height = 22
            MaxValue = 25
            MinValue = 0
            TabOrder = 5
            Value = 4
          end
        end
        object tbshCurveWatermark: TTabSheet
          Caption = 'CurveWatermark'
          ImageIndex = 5
          TabVisible = False
          object Label55: TLabel
            Left = 7
            Top = 10
            Width = 50
            Height = 13
            Caption = 'Initial point'
          end
          object Label54: TLabel
            Left = 113
            Top = 10
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object Label56: TLabel
            Left = 181
            Top = 10
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object Label64: TLabel
            Left = 7
            Top = 101
            Width = 45
            Height = 13
            Caption = 'End point'
          end
          object Label62: TLabel
            Left = 328
            Top = 10
            Width = 47
            Height = 13
            Caption = 'Pen width'
          end
          object Label59: TLabel
            Left = 181
            Top = 39
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object Label61: TLabel
            Left = 113
            Top = 39
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object Label57: TLabel
            Left = 7
            Top = 39
            Width = 80
            Height = 13
            Caption = 'First control point'
          end
          object Label60: TLabel
            Left = 7
            Top = 73
            Width = 98
            Height = 13
            Caption = 'Second control point'
          end
          object Label58: TLabel
            Left = 113
            Top = 73
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object Label63: TLabel
            Left = 181
            Top = 73
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object Label135: TLabel
            Left = 328
            Top = 39
            Width = 55
            Height = 13
            Caption = 'Page range'
          end
          object Label65: TLabel
            Left = 114
            Top = 101
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object Label66: TLabel
            Left = 181
            Top = 101
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object Label155: TLabel
            Left = 467
            Top = 42
            Width = 51
            Height = 13
            Caption = 'Ex: 2-6,4,8'
          end
          object Label156: TLabel
            Left = 467
            Top = 11
            Width = 27
            Height = 13
            Caption = 'Pixels'
          end
          object edCurveInitPointX: TEdit
            Left = 131
            Top = 8
            Width = 33
            Height = 21
            TabOrder = 0
          end
          object edCurveInitPointY: TEdit
            Left = 199
            Top = 8
            Width = 33
            Height = 21
            TabOrder = 1
          end
          object edCurveFirstPointY: TEdit
            Left = 199
            Top = 38
            Width = 33
            Height = 21
            TabOrder = 2
          end
          object edCurveFirstPointX: TEdit
            Left = 131
            Top = 38
            Width = 33
            Height = 21
            TabOrder = 3
          end
          object edCurveSecondPointX: TEdit
            Left = 131
            Top = 68
            Width = 33
            Height = 21
            TabOrder = 4
          end
          object edCurveSecondPointY: TEdit
            Left = 199
            Top = 68
            Width = 33
            Height = 21
            TabOrder = 5
          end
          object edCurveWMPageno: TEdit
            Left = 394
            Top = 38
            Width = 64
            Height = 21
            TabOrder = 6
            Text = '1'
          end
          object edCurveEndX: TEdit
            Left = 131
            Top = 98
            Width = 33
            Height = 21
            TabOrder = 7
          end
          object edCurveEndY: TEdit
            Left = 199
            Top = 98
            Width = 33
            Height = 21
            TabOrder = 8
          end
          object spedCurveWMPenWidth: TSpinEdit
            Left = 394
            Top = 8
            Width = 64
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 9
            Value = 3
          end
        end
        object tbshLineWatermark: TTabSheet
          Caption = 'Line Watermark'
          ImageIndex = 7
          TabVisible = False
          object Label86: TLabel
            Left = 7
            Top = 14
            Width = 50
            Height = 13
            Caption = 'Initial point'
          end
          object Label87: TLabel
            Left = 71
            Top = 14
            Width = 13
            Height = 13
            Caption = 'X1'
          end
          object Label88: TLabel
            Left = 139
            Top = 14
            Width = 13
            Height = 13
            Caption = 'Y1'
          end
          object Label89: TLabel
            Left = 7
            Top = 44
            Width = 45
            Height = 13
            Caption = 'End point'
          end
          object Label90: TLabel
            Left = 71
            Top = 44
            Width = 13
            Height = 13
            Caption = 'X2'
          end
          object Label91: TLabel
            Left = 139
            Top = 44
            Width = 13
            Height = 13
            Caption = 'Y2'
          end
          object Label92: TLabel
            Left = 7
            Top = 111
            Width = 68
            Height = 13
            Caption = 'Opacity stroke'
          end
          object Label93: TLabel
            Left = 292
            Top = 14
            Width = 47
            Height = 13
            Caption = 'Pen width'
          end
          object Label136: TLabel
            Left = 7
            Top = 80
            Width = 55
            Height = 13
            Caption = 'Page range'
          end
          object Label157: TLabel
            Left = 163
            Top = 81
            Width = 51
            Height = 13
            Caption = 'Ex: 2-6,4,8'
          end
          object edLineInitX1: TEdit
            Left = 89
            Top = 12
            Width = 33
            Height = 21
            TabOrder = 0
          end
          object edLineInitY1: TEdit
            Left = 157
            Top = 12
            Width = 33
            Height = 21
            TabOrder = 1
          end
          object edLineEndX2: TEdit
            Left = 89
            Top = 42
            Width = 33
            Height = 21
            TabOrder = 2
          end
          object edLineEndY2: TEdit
            Left = 157
            Top = 42
            Width = 33
            Height = 21
            TabOrder = 3
          end
          object edLineWMPageno: TEdit
            Left = 89
            Top = 78
            Width = 69
            Height = 21
            TabOrder = 4
            Text = '1'
          end
          object spedLinePenWidth: TSpinEdit
            Left = 355
            Top = 12
            Width = 62
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 5
            Value = 2
          end
          object spedLineOpacityStroke: TSpinEdit
            Left = 89
            Top = 109
            Width = 48
            Height = 22
            MaxValue = 100
            MinValue = 0
            TabOrder = 6
            Value = 50
          end
        end
        object tbshEllipseWatermark: TTabSheet
          Caption = 'EllipseWatermark'
          ImageIndex = 8
          TabVisible = False
          object Label72: TLabel
            Left = 11
            Top = 10
            Width = 31
            Height = 13
            Caption = 'X cord'
          end
          object Label73: TLabel
            Left = 144
            Top = 10
            Width = 31
            Height = 13
            Caption = 'Y cord'
          end
          object Label1: TLabel
            Left = 11
            Top = 69
            Width = 57
            Height = 13
            Caption = 'Minor radius'
          end
          object Label74: TLabel
            Left = 11
            Top = 38
            Width = 57
            Height = 13
            Caption = 'Major radius'
          end
          object Label76: TLabel
            Left = 11
            Top = 100
            Width = 47
            Height = 13
            Caption = 'Pen width'
          end
          object Label137: TLabel
            Left = 144
            Top = 38
            Width = 55
            Height = 13
            Caption = 'Page range'
          end
          object Label159: TLabel
            Left = 263
            Top = 38
            Width = 51
            Height = 13
            Caption = 'Ex: 2-6,4,8'
          end
          object edEllipseY: TEdit
            Left = 203
            Top = 6
            Width = 54
            Height = 21
            TabOrder = 0
          end
          object edEllipseX: TEdit
            Left = 77
            Top = 6
            Width = 54
            Height = 21
            TabOrder = 1
          end
          object edEllipseWMPageno: TEdit
            Left = 203
            Top = 35
            Width = 54
            Height = 21
            TabOrder = 2
            Text = '1'
          end
          object spedEllipseMajorRad: TSpinEdit
            Left = 79
            Top = 35
            Width = 52
            Height = 22
            MaxValue = 100
            MinValue = 1
            TabOrder = 3
            Value = 1
          end
          object spedEllipseMinorRad: TSpinEdit
            Left = 78
            Top = 66
            Width = 53
            Height = 22
            MaxValue = 100
            MinValue = 1
            TabOrder = 4
            Value = 1
          end
          object spedEllipsePenWidth: TSpinEdit
            Left = 78
            Top = 97
            Width = 53
            Height = 22
            MaxValue = 100
            MinValue = 1
            TabOrder = 5
            Value = 1
          end
        end
      end
      object btnAddWatermark: TButton
        Left = 453
        Top = 296
        Width = 98
        Height = 25
        Caption = 'Add Watermark'
        TabOrder = 2
        OnClick = btnAddWatermarkClick
      end
      object cbMWMeasure: TComboBox
        Left = 98
        Top = 296
        Width = 71
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        Items.Strings = (
          'Pixels'
          'Points'
          'Inches'
          'MM'
          'Twips')
      end
    end
  end
  object cbOpenAfterCreate: TCheckBox
    Left = 339
    Top = 463
    Width = 114
    Height = 17
    Caption = 'Open After Create'
    TabOrder = 6
  end
  object btnReset: TButton
    Left = 4
    Top = 458
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
    Left = 520
    Top = 32
  end
  object OpenDialog1: TOpenDialog
    Left = 488
    Top = 32
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 182
    Top = 423
  end
  object SaveDialog1: TSaveDialog
    Left = 488
    Top = 64
  end
end
