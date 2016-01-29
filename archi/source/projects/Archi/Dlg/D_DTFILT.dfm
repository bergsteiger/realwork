inherited DocTypeFilterDlg: TDocTypeFilterDlg
  Left = 490
  Top = 191
  VertScrollBar.Range = 0
  AutoScroll = False
  Caption = #1060#1080#1083#1100#1090#1088' '#1090#1080#1087#1086#1074
  ClientHeight = 326
  ClientWidth = 385
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 281
    Width = 385
    inherited OK: TBitBtn
      Left = 111
    end
    inherited Cancel: TBitBtn
      Left = 202
    end
    inherited Help: TBitBtn
      Left = 292
    end
  end
  inherited Panel1: TPanel
    Width = 385
    Height = 281
    object lstTypes: TvtStringLister
      Left = 2
      Top = 2
      Width = 381
      Height = 249
      Items.Strings = (
        #1044#1086#1082#1091#1084#1077#1085#1090
        #1058#1077#1093'. '#1076#1086#1082#1091#1084#1077#1085#1090' (NoDoc)'
        #1050#1072#1083#1077#1085#1076#1072#1088#1100
        #1041#1080#1079#1085#1077#1089'-'#1089#1087#1088#1072#1074#1082#1072
        #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1076#1083#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
        'WEB-'#1089#1089#1099#1083#1082#1080
        #1053#1077#1076#1077#1081#1089#1090#1074#1091#1102#1097#1072#1103' '#1088#1077#1076#1072#1082#1094#1080#1103
        #1050#1085#1080#1075#1072
        #1048#1079#1084#1077#1085#1103#1102#1097#1080#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
        #1050#1072#1088#1090#1086#1095#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        #1044#1086#1089#1100#1077
        #1040#1040#1050'-'#1089#1086#1076#1077#1088#1078#1072#1085#1080#1077
        #1040#1040#1050'-'#1076#1086#1082#1091#1084#1077#1085#1090
        #1043#1088#1072#1092#1080#1082#1072
        #1057#1083#1086#1074#1072#1088#1085#1072#1103' '#1089#1090#1072#1090#1100#1103)
      Sorted = False
      AlienSource = False
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
      TabOrder = 0
      TabStop = True
      Anchors = [akLeft, akTop, akRight, akBottom]
    end
    object cbxIsDefault: TCheckBox
      Left = 7
      Top = 256
      Width = 290
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100' '#1082#1072#1082' '#1092#1080#1083#1100#1090#1088' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      TabOrder = 1
    end
  end
end
