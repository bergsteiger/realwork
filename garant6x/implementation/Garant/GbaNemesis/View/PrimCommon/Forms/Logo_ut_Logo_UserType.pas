unit Logo_ut_Logo_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/Forms/Logo_ut_Logo_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimCommon::Logo::ut_Logo
//
// Logo
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
   { Константы для типа формы ut_Logo }
  ut_LogoName = 'ut_Logo';
   { Строковый идентификатор пользовательского типа "Logo" }
  ut_Logo = TvcmUserType(0);
   { Logo }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_ut_Logo = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы ut_Logo }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_ut_Logo
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_ut_Logo

class function Tkw_FormUserType_ut_Logo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_Logo';
end;//Tkw_FormUserType_ut_Logo.GetWordNameForRegister

function Tkw_FormUserType_ut_Logo.GetInteger: Integer;
 {-}
begin
 Result := ut_Logo;
end;//Tkw_FormUserType_ut_Logo.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация Tkw_FormUserType_ut_Logo
 Tkw_FormUserType_ut_Logo.RegisterInEngine;
{$IfEnd} //not NoScripts

end.