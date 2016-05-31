unit PrimPostingsListOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\Forms\PrimPostingsListOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimPostingsListOptions" MUID: (4DF789BF02EF)
// Имя типа: "TPrimPostingsListOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimPostingsList_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , PostingOrder_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimPostingsListOptionsForm = class(TPrimPostingsListForm)
  protected
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure SearchSupport_ActivatePostingsListForm_Execute;
   procedure SearchSupport_ActivatePostingsListForm(const aParams: IvcmExecuteParams);
 end;//TPrimPostingsListOptionsForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , PrimPostingsList_MyPostingList_UserType
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3TabbedContainersDispatcher
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4DF789BF02EFimpl_uses*
 //#UC END# *4DF789BF02EFimpl_uses*
;

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
 Self.SearchSupport_ActivatePostingsListForm_Execute;
end;//TPrimPostingsListOptionsForm.SearchSupport_ActivatePostingsListForm

{$If NOT Defined(NoVCM)}
procedure TPrimPostingsListOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Tree, nil);
  PublishFormEntity(en_SearchSupport, nil);
  PublishOp(en_Tree, op_ExpandAll, nil, nil, nil);
  PublishOp(en_Tree, op_CollapseAll, nil, nil, nil);
  PublishOpWithResult(en_SearchSupport, op_ActivatePostingsListForm, SearchSupport_ActivatePostingsListForm, nil, nil);
  ShowInContextMenu(en_PostingToolBar, op_ptEditPosting, True, true);
  ShowInToolbar(en_PostingToolBar, op_ptEditPosting, True, true);
 end;//with Entities.Entities
 AddUserTypeExclude(MyPostingListName, en_Tree, op_ExpandAll, False);
 AddUserTypeExclude(MyPostingListName, en_Tree, op_CollapseAll, False);
end;//TPrimPostingsListOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPostingsListOptionsForm);
 {* Регистрация PrimPostingsListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
