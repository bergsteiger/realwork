unit PrimNavigator_utNavigator_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/PrimNavigator_utNavigator_UserType.pas"
// Начат: 02.11.2009 16:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Common::View::Common::PrimNavigator::utNavigator
//
// Меню
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
   { Константы для типа формы utNavigator }
  utNavigatorName = 'utNavigator';
   { Строковый идентификатор пользовательского типа "Меню" }
  utNavigator = TvcmUserType(0);
   { Меню }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utNavigator = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utNavigator }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utNavigator
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utNavigator

class function Tkw_FormUserType_utNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utNavigator';
end;//Tkw_FormUserType_utNavigator.GetWordNameForRegister

function Tkw_FormUserType_utNavigator.GetInteger: Integer;
 {-}
begin
 Result := utNavigator;
end;//Tkw_FormUserType_utNavigator.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utNavigator
 Tkw_FormUserType_utNavigator.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.