unit PrimSaveLoadUserTypes_slqtInpharmSearch_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadUserTypes_slqtInpharmSearch_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadUserTypes::slqtInpharmSearch
//
// Поиск лекарственных средств
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
  ,
  PrimSaveLoadUserTypes_slqtConsult_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы slqtInpharmSearch }
  slqtInpharmSearchName = 'slqtInpharmSearch';
   { Строковый идентификатор пользовательского типа "Поиск лекарственных средств" }
  slqtInpharmSearch = TvcmUserType(slqtConsult + 1);
   { Поиск лекарственных средств }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtInpharmSearch = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы slqtInpharmSearch }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtInpharmSearch
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtInpharmSearch

class function Tkw_FormUserType_slqtInpharmSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::slqtInpharmSearch';
end;//Tkw_FormUserType_slqtInpharmSearch.GetWordNameForRegister

function Tkw_FormUserType_slqtInpharmSearch.GetInteger: Integer;
 {-}
begin
 Result := slqtInpharmSearch;
end;//Tkw_FormUserType_slqtInpharmSearch.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_slqtInpharmSearch
 Tkw_FormUserType_slqtInpharmSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.