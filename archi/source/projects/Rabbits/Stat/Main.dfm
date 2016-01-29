object MainForm: TMainForm
  Left = 190
  Top = 120
  Width = 696
  Height = 480
  Caption = 'MainForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    688
    448)
  PixelsPerInch = 120
  TextHeight = 16
  object btStart: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = #1057#1090#1072#1088#1090'!'
    TabOrder = 0
    OnClick = btStartClick
  end
  object btStartAll: TButton
    Left = 88
    Top = 8
    Width = 75
    Height = 25
    Caption = '!!!'
    TabOrder = 1
    OnClick = btStartAllClick
  end
  object btStartLong: TButton
    Left = 168
    Top = 8
    Width = 75
    Height = 25
    Caption = '?'
    TabOrder = 2
    OnClick = btStartLongClick
  end
  object Meter: TvtW95Meter
    Left = 8
    Top = 40
    Width = 673
    Anchors = [akLeft, akTop, akRight]
  end
  object Controller: TOvcController
    EntryCommands.TableList = (
      'Default'
      True
      ()
      'WordStar'
      False
      ()
      'List'
      False
      ()
      'Grid'
      False
      ())
    Left = 8
    Top = 64
  end
end
