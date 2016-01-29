object evExtDlgInsertTable: TevExtDlgInsertTable
  Left = 318
  Top = 182
  ActiveControl = ColNumEdit
  BorderStyle = bsDialog
  Caption = 'Вставить таблицу'
  ClientHeight = 136
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -17
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 20
  object Bevel1: TBevel
    Left = 10
    Top = 10
    Width = 351
    Height = 116
    Shape = bsFrame
    IsControl = True
  end
  object Label1: TLabel
    Left = 17
    Top = 39
    Width = 191
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Количество столбцов'
  end
  object Label2: TLabel
    Left = 17
    Top = 79
    Width = 186
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Количество строк'
  end
  object OKBtn: TBitBtn
    Left = 373
    Top = 10
    Width = 105
    Height = 33
    TabOrder = 0
    Kind = bkOK
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 373
    Top = 50
    Width = 105
    Height = 33
    Caption = 'Отмена'
    TabOrder = 1
    Kind = bkCancel
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object HelpBtn: TBitBtn
    Left = 373
    Top = 90
    Width = 105
    Height = 33
    Caption = '&Помощь'
    TabOrder = 2
    Kind = bkHelp
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object ColNumEdit: TvtSpinEdit
    Left = 219
    Top = 32
    Width = 122
    Height = 28
    MaxValue = 255
    MinValue = 1
    Value = 3
    TabOrder = 3
  end
  object RowNumEdit: TvtSpinEdit
    Left = 219
    Top = 73
    Width = 122
    Height = 28
    MaxValue = 100
    MinValue = 1
    Value = 3
    TabOrder = 4
  end
end
