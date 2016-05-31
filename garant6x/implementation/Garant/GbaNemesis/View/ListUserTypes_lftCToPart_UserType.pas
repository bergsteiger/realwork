unit ListUserTypes_lftCToPart_UserType;
 {* Ссылки на фрагмент }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftCToPart_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "lftCToPart" MUID: (4BD588C1029B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки lftCToPartLocalConstants }
 str_lftCToPartCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCToPartCaption'; rValue : 'Ссылки на фрагмент');
  {* Заголовок пользовательского типа "Ссылки на фрагмент" }
 str_lftCToPartSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCToPartSettingsCaption'; rValue : 'Список: Ссылки на фрагмент');
  {* Заголовок пользовательского типа "Ссылки на фрагмент" для настройки панелей инструментов }
 {* Константы для типа формы lftCToPart }
 lftCToPartName = 'lftCToPart';
  {* Строковый идентификатор пользовательского типа "Ссылки на фрагмент" }
 lftCToPart = TvcmUserType(lftSynchroView + 1);
  {* Ссылки на фрагмент }
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
 Tkw_FormUserType_lftCToPart = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftCToPart }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftCToPart
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftCToPart.GetInteger: Integer;
begin
 Result := lftCToPart;
end;//Tkw_FormUserType_lftCToPart.GetInteger

class function Tkw_FormUserType_lftCToPart.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftCToPart';
end;//Tkw_FormUserType_lftCToPart.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftCToPartCaption.Init;
 {* Инициализация str_lftCToPartCaption }
 str_lftCToPartSettingsCaption.Init;
 {* Инициализация str_lftCToPartSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftCToPart.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftCToPart }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
