unit PrimSaveLoadUserTypes_slqtOldKW_UserType;
 {* Поиск: По ситуации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtOldKW_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtKW_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы slqtOldKW }
 slqtOldKWName = 'slqtOldKW';
  {* Строковый идентификатор пользовательского типа "Поиск: По ситуации" }
 slqtOldKW = TvcmUserType(slqtKW + 1);
  {* Поиск: По ситуации }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtOldKW = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtOldKW }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtOldKW
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtOldKW.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtOldKW';
end;//Tkw_FormUserType_slqtOldKW.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtOldKW.GetInteger: Integer;
begin
 Result := slqtOldKW;
end;//Tkw_FormUserType_slqtOldKW.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtOldKW.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtOldKW }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
