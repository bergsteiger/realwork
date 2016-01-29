inherited GetSubNamePropDlg: TGetSubNamePropDlg
  Left = 478
  Top = 264
  VertScrollBar.Range = 0
  AutoScroll = False
  BorderIcons = []
  Caption = #1040#1074#1090#1086#1079#1072#1084#1077#1085#1072' '#1080#1084#1077#1085' '#1084#1077#1090#1086#1082
  ClientHeight = 429
  ClientWidth = 640
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 384
    Width = 640
    inherited OK: TBitBtn
      Left = 455
    end
    inherited Cancel: TBitBtn
      Left = 364
      Enabled = False
      Visible = False
    end
    inherited Help: TBitBtn
      Left = 546
    end
  end
  inherited Panel1: TPanel
    Width = 640
    Height = 384
    object cbxNeedHeader: TCheckBox
      Left = 18
      Top = 14
      Width = 405
      Height = 17
      Caption = #1048#1089#1087#1088#1072#1074#1083#1103#1090#1100' '#1080#1084#1077#1085#1072' '#1084#1077#1090#1086#1082' '#1085#1072' '#1079#1072#1075#1086#1083#1086#1074#1082#1072#1093
      TabOrder = 0
    end
    object vtGroupBoxEx1: TvtGroupBoxEx
      Left = 10
      Top = 43
      Width = 621
      Height = 89
      Caption = 
        ' '#1059#1082#1072#1078#1080#1090#1077' '#1085#1072#1079#1074#1072#1085#1080#1103' '#1085#1091#1084#1077#1088#1086#1074#1072#1085#1085#1099#1093' '#1072#1073#1079#1072#1094#1077#1074', '#1085#1072#1095#1080#1085#1072#1102#1097#1080#1093#1089#1103' '#1089' '#1094#1080#1092#1088#1099' '#1089' '#1090 +
        #1086#1095#1082#1086#1081' ( 1. ) '
      TabOrder = 1
      ShapeType = stNone
      object rb1_1: TRadioButton
        Left = 33
        Top = 22
        Width = 113
        Height = 17
        Caption = #1055#1091#1085#1082#1090
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object rb1_2: TRadioButton
        Left = 33
        Top = 43
        Width = 113
        Height = 17
        Caption = #1063#1072#1089#1090#1100
        TabOrder = 1
      end
      object rb1_3: TRadioButton
        Left = 33
        Top = 64
        Width = 113
        Height = 17
        Caption = #1055#1072#1088#1072#1075#1088#1072#1092
        TabOrder = 2
      end
    end
    object vtGroupBoxEx2: TvtGroupBoxEx
      Left = 10
      Top = 137
      Width = 621
      Height = 67
      Caption = 
        ' '#1059#1082#1072#1078#1080#1090#1077' '#1085#1072#1079#1074#1072#1085#1080#1103' '#1085#1091#1084#1077#1088#1086#1074#1072#1085#1085#1099#1093' '#1072#1073#1079#1072#1094#1077#1074', '#1085#1072#1095#1080#1085#1072#1102#1097#1080#1093#1089#1103' '#1089' '#1094#1080#1092#1088#1099' '#1089' '#1090 +
        #1086#1095#1082#1086#1081' ( 1.1. ) '
      TabOrder = 2
      ShapeType = stNone
      object rb2_1: TRadioButton
        Left = 33
        Top = 22
        Width = 113
        Height = 17
        Caption = #1055#1091#1085#1082#1090
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object rb2_2: TRadioButton
        Left = 33
        Top = 43
        Width = 113
        Height = 17
        Caption = #1055#1086#1076#1087#1091#1085#1082#1090
        TabOrder = 1
      end
    end
    object vtGroupBoxEx3: TvtGroupBoxEx
      Left = 10
      Top = 210
      Width = 621
      Height = 67
      Caption = 
        ' '#1059#1082#1072#1078#1080#1090#1077' '#1085#1072#1079#1074#1072#1085#1080#1103' '#1085#1091#1084#1077#1088#1086#1074#1072#1085#1085#1099#1093' '#1072#1073#1079#1072#1094#1077#1074', '#1085#1072#1095#1080#1085#1072#1102#1097#1080#1093#1089#1103' '#1089' '#1094#1080#1092#1088#1099' '#1089' '#1090 +
        #1086#1095#1082#1086#1081' ( 1.1.1. ) '
      TabOrder = 3
      ShapeType = stNone
      object rb3_1: TRadioButton
        Left = 33
        Top = 22
        Width = 113
        Height = 17
        Caption = #1055#1091#1085#1082#1090
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object rb3_2: TRadioButton
        Left = 33
        Top = 43
        Width = 113
        Height = 17
        Caption = #1055#1086#1076#1087#1091#1085#1082#1090
        TabOrder = 1
      end
    end
    object vtGroupBoxEx4: TvtGroupBoxEx
      Left = 10
      Top = 284
      Width = 621
      Height = 89
      Caption = 
        ' '#1059#1082#1072#1078#1080#1090#1077' '#1085#1072#1079#1074#1072#1085#1080#1103' '#1085#1091#1084#1077#1088#1086#1074#1072#1085#1085#1099#1093' '#1072#1073#1079#1072#1094#1077#1074', '#1085#1072#1095#1080#1085#1072#1102#1097#1080#1093#1089#1103' '#1089' '#1094#1080#1092#1088#1099' ('#1073#1091 +
        #1082#1074#1099') '#1089#1086' '#1089#1082#1086#1073#1082#1086#1081'  ( '#1072') ) '
      TabOrder = 4
      ShapeType = stNone
      object rb4_1: TRadioButton
        Left = 33
        Top = 22
        Width = 113
        Height = 17
        Caption = #1055#1091#1085#1082#1090
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object rb4_2: TRadioButton
        Left = 33
        Top = 43
        Width = 113
        Height = 17
        Caption = #1055#1086#1076#1087#1091#1085#1082#1090
        TabOrder = 1
      end
      object rb4_3: TRadioButton
        Left = 33
        Top = 64
        Width = 113
        Height = 17
        Caption = #1055#1072#1088#1072#1075#1088#1072#1092
        TabOrder = 2
      end
    end
  end
end
