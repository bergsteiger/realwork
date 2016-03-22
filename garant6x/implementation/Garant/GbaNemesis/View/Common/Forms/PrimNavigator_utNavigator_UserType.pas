unit PrimNavigator_utNavigator_UserType;
 {* Меню }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimNavigator_utNavigator_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utNavigator" MUID: (4BD72ACA02F6)

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
 {* Константы для типа формы utNavigator }
 utNavigatorName = 'utNavigator';
  {* Строковый идентификатор пользовательского типа "Меню" }
 utNavigator = TvcmUserType(0);
  {* Меню }
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
 Tkw_FormUserType_utNavigator = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utNavigator }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utNavigator
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utNavigator.GetInteger: Integer;
begin
 Result := utNavigator;
end;//Tkw_FormUserType_utNavigator.GetInteger

class function Tkw_FormUserType_utNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utNavigator';
end;//Tkw_FormUserType_utNavigator.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utNavigator.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utNavigator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
