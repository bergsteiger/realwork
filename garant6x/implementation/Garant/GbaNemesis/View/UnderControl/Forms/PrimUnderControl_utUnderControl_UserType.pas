unit PrimUnderControl_utUnderControl_UserType;
 {* Документы на контроле }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\Forms\PrimUnderControl_utUnderControl_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utUnderControl" MUID: (4BD7296F02E0)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки utUnderControlLocalConstants }
 str_utUnderControlCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utUnderControlCaption'; rValue : 'Документы на контроле');
  {* Заголовок пользовательского типа "Документы на контроле" }
 str_utUnderControlSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utUnderControlSettingsCaption'; rValue : 'Документы на контроле (вкладка)');
  {* Заголовок пользовательского типа "Документы на контроле" для настройки панелей инструментов }
 {* Константы для типа формы utUnderControl }
 utUnderControlName = 'utUnderControl';
  {* Строковый идентификатор пользовательского типа "Документы на контроле" }
 utUnderControl = TvcmUserType(0);
  {* Документы на контроле }
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
 Tkw_FormUserType_utUnderControl = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utUnderControl }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utUnderControl
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utUnderControl.GetInteger: Integer;
begin
 Result := utUnderControl;
end;//Tkw_FormUserType_utUnderControl.GetInteger

class function Tkw_FormUserType_utUnderControl.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utUnderControl';
end;//Tkw_FormUserType_utUnderControl.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utUnderControlCaption.Init;
 {* Инициализация str_utUnderControlCaption }
 str_utUnderControlSettingsCaption.Init;
 {* Инициализация str_utUnderControlSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utUnderControl.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utUnderControl }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
