unit PrimStyleEditorNavigator_utStyleEditorNavigator_UserType;
 {* Дерево стилей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorNavigator_utStyleEditorNavigator_UserType.pas"
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
 {* Константы для типа формы utStyleEditorNavigator }
 utStyleEditorNavigatorName = 'utStyleEditorNavigator';
  {* Строковый идентификатор пользовательского типа "Дерево стилей" }
 utStyleEditorNavigator = TvcmUserType(0);
  {* Дерево стилей }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utStyleEditorNavigator = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utStyleEditorNavigator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utStyleEditorNavigator
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utStyleEditorNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utStyleEditorNavigator';
end;//Tkw_FormUserType_utStyleEditorNavigator.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utStyleEditorNavigator.GetInteger: Integer;
begin
 Result := utStyleEditorNavigator;
end;//Tkw_FormUserType_utStyleEditorNavigator.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utStyleEditorNavigator.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utStyleEditorNavigator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
