unit DocumentUserTypes_dftMedicFirmSynchroView_UserType;
 {* Описание фирмы (синхронный просмотр) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftMedicFirmSynchroView_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftMedicFirm_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы dftMedicFirmSynchroView }
 dftMedicFirmSynchroViewName = 'dftMedicFirmSynchroView';
  {* Строковый идентификатор пользовательского типа "Описание фирмы (синхронный просмотр)" }
 dftMedicFirmSynchroView = TvcmUserType(dftMedicFirm + 1);
  {* Описание фирмы (синхронный просмотр) }
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
 Tkw_FormUserType_dftMedicFirmSynchroView = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftMedicFirmSynchroView }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftMedicFirmSynchroView
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftMedicFirmSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftMedicFirmSynchroView';
end;//Tkw_FormUserType_dftMedicFirmSynchroView.GetWordNameForRegister

function Tkw_FormUserType_dftMedicFirmSynchroView.GetInteger: Integer;
begin
 Result := dftMedicFirmSynchroView;
end;//Tkw_FormUserType_dftMedicFirmSynchroView.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedicFirmSynchroView.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftMedicFirmSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
