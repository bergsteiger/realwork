unit AdminMain_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\AdminMain_Form.pas"
// Стереотип: "VCMMainForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , PrimAdminMain_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_AdminMainForm: TvcmFormDescriptor = (rFormID : (rName : 'AdminMainForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TAdminMainForm }

type
 AdminMainFormDef = interface
  {* Идентификатор формы AdminMain }
  ['{26239010-1045-42DC-ABBF-3909601CF2CB}']
 end;//AdminMainFormDef

 TAdminMainForm = {final} class(TPrimAdminMainForm, AdminMainFormDef)
 end;//TAdminMainForm
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , AdminMainKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAdminMainForm);
 {* Регистрация AdminMain }
{$IfEnd} // NOT Defined(NoScripts)
 fm_AdminMainForm.SetFactory(TAdminMainForm.Make);
 {* Регистрация фабрики формы AdminMain }
{$IfEnd} // Defined(Admin)

end.
