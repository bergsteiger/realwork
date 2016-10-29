unit PrimNewsLine_nltMain_UserType;
 {* ПРАЙМ. Моя новостная лента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimNewsLine_nltMain_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "nltMain" MUID: (4BD71E1103CD)

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
 {* Локализуемые строки nltMainLocalConstants }
 str_nltMainCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nltMainCaption'; rValue : 'ПРАЙМ. Моя новостная лента');
  {* Заголовок пользовательского типа "ПРАЙМ. Моя новостная лента" }
 str_nltMainSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nltMainSettingsCaption'; rValue : 'ПРАЙМ. Моя новостная лента (вкладка)');
  {* Заголовок пользовательского типа "ПРАЙМ. Моя новостная лента" для настройки панелей инструментов }
 {* Константы для типа формы nltMain }
 nltMainName = 'nltMain';
  {* Строковый идентификатор пользовательского типа "ПРАЙМ. Моя новостная лента" }
 nltMain = TvcmUserType(0);
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
 Tkw_FormUserType_nltMain = {final} class(TtfwInteger)
  {* Слово словаря для типа формы nltMain }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_nltMain
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_nltMain.GetInteger: Integer;
begin
 Result := nltMain;
end;//Tkw_FormUserType_nltMain.GetInteger

class function Tkw_FormUserType_nltMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::nltMain';
end;//Tkw_FormUserType_nltMain.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_nltMainCaption.Init;
 {* Инициализация str_nltMainCaption }
 str_nltMainSettingsCaption.Init;
 {* Инициализация str_nltMainSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_nltMain.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_nltMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
