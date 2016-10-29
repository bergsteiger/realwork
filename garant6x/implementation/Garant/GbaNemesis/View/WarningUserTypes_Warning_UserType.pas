unit WarningUserTypes_Warning_UserType;
 {* Предупреждение }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WarningUserTypes_Warning_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "Warning" MUID: (4BD6C31B03BC)

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
 {* Локализуемые строки WarningLocalConstants }
 str_WarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarningCaption'; rValue : 'Предупреждение');
  {* Заголовок пользовательского типа "Предупреждение" }
 str_WarningSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarningSettingsCaption'; rValue : 'Документ: Предупреждение');
  {* Заголовок пользовательского типа "Предупреждение" для настройки панелей инструментов }
 {* Константы для типа формы Warning }
 WarningName = 'Warning';
  {* Строковый идентификатор пользовательского типа "Предупреждение" }
 Warning = TvcmUserType(0);
  {* Предупреждение }
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
 Tkw_FormUserType_Warning = {final} class(TtfwInteger)
  {* Слово словаря для типа формы Warning }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_Warning
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_Warning.GetInteger: Integer;
begin
 Result := Warning;
end;//Tkw_FormUserType_Warning.GetInteger

class function Tkw_FormUserType_Warning.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::Warning';
end;//Tkw_FormUserType_Warning.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_WarningCaption.Init;
 {* Инициализация str_WarningCaption }
 str_WarningSettingsCaption.Init;
 {* Инициализация str_WarningSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_Warning.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_Warning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
