object cfHorizontal: TcfHorizontal
  Left = 252
  Top = 216
  Width = 696
  Height = 433
  Caption = 'a'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Height = -11
  OnShow = vcmContainerFormShow
  UserTypes = <
    item
      Name = 'utHUserProperties'
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
    end
    item
      Name = 'utHUserGroupProperties'
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1075#1088#1091#1087#1087#1099
    end>
  Zones = <
    item
      Control = zTop
      ZoneType = vcm_ztParent
    end
    item
      Control = zBottom
      ZoneType = vcm_ztChild
    end>
  PixelsPerInch = 96
  TextHeight = 14
  object zTop: TPanel
    Left = 0
    Top = 0
    Width = 680
    Height = 194
    Align = alTop
    BevelOuter = bvNone
    Caption = 'zTop'
    Constraints.MinHeight = 180
    TabOrder = 0
  end
  object zBottom: TPanel
    Left = 0
    Top = 197
    Width = 680
    Height = 200
    Align = alClient
    BevelOuter = bvNone
    Caption = 'zBottom'
    Constraints.MinHeight = 200
    TabOrder = 1
  end
  object Splitter1: TRxSplitter
    Left = 0
    Top = 194
    Width = 680
    Height = 3
    ControlFirst = zTop
    ControlSecond = zBottom
    Align = alTop
    ParentColor = True
  end
  object Entities: TvcmEntities
    Entities = <
      item
        Name = 'enTest'
        Operations = <
          item
            Name = 'opTest'
          end>
      end>
    Left = 10
    Top = 10
  end
end
