object vtNFPngImageListEditForm: TvtNFPngImageListEditForm
  Left = 311
  Top = 225
  Width = 386
  Height = 509
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 243
    Height = 482
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object lsImages: TvtLister
      Left = 1
      Top = 1
      Width = 241
      Height = 480
      AutoRowHeight = False
      IntegralHeight = False
      InternalSelector = False
      ProtectColor.BackColor = clRed
      ProtectColor.TextColor = clWhite
      SelectColor.BackColor = clHighlight
      SelectColor.TextColor = clHighlightText
      SelectNonFocusColor.BackColor = clBtnFace
      SelectNonFocusColor.TextColor = clBtnText
      MultiStrokeItem = True
      ReadOnly = False
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
  object Panel2: TPanel
    Left = 243
    Top = 0
    Width = 135
    Height = 482
    Align = alRight
    TabOrder = 1
    object btnShiftUp: TSpeedButton
      Left = 17
      Top = 281
      Width = 23
      Height = 23
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
      Left = 17
      Top = 306
      Width = 23
      Height = 21
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
    object btn8: TvtSpeedButton
      Left = 51
      Top = 193
      Width = 67
      Height = 42
      Flat = False
      OnClick = LoadImage
      OnCustomGlyphDraw = btn8CustomGlyphDraw
    end
    object btn4: TvtSpeedButton
      Left = 51
      Top = 241
      Width = 67
      Height = 42
      Flat = False
      OnClick = LoadImage
      OnCustomGlyphDraw = btn4CustomGlyphDraw
    end
    object btn24: TvtSpeedButton
      Left = 51
      Top = 145
      Width = 67
      Height = 42
      Flat = False
      OnClick = LoadImage
      OnCustomGlyphDraw = btn24CustomGlyphDraw
    end
    object Label3: TLabel
      Left = 21
      Top = 145
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
    object Label5: TLabel
      Left = 26
      Top = 241
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
      Left = 26
      Top = 193
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
    object btnSaveAll: TButton
      Left = 14
      Top = 89
      Width = 108
      Height = 26
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1074#1089#1077
      TabOrder = 0
      OnClick = btnSaveAllClick
    end
    object btnSave: TButton
      Left = 14
      Top = 60
      Width = 108
      Height = 25
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnDelete: TButton
      Left = 14
      Top = 33
      Width = 108
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 2
      OnClick = btnDeleteClick
    end
    object btnClose: TButton
      Left = 14
      Top = 340
      Width = 108
      Height = 25
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 1
      TabOrder = 3
    end
    object btnAdd: TButton
      Left = 14
      Top = 5
      Width = 108
      Height = 24
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 4
      OnClick = btnAddClick
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
