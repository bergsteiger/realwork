object frmProgress: TfrmProgress
  Left = 352
  Top = 290
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 137
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gOverall: TGauge
    Left = 16
    Top = 24
    Width = 281
    Height = 20
    ForeColor = clBlue
    Progress = 0
  end
  object gFile: TGauge
    Left = 16
    Top = 72
    Width = 281
    Height = 20
    ForeColor = clBlue
    Progress = 0
  end
  object lbFile: TLabel
    Left = 18
    Top = 53
    Width = 279
    Height = 13
    AutoSize = False
  end
  object btnCancel: TBitBtn
    Left = 120
    Top = 104
    Width = 75
    Height = 25
    TabOrder = 0
    OnClick = btnCancelClick
    Kind = bkCancel
  end
end
