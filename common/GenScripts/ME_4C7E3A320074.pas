unit PrimMedicFirmListOptions_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicFirmListOptions_Form.pas"
// ���������: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMedicFirmList_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Common_Strange_Controls
 , Inpharm_Strange_Controls
;

type
 TPrimMedicFirmListOptionsForm = class(TPrimMedicFirmListForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure Cut; override;
    {* �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure AddBookmark; override;
    {* �������� �������� }
   {$If NOT Defined(NoVCM)}
   procedure Paste; override;
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Undo; override;
    {* ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Redo; override;
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SelectAll; override;
    {* �������� �� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Deselect; override;
    {* ����� ��������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Wrap; override;
    {* ������� �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure OpenNewWindow; override;
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* ���������� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure CountryFilter; override;
   procedure OpenInNewTab; override;
 end;//TPrimMedicFirmListOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsUtils
 , afwFacade
 , nsTypes
 , l3TreeInterfaces
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimMedicFirmListOptionsForm.Cut;
 {* �������� }
//#UC START# *4951285702E1_4C7E3A320074_var*
//#UC END# *4951285702E1_4C7E3A320074_var*
begin
//#UC START# *4951285702E1_4C7E3A320074_impl*
 !!! Needs to be implemented !!!
//#UC END# *4951285702E1_4C7E3A320074_impl*
end;//TPrimMedicFirmListOptionsForm.Cut
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimMedicFirmListOptionsForm.AddBookmark;
 {* �������� �������� }
//#UC START# *4989D06D014E_4C7E3A320074_var*
//#UC END# *4989D06D014E_4C7E3A320074_var*
begin
//#UC START# *4989D06D014E_4C7E3A320074_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D06D014E_4C7E3A320074_impl*
end;//TPrimMedicFirmListOptionsForm.AddBookmark

{$If NOT Defined(NoVCM)}
procedure TPrimMedicFirmListOptionsForm.Paste;
 {* ������� }
//#UC START# *49EDFA3701B0_4C7E3A320074_var*
//#UC END# *49EDFA3701B0_4C7E3A320074_var*
begin
//#UC START# *49EDFA3701B0_4C7E3A320074_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFA3701B0_4C7E3A320074_impl*
end;//TPrimMedicFirmListOptionsForm.Paste
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimMedicFirmListOptionsForm.Undo;
 {* ������ }
//#UC START# *49EDFCA2006D_4C7E3A320074_var*
//#UC END# *49EDFCA2006D_4C7E3A320074_var*
begin
//#UC START# *49EDFCA2006D_4C7E3A320074_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCA2006D_4C7E3A320074_impl*
end;//TPrimMedicFirmListOptionsForm.Undo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimMedicFirmListOptionsForm.Redo;
 {* ������� }
//#UC START# *49EDFCB100BC_4C7E3A320074_var*
//#UC END# *49EDFCB100BC_4C7E3A320074_var*
begin
//#UC START# *49EDFCB100BC_4C7E3A320074_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCB100BC_4C7E3A320074_impl*
end;//TPrimMedicFirmListOptionsForm.Redo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimMedicFirmListOptionsForm.SelectAll;
 {* �������� �� }
//#UC START# *49EE01AA02BE_4C7E3A320074_var*
//#UC END# *49EE01AA02BE_4C7E3A320074_var*
begin
//#UC START# *49EE01AA02BE_4C7E3A320074_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01AA02BE_4C7E3A320074_impl*
end;//TPrimMedicFirmListOptionsForm.SelectAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimMedicFirmListOptionsForm.Deselect;
 {* ����� ��������� }
//#UC START# *49EE01BC022E_4C7E3A320074_var*
//#UC END# *49EE01BC022E_4C7E3A320074_var*
begin
//#UC START# *49EE01BC022E_4C7E3A320074_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01BC022E_4C7E3A320074_impl*
end;//TPrimMedicFirmListOptionsForm.Deselect
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimMedicFirmListOptionsForm.Wrap;
 {* ������� �� ������ }
//#UC START# *4BDAF7B803CF_4C7E3A320074_var*
//#UC END# *4BDAF7B803CF_4C7E3A320074_var*
begin
//#UC START# *4BDAF7B803CF_4C7E3A320074_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7B803CF_4C7E3A320074_impl*
end;//TPrimMedicFirmListOptionsForm.Wrap
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimMedicFirmListOptionsForm.OpenNewWindow;
//#UC START# *4C4EAC20007F_4C7E3A320074_var*
//#UC END# *4C4EAC20007F_4C7E3A320074_var*
begin
//#UC START# *4C4EAC20007F_4C7E3A320074_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C4EAC20007F_4C7E3A320074_impl*
end;//TPrimMedicFirmListOptionsForm.OpenNewWindow

{$If NOT Defined(NoVCM)}
procedure TPrimMedicFirmListOptionsForm.Copy;
 {* ���������� }
//#UC START# *4C7D0C7B0185_4C7E3A320074_var*
//#UC END# *4C7D0C7B0185_4C7E3A320074_var*
begin
//#UC START# *4C7D0C7B0185_4C7E3A320074_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0C7B0185_4C7E3A320074_impl*
end;//TPrimMedicFirmListOptionsForm.Copy
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimMedicFirmListOptionsForm.CountryFilter;
//#UC START# *4C7E4168031D_4C7E3A320074_var*
//#UC END# *4C7E4168031D_4C7E3A320074_var*
begin
//#UC START# *4C7E4168031D_4C7E3A320074_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E4168031D_4C7E3A320074_impl*
end;//TPrimMedicFirmListOptionsForm.CountryFilter

procedure TPrimMedicFirmListOptionsForm.OpenInNewTab;
//#UC START# *54A2AF9C0157_4C7E3A320074_var*
//#UC END# *54A2AF9C0157_4C7E3A320074_var*
begin
//#UC START# *54A2AF9C0157_4C7E3A320074_impl*
 !!! Needs to be implemented !!!
//#UC END# *54A2AF9C0157_4C7E3A320074_impl*
end;//TPrimMedicFirmListOptionsForm.OpenInNewTab

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimMedicFirmListOptionsForm);
 {* ����������� PrimMedicFirmListOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
