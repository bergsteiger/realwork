unit CompInfo_ut_CompInfo_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/CompInfo_ut_CompInfo_UserType.pas"
// Начат: 24.08.2009 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Common::View::Common::PrimF1Common::CompInfo::ut_CompInfo
//
// Информация о комплекте
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
    { Константы для типа формы ut_CompInfo }
   ut_CompInfoName = 'ut_CompInfo';
    { Строковый идентификатор пользовательского типа "Информация о комплекте" }
   ut_CompInfo = TvcmUserType(0);
    { Информация о комплекте }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_CompInfo = {final scriptword} class(TtfwInteger)
    {* Слово словаря для типа формы ut_CompInfo }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_CompInfo
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_CompInfo

class function Tkw_FormUserType_ut_CompInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_CompInfo';
end;//Tkw_FormUserType_ut_CompInfo.GetWordNameForRegister

function Tkw_FormUserType_ut_CompInfo.GetInteger: Integer;
 {-}
begin
 Result := ut_CompInfo;
end;//Tkw_FormUserType_ut_CompInfo.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_ut_CompInfo
 Tkw_FormUserType_ut_CompInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.