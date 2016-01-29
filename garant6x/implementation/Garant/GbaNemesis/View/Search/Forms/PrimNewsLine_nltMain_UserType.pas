unit PrimNewsLine_nltMain_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimNewsLine_nltMain_UserType.pas"
// Начат: 27.01.2009 11:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Пользовательские сервисы::Autoreferat::View::Search::PrimNewsLine::nltMain
//
// ПРАЙМ. Моя новостная лента
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
   { Константы для типа формы nltMain }
  nltMainName = 'nltMain';
   { Строковый идентификатор пользовательского типа "ПРАЙМ. Моя новостная лента" }
  nltMain = TvcmUserType(0);
   { ПРАЙМ. Моя новостная лента }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_nltMain = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы nltMain }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_nltMain
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_nltMain

class function Tkw_FormUserType_nltMain.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::nltMain';
end;//Tkw_FormUserType_nltMain.GetWordNameForRegister

function Tkw_FormUserType_nltMain.GetInteger: Integer;
 {-}
begin
 Result := nltMain;
end;//Tkw_FormUserType_nltMain.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_nltMain
 Tkw_FormUserType_nltMain.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.