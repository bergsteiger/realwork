object MainForm: TMainForm
  Left = 295
  Top = 110
  BorderStyle = bsDialog
  Caption = #1055#1086#1076#1089#1095#1077#1090' '#1086#1073#1098#1077#1084#1072' '#1090#1077#1082#1089#1090#1072
  ClientHeight = 238
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 87
    Height = 14
    Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1087#1072#1087#1082#1072
  end
  object Label2: TLabel
    Left = 248
    Top = 8
    Width = 63
    Height = 14
    Caption = #1063#1090#1086' '#1089#1095#1080#1090#1072#1090#1100
  end
  object editStartFolder: TDirectoryEdit
    Left = 8
    Top = 24
    Width = 233
    Height = 21
    DialogKind = dkWin32
    GlyphKind = gkDropDown
    NumGlyphs = 1
    TabOrder = 0
    OnChange = editStartFolderChange
  end
  object listSubFolders: TListBox
    Left = 8
    Top = 48
    Width = 233
    Height = 153
    ItemHeight = 14
    MultiSelect = True
    TabOrder = 1
    OnClick = listSubFoldersClick
  end
  object ProgressBar: TProgressBar
    Left = 88
    Top = 216
    Width = 225
    Height = 10
    Smooth = True
    TabOrder = 2
    Visible = False
  end
  object comboFileType: TComboBox
    Left = 248
    Top = 24
    Width = 225
    Height = 22
    Style = csDropDownList
    ItemHeight = 14
    ItemIndex = 0
    TabOrder = 3
    Text = #1060#1086#1088#1084#1072#1090' '#1069#1074#1077#1088#1077#1089#1090' (*.evd)'
    Items.Strings = (
      #1060#1086#1088#1084#1072#1090' '#1069#1074#1077#1088#1077#1089#1090' (*.evd)'
      #1060#1086#1088#1084#1072#1090' NSRC (*.nsr)'
      #1060#1086#1088#1084#1072#1090' '#1069#1074#1077#1088#1077#1089#1090' '#1080' NSRC (*.evd '#1080' *.nsr)')
  end
  object GroupBox1: TGroupBox
    Left = 248
    Top = 48
    Width = 225
    Height = 153
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1087#1086#1076#1089#1095#1077#1090#1072
    TabOrder = 4
    object Bevel1: TBevel
      Left = 8
      Top = 72
      Width = 209
      Height = 9
      Shape = bsBottomLine
    end
    object editEverest: TLabeledEdit
      Left = 144
      Top = 16
      Width = 75
      Height = 22
      EditLabel.Width = 88
      EditLabel.Height = 14
      EditLabel.Caption = #1060#1086#1088#1084#1072#1090' '#1069#1074#1077#1088#1077#1089#1090
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 0
    end
    object editNSRC: TLabeledEdit
      Left = 144
      Top = 48
      Width = 75
      Height = 22
      EditLabel.Width = 71
      EditLabel.Height = 14
      EditLabel.Caption = #1060#1086#1088#1084#1072#1090' NSRC'
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 1
    end
    object editSum: TLabeledEdit
      Left = 144
      Top = 88
      Width = 75
      Height = 22
      EditLabel.Width = 35
      EditLabel.Height = 14
      EditLabel.Caption = #1057#1091#1084#1084#1072
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 2
    end
    object editFiles: TLabeledEdit
      Left = 144
      Top = 120
      Width = 75
      Height = 22
      EditLabel.Width = 71
      EditLabel.Height = 14
      EditLabel.Caption = #1042#1089#1077#1075#1086' '#1092#1072#1081#1083#1086#1074
      LabelPosition = lpLeft
      ReadOnly = True
      TabOrder = 3
    end
  end
  object Button1: TButton
    Left = 320
    Top = 208
    Width = 75
    Height = 25
    Caption = #1057#1095#1080#1090#1072#1090#1100
    Enabled = False
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 400
    Top = 208
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 6
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 208
    Width = 75
    Height = 25
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    TabOrder = 7
    OnClick = editStartFolderChange
  end
end
