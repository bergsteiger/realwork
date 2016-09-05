unit tfwMappedArrayView;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwMappedArrayView.pas"
// ���������: "SimpleClass"
// ������� ������: "TtfwMappedArrayView" MUID: (52E6733C0163)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwLambdedArrayView
 , tfwScriptingInterfaces
;

type
 TtfwMapLambda = class(TtfwTwoLambdas)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TtfwMapLambda

 TtfwMappedArrayView = class(TtfwLambdedArrayView)
  protected
   function TwoLabdasClass: RtfwTwoLambdas; override;
   function GetCount: Integer; override;
 end;//TtfwMappedArrayView
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *52E6733C0163impl_uses*
 //#UC END# *52E6733C0163impl_uses*
;

procedure TtfwMapLambda.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52EA87EA0325_var*
//#UC END# *4DAEEDE10285_52EA87EA0325_var*
begin
//#UC START# *4DAEEDE10285_52EA87EA0325_impl*
 f_Lambda.DoIt(aCtx);
 WordToWork.DoIt(aCtx);
//#UC END# *4DAEEDE10285_52EA87EA0325_impl*
end;//TtfwMapLambda.DoDoIt

function TtfwMappedArrayView.TwoLabdasClass: RtfwTwoLambdas;
//#UC START# *52EA8EE702FA_52E6733C0163_var*
//#UC END# *52EA8EE702FA_52E6733C0163_var*
begin
//#UC START# *52EA8EE702FA_52E6733C0163_impl*
 Result := TtfwMapLambda;
//#UC END# *52EA8EE702FA_52E6733C0163_impl*
end;//TtfwMappedArrayView.TwoLabdasClass

function TtfwMappedArrayView.GetCount: Integer;
//#UC START# *57C811A30375_52E6733C0163_var*
//#UC END# *57C811A30375_52E6733C0163_var*
begin
//#UC START# *57C811A30375_52E6733C0163_impl*
 Result := f_Other.Count;
//#UC END# *57C811A30375_52E6733C0163_impl*
end;//TtfwMappedArrayView.GetCount

initialization
 TtfwMapLambda.RegisterClass;
 {* ����������� TtfwMapLambda }
{$IfEnd} // NOT Defined(NoScripts)

end.
