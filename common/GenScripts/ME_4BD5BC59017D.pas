unit PrimSaveLoadUserTypes_slqtPostingOrder_UserType;
 {* Настройка индивидуальной ленты новостей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtPostingOrder_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtLegislationReview_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
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
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtPostingOrder = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtPostingOrder }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtPostingOrder
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtPostingOrder.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtPostingOrder';
end;//Tkw_FormUserType_slqtPostingOrder.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtPostingOrder.GetInteger: Integer;
begin
 Result := slqtPostingOrder;
end;//Tkw_FormUserType_slqtPostingOrder.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtPostingOrder.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtPostingOrder }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
