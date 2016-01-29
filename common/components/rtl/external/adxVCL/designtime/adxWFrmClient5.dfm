inherited frmClient5: TfrmClient5
  Top = 351
  Caption = 'frmClient5'
  ClientHeight = 226
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblComment: TLabel
    Top = 25
    Width = 458
    Height = 65
  end
  inherited lblTitle: TLabel
    Width = 37
    Height = 15
    Font.Charset = RUSSIAN_CHARSET
    Font.Height = -12
    Font.Name = 'Arial'
  end
  object sgPages: TStringGrid
    Left = 15
    Top = 100
    Width = 371
    Height = 120
    ColCount = 3
    Ctl3D = True
    DefaultColWidth = 100
    DefaultRowHeight = 17
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing]
    ParentCtl3D = False
    TabOrder = 0
    OnKeyDown = sgPagesKeyDown
  end
  object btnAdd: TButton
    Left = 395
    Top = 100
    Width = 75
    Height = 25
    Caption = '&Add'
    TabOrder = 1
    OnClick = btnAddClick
  end
  object btnRemove: TButton
    Left = 395
    Top = 130
    Width = 75
    Height = 25
    Caption = '&Delete'
    TabOrder = 2
    OnClick = btnRemoveClick
  end
end
