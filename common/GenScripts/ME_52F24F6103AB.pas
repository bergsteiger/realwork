program AutoPipeServerTest;
 {* Тесты Сервера автоматизации Архивариуса }

// Модуль: "w:\archi\source\projects\PipeInAuto\AutoPipeServerTest.dpr"
// Стереотип: "TestTarget"

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
