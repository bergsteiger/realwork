unit tfwRevertedArrayView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Axiomatics"
// ������: "tfwRevertedArrayView.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Axiomatics::ArrayProcessing::TtfwRevertedArrayView
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwArrayView,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TtfwRevertedArrayView = class(TtfwArrayView)
 public
 // overridden public methods
   procedure DoForEach(aLambda: TtfwWordPrim;
     const aCtx: TtfwContext); override;
   procedure DoForEachBack(aLambda: TtfwWordPrim;
     const aCtx: TtfwContext); override;
 end;//TtfwRevertedArrayView
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TtfwRevertedArrayView

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

{$IfEnd} //not NoScripts

end.