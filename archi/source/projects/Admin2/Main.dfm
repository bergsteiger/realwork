object MainForm: TMainForm
  Left = 421
  Top = 220
  Width = 777
  Height = 570
  Caption = '"'#1040#1088#1093#1080#1074#1072#1088#1080#1091#1089'". '#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088' '#1089#1080#1089#1090#1077#1084#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  OldCreateOrder = False
  OnInit = vcmMainFormInit
  Zones = <
    item
      Control = zMain
    end>
  SDI = True
  MenuManager = dmStdRes.MenuManager
  PixelsPerInch = 96
  TextHeight = 16
  object zMain: TPanel
    Left = 0
    Top = 0
    Width = 761
    Height = 515
    Align = alClient
    BevelOuter = bvNone
    Caption = 'zMain'
    TabOrder = 0
  end
  object nscStatusBar1: TvtStatusBar
    Left = 0
    Top = 515
    Width = 761
    Height = 19
    Panels = <
      item
        Width = 350
      end>
  end
  object Entities: TvcmEntities
    Entities = <
      item
        Name = 'enFile'
        Operations = <
          item
            Name = 'opExit'
            OnExecute = enFileopExitExecute
            Options = [vcm_ooShowInMainMenu]
          end>
      end
      item
        Name = 'enTools'
        Operations = <
          item
            Name = 'opBaseSwitch'
            OnTest = enToolsopBaseSwitchTest
            OnExecute = enToolsopBaseSwitchExecute
          end
          item
            Name = 'opSupervisorPassword'
            OnTest = enToolsopSupervisorPasswordTest
            OnExecute = enToolsopSupervisorPasswordExecute
            Options = [vcm_ooShowInMainMenu]
          end
          item
            Name = 'opDocIDRangeEdit'
            OnExecute = enToolsopDocIDRangeEditExecute
            Options = [vcm_ooShowInMainMenu, vcm_ooShowInChildMenu]
          end>
      end
      item
        Name = 'enExportImport'
        Operations = <
          item
            Name = 'opExport'
            OnExecute = enExportImportopExportExecute
            Options = [vcm_ooShowInMainToolbar, vcm_ooShowInContextMenu, vcm_ooShowInMainMenu]
          end
          item
            Name = 'opImport'
            OnExecute = enExportImportopImportExecute
            Options = [vcm_ooShowInMainToolbar, vcm_ooShowInContextMenu, vcm_ooShowInMainMenu]
          end>
      end>
    Left = 24
    Top = 16
  end
end
