unit vcmChromeLikeTabbedContainerFormPrim;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabbedContainerFormPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , vcmGlassForm
 , vcmInterfaces
;

type
 TvcmChromeLikeTabbedContainerFormPrim = class(TvcmGlassForm, IvcmSizeableForm)
  protected
   function pm_GetCanChangeSize: Boolean;
   function pm_GetCanBeMaximized: Boolean;
 end;//TvcmChromeLikeTabbedContainerFormPrim
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TvcmChromeLikeTabbedContainerFormPrim.pm_GetCanChangeSize: Boolean;
//#UC START# *53C65D8F0393_53C65E480231get_var*
//#UC END# *53C65D8F0393_53C65E480231get_var*
begin
//#UC START# *53C65D8F0393_53C65E480231get_impl*
 Result := True;
//#UC END# *53C65D8F0393_53C65E480231get_impl*
end;//TvcmChromeLikeTabbedContainerFormPrim.pm_GetCanChangeSize

function TvcmChromeLikeTabbedContainerFormPrim.pm_GetCanBeMaximized: Boolean;
//#UC START# *53C65E120031_53C65E480231get_var*
//#UC END# *53C65E120031_53C65E480231get_var*
begin
//#UC START# *53C65E120031_53C65E480231get_impl*
 Result := True;
//#UC END# *53C65E120031_53C65E480231get_impl*
end;//TvcmChromeLikeTabbedContainerFormPrim.pm_GetCanBeMaximized

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmChromeLikeTabbedContainerFormPrim);
 {* Регистрация TvcmChromeLikeTabbedContainerFormPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
