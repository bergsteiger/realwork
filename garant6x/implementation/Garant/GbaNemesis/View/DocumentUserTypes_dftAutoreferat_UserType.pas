unit DocumentUserTypes_dftAutoreferat_UserType;
 {* ПРАЙМ. Моя новостная лента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAutoreferat_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftAutoreferat" MUID: (4B04102D00B6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftMedDictEntry_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки dftAutoreferatLocalConstants }
 str_dftAutoreferatCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatCaption'; rValue : 'ПРАЙМ. Моя новостная лента');
  {* Заголовок пользовательского типа "ПРАЙМ. Моя новостная лента" }
 str_dftAutoreferatSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatSettingsCaption'; rValue : 'Документ: ПРАЙМ. Моя новостная лента');
  {* Заголовок пользовательского типа "ПРАЙМ. Моя новостная лента" для настройки панелей инструментов }
 {* Константы для типа формы dftAutoreferat }
 dftAutoreferatName = 'dftAutoreferat';
  {* Строковый идентификатор пользовательского типа "ПРАЙМ. Моя новостная лента" }
 dftAutoreferat = TvcmUserType(dftMedDictEntry + 1);
  {* ПРАЙМ. Моя новостная лента }
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
 Tkw_FormUserType_dftAutoreferat = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftAutoreferat }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftAutoreferat
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftAutoreferat.GetInteger: Integer;
begin
 Result := dftAutoreferat;
end;//Tkw_FormUserType_dftAutoreferat.GetInteger

class function Tkw_FormUserType_dftAutoreferat.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftAutoreferat';
end;//Tkw_FormUserType_dftAutoreferat.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftAutoreferatCaption.Init;
 {* Инициализация str_dftAutoreferatCaption }
 str_dftAutoreferatSettingsCaption.Init;
 {* Инициализация str_dftAutoreferatSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAutoreferat.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftAutoreferat }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
