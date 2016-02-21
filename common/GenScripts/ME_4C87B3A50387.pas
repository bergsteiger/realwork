unit PrimSelectedAttributesOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimSelectedAttributesOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimSelectedAttributes_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimSelectedAttributesOptionsForm = class(TPrimSelectedAttributesForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure Delete; override;
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimSelectedAttributesOptionsForm

implementation

uses
 l3ImplUses
 , l3TreeInterfaces
 , DynamicTreeUnit
 , SysUtils
 , l3Nodes
 , SearchLite_Strange_Controls
 , l3Tree_TLB
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimSelectedAttributesOptionsForm.Delete;
 {* Удалить }
//#UC START# *4C7D0CC90052_4C87B3A50387_var*
//#UC END# *4C7D0CC90052_4C87B3A50387_var*
begin
//#UC START# *4C7D0CC90052_4C87B3A50387_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7D0CC90052_4C87B3A50387_impl*
end;//TPrimSelectedAttributesOptionsForm.Delete
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSelectedAttributesOptionsForm);
 {* Регистрация PrimSelectedAttributesOptions }
{$IfEnd} // NOT Defined(NoScripts)

end.
