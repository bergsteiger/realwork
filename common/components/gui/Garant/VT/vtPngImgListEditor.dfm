object vtPngImageListEditForm: TvtPngImageListEditForm
  Left = 376
  Top = 193
  Width = 427
  Height = 584
  Caption = '<>'
  Color = clBtnFace
  Constraints.MinHeight = 350
  Constraints.MinWidth = 200
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 515
    Width = 411
    Height = 33
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      411
      33)
    object btnClose: TButton
      Left = 230
      Top = 3
      Width = 108
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 1
      TabOrder = 0
    end
  end
  object pnlRight: TPanel
    Left = 264
    Top = 0
    Width = 147
    Height = 515
    Align = alRight
    TabOrder = 1
    object btnShiftUp: TSpeedButton
      Left = 22
      Top = 181
      Width = 108
      Height = 25
      Caption = #1042#1074#1077#1088#1093
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
        3333333333777F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
        3333333777737777F333333099999990333333373F3333373333333309999903
        333333337F33337F33333333099999033333333373F333733333333330999033
        3333333337F337F3333333333099903333333333373F37333333333333090333
        33333333337F7F33333333333309033333333333337373333333333333303333
        333333333337F333333333333330333333333333333733333333}
      NumGlyphs = 2
      OnClick = btnShiftUpClick
    end
    object btnShiftDown: TSpeedButton
      Left = 22
      Top = 215
      Width = 108
      Height = 25
      Caption = #1042#1085#1080#1079
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337F33333333333333033333333333333373F333333333333090333
        33333333337F7F33333333333309033333333333337373F33333333330999033
        3333333337F337F33333333330999033333333333733373F3333333309999903
        333333337F33337F33333333099999033333333373333373F333333099999990
        33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333309033333333333337F7F333333333333090333
        33333333337F7F33333333333300033333333333337773333333}
      NumGlyphs = 2
      OnClick = btnShiftDownClick
    end
    object btnCorrect: TSpeedButton
      Left = 117
      Top = 482
      Width = 23
      Height = 22
      Hint = 
        #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1086#1090#1085#1086#1089#1080#1090#1077#1083#1100#1085#1086' '#1089#1090#1072#1088#1086#1081' '#1074#1077#1088#1089#1080#1080#13#10#1053#1045' '#1053#1040#1046#1048#1052#1040#1049#1058#1045', '#1045#1057#1051#1048' '#1053#1045' ' +
        #1059#1042#1045#1056#1045#1053#1067'!!!'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FF0000000F0
        000033F77777773777773FFF0CCC0FF09990333F73F37337F33733FFF0C0FFF0
        99903333F7373337F337333FFF0FFFF0999033333F73FFF7FFF73333FFF000F0
        0000333333F77737777733333F07B70FFFFF3333337F337F33333333330BBB0F
        FFFF3333337F337F333333333307B70FFFFF33333373FF733F333333333000FF
        0FFF3333333777337FF3333333333FF000FF33FFFFF3333777FF300000333300
        000F377777F33377777F30EEE0333000000037F337F33777777730EEE0333330
        00FF37F337F3333777F330EEE033333000FF37FFF7F3333777F3300000333330
        00FF3777773333F77733333333333000033F3333333337777333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = btnCorrectClick
    end
    object btn32_8: TvtSpeedButton
      Left = 98
      Top = 323
      Width = 36
      Height = 36
      Flat = False
      OnClick = LoadImage
      OnCustomGlyphDraw = btn32_8CustomGlyphDraw
    end
    object btn32_4: TvtSpeedButton
      Left = 97
      Top = 371
      Width = 36
      Height = 37
      Flat = False
      OnClick = LoadImage
      OnCustomGlyphDraw = btn32_4CustomGlyphDraw
    end
    object btn32_24: TvtSpeedButton
      Left = 98
      Top = 275
      Width = 36
      Height = 36
      Flat = False
      OnClick = LoadImage
      OnCustomGlyphDraw = btn32_24CustomGlyphDraw
    end
    object btn16_8: TvtSpeedButton
      Left = 38
      Top = 323
      Width = 20
      Height = 20
      Flat = False
      OnClick = LoadImage
      OnCustomGlyphDraw = btn16_8CustomGlyphDraw
    end
    object btn16_4: TvtSpeedButton
      Left = 38
      Top = 371
      Width = 20
      Height = 20
      Flat = False
      OnClick = LoadImage
      OnCustomGlyphDraw = btn16_4CustomGlyphDraw
    end
    object btn16_24: TvtSpeedButton
      Left = 38
      Top = 275
      Width = 20
      Height = 20
      Flat = False
      OnClick = LoadImage
      OnCustomGlyphDraw = btn16_24CustomGlyphDraw
    end
    object Label5: TLabel
      Left = 13
      Top = 371
      Width = 18
      Height = 12
      Caption = '4 bit'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 13
      Top = 323
      Width = 18
      Height = 12
      Caption = '8 bit'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 275
      Width = 23
      Height = 12
      Caption = '24 bit'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 103
      Top = 259
      Width = 25
      Height = 12
      Caption = '32x32'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 34
      Top = 259
      Width = 25
      Height = 12
      Caption = '16x16'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 20
      Top = 168
      Width = 108
      Height = 9
      Shape = bsTopLine
    end
    object btn24_8: TvtSpeedButton
      Left = 64
      Top = 323
      Width = 28
      Height = 28
      Flat = False
      OnClick = LoadImage
      OnCustomGlyphDraw = btn24_8CustomGlyphDraw
    end
    object btn24_4: TvtSpeedButton
      Left = 64
      Top = 371
      Width = 28
      Height = 28
      Flat = False
      OnClick = LoadImage
      OnCustomGlyphDraw = btn24_4CustomGlyphDraw
    end
    object btn24_24: TvtSpeedButton
      Left = 64
      Top = 275
      Width = 28
      Height = 28
      Flat = False
      OnClick = LoadImage
      OnCustomGlyphDraw = btn24_24CustomGlyphDraw
    end
    object Label6: TLabel
      Left = 65
      Top = 259
      Width = 25
      Height = 12
      Caption = '24x24'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object btnSaveAll: TButton
      Left = 21
      Top = 96
      Width = 108
      Height = 25
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1074#1089#1077
      TabOrder = 0
      OnClick = btnSaveAllClick
    end
    object btnSave: TButton
      Left = 21
      Top = 67
      Width = 108
      Height = 25
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnDelete: TButton
      Left = 21
      Top = 39
      Width = 108
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 2
      OnClick = btnDeleteClick
    end
    object btnAdd: TButton
      Left = 21
      Top = 11
      Width = 108
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 3
      OnClick = btnAddClick
    end
    object btnLoad: TButton
      Left = 20
      Top = 131
      Width = 108
      Height = 25
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1086#1087#1090#1086#1084
      TabOrder = 4
      OnClick = btnLoadClick
    end
    object btnCopySizedImg: TButton
      Left = 21
      Top = 427
      Width = 108
      Height = 25
      Caption = #1050#1086#1087#1080#1088
      TabOrder = 5
      OnClick = btnCopySizedImgClick
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 264
    Height = 515
    Align = alClient
    Caption = 'pnlClient'
    TabOrder = 2
    object lsImages: TvtLister
      Left = 1
      Top = 1
      Width = 262
      Height = 513
      AutoRowHeight = False
      IntegralHeight = False
      InternalSelector = False
      ProtectColor.BackColor = clRed
      ProtectColor.TextColor = clWhite
      RowHeight = 13
      SelectColor.BackColor = clHighlight
      SelectColor.TextColor = clHighlightText
      SelectNonFocusColor.BackColor = clBtnFace
      SelectNonFocusColor.TextColor = clBtnText
      MultiStrokeItem = True
      OnGetStrItem = lsImagesGetStrItem
      OnGetItemImageIndex = lsImagesGetItemImageIndex
      OnCurrentChanged = lsImagesCurrentChanged
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      ParentColor = False
      TabOrder = 0
      TabStop = True
    end
  end
  object dlgOpen: TOpenDialog
    DefaultExt = 'png'
    Filter = 'PNG, GIF '#1080#1083#1080' BMP|*.png; *.bmp; *.gif'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofFileMustExist, ofEnableSizing]
    Left = 120
    Top = 136
  end
end
