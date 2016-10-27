unit PrimSaveLoadUserTypes_slqtPostingOrder_UserType;
 {* Настройка индивидуальной ленты новостей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtPostingOrder_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "slqtPostingOrder" MUID: (4BD5BC59017D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtLegislationReview_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки slqtPostingOrderLocalConstants }
 str_slqtPostingOrderCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtPostingOrderCaption'; rValue : 'Настройка индивидуальной ленты новостей');
  {* Заголовок пользовательского типа "Настройка индивидуальной ленты новостей" }
 {* Константы для типа формы slqtPostingOrder }
 slqtPostingOrderName = 'slqtPostingOrder';
  {* Строковый идентификатор пользовательского типа "Настройка индивидуальной ленты новостей" }
 slqtPostingOrder = TvcmUserType(slqtLegislationReview + 1);
  {* Настройка индивидуальной ленты новостей }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_slqtPostingOrder = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtPostingOrder }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtPostingOrder
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtPostingOrder.GetInteger: Integer;
begin
 Result := slqtPostingOrder;
end;//Tkw_FormUserType_slqtPostingOrder.GetInteger

class function Tkw_FormUserType_slqtPostingOrder.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtPostingOrder';
end;//Tkw_FormUserType_slqtPostingOrder.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtPostingOrderCaption.Init;
 {* Инициализация str_slqtPostingOrderCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtPostingOrder.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtPostingOrder }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
