object gtImgPrvwDlg: TgtImgPrvwDlg
  Left = 300
  Top = 120
  Width = 265
  Height = 301
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Preview'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBgImgPrvw: TPanel
    Left = 0
    Top = 0
    Width = 257
    Height = 267
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    Color = clWindow
    TabOrder = 0
    object imgBgImgPrvw: TImage
      Left = 5
      Top = 5
      Width = 247
      Height = 257
      Align = alClient
      Center = True
      Stretch = True
    end
  end
end
