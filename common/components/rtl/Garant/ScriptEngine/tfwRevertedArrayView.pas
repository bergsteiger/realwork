unit tfwRevertedArrayView;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwRevertedArrayView.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwRevertedArrayView" MUID: (52E271D60114)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwArrayView
 , tfwScriptingInterfaces
;

type
 TtfwRevertedArrayView = class(TtfwArrayView)
  public
   procedure DoForEach(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext); override;
   procedure DoForEachBack(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext); override;
 end;//TtfwRevertedArrayView
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *52E271D60114impl_uses*
 //#UC END# *52E271D60114impl_uses*
;

procedure TtfwRevertedArrayView.DoForEach(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E666E80335_52E271D60114_var*
//#UC END# *52E666E80335_52E271D60114_var*
begin
//#UC START# *52E666E80335_52E271D60114_impl*
 inherited DoForEachBack(aLambda, aCtx);
//#UC END# *52E666E80335_52E271D60114_impl*
end;//TtfwRevertedArrayView.DoForEach

procedure TtfwRevertedArrayView.DoForEachBack(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E666F6036E_52E271D60114_var*
//#UC END# *52E666F6036E_52E271D60114_var*
begin
//#UC START# *52E666F6036E_52E271D60114_impl*
 inherited DoForEach(aLambda, aCtx);
//#UC END# *52E666F6036E_52E271D60114_impl*
end;//TtfwRevertedArrayView.DoForEachBack
{$IfEnd} // NOT Defined(NoScripts)

end.
