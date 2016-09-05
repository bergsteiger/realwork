unit kwConstLikeCompiled;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwConstLikeCompiled.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwConstLikeCompiled" MUID: (551E87F00212)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwRuntimeWordWithCodeExecution
 , TypInfo
 , tfwScriptingInterfaces
;

type
 TkwConstLikeCompiled = class(TkwRuntimeWordWithCodeExecution)
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TkwConstLikeCompiled
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *551E87F00212impl_uses*
 //#UC END# *551E87F00212impl_uses*
;

function TkwConstLikeCompiled.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_551E87F00212_var*
//#UC END# *551544E2001A_551E87F00212_var*
begin
//#UC START# *551544E2001A_551E87F00212_impl*
 Result := GetCode(aCtx)[0].GetResultTypeInfo(aCtx);
//#UC END# *551544E2001A_551E87F00212_impl*
end;//TkwConstLikeCompiled.GetResultTypeInfo

initialization
 TkwConstLikeCompiled.RegisterClass;
 {* Регистрация TkwConstLikeCompiled }
{$IfEnd} // NOT Defined(NoScripts)

end.
