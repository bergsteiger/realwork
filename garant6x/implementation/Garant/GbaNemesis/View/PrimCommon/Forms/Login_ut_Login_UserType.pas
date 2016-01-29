unit Login_ut_Login_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/Forms/Login_ut_Login_UserType.pas"
// Начат: 21.08.2009 20:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimCommon::PrimCommon::Login::ut_Login
//
// Вход в систему ГАРАНТ
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

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
    { Константы для типа формы ut_Login }
   ut_LoginName = 'ut_Login';
    { Строковый идентификатор пользовательского типа "Вход в систему ГАРАНТ" }
   ut_Login = TvcmUserType(0);
    { Вход в систему ГАРАНТ }

implementation

{$If not defined(NoScripts)}
type
   Tkw_FormUserType_ut_Login = {final scriptword} class(TtfwInteger)
    {* Слово словаря для типа формы ut_Login }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_Login
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_ut_Login

class function Tkw_FormUserType_ut_Login.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_Login';
end;//Tkw_FormUserType_ut_Login.GetWordNameForRegister

function Tkw_FormUserType_ut_Login.GetInteger: Integer;
 {-}
begin
 Result := ut_Login;
end;//Tkw_FormUserType_ut_Login.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация Tkw_FormUserType_ut_Login
 Tkw_FormUserType_ut_Login.RegisterInEngine;
{$IfEnd} //not NoScripts

end.