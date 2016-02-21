unit Filters_Form;
 {* Фильтры }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\Filters_Form.pas"
// Стереотип: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFiltersOptions_Form
 , Common_FormDefinitions_Controls
;

type
 TenFilters = {final} class(TPrimFiltersOptionsForm, FiltersFormDef)
  {* Фильтры }
 end;//TenFilters
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , FiltersKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenFilters);
 {* Регистрация Filters }
{$IfEnd} // NOT Defined(NoScripts)
 fm_enFilters.SetFactory(TenFilters.Make);
 {* Регистрация фабрики формы Filters }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
