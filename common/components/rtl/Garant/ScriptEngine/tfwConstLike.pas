unit tfwConstLike;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwConstLike.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwConstLike" MUID: (4F3BC124004D)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwNewWord
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TtfwConstLike = {abstract} class(TtfwNewWord)
  protected
   function EndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   function AfterWordMaxCount(const aCtx: TtfwContext): Integer; override;
   function CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim; override;
 end;//TtfwConstLike
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwRuntimeWordWithCodeExecution
 , kwConstLikeCompiled
 //#UC START# *4F3BC124004Dimpl_uses*
 //#UC END# *4F3BC124004Dimpl_uses*
;

function TtfwConstLike.EndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *4DB6C99F026E_4F3BC124004D_var*
//#UC END# *4DB6C99F026E_4F3BC124004D_var*
begin
//#UC START# *4DB6C99F026E_4F3BC124004D_impl*
 Result := DisabledEndBracket(aContext, aSilent);
//#UC END# *4DB6C99F026E_4F3BC124004D_impl*
end;//TtfwConstLike.EndBracket

function TtfwConstLike.AfterWordMaxCount(const aCtx: TtfwContext): Integer;
//#UC START# *4DB9B446039A_4F3BC124004D_var*
//#UC END# *4DB9B446039A_4F3BC124004D_var*
begin
//#UC START# *4DB9B446039A_4F3BC124004D_impl*
 Result := 1;
//#UC END# *4DB9B446039A_4F3BC124004D_impl*
end;//TtfwConstLike.AfterWordMaxCount

function TtfwConstLike.CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim;
//#UC START# *4DBAEE0D028D_4F3BC124004D_var*
//#UC END# *4DBAEE0D028D_4F3BC124004D_var*
begin
//#UC START# *4DBAEE0D028D_4F3BC124004D_impl*
 Result := TkwConstLikeCompiled;
//#UC END# *4DBAEE0D028D_4F3BC124004D_impl*
end;//TtfwConstLike.CompiledWordClass

initialization
 TtfwConstLike.RegisterClass;
 {* Регистрация TtfwConstLike }
{$IfEnd} // NOT Defined(NoScripts)

end.
