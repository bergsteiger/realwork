object Form1: TForm1
  Left = 540
  Top = 156
  Width = 636
  Height = 608
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object View: TImageEnView
    Left = 0
    Top = 0
    Width = 620
    Height = 570
    ParentCtl3D = False
    Align = alClient
    TabOrder = 0
  end
  object IO: TImageEnIO
    AttachedImageEn = View
    Background = clBtnFace
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clWindowText
    PreviewFont.Height = -11
    PreviewFont.Name = 'MS Sans Serif'
    PreviewFont.Style = []
    Left = 120
    Top = 88
  end
end
