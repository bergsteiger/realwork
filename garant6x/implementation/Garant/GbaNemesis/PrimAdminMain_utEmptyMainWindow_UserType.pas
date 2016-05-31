unit PrimAdminMain_utEmptyMainWindow_UserType;
 {* Главное окно }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\PrimAdminMain_utEmptyMainWindow_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utEmptyMainWindow" MUID: (4BD84DBE0387)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки utEmptyMainWindowLocalConstants }
 str_utEmptyMainWindowCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utEmptyMainWindowCaption'; rValue : 'Главное окно');
  {* Заголовок пользовательского типа "Главное окно" }
 str_utEmptyMainWindowSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utEmptyMainWindowSettingsCaption'; rValue : 'Главная панель инструментов');
  {* Заголовок пользовательского типа "Главное окно" для настройки панелей инструментов }
 {* Константы для типа формы utEmptyMainWindow }
 utEmptyMainWindowName = 'utEmptyMainWindow';
  {* Строковый идентификатор пользовательского типа "Главное окно" }
 utEmptyMainWindow = TvcmUserType(0);
  {* Главное окно }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utEmptyMainWindow = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utEmptyMainWindow }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utEmptyMainWindow
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utEmptyMainWindow.GetInteger: Integer;
begin
 Result := utEmptyMainWindow;
end;//Tkw_FormUserType_utEmptyMainWindow.GetInteger

class function Tkw_FormUserType_utEmptyMainWindow.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utEmptyMainWindow';
end;//Tkw_FormUserType_utEmptyMainWindow.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utEmptyMainWindowCaption.Init;
 {* Инициализация str_utEmptyMainWindowCaption }
 str_utEmptyMainWindowSettingsCaption.Init;
 {* Инициализация str_utEmptyMainWindowSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utEmptyMainWindow.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utEmptyMainWindow }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
