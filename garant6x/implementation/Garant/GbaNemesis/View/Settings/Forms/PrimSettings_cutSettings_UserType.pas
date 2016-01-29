unit PrimSettings_cutSettings_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/PrimSettings_cutSettings_UserType.pas"
// Начат: 02.10.2009 21:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::Settings::View::Settings::PrimSettings::cutSettings
//
// Настройка конфигурации
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
   { Константы для типа формы cutSettings }
  cutSettingsName = 'cutSettings';
   { Строковый идентификатор пользовательского типа "Настройка конфигурации" }
  cutSettings = TvcmUserType(0);
   { Настройка конфигурации }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_cutSettings = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы cutSettings }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_cutSettings
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_cutSettings

class function Tkw_FormUserType_cutSettings.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::cutSettings';
end;//Tkw_FormUserType_cutSettings.GetWordNameForRegister

function Tkw_FormUserType_cutSettings.GetInteger: Integer;
 {-}
begin
 Result := cutSettings;
end;//Tkw_FormUserType_cutSettings.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_cutSettings
 Tkw_FormUserType_cutSettings.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.