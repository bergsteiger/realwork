unit AACContainer_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainer_Form.pas"
// Стереотип: "VCMFinalContainer"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AACTextContainerPrim_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_AACContainerForm: TvcmFormDescriptor = (rFormID : (rName : 'AACContainerForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TAACContainerForm }

type
 AACContainerFormDef = interface
  {* Идентификатор формы AACContainer }
  ['{548CB0E3-A19F-4AD8-A785-C6FB8E70BF73}']
 end;//AACContainerFormDef

 TAACContainerForm = {final} class(TAACTextContainerPrimForm, AACContainerFormDef)
 end;//TAACContainerForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , AACContainerKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAACContainerForm);
 {* Регистрация AACContainer }
{$IfEnd} // NOT Defined(NoScripts)
 fm_AACContainerForm.SetFactory(TAACContainerForm.Make);
 {* Регистрация фабрики формы AACContainer }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
