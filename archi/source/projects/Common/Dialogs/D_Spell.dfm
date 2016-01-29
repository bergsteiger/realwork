object SpellCheckDlg: TSpellCheckDlg
  Left = 454
  Top = 303
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  ClientHeight = 299
  ClientWidth = 456
  Color = clBtnFace
  Constraints.MinHeight = 285
  Constraints.MinWidth = 454
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = [fsBold]
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    456
    299)
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 6
    Top = 4
    Width = 89
    Height = 16
    Caption = #1053#1077#1090' '#1074' '#1089#1083#1086#1074#1072#1088#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 7
    Top = 125
    Width = 62
    Height = 16
    Caption = #1042#1072#1088#1080#1072#1085#1090#1099':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lblLatinChars: TLabel
    Left = 6
    Top = 99
    Width = 276
    Height = 14
    Caption = #1057#1083#1086#1074#1086' '#1089#1086#1089#1090#1086#1080#1090' '#1080#1079' '#1088#1091#1089#1089#1082#1080#1093' '#1080' '#1083#1072#1090#1080#1085#1089#1082#1080#1093' '#1089#1080#1084#1074#1086#1083#1086#1074'!'
    WordWrap = True
  end
  object btSkip: TButton
    Tag = 1
    Left = 332
    Top = 21
    Width = 119
    Height = 27
    Anchors = [akTop, akRight]
    Caption = #1055#1088#1086#1087#1091#1089#1090#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btSkipClick
  end
  object btSkipAll: TButton
    Tag = 2
    Left = 332
    Top = 50
    Width = 119
    Height = 27
    Anchors = [akTop, akRight]
    Caption = #1055#1088#1086#1087#1091#1089#1090#1080#1090#1100' '#1074#1089#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btSkipAllClick
  end
  object btAddDic: TButton
    Tag = 3
    Left = 332
    Top = 80
    Width = 119
    Height = 27
    Anchors = [akTop, akRight]
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btAddDicClick
  end
  object btCancel: TBitBtn
    Left = 332
    Top = 267
    Width = 119
    Height = 27
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = #1047#1072#1074#1077#1088#1096#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
    OnClick = btCancelClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object btHelp: TBitBtn
    Left = 205
    Top = 267
    Width = 119
    Height = 27
    Anchors = [akTop, akRight]
    Caption = '&'#1055#1086#1084#1086#1097#1100
    TabOrder = 4
    Kind = bkHelp
  end
  object btReplace: TButton
    Tag = 4
    Left = 332
    Top = 142
    Width = 119
    Height = 27
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1084#1077#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btReplaceClick
  end
  object btReplaceAll: TButton
    Tag = 5
    Left = 332
    Top = 172
    Width = 119
    Height = 27
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1084#1077#1085#1080#1090#1100' '#1074#1089#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = btReplaceAllClick
  end
  object memAbsent: TevMemo
    Left = 6
    Top = 22
    Width = 318
    Height = 70
    TextSource.OnChangeModified = memAbsentChange
    TextSource.OnBruttoCharCountChange = memAbsentChange
    Anchors = [akLeft, akTop, akRight]
    ScrollStyle = ssNone
    OnParaChange = memAbsentParaChange
    OnFontChange = memAbsentFontChange
    OnCursorInSelectionChange = memAbsentCursorInSelectionChange
    TabOrder = 7
    TabStop = True
    BorderStyle = bsSingle
  end
  object lstAlternative: TvtLister
    Left = 7
    Top = 144
    Width = 318
    Height = 116
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clInactiveCaption
    SelectNonFocusColor.TextColor = clHighlightText
    OnCountChanged = lstAlternativeCountChanged
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Style = [fsBold]
    ParentColor = False
    TabOrder = 8
    TabStop = True
    Anchors = [akTop, akRight]
    OnActionElement = lstAlternativeActionElement
  end
end
