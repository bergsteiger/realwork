unit GroupProperty_Form;
 {* Свойства группы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\GroupProperty_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "GroupProperty" MUID: (4AA8E3E20024)
// Имя типа: "TefGroupProperty"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimGroupPropertyOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_efGroupProperty: TvcmFormDescriptor = (rFormID : (rName : 'efGroupProperty'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefGroupProperty }

type
 GroupPropertyFormDef = interface
  {* Идентификатор формы GroupProperty }
  ['{F213AE84-ECF9-427D-8B89-53C6221D1F27}']
 end;//GroupPropertyFormDef

 TefGroupProperty = {final} class(TPrimGroupPropertyOptionsForm, GroupPropertyFormDef)
  {* Свойства группы }
 end;//TefGroupProperty
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , GroupPropertyKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefGroupProperty);
 {* Регистрация GroupProperty }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
