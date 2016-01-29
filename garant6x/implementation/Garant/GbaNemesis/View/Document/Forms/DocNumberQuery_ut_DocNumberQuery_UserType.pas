unit DocNumberQuery_ut_DocNumberQuery_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/Forms/DocNumberQuery_ut_DocNumberQuery_UserType.pas"
// Начат: 16.09.2009 22:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document::DocNumberQuery::ut_DocNumberQuery
//
// Открыть документ по номеру
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
    { Константы для типа формы ut_DocNumberQuery }
   ut_DocNumberQueryName = 'ut_DocNumberQuery';
    { Строковый идентификатор пользовательского типа "Открыть документ по номеру" }
   ut_DocNumberQuery = TvcmUserType(0);
    { Открыть документ по номеру }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_DocNumberQuery = {final scriptword} class(TtfwInteger)
    {* Слово словаря для типа формы ut_DocNumberQuery }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_DocNumberQuery
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_DocNumberQuery

class function Tkw_FormUserType_ut_DocNumberQuery.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_DocNumberQuery';
end;//Tkw_FormUserType_ut_DocNumberQuery.GetWordNameForRegister

function Tkw_FormUserType_ut_DocNumberQuery.GetInteger: Integer;
 {-}
begin
 Result := ut_DocNumberQuery;
end;//Tkw_FormUserType_ut_DocNumberQuery.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_ut_DocNumberQuery
 Tkw_FormUserType_ut_DocNumberQuery.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.