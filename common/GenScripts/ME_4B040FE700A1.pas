unit DocumentUserTypes_dftTips_UserType;
 {* Совет дня }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftTips_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftTips" MUID: (4B040FE700A1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAnnotationSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_dftTips = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftTips }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftTips
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftTips.GetInteger: Integer;
begin
 Result := dftTips;
end;//Tkw_FormUserType_dftTips.GetInteger

class function Tkw_FormUserType_dftTips.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftTips';
end;//Tkw_FormUserType_dftTips.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftTips.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftTips }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
