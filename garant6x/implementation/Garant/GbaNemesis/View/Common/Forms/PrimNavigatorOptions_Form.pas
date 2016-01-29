unit PrimNavigatorOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/PrimNavigatorOptions_Form.pas"
// Начат: 09.0.2010 18:58
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Common::View::Common::PrimNavigatorOptions
//
// Меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  ,
  PrimNavigator_Form,
  Common_Strange_Controls,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimNavigatorOptionsForm = {form} class(TPrimNavigatorForm)
  {* Меню }
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   procedure NavigatorElement_Info_Test(const aParams: IvcmTestParamsPrim);
   procedure NavigatorElement_Info_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure NavigatorElement_Execute_Test(const aParams: IvcmTestParamsPrim);
   procedure NavigatorElement_Execute_Execute(const aParams: IvcmExecuteParamsPrim);
 end;//TPrimNavigatorOptionsForm

 TvcmEntityFormRef = TPrimNavigatorOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3TreeInterfaces,
  DynamicTreeUnit,
  nsNodes,
  SysUtils,
  nsNavigatorTreeStruct
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimNavigatorOptionsForm

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

procedure TPrimNavigatorOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_NavigatorElement, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Cut, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Cut, true);
  ShowInToolbar(en_Edit, op_Cut, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Paste, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Paste, true);
  ShowInToolbar(en_Edit, op_Paste, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Undo, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Undo, true);
  ShowInToolbar(en_Edit, op_Undo, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Redo, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Redo, true);
  ShowInToolbar(en_Edit, op_Redo, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_SelectAll, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_SelectAll, true);
  ShowInToolbar(en_Edit, op_SelectAll, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Deselect, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Deselect, true);
  ShowInToolbar(en_Edit, op_Deselect, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Copy, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Copy, true);
  ShowInToolbar(en_Edit, op_Copy, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Delete, nil, nil, nil);
  ShowInContextMenu(en_Edit, op_Delete, true);
  ShowInToolbar(en_Edit, op_Delete, false);
  {$IfEnd} //not NoVCM

  PublishOp(en_NavigatorElement, op_Info, NavigatorElement_Info_Execute, NavigatorElement_Info_Test, nil);
  ShowInContextMenu(en_NavigatorElement, op_Info, true);
  ShowInToolbar(en_NavigatorElement, op_Info, false);
  PublishOp(en_NavigatorElement, op_Execute, NavigatorElement_Execute_Execute, NavigatorElement_Execute_Test, nil);
  ShowInContextMenu(en_NavigatorElement, op_Execute, true);
  ShowInToolbar(en_NavigatorElement, op_Execute, false);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimNavigatorOptions
 TtfwClassRef.Register(TPrimNavigatorOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.