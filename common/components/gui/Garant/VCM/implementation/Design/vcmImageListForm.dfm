object vcmImageList: TvcmImageList
  Left = 295
  Top = 92
  Width = 524
  Height = 617
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object BitBtn1: TBitBtn
    Left = 56
    Top = 56
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object BitBtn2: TBitBtn
    Left = 56
    Top = 96
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object ListView: TListView
    Left = 0
    Top = 0
    Width = 516
    Height = 585
    Align = alClient
    Columns = <
      item
      end>
    TabOrder = 0
    OnDblClick = ListViewDblClick
    OnResize = ListViewResize
  end
end
