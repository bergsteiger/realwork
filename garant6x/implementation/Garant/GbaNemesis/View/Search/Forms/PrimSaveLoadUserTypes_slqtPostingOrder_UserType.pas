unit PrimSaveLoadUserTypes_slqtPostingOrder_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadUserTypes_slqtPostingOrder_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadUserTypes::slqtPostingOrder
//
// Настройка индивидуальной ленты новостей
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
  PrimSaveLoadUserTypes_slqtLegislationReview_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы slqtPostingOrder }
  slqtPostingOrderName = 'slqtPostingOrder';
   { Строковый идентификатор пользовательского типа "Настройка индивидуальной ленты новостей" }
  slqtPostingOrder = TvcmUserType(slqtLegislationReview + 1);
   { Настройка индивидуальной ленты новостей }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtPostingOrder = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы slqtPostingOrder }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtPostingOrder
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtPostingOrder

class function Tkw_FormUserType_slqtPostingOrder.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::slqtPostingOrder';
end;//Tkw_FormUserType_slqtPostingOrder.GetWordNameForRegister

function Tkw_FormUserType_slqtPostingOrder.GetInteger: Integer;
 {-}
begin
 Result := slqtPostingOrder;
end;//Tkw_FormUserType_slqtPostingOrder.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_slqtPostingOrder
 Tkw_FormUserType_slqtPostingOrder.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.