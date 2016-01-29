object MainForm: TMainForm
  Left = 346
  Top = 169
  Width = 659
  Height = 533
  Caption = #1054#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1077' '#1041#1044
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 456
    Width = 643
    Height = 19
    Panels = <>
  end
  object mInfo: TMemo
    Left = 0
    Top = 0
    Width = 643
    Height = 456
    TabStop = False
    Align = alClient
    Color = clBtnFace
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object MainMenu: TMainMenu
    Left = 79
    Top = 32
    object miFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object miArchiIni: TMenuItem
        Action = actArchiIni
      end
      object miExit: TMenuItem
        Action = actClose
      end
    end
    object miActions: TMenuItem
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      object miBuildCopy: TMenuItem
        Action = actMakeBaseCopy
      end
      object mReindex: TMenuItem
        Caption = #1055#1077#1088#1077#1080#1085#1076#1077#1082#1089#1072#1094#1080#1103
        object N2: TMenuItem
          Action = actReindexTable
        end
        object N5: TMenuItem
          Action = actReindexAllTables
        end
      end
      object N3: TMenuItem
        Action = actClearLocks
      end
      object FREE1: TMenuItem
        Action = actUpdateFreeTable
      end
      object LinkDict1: TMenuItem
        Action = actDeleteBadLinkToDict
      end
      object N1: TMenuItem
        Action = actReplaceLinks
      end
      object N4: TMenuItem
        Action = actJrnlUnpack
      end
      object N6: TMenuItem
        Action = acCorrectForbiddenValue
      end
      object N7: TMenuItem
        Action = acRecoverSortDate
      end
      object N8: TMenuItem
        Action = acRecoverPriority
      end
    end
  end
  object ActionList: TActionList
    Left = 25
    Top = 26
    object actClose: TAction
      Category = #1060#1072#1081#1083
      Caption = #1042#1099#1093#1086#1076
      OnExecute = actCloseExecute
    end
    object actArchiIni: TAction
      Category = #1060#1072#1081#1083
      Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093
      OnExecute = actArchiIniExecute
    end
    object actWhoLock: TAction
      Category = #1047#1072#1093#1074#1072#1090#1099
      Caption = #1055#1086#1080#1089#1082' '#1079#1072#1093#1074#1072#1090#1095#1080#1082#1072
      ShortCut = 16460
      OnExecute = actWhoLockExecute
      OnUpdate = actDbServiceAvailable
    end
    object actClearLocks: TAction
      Category = #1047#1072#1093#1074#1072#1090#1099
      Caption = #1063#1080#1089#1090#1082#1072' '#1079#1072#1093#1074#1072#1090#1086#1074
      OnExecute = actClearLocksExecute
      OnUpdate = actDbServiceAvailable
    end
    object ActRepairTable: TAction
      Category = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077
      Caption = #1055#1086#1095#1080#1085#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091' ...'
      OnExecute = ActRepairTableExecute
      OnUpdate = actDbServiceAvailable
    end
    object actReindexTable: TAction
      Category = #1055#1077#1088#1077#1080#1085#1076#1077#1082#1089#1072#1094#1080#1103
      Caption = #1058#1072#1073#1083#1080#1094#1072' ...'
      OnExecute = actReindexTableExecute
      OnUpdate = actDbServiceAvailable
    end
    object actReindexAllTables: TAction
      Category = #1055#1077#1088#1077#1080#1085#1076#1077#1082#1089#1072#1094#1080#1103
      Caption = #1042#1089#1077' '#1090#1072#1073#1083#1080#1094#1099' '#1074' '#1087#1072#1087#1082#1077' ...'
      OnExecute = actReindexAllTablesExecute
      OnUpdate = actDbServiceAvailable
    end
    object actUpdateFreeTable: TAction
      Category = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1099' FREE'
      Hint = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1086' '#1089#1074#1086#1073#1086#1076#1085#1099#1093' '#1085#1086#1084#1077#1088#1072#1093
      OnExecute = actUpdateFreeTableExecute
      OnUpdate = actDbServiceAvailable
    end
    object actMakeBaseCopy: TAction
      Category = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1082#1086#1087#1080#1102' '#1073#1072#1079#1099'...'
      Hint = #1057#1086#1079#1076#1072#1085#1080#1080' '#1087#1091#1089#1090#1086#1081' '#1082#1086#1087#1080#1080' '#1073#1072#1079#1099' '#1089#1086' '#1089#1083#1086#1074#1072#1088#1103#1084#1080' '#1080#1083#1080' '#1073#1077#1079
      OnExecute = actMakeBaseCopyExecute
      OnUpdate = actDbServiceAvailable
    end
    object actReplaceLinks: TAction
      Category = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077
      Caption = #1047#1072#1084#1077#1085#1072' '#1089#1089#1099#1083#1086#1082' '#1085#1072' '#1101#1083#1077#1084#1077#1085#1090#1099' '#1089#1083#1086#1074#1072#1088#1103'...'
      OnExecute = actReplaceLinksExecute
    end
    object actDeleteBadLinkToDict: TAction
      Category = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077
      Caption = #1063#1080#1089#1090#1082#1072' '#1084#1091#1089#1086#1088#1072' '#1074' '#1072#1090#1088#1080#1073#1091#1090#1072#1093
      OnExecute = actDeleteBadLinkToDictExecute
    end
    object actJrnlUnpack: TAction
      Category = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077
      Caption = #1056#1072#1089#1087#1072#1082#1086#1074#1082#1072' '#1078#1091#1088#1085#1072#1083#1086#1074
      OnExecute = actJrnlUnpackExecute
    end
    object acCorrectForbiddenValue: TAction
      Category = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077
      Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100' '#1079#1072#1087#1088#1077#1097#1077#1085#1085#1099#1077' '#1079#1085#1072#1095#1077#1085#1080#1103
      OnExecute = acCorrectForbiddenValueExecute
    end
    object acRecoverSortDate: TAction
      Category = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1076#1072#1090#1091' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1080
      OnExecute = acRecoverSortDateExecute
    end
    object acRecoverPriority: TAction
      Category = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1074#1072#1078#1085#1086#1089#1090#1100
      OnExecute = acRecoverPriorityExecute
    end
  end
  object FileDialog: TOpenDialog
    Filter = '*.ini|*.ini|*.*|*.*'
    Left = 266
    Top = 38
  end
  object ApplicationEvents1: TApplicationEvents
    OnHint = ApplicationEvents1Hint
    Left = 452
    Top = 52
  end
  object XPManifest1: TXPManifest
    Left = 536
    Top = 56
  end
end
