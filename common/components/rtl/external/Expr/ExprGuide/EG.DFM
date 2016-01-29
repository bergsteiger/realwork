object FormGuide: TFormGuide
  Left = 192
  Top = 109
  Width = 757
  Height = 579
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1087#1086' '#1089#1080#1085#1090#1072#1082#1089#1080#1089#1091' ExprBuild'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    749
    547)
  PixelsPerInch = 120
  TextHeight = 16
  object ListBox: TListBox
    Left = 15
    Top = 20
    Width = 291
    Height = 516
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 16
    Sorted = True
    TabOrder = 0
    OnClick = ListBoxClick
  end
  object Memo: TMemo
    Left = 325
    Top = 20
    Width = 414
    Height = 198
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      'Memo')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object ScrollBox1: TScrollBox
    Left = 325
    Top = 236
    Width = 413
    Height = 301
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clInfoBk
    ParentColor = False
    TabOrder = 2
    object Image: TImage
      Left = 0
      Top = 0
      Width = 129
      Height = 129
      Transparent = True
    end
  end
  object BtnPrint: TBitBtn
    Left = 15
    Top = 630
    Width = 99
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = #1055#1077#1095#1072#1090#1100
    TabOrder = 3
    OnClick = BtnPrintClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      00030888888888888880088888888888888000000000000000000F8F8F8F8F8F
      8F8008F8F8F8F8F8F9F00F8F8F8F8F8F8F8000000000000000003330FFFFFFFF
      03333330F0000F0F03333330FFFFFFFF03333330F00F000003333330FFFF0FF0
      33333330F08F0F0333333330FFFF003333333330000003333333}
  end
end
