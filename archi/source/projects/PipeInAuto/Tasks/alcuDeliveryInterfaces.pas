unit alcuDeliveryInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuDeliveryInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> archi$AutoPipeServer$Garant::Tasks::alcuDeliveryInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(ServerTasks)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  
  ;

type
 IalcuTaskFinisher = interface(IUnknown)
   ['{EEC123D4-2A14-46DA-A4B0-03904BB8751C}']
   procedure TaskDone(aTask: TddProcessTask);
 end;//IalcuTaskFinisher
{$IfEnd} //ServerTasks

implementation

end.