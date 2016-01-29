object ConfigDialog: TConfigDialog
  Left = 548
  Top = 178
  BorderStyle = bsDialog
  Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103
  ClientHeight = 391
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object OKBtn: TButton
    Left = 231
    Top = 352
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelBtn: TButton
    Left = 315
    Top = 352
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object PageControl2: TPageControl
    Left = 0
    Top = 0
    Width = 393
    Height = 345
    ActivePage = SchedulerTab
    TabOrder = 0
    object tsMainOptions: TTabSheet
      Caption = #1054#1073#1097#1080#1077
      object Label1: TLabel
        Left = 4
        Top = 4
        Width = 242
        Height = 14
        Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1093#1088#1072#1085#1077#1085#1080#1103' '#1080#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1085#1085#1099#1093' '#1092#1072#1081#1083#1086#1074
      end
      object Label14: TLabel
        Left = 4
        Top = 44
        Width = 282
        Height = 14
        Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1093#1088#1072#1085#1077#1085#1080#1103' '#1087#1086#1074#1088#1077#1078#1076#1077#1085#1085#1099#1093' '#1079#1072#1076#1072#1085#1080#1081' '#1085#1072' '#1080#1084#1087#1086#1088#1090
      end
      object Label5: TLabel
        Left = 4
        Top = 84
        Width = 164
        Height = 14
        Caption = #1051#1086#1082#1072#1083#1100#1085#1099#1081' '#1087#1091#1090#1100' '#1082' '#1087#1072#1087#1082#1077' '#1089' '#1073#1072#1079#1086#1081
      end
      object Label17: TLabel
        Left = 4
        Top = 124
        Width = 211
        Height = 14
        Caption = #1055#1072#1087#1082#1072' '#1089#1086' '#1089#1083#1086#1074#1072#1088#1103#1084#1080' '#1072#1074#1090#1086#1082#1083#1072#1089#1089#1080#1092#1080#1082#1072#1094#1080#1080
      end
      object dirSafe: TDirectoryEdit
        Left = 4
        Top = 20
        Width = 373
        Height = 21
        GlyphKind = gkEllipsis
        NumGlyphs = 1
        TabOrder = 0
      end
      object dirBadImport: TDirectoryEdit
        Left = 4
        Top = 60
        Width = 373
        Height = 21
        GlyphKind = gkEllipsis
        NumGlyphs = 1
        TabOrder = 1
      end
      object dirLocalFamilyPath: TDirectoryEdit
        Left = 4
        Top = 100
        Width = 373
        Height = 21
        GlyphKind = gkEllipsis
        NumGlyphs = 1
        TabOrder = 2
      end
      object cbSilentWork: TCheckBox
        Left = 0
        Top = 296
        Width = 365
        Height = 17
        Caption = #1053#1077' '#1091#1095#1072#1089#1090#1074#1086#1074#1072#1090#1100' '#1074' '#1088#1072#1089#1089#1099#1083#1082#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
        TabOrder = 4
      end
      object dirAutoClass: TDirectoryEdit
        Left = 4
        Top = 140
        Width = 373
        Height = 21
        GlyphKind = gkEllipsis
        NumGlyphs = 1
        ButtonWidth = 17
        TabOrder = 3
      end
      object GroupBox5: TGroupBox
        Left = 0
        Top = 168
        Width = 377
        Height = 73
        Caption = #1051#1086#1075'-'#1092#1072#1081#1083' "'#1040#1088#1093#1080#1074#1072#1088#1080#1091#1089#1072'"'
        TabOrder = 5
        object Label8: TLabel
          Left = 8
          Top = 48
          Width = 214
          Height = 14
          Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1099#1081' '#1088#1072#1079#1084#1077#1088' '#1092#1072#1081#1083#1072' ('#1074' '#1082#1073#1072#1081#1090#1072#1093')'
        end
        object fileArchiLogFileName: TFilenameEdit
          Left = 8
          Top = 14
          Width = 361
          Height = 21
          Filter = #1060#1072#1081#1083#1099' '#1083#1086#1075#1086#1074' (*.log)|*.log'
          GlyphKind = gkEllipsis
          NumGlyphs = 1
          TabOrder = 0
        end
        object spinMaxLogSize: TvtSpinEdit
          Left = 244
          Top = 43
          Width = 125
          Height = 22
          MaxValue = 4000000.000000000000000000
          TabOrder = 1
        end
      end
    end
    object tsEveryday: TTabSheet
      Caption = #1045#1078#1077#1076#1085#1077#1074#1085#1086
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 385
        Height = 316
        Align = alClient
        Caption = #1045#1078#1077#1076#1085#1077#1074#1085#1086#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
        TabOrder = 0
        object Label15: TLabel
          Left = 8
          Top = 244
          Width = 86
          Height = 14
          Caption = '"'#1052#1086#1089#1090' '#1082' '#1043#1072#1088#1076#1086#1082#1091'"'
        end
        object Label18: TLabel
          Left = 96
          Top = 292
          Width = 204
          Height = 14
          Caption = #1051#1080#1084#1080#1090' '#1089#1074#1086#1073#1086#1076#1085#1086#1075#1086' '#1084#1077#1089#1090#1072' '#1074' '#1043#1080#1075#1072#1073#1072#1081#1090#1072#1093' '
        end
        object cbUpdateBase: TCheckBox
          Left = 8
          Top = 92
          Width = 201
          Height = 17
          Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1072#1073#1083#1080#1094' '#1073#1072#1079#1099
          TabOrder = 1
        end
        object cbUpdateIndex: TCheckBox
          Left = 8
          Top = 168
          Width = 273
          Height = 17
          Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1077#1082#1089#1090#1086#1074#1086#1081' '#1095#1072#1089#1090#1080' '#1080' '#1080#1085#1076#1077#1082#1089#1072
          TabOrder = 2
        end
        object cbLoadKW: TCheckBox
          Left = 8
          Top = 200
          Width = 205
          Height = 17
          Caption = #1048#1084#1087#1086#1088#1090' KW-'#1092#1072#1081#1083#1072
          TabOrder = 4
          OnClick = cbLoadKWClick
        end
        object fileKWFileName: TFilenameEdit
          Left = 20
          Top = 220
          Width = 357
          Height = 21
          Filter = 'KW '#1092#1072#1081#1083#1099'|*.kw'
          Enabled = False
          GlyphKind = gkEllipsis
          NumGlyphs = 1
          TabOrder = 5
        end
        object cbDoEveryday: TCheckBox
          Left = 8
          Top = 16
          Width = 209
          Height = 17
          Caption = #1042#1099#1087#1086#1083#1085#1103#1090#1100' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = cbDoEverydayClick
        end
        object cbHeaderIndex: TCheckBox
          Left = 8
          Top = 184
          Width = 217
          Height = 17
          Caption = #1048#1085#1076#1077#1082#1089#1072#1094#1080#1103' '#1079#1072#1075#1086#1083#1086#1074#1082#1086#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
          TabOrder = 3
        end
        object dirGarDocPath: TDirectoryEdit
          Left = 20
          Top = 264
          Width = 357
          Height = 21
          GlyphKind = gkEllipsis
          NumGlyphs = 1
          TabOrder = 6
        end
        object GroupBox4: TGroupBox
          Left = 8
          Top = 36
          Width = 369
          Height = 129
          Caption = #1056#1077#1079#1077#1088#1074#1085#1086#1077' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1073#1072#1079#1099
          TabOrder = 7
          object Label11: TLabel
            Left = 216
            Top = 64
            Width = 75
            Height = 14
            Caption = #1061#1088#1072#1085#1080#1090#1100' '#1082#1086#1087#1080#1081
          end
          object cbCopyBase: TCheckBox
            Left = 8
            Top = 16
            Width = 301
            Height = 17
            Caption = #1042#1099#1087#1086#1083#1085#1103#1090#1100' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1089#1077#1084#1077#1081#1089#1090#1074#1072' '#1074' '#1087#1072#1087#1082#1091
            TabOrder = 0
            OnClick = cbCopyBaseClick
          end
          object dirBackup: TDirectoryEdit
            Left = 8
            Top = 36
            Width = 353
            Height = 21
            Enabled = False
            GlyphKind = gkEllipsis
            NumGlyphs = 1
            TabOrder = 1
          end
          object spinCountYesterday: TvtSpinEdit
            Left = 308
            Top = 60
            Width = 53
            Height = 22
            MaxValue = 7.000000000000000000
            Value = 7.000000000000000000
            TabOrder = 2
          end
          object cbMakeFullCopy: TCheckBox
            Left = 8
            Top = 80
            Width = 257
            Height = 17
            Caption = #1042#1099#1087#1086#1083#1085#1103#1090#1100' '#1087#1086#1083#1085#1086#1077' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1074' '#1087#1072#1087#1082#1091
            TabOrder = 3
            OnClick = cbMakeFullCopyClick
          end
          object dirFullBackup: TDirectoryEdit
            Left = 8
            Top = 100
            Width = 349
            Height = 21
            Enabled = False
            GlyphKind = gkEllipsis
            NumGlyphs = 1
            ButtonWidth = 20
            TabOrder = 4
          end
        end
        object spinFreeDiskLimit: TvtSpinEdit
          Left = 316
          Top = 288
          Width = 61
          Height = 22
          TabOrder = 8
        end
      end
    end
    object tsDelta: TTabSheet
      Caption = '"'#1044#1077#1083#1100#1090#1072'"'
      ImageIndex = 2
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 385
        Height = 316
        Align = alClient
        Caption = '"'#1044#1077#1083#1100#1090#1072'"'
        TabOrder = 0
        object Label3: TLabel
          Left = 8
          Top = 120
          Width = 191
          Height = 14
          Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1088#1077#1079#1077#1088#1074#1085#1086#1075#1086' '#1093#1088#1072#1085#1077#1085#1080#1103' '#1073#1072#1079#1099
        end
        object Label4: TLabel
          Left = 8
          Top = 176
          Width = 125
          Height = 14
          Caption = #1055#1072#1087#1082#1072' '#1080#1089#1093#1086#1076#1085#1099#1093' '#1092#1072#1081#1083#1086#1074
        end
        object Label2: TLabel
          Left = 8
          Top = 216
          Width = 164
          Height = 14
          Caption = #1055#1072#1087#1082#1072' '#1089' '#1075#1088#1072#1092#1080#1095#1077#1089#1082#1080#1084#1080' '#1092#1072#1081#1083#1072#1084#1080
        end
        object Label6: TLabel
          Left = 8
          Top = 256
          Width = 109
          Height = 14
          Caption = #1060#1072#1081#1083' '#1082#1083#1102#1095#1077#1074#1099#1093' '#1089#1083#1086#1074
        end
        object Label13: TLabel
          Left = 216
          Top = 164
          Width = 75
          Height = 14
          Caption = #1061#1088#1072#1085#1080#1090#1100' '#1082#1086#1087#1080#1081
        end
        object cbLoadDelta: TCheckBox
          Left = 8
          Top = 16
          Width = 153
          Height = 17
          Caption = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' "'#1044#1077#1083#1100#1090#1091'"'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = cbLoadDeltaClick
        end
        object dirBackupRoot: TDirectoryEdit
          Left = 8
          Top = 136
          Width = 369
          Height = 21
          AcceptFiles = True
          GlyphKind = gkEllipsis
          NumGlyphs = 1
          TabOrder = 3
        end
        object dirNSRC: TDirectoryEdit
          Left = 8
          Top = 192
          Width = 369
          Height = 21
          AcceptFiles = True
          GlyphKind = gkEllipsis
          NumGlyphs = 1
          TabOrder = 4
        end
        object dirPictures: TDirectoryEdit
          Left = 8
          Top = 232
          Width = 369
          Height = 21
          AcceptFiles = True
          GlyphKind = gkEllipsis
          NumGlyphs = 1
          TabOrder = 5
        end
        object fileKW: TFilenameEdit
          Left = 8
          Top = 272
          Width = 369
          Height = 21
          AcceptFiles = True
          Filter = 'KW '#1092#1072#1081#1083#1099'|*.kw'
          DialogOptions = [ofHideReadOnly, ofPathMustExist]
          GlyphKind = gkEllipsis
          NumGlyphs = 1
          TabOrder = 6
        end
        object cbUpdateTextIndex: TCheckBox
          Left = 8
          Top = 296
          Width = 269
          Height = 17
          Caption = #1054#1073#1085#1086#1074#1083#1103#1090#1100' '#1090#1077#1082'c'#1090#1086#1074#1099#1081' '#1080#1085#1076#1077#1082#1089
          TabOrder = 7
        end
        object cbWeekendBase: TCheckBox
          Left = 8
          Top = 76
          Width = 193
          Height = 17
          Caption = #1055#1072#1087#1082#1072' '#1073#1072#1079#1099' "'#1074#1099#1093#1086#1076#1085#1086#1075#1086' '#1076#1085#1103'"'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = cbWeekendBaseClick
        end
        object dirWeekendBase: TDirectoryEdit
          Left = 20
          Top = 96
          Width = 357
          Height = 21
          AcceptFiles = True
          GlyphKind = gkEllipsis
          NumGlyphs = 1
          TabOrder = 2
        end
        object cbPrepareDelta: TCheckBox
          Left = 8
          Top = 36
          Width = 261
          Height = 17
          Caption = #1060#1072#1081#1083', '#1087#1086#1076#1075#1086#1090#1072#1074#1083#1080#1074#1072#1102#1097#1080#1081' '#1080#1089#1093#1086#1076#1085#1099#1077' '#1092#1072#1081#1083#1099
          TabOrder = 8
        end
        object filePrepareDelta: TFilenameEdit
          Left = 24
          Top = 52
          Width = 353
          Height = 21
          AcceptFiles = True
          Filter = 
            #1050#1086#1084#1072#1085#1076#1085#1099#1077' '#1092#1072#1081#1083#1099' (*.bat)|*.bat|'#1048#1089#1087#1086#1083#1085#1103#1077#1084#1099#1077' '#1092#1072#1081#1083#1099' (*.exe)|*.exe|'#1042#1089 +
            #1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
          DialogOptions = [ofHideReadOnly, ofPathMustExist]
          GlyphKind = gkEllipsis
          NumGlyphs = 1
          TabOrder = 9
        end
        object spinBackupAge: TvtSpinEdit
          Left = 324
          Top = 160
          Width = 53
          Height = 22
          MaxValue = 12.000000000000000000
          Value = 8.000000000000000000
          TabOrder = 10
        end
      end
    end
    object tsNotification: TTabSheet
      Caption = #1059#1074#1077#1076#1086#1084#1083#1077#1085#1080#1077
      ImageIndex = 4
      object GroupBox6: TGroupBox
        Left = 2
        Top = 0
        Width = 380
        Height = 209
        Caption = #1054#1090#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1086#1095#1090#1099
        TabOrder = 0
        object editSMTPServer: TLabeledEdit
          Left = 108
          Top = 16
          Width = 100
          Height = 22
          EditLabel.Width = 67
          EditLabel.Height = 14
          EditLabel.Caption = 'SMTP '#1089#1077#1088#1074#1077#1088
          LabelPosition = lpLeft
          TabOrder = 0
        end
        object editSMTPPort: TLabeledEdit
          Left = 268
          Top = 16
          Width = 100
          Height = 22
          EditLabel.Width = 25
          EditLabel.Height = 14
          EditLabel.Caption = #1055#1086#1088#1090
          LabelPosition = lpLeft
          TabOrder = 1
          Text = '25'
        end
        object editPassword: TLabeledEdit
          Left = 268
          Top = 64
          Width = 100
          Height = 22
          EditLabel.Width = 37
          EditLabel.Height = 14
          EditLabel.Caption = #1055#1072#1088#1086#1083#1100
          Enabled = False
          LabelPosition = lpLeft
          PasswordChar = '*'
          TabOrder = 2
        end
        object editLogin: TLabeledEdit
          Left = 108
          Top = 64
          Width = 100
          Height = 22
          EditLabel.Width = 98
          EditLabel.Height = 14
          EditLabel.Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
          Enabled = False
          LabelPosition = lpLeft
          TabOrder = 3
        end
        object CheckBox1: TCheckBox
          Left = 12
          Top = 44
          Width = 169
          Height = 17
          Caption = #1058#1088#1077#1073#1091#1077#1090#1089#1103' '#1072#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
          TabOrder = 4
          OnClick = CheckBox1Click
        end
        object GroupBox1: TGroupBox
          Left = 8
          Top = 88
          Width = 365
          Height = 105
          Caption = #1040#1076#1088#1077#1089#1072' '#1088#1072#1089#1089#1099#1083#1082#1080
          TabOrder = 5
          DesignSize = (
            365
            105)
          object ListBox1: TListBox
            Left = 8
            Top = 16
            Width = 257
            Height = 81
            Anchors = [akLeft, akTop, akBottom]
            ItemHeight = 14
            TabOrder = 0
            OnDblClick = ListBox1DblClick
          end
          object AddEmailButton: TButton
            Left = 272
            Top = 16
            Width = 85
            Height = 25
            Caption = #1044#1086#1073#1072#1074#1080#1090#1100
            TabOrder = 1
            OnClick = AddEmailButtonClick
          end
          object EditEmailButton: TButton
            Left = 272
            Top = 44
            Width = 85
            Height = 25
            Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100
            TabOrder = 2
            OnClick = EditEmailButtonClick
          end
          object DelEmailButton: TButton
            Left = 272
            Top = 72
            Width = 85
            Height = 25
            Caption = #1059#1076#1072#1083#1080#1090#1100
            TabOrder = 3
            OnClick = DelEmailButtonClick
          end
        end
      end
      object GroupBox7: TGroupBox
        Left = 4
        Top = 216
        Width = 377
        Height = 97
        Caption = #1055#1086#1083#1091#1095#1077#1085#1080#1077' '#1087#1086#1095#1090#1099
        TabOrder = 1
        object editPOP3Server: TLabeledEdit
          Left = 112
          Top = 24
          Width = 100
          Height = 22
          EditLabel.Width = 66
          EditLabel.Height = 14
          EditLabel.Caption = 'POP3 '#1089#1077#1088#1074#1077#1088
          LabelPosition = lpLeft
          TabOrder = 0
        end
        object editPOP3Port: TLabeledEdit
          Left = 264
          Top = 24
          Width = 100
          Height = 22
          EditLabel.Width = 25
          EditLabel.Height = 14
          EditLabel.Caption = #1055#1086#1088#1090
          LabelPosition = lpLeft
          TabOrder = 1
          Text = '110'
        end
        object editPOP3Login: TLabeledEdit
          Left = 112
          Top = 56
          Width = 100
          Height = 22
          EditLabel.Width = 98
          EditLabel.Height = 14
          EditLabel.Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
          LabelPosition = lpLeft
          TabOrder = 2
        end
        object editPOP3Password: TLabeledEdit
          Left = 264
          Top = 56
          Width = 100
          Height = 22
          EditLabel.Width = 37
          EditLabel.Height = 14
          EditLabel.Caption = #1055#1072#1088#1086#1083#1100
          LabelPosition = lpLeft
          PasswordChar = '*'
          TabOrder = 3
        end
      end
    end
    object SchedulerTab: TTabSheet
      Caption = #1056#1072#1089#1087#1080#1089#1072#1085#1080#1077
      ImageIndex = 4
      object LabeledEdit1: TLabeledEdit
        Left = 4
        Top = 280
        Width = 377
        Height = 22
        EditLabel.Width = 87
        EditLabel.Height = 14
        EditLabel.Caption = #1058#1077#1082#1091#1097#1077#1077' '#1079#1072#1076#1072#1085#1080#1077
        ReadOnly = True
        TabOrder = 0
      end
      object TaskList: TListView
        Left = 208
        Top = 4
        Width = 175
        Height = 153
        Columns = <
          item
            AutoSize = True
            Caption = #1047#1072#1076#1072#1085#1080#1077
          end>
        IconOptions.WrapText = False
        ReadOnly = True
        ShowWorkAreas = True
        StateImages = TaskImages
        TabOrder = 1
        ViewStyle = vsReport
        OnDblClick = EditTaskButtonClick
        OnSelectItem = TaskListSelectItem
      end
      object AddTaskButton: TBitBtn
        Left = 208
        Top = 160
        Width = 81
        Height = 25
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        TabOrder = 2
        OnClick = AddTaskButtonClick
      end
      object EditTaskButton: TBitBtn
        Left = 296
        Top = 160
        Width = 88
        Height = 25
        Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100
        Enabled = False
        TabOrder = 3
        OnClick = EditTaskButtonClick
      end
      object DelTaskButton: TBitBtn
        Left = 208
        Top = 192
        Width = 81
        Height = 25
        Caption = #1059#1076#1072#1083#1080#1090#1100
        Enabled = False
        TabOrder = 4
        OnClick = DelTaskButtonClick
      end
      object cbShowEveryday: TCheckBox
        Left = 4
        Top = 240
        Width = 213
        Height = 17
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1077#1078#1077#1076#1085#1077#1074#1085#1099#1077' '#1079#1072#1076#1072#1085#1080#1103
        TabOrder = 5
        OnClick = cbShowEverydayClick
      end
      object ChangeDateButton: TButton
        Left = 296
        Top = 192
        Width = 88
        Height = 25
        Caption = #1057#1076#1074#1080#1085#1091#1090#1100
        Enabled = False
        TabOrder = 6
        OnClick = ChangeDateButtonClick
      end
    end
  end
  object TaskImages: TImageList
    Left = 196
    Top = 185
  end
end
