object vtCommandListEditor: TvtCommandListEditor
  Left = 282
  Top = 205
  Width = 628
  Height = 215
  Caption = 'vtCommandListEditor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object CmdTable: TvtStringGrid
    Left = 0
    Top = 0
    Width = 620
    Height = 188
    OnGetCellText = CmdTableGetCellText
    Align = alClient
    ColCount = 6
    FixedCols = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goEditing]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    ColWidths = (
      100
      68
      50
      85
      144
      162)
  end
end
