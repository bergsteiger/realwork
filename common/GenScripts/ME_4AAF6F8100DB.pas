unit Preview_Form;
 {* Предварительный просмотр }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\Preview_Form.pas"
// Стереотип: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimPreview_Form
 , Search_FormDefinitions_Controls
;

type
 TefPreviewForm = {final} class(TPrimPreviewForm, PreviewFormDef)
  {* Предварительный просмотр }
 end;//TefPreviewForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , PreviewFormKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefPreviewForm);
 {* Регистрация PreviewForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
