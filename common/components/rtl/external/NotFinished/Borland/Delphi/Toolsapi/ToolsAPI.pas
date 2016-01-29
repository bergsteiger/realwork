unit ToolsAPI;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Toolsapi"
// Модуль: "w:/common/components/rtl/external/NotFinished/Borland/Delphi/Toolsapi/ToolsAPI.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Core::Toolsapi::Implementation::ToolsAPI
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(XE)}
type
 IOTAModule40 = interface(IUnknown)
   ['{7A5AE700-EF74-4D3E-8FE4-1EB41BD06330}']
 end;//IOTAModule40

 IOTAModule50 = interface(IOTAModule40)
   ['{624FEEA1-402B-4849-90F5-1C5A1162DA50}']
 end;//IOTAModule50

 IOTAModule = interface(IOTAModule50)
   ['{DA32E0F5-9B91-4319-AEE4-75CFAB0ED74C}']
 end;//IOTAModule

 IOTANotifier = interface(IUnknown)
   ['{6886FB80-6B64-48E8-B13F-740305967081}']
 end;//IOTANotifier

 IOTAModuleNotifier = interface(IOTANotifier)
   ['{FB97C9ED-1A65-4C95-940F-7001B3CC45E8}']
 end;//IOTAModuleNotifier

 IOTAEditor = interface(IUnknown)
   ['{0074C9B9-E836-4932-AE57-A6164F94D7AC}']
 end;//IOTAEditor

 IOTASourceEditor = interface(IOTAEditor)
   ['{109E6635-84DE-4A60-A5F9-1337E4995BCC}']
 end;//IOTASourceEditor
{$IfEnd} //not XE

implementation

{$If not defined(XE)}
uses
  DesignIntf
  ;

{$IfEnd} //not XE
end.