unit AACContentsContainer_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContentsContainer_Form.pas"
// Стереотип: "VCMFinalContainer"
// Элемент модели: "AACContentsContainer" MUID: (4FF4543F014A)
// Имя типа: "TAACContentsContainerForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AACContainerPrim_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_AACContentsContainerForm: TvcmFormDescriptor = (rFormID : (rName : 'AACContentsContainerForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TAACContentsContainerForm }

type
 AACContentsContainerFormDef = interface
  {* Идентификатор формы AACContentsContainer }
  ['{3EBD2AC1-BEED-4678-BF35-5B80CE4A6852}']
 end;//AACContentsContainerFormDef

 TAACContentsContainerForm = {final} class(TAACContainerPrimForm, AACContentsContainerFormDef)
 end;//TAACContentsContainerForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , AACContentsContainerKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAACContentsContainerForm);
 {* Регистрация AACContentsContainer }
{$IfEnd} // NOT Defined(NoScripts)
 fm_AACContentsContainerForm.SetFactory(TAACContentsContainerForm.Make);
 {* Регистрация фабрики формы AACContentsContainer }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
