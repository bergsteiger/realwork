unit NOT_FINISHED_NewBaseSearch_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\NOT_FINISHED_NewBaseSearch_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "NewBaseSearch" MUID: (4CF4BE9C035F)
// Имя типа: "TNewBaseSearchForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , NewBaseSearchForDFM_Form
 , Common_FormDefinitions_Controls
;

type
 TNewBaseSearchForm = {final} class(TNewBaseSearchForDFMForm, NewBaseSearchFormDef)
 end;//TNewBaseSearchForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , NewBaseSearchKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TNewBaseSearchForm);
 {* Регистрация NewBaseSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
