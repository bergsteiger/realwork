unit ContentsUserTypes_utDrugContents_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ContentsUserTypes_utDrugContents_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ContentsUserTypes::utDrugContents
//
// Структура препарата
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
  ,
  ContentsUserTypes_utContents_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы utDrugContents }
  utDrugContentsName = 'utDrugContents';
   { Строковый идентификатор пользовательского типа "Структура препарата" }
  utDrugContents = TvcmUserType(utContents + 1);
   { Структура препарата }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utDrugContents = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utDrugContents }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utDrugContents
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utDrugContents

class function Tkw_FormUserType_utDrugContents.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utDrugContents';
end;//Tkw_FormUserType_utDrugContents.GetWordNameForRegister

function Tkw_FormUserType_utDrugContents.GetInteger: Integer;
 {-}
begin
 Result := utDrugContents;
end;//Tkw_FormUserType_utDrugContents.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utDrugContents
 Tkw_FormUserType_utDrugContents.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.