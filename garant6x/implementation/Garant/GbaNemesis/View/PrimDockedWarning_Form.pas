unit PrimDockedWarning_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimDockedWarning_Form.pas"
// Начат: 24.10.2011 21:17
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::Warning::PrimDockedWarning
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
  ,
  Document_Strange_Controls,
  Base_Operations_Editions_Controls,
  WarningUserTypes_Warning_UserType,
  PrimWarningOptions_Form
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a},
  DocumentAndListInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _WarningUserTypes_Parent_ = TPrimWarningOptionsForm;
 {$Include ..\View\WarningUserTypes.imp.pas}
 TPrimDockedWarningForm = {form} class(_WarningUserTypes_)
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   procedure WarningQueryClose(aSender: TObject); override;
     {* Обработчик события Warning.OnQueryClose }
   procedure Warning_BecomeActive_Test(const aParams: IvcmTestParamsPrim);
   procedure Warning_BecomeActive_Execute(aSubID: TnsWarningSub);
   procedure Warning_BecomeActive(const aParams: IvcmExecuteParams);
   procedure Warning_SwitchActive_Test(const aParams: IvcmTestParamsPrim);
   procedure Warning_SwitchActive_Execute(aSubID: TnsWarningSub);
   procedure Warning_SwitchActive(const aParams: IvcmExecuteParams);
 end;//TPrimDockedWarningForm

 TvcmEntityFormRef = TPrimDockedWarningForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  F1Like_InternalOperations_Controls
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID,
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include ..\View\WarningUserTypes.imp.pas}

// start class TPrimDockedWarningForm

procedure TPrimDockedWarningForm.WarningQueryClose(aSender: TObject);
//#UC START# *2FE2CD3A0C24_4EA59DA70226_var*
//#UC END# *2FE2CD3A0C24_4EA59DA70226_var*
begin
//#UC START# *2FE2CD3A0C24_4EA59DA70226_impl*
 op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *2FE2CD3A0C24_4EA59DA70226_impl*
end;//TPrimDockedWarningForm.WarningQueryClose

procedure TPrimDockedWarningForm.Warning_BecomeActive_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AE9DF12018A_4EA59DA70226test_var*
//#UC END# *4AE9DF12018A_4EA59DA70226test_var*
begin
//#UC START# *4AE9DF12018A_4EA59DA70226test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (UserType = Warning);
 // http://mdp.garant.ru/pages/viewpage.action?pageId=269081712
 // http://mdp.garant.ru/pages/viewpage.action?pageId=274464961
//#UC END# *4AE9DF12018A_4EA59DA70226test_impl*
end;//TPrimDockedWarningForm.Warning_BecomeActive_Test

procedure TPrimDockedWarningForm.Warning_BecomeActive_Execute(aSubID: TnsWarningSub);
//#UC START# *4AE9DF12018A_4EA59DA70226exec_var*
//#UC END# *4AE9DF12018A_4EA59DA70226exec_var*
begin
//#UC START# *4AE9DF12018A_4EA59DA70226exec_impl*
 PositionOnRequestedSub(aSubID);
//#UC END# *4AE9DF12018A_4EA59DA70226exec_impl*
end;//TPrimDockedWarningForm.Warning_BecomeActive_Execute

procedure TPrimDockedWarningForm.Warning_BecomeActive(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IWarning_BecomeActive_Params) do
  Warning_BecomeActive_Execute(SubID);
end;

procedure TPrimDockedWarningForm.Warning_SwitchActive_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AE9DF3602B2_4EA59DA70226test_var*
//#UC END# *4AE9DF3602B2_4EA59DA70226test_var*
begin
//#UC START# *4AE9DF3602B2_4EA59DA70226test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (UserType = Warning);
 // http://mdp.garant.ru/pages/viewpage.action?pageId=269081712
 // http://mdp.garant.ru/pages/viewpage.action?pageId=274464961
//#UC END# *4AE9DF3602B2_4EA59DA70226test_impl*
end;//TPrimDockedWarningForm.Warning_SwitchActive_Test

procedure TPrimDockedWarningForm.Warning_SwitchActive_Execute(aSubID: TnsWarningSub);
//#UC START# *4AE9DF3602B2_4EA59DA70226exec_var*
//#UC END# *4AE9DF3602B2_4EA59DA70226exec_var*
begin
//#UC START# *4AE9DF3602B2_4EA59DA70226exec_impl*
 PositionOnRequestedSub(aSubID);
//#UC END# *4AE9DF3602B2_4EA59DA70226exec_impl*
end;//TPrimDockedWarningForm.Warning_SwitchActive_Execute

procedure TPrimDockedWarningForm.Warning_SwitchActive(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IWarning_SwitchActive_Params) do
  Warning_SwitchActive_Execute(SubID);
end;

procedure TPrimDockedWarningForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Warning, nil);
  PublishOpWithResult(en_Warning, op_BecomeActive, Warning_BecomeActive, Warning_BecomeActive_Test, nil);
  PublishOpWithResult(en_Warning, op_SwitchActive, Warning_SwitchActive, Warning_SwitchActive_Test, nil);{$If not defined(NoVCM)}
  
  ShowInContextMenu(en_File, op_Print, false);
  ShowInToolbar(en_File, op_Print, false);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include ..\View\WarningUserTypes.imp.pas}
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimDockedWarning
 TtfwClassRef.Register(TPrimDockedWarningForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.