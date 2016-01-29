unit MemoryUsage_ut_MemoryUsage_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MemoryUsage_ut_MemoryUsage_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::Main::MemoryUsage::ut_MemoryUsage
//
// Используемые ресурсы
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
   { Константы для типа формы ut_MemoryUsage }
  ut_MemoryUsageName = 'ut_MemoryUsage';
   { Строковый идентификатор пользовательского типа "Используемые ресурсы" }
  ut_MemoryUsage = TvcmUserType(0);
   { Используемые ресурсы }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_ut_MemoryUsage = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы ut_MemoryUsage }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_ut_MemoryUsage
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_MemoryUsage

class function Tkw_FormUserType_ut_MemoryUsage.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_MemoryUsage';
end;//Tkw_FormUserType_ut_MemoryUsage.GetWordNameForRegister

function Tkw_FormUserType_ut_MemoryUsage.GetInteger: Integer;
 {-}
begin
 Result := ut_MemoryUsage;
end;//Tkw_FormUserType_ut_MemoryUsage.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_ut_MemoryUsage
 Tkw_FormUserType_ut_MemoryUsage.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.