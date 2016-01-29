unit ListInfoUserTypes_liListInfo_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListInfoUserTypes_liListInfo_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListInfoUserTypes::liListInfo
//
// Справка к списку
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
   { Константы для типа формы liListInfo }
  liListInfoName = 'liListInfo';
   { Строковый идентификатор пользовательского типа "Справка к списку" }
  liListInfo = TvcmUserType(0);
   { Справка к списку }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_liListInfo = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы liListInfo }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_liListInfo
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_liListInfo

class function Tkw_FormUserType_liListInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::liListInfo';
end;//Tkw_FormUserType_liListInfo.GetWordNameForRegister

function Tkw_FormUserType_liListInfo.GetInteger: Integer;
 {-}
begin
 Result := liListInfo;
end;//Tkw_FormUserType_liListInfo.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_liListInfo
 Tkw_FormUserType_liListInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.