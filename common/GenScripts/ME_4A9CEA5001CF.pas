unit Diction_Form;
 {* Толковый словарь }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\Diction_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "Diction" MUID: (4A9CEA5001CF)
// Имя типа: "TenDiction"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimDictionOptions_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TenDiction = {final} class(TPrimDictionOptionsForm, DictionFormDef)
  {* Толковый словарь }
   Entities : TvcmEntities;
 end;//TenDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , DictionKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_enDiction.SetFactory(TenDiction.Make);
 {* Регистрация фабрики формы Diction }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenDiction);
 {* Регистрация Diction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
