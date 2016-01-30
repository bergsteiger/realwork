unit PrimPostingsListOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\Forms\PrimPostingsListOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimPostingsList_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , PostingOrder_Strange_Controls
 , PrimPostingsList_MyPostingList_UserType
;

type
 TPrimPostingsListOptionsForm = class(TPrimPostingsListForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure ExpandAll; override;
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CollapseAll; override;
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ActivatePostingsListForm; override;
   procedure ptEditPosting; override;
 end;//TPrimPostingsListOptionsForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
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

{$If NOT Defined(NoVCM)}
procedure TPrimPostingsListOptionsForm.ExpandAll;
 {* Развернуть все }
//#UC START# *4BDAF7880236_4DF789BF02EF_var*
//#UC END# *4BDAF7880236_4DF789BF02EF_var*
begin
//#UC START# *4BDAF7880236_4DF789BF02EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7880236_4DF789BF02EF_impl*
end;//TPrimPostingsListOptionsForm.ExpandAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPostingsListOptionsForm.CollapseAll;
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4DF789BF02EF_var*
//#UC END# *4BDAF7A2005C_4DF789BF02EF_var*
begin
//#UC START# *4BDAF7A2005C_4DF789BF02EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7A2005C_4DF789BF02EF_impl*
end;//TPrimPostingsListOptionsForm.CollapseAll
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimPostingsListOptionsForm.ActivatePostingsListForm;
//#UC START# *553FAEED007A_4DF789BF02EF_var*
//#UC END# *553FAEED007A_4DF789BF02EF_var*
begin
//#UC START# *553FAEED007A_4DF789BF02EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *553FAEED007A_4DF789BF02EF_impl*
end;//TPrimPostingsListOptionsForm.ActivatePostingsListForm

procedure TPrimPostingsListOptionsForm.ptEditPosting;
//#UC START# *4C84EE1D0024_4DF789BF02EF_var*
//#UC END# *4C84EE1D0024_4DF789BF02EF_var*
begin
//#UC START# *4C84EE1D0024_4DF789BF02EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C84EE1D0024_4DF789BF02EF_impl*
end;//TPrimPostingsListOptionsForm.ptEditPosting

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPostingsListOptionsForm);
 {* Регистрация PrimPostingsListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
