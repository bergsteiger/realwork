object BorderParamDlg: TBorderParamDlg
  Left = 179
  Top = 118
  BorderStyle = bsDialog
  Caption = 'Параметры границ'
  ClientHeight = 129
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 4
    Top = 4
    Width = 33
    Height = 16
    Caption = 'Поля'
  end
  object Bevel1: TBevel
    Left = 44
    Top = 12
    Width = 365
    Height = 9
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 4
    Top = 28
    Width = 54
    Height = 16
    Caption = 'верхнее'
  end
  object Label3: TLabel
    Left = 4
    Top = 56
    Width = 49
    Height = 16
    Caption = 'нижнее'
  end
  object Label4: TLabel
    Left = 212
    Top = 28
    Width = 40
    Height = 16
    Caption = 'левое'
  end
  object Label5: TLabel
    Left = 212
    Top = 60
    Width = 48
    Height = 16
    Caption = 'правое'
  end
  object Bevel2: TBevel
    Left = 0
    Top = 88
    Width = 409
    Height = 13
    Shape = bsTopLine
  end
  object spinTop: TvtSpinEdit
    Left = 64
    Top = 24
    Width = 137
    Height = 25
    TabOrder = 0
  end
  object spinBottom: TvtSpinEdit
    Left = 64
    Top = 52
    Width = 137
    Height = 25
    TabOrder = 1
  end
  object spinLeft: TvtSpinEdit
    Left = 272
    Top = 24
    Width = 133
    Height = 25
    TabOrder = 2
  end
  object SpinRight: TvtSpinEdit
    Left = 272
    Top = 52
    Width = 133
    Height = 25
    TabOrder = 3
  end
  object Button1: TButton
    Left = 216
    Top = 96
    Width = 89
    Height = 28
    Caption = 'ОК'
    ModalResult = 1
    TabOrder = 4
  end
  object Button2: TButton
    Left = 316
    Top = 96
    Width = 89
    Height = 28
    Caption = 'Отмена'
    ModalResult = 2
    TabOrder = 5
  end
end
