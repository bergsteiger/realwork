unit Registration_Form;
 {* Регистрация }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\Registration_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "RegistrationForm" MUID: (4ABB7ACB00E7)
// Имя типа: "TnsRegistrationForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimRegistration_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_nsRegistrationForm: TvcmFormDescriptor = (rFormID : (rName : 'nsRegistrationForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TnsRegistrationForm }

type
 TnsRegistrationForm = class;

 RegistrationFormFormDef = interface
  {* Идентификатор формы RegistrationForm }
  ['{1C7CFA67-8415-4312-BA10-BF18AAF522CF}']
 end;//RegistrationFormFormDef

 TnsRegistrationForm = {final} class(TPrimRegistrationForm, RegistrationFormFormDef)
  {* Регистрация }
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TnsRegistrationForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , RegistrationForm_ut_RegistrationForm_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , RegistrationFormKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* Локализуемые строки ut_RegistrationFormLocalConstants }
 str_ut_RegistrationFormCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_RegistrationFormCaption'; rValue : 'Регистрация');
  {* Заголовок пользовательского типа "Регистрация" }

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure TnsRegistrationForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_RegistrationFormName,
  str_ut_RegistrationFormCaption,
  str_ut_RegistrationFormCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_RegistrationFormName
end;//TnsRegistrationForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_ut_RegistrationFormCaption.Init;
 {* Инициализация str_ut_RegistrationFormCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnsRegistrationForm);
 {* Регистрация RegistrationForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
