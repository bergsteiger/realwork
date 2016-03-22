program AutoPipeServer;
 {* Приложение Сервера автоматизации Архивариуса }

// Модуль: "w:\archi\source\projects\PipeInAuto\AutoPipeServer.dpr"
// Стереотип: "ExeTarget"
// Элемент модели: "AutoPipeServer" MUID: (52E8D676018A)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(AppServerSide)

end.
