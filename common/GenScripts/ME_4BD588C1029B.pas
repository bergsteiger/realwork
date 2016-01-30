unit ListUserTypes_lftCToPart_UserType;
 {* Ссылки на фрагмент }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftCToPart_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftSynchroView_UserType
 , ListUserTypes_lftRespondent_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы lftCToPart }
 lftCToPartName = 'lftCToPart';
  {* Строковый идентификатор пользовательского типа "Ссылки на фрагмент" }
 lftCToPart = TvcmUserType(lftSynchroView + 1);
  {* Ссылки на фрагмент }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftCToPart = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftCToPart }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftCToPart
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftCToPart.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftCToPart';
end;//Tkw_FormUserType_lftCToPart.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftCToPart.GetInteger: Integer;
begin
 Result := lftCToPart;
end;//Tkw_FormUserType_lftCToPart.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftCToPart.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftCToPart }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
