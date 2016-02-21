unit BaseSearchCard_ut_BaseSearchCard_UserType;
 {* Базовый поиск }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\BaseSearchCard_ut_BaseSearchCard_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы ut_BaseSearchCard }
 ut_BaseSearchCardName = 'ut_BaseSearchCard';
  {* Строковый идентификатор пользовательского типа "Базовый поиск" }
 ut_BaseSearchCard = TvcmUserType(0);
  {* Базовый поиск }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_BaseSearchCard = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_BaseSearchCard }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_BaseSearchCard
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_BaseSearchCard.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_BaseSearchCard';
end;//Tkw_FormUserType_ut_BaseSearchCard.GetWordNameForRegister

function Tkw_FormUserType_ut_BaseSearchCard.GetInteger: Integer;
begin
 Result := ut_BaseSearchCard;
end;//Tkw_FormUserType_ut_BaseSearchCard.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_BaseSearchCard.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_BaseSearchCard }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
