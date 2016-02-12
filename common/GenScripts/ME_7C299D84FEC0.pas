unit DefineSearchDate_ut_DefineSearchDate_UserType;
 {* Дата }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\DefineSearchDate_ut_DefineSearchDate_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы ut_DefineSearchDate }
 ut_DefineSearchDateName = 'ut_DefineSearchDate';
  {* Строковый идентификатор пользовательского типа "Дата" }
 ut_DefineSearchDate = TvcmUserType(0);
  {* Дата }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_DefineSearchDate = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_DefineSearchDate }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_DefineSearchDate
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_DefineSearchDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_DefineSearchDate';
end;//Tkw_FormUserType_ut_DefineSearchDate.GetWordNameForRegister

function Tkw_FormUserType_ut_DefineSearchDate.GetInteger: Integer;
begin
 Result := ut_DefineSearchDate;
end;//Tkw_FormUserType_ut_DefineSearchDate.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_DefineSearchDate.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_DefineSearchDate }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
