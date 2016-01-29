unit PrimQueryCard_utqcInpharmSearch_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimQueryCard_utqcInpharmSearch_UserType.pas"
// Начат: 27.01.2009 10:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimQueryCard::utqcInpharmSearch
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
  PrimQueryCard_utqcSendConsultation_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы utqcInpharmSearch }
  utqcInpharmSearchName = 'utqcInpharmSearch';
   { Строковый идентификатор пользовательского типа "Поиск лекарственных средств" }
  utqcInpharmSearch = TvcmUserType(utqcSendConsultation + 1);
   { Поиск лекарственных средств }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utqcInpharmSearch = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utqcInpharmSearch }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utqcInpharmSearch
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utqcInpharmSearch

class function Tkw_FormUserType_utqcInpharmSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utqcInpharmSearch';
end;//Tkw_FormUserType_utqcInpharmSearch.GetWordNameForRegister

function Tkw_FormUserType_utqcInpharmSearch.GetInteger: Integer;
 {-}
begin
 Result := utqcInpharmSearch;
end;//Tkw_FormUserType_utqcInpharmSearch.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utqcInpharmSearch
 Tkw_FormUserType_utqcInpharmSearch.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.