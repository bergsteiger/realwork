unit PrimDictionOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimDictionOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDiction_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimDictionOptionsForm = class(TPrimDictionForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure ExpandAll; override;
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CollapseAll; override;
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimDictionOptionsForm
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
procedure TPrimDictionOptionsForm.ExpandAll;
 {* Развернуть все }
//#UC START# *4BDAF7880236_51B860F20280_var*
//#UC END# *4BDAF7880236_51B860F20280_var*
begin
//#UC START# *4BDAF7880236_51B860F20280_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7880236_51B860F20280_impl*
end;//TPrimDictionOptionsForm.ExpandAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimDictionOptionsForm.CollapseAll;
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_51B860F20280_var*
//#UC END# *4BDAF7A2005C_51B860F20280_var*
begin
//#UC START# *4BDAF7A2005C_51B860F20280_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7A2005C_51B860F20280_impl*
end;//TPrimDictionOptionsForm.CollapseAll
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDictionOptionsForm);
 {* Регистрация PrimDictionOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
