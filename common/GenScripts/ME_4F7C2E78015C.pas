unit MonitoringsMain_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\MonitoringsMain_Form.pas"
// Стереотип: "VCMMainForm"
// Элемент модели: "MonitoringsMain" MUID: (4F7C2E78015C)
// Имя типа: "TMonitoringsMainForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Monitorings) AND NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimMonitoringsMain_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_MonitoringsMainForm: TvcmFormDescriptor = (rFormID : (rName : 'MonitoringsMainForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TMonitoringsMainForm }

type
 MonitoringsMainFormDef = interface
  {* Идентификатор формы MonitoringsMain }
  ['{302D255D-E242-47AD-ACB5-B3822A5E3F7F}']
 end;//MonitoringsMainFormDef

 TMonitoringsMainForm = {final} class(TPrimMonitoringsMainForm, MonitoringsMainFormDef)
 end;//TMonitoringsMainForm
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

implementation

{$If Defined(Monitorings) AND NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , MonitoringsMainKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMonitoringsMainForm);
 {* Регистрация MonitoringsMain }
{$IfEnd} // NOT Defined(NoScripts)
 fm_MonitoringsMainForm.SetFactory(TMonitoringsMainForm.Make);
 {* Регистрация фабрики формы MonitoringsMain }
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

end.
