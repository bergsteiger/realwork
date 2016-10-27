unit PrimProgressIndicator_utProgressIndicator_UserType;
 {* Ход выполнения }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimProgressIndicator_utProgressIndicator_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utProgressIndicator" MUID: (50F667D30021)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки utProgressIndicatorLocalConstants }
 str_utProgressIndicatorCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utProgressIndicatorCaption'; rValue : 'Ход выполнения');
  {* Заголовок пользовательского типа "Ход выполнения" }
 str_utProgressIndicatorSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utProgressIndicatorSettingsCaption'; rValue : 'Ход выполнения');
  {* Заголовок пользовательского типа "Ход выполнения" для настройки панелей инструментов }
 {* Константы для типа формы utProgressIndicator }
 utProgressIndicatorName = 'utProgressIndicator';
  {* Строковый идентификатор пользовательского типа "Ход выполнения" }
 utProgressIndicator = TvcmUserType(0);
  {* Ход выполнения }
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
 Tkw_FormUserType_utProgressIndicator = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utProgressIndicator }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utProgressIndicator
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utProgressIndicator.GetInteger: Integer;
begin
 Result := utProgressIndicator;
end;//Tkw_FormUserType_utProgressIndicator.GetInteger

class function Tkw_FormUserType_utProgressIndicator.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utProgressIndicator';
end;//Tkw_FormUserType_utProgressIndicator.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utProgressIndicatorCaption.Init;
 {* Инициализация str_utProgressIndicatorCaption }
 str_utProgressIndicatorSettingsCaption.Init;
 {* Инициализация str_utProgressIndicatorSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utProgressIndicator.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utProgressIndicator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
