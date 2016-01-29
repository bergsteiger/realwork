unit RememberPassword_ut_RememberPassword_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/RememberPassword_ut_RememberPassword_UserType.pas"
// Начат: 24.08.2009 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Common::View::Common::PrimF1Common::RememberPassword::ut_RememberPassword
//
// Забыли пароль?
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
    { Константы для типа формы ut_RememberPassword }
   ut_RememberPasswordName = 'ut_RememberPassword';
    { Строковый идентификатор пользовательского типа "Забыли пароль?" }
   ut_RememberPassword = TvcmUserType(0);
    { Забыли пароль? }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_RememberPassword = {final scriptword} class(TtfwInteger)
    {* Слово словаря для типа формы ut_RememberPassword }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_RememberPassword
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_RememberPassword

class function Tkw_FormUserType_ut_RememberPassword.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_RememberPassword';
end;//Tkw_FormUserType_ut_RememberPassword.GetWordNameForRegister

function Tkw_FormUserType_ut_RememberPassword.GetInteger: Integer;
 {-}
begin
 Result := ut_RememberPassword;
end;//Tkw_FormUserType_ut_RememberPassword.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_ut_RememberPassword
 Tkw_FormUserType_ut_RememberPassword.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.