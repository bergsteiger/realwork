unit SynchroView_Form;
 {* Синхронный просмотр }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\SynchroView_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "SynchroView" MUID: (4AB1359700D9)
// Имя типа: "TfcSynchroView"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimSynchroViewOptions_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TfcSynchroView = {final} class(TPrimSynchroViewOptionsForm, SynchroViewFormDef)
  {* Синхронный просмотр }
   Entities : TvcmEntities;
 end;//TfcSynchroView
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , SynchroViewKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
 fm_fcSynchroView.SetFactory(TfcSynchroView.Make);
 {* Регистрация фабрики формы SynchroView }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TfcSynchroView);
 {* Регистрация SynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
