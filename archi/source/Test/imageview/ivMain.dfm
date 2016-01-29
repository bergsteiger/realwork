object Form1: TForm1
  Left = 336
  Top = 132
  Width = 1126
  Height = 850
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
  inline ImgViewer: TfrmImgViewer
    Left = 0
    Top = 0
    Width = 1110
    Height = 812
    Align = alClient
    TabOrder = 0
    inherited Splitter1: TSplitter
      Height = 782
    end
    inherited TumbView: TImageEnMView
      Height = 782
    end
    inherited PageView: TImageEnView
      Width = 970
      Height = 782
    end
    inherited Panel1: TPanel
      Width = 1110
    end
  end
end
