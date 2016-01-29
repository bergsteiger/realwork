unit ContentsUserTypes_utContents_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ContentsUserTypes_utContents_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ContentsUserTypes::utContents
//
// Структура документа
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
   { Константы для типа формы utContents }
  utContentsName = 'utContents';
   { Строковый идентификатор пользовательского типа "Структура документа" }
  utContents = TvcmUserType(0);
   { Структура документа }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utContents = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utContents }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utContents
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utContents

class function Tkw_FormUserType_utContents.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utContents';
end;//Tkw_FormUserType_utContents.GetWordNameForRegister

function Tkw_FormUserType_utContents.GetInteger: Integer;
 {-}
begin
 Result := utContents;
end;//Tkw_FormUserType_utContents.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utContents
 Tkw_FormUserType_utContents.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.