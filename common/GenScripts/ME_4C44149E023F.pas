unit PrimOldSituationSearchOptions_Form;
 {* Поиск по ситуации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimOldSituationSearchOptions_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimOldSituationSearchOptions" MUID: (4C44149E023F)
// Имя типа: "TPrimOldSituationSearchOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimOldSituationSearch_Form
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimOldSituationSearchOptionsForm = class(TPrimOldSituationSearchForm)
  {* Поиск по ситуации }
  public
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_GetState(var State: TvcmOperationStateIndex);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimOldSituationSearchOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C44149E023Fimpl_uses*
 //#UC END# *4C44149E023Fimpl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimOldSituationSearchOptionsForm.Edit_Delete_GetState(var State: TvcmOperationStateIndex);
 {* Удалить }
//#UC START# *494F89C30197_4C44149E023Fgetstate_var*
//#UC END# *494F89C30197_4C44149E023Fgetstate_var*
begin
//#UC START# *494F89C30197_4C44149E023Fgetstate_impl*
 // - ничего не делаем 
//#UC END# *494F89C30197_4C44149E023Fgetstate_impl*
end;//TPrimOldSituationSearchOptionsForm.Edit_Delete_GetState
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimOldSituationSearchOptionsForm);
 {* Регистрация PrimOldSituationSearchOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
