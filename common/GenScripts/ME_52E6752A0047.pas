unit tfwFilteredArrayView;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwFilteredArrayView.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwLambdedArrayView
 , tfwScriptingInterfaces
;

type
 TtfwFilterLambda = class(TtfwTwoLambdas)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TtfwFilterLambda

 TtfwFilteredArrayView = class(TtfwLambdedArrayView)
  protected
   function TwoLabdasClass: RtfwTwoLambdas; override;
 end;//TtfwFilteredArrayView
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TtfwFilterLambda.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52EA87C200D8_var*
(*var
 l_V : TtfwStackValue;*)
//#UC END# *4DAEEDE10285_52EA87C200D8_var*
begin
//#UC START# *4DAEEDE10285_52EA87C200D8_impl*
 aCtx.rEngine.DupN(ItemsCountInSlice);
 f_Lambda.DoIt(aCtx);
 if aCtx.rEngine.PopBool then
  WordToWork.DoIt(aCtx)
 else
  aCtx.rEngine.DropN(ItemsCountInSlice);
(* l_V := aCtx.rEngine.Pop;
 try
  aCtx.rEngine.Push(l_V);
  f_Lambda.DoIt(aCtx);
  if aCtx.rEngine.PopBool then
  begin
   aCtx.rEngine.Push(l_V);
   WordToWork.DoIt(aCtx);
  end;//aCtx.rEngine.PopBool
 finally
  Finalize(l_V);
 end;//try..finally*)
//#UC END# *4DAEEDE10285_52EA87C200D8_impl*
end;//TtfwFilterLambda.DoDoIt

function TtfwFilteredArrayView.TwoLabdasClass: RtfwTwoLambdas;
//#UC START# *52EA8EE702FA_52E6752A0047_var*
//#UC END# *52EA8EE702FA_52E6752A0047_var*
begin
//#UC START# *52EA8EE702FA_52E6752A0047_impl*
 Result := TtfwFilterLambda;
//#UC END# *52EA8EE702FA_52E6752A0047_impl*
end;//TtfwFilteredArrayView.TwoLabdasClass

initialization
 TtfwFilterLambda.RegisterClass;
 {* Регистрация TtfwFilterLambda }
{$IfEnd} // NOT Defined(NoScripts)

end.
