unit PrimPostingsListOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Monitorings/Forms/PrimPostingsListOptions_Form.pas"
// Начат: 14.06.2011 20:18
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Common For Shell And Monitoring::PostingOrder::View::Monitorings::PrimPostingsListOptions
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  PrimPostingsList_Form,
  PrimPostingsList_MyPostingList_UserType
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  PostingOrder_Strange_Controls,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TPrimPostingsListOptionsForm = {form} class(TPrimPostingsListForm)
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   procedure SearchSupport_ActivatePostingsListForm_Execute;
   procedure SearchSupport_ActivatePostingsListForm(const aParams: IvcmExecuteParams);
 end;//TPrimPostingsListOptionsForm

 TvcmEntityFormRef = TPrimPostingsListOptionsForm;
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  Windows
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  l3TabbedContainersDispatcher
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TPrimPostingsListOptionsForm

procedure TPrimPostingsListOptionsForm.SearchSupport_ActivatePostingsListForm_Execute;
//#UC START# *553FAEED007A_4DF789BF02EFexec_var*
var
 C: TWinControl;
//#UC END# *553FAEED007A_4DF789BF02EFexec_var*
begin
//#UC START# *553FAEED007A_4DF789BF02EFexec_impl*
 C := Self;
 while Assigned(C.Parent) do
  C := C.Parent;
 SetForegroundWindow(C.Handle);

 if Tl3TabbedContainersDispatcher.Instance.NeedUseTabs then
  Tl3TabbedContainersDispatcher.Instance.ActivateForm(Self);
//#UC END# *553FAEED007A_4DF789BF02EFexec_impl*
end;//TPrimPostingsListOptionsForm.SearchSupport_ActivatePostingsListForm_Execute

procedure TPrimPostingsListOptionsForm.SearchSupport_ActivatePostingsListForm(const aParams: IvcmExecuteParams);
begin
 SearchSupport_ActivatePostingsListForm_Execute;
end;

procedure TPrimPostingsListOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Tree, nil);
  PublishFormEntity(en_SearchSupport, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_ExpandAll, nil, nil, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_CollapseAll, nil, nil, nil);
  {$IfEnd} //not NoVCM

  PublishOpWithResult(en_SearchSupport, op_ActivatePostingsListForm, SearchSupport_ActivatePostingsListForm, nil, nil);
  ShowInContextMenu(en_PostingToolBar, op_ptEditPosting, true, true);
  ShowInToolbar(en_PostingToolBar, op_ptEditPosting, true, true);
 end;//with Entities.Entities
 {$If not defined(NoVCM)}
 AddUserTypeExclude(MyPostingListName, en_Tree, op_ExpandAll, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(MyPostingListName, en_Tree, op_CollapseAll, false);
 {$IfEnd} //not NoVCM
end;

{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimPostingsListOptions
 TtfwClassRef.Register(TPrimPostingsListOptionsForm);
{$IfEnd} //not Admin AND not NoScripts

end.