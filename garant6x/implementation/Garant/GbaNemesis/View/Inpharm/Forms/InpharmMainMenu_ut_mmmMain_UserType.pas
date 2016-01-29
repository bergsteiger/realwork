unit InpharmMainMenu_ut_mmmMain_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/Forms/InpharmMainMenu_ut_mmmMain_UserType.pas"
// Начат: 29.12.2008 18:10
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Встроенные продукты::Inpharm::View::Inpharm::InpharmMainMenu::ut_mmmMain
//
// ГАРАНТ-ИнФарм
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
   { Константы для типа формы ut_mmmMain }
  ut_mmmMainName = 'ut_mmmMain';
   { Строковый идентификатор пользовательского типа "ГАРАНТ-ИнФарм" }
  ut_mmmMain = TvcmUserType(0);
   { ГАРАНТ-ИнФарм }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_ut_mmmMain = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы ut_mmmMain }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_ut_mmmMain
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_mmmMain

class function Tkw_FormUserType_ut_mmmMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_mmmMain';
end;//Tkw_FormUserType_ut_mmmMain.GetWordNameForRegister

function Tkw_FormUserType_ut_mmmMain.GetInteger: Integer;
 {-}
begin
 Result := ut_mmmMain;
end;//Tkw_FormUserType_ut_mmmMain.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_ut_mmmMain
 Tkw_FormUserType_ut_mmmMain.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.