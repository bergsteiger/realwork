program AutoPipeServer;
 {* Приложение Сервера автоматизации Архивариуса }

// Модуль: "w:\archi\source\projects\PipeInAuto\AutoPipeServer.dpr"
// Стереотип: "ExeTarget"

{$Include alcuDefine.inc}

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
