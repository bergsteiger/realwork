unit PrimOldSituationSearchOptions_Form;
 {* ����� �� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimOldSituationSearchOptions_Form.pas"
// ���������: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimOldSituationSearch_Form
;

type
 TPrimOldSituationSearchOptionsForm = class(TPrimOldSituationSearchForm)
  {* ����� �� �������� }
  public
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Copy; override;
    {* ���������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cut; override;
    {* �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FindContext; override;
    {* ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FindNext; override;
    {* ����� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
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
   procedure FindPrev; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimOldSituationSearchOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimOldSituationSearchOptionsForm.Delete;
 {* ������� }
//#UC START# *494F89C30197_4C44149E023F_var*
//#UC END# *494F89C30197_4C44149E023F_var*
begin
//#UC START# *494F89C30197_4C44149E023F_impl*
 !!! Needs to be implemented !!!
//#UC END# *494F89C30197_4C44149E023F_impl*
end;//TPrimOldSituationSearchOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimOldSituationSearchOptionsForm.Copy;
 {* ���������� }
//#UC START# *4951284902BD_4C44149E023F_var*
//#UC END# *4951284902BD_4C44149E023F_var*
begin
//#UC START# *4951284902BD_4C44149E023F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4951284902BD_4C44149E023F_impl*
end;//TPrimOldSituationSearchOptionsForm.Copy
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimOldSituationSearchOptionsForm.Cut;
 {* �������� }
//#UC START# *4951285702E1_4C44149E023F_var*
//#UC END# *4951285702E1_4C44149E023F_var*
begin
//#UC START# *4951285702E1_4C44149E023F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4951285702E1_4C44149E023F_impl*
end;//TPrimOldSituationSearchOptionsForm.Cut
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimOldSituationSearchOptionsForm.FindContext;
 {* ����� }
//#UC START# *49512B5D0009_4C44149E023F_var*
//#UC END# *49512B5D0009_4C44149E023F_var*
begin
//#UC START# *49512B5D0009_4C44149E023F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49512B5D0009_4C44149E023F_impl*
end;//TPrimOldSituationSearchOptionsForm.FindContext
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimOldSituationSearchOptionsForm.FindNext;
 {* ����� ����� }
//#UC START# *495130C40123_4C44149E023F_var*
//#UC END# *495130C40123_4C44149E023F_var*
begin
//#UC START# *495130C40123_4C44149E023F_impl*
 !!! Needs to be implemented !!!
//#UC END# *495130C40123_4C44149E023F_impl*
end;//TPrimOldSituationSearchOptionsForm.FindNext
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimOldSituationSearchOptionsForm.Paste;
 {* ������� }
//#UC START# *49EDFA3701B0_4C44149E023F_var*
//#UC END# *49EDFA3701B0_4C44149E023F_var*
begin
//#UC START# *49EDFA3701B0_4C44149E023F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFA3701B0_4C44149E023F_impl*
end;//TPrimOldSituationSearchOptionsForm.Paste
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimOldSituationSearchOptionsForm.Undo;
 {* ������ }
//#UC START# *49EDFCA2006D_4C44149E023F_var*
//#UC END# *49EDFCA2006D_4C44149E023F_var*
begin
//#UC START# *49EDFCA2006D_4C44149E023F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCA2006D_4C44149E023F_impl*
end;//TPrimOldSituationSearchOptionsForm.Undo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimOldSituationSearchOptionsForm.Redo;
 {* ������� }
//#UC START# *49EDFCB100BC_4C44149E023F_var*
//#UC END# *49EDFCB100BC_4C44149E023F_var*
begin
//#UC START# *49EDFCB100BC_4C44149E023F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCB100BC_4C44149E023F_impl*
end;//TPrimOldSituationSearchOptionsForm.Redo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimOldSituationSearchOptionsForm.SelectAll;
 {* �������� �� }
//#UC START# *49EE01AA02BE_4C44149E023F_var*
//#UC END# *49EE01AA02BE_4C44149E023F_var*
begin
//#UC START# *49EE01AA02BE_4C44149E023F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01AA02BE_4C44149E023F_impl*
end;//TPrimOldSituationSearchOptionsForm.SelectAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimOldSituationSearchOptionsForm.Deselect;
 {* ����� ��������� }
//#UC START# *49EE01BC022E_4C44149E023F_var*
//#UC END# *49EE01BC022E_4C44149E023F_var*
begin
//#UC START# *49EE01BC022E_4C44149E023F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EE01BC022E_4C44149E023F_impl*
end;//TPrimOldSituationSearchOptionsForm.Deselect
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimOldSituationSearchOptionsForm.FindPrev;
//#UC START# *49FEDE4703B8_4C44149E023F_var*
//#UC END# *49FEDE4703B8_4C44149E023F_var*
begin
//#UC START# *49FEDE4703B8_4C44149E023F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49FEDE4703B8_4C44149E023F_impl*
end;//TPrimOldSituationSearchOptionsForm.FindPrev
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimOldSituationSearchOptionsForm);
 {* ����������� PrimOldSituationSearchOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
