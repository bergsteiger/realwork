unit Rubricator_Form;
 {* Правовой навигатор }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\Forms\Rubricator_Form.pas"
// Стереотип: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimRubricator_Form
 , Common_FormDefinitions_Controls
;

type
 TefRubricator = {final} class(TPrimRubricatorForm, RubricatorFormDef)
  {* Правовой навигатор }
 end;//TefRubricator
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , RubricatorKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefRubricator);
 {* Регистрация Rubricator }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efRubricator.SetFactory(TefRubricator.Make);
 {* Регистрация фабрики формы Rubricator }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
