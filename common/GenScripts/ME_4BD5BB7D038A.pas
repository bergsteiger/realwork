unit PrimSaveLoadUserTypes_slqtAttribute_UserType;
 {* Поиск: По реквизитам }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtAttribute_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
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
 {* Константы для типа формы slqtAttribute }
 slqtAttributeName = 'slqtAttribute';
  {* Строковый идентификатор пользовательского типа "Поиск: По реквизитам" }
 slqtAttribute = TvcmUserType(0);
  {* Поиск: По реквизитам }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtAttribute = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtAttribute }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtAttribute
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtAttribute.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtAttribute';
end;//Tkw_FormUserType_slqtAttribute.GetWordNameForRegister

function Tkw_FormUserType_slqtAttribute.GetInteger: Integer;
begin
 Result := slqtAttribute;
end;//Tkw_FormUserType_slqtAttribute.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtAttribute.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtAttribute }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
