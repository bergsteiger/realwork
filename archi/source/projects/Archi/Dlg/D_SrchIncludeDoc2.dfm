object SrchIncludeDoc2Dlg: TSrchIncludeDoc2Dlg
  Left = 438
  Top = 261
  ActiveControl = OKBtn
  BiDiMode = bdRightToLeftNoAlign
  BorderStyle = bsDialog
  Caption = 'ПОИСК '
  ClientHeight = 152
  ClientWidth = 429
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object pnlButtons: TPanel
    Left = 0
    Top = 111
    Width = 429
    Height = 41
    Align = alBottom
    TabOrder = 0
    object pnlButtonsRight: TPanel
      Left = 171
      Top = 1
      Width = 257
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object OKBtn: TBitBtn
        Left = 6
        Top = 6
        Width = 77
        Height = 27
        TabOrder = 0
        Kind = bkOK
        Margin = 2
        Spacing = -1
        IsControl = True
      end
      object CancelBtn: TBitBtn
        Left = 90
        Top = 6
        Width = 77
        Height = 27
        TabOrder = 1
        Kind = bkCancel
        Margin = 2
        Spacing = -1
        IsControl = True
      end
      object HelpBtn: TBitBtn
        Left = 174
        Top = 6
        Width = 77
        Height = 27
        Caption = 'Help'
        TabOrder = 2
        Kind = bkHelp
        Margin = 2
        Spacing = -1
        IsControl = True
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 429
    Height = 111
    Align = alClient
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 8
      Top = 5
      Width = 154
      Height = 98
      Caption = ' &Диапазон дат '
      TabOrder = 0
      object Label1: TLabel
        Left = 12
        Top = 25
        Width = 23
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'
      end
      object Label4: TLabel
        Left = 9
        Top = 62
        Width = 29
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'ПО'
        Color = clBtnFace
        ParentColor = False
      end
      object edtLowDate: TvtDateEdit
        Left = 47
        Top = 20
        Width = 100
        Height = 24
        ButtonStyle = cbsDefault
        ImageIndex = 0
        ReadOnly = False
        Style = csDropDown
        TabOrder = 0
      end
      object edtHighDate: TvtDateEdit
        Left = 47
        Top = 57
        Width = 100
        Height = 24
        ButtonStyle = cbsDefault
        ImageIndex = 0
        ReadOnly = False
        Style = csDropDown
        TabOrder = 1
      end
    end
    object GroupBox2: TGroupBox
      Left = 168
      Top = 4
      Width = 255
      Height = 99
      Caption = ' Выборки '
      TabOrder = 1
      object cbxAttach: TCheckBox
        Left = 9
        Top = 17
        Width = 173
        Height = 17
        Caption = 'Подключенные'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object cbxAttachArh: TCheckBox
        Left = 9
        Top = 36
        Width = 193
        Height = 17
        Caption = 'Подключенные в Архивы'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object cbxChanged: TCheckBox
        Left = 9
        Top = 74
        Width = 168
        Height = 17
        Caption = 'Измененные'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object cbxAttachArhMos: TCheckBox
        Left = 9
        Top = 55
        Width = 242
        Height = 17
        Caption = 'Подключенные в Архивы Москва'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
    end
  end
end
