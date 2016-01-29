object SpyForm: TSpyForm
  Left = 694
  Top = 355
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1048#1084#1087#1086#1088#1090' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074'. "'#1040#1088#1093#1080#1074#1072#1088#1080#1091#1089'"'
  ClientHeight = 373
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object VersionLabel: TLabel
    Left = 0
    Top = 360
    Width = 520
    Height = 13
    Align = alBottom
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'VersionLabel'
    Color = clBtnFace
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object pnlError: TPanel
    Left = 0
    Top = 0
    Width = 520
    Height = 17
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = ' Error'
    Color = clRed
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clYellow
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object pnlMessage: TPanel
    Left = 0
    Top = 17
    Width = 520
    Height = 17
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = ' Message'
    Color = clBlue
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object pnlMain: TPanel
    Left = 0
    Top = 34
    Width = 520
    Height = 326
    Align = alClient
    TabOrder = 2
    object Panel1: TPanel
      Left = 419
      Top = 1
      Width = 100
      Height = 324
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        100
        324)
      object btnGo: TButton
        Left = 10
        Top = 8
        Width = 75
        Height = 25
        Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
        Default = True
        TabOrder = 0
        OnClick = btnGoClick
      end
      object CancelButton: TButton
        Tag = 100
        Left = 10
        Top = 40
        Width = 75
        Height = 25
        Cancel = True
        Caption = #1042#1099#1093#1086#1076
        TabOrder = 1
        OnClick = CancelButtonClick
      end
      object HelpButton: TButton
        Left = 8
        Top = 286
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = #1055#1086#1084#1086#1097#1100
        TabOrder = 2
        Visible = False
        OnClick = HelpButtonClick
      end
    end
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 418
      Height = 324
      HelpContext = 1
      ActivePage = NSRCTab
      Align = alClient
      MultiLine = True
      TabOrder = 1
      OnChange = PageControl1Change
      object NSRCTab: TTabSheet
        HelpContext = 1
        Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099
        ImageIndex = 2
        DesignSize = (
          410
          295)
        object GroupBox1: TGroupBox
          Left = 0
          Top = 2
          Width = 411
          Height = 285
          Anchors = [akLeft, akTop, akRight, akBottom]
          TabOrder = 0
          DesignSize = (
            411
            285)
          object Label8: TLabel
            Left = 10
            Top = 103
            Width = 227
            Height = 14
            Caption = #1055#1072#1087#1082#1072' '#1089' '#1076#1072#1085#1085#1099#1084#1080' '#1076#1083#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074'-'#1086#1073#1098#1077#1082#1090#1086#1074
          end
          object Label9: TLabel
            Left = 11
            Top = 64
            Width = 88
            Height = 14
            Caption = #1055#1072#1087#1082#1072' '#1089' '#1076#1072#1085#1085#1099#1084#1080
          end
          object Label1: TLabel
            Left = 8
            Top = 152
            Width = 108
            Height = 14
            Caption = #1054#1073#1088#1072#1073#1086#1090#1082#1072' '#1087#1086#1074#1090#1086#1088#1086#1074
          end
          object Label2: TLabel
            Left = 8
            Top = 192
            Width = 80
            Height = 14
            Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
          end
          object Label3: TLabel
            Left = 8
            Top = 16
            Width = 99
            Height = 14
            Caption = #1044#1072#1085#1085#1099#1077' '#1074' '#1092#1086#1088#1084#1072#1090#1077
          end
          object deWorkDir: TDirectoryEdit
            Left = 10
            Top = 83
            Width = 391
            Height = 21
            DialogKind = dkWin32
            GlyphKind = gkDropDown
            NumGlyphs = 1
            TabOrder = 1
            OnChange = deWorkDirChange
          end
          object dirPicture: TDirectoryEdit
            Left = 10
            Top = 124
            Width = 391
            Height = 21
            DialogKind = dkWin32
            GlyphKind = gkDropDown
            NumGlyphs = 1
            TabOrder = 2
          end
          object comboInputType: TComboBox
            Left = 8
            Top = 36
            Width = 393
            Height = 22
            Style = csDropDownList
            ItemHeight = 14
            TabOrder = 0
            OnChange = comboInputTypeChange
            Items.Strings = (
              #1043#1072#1088#1072#1085#1090
              #1069#1074#1077#1088#1077#1089#1090
              'RTF-'#1040#1085#1085#1086#1090#1072#1094#1080#1080
              'TXT-'#1040#1085#1085#1086#1090#1072#1094#1080#1080
              #1055#1086#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1103' '#1040#1057
              #1055#1088#1086#1074#1077#1088#1082#1072' '#1050#1058)
          end
          object comboSameDocs: TComboBox
            Left = 8
            Top = 168
            Width = 393
            Height = 22
            Style = csDropDownList
            ItemHeight = 14
            ItemIndex = 2
            TabOrder = 3
            Text = #1055#1077#1088#1077#1079#1072#1087#1080#1089#1099#1074#1072#1090#1100' '#1076#1091#1073#1083#1080#1082#1072#1090#1099
            Items.Strings = (
              #1053#1077' '#1087#1088#1086#1074#1077#1088#1103#1090#1100' '#1085#1072' '#1087#1086#1074#1090#1086#1088#1099
              #1055#1088#1086#1087#1091#1089#1082#1072#1090#1100' '#1076#1091#1073#1083#1080#1082#1072#1090#1099
              #1055#1077#1088#1077#1079#1072#1087#1080#1089#1099#1074#1072#1090#1100' '#1076#1091#1073#1083#1080#1082#1072#1090#1099)
          end
          object chkImportParams: TCheckListBox
            Left = 8
            Top = 208
            Width = 393
            Height = 69
            Anchors = [akLeft, akTop, akBottom]
            Columns = 2
            ItemHeight = 14
            Items.Strings = (
              #1057#1087#1080#1089#1086#1082' '#1079#1072#1087#1086#1083#1085#1103#1077#1090#1089#1103' '#1074' run-time')
            TabOrder = 4
          end
        end
      end
      object Additional: TTabSheet
        HelpContext = 2
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
        ImageIndex = 1
        object lblMainInfo: TLabel
          Left = 4
          Top = 154
          Width = 389
          Height = 17
          AutoSize = False
          Caption = #1043#1083#1072#1074#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
          Visible = False
        end
        object Label15: TLabel
          Left = 4
          Top = 109
          Width = 175
          Height = 14
          Caption = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1086#1090' '#1080#1084#1077#1085#1080
        end
        object GroupBox2: TGroupBox
          Left = 0
          Top = 8
          Width = 396
          Height = 93
          Enabled = False
          TabOrder = 0
          object kwFileEdit: TFilenameEdit
            Left = 8
            Top = 20
            Width = 381
            Height = 21
            Enabled = False
            NumGlyphs = 1
            TabOrder = 0
          end
          object chkKWParams: TCheckListBox
            Left = 8
            Top = 48
            Width = 377
            Height = 33
            OnClickCheck = cbIsDeltaKWClick
            Columns = 2
            ItemHeight = 14
            Items.Strings = (
              #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1077#1088#1077#1076' '#1080#1084#1087#1086#1088#1090#1086#1084
              #1055#1086#1087#1086#1083#1085#1103#1090#1100' '#1089#1083#1086#1074#1072#1088#1100
              #1056#1072#1079#1085#1080#1094#1072)
            TabOrder = 1
          end
        end
        object ServerProgressBar: TProgressBar
          Left = 4
          Top = 169
          Width = 389
          Height = 14
          Smooth = True
          TabOrder = 1
          Visible = False
        end
        object comboUserList: TComboBox
          Left = 4
          Top = 125
          Width = 393
          Height = 22
          Style = csDropDownList
          ItemHeight = 14
          TabOrder = 2
        end
        object chbDictionCollect: TCheckBox
          Left = 9
          Top = 5
          Width = 208
          Height = 17
          Caption = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1082#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
          TabOrder = 3
          OnClick = chbDictionCollectClick
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'TabSheet2'
        ImageIndex = 5
        TabVisible = False
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 453
    Top = 81
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 424
    Top = 78
  end
  object MainMenu1: TMainMenu
    Left = 424
    Top = 113
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N3: TMenuItem
        Action = actExit
      end
    end
    object N2: TMenuItem
      Caption = #1059#1090#1080#1083#1080#1090#1099
      object N4: TMenuItem
        Action = actUpdateBase
      end
      object N5: TMenuItem
        Action = actRepairBase
      end
    end
    object mnuHelp: TMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
      Visible = False
      object N7: TMenuItem
        Action = actHelpContents
      end
    end
  end
  object ActionList1: TActionList
    Left = 456
    Top = 113
    object actExit: TAction
      Caption = #1042#1099#1093#1086#1076
      OnExecute = actExitExecute
    end
    object actUpdateBase: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1073#1072#1079#1091
      OnExecute = btnUpdateTablesClick
    end
    object actRepairBase: TAction
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1073#1072#1079#1091
      OnExecute = Button2Click
    end
    object Action1: TAction
      Caption = 'Action1'
    end
    object actHelpContents: THelpContents
      Category = #1055#1086#1084#1086#1097#1100
      Caption = '&'#1057#1086#1076#1077#1088#1078#1072#1085#1080#1077
      Hint = 'Help Contents'
      ImageIndex = 40
      OnExecute = actHelpContentsExecute
    end
    object actHelpContext: THelpContextAction
      Category = #1055#1086#1084#1086#1097#1100
      Caption = #1057#1087#1088#1072#1074#1082#1072
      ImageIndex = 11
      ShortCut = 112
      OnExecute = actHelpContextExecute
    end
  end
end
