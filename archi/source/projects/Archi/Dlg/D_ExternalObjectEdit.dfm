inherited ExternalObjEditDlg: TExternalObjEditDlg
  Left = 390
  Top = 211
  Caption = #1053#1086#1074#1099#1081' '#1074#1085#1077#1096#1085#1080#1081' '#1086#1073#1098#1077#1082#1090
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel1: TPanel
    object Label1: TLabel
      Left = 12
      Top = 16
      Width = 65
      Height = 16
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077
    end
    object Label2: TLabel
      Left = 12
      Top = 56
      Width = 81
      Height = 16
      Caption = #1056#1072#1089#1096#1080#1088#1077#1085#1080#1077
    end
    object Label3: TLabel
      Left = 12
      Top = 96
      Width = 89
      Height = 16
      Caption = #1058#1077#1082#1089#1090' '#1072#1073#1079#1072#1094#1072
    end
    object editDescription: TEdit
      Left = 112
      Top = 16
      Width = 333
      Height = 24
      TabOrder = 0
      OnChange = editDescriptionChange
    end
    object editExtension: TEdit
      Left = 112
      Top = 56
      Width = 121
      Height = 24
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 112
      Top = 96
      Width = 141
      Height = 24
      TabStop = False
      TabOrder = 2
      Text = #1057#1084'. '#1076#1072#1085#1085#1091#1102' '#1092#1086#1088#1084#1091' '#1074
    end
    object editSeeAlso: TEdit
      Left = 256
      Top = 96
      Width = 185
      Height = 24
      TabOrder = 3
      Text = #1088#1077#1076#1072#1082#1090#1086#1088#1077
      OnChange = editSeeAlsoChange
    end
  end
end
