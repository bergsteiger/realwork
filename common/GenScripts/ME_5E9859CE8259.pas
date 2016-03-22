unit ForbidAutoregistration_ut_ForbidAutoregistration_UserType;
 {* Запретить авторегистрацию }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\ForbidAutoregistration_ut_ForbidAutoregistration_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_ForbidAutoregistration" MUID: (5E9859CE8259)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы ut_ForbidAutoregistration }
 ut_ForbidAutoregistrationName = 'ut_ForbidAutoregistration';
  {* Строковый идентификатор пользовательского типа "Запретить авторегистрацию" }
 ut_ForbidAutoregistration = TvcmUserType(0);
  {* Запретить авторегистрацию }
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
 Tkw_FormUserType_ut_ForbidAutoregistration = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_ForbidAutoregistration }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_ForbidAutoregistration
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_ForbidAutoregistration.GetInteger: Integer;
begin
 Result := ut_ForbidAutoregistration;
end;//Tkw_FormUserType_ut_ForbidAutoregistration.GetInteger

class function Tkw_FormUserType_ut_ForbidAutoregistration.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_ForbidAutoregistration';
end;//Tkw_FormUserType_ut_ForbidAutoregistration.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_ForbidAutoregistration.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_ForbidAutoregistration }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
