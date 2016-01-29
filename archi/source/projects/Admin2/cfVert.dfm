object cfVertical: TcfVertical
  Left = 403
  Top = 246
  Width = 416
  Height = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Height = -11
  UserTypes = <
    item
      Name = 'utVGeneral'
    end
    item
      Name = 'utVGroupRights'
    end>
  Zones = <
    item
      Control = zLeft
      ZoneType = vcm_ztParent
    end
    item
      Control = zRight
      ZoneType = vcm_ztChild
    end>
  PixelsPerInch = 96
  TextHeight = 13
  object zLeft: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 312
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'zLeft'
    Constraints.MinHeight = 200
    Constraints.MinWidth = 185
    TabOrder = 0
  end
  object zRight: TPanel
    Left = 188
    Top = 0
    Width = 212
    Height = 312
    Align = alClient
    BevelOuter = bvNone
    Caption = 'zRight'
    TabOrder = 1
  end
  object Splitter1: TRxSplitter
    Left = 185
    Top = 0
    Width = 3
    Height = 312
    ControlFirst = zLeft
    ControlSecond = zRight
    Align = alLeft
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
