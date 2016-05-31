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
 {$If NOT Defined(NoVCM)}
 , vcmEntities
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
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TLoginForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , Login_ut_Login_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , LoginKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure TLoginForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_LoginName,
  str_ut_LoginCaption,
  str_ut_LoginCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_LoginName
end;//TLoginForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 fm_LoginForm.SetFactory(TLoginForm.Make);
 {* Регистрация фабрики формы Login }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TLoginForm);
 {* Регистрация Login }
{$IfEnd} // NOT Defined(NoScripts)

end.
