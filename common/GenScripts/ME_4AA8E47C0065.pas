unit UserProperty_Form;
 {* Свойства пользователя }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\UserProperty_Form.pas"
// Стереотип: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimUserPropertyOptions_Form
 , Admin_FormDefinitions_Controls
;

type
 TefUserProperty = {final} class(TPrimUserPropertyOptionsForm, UserPropertyFormDef)
  {* Свойства пользователя }
 end;//TefUserProperty
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , UserPropertyKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefUserProperty);
 {* Регистрация UserProperty }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efUserProperty.SetFactory(TefUserProperty.Make);
 {* Регистрация фабрики формы UserProperty }
{$IfEnd} // Defined(Admin)

end.
