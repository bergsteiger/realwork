unit PrimUserProperty_admUseProperties_UserType;
 {* Свойства пользователя }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimUserProperty_admUseProperties_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
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
 {* Константы для типа формы admUseProperties }
 admUsePropertiesName = 'admUseProperties';
  {* Строковый идентификатор пользовательского типа "Свойства пользователя" }
 admUseProperties = TvcmUserType(0);
  {* Свойства пользователя }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admUseProperties = {final} class(TtfwInteger)
  {* Слово словаря для типа формы admUseProperties }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_admUseProperties
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_admUseProperties.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::admUseProperties';
end;//Tkw_FormUserType_admUseProperties.GetWordNameForRegister

function Tkw_FormUserType_admUseProperties.GetInteger: Integer;
begin
 Result := admUseProperties;
end;//Tkw_FormUserType_admUseProperties.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admUseProperties.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_admUseProperties }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
