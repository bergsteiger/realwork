unit PrimNavigatorOptions_Form;
 {* Меню }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimNavigatorOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimNavigatorOptions" MUID: (4C87A47E0036)
// Имя типа: "TPrimNavigatorOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimNavigator_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Common_Strange_Controls
;

type
 TPrimNavigatorOptionsForm = class(TPrimNavigatorForm)
  {* Меню }
  public
   procedure NavigatorElement_Info_Test(const aParams: IvcmTestParamsPrim);
   procedure NavigatorElement_Info_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure NavigatorElement_Execute_Test(const aParams: IvcmTestParamsPrim);
   procedure NavigatorElement_Execute_Execute(const aParams: IvcmExecuteParamsPrim);
 end;//TPrimNavigatorOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3TreeInterfaces
 , DynamicTreeUnit
 , nsNodes
 , SysUtils
 , nsNavigatorTreeStruct
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TPrimNavigatorOptionsForm.NavigatorElement_Info_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C87A50402CC_4C87A47E0036test_var*
//#UC END# *4C87A50402CC_4C87A47E0036test_var*
begin
//#UC START# *4C87A50402CC_4C87A47E0036test_impl*
 // до реализации информации на INodeBase
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4C87A50402CC_4C87A47E0036test_impl*
end;//TPrimNavigatorOptionsForm.NavigatorElement_Info_Test

procedure TPrimNavigatorOptionsForm.NavigatorElement_Info_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C87A50402CC_4C87A47E0036exec_var*
var
 l_l3Node : Il3SimpleNode;
 l_Node   : INodeBase;
//#UC END# *4C87A50402CC_4C87A47E0036exec_var*
begin
//#UC START# *4C87A50402CC_4C87A47E0036exec_impl*
 l_l3Node := NavigatorTree.GetCurrentNode;
 if Supports(l_l3Node, INodeBase, l_Node) then
  Say(inf_AnyInformation, [nsGetHint(l_Node)]);
//#UC END# *4C87A50402CC_4C87A47E0036exec_impl*
end;//TPrimNavigatorOptionsForm.NavigatorElement_Info_Execute

procedure TPrimNavigatorOptionsForm.NavigatorElement_Execute_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C87A52E02F7_4C87A47E0036test_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *4C87A52E02F7_4C87A47E0036test_var*
begin
//#UC START# *4C87A52E02F7_4C87A47E0036test_impl*
 with NavigatorTree do
 begin
  l_Node := GetCurrentNode;
  try
   aParams.Op.Flag[vcm_ofVisible] := (l_Node <> nil) and not l_Node.HasChild;
  finally
   l_Node := nil;
  end;//try..finally
 end;//with NavigatorTree do
//#UC END# *4C87A52E02F7_4C87A47E0036test_impl*
end;//TPrimNavigatorOptionsForm.NavigatorElement_Execute_Test

procedure TPrimNavigatorOptionsForm.NavigatorElement_Execute_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C87A52E02F7_4C87A47E0036exec_var*
//#UC END# *4C87A52E02F7_4C87A47E0036exec_var*
begin
//#UC START# *4C87A52E02F7_4C87A47E0036exec_impl*
 ExecuteCurrentElement;
//#UC END# *4C87A52E02F7_4C87A47E0036exec_impl*
end;//TPrimNavigatorOptionsForm.NavigatorElement_Execute_Execute

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimNavigatorOptionsForm);
 {* Регистрация PrimNavigatorOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
