unit ListUserTypes_lftSynchroView_UserType;
 {* Синхронный просмотр (ссылки из документа, ссылки на документ) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftSynchroView_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftCorrespondent_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы lftSynchroView }
 lftSynchroViewName = 'lftSynchroView';
  {* Строковый идентификатор пользовательского типа "Синхронный просмотр (ссылки из документа, ссылки на документ)" }
 lftSynchroView = TvcmUserType(lftCorrespondent + 1);
  {* Синхронный просмотр (ссылки из документа, ссылки на документ) }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftSynchroView = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftSynchroView }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftSynchroView
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftSynchroView';
end;//Tkw_FormUserType_lftSynchroView.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftSynchroView.GetInteger: Integer;
begin
 Result := lftSynchroView;
end;//Tkw_FormUserType_lftSynchroView.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftSynchroView.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
