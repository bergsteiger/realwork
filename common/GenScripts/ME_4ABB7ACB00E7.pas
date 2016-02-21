unit Registration_Form;
 {* Регистрация }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\Registration_Form.pas"
// Стереотип: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimRegistration_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_nsRegistrationForm: TvcmFormDescriptor = (rFormID : (rName : 'nsRegistrationForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TnsRegistrationForm }

type
 RegistrationFormFormDef = interface
  {* Идентификатор формы RegistrationForm }
  ['{1C7CFA67-8415-4312-BA10-BF18AAF522CF}']
 end;//RegistrationFormFormDef

 TnsRegistrationForm = {final} class(TPrimRegistrationForm, RegistrationFormFormDef)
  {* Регистрация }
 end;//TnsRegistrationForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , RegistrationFormKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки ut_RegistrationFormLocalConstants }
 str_ut_RegistrationFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_RegistrationFormCaption'; rValue : 'Регистрация');
  {* Заголовок пользовательского типа "Регистрация" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnsRegistrationForm);
 {* Регистрация RegistrationForm }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_RegistrationFormCaption.Init;
 {* Инициализация str_ut_RegistrationFormCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
