object HandlingDocDlg: THandlingDocDlg
  Left = 448
  Top = 188
  ActiveControl = edtLowDate
  BorderStyle = bsDialog
  Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099' '#1074' '#1086#1073#1088#1072#1073#1086#1090#1082#1077
  ClientHeight = 239
  ClientWidth = 414
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
    Top = 198
    Width = 414
    Height = 41
    Align = alBottom
    TabOrder = 0
    object pnlButtonsRight: TPanel
      Left = 156
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
    Width = 414
    Height = 198
    Align = alClient
    TabOrder = 1
    object Label6: TLabel
      Left = 8
      Top = 102
      Width = 91
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082
    end
    object Label7: TLabel
      Left = 12
      Top = 136
      Width = 88
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1069#1090#1072#1087
    end
    object Label8: TLabel
      Left = 12
      Top = 168
      Width = 88
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077
    end
    object Label4: TLabel
      Left = 56
      Top = 12
      Width = 41
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1044#1072#1090#1099
    end
    object cbUser: TComboBox
      Left = 107
      Top = 99
      Width = 299
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 1
    end
    object cbStage: TComboBox
      Left = 107
      Top = 131
      Width = 299
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 2
    end
    object cbStageType: TComboBox
      Left = 107
      Top = 164
      Width = 299
      Height = 22
      Style = csOwnerDrawFixed
      ItemHeight = 16
      TabOrder = 3
      Items.Strings = (
        '['#1042#1057#1045']'
        #1053#1072#1095#1072#1090#1099#1077
        #1047#1072#1082#1086#1085#1095#1077#1085#1085#1099#1077
        #1053#1077#1079#1072#1082#1086#1085#1095#1077#1085#1085#1099#1077)
    end
    object GroupBox2: TGroupBox
      Left = 106
      Top = 3
      Width = 300
      Height = 85
      TabOrder = 0
      object Label9: TLabel
        Left = 13
        Top = 26
        Width = 30
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = #1057
      end
      object Label10: TLabel
        Left = 8
        Top = 55
        Width = 37
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Caption = #1055#1054
      end
      object edtLowDate: TvtDateEdit
        Left = 57
        Top = 23
        Width = 121
        Height = 24
        Style = csDropDown
        TabOrder = 0
      end
      object edtHighDate: TvtDateEdit
        Left = 57
        Top = 52
        Width = 121
        Height = 24
        Style = csDropDown
        TabOrder = 1
      end
    end
  end
end
