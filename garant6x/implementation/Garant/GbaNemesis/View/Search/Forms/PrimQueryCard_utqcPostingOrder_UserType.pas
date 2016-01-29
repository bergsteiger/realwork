unit PrimQueryCard_utqcPostingOrder_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimQueryCard_utqcPostingOrder_UserType.pas"
// Начат: 27.01.2009 10:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimQueryCard::utqcPostingOrder
//
// Создание индивидуальной ленты
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
  PrimQueryCard_utqcAttributeSearch_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы utqcPostingOrder }
  utqcPostingOrderName = 'utqcPostingOrder';
   { Строковый идентификатор пользовательского типа "Создание индивидуальной ленты" }
  utqcPostingOrder = TvcmUserType(utqcAttributeSearch + 1);
   { Создание индивидуальной ленты }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utqcPostingOrder = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utqcPostingOrder }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utqcPostingOrder
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utqcPostingOrder

class function Tkw_FormUserType_utqcPostingOrder.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utqcPostingOrder';
end;//Tkw_FormUserType_utqcPostingOrder.GetWordNameForRegister

function Tkw_FormUserType_utqcPostingOrder.GetInteger: Integer;
 {-}
begin
 Result := utqcPostingOrder;
end;//Tkw_FormUserType_utqcPostingOrder.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utqcPostingOrder
 Tkw_FormUserType_utqcPostingOrder.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.