unit BaseSearchCard_ut_BaseSearchCard_UserType;
 {* Базовый поиск }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\BaseSearchCard_ut_BaseSearchCard_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_BaseSearchCard" MUID: (9CF9D22D891B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки ut_BaseSearchCardLocalConstants }
 str_ut_BaseSearchCardCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_BaseSearchCardCaption'; rValue : 'Базовый поиск');
  {* Заголовок пользовательского типа "Базовый поиск" }
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_BaseSearchCard = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_BaseSearchCard }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_BaseSearchCard
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_BaseSearchCard.GetInteger: Integer;
begin
 Result := ut_BaseSearchCard;
end;//Tkw_FormUserType_ut_BaseSearchCard.GetInteger

class function Tkw_FormUserType_ut_BaseSearchCard.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_BaseSearchCard';
end;//Tkw_FormUserType_ut_BaseSearchCard.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_BaseSearchCardCaption.Init;
 {* Инициализация str_ut_BaseSearchCardCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_BaseSearchCard.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_BaseSearchCard }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
