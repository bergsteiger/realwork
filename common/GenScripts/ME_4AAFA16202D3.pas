unit PostingsList_Form;
 {* ПРАЙМ. Моя новостная лента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\Forms\PostingsList_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "PostingsList" MUID: (4AAFA16202D3)
// Имя типа: "TenPostingsList"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimPostingsListOptions_Form
 , PostingOrder_FormDefinitions_Controls
;

type
 TenPostingsList = {final} class(TPrimPostingsListOptionsForm, PostingsListFormDef)
  {* ПРАЙМ. Моя новостная лента }
 end;//TenPostingsList
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , PostingsListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenPostingsList);
 {* Регистрация PostingsList }
{$IfEnd} // NOT Defined(NoScripts)
 fm_enPostingsList.SetFactory(TenPostingsList.Make);
 {* Регистрация фабрики формы PostingsList }
{$IfEnd} // NOT Defined(Admin)

end.
