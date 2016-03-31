unit alcuDeliveryInterfaces;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuDeliveryInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "alcuDeliveryInterfaces" MUID: (5475AF76000C)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(ServerTasks)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 IalcuTaskFinisher = interface
  ['{EEC123D4-2A14-46DA-A4B0-03904BB8751C}']
  procedure TaskDone(aTask: TddProcessTask);
 end;//IalcuTaskFinisher
{$IfEnd} // Defined(ServerTasks)

implementation

{$If Defined(ServerTasks)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(ServerTasks)

end.
