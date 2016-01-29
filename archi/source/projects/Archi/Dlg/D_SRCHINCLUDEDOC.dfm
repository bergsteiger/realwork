object SrchIncludeDocDlg: TSrchIncludeDocDlg
  Left = 438
  Top = 261
  ActiveControl = OKBtn
  BiDiMode = bdRightToLeftNoAlign
  BorderStyle = bsDialog
  Caption = 'ПОИСК '
  ClientHeight = 255
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object pnlButtons: TPanel
    Left = 0
    Top = 214
    Width = 386
    Height = 41
    Align = alBottom
    TabOrder = 0
    object pnlButtonsRight: TPanel
      Left = 128
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
    Width = 386
    Height = 214
    Align = alClient
    TabOrder = 1
    object Label6: TLabel
      Left = 8
      Top = 102
      Width = 91
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Разработчик'
    end
    object cbUser: TComboBox
      Left = 9
      Top = 124
      Width = 369
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 1
    end
    object cbxAttach: TCheckBox
      Left = 10
      Top = 162
      Width = 173
      Height = 17
      Caption = 'Подключенные'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object cbxChanged: TCheckBox
      Left = 10
      Top = 184
      Width = 168
      Height = 17
      Caption = 'Измененные'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 5
      Width = 370
      Height = 91
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
  end
end
