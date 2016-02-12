unit PrimTreeAttributeFirstLevel_flSituation_UserType;
 {* Ситуации первого уровня (вкладка) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimTreeAttributeFirstLevel_flSituation_UserType.pas"
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
 {* Константы для типа формы flSituation }
 flSituationName = 'flSituation';
  {* Строковый идентификатор пользовательского типа "Ситуации первого уровня (вкладка)" }
 flSituation = TvcmUserType(0);
  {* Ситуации первого уровня (вкладка) }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_flSituation = {final} class(TtfwInteger)
  {* Слово словаря для типа формы flSituation }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_flSituation
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_flSituation.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::flSituation';
end;//Tkw_FormUserType_flSituation.GetWordNameForRegister

function Tkw_FormUserType_flSituation.GetInteger: Integer;
begin
 Result := flSituation;
end;//Tkw_FormUserType_flSituation.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_flSituation.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_flSituation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
