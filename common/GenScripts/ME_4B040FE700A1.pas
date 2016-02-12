unit DocumentUserTypes_dftTips_UserType;
 {* Совет дня }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftTips_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAnnotationSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы dftTips }
 dftTipsName = 'dftTips';
  {* Строковый идентификатор пользовательского типа "Совет дня" }
 dftTips = TvcmUserType(dftAnnotationSynchroView + 1);
  {* Совет дня }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftTips = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftTips }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftTips
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftTips.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftTips';
end;//Tkw_FormUserType_dftTips.GetWordNameForRegister

function Tkw_FormUserType_dftTips.GetInteger: Integer;
begin
 Result := dftTips;
end;//Tkw_FormUserType_dftTips.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftTips.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftTips }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
