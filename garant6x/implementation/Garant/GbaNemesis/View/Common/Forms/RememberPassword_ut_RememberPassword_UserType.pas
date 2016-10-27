unit RememberPassword_ut_RememberPassword_UserType;
 {* Забыли пароль? }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\RememberPassword_ut_RememberPassword_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_RememberPassword" MUID: (76478A82A459)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки ut_RememberPasswordLocalConstants }
 str_ut_RememberPasswordCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_RememberPasswordCaption'; rValue : 'Забыли пароль?');
  {* Заголовок пользовательского типа "Забыли пароль?" }
 {* Константы для типа формы ut_RememberPassword }
 ut_RememberPasswordName = 'ut_RememberPassword';
  {* Строковый идентификатор пользовательского типа "Забыли пароль?" }
 ut_RememberPassword = TvcmUserType(0);
  {* Забыли пароль? }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_RememberPassword = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_RememberPassword }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_RememberPassword
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_RememberPassword.GetInteger: Integer;
begin
 Result := ut_RememberPassword;
end;//Tkw_FormUserType_ut_RememberPassword.GetInteger

class function Tkw_FormUserType_ut_RememberPassword.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_RememberPassword';
end;//Tkw_FormUserType_ut_RememberPassword.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_RememberPasswordCaption.Init;
 {* Инициализация str_ut_RememberPasswordCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_RememberPassword.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_RememberPassword }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
