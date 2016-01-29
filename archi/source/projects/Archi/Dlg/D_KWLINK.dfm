object KWLinkDlg: TKWLinkDlg
  Left = 502
  Top = 242
  Width = 325
  Height = 271
  Caption = 'КЛЮЧЕВЫЕ СЛОВА'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object AllKWList: TvtDStringLister
    Left = 0
    Top = 29
    Width = 317
    Height = 195
    Hint = 'Ключевые слова|'
    Sorted = False
    AutoRowHeight = False
    HeaderHeight = 0
    IntegralHeight = False
    MultiSelect = True
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    RowHeight = 53
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clInactiveCaption
    SelectNonFocusColor.TextColor = clHighlightText
    PickedList = True
    MultiStrokeItem = False
    ReadOnly = False
    OnSelectChange = AllKWListSelectChange
    Align = alClient
    Controller = OvcController1
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    TabStop = True
    Visible = False
  end
  object KWLinkList: TvtStringLister
    Left = 0
    Top = 29
    Width = 317
    Height = 195
    Sorted = False
    AlienSource = False
    AutoRowHeight = False
    HeaderHeight = 0
    IntegralHeight = False
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    RowHeight = 53
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clInactiveCaption
    SelectNonFocusColor.TextColor = clHighlightText
    PickedList = False
    MultiStrokeItem = False
    ReadOnly = False
    Align = alClient
    Controller = OvcController1
    ParentColor = False
    TabOrder = 2
    TabStop = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 317
    Height = 29
    Align = alTop
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 3
      Top = 3
      Width = 24
      Height = 24
      Hint = 'Удалить|'
      Glyph.Data = {
        06020000424D0602000000000000760000002800000028000000140000000100
        0400000000009001000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777777777FFFFFF
        FFFFFFFFFFF770000000000000000077788888888888888888F7709999999999
        9999907778F777777777777778F77099999999999999907778F7777777777777
        78F77099999999999999907778FFFFFFFFFFFFFFF8F770000000000000000077
        7888888888888888887777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        77777777777777777777}
      NumGlyphs = 2
    end
    object SingleModeBtn: TSpeedButton
      Left = 26
      Top = 3
      Width = 24
      Height = 24
      Hint = 'Все / Выделенные|'
      AllowAllUp = True
      GroupIndex = 1
      OnClick = SingleModeBtnClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 224
    Width = 317
    Height = 17
    Align = alBottom
    TabOrder = 1
  end
  object OvcController1: TOvcController
    EntryCommands.TableList = (
      'Default'
      True
      ()
      'WordStar'
      False
      ()
      'Grid'
      False
      ())
    Left = 358
    Top = 4
  end
end
