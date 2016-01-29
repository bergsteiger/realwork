object evpDocument: TevpDocument
  OldCreateOrder = True
  Left = 302
  Top = 160
  Height = 160
  Width = 360
  object ModuleDef: TvcmModuleDef
    Caption = #1044#1086#1082#1091#1084#1077#1085#1090
    Operations = <
      item
        Name = 'New'
        OnExecute = ModuleDefNewExecute
      end
      item
        Name = 'Open'
        OnExecute = ModuleDefOpenExecute
      end
      item
        Name = 'GetSaveManager'
        OnExecute = ModuleDefGetSaveManagerExecute
      end>
    Events = <>
    Left = 56
    Top = 40
  end
  object LoadManager: TevLoadDocumentManager
    Left = 160
    Top = 40
  end
  object SaveManager: TevSaveDocumentManager
    Left = 264
    Top = 40
  end
end
