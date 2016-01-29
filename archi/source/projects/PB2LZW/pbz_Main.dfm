object Form1: TForm1
  Left = 325
  Top = 277
  BorderStyle = bsDialog
  Caption = 'PACK-BITS to LZW TIFF converter'
  ClientHeight = 144
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 111
    Height = 13
    Caption = #1048#1089#1093#1086#1076#1085#1072#1103' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1103
  end
  object deSource: TDirectoryEdit
    Left = 8
    Top = 24
    Width = 489
    Height = 21
    DialogKind = dkWin32
    NumGlyphs = 1
    TabOrder = 0
  end
  object Button1: TButton
    Left = 176
    Top = 64
    Width = 153
    Height = 25
    Caption = #1053#1072#1095#1072#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
  object ProgressPanel: TPanel
    Left = 0
    Top = 96
    Width = 505
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    object DispLabel: TLabel
      Left = 12
      Top = 0
      Width = 6
      Height = 13
      Caption = '[]'
    end
    object ProgressBar1: TProgressBar
      Left = 8
      Top = 16
      Width = 489
      Height = 17
      Step = 1
      TabOrder = 0
    end
  end
  object XPManifest1: TXPManifest
    Left = 432
  end
  object ImgIO: TImageEnIO
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clWindowText
    PreviewFont.Height = -11
    PreviewFont.Name = 'MS Sans Serif'
    PreviewFont.Style = []
    Left = 432
    Top = 56
  end
end
