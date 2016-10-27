unit MemoryUsage_ut_MemoryUsage_UserType;
 {* Используемые ресурсы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MemoryUsage_ut_MemoryUsage_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_MemoryUsage" MUID: (06C06D8D5AC2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки ut_MemoryUsageLocalConstants }
 str_ut_MemoryUsageCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_MemoryUsageCaption'; rValue : 'Используемые ресурсы');
  {* Заголовок пользовательского типа "Используемые ресурсы" }
 {* Константы для типа формы ut_MemoryUsage }
 ut_MemoryUsageName = 'ut_MemoryUsage';
  {* Строковый идентификатор пользовательского типа "Используемые ресурсы" }
 ut_MemoryUsage = TvcmUserType(0);
  {* Используемые ресурсы }
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
 Tkw_FormUserType_ut_MemoryUsage = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_MemoryUsage }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_MemoryUsage
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_MemoryUsage.GetInteger: Integer;
begin
 Result := ut_MemoryUsage;
end;//Tkw_FormUserType_ut_MemoryUsage.GetInteger

class function Tkw_FormUserType_ut_MemoryUsage.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_MemoryUsage';
end;//Tkw_FormUserType_ut_MemoryUsage.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_MemoryUsageCaption.Init;
 {* Инициализация str_ut_MemoryUsageCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_MemoryUsage.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_MemoryUsage }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
