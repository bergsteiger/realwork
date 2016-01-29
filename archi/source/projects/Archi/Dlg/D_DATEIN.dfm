object FindByJournalDlg: TFindByJournalDlg
  Left = 705
  Top = 194
  BorderStyle = bsDialog
  Caption = #1055#1054#1048#1057#1050' '
  ClientHeight = 237
  ClientWidth = 347
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
    Top = 196
    Width = 347
    Height = 41
    Align = alBottom
    TabOrder = 0
    object pnlButtonsRight: TPanel
      Left = 89
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
    Width = 347
    Height = 196
    Align = alClient
    TabOrder = 1
    object Label6: TLabel
      Left = 8
      Top = 145
      Width = 91
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082
    end
    object gbxStageStatus: TvtGroupBoxEx
      Left = 177
      Top = 4
      Width = 162
      Height = 62
      Caption = ' &'#1057#1090#1072#1090#1091#1089' '
      TabOrder = 0
      object cbxStageInc: TCheckBox
        Left = 10
        Top = 20
        Width = 134
        Height = 15
        Caption = ' '#1055#1086#1076#1082#1083#1102#1095#1077#1085#1085#1099#1077
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object cbxStageUnInc: TCheckBox
        Left = 10
        Top = 39
        Width = 143
        Height = 15
        Caption = ' '#1053#1077#1087#1086#1076#1082#1083#1102#1095#1077#1085#1085#1099#1077
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 4
      Width = 162
      Height = 137
      Caption = ' &'#1044#1080#1072#1087#1072#1079#1086#1085' '#1076#1072#1090' '
      TabOrder = 1
      object Label1: TLabel
        Left = 15
        Top = 40
        Width = 23
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'
      end
      object Label4: TLabel
        Left = 12
        Top = 77
        Width = 29
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = #1055#1054
        Color = clBtnFace
        ParentColor = False
      end
      object LowDateEdit: TvtDateEdit
        Left = 50
        Top = 35
        Width = 100
        Height = 24
        Style = csDropDown
        TabOrder = 0
      end
      object HighDateEdit: TvtDateEdit
        Left = 50
        Top = 72
        Width = 100
        Height = 24
        Style = csDropDown
        TabOrder = 1
      end
    end
    object gbxType: TvtGroupBoxEx
      Left = 178
      Top = 70
      Width = 162
      Height = 71
      Caption = ' '#1058#1080#1087' '
      TabOrder = 2
      object cbxNew: TCheckBox
        Left = 10
        Top = 22
        Width = 144
        Height = 17
        Caption = ' '#1053#1086#1074#1099#1077
        TabOrder = 0
      end
      object cbxChanged: TCheckBox
        Left = 10
        Top = 45
        Width = 144
        Height = 17
        Caption = ' '#1048#1079#1084#1077#1085#1080#1074#1096#1080#1077#1089#1103
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
    object cbUser: TComboBox
      Left = 9
      Top = 164
      Width = 330
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 3
    end
  end
end
