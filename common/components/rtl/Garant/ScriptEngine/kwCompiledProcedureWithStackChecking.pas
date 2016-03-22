unit kwCompiledProcedureWithStackChecking;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedureWithStackChecking.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwCompiledProcedureWithStackChecking" MUID: (528F655002C2)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledProcedure
 , tfwScriptingInterfaces
;

type
 _tfwStackChecking_Parent_ = TkwCompiledProcedure;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwStackChecking.imp.pas}
 TkwCompiledProcedureWithStackChecking = class(_tfwStackChecking_)
 end;//TkwCompiledProcedureWithStackChecking
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwStackChecking.imp.pas}

initialization
 TkwCompiledProcedureWithStackChecking.RegisterClass;
 {* Регистрация TkwCompiledProcedureWithStackChecking }
{$IfEnd} // NOT Defined(NoScripts)

end.
