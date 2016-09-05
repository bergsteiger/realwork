unit tfwTruncatedArrayView;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwTruncatedArrayView.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwTruncatedArrayView" MUID: (55E0413800EA)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwLambdedArrayView
 , tfwScriptingInterfaces
;

type
 TtfwTruncLambda = class(TtfwTwoLambdas)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TtfwTruncLambda

 TtfwTruncatedArrayView = class(TtfwLambdedArrayView)
  protected
   function TwoLabdasClass: RtfwTwoLambdas; override;
 end;//TtfwTruncatedArrayView
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *55E0413800EAimpl_uses*
 //#UC END# *55E0413800EAimpl_uses*
;

procedure TtfwTruncLambda.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55E0417101EC_var*
(*var
 l_V : TtfwStackValue;*)
//#UC END# *4DAEEDE10285_55E0417101EC_var*
begin
//#UC START# *4DAEEDE10285_55E0417101EC_impl*
 aCtx.rEngine.Dup;
 f_Lambda.DoIt(aCtx);
 if aCtx.rEngine.PopBool then
 begin
  WordToWork.DoIt(aCtx);
 end//aCtx.rEngine.PopBool
 else
 begin
  aCtx.rEngine.Drop;
//  raise EtfwBreakIterator.Create('Выход из итератора');
  raise EtfwBreakIterator.Instance;
 end;//aCtx.rEngine.PopBool
(* l_V := aCtx.rEngine.Pop;
 try
  aCtx.rEngine.Push(l_V);
  f_Lambda.DoIt(aCtx);
  if aCtx.rEngine.PopBool then
  begin
   aCtx.rEngine.Push(l_V);
   WordToWork.DoIt(aCtx);
  end//aCtx.rEngine.PopBool
  else
//   raise EtfwBreakIterator.Create('Выход из итератора');
   raise EtfwBreakIterator.Instance;
 finally
  Finalize(l_V);
 end;//try..finally*)
//#UC END# *4DAEEDE10285_55E0417101EC_impl*
end;//TtfwTruncLambda.DoDoIt

function TtfwTruncatedArrayView.TwoLabdasClass: RtfwTwoLambdas;
//#UC START# *52EA8EE702FA_55E0413800EA_var*
//#UC END# *52EA8EE702FA_55E0413800EA_var*
begin
//#UC START# *52EA8EE702FA_55E0413800EA_impl*
 Result := TtfwTruncLambda;
//#UC END# *52EA8EE702FA_55E0413800EA_impl*
end;//TtfwTruncatedArrayView.TwoLabdasClass

initialization
 TtfwTruncLambda.RegisterClass;
 {* Регистрация TtfwTruncLambda }
{$IfEnd} // NOT Defined(NoScripts)

end.
