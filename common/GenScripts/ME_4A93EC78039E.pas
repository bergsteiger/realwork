unit RememberPassword_Form;
 {* Забыли пароль? }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\RememberPassword_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "RememberPassword" MUID: (4A93EC78039E)
// Имя типа: "TRememberPasswordForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimRememberPassword_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_RememberPasswordForm: TvcmFormDescriptor = (rFormID : (rName : 'RememberPasswordForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TRememberPasswordForm }

type
 TRememberPasswordForm = class;

 RememberPasswordFormDef = interface
  {* Идентификатор формы RememberPassword }
  ['{332C1743-EA95-4386-9F6E-677BF58FAE7D}']
 end;//RememberPasswordFormDef

 TRememberPasswordForm = {final} class(TPrimRememberPasswordForm, RememberPasswordFormDef)
  {* Забыли пароль? }
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TRememberPasswordForm
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
 , RememberPassword_ut_RememberPassword_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , RememberPasswordKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* Локализуемые строки ut_RememberPasswordLocalConstants }
 str_ut_RememberPasswordCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_RememberPasswordCaption'; rValue : 'Забыли пароль?');
  {* Заголовок пользовательского типа "Забыли пароль?" }

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure TRememberPasswordForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_RememberPasswordName,
  str_ut_RememberPasswordCaption,
  str_ut_RememberPasswordCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_RememberPasswordName
end;//TRememberPasswordForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TRememberPasswordForm);
 {* Регистрация RememberPassword }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_RememberPasswordCaption.Init;
 {* Инициализация str_ut_RememberPasswordCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
