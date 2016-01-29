unit PrimConfigurationList_utConfigurationList_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/PrimConfigurationList_utConfigurationList_UserType.pas"
// Начат: 27.04.2010 22:06
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::Settings::View::Settings::PrimConfigurationList::utConfigurationList
//
// Конфигурации
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
   { Константы для типа формы utConfigurationList }
  utConfigurationListName = 'utConfigurationList';
   { Строковый идентификатор пользовательского типа "Конфигурации" }
  utConfigurationList = TvcmUserType(0);
   { Конфигурации }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utConfigurationList = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utConfigurationList }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utConfigurationList
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utConfigurationList

class function Tkw_FormUserType_utConfigurationList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utConfigurationList';
end;//Tkw_FormUserType_utConfigurationList.GetWordNameForRegister

function Tkw_FormUserType_utConfigurationList.GetInteger: Integer;
 {-}
begin
 Result := utConfigurationList;
end;//Tkw_FormUserType_utConfigurationList.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utConfigurationList
 Tkw_FormUserType_utConfigurationList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.