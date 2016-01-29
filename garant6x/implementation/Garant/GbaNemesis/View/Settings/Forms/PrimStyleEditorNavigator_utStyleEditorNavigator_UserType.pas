unit PrimStyleEditorNavigator_utStyleEditorNavigator_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/PrimStyleEditorNavigator_utStyleEditorNavigator_UserType.pas"
// Начат: 28.10.2009 14:01
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::Settings::View::Settings::PrimStyleEditorNavigator::utStyleEditorNavigator
//
// Дерево стилей
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
   { Константы для типа формы utStyleEditorNavigator }
  utStyleEditorNavigatorName = 'utStyleEditorNavigator';
   { Строковый идентификатор пользовательского типа "Дерево стилей" }
  utStyleEditorNavigator = TvcmUserType(0);
   { Дерево стилей }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utStyleEditorNavigator = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utStyleEditorNavigator }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utStyleEditorNavigator
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utStyleEditorNavigator

class function Tkw_FormUserType_utStyleEditorNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utStyleEditorNavigator';
end;//Tkw_FormUserType_utStyleEditorNavigator.GetWordNameForRegister

function Tkw_FormUserType_utStyleEditorNavigator.GetInteger: Integer;
 {-}
begin
 Result := utStyleEditorNavigator;
end;//Tkw_FormUserType_utStyleEditorNavigator.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utStyleEditorNavigator
 Tkw_FormUserType_utStyleEditorNavigator.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.