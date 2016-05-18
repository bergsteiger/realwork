unit MedicListSynchroView_Form;
 {* Синхронный просмотр }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\MedicListSynchroView_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "MedicListSynchroView" MUID: (4AB9E6D40211)
// Имя типа: "Ten_MedicListSynchroView"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMedicListSynchroView_Form
 , Common_FormDefinitions_Controls
;

type
 Ten_MedicListSynchroView = {final} class(TPrimMedicListSynchroViewForm, MedicListSynchroViewFormDef)
  {* Синхронный просмотр }
 end;//Ten_MedicListSynchroView
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MedicListSynchroViewKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_MedicListSynchroView);
 {* Регистрация MedicListSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_MedicListSynchroView.SetFactory(Ten_MedicListSynchroView.Make);
 {* Регистрация фабрики формы MedicListSynchroView }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
