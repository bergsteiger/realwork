unit PrimDocumentWithFlashOptions_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDocumentWithFlashOptions_Form.pas"
// ���������: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDocumentWithFlash_Form
;

type
 TPrimDocumentWithFlashOptionsForm = class(TPrimDocumentWithFlashForm)
  public
   procedure NextDocumentInList; override;
    {* ��������� �������� � ������ }
   procedure ReturnToList; override;
    {* ��������� � ����� }
   procedure GetRelatedDocFrmAct; override;
    {* ������� � ��������� }
   procedure AddBookmark; override;
    {* �������� �������� }
   procedure GetCorrespondentList; override;
    {* ������ �� �������� }
   procedure GetRespondentList; override;
    {* ������ �� ��������� }
   procedure GetCorrespondentListExFrmAct; override;
    {* ������ �� �������� (��� ����������) }
   procedure GetRespondentListExFrmAct; override;
    {* ������ �� ��������� (��� ����������) }
   procedure GetAttributesFrmAct; override;
    {* ���������� � ��������� }
   procedure AddToControl; override;
    {* ��������� �� �������� }
   procedure UserCR1; override;
    {* ���������������� ������ �� �������� (������ �� ���������) 1 }
   procedure UserCR2; override;
    {* ���������������� ������ �� �������� (������ �� ���������) 2 }
   procedure PrevDocumentInList; override;
    {* ���������� �������� � ������ }
   procedure DocumentIsUseful; override;
    {* �������� }
   procedure DocumentIsUseless; override;
    {* �� �������� }
 end;//TPrimDocumentWithFlashOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TPrimDocumentWithFlashOptionsForm.NextDocumentInList;
 {* ��������� �������� � ������ }
//#UC START# *49880FD20039_4C87849303A6_var*
//#UC END# *49880FD20039_4C87849303A6_var*
begin
//#UC START# *49880FD20039_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *49880FD20039_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.NextDocumentInList

procedure TPrimDocumentWithFlashOptionsForm.ReturnToList;
 {* ��������� � ����� }
//#UC START# *49880FE90145_4C87849303A6_var*
//#UC END# *49880FE90145_4C87849303A6_var*
begin
//#UC START# *49880FE90145_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *49880FE90145_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.ReturnToList

procedure TPrimDocumentWithFlashOptionsForm.GetRelatedDocFrmAct;
 {* ������� � ��������� }
//#UC START# *498993C801DC_4C87849303A6_var*
//#UC END# *498993C801DC_4C87849303A6_var*
begin
//#UC START# *498993C801DC_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *498993C801DC_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.GetRelatedDocFrmAct

procedure TPrimDocumentWithFlashOptionsForm.AddBookmark;
 {* �������� �������� }
//#UC START# *4989D06D014E_4C87849303A6_var*
//#UC END# *4989D06D014E_4C87849303A6_var*
begin
//#UC START# *4989D06D014E_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D06D014E_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.AddBookmark

procedure TPrimDocumentWithFlashOptionsForm.GetCorrespondentList;
 {* ������ �� �������� }
//#UC START# *4989D65C0275_4C87849303A6_var*
//#UC END# *4989D65C0275_4C87849303A6_var*
begin
//#UC START# *4989D65C0275_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D65C0275_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.GetCorrespondentList

procedure TPrimDocumentWithFlashOptionsForm.GetRespondentList;
 {* ������ �� ��������� }
//#UC START# *4989D8430128_4C87849303A6_var*
//#UC END# *4989D8430128_4C87849303A6_var*
begin
//#UC START# *4989D8430128_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D8430128_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.GetRespondentList

procedure TPrimDocumentWithFlashOptionsForm.GetCorrespondentListExFrmAct;
 {* ������ �� �������� (��� ����������) }
//#UC START# *4AF329F6002A_4C87849303A6_var*
//#UC END# *4AF329F6002A_4C87849303A6_var*
begin
//#UC START# *4AF329F6002A_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF329F6002A_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.GetCorrespondentListExFrmAct

procedure TPrimDocumentWithFlashOptionsForm.GetRespondentListExFrmAct;
 {* ������ �� ��������� (��� ����������) }
//#UC START# *4AF329FD014D_4C87849303A6_var*
//#UC END# *4AF329FD014D_4C87849303A6_var*
begin
//#UC START# *4AF329FD014D_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF329FD014D_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.GetRespondentListExFrmAct

procedure TPrimDocumentWithFlashOptionsForm.GetAttributesFrmAct;
 {* ���������� � ��������� }
//#UC START# *4C7B9EBC01AC_4C87849303A6_var*
//#UC END# *4C7B9EBC01AC_4C87849303A6_var*
begin
//#UC START# *4C7B9EBC01AC_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7B9EBC01AC_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.GetAttributesFrmAct

procedure TPrimDocumentWithFlashOptionsForm.AddToControl;
 {* ��������� �� �������� }
//#UC START# *4C7BABCE03C0_4C87849303A6_var*
//#UC END# *4C7BABCE03C0_4C87849303A6_var*
begin
//#UC START# *4C7BABCE03C0_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BABCE03C0_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.AddToControl

procedure TPrimDocumentWithFlashOptionsForm.UserCR1;
 {* ���������������� ������ �� �������� (������ �� ���������) 1 }
//#UC START# *4C7BAC1902F5_4C87849303A6_var*
//#UC END# *4C7BAC1902F5_4C87849303A6_var*
begin
//#UC START# *4C7BAC1902F5_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAC1902F5_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.UserCR1

procedure TPrimDocumentWithFlashOptionsForm.UserCR2;
 {* ���������������� ������ �� �������� (������ �� ���������) 2 }
//#UC START# *4C7BAC5101CA_4C87849303A6_var*
//#UC END# *4C7BAC5101CA_4C87849303A6_var*
begin
//#UC START# *4C7BAC5101CA_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAC5101CA_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.UserCR2

procedure TPrimDocumentWithFlashOptionsForm.PrevDocumentInList;
 {* ���������� �������� � ������ }
//#UC START# *4FE1BA1303D3_4C87849303A6_var*
//#UC END# *4FE1BA1303D3_4C87849303A6_var*
begin
//#UC START# *4FE1BA1303D3_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FE1BA1303D3_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.PrevDocumentInList

procedure TPrimDocumentWithFlashOptionsForm.DocumentIsUseful;
 {* �������� }
//#UC START# *4FE1EF1201D6_4C87849303A6_var*
//#UC END# *4FE1EF1201D6_4C87849303A6_var*
begin
//#UC START# *4FE1EF1201D6_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FE1EF1201D6_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.DocumentIsUseful

procedure TPrimDocumentWithFlashOptionsForm.DocumentIsUseless;
 {* �� �������� }
//#UC START# *4FE1EF1B039A_4C87849303A6_var*
//#UC END# *4FE1EF1B039A_4C87849303A6_var*
begin
//#UC START# *4FE1EF1B039A_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FE1EF1B039A_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.DocumentIsUseless

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDocumentWithFlashOptionsForm);
 {* ����������� PrimDocumentWithFlashOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
