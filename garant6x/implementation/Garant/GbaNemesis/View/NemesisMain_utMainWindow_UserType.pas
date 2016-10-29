unit NemesisMain_utMainWindow_UserType;
 {* Главное окно }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\NemesisMain_utMainWindow_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utMainWindow" MUID: (4BD84644014A)

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
 {* Локализуемые строки utMainWindowLocalConstants }
 str_utMainWindowCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMainWindowCaption'; rValue : 'Главное окно');
  {* Заголовок пользовательского типа "Главное окно" }
 str_utMainWindowSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMainWindowSettingsCaption'; rValue : 'Главная панель инструментов');
  {* Заголовок пользовательского типа "Главное окно" для настройки панелей инструментов }
 {* Константы для типа формы utMainWindow }
 utMainWindowName = 'utMainWindow';
  {* Строковый идентификатор пользовательского типа "Главное окно" }
 utMainWindow = TvcmUserType(0);
  {* Главное окно }
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
 Tkw_FormUserType_utMainWindow = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utMainWindow }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utMainWindow
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utMainWindow.GetInteger: Integer;
begin
 Result := utMainWindow;
end;//Tkw_FormUserType_utMainWindow.GetInteger

class function Tkw_FormUserType_utMainWindow.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utMainWindow';
end;//Tkw_FormUserType_utMainWindow.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utMainWindowCaption.Init;
 {* Инициализация str_utMainWindowCaption }
 str_utMainWindowSettingsCaption.Init;
 {* Инициализация str_utMainWindowSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utMainWindow.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utMainWindow }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
