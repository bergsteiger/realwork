unit PrimMainOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimMainOptions_Form.pas"
// Начат: 10.09.2010 16:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMMainForm::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimF1::PrimMainOptions
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  F1_Application_Template_InternalOperations_Controls,
  PrimMain_Form,
  MainPrim_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;

type
 TPrimMainOptionsForm = {form} class(TPrimMainForm)
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 protected
 // realized methods
   procedure Help_HelpTopics_Test(const aParams: IvcmTestParamsPrim);
   procedure Help_HelpTopics_Execute(const aParams: IvcmExecuteParamsPrim);
 end;//TPrimMainOptionsForm

 TvcmMainFormRef = TPrimMainOptionsForm;

implementation

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vtNavigator
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  nsConst
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;

// start class TPrimMainOptionsForm

procedure TPrimMainOptionsForm.Help_HelpTopics_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8A27DA0087_4C8A210E018Ctest_var*
//#UC END# *4C8A27DA0087_4C8A210E018Ctest_var*
begin
//#UC START# *4C8A27DA0087_4C8A210E018Ctest_impl*
 if (Application.HelpFile = '') then
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C8A27DA0087_4C8A210E018Ctest_impl*
end;//TPrimMainOptionsForm.Help_HelpTopics_Test

procedure TPrimMainOptionsForm.Help_HelpTopics_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A27DA0087_4C8A210E018Cexec_var*
//#UC END# *4C8A27DA0087_4C8A210E018Cexec_var*
begin
//#UC START# *4C8A27DA0087_4C8A210E018Cexec_impl*
 Application.HelpSystem.ShowTopicHelp(cHelpStartPage, '');
//#UC END# *4C8A27DA0087_4C8A210E018Cexec_impl*
end;//TPrimMainOptionsForm.Help_HelpTopics_Execute

procedure TPrimMainOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Help, nil);
  PublishOp(en_Help, op_HelpTopics, Help_HelpTopics_Execute, Help_HelpTopics_Test, nil);
  ShowInContextMenu(en_Help, op_HelpTopics, false);
  ShowInToolbar(en_Help, op_HelpTopics, false);
 end;//with Entities.Entities
end;

procedure TPrimMainOptionsForm.MakeControls;
begin
 inherited;
 ClientZone.Parent := Self;
 LeftNavigator.Parent := ClientZone;
{$If defined(HasRightNavigator)}
 RightNavigator.Parent := ClientZone;
{$IfEnd} //HasRightNavigator
end;

initialization
{$If not defined(NoScripts)}
// Регистрация PrimMainOptions
 TtfwClassRef.Register(TPrimMainOptionsForm);
{$IfEnd} //not NoScripts

end.