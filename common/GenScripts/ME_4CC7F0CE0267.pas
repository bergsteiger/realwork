unit PrimBaseSearchOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\PrimBaseSearchOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimBaseSearch_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Text_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimBaseSearchOptionsForm = class(TPrimBaseSearchForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure FindNext; override;
    {* Найти далее }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Undo; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Redo; override;
    {* Возврат }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FindPrev; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimBaseSearchOptionsForm
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
procedure TPrimBaseSearchOptionsForm.FindNext;
 {* Найти далее }
//#UC START# *495130C40123_4CC7F0CE0267_var*
//#UC END# *495130C40123_4CC7F0CE0267_var*
begin
//#UC START# *495130C40123_4CC7F0CE0267_impl*
 !!! Needs to be implemented !!!
//#UC END# *495130C40123_4CC7F0CE0267_impl*
end;//TPrimBaseSearchOptionsForm.FindNext
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimBaseSearchOptionsForm.Undo;
 {* Отмена }
//#UC START# *49EDFCA2006D_4CC7F0CE0267_var*
//#UC END# *49EDFCA2006D_4CC7F0CE0267_var*
begin
//#UC START# *49EDFCA2006D_4CC7F0CE0267_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCA2006D_4CC7F0CE0267_impl*
end;//TPrimBaseSearchOptionsForm.Undo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimBaseSearchOptionsForm.Redo;
 {* Возврат }
//#UC START# *49EDFCB100BC_4CC7F0CE0267_var*
//#UC END# *49EDFCB100BC_4CC7F0CE0267_var*
begin
//#UC START# *49EDFCB100BC_4CC7F0CE0267_impl*
 !!! Needs to be implemented !!!
//#UC END# *49EDFCB100BC_4CC7F0CE0267_impl*
end;//TPrimBaseSearchOptionsForm.Redo
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimBaseSearchOptionsForm.FindPrev;
//#UC START# *49FEDE4703B8_4CC7F0CE0267_var*
//#UC END# *49FEDE4703B8_4CC7F0CE0267_var*
begin
//#UC START# *49FEDE4703B8_4CC7F0CE0267_impl*
 !!! Needs to be implemented !!!
//#UC END# *49FEDE4703B8_4CC7F0CE0267_impl*
end;//TPrimBaseSearchOptionsForm.FindPrev
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimBaseSearchOptionsForm);
 {* Регистрация PrimBaseSearchOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
