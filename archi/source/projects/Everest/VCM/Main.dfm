object evpMain: TevpMain
  Left = 302
  Top = 123
  Width = 696
  Height = 480
  HelpType = htKeyword
  Caption = #1069#1074#1077#1088#1077#1089#1090
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = vcmMainFormCloseQuery
  UserTypes = <>
  Zones = <>
  MenuManager = dmStdRes.MenuManager
  PixelsPerInch = 120
  TextHeight = 16
  object Entities: TvcmEntities
    Entities = <
      item
        Name = 'File'
        Caption = #1060#1072#1081#1083
        Operations = <
          item
            Name = 'Exit'
            OnExecute = FileExitExecute
          end>
        Controls = <>
      end>
    Events = <>
    Left = 16
    Top = 16
  end
end
