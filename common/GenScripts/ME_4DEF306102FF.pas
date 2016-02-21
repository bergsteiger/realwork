unit tfwScriptEngineEX;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEngineEX.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptEngine
;

type
 TtfwScriptEngineEX = class(TtfwScriptEngine)
 end;//TtfwScriptEngineEX
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , CodeFlowWordsPack
 , CompilationPack
 , WordsDefinitionPack
 , IncludesAndUsesPack
 , EtalonsWorkingPack
 , MouseInputPack
 {$If NOT Defined(NoVCL)}
 , ModalDialogsKeywordsPack
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , KeyboardInputPack
 {$IfEnd} // NOT Defined(NoVCL)
 , ObjectFromstackWords
 , CodeBranchingPack
 , ScriptsCompilingAndProcessingPack
 {$If NOT Defined(NoWindows)}
 , WinUtilsPack
 {$IfEnd} // NOT Defined(NoWindows)
;
{$IfEnd} // NOT Defined(NoScripts)

end.
