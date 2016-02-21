unit MemoryUsage_ut_MemoryUsage_UserType;
 {* Используемые ресурсы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MemoryUsage_ut_MemoryUsage_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_MemoryUsage = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_MemoryUsage }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_MemoryUsage
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_MemoryUsage.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_MemoryUsage';
end;//Tkw_FormUserType_ut_MemoryUsage.GetWordNameForRegister

function Tkw_FormUserType_ut_MemoryUsage.GetInteger: Integer;
begin
 Result := ut_MemoryUsage;
end;//Tkw_FormUserType_ut_MemoryUsage.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_MemoryUsage.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_MemoryUsage }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
