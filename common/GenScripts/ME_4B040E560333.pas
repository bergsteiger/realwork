unit DocumentUserTypes_dftRelatedSynchroView_UserType;
 {* Справка к документу (синхронный просмотр) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftRelatedSynchroView_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDocSynchroView_UserType
 , DocumentUserTypes_dftAnnotationSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы dftRelatedSynchroView }
 dftRelatedSynchroViewName = 'dftRelatedSynchroView';
  {* Строковый идентификатор пользовательского типа "Справка к документу (синхронный просмотр)" }
 dftRelatedSynchroView = TvcmUserType(dftDocSynchroView + 1);
  {* Справка к документу (синхронный просмотр) }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftRelatedSynchroView = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftRelatedSynchroView }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftRelatedSynchroView
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftRelatedSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftRelatedSynchroView';
end;//Tkw_FormUserType_dftRelatedSynchroView.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftRelatedSynchroView.GetInteger: Integer;
begin
 Result := dftRelatedSynchroView;
end;//Tkw_FormUserType_dftRelatedSynchroView.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftRelatedSynchroView.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftRelatedSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
