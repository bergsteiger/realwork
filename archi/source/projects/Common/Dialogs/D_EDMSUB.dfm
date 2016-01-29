object NewSubDlg: TNewSubDlg
  Left = 485
  Top = 357
  ActiveControl = edtSubName
  AutoScroll = False
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1053#1054#1042#1040#1071' '#1052#1045#1058#1050#1040
  ClientHeight = 295
  ClientWidth = 437
  Color = clBtnFace
  Constraints.MinHeight = 180
  Constraints.MinWidth = 445
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 254
    Width = 437
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      437
      41)
    object OKBtn: TBitBtn
      Left = 5
      Top = 7
      Width = 77
      Height = 27
      Anchors = [akTop, akRight]
      TabOrder = 0
      OnClick = OKBtnClick
      Kind = bkOK
      Margin = 2
      Spacing = -1
      IsControl = True
    end
    object CancelBtn: TBitBtn
      Left = 267
      Top = 7
      Width = 77
      Height = 27
      Anchors = [akTop, akRight]
      TabOrder = 1
      Kind = bkCancel
      Margin = 2
      Spacing = -1
      IsControl = True
    end
    object HelpBtn: TBitBtn
      Left = 354
      Top = 7
      Width = 77
      Height = 27
      Anchors = [akTop, akRight]
      Caption = 'Help'
      TabOrder = 2
      Kind = bkHelp
      Margin = 2
      Spacing = -1
      IsControl = True
    end
    object AllBtn: TBitBtn
      Left = 92
      Top = 7
      Width = 77
      Height = 27
      Anchors = [akTop, akRight]
      Caption = 'All'
      TabOrder = 3
      OnClick = OKBtnClick
      Kind = bkAll
    end
    object NoBtn: TBitBtn
      Left = 180
      Top = 7
      Width = 77
      Height = 27
      Anchors = [akTop, akRight]
      Caption = 'No'
      TabOrder = 4
      Kind = bkNo
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 437
    Height = 184
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      437
      184)
    object Label2: TLabel
      Left = 8
      Top = 155
      Width = 53
      Height = 20
      Alignment = taRightJustify
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = #1053#1086#1084#1077#1088
    end
    object Label1: TLabel
      Left = 13
      Top = 8
      Width = 46
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1048#1084#1103
    end
    object edtSubNum: TvtSpinEdit
      Left = 72
      Top = 152
      Width = 132
      Height = 25
      MaxValue = 1073741820.000000000000000000
      Value = 1.000000000000000000
      Anchors = [akLeft, akBottom]
      TabOrder = 1
    end
    object edtSubName: TevMemo
      Left = 72
      Top = 7
      Width = 359
      Height = 140
      Anchors = [akLeft, akTop, akRight, akBottom]
      RMargin = 8
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      TabStop = True
      BorderStyle = bsSingle
    end
    object stCounter: TStaticText
      Left = 352
      Top = 154
      Width = 77
      Height = 20
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = '888/888'
      TabOrder = 2
    end
  end
  object pnlType: TPanel
    Left = 0
    Top = 184
    Width = 437
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Label3: TLabel
      Left = 8
      Top = 10
      Width = 53
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1058#1080#1087
    end
    object cbPosition: TComboBox
      Left = 72
      Top = 6
      Width = 224
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      ItemIndex = 0
      TabOrder = 0
      Text = #1086#1073#1099#1095#1085#1099#1081
      OnChange = cbPositionChange
      Items.Strings = (
        #1086#1073#1099#1095#1085#1099#1081
        #1089#1083#1077#1074#1072
        #1089#1087#1088#1072#1074#1072)
    end
  end
  object pnlStyle: TPanel
    Left = 0
    Top = 220
    Width = 437
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Label6: TLabel
      Left = 8
      Top = 10
      Width = 53
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1057#1090#1080#1083#1100
    end
    object cbStyle: TvtComboBox
      Left = 71
      Top = 6
      Width = 361
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 0
    end
  end
end
