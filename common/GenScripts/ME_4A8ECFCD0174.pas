unit NewsLine_Form;
 {* ПРАЙМ. Моя новостная лента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\NewsLine_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "NewsLine" MUID: (4A8ECFCD0174)
// Имя типа: "TenNewsLine"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimNewsLineOptions_Form
 , Common_FormDefinitions_Controls
;

type
 TenNewsLine = {final} class(TPrimNewsLineOptionsForm, NewsLineFormDef)
  {* ПРАЙМ. Моя новостная лента }
 end;//TenNewsLine
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , NewsLineKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenNewsLine);
 {* Регистрация NewsLine }
{$IfEnd} // NOT Defined(NoScripts)
 fm_enNewsLine.SetFactory(TenNewsLine.Make);
 {* Регистрация фабрики формы NewsLine }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
