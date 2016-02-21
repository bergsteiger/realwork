unit PrimCommonDiction_utTips_UserType;
 {* Совет дня }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimCommonDiction_utTips_UserType.pas"
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
 {* Константы для типа формы utTips }
 utTipsName = 'utTips';
  {* Строковый идентификатор пользовательского типа "Совет дня" }
 utTips = TvcmUserType(0);
  {* Совет дня }
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
 Tkw_FormUserType_utTips = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utTips }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utTips
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utTips.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utTips';
end;//Tkw_FormUserType_utTips.GetWordNameForRegister

function Tkw_FormUserType_utTips.GetInteger: Integer;
begin
 Result := utTips;
end;//Tkw_FormUserType_utTips.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utTips.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utTips }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
