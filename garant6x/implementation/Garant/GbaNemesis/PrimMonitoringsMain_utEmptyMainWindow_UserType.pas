unit PrimMonitoringsMain_utEmptyMainWindow_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/PrimMonitoringsMain_utEmptyMainWindow_UserType.pas"
// Начат: 10.09.2009 19:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Утилита Прайм::Monitoring::Monitorings::PrimMonitoringsMain::utEmptyMainWindow
//
// Главное окно
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Monitorings) AND not defined(Admin)}
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
   { Константы для типа формы utEmptyMainWindow }
  utEmptyMainWindowName = 'utEmptyMainWindow';
   { Строковый идентификатор пользовательского типа "Главное окно" }
  utEmptyMainWindow = TvcmUserType(0);
   { Главное окно }
{$IfEnd} //Monitorings AND not Admin

implementation

{$If defined(Monitorings) AND not defined(Admin)}
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utEmptyMainWindow = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utEmptyMainWindow }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utEmptyMainWindow
{$IfEnd} //Monitorings AND not Admin AND not NoScripts

{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utEmptyMainWindow

class function Tkw_FormUserType_utEmptyMainWindow.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utEmptyMainWindow';
end;//Tkw_FormUserType_utEmptyMainWindow.GetWordNameForRegister

function Tkw_FormUserType_utEmptyMainWindow.GetInteger: Integer;
 {-}
begin
 Result := utEmptyMainWindow;
end;//Tkw_FormUserType_utEmptyMainWindow.GetInteger

{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$IfEnd} //Monitorings AND not Admin

initialization
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utEmptyMainWindow
 Tkw_FormUserType_utEmptyMainWindow.RegisterInEngine;
{$IfEnd} //Monitorings AND not Admin AND not NoScripts

end.