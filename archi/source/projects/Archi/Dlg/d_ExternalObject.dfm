inherited ExternalObjectDlg: TExternalObjectDlg
  Left = 396
  Top = 216
  Caption = #1042#1085#1077#1096#1085#1080#1081' '#1086#1073#1098#1077#1082#1090
  ClientHeight = 188
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 143
  end
  inherited Panel1: TPanel
    Height = 143
    inherited lblText: TLabel
      Left = 12
      Top = 17
      Width = 172
      Caption = #1053#1086#1084#1077#1088' '#1086#1073#1098#1077#1082#1090#1085#1086#1075#1086' '#1090#1086#1087#1080#1082#1072
    end
    object lblObjType: TLabel [1]
      Left = 12
      Top = 78
      Width = 83
      Height = 19
      Anchors = [akLeft, akBottom]
      Caption = #1058#1080#1087' '#1086#1073#1098#1077#1082#1090#1072
    end
    inherited edtValue: TvtSpinEdit
      Top = 41
    end
    object cbObjType: TComboBox
      Left = 22
      Top = 102
      Width = 243
      Height = 24
      Hint = #1050#1086#1084#1072#1085#1076#1099' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1076#1086#1089#1090#1091#1087#1085#1099' '#1074' '#1082#1086#1085#1090#1077#1082#1089#1090#1085#1086#1084' '#1084#1077#1085#1102
      Style = csDropDownList
      Anchors = [akLeft, akBottom]
      ItemHeight = 16
      ItemIndex = 0
      PopupMenu = menuObjectType
      TabOrder = 1
      Text = #1044#1086#1082#1091#1084#1077#1085#1090' Word '
      Items.Strings = (
        #1044#1086#1082#1091#1084#1077#1085#1090' Word '
        #1058#1072#1073#1083#1080#1094#1072' Excel')
    end
  end
  object menuObjectType: TPopupMenu
    Left = 176
    Top = 72
    object itmAddObject: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      OnClick = itmAddObjectClick
    end
    object itmEdit: TMenuItem
      Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100
      OnClick = itmEditClick
    end
  end
end
