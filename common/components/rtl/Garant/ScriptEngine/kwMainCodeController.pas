unit kwMainCodeController;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMainCodeController.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwMain
 , tfwScriptingInterfaces
;

type
 TkwMainCodeController = class(TkwMain)
  private
   f_Lambda: TtfwWord;
   f_OuterContext: PtfwContext;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function CacheDict: Boolean; override;
  public
   constructor Create(aLambda: TtfwWord;
    aOuterContext: PtfwContext); reintroduce;
   procedure RunCompiled(const aContext: TtfwContext); override;
 end;//TkwMainCodeController
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

constructor TkwMainCodeController.Create(aLambda: TtfwWord;
 aOuterContext: PtfwContext);
//#UC START# *53DA263600C7_53DA257D011C_var*
//#UC END# *53DA263600C7_53DA257D011C_var*
begin
//#UC START# *53DA263600C7_53DA257D011C_impl*
 inherited Create;
 aLambda.SetRefTo(f_Lambda);
 f_OuterContext := aOuterContext;
 Assert(f_OuterContext <> nil);
//#UC END# *53DA263600C7_53DA257D011C_impl*
end;//TkwMainCodeController.Create

procedure TkwMainCodeController.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53DA257D011C_var*
//#UC END# *479731C50290_53DA257D011C_var*
begin
//#UC START# *479731C50290_53DA257D011C_impl*
 FreeAndNil(f_Lambda);
 inherited;
//#UC END# *479731C50290_53DA257D011C_impl*
end;//TkwMainCodeController.Cleanup

procedure TkwMainCodeController.RunCompiled(const aContext: TtfwContext);
//#UC START# *4DC90A79006D_53DA257D011C_var*
//#UC END# *4DC90A79006D_53DA257D011C_var*
begin
//#UC START# *4DC90A79006D_53DA257D011C_impl*
 Assert(f_OuterContext <> nil);
 f_OuterContext.rEngine.PushObj(MainDictionary.CompiledCode);
 f_Lambda.DoIt(f_OuterContext^);
//#UC END# *4DC90A79006D_53DA257D011C_impl*
end;//TkwMainCodeController.RunCompiled

function TkwMainCodeController.CacheDict: Boolean;
//#UC START# *55AF8A9D03A2_53DA257D011C_var*
//#UC END# *55AF8A9D03A2_53DA257D011C_var*
begin
//#UC START# *55AF8A9D03A2_53DA257D011C_impl*
 Result := true;
//#UC END# *55AF8A9D03A2_53DA257D011C_impl*
end;//TkwMainCodeController.CacheDict

initialization
 TkwMainCodeController.RegisterInEngine;
 {* Регистрация TkwMainCodeController }
{$IfEnd} // NOT Defined(NoScripts)

end.
