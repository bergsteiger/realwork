inherited ConfigDlg: TConfigDlg
  Left = 413
  Top = 247
  VertScrollBar.Range = 0
  AutoScroll = False
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 337
  ClientWidth = 443
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 292
    Width = 443
    inherited OK: TBitBtn
      Left = 170
    end
    inherited Cancel: TBitBtn
      Left = 261
    end
    inherited Help: TBitBtn
      Left = 351
    end
  end
  inherited PageCtrl: TPageControl
    Width = 443
    Height = 292
    ActivePage = TabSheet4
    object TabSheet4: TTabSheet
      Caption = '&'#1055#1088#1086#1075#1088#1072#1084#1084#1072
      object Label6: TLabel
        Left = 8
        Top = 43
        Width = 177
        Height = 16
        Caption = #1050#1072#1090#1072#1083#1086#1075' '#1082#1086#1087#1080#1081' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      end
      object Label9: TLabel
        Left = 9
        Top = 104
        Width = 232
        Height = 16
        AutoSize = False
        Caption = #1044#1072#1090#1072' '#1089#1083#1077#1076#1091#1102#1097#1077#1075#1086' '#1074#1099#1087#1091#1089#1082#1072' '#1073#1072#1079#1099
      end
      object Label4: TLabel
        Left = 9
        Top = 160
        Width = 231
        Height = 16
        AutoSize = False
        Caption = #1044#1072#1090#1072' '#1072#1085#1086#1085#1089#1080#1088#1086#1074#1072#1085#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      end
      object chbGarantStyleQuery: TCheckBox
        Left = 8
        Top = 14
        Width = 361
        Height = 19
        Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1079#1072#1087#1088#1086#1089#1072' '#1082#1072#1082' '#1074' '#1043#1072#1088#1072#1085#1090#1077
        TabOrder = 0
      end
      object edtDocOnDiskDir: TDirectoryEdit
        Left = 6
        Top = 65
        Width = 422
        Height = 21
        NumGlyphs = 1
        TabOrder = 1
      end
      object edtNextVersion: TvtDateEdit
        Left = 10
        Top = 122
        Width = 121
        Height = 24
        Style = csDropDown
        TabOrder = 2
      end
      object cbVDFromServer: TCheckBox
        Left = 138
        Top = 128
        Width = 207
        Height = 17
        Caption = #1055#1086#1083#1091#1095#1072#1077#1090#1089#1103' '#1089' '#1089#1077#1088#1074#1077#1088#1072
        TabOrder = 3
        OnClick = cbVDFromServerClick
      end
      object edtAnounceDate: TvtDateEdit
        Left = 10
        Top = 178
        Width = 121
        Height = 24
        Enabled = False
        Style = csDropDown
        TabOrder = 4
      end
      object cbADFromServer: TCheckBox
        Left = 138
        Top = 184
        Width = 207
        Height = 17
        Caption = #1055#1086#1083#1091#1095#1072#1077#1090#1089#1103' '#1089' '#1089#1077#1088#1074#1077#1088#1072
        Checked = True
        Enabled = False
        State = cbChecked
        TabOrder = 5
        OnClick = cbVDFromServerClick
      end
      object chbMailNotifyByModalDialog: TCheckBox
        Left = 8
        Top = 215
        Width = 361
        Height = 19
        Caption = #1054#1087#1086#1074#1077#1097#1072#1090#1100' '#1086' '#1087#1086#1083#1091#1095#1077#1085#1080#1080' '#1087#1080#1089#1100#1084#1072' '#1076#1080#1072#1083#1086#1075#1086#1084
        TabOrder = 6
      end
    end
    object TabSheet5: TTabSheet
      Caption = '&'#1056#1077#1076#1072#1082#1090#1086#1088
      ImageIndex = 1
      DesignSize = (
        435
        261)
      object Label1: TLabel
        Left = 6
        Top = 125
        Width = 193
        Height = 16
        AutoSize = False
        Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1077#1084#1099#1077' '#1072#1090#1088#1080#1073#1091#1090#1099
      end
      object Label7: TLabel
        Left = 285
        Top = 10
        Width = 28
        Height = 16
        Caption = #1084#1080#1085'.'
      end
      object Label8: TLabel
        Left = 7
        Top = 60
        Width = 265
        Height = 16
        AutoSize = False
        Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1077#1084#1099#1077' '#1101#1083#1077#1084#1077#1085#1090#1099' '#1088#1077#1076#1072#1082#1090#1086#1088#1072
      end
      object cbxAutoSave: TCheckBox
        Left = 7
        Top = 10
        Width = 188
        Height = 17
        Caption = ' '#1040#1074#1090#1086#1089#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1082#1072#1078#1076#1099#1077' '
        TabOrder = 0
      end
      object edtAutoSaveInterval: TvtSpinEdit
        Left = 195
        Top = 6
        Width = 83
        Height = 24
        MaxValue = 60.000000000000000000
        TabOrder = 1
      end
      object lstVisUserAttr: TvtDStringLister
        Left = 6
        Top = 150
        Width = 420
        Height = 98
        Sorted = False
        AutoRowHeight = False
        IntegralHeight = False
        MultiSelect = True
        ProtectColor.BackColor = clRed
        ProtectColor.TextColor = clWhite
        SelectColor.BackColor = clHighlight
        SelectColor.TextColor = clHighlightText
        SelectNonFocusColor.BackColor = clInactiveCaption
        SelectNonFocusColor.TextColor = clHighlightText
        PickedList = True
        Font.Charset = DEFAULT_CHARSET
        ParentColor = False
        TabOrder = 5
        TabStop = True
        Anchors = [akLeft, akTop, akRight, akBottom]
      end
      object cbxShowHRuller: TCheckBox
        Left = 13
        Top = 84
        Width = 214
        Height = 17
        Caption = #1043#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1072#1103' '#1083#1080#1085#1077#1081#1082#1072
        TabOrder = 3
      end
      object chbSychroNameWSpr: TCheckBox
        Left = 7
        Top = 34
        Width = 302
        Height = 17
        Caption = #1048#1089#1087#1088#1072#1074#1083#1103#1090#1100' '#1057#1087#1088#1072#1074#1082#1091' '#1074#1084#1077#1089#1090#1077' '#1089' '#1053#1072#1079#1074#1072#1085#1080#1077#1084
        TabOrder = 2
      end
      object cbxCheckScanImage: TCheckBox
        Left = 13
        Top = 102
        Width = 405
        Height = 17
        Caption = #1055#1088#1086#1074#1077#1088#1103#1090#1100' '#1085#1072#1083#1080#1095#1080#1077' '#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1085#1086#1075#1086' '#1086#1073#1088#1072#1079#1072
        TabOrder = 4
      end
    end
    object TabSheet6: TTabSheet
      Caption = '&'#1041#1072#1079#1072
      ImageIndex = 2
    end
    object TabSheet1: TTabSheet
      Caption = #1054#1088#1092#1086#1075#1088#1072#1092#1080#1103
      ImageIndex = 3
      object cbOrphoSkipThreeLetterWords: TCheckBox
        Left = 8
        Top = 16
        Width = 425
        Height = 17
        Caption = #1055#1088#1086#1087#1091#1089#1082#1072#1090#1100' '#1089#1083#1086#1074#1072' '#1080#1079' '#1090#1088#1105#1093' '#1080' '#1084#1077#1085#1100#1096#1077' '#1073#1091#1082#1074
        TabOrder = 0
      end
      object cbOrphoDotIsSeparator: TCheckBox
        Left = 8
        Top = 48
        Width = 281
        Height = 17
        Caption = #1057#1095#1080#1090#1072#1090#1100' '#1090#1086#1095#1082#1091' '#1088#1072#1079#1076#1077#1083#1080#1090#1077#1083#1077#1084' '#1089#1083#1086#1074
        TabOrder = 1
      end
    end
    object tsTech: TTabSheet
      Caption = #1058#1077#1093'.'
      ImageIndex = 4
      object Label5: TLabel
        Left = 7
        Top = 9
        Width = 144
        Height = 16
        Caption = #1059#1088#1086#1074#1077#1085#1100' '#1083#1086#1075#1080#1088#1086#1074#1072#1085#1080#1103
      end
      object edtMsgLevel: TvtSpinEdit
        Left = 161
        Top = 6
        Width = 83
        Height = 24
        MaxValue = 10.000000000000000000
        TabOrder = 0
      end
    end
  end
end
