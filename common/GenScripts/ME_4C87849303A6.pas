unit PrimDocumentWithFlashOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDocumentWithFlashOptions_Form.pas"
// Стереотип: "VCMForm"

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
    {* Следующий документ в списке }
   procedure ReturnToList; override;
    {* Вернуться в списк }
   procedure GetRelatedDocFrmAct; override;
    {* Справка к документу }
   procedure AddBookmark; override;
    {* Добавить закладку }
   procedure GetCorrespondentList; override;
    {* Ссылки на документ }
   procedure GetRespondentList; override;
    {* Ссылки из документа }
   procedure GetCorrespondentListExFrmAct; override;
    {* Ссылки на документ (вид информации) }
   procedure GetRespondentListExFrmAct; override;
    {* Ссылки из документа (вид информации) }
   procedure GetAttributesFrmAct; override;
    {* Информация о документе }
   procedure AddToControl; override;
    {* Поставить на контроль }
   procedure UserCR1; override;
    {* Пользовательские ссылки на документ (ссылки из документа) 1 }
   procedure UserCR2; override;
    {* Пользовательские ссылки на документ (ссылки из документа) 2 }
   procedure PrevDocumentInList; override;
    {* Предыдущий документ в списке }
   procedure DocumentIsUseful; override;
    {* Нравится }
   procedure DocumentIsUseless; override;
    {* Не нравится }
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
 {* Следующий документ в списке }
//#UC START# *49880FD20039_4C87849303A6_var*
//#UC END# *49880FD20039_4C87849303A6_var*
begin
//#UC START# *49880FD20039_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *49880FD20039_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.NextDocumentInList

procedure TPrimDocumentWithFlashOptionsForm.ReturnToList;
 {* Вернуться в списк }
//#UC START# *49880FE90145_4C87849303A6_var*
//#UC END# *49880FE90145_4C87849303A6_var*
begin
//#UC START# *49880FE90145_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *49880FE90145_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.ReturnToList

procedure TPrimDocumentWithFlashOptionsForm.GetRelatedDocFrmAct;
 {* Справка к документу }
//#UC START# *498993C801DC_4C87849303A6_var*
//#UC END# *498993C801DC_4C87849303A6_var*
begin
//#UC START# *498993C801DC_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *498993C801DC_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.GetRelatedDocFrmAct

procedure TPrimDocumentWithFlashOptionsForm.AddBookmark;
 {* Добавить закладку }
//#UC START# *4989D06D014E_4C87849303A6_var*
//#UC END# *4989D06D014E_4C87849303A6_var*
begin
//#UC START# *4989D06D014E_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D06D014E_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.AddBookmark

procedure TPrimDocumentWithFlashOptionsForm.GetCorrespondentList;
 {* Ссылки на документ }
//#UC START# *4989D65C0275_4C87849303A6_var*
//#UC END# *4989D65C0275_4C87849303A6_var*
begin
//#UC START# *4989D65C0275_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D65C0275_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.GetCorrespondentList

procedure TPrimDocumentWithFlashOptionsForm.GetRespondentList;
 {* Ссылки из документа }
//#UC START# *4989D8430128_4C87849303A6_var*
//#UC END# *4989D8430128_4C87849303A6_var*
begin
//#UC START# *4989D8430128_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4989D8430128_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.GetRespondentList

procedure TPrimDocumentWithFlashOptionsForm.GetCorrespondentListExFrmAct;
 {* Ссылки на документ (вид информации) }
//#UC START# *4AF329F6002A_4C87849303A6_var*
//#UC END# *4AF329F6002A_4C87849303A6_var*
begin
//#UC START# *4AF329F6002A_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF329F6002A_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.GetCorrespondentListExFrmAct

procedure TPrimDocumentWithFlashOptionsForm.GetRespondentListExFrmAct;
 {* Ссылки из документа (вид информации) }
//#UC START# *4AF329FD014D_4C87849303A6_var*
//#UC END# *4AF329FD014D_4C87849303A6_var*
begin
//#UC START# *4AF329FD014D_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF329FD014D_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.GetRespondentListExFrmAct

procedure TPrimDocumentWithFlashOptionsForm.GetAttributesFrmAct;
 {* Информация о документе }
//#UC START# *4C7B9EBC01AC_4C87849303A6_var*
//#UC END# *4C7B9EBC01AC_4C87849303A6_var*
begin
//#UC START# *4C7B9EBC01AC_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7B9EBC01AC_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.GetAttributesFrmAct

procedure TPrimDocumentWithFlashOptionsForm.AddToControl;
 {* Поставить на контроль }
//#UC START# *4C7BABCE03C0_4C87849303A6_var*
//#UC END# *4C7BABCE03C0_4C87849303A6_var*
begin
//#UC START# *4C7BABCE03C0_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BABCE03C0_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.AddToControl

procedure TPrimDocumentWithFlashOptionsForm.UserCR1;
 {* Пользовательские ссылки на документ (ссылки из документа) 1 }
//#UC START# *4C7BAC1902F5_4C87849303A6_var*
//#UC END# *4C7BAC1902F5_4C87849303A6_var*
begin
//#UC START# *4C7BAC1902F5_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAC1902F5_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.UserCR1

procedure TPrimDocumentWithFlashOptionsForm.UserCR2;
 {* Пользовательские ссылки на документ (ссылки из документа) 2 }
//#UC START# *4C7BAC5101CA_4C87849303A6_var*
//#UC END# *4C7BAC5101CA_4C87849303A6_var*
begin
//#UC START# *4C7BAC5101CA_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7BAC5101CA_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.UserCR2

procedure TPrimDocumentWithFlashOptionsForm.PrevDocumentInList;
 {* Предыдущий документ в списке }
//#UC START# *4FE1BA1303D3_4C87849303A6_var*
//#UC END# *4FE1BA1303D3_4C87849303A6_var*
begin
//#UC START# *4FE1BA1303D3_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FE1BA1303D3_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.PrevDocumentInList

procedure TPrimDocumentWithFlashOptionsForm.DocumentIsUseful;
 {* Нравится }
//#UC START# *4FE1EF1201D6_4C87849303A6_var*
//#UC END# *4FE1EF1201D6_4C87849303A6_var*
begin
//#UC START# *4FE1EF1201D6_4C87849303A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FE1EF1201D6_4C87849303A6_impl*
end;//TPrimDocumentWithFlashOptionsForm.DocumentIsUseful

procedure TPrimDocumentWithFlashOptionsForm.DocumentIsUseless;
 {* Не нравится }
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
 {* Регистрация PrimDocumentWithFlashOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
