unit PrimLeftEdition_utLeftEdition_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/Forms/PrimLeftEdition_utLeftEdition_UserType.pas"
// Начат: 27.07.2009 11:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Пользовательские сервисы::CompareEditions::View::Editions::PrimLeftEdition::utLeftEdition
//
// Предыдущая редакция
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
   { Константы для типа формы utLeftEdition }
  utLeftEditionName = 'utLeftEdition';
   { Строковый идентификатор пользовательского типа "Предыдущая редакция" }
  utLeftEdition = TvcmUserType(0);
   { Предыдущая редакция }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utLeftEdition = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utLeftEdition }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utLeftEdition
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utLeftEdition

class function Tkw_FormUserType_utLeftEdition.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utLeftEdition';
end;//Tkw_FormUserType_utLeftEdition.GetWordNameForRegister

function Tkw_FormUserType_utLeftEdition.GetInteger: Integer;
 {-}
begin
 Result := utLeftEdition;
end;//Tkw_FormUserType_utLeftEdition.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utLeftEdition
 Tkw_FormUserType_utLeftEdition.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.