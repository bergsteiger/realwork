unit Login_Form;
 {* Вход в систему ГАРАНТ }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\Login_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "Login" MUID: (4A93D829005C)
// Имя типа: "TLoginForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimLogin_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_LoginForm: TvcmFormDescriptor = (rFormID : (rName : 'LoginForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TLoginForm }

type
 TLoginForm = class;

 LoginFormDef = interface
  {* Идентификатор формы Login }
  ['{96B4FBEB-A42A-4990-BCED-2F439F4E152A}']
 end;//LoginFormDef

 TLoginForm = {final} class(TPrimLoginForm, LoginFormDef)
  {* Вход в систему ГАРАНТ }
 end;//TLoginForm

implementation

uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 , Login_ut_Login_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , LoginKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* Локализуемые строки ut_LoginLocalConstants }
 str_ut_LoginCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_LoginCaption'; rValue : 'Вход в систему ГАРАНТ');
  {* Заголовок пользовательского типа "Вход в систему ГАРАНТ" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TLoginForm);
 {* Регистрация Login }
{$IfEnd} // NOT Defined(NoScripts)
 fm_LoginForm.SetFactory(TLoginForm.Make);
 {* Регистрация фабрики формы Login }
 str_ut_LoginCaption.Init;
 {* Инициализация str_ut_LoginCaption }

end.
