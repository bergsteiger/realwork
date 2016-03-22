unit PrimQueryCard_utqcPostingOrder_UserType;
 {* Создание индивидуальной ленты }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcPostingOrder_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utqcPostingOrder" MUID: (4BD5C3510339)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCard_utqcAttributeSearch_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы utqcPostingOrder }
 utqcPostingOrderName = 'utqcPostingOrder';
  {* Строковый идентификатор пользовательского типа "Создание индивидуальной ленты" }
 utqcPostingOrder = TvcmUserType(utqcAttributeSearch + 1);
  {* Создание индивидуальной ленты }
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
 Tkw_FormUserType_utqcPostingOrder = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utqcPostingOrder }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utqcPostingOrder
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utqcPostingOrder.GetInteger: Integer;
begin
 Result := utqcPostingOrder;
end;//Tkw_FormUserType_utqcPostingOrder.GetInteger

class function Tkw_FormUserType_utqcPostingOrder.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utqcPostingOrder';
end;//Tkw_FormUserType_utqcPostingOrder.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcPostingOrder.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utqcPostingOrder }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
