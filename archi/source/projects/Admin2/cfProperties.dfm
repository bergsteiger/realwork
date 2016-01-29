object cfProps: TcfProps
  Left = 223
  Top = 233
  Width = 509
  Height = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  UserTypes = <
    item
      Name = 'utProperties'
    end>
  OnChangedDataSource = vcmContainerFormChangedDataSource
  Zones = <
    item
      Control = zMain
      ZoneType = vcm_ztParent
    end>
  PixelsPerInch = 96
  TextHeight = 13
  object zMain: TPageControl
    Left = 0
    Top = 0
    Width = 493
    Height = 348
    Align = alClient
    TabOrder = 0
  end
  object Entities: TvcmEntities
    Entities = <
      item
        Name = 'enProperties'
        Operations = <
          item
            Name = 'opSave'
            OnTest = enPropertiesopSaveTest
            OnExecute = enPropertiesopSaveExecute
            Options = [vcm_ooShowInChildToolbar]
          end
          item
            Name = 'opRevert'
            OnTest = enPropertiesopRevertTest
            OnExecute = enPropertiesopRevertExecute
            Options = [vcm_ooShowInChildToolbar]
          end>
        Category = 'enProperties'
        ToolbarPos = vcm_tbpBottom
      end>
    Left = 10
    Top = 10
  end
end
