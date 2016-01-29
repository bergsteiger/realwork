object ProcessDocList: TProcessDocList
  Left = 371
  Top = 342
  ActiveControl = btnCancel
  BorderIcons = [biMinimize]
  BorderStyle = bsDialog
  ClientHeight = 40
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Visible = True
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 16
  object pbList: TW95Meter
    Left = 9
    Top = 11
    Width = 280
    Percent = 30
    BorderStyle = bsNone
  end
  object Panel1: TPanel
    Left = 292
    Top = 0
    Width = 90
    Height = 40
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object btnCancel: TBitBtn
      Left = 7
      Top = 6
      Width = 77
      Height = 27
      TabOrder = 0
      OnClick = btnCancelClick
      Kind = bkCancel
      Margin = 2
      Spacing = -1
      IsControl = True
    end
  end
end
