unit BaseSearchCard_ut_BaseSearchCard_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseSearch/Forms/BaseSearchCard_ut_BaseSearchCard_UserType.pas"
// Начат: 21.09.2009 20:01
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Основные прецеденты::BaseSearch::View::BaseSearch$Module::BaseSearch::BaseSearchCard::ut_BaseSearchCard
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
    { Константы для типа формы ut_BaseSearchCard }
   ut_BaseSearchCardName = 'ut_BaseSearchCard';
    { Строковый идентификатор пользовательского типа "Базовый поиск" }
   ut_BaseSearchCard = TvcmUserType(0);
    { Базовый поиск }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_BaseSearchCard = {final scriptword} class(TtfwInteger)
    {* Слово словаря для типа формы ut_BaseSearchCard }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_BaseSearchCard
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_BaseSearchCard

class function Tkw_FormUserType_ut_BaseSearchCard.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_BaseSearchCard';
end;//Tkw_FormUserType_ut_BaseSearchCard.GetWordNameForRegister

function Tkw_FormUserType_ut_BaseSearchCard.GetInteger: Integer;
 {-}
begin
 Result := ut_BaseSearchCard;
end;//Tkw_FormUserType_ut_BaseSearchCard.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_ut_BaseSearchCard
 Tkw_FormUserType_ut_BaseSearchCard.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.