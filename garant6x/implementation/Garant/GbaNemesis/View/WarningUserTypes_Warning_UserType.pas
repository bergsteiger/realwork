unit WarningUserTypes_Warning_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/WarningUserTypes_Warning_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::WarningUserTypes::Warning
//
// Предупреждение
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
   { Константы для типа формы Warning }
  WarningName = 'Warning';
   { Строковый идентификатор пользовательского типа "Предупреждение" }
  Warning = TvcmUserType(0);
   { Предупреждение }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_Warning = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы Warning }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_Warning
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_Warning

class function Tkw_FormUserType_Warning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::Warning';
end;//Tkw_FormUserType_Warning.GetWordNameForRegister

function Tkw_FormUserType_Warning.GetInteger: Integer;
 {-}
begin
 Result := Warning;
end;//Tkw_FormUserType_Warning.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_Warning
 Tkw_FormUserType_Warning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.