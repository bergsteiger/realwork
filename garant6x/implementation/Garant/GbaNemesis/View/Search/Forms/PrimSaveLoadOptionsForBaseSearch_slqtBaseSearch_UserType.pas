unit PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadOptionsForBaseSearch_slqtBaseSearch_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadOptionsForBaseSearch::slqtBaseSearch
//
// Базовый поиск
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
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
   { Константы для типа формы slqtBaseSearch }
  slqtBaseSearchName = 'slqtBaseSearch';
   { Строковый идентификатор пользовательского типа "Базовый поиск" }
  slqtBaseSearch = TvcmUserType(0);
   { Базовый поиск }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtBaseSearch = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы slqtBaseSearch }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtBaseSearch
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtBaseSearch

class function Tkw_FormUserType_slqtBaseSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::slqtBaseSearch';
end;//Tkw_FormUserType_slqtBaseSearch.GetWordNameForRegister

function Tkw_FormUserType_slqtBaseSearch.GetInteger: Integer;
 {-}
begin
 Result := slqtBaseSearch;
end;//Tkw_FormUserType_slqtBaseSearch.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_slqtBaseSearch
 Tkw_FormUserType_slqtBaseSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.