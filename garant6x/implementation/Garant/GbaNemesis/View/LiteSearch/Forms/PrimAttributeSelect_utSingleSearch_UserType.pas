unit PrimAttributeSelect_utSingleSearch_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimAttributeSelect_utSingleSearch_UserType.pas"
// Начат: 27.01.2009 15:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Базовые определения предметной области::SearchLite::View::LiteSearch::PrimAttributeSelect::utSingleSearch
//
// Атомарный поиск
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  PrimAttributeSelect_utAttributeSelect_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы utSingleSearch }
  utSingleSearchName = 'utSingleSearch';
   { Строковый идентификатор пользовательского типа "Атомарный поиск" }
  utSingleSearch = TvcmUserType(utAttributeSelect + 1);
   { Атомарный поиск }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_utSingleSearch = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utSingleSearch }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utSingleSearch
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_utSingleSearch

class function Tkw_FormUserType_utSingleSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utSingleSearch';
end;//Tkw_FormUserType_utSingleSearch.GetWordNameForRegister

function Tkw_FormUserType_utSingleSearch.GetInteger: Integer;
 {-}
begin
 Result := utSingleSearch;
end;//Tkw_FormUserType_utSingleSearch.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utSingleSearch
 Tkw_FormUserType_utSingleSearch.RegisterInEngine;
{$IfEnd} //not NoScripts

end.