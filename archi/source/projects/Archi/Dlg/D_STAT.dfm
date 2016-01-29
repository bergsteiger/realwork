object StatisticDlg: TStatisticDlg
  Left = 427
  Top = 217
  BorderStyle = bsDialog
  Caption = 'СТАТИСТИКА'
  ClientHeight = 287
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object pnlButtons: TPanel
    Left = 0
    Top = 246
    Width = 418
    Height = 41
    Align = alBottom
    TabOrder = 2
    object pnlButtonsRight: TPanel
      Left = 160
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
    Top = 209
    Width = 418
    Height = 37
    Align = alBottom
    TabOrder = 1
    object Label11: TLabel
      Left = 9
      Top = 11
      Width = 94
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Файл отчета'
    end
    object FilenameEdit1: TFilenameEdit
      Left = 112
      Top = 8
      Width = 299
      Height = 21
      NumGlyphs = 1
      TabOrder = 0
      Text = 'Report.txt'
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 418
    Height = 209
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = '&По документам'
      object Label1: TLabel
        Left = 3
        Top = 112
        Width = 138
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Группы документов'
      end
      object Label5: TLabel
        Left = 48
        Top = 12
        Width = 90
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Даты'
      end
      object cbDocGroupD: TComboBox
        Left = 148
        Top = 108
        Width = 257
        Height = 24
        Style = csDropDownList
        ItemHeight = 16
        TabOrder = 1
      end
      object chbShowUserD: TCheckBox
        Left = 11
        Top = 148
        Width = 366
        Height = 18
        Caption = '  показывать информацию о разработчиках'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object GroupBox1: TGroupBox
        Left = 148
        Top = 2
        Width = 256
        Height = 88
        TabOrder = 0
        object Label2: TLabel
          Left = 20
          Top = 26
          Width = 23
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'С'
        end
        object Label3: TLabel
          Left = 10
          Top = 55
          Width = 34
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'ПО'
        end
        object edtLowDateD: TvtDateEdit
          Left = 57
          Top = 23
          Width = 121
          Height = 24
          ButtonStyle = cbsDefault
          ImageIndex = 0
          ReadOnly = False
          Style = csDropDown
          TabOrder = 0
        end
        object edtHighDateD: TvtDateEdit
          Left = 57
          Top = 52
          Width = 121
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
end
