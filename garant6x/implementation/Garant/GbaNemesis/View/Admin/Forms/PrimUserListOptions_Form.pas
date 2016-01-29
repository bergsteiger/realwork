unit PrimUserListOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimUserListOptions_Form.pas"
// Начат: 31.08.2010 15:18
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Администратор::Admin::View::Admin::PrimUserListOptions
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  PrimUserList_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TPrimUserListOptionsForm = {form} class(TPrimUserListForm)
 protected
  procedure InitEntities; override;
 end;//TPrimUserListOptionsForm

 TvcmEntityFormRef = TPrimUserListOptionsForm;
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  ,
  Admin_Users_Controls
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

// start class TPrimUserListOptionsForm

procedure TPrimUserListOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  {$If not defined(NoVCM)}
  
  ShowInContextMenu(en_Edit, op_Delete, true);
  ShowInToolbar(en_Edit, op_Delete, false);
  {$IfEnd} //not NoVCM

  
  ShowInContextMenu(en_Users, op_Add, false);
  ShowInToolbar(en_Users, op_Add, true);
  
  ShowInContextMenu(en_Users, op_LogoutUser, false);
  ShowInToolbar(en_Users, op_LogoutUser, true);
  
  ShowInContextMenu(en_Users, op_ConsultingStateForNewbie, false);
  ShowInToolbar(en_Users, op_ConsultingStateForNewbie, true);
  
  ShowInContextMenu(en_Users, op_Autoregistration, false);
  ShowInToolbar(en_Users, op_Autoregistration, true);
  
  ShowInContextMenu(en_Users, op_AddPrivelegedRight, true);
  ShowInToolbar(en_Users, op_AddPrivelegedRight, false);
  
  ShowInContextMenu(en_Users, op_RemovePrivelegedRight, true);
  ShowInToolbar(en_Users, op_RemovePrivelegedRight, false);
  
  ShowInContextMenu(en_Users, op_UserFilter, false);
  ShowInToolbar(en_Users, op_UserFilter, true);
  
  ShowInContextMenu(en_Users, op_DisableConsulting, true);
  ShowInToolbar(en_Users, op_DisableConsulting, true);
  
  ShowInContextMenu(en_Users, op_EnableConsulting, true);
  ShowInToolbar(en_Users, op_EnableConsulting, true);
 end;//with Entities.Entities
end;

{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimUserListOptions
 TtfwClassRef.Register(TPrimUserListOptionsForm);
{$IfEnd} //Admin AND not NoScripts

end.