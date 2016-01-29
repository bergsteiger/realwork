object BaseDlg: TBaseDlg
  Left = 402
  Top = 186
  Width = 448
  Height = 179
  BorderIcons = [biSystemMenu, biMaximize]
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  ShowHint = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 120
  TextHeight = 16
  object FormPanel: TPanel
    Left = 0
    Top = 0
    Width = 440
    Height = 147
    Align = alClient
    TabOrder = 0
    object pnButtons: TPanel
      Left = 1
      Top = 104
      Width = 438
      Height = 42
      Align = alBottom
      TabOrder = 0
      object btOk: TBitBtn
        Left = 6
        Top = 8
        Width = 97
        Height = 27
        TabOrder = 0
        Kind = bkOK
        Margin = 2
        Spacing = -1
        IsControl = True
      end
      object btCancel: TBitBtn
        Left = 105
        Top = 8
        Width = 97
        Height = 27
        TabOrder = 1
        Kind = bkCancel
        Margin = 2
        Spacing = -1
        IsControl = True
      end
    end
    object pnMain: TPanel
      Left = 1
      Top = 1
      Width = 438
      Height = 103
      Align = alClient
      TabOrder = 1
    end
  end
end
