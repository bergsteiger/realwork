unit ArchiScriptEngine;

// Модуль: "w:\archi\source\projects\Archi\Archi_Script_Engine\ArchiScriptEngine.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngineEX
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TArchiScriptEngine = class(TtfwScriptEngineEX)
 end;//TArchiScriptEngine

implementation

uses
 l3ImplUses
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , arEditorUtils
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , arDialogsPack
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , CommonArchiWords
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwCompiledWord
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , kwDocumentSpravka
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , kwEditorKeyWordsPack
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)
 {$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
 , kwCommonArchiWords
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
{$IfEnd} // NOT Defined(NoScripts)
end.
