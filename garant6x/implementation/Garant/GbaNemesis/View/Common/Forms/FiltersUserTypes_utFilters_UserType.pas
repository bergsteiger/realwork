unit FiltersUserTypes_utFilters_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/FiltersUserTypes_utFilters_UserType.pas"
// Начат: 16.03.2011 18:08
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Common::View::Common::FiltersUserTypes::utFilters
//
// Фильтры
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
   { Константы для типа формы utFilters }
  utFiltersName = 'utFilters';
   { Строковый идентификатор пользовательского типа "Фильтры" }
  utFilters = TvcmUserType(0);
   { Фильтры }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utFilters = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utFilters }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utFilters
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utFilters

class function Tkw_FormUserType_utFilters.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utFilters';
end;//Tkw_FormUserType_utFilters.GetWordNameForRegister

function Tkw_FormUserType_utFilters.GetInteger: Integer;
 {-}
begin
 Result := utFilters;
end;//Tkw_FormUserType_utFilters.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utFilters
 Tkw_FormUserType_utFilters.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.