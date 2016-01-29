unit SelfInfo_ut_SelfInfo_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/SelfInfo_ut_SelfInfo_UserType.pas"
// Начат: 09.09.2009 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::Settings::View::Settings::Settings::SelfInfo::ut_SelfInfo
//
// Регистрационные данные
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
    { Константы для типа формы ut_SelfInfo }
   ut_SelfInfoName = 'ut_SelfInfo';
    { Строковый идентификатор пользовательского типа "Регистрационные данные" }
   ut_SelfInfo = TvcmUserType(0);
    { Регистрационные данные }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_SelfInfo = {final scriptword} class(TtfwInteger)
    {* Слово словаря для типа формы ut_SelfInfo }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_SelfInfo
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_SelfInfo

class function Tkw_FormUserType_ut_SelfInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_SelfInfo';
end;//Tkw_FormUserType_ut_SelfInfo.GetWordNameForRegister

function Tkw_FormUserType_ut_SelfInfo.GetInteger: Integer;
 {-}
begin
 Result := ut_SelfInfo;
end;//Tkw_FormUserType_ut_SelfInfo.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_ut_SelfInfo
 Tkw_FormUserType_ut_SelfInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.