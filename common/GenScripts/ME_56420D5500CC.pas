unit kwCompiledScriptCompileStringAndProcess;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledScriptCompileStringAndProcess.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledScriptCompileAndProcess
 , tfwStreamFactory
;

type
 TkwCompiledScriptCompileStringAndProcess = class(TkwCompiledScriptCompileAndProcess)
  public
   function MakeStream(const aData: AnsiString): TtfwStreamFactory; override;
 end;//TkwCompiledScriptCompileStringAndProcess
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwStringStreamFactory
;

function TkwCompiledScriptCompileStringAndProcess.MakeStream(const aData: AnsiString): TtfwStreamFactory;
//#UC START# *56420D080052_56420D5500CC_var*
//#UC END# *56420D080052_56420D5500CC_var*
begin
//#UC START# *56420D080052_56420D5500CC_impl*
 Result := TtfwStringStreamFactory.Create(aData);
 //WriteLn(aData);
//#UC END# *56420D080052_56420D5500CC_impl*
end;//TkwCompiledScriptCompileStringAndProcess.MakeStream

initialization
 TkwCompiledScriptCompileStringAndProcess.RegisterClass;
 {* Регистрация TkwCompiledScriptCompileStringAndProcess }
{$IfEnd} // NOT Defined(NoScripts)

end.
