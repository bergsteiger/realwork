unit PrimSaveLoadUserTypes_slqtKW_UserType;
 {* Поиск: По ситуации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtKW_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtAttribute_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы slqtKW }
 slqtKWName = 'slqtKW';
  {* Строковый идентификатор пользовательского типа "Поиск: По ситуации" }
 slqtKW = TvcmUserType(slqtAttribute + 1);
  {* Поиск: По ситуации }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtKW = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtKW }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtKW
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtKW.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtKW';
end;//Tkw_FormUserType_slqtKW.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtKW.GetInteger: Integer;
begin
 Result := slqtKW;
end;//Tkw_FormUserType_slqtKW.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtKW.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtKW }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
