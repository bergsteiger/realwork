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
;

type
 TPrimPostingsListOptionsForm = class(TPrimPostingsListForm)
  public
   procedure SearchSupport_ActivatePostingsListForm_Execute;
   procedure SearchSupport_ActivatePostingsListForm(const aParams: IvcmExecuteParamsPrim);
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
;

type
 // ExcludeTree

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

procedure TPrimPostingsListOptionsForm.SearchSupport_ActivatePostingsListForm(const aParams: IvcmExecuteParamsPrim);
begin
 Self.SearchSupport_ActivatePostingsListForm_Execute;
end;//TPrimPostingsListOptionsForm.SearchSupport_ActivatePostingsListForm

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPostingsListOptionsForm);
 {* Регистрация PrimPostingsListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
