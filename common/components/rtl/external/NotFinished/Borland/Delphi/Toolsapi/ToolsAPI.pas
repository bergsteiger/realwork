unit ToolsAPI;

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Toolsapi\ToolsAPI.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ToolsAPI" MUID: (52A1F018005B)

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
;

type
 IOTAModule40 = interface
  ['{7A5AE700-EF74-4D3E-8FE4-1EB41BD06330}']
 end;//IOTAModule40

 IOTAModule50 = interface(IOTAModule40)
  ['{624FEEA1-402B-4849-90F5-1C5A1162DA50}']
 end;//IOTAModule50

 IOTAModule = interface(IOTAModule50)
  ['{DA32E0F5-9B91-4319-AEE4-75CFAB0ED74C}']
 end;//IOTAModule

 IOTANotifier = interface
  ['{6886FB80-6B64-48E8-B13F-740305967081}']
 end;//IOTANotifier

 IOTAModuleNotifier = interface(IOTANotifier)
  ['{FB97C9ED-1A65-4C95-940F-7001B3CC45E8}']
 end;//IOTAModuleNotifier

 IOTAEditor = interface
  ['{0074C9B9-E836-4932-AE57-A6164F94D7AC}']
 end;//IOTAEditor

 IOTASourceEditor = interface(IOTAEditor)
  ['{109E6635-84DE-4A60-A5F9-1337E4995BCC}']
 end;//IOTASourceEditor
{$IfEnd} // NOT Defined(XE)

implementation

{$If NOT Defined(XE)}
uses
 l3ImplUses
 , DesignIntf
 //#UC START# *52A1F018005Bimpl_uses*
 //#UC END# *52A1F018005Bimpl_uses*
;
{$IfEnd} // NOT Defined(XE)

end.
