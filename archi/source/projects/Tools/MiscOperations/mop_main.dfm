object Form1: TForm1
  Left = 446
  Top = 410
  Width = 594
  Height = 356
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ActionList1: TActionList
    Left = 528
    Top = 104
    object FileExit1: TFileExit
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Quits the application'
      ImageIndex = 43
    end
    object actExportLinkWithPages: TAction
      Category = 'Actions'
      Caption = #1042#1099#1083#1080#1074#1082#1072' '#1083#1080#1085#1082#1086#1074' '#1089' page'
      OnExecute = actExportLinkWithPagesExecute
    end
    object actImportLinkWithPages: TAction
      Category = 'Actions'
      Caption = #1047#1072#1083#1080#1074#1082#1072' pages '#1086#1073#1088#1072#1090#1085#1086' '#1074' '#1083#1080#1085#1082#1080
      OnExecute = actImportLinkWithPagesExecute
    end
    object acRemovePubBySubscribtion: TAction
      Category = 'Actions'
      Caption = #1059#1076#1072#1083#1080#1090#1100' "'#1087#1086#1083#1091#1095#1077#1085#1086' '#1087#1086' '#1088#1072#1089#1089#1099#1083#1082#1077'"'
      OnExecute = acRemovePubBySubscribtionExecute
    end
  end
  object MainMenu1: TMainMenu
    Left = 528
    Top = 72
    object File1: TMenuItem
      Caption = 'File'
      object Exit1: TMenuItem
        Action = FileExit1
      end
    end
    object N1: TMenuItem
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      object page1: TMenuItem
        Action = actExportLinkWithPages
      end
      object pages1: TMenuItem
        Action = actImportLinkWithPages
      end
      object N2: TMenuItem
        Action = acRemovePubBySubscribtion
      end
    end
  end
  object OpenDialog: TOpenDialog
    Filter = #1051#1102#1073#1086#1081' '#1092#1072#1081#1083' (*.*)|*.*'
    Left = 8
    Top = 16
  end
end
