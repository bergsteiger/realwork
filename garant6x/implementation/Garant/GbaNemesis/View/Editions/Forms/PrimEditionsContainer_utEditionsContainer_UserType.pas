unit PrimEditionsContainer_utEditionsContainer_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/Forms/PrimEditionsContainer_utEditionsContainer_UserType.pas"
// Начат: 28.07.2009 13:12
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Пользовательские сервисы::CompareEditions::View::Editions::PrimEditionsContainer::utEditionsContainer
//
// Сравнение редакций документа
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
   { Константы для типа формы utEditionsContainer }
  utEditionsContainerName = 'utEditionsContainer';
   { Строковый идентификатор пользовательского типа "Сравнение редакций документа" }
  utEditionsContainer = TvcmUserType(0);
   { Сравнение редакций документа }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utEditionsContainer = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utEditionsContainer }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utEditionsContainer
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utEditionsContainer

class function Tkw_FormUserType_utEditionsContainer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utEditionsContainer';
end;//Tkw_FormUserType_utEditionsContainer.GetWordNameForRegister

function Tkw_FormUserType_utEditionsContainer.GetInteger: Integer;
 {-}
begin
 Result := utEditionsContainer;
end;//Tkw_FormUserType_utEditionsContainer.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utEditionsContainer
 Tkw_FormUserType_utEditionsContainer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.