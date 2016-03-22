object EasyUpdateParamsForm: TEasyUpdateParamsForm
  Left = 428
  Top = 242
  Width = 570
  Height = 342
  BorderIcons = [biSystemMenu]
  Caption = #1043#1040#1056#1040#1053#1058': '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1075#1086' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103
  Color = 16382202
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object f_MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 554
    Height = 246
    Align = alClient
    TabOrder = 0
    object f_MainPageControl: TPageControl
      Left = 1
      Top = 1
      Width = 552
      Height = 244
      ActivePage = f_UpdateTabSheet
      Align = alClient
      TabOrder = 0
      object f_DownloadTabSheet: TTabSheet
        Caption = #1057#1082#1072#1095#1080#1074#1072#1085#1080#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1081
        object f_DownloadRestoreMinutesLabel: TLabel
          Left = 403
          Top = 44
          Width = 124
          Height = 13
          AutoSize = False
          Caption = #1084#1080#1085#1091#1090
        end
        object f_DownloadSaveToLabel: TLabel
          Left = 40
          Top = 86
          Width = 125
          Height = 13
          Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' '#1074
        end
        object f_DownloadUserAgentLabel: TLabel
          Left = 40
          Top = 116
          Width = 119
          Height = 13
          Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1094#1080#1088#1086#1074#1072#1090#1100' '#1082#1072#1082
        end
        object f_DownloadSendReportParametersLabel: TLabel
          Left = 40
          Top = 189
          Width = 173
          Height = 13
          Cursor = crHandPoint
          Caption = #1053#1072#1089#1090#1088#1086#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1086#1095#1090#1099
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = SendReportParametersLabelClick
        end
        object f_DownloadSendReportStatusLabel: TLabel
          Left = 382
          Top = 138
          Width = 145
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object f_DownloadRetryCheckBox: TCheckBox
          Left = 17
          Top = 24
          Width = 510
          Height = 17
          Caption = 
            #1042' '#1089#1083#1091#1095#1072#1077' '#1086#1090#1089#1091#1090#1089#1090#1074#1080#1103' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1081' '#1087#1086#1074#1090#1086#1088#1103#1090#1100' '#1087#1086#1087#1099#1090#1082#1091' '#1089#1082#1072#1095#1080#1074#1072#1085#1080#1103' '#1082#1072#1078#1076 +
            #1099#1077' 20 '#1084#1080#1085#1091#1090
          TabOrder = 0
        end
        object f_DownloadRestoreCheckBox: TCheckBox
          Left = 17
          Top = 43
          Width = 340
          Height = 17
          Caption = #1055#1088#1080' '#1086#1073#1088#1099#1074#1077' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103' '#1087#1099#1090#1072#1090#1100#1089#1103' '#1074#1086#1089#1089#1090#1072#1085#1072#1074#1083#1080#1074#1072#1090#1100' '#1074' '#1090#1077#1095#1077#1085#1080#1077
          TabOrder = 1
        end
        object f_DownloadRestoreEdit: TEdit
          Left = 360
          Top = 41
          Width = 39
          Height = 21
          AutoSize = False
          MaxLength = 2
          TabOrder = 2
          Text = '  '
          OnExit = DownloadRestoreEditExit
        end
        object f_DownloadSaveToEdit: TEdit
          Left = 172
          Top = 84
          Width = 330
          Height = 21
          AutoSize = False
          TabOrder = 3
        end
        object f_DownloadUserAgentEdit: TEdit
          Left = 172
          Top = 114
          Width = 355
          Height = 21
          AutoSize = False
          TabOrder = 4
        end
        object f_DownloadSendReportCheckBox: TCheckBox
          Left = 17
          Top = 136
          Width = 510
          Height = 17
          Caption = #1055#1086' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1080' '#1089#1082#1072#1095#1080#1074#1072#1085#1080#1103' '#1087#1086#1089#1099#1083#1072#1090#1100' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1077' '#1087#1086' '#1087#1086#1095#1090#1077
          TabOrder = 5
        end
        object f_DownloadRestoreAllBitBtn: TBitBtn
          Left = 282
          Top = 184
          Width = 245
          Height = 25
          Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
          TabOrder = 6
          OnClick = DownloadRestoreAllBitBtnClick
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
            33333333333F8888883F33330000324334222222443333388F3833333388F333
            000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
            F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
            223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
            3338888300003AAAAAAA33333333333888888833333333330000333333333333
            333333333333333333FFFFFF000033333333333344444433FFFF333333888888
            00003A444333333A22222438888F333338F3333800003A2243333333A2222438
            F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
            22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
            33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
            3333333333338888883333330000333333333333333333333333333333333333
            0000}
          NumGlyphs = 2
        end
        object f_DownloadSaveToSelectButton: TButton
          Left = 506
          Top = 83
          Width = 20
          Height = 20
          Caption = '...'
          TabOrder = 7
          OnClick = DownloadSaveToSelectButtonClick
        end
        object f_DownloadResumeCheckBox: TCheckBox
          Left = 17
          Top = 62
          Width = 510
          Height = 17
          Caption = #1055#1088#1086#1076#1086#1083#1078#1072#1090#1100' '#1087#1088#1077#1088#1074#1072#1085#1085#1086#1077' '#1089#1082#1072#1095#1080#1074#1072#1085#1080#1077' '#1087#1088#1080' '#1089#1083#1077#1076#1091#1102#1097#1077#1084' '#1079#1072#1087#1091#1089#1082#1077
          TabOrder = 8
        end
        object f_DownloadRevisionCheckBox: TCheckBox
          Left = 17
          Top = 5
          Width = 510
          Height = 17
          Caption = #1044#1086#1087#1091#1089#1082#1072#1090#1100' '#1087#1086#1074#1090#1086#1088#1085#1099#1077' '#1089#1082#1072#1095#1080#1074#1072#1085#1080#1103
          TabOrder = 9
        end
      end
      object f_UpdateTabSheet: TTabSheet
        Caption = #1055#1088#1080#1084#1077#1085#1077#1085#1080#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1081
        ImageIndex = 1
        object f_UpdateSearchInLabel: TLabel
          Left = 40
          Top = 72
          Width = 109
          Height = 13
          Caption = #1048#1089#1082#1072#1090#1100' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' '#1074
        end
        object f_UpdateAdminPasswordCommentLabel: TLabel
          Left = 265
          Top = 104
          Width = 204
          Height = 13
          Caption = '('#1077#1089#1083#1080' '#1086#1085' '#1086#1090#1083#1080#1095#1072#1077#1090#1089#1103' '#1086#1090' '#1091#1084#1086#1083#1095#1072#1090#1077#1083#1100#1085#1086#1075#1086')'
        end
        object f_UpdateSendReportParametersLabel: TLabel
          Left = 40
          Top = 189
          Width = 173
          Height = 13
          Cursor = crHandPoint
          Caption = #1053#1072#1089#1090#1088#1086#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1086#1095#1090#1099
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = SendReportParametersLabelClick
        end
        object f_UpdateAdminPasswordLabel: TLabel
          Left = 40
          Top = 104
          Width = 220
          Height = 13
          Cursor = crHandPoint
          Caption = #1047#1072#1076#1072#1090#1100' '#1087#1072#1088#1086#1083#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' ADMIN'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = UpdateAdminPasswordLabelClick
        end
        object f_UpdateSendReportStatusLabel: TLabel
          Left = 382
          Top = 138
          Width = 145
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object f_UpdateNoBackupCheckBox: TCheckBox
          Left = 17
          Top = 8
          Width = 510
          Height = 17
          Caption = #1054#1090#1082#1072#1079#1072#1090#1100#1089#1103' '#1086#1090' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1088#1077#1079#1077#1088#1074#1085#1086#1081' '#1082#1086#1087#1080#1080' ('#1085#1077' '#1088#1077#1082#1086#1084#1077#1085#1076#1091#1077#1090#1089#1103'!)'
          TabOrder = 0
        end
        object f_UpdateRemoveZipsCheckBox: TCheckBox
          Left = 17
          Top = 40
          Width = 510
          Height = 17
          Caption = #1059#1076#1072#1083#1103#1090#1100' '#1072#1088#1093#1080#1074#1099' '#1088#1072#1089#1087#1072#1082#1086#1074#1072#1085#1085#1099#1093' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1081' '#1080#1079' '#1087#1086#1076#1082#1072#1090#1072#1083#1086#1075#1072' Archive'
          TabOrder = 1
        end
        object f_UpdateSearchInEdit: TEdit
          Left = 172
          Top = 70
          Width = 330
          Height = 21
          AutoSize = False
          TabOrder = 2
        end
        object f_UpdateSendReportCheckBox: TCheckBox
          Left = 17
          Top = 136
          Width = 510
          Height = 17
          Caption = #1055#1086' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1080' '#1087#1088#1080#1084#1077#1085#1077#1085#1080#1103' '#1087#1086#1089#1099#1083#1072#1090#1100' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1077' '#1087#1086' '#1087#1086#1095#1090#1077
          TabOrder = 3
        end
        object f_UpdateRestoreAllBitBtn: TBitBtn
          Left = 282
          Top = 184
          Width = 245
          Height = 25
          Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
          TabOrder = 4
          OnClick = UpdateRestoreAllBitBtnClick
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
            33333333333F8888883F33330000324334222222443333388F3833333388F333
            000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
            F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
            223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
            3338888300003AAAAAAA33333333333888888833333333330000333333333333
            333333333333333333FFFFFF000033333333333344444433FFFF333333888888
            00003A444333333A22222438888F333338F3333800003A2243333333A2222438
            F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
            22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
            33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
            3333333333338888883333330000333333333333333333333333333333333333
            0000}
          NumGlyphs = 2
        end
        object f_UpdateSearchInSelectButton: TButton
          Left = 506
          Top = 69
          Width = 20
          Height = 20
          Caption = '...'
          TabOrder = 5
          OnClick = UpdateSearchInSelectButtonClick
        end
        object f_UpdateSkipWarningCheckBox: TCheckBox
          Left = 17
          Top = 159
          Width = 510
          Height = 17
          Caption = #1047#1072#1087#1091#1089#1082#1072#1090#1100' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1076#1072#1078#1077' '#1074' '#1089#1083#1091#1095#1072#1077' '#1085#1077#1093#1074#1072#1090#1082#1080' '#1084#1077#1089#1090#1072
          TabOrder = 6
        end
      end
      object f_ScheduleTabSheet: TTabSheet
        Caption = #1056#1072#1089#1087#1080#1089#1072#1085#1080#1077
        ImageIndex = 2
        object f_ScheduleRunAtEndCommandLineLabel: TLabel
          Left = 50
          Top = 72
          Width = 78
          Height = 13
          Caption = #1089' '#1087#1072#1088#1072#1084#1077#1090#1088#1072#1084#1080
        end
        object f_ScheduleDownloadEnabledCheckBox: TCheckBox
          Left = 17
          Top = 8
          Width = 510
          Height = 17
          Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1089#1082#1072#1095#1080#1074#1072#1085#1080#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1081
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object f_ScheduleUpdateEnabledCheckBox: TCheckBox
          Left = 17
          Top = 25
          Width = 510
          Height = 17
          Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1087#1088#1080#1084#1077#1085#1077#1085#1080#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1081
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object f_ScheduleRunAtEndApplicationEdit: TEdit
          Left = 135
          Top = 45
          Width = 367
          Height = 21
          AutoSize = False
          Enabled = False
          TabOrder = 2
        end
        object f_ScheduleRunAtEndCommandLineEdit: TEdit
          Left = 135
          Top = 69
          Width = 392
          Height = 21
          AutoSize = False
          Enabled = False
          TabOrder = 3
        end
        object f_ScheduleWeekGroupBox: TGroupBox
          Left = 17
          Top = 96
          Width = 510
          Height = 81
          Caption = #1047#1072#1087#1091#1089#1082#1072#1090#1100' '#1082#1072#1078#1076#1099#1081
          TabOrder = 4
          object f_ScheduleMondayCheckBox: TCheckBox
            Left = 15
            Top = 22
            Width = 90
            Height = 17
            Caption = #1055#1086#1085#1077#1076#1077#1083#1100#1085#1080#1082
            Checked = True
            State = cbChecked
            TabOrder = 0
            OnClick = ScheduleMondayCheckBoxClick
          end
          object f_ScheduleTuesdayCheckBox: TCheckBox
            Left = 15
            Top = 46
            Width = 90
            Height = 17
            Caption = #1042#1090#1086#1088#1085#1080#1082
            Checked = True
            State = cbChecked
            TabOrder = 1
            OnClick = ScheduleTuesdayCheckBoxClick
          end
          object f_ScheduleWednesdayCheckBox: TCheckBox
            Left = 151
            Top = 22
            Width = 65
            Height = 17
            Caption = #1057#1088#1077#1076#1072
            Checked = True
            State = cbChecked
            TabOrder = 2
            OnClick = ScheduleWednesdayCheckBoxClick
          end
          object f_ScheduleThursdayCheckBox: TCheckBox
            Left = 151
            Top = 46
            Width = 65
            Height = 17
            Caption = #1063#1077#1090#1074#1077#1088#1075
            Checked = True
            State = cbChecked
            TabOrder = 3
            OnClick = ScheduleThursdayCheckBoxClick
          end
          object f_ScheduleFridayCheckBox: TCheckBox
            Left = 264
            Top = 22
            Width = 65
            Height = 17
            Caption = #1055#1103#1090#1085#1080#1094#1072
            Checked = True
            State = cbChecked
            TabOrder = 4
            OnClick = ScheduleFridayCheckBoxClick
          end
          object f_ScheduleSaturdayCheckBox: TCheckBox
            Left = 264
            Top = 46
            Width = 65
            Height = 17
            Caption = #1057#1091#1073#1073#1086#1090#1072
            TabOrder = 5
            OnClick = ScheduleSaturdayCheckBoxClick
          end
          object f_ScheduleSundayCheckBox: TCheckBox
            Left = 372
            Top = 35
            Width = 90
            Height = 17
            Caption = #1042#1086#1089#1082#1088#1077#1089#1077#1085#1100#1077
            TabOrder = 6
            OnClick = ScheduleSundayCheckBoxClick
          end
          object f_ScheduleWednesdayEdit: TEdit
            Left = 219
            Top = 22
            Width = 33
            Height = 21
            MaxLength = 5
            TabOrder = 7
            OnExit = ScheduleWednesdayEditExit
          end
          object f_ScheduleMondayEdit: TEdit
            Left = 105
            Top = 22
            Width = 34
            Height = 21
            MaxLength = 5
            TabOrder = 8
            OnExit = ScheduleMondayEditExit
          end
          object f_ScheduleTuesdayEdit: TEdit
            Left = 105
            Top = 46
            Width = 33
            Height = 21
            MaxLength = 5
            TabOrder = 9
            OnExit = ScheduleTuesdayEditExit
          end
          object f_ScheduleThursdayEdit: TEdit
            Left = 219
            Top = 46
            Width = 33
            Height = 21
            MaxLength = 5
            TabOrder = 10
            OnExit = ScheduleThursdayEditExit
          end
          object f_ScheduleFridayEdit: TEdit
            Left = 329
            Top = 22
            Width = 33
            Height = 21
            MaxLength = 5
            TabOrder = 11
            OnExit = ScheduleFridayEditExit
          end
          object f_ScheduleSaturdayEdit: TEdit
            Left = 329
            Top = 46
            Width = 33
            Height = 21
            MaxLength = 5
            TabOrder = 12
            OnExit = ScheduleSaturdayEditExit
          end
          object f_ScheduleSundayEdit: TEdit
            Left = 462
            Top = 35
            Width = 33
            Height = 21
            Enabled = False
            MaxLength = 5
            TabOrder = 13
            OnExit = ScheduleSundayEditExit
          end
        end
        object f_ScheduleRestoreAllBitBtn: TBitBtn
          Left = 282
          Top = 184
          Width = 245
          Height = 25
          Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
          TabOrder = 5
          OnClick = ScheduleRestoreAllBitBtnClick
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
            33333333333F8888883F33330000324334222222443333388F3833333388F333
            000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
            F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
            223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
            3338888300003AAAAAAA33333333333888888833333333330000333333333333
            333333333333333333FFFFFF000033333333333344444433FFFF333333888888
            00003A444333333A22222438888F333338F3333800003A2243333333A2222438
            F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
            22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
            33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
            3333333333338888883333330000333333333333333333333333333333333333
            0000}
          NumGlyphs = 2
        end
        object f_ScheduleRunAtEndCheckBox: TCheckBox
          Left = 17
          Top = 48
          Width = 115
          Height = 17
          Caption = #1047#1072#1087#1091#1089#1082#1072#1090#1100' '#1074' '#1082#1086#1085#1094#1077
          TabOrder = 6
          OnClick = ScheduleRunAtEndCheckBoxClick
        end
        object f_ScheduleRunAtEndApplicationButton: TButton
          Left = 507
          Top = 45
          Width = 20
          Height = 20
          Caption = '...'
          Enabled = False
          TabOrder = 7
          OnClick = ScheduleRunAtEndButtonClick
        end
      end
    end
  end
  object f_BottomPanel: TPanel
    Left = 0
    Top = 246
    Width = 554
    Height = 57
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 1
    object f_CommonSaveBitBtn: TBitBtn
      Left = 315
      Top = 16
      Width = 107
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = CommonSaveBitBtnClick
      Kind = bkOK
    end
    object f_CommonCancelBitBtn: TBitBtn
      Left = 428
      Top = 16
      Width = 105
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      TabOrder = 1
      Kind = bkCancel
    end
    object f_CommonHelpBitBtn: TBitBtn
      Left = 19
      Top = 16
      Width = 97
      Height = 25
      Caption = #1057#1087#1088#1072#1074#1082#1072
      TabOrder = 2
      OnClick = CommonHelpBitBtnClick
      Kind = bkHelp
    end
  end
  object f_ScheduleRunAtEndOpenDialog: TOpenDialog
    DefaultExt = 'exe'
    Filter = '*.bat|*.bat|*.exe|*.exe|*.*|*.*'
    Options = [ofHideReadOnly, ofNoChangeDir, ofPathMustExist, ofFileMustExist, ofEnableSizing, ofDontAddToRecent]
    OptionsEx = [ofExNoPlacesBar]
    Left = 455
    Top = 60
  end
end
