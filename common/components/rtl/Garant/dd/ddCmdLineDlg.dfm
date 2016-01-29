object ddCmdLineDlgForm: TddCmdLineDlgForm
  Left = 455
  Top = 284
  BorderStyle = bsDialog
  Caption = 'ddCmdLineDlgForm'
  ClientHeight = 201
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object listParams: TListView
    Left = 8
    Top = 8
    Width = 521
    Height = 150
    Columns = <
      item
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088
        Width = 150
      end
      item
        AutoSize = True
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077
        MinWidth = 200
      end>
    HotTrack = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object Button1: TButton
    Left = 216
    Top = 168
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
end
