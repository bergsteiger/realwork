object ShowLongMessageDlg: TShowLongMessageDlg
  Left = 424
  Top = 202
  BorderStyle = bsDialog
  Caption = #1055#1056#1045#1044#1059#1055#1056#1045#1046#1044#1045#1053#1048#1045
  ClientHeight = 336
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 294
    Width = 460
    Height = 42
    Align = alBottom
    TabOrder = 0
    object Panel2: TPanel
      Left = 366
      Top = 1
      Width = 93
      Height = 40
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object OKBtn: TBitBtn
        Left = 8
        Top = 7
        Width = 77
        Height = 27
        TabOrder = 0
        Kind = bkOK
        Margin = 2
        Spacing = -1
        IsControl = True
      end
    end
  end
  object evMemo1: TevMemo
    Left = 0
    Top = 0
    Width = 460
    Height = 294
    Align = alClient
    RMargin = 8
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    TabOrder = 1
    TabStop = True
    BorderStyle = bsSingle
  end
end
