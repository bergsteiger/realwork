unit BaloonWarningUserTypes_WarnJuror_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaloonWarningUserTypes_WarnJuror_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::BaloonWarningUserTypes::WarnJuror
//
// Юридическое предупреждение
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
  ,
  BaloonWarningUserTypes_Fake_UserType
  ;

const
   { Константы для типа формы WarnJuror }
  WarnJurorName = 'WarnJuror';
   { Строковый идентификатор пользовательского типа "Юридическое предупреждение" }
  WarnJuror = TvcmUserType(Fake + 1);
   { Юридическое предупреждение }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_WarnJuror = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы WarnJuror }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_WarnJuror
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_WarnJuror

class function Tkw_FormUserType_WarnJuror.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::WarnJuror';
end;//Tkw_FormUserType_WarnJuror.GetWordNameForRegister

function Tkw_FormUserType_WarnJuror.GetInteger: Integer;
 {-}
begin
 Result := WarnJuror;
end;//Tkw_FormUserType_WarnJuror.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_WarnJuror
 Tkw_FormUserType_WarnJuror.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.