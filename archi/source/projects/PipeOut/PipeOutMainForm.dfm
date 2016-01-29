object PipeOutForm: TPipeOutForm
  Left = 336
  Top = 272
  BorderStyle = bsDialog
  Caption = '"'#1040#1088#1093#1080#1074#1072#1088#1080#1091#1089'". '#1069#1082#1089#1087#1086#1088#1090' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
  ClientHeight = 372
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 344
    Width = 465
    Height = 15
    AutoSize = False
    Caption = ' '
    Transparent = False
  end
  object Label7: TLabel
    Left = 0
    Top = 359
    Width = 688
    Height = 13
    Align = alBottom
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1069#1090#1086' '#1089#1090#1088#1086#1082#1072' '#1089' '#1074#1077#1088#1089#1080#1077#1081' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object labelBaseFolder: TLabel
    Left = 472
    Top = 64
    Width = 209
    Height = 41
    Alignment = taCenter
    AutoSize = False
    Caption = #1055#1091#1090#1100' '#1082' '#1073#1072#1079#1077
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object labelMessage: TLabel
    Left = 8
    Top = 296
    Width = 465
    Height = 15
    AutoSize = False
  end
  object GoButton: TButton
    Left = 508
    Top = 12
    Width = 141
    Height = 45
    Caption = #1069#1082#1089#1087#1086#1088#1090
    Default = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = GoButtonClick
  end
  object AllProgressBar: TProgressBar
    Left = 8
    Top = 312
    Width = 465
    Height = 9
    Smooth = True
    TabOrder = 3
  end
  object groupWhat: TGroupBox
    Left = 8
    Top = 0
    Width = 465
    Height = 145
    Caption = ' '#1063#1090#1086' '
    TabOrder = 0
    object comboWhat: TComboBox
      Left = 8
      Top = 16
      Width = 145
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      ItemIndex = 3
      TabOrder = 0
      Text = #1055#1086#1080#1089#1082#1086#1074#1099#1081' '#1079#1072#1087#1088#1086#1089' '
      OnChange = comboWhatChange
      Items.Strings = (
        #1042#1089#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
        #1054#1076#1080#1085' '#1076#1086#1082#1091#1084#1077#1085#1090
        #1057#1087#1080#1089#1086#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
        #1055#1086#1080#1089#1082#1086#1074#1099#1081' '#1079#1072#1087#1088#1086#1089' ')
    end
    object checkDetails: TCheckListBox
      Left = 8
      Top = 48
      Width = 449
      Height = 81
      OnClickCheck = checkDetailsClickCheck
      Columns = 2
      ItemHeight = 15
      Items.Strings = (
        #1044#1086#1082#1091#1084#1077#1085#1090#1099
        #1057#1087#1088#1072#1074#1082#1080
        #1043#1088#1072#1092#1080#1095#1077#1089#1082#1080#1077' '#1086#1073#1088#1072#1079#1099
        #1056#1077#1076#1072#1082#1094#1080#1080' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
        #1040#1085#1085#1086#1090#1072#1094#1080#1080
        #1058#1086#1083#1100#1082#1086' '#1079#1072#1075#1086#1083#1086#1074#1086#1082
        #1058#1086#1083#1100#1082#1086' '#1089#1090#1088#1091#1082#1090#1091#1088#1072
        #1050#1072#1082' '#1040#1085#1086#1085#1089#1099
        #1060#1086#1088#1084#1091#1083#1099' '#1082#1072#1082' '#1082#1072#1088#1090#1080#1085#1082#1080)
      TabOrder = 1
    end
  end
  object groupHow: TGroupBox
    Left = 8
    Top = 160
    Width = 465
    Height = 137
    Caption = ' '#1050#1072#1082' '
    TabOrder = 1
    object Label8: TLabel
      Left = 8
      Top = 50
      Width = 36
      Height = 15
      Caption = #1055#1072#1087#1082#1072
    end
    object Label10: TLabel
      Left = 396
      Top = 82
      Width = 53
      Height = 15
      Caption = #1082#1080#1083#1086#1073#1072#1081#1090
      Visible = False
    end
    object Label2: TLabel
      Left = 6
      Top = 18
      Width = 194
      Height = 15
      Caption = #1064#1072#1073#1083#1086#1085' '#1080#1084#1077#1085#1080' '#1092#1072#1081#1083#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
    end
    object dirDestinationFolder: TDirectoryEdit
      Left = 56
      Top = 48
      Width = 401
      Height = 21
      DialogKind = dkWin32
      DialogText = #1059#1082#1072#1078#1080#1090#1077' '#1082#1072#1090#1072#1083#1086#1075' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      DialogOptions = [sdAllowCreate, sdPerformCreate]
      NumGlyphs = 1
      TabOrder = 0
      Text = 'c:\@Out'
    end
    object comboSplitType: TComboBox
      Left = 8
      Top = 80
      Width = 217
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      ItemIndex = 0
      TabOrder = 1
      Text = #1053#1077' '#1088#1072#1079#1076#1077#1083#1103#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
      OnChange = comboSplitTypeChange
      Items.Strings = (
        #1053#1077' '#1088#1072#1079#1076#1077#1083#1103#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
        #1056#1072#1079#1076#1077#1083#1103#1090#1100' '#1087#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1084
        #1056#1072#1079#1076#1077#1083#1103#1090#1100' '#1087#1086' '#1075#1088#1091#1087#1087#1072#1084' '#1076#1086#1089#1090#1091#1087#1072
        #1056#1072#1079#1076#1077#1083#1103#1090#1100' '#1087#1086' '#1088#1072#1079#1084#1077#1088#1091)
    end
    object spinPartSize: TvtSpinEdit
      Left = 240
      Top = 80
      Width = 145
      Height = 23
      UseMaxValue = False
      UseMinValue = False
      Value = 2048.000000000000000000
      TabOrder = 2
      Visible = False
    end
    object cbUpdate: TCheckBox
      Left = 8
      Top = 112
      Width = 225
      Height = 17
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1089#1091#1097#1077#1089#1090#1074#1091#1102#1097#1080#1077' '#1092#1072#1081#1083#1099
      TabOrder = 3
    end
    object editDocFileMask: TEdit
      Left = 208
      Top = 18
      Width = 121
      Height = 23
      TabOrder = 4
      Text = 'document'
    end
    object ComboFileFormat: TComboBox
      Left = 336
      Top = 18
      Width = 121
      Height = 23
      Style = csDropDownList
      ItemHeight = 15
      TabOrder = 5
      Items.Strings = (
        'EVD'
        'EVD text'
        'TXT'
        'NSRC'
        'RTF'
        'HTML')
    end
    object cbPaginateImages: TCheckBox
      Left = 240
      Top = 112
      Width = 217
      Height = 17
      Caption = #1054#1073#1088#1072#1079#1099' '#1087#1086#1089#1090#1088#1072#1085#1080#1095#1085#1086
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
  end
  object ProgressCurrent: TProgressBar
    Left = 8
    Top = 328
    Width = 465
    Height = 9
    Smooth = True
    TabOrder = 4
  end
  object AppEvents: TApplicationEvents
    OnIdle = AppEventsIdle
    Left = 520
    Top = 104
  end
end
