unit PrimOldSituationSearch_cutOldKeyWord_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimOldSituationSearch_cutOldKeyWord_UserType.pas"
// Начат: 28.10.2009 20:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::Search::View::Search::PrimOldSituationSearch::cutOldKeyWord
//
// Поиск по ситуации
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
   { Константы для типа формы cutOldKeyWord }
  cutOldKeyWordName = 'cutOldKeyWord';
   { Строковый идентификатор пользовательского типа "Поиск по ситуации" }
  cutOldKeyWord = TvcmUserType(0);
   { Поиск по ситуации }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_cutOldKeyWord = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы cutOldKeyWord }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_cutOldKeyWord
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_cutOldKeyWord

class function Tkw_FormUserType_cutOldKeyWord.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::cutOldKeyWord';
end;//Tkw_FormUserType_cutOldKeyWord.GetWordNameForRegister

function Tkw_FormUserType_cutOldKeyWord.GetInteger: Integer;
 {-}
begin
 Result := cutOldKeyWord;
end;//Tkw_FormUserType_cutOldKeyWord.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_cutOldKeyWord
 Tkw_FormUserType_cutOldKeyWord.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.