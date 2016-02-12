unit SynchroViewUserTypes_svSynchroView_UserType;
 {* Синхронный просмотр }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\SynchroViewUserTypes_svSynchroView_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 {* Константы для типа формы svSynchroView }
 svSynchroViewName = 'svSynchroView';
  {* Строковый идентификатор пользовательского типа "Синхронный просмотр" }
 svSynchroView = TvcmUserType(0);
  {* Синхронный просмотр }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_svSynchroView = {final} class(TtfwInteger)
  {* Слово словаря для типа формы svSynchroView }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_svSynchroView
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_svSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::svSynchroView';
end;//Tkw_FormUserType_svSynchroView.GetWordNameForRegister

function Tkw_FormUserType_svSynchroView.GetInteger: Integer;
begin
 Result := svSynchroView;
end;//Tkw_FormUserType_svSynchroView.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_svSynchroView.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_svSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
