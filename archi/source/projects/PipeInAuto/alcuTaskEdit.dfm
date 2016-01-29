object SchedulerTaskEditDlg: TSchedulerTaskEditDlg
  Left = 1749
  Top = 404
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1086#1077' '#1079#1072#1076#1072#1085#1080#1077
  ClientHeight = 209
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 8
    Top = 66
    Width = 50
    Height = 14
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077
  end
  object Label2: TLabel
    Left = 8
    Top = 92
    Width = 33
    Height = 14
    Caption = #1042#1088#1077#1084#1103
  end
  object Label4: TLabel
    Left = 8
    Top = 38
    Width = 79
    Height = 14
    Caption = #1055#1077#1088#1080#1086#1076#1080#1095#1085#1086#1089#1090#1100
  end
  object Label3: TLabel
    Left = 8
    Top = 16
    Width = 18
    Height = 14
    Caption = #1058#1080#1087
  end
  object Edit1: TEdit
    Left = 96
    Top = 60
    Width = 225
    Height = 22
    TabOrder = 1
    OnChange = Edit1Change
  end
  object DateTimePicker1: TDateTimePicker
    Left = 96
    Top = 86
    Width = 225
    Height = 22
    Date = 37964.749169930550000000
    Time = 37964.749169930550000000
    Kind = dtkTime
    TabOrder = 2
  end
  object ComboBox1: TComboBox
    Left = 96
    Top = 34
    Width = 225
    Height = 22
    Style = csDropDownList
    ItemHeight = 14
    TabOrder = 0
    OnChange = ComboBox1Change
    OnSelect = ComboBox1Change
    Items.Strings = (
      #1054#1076#1080#1085' '#1088#1072#1079
      #1050#1072#1078#1076#1099#1081' '#1076#1077#1085#1100
      #1050#1072#1078#1076#1091#1102' '#1085#1077#1076#1077#1083#1102
      #1050#1072#1078#1076#1099#1081' '#1084#1077#1089#1103#1094
      #1050#1072#1078#1076#1099#1081' '#1075#1086#1076)
  end
  object btnOk: TButton
    Left = 160
    Top = 176
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    TabOrder = 3
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 248
    Top = 176
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 4
  end
  object cbTaskType: TComboBox
    Left = 96
    Top = 8
    Width = 225
    Height = 22
    Style = csDropDownList
    ItemHeight = 14
    TabOrder = 5
    OnChange = cbTaskTypeChange
    Items.Strings = (
      #1045#1078#1077#1085#1077#1076#1077#1083#1100#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
      #1045#1078#1077#1076#1085#1077#1074#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
      #1044#1077#1085#1100' '#1088#1086#1078#1076#1077#1085#1080#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      #1055#1088#1072#1079#1076#1085#1080#1082
      #1055#1088#1086#1092#1080#1083#1072#1082#1090#1080#1082#1072
      #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080#1081' '#1101#1082#1089#1087#1086#1088#1090
      #1069#1082#1089#1087#1086#1088#1090' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1076#1083#1103' '#1060#1053#1057' '#1056#1060
      #1048#1084#1087#1086#1088#1090' '#1074#1085#1077#1096#1085#1080#1093' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      #1040#1074#1090#1086#1082#1083#1072#1089#1089#1080#1092#1080#1082#1072#1094#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074)
  end
  object btnSubTasks: TButton
    Left = 8
    Top = 176
    Width = 89
    Height = 25
    Caption = #1042#1083#1086#1078#1077#1085#1085#1099#1077'...'
    TabOrder = 6
    OnClick = btnSubTasksClick
  end
end
