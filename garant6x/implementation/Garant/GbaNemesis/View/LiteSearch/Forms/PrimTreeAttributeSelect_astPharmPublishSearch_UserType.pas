unit PrimTreeAttributeSelect_astPharmPublishSearch_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimTreeAttributeSelect_astPharmPublishSearch_UserType.pas"
// Начат: 27.01.2009 11:56
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Базовые определения предметной области::SearchLite::View::LiteSearch::PrimTreeAttributeSelect::astPharmPublishSearch
//
// СМИ по медицине и здравоохранению
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
  PrimTreeAttributeSelect_astNone_UserType,
  PrimTreeAttributeSelect_astTaxesPublishSearch_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы astPharmPublishSearch }
  astPharmPublishSearchName = 'astPharmPublishSearch';
   { Строковый идентификатор пользовательского типа "СМИ по медицине и здравоохранению" }
  astPharmPublishSearch = TvcmUserType(astTaxesPublishSearch + 1);
   { СМИ по медицине и здравоохранению }

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_astPharmPublishSearch = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы astPharmPublishSearch }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_astPharmPublishSearch
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_astPharmPublishSearch

class function Tkw_FormUserType_astPharmPublishSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::astPharmPublishSearch';
end;//Tkw_FormUserType_astPharmPublishSearch.GetWordNameForRegister

function Tkw_FormUserType_astPharmPublishSearch.GetInteger: Integer;
 {-}
begin
 Result := astPharmPublishSearch;
end;//Tkw_FormUserType_astPharmPublishSearch.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация Tkw_FormUserType_astPharmPublishSearch
 Tkw_FormUserType_astPharmPublishSearch.RegisterInEngine;
{$IfEnd} //not NoScripts

end.