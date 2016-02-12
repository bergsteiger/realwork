unit DocumentUserTypes_dftDrugSynchroView_UserType;
 {* Описание препарата (синхронный просмотр) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDrugSynchroView_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftMedicFirmSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы dftDrugSynchroView }
 dftDrugSynchroViewName = 'dftDrugSynchroView';
  {* Строковый идентификатор пользовательского типа "Описание препарата (синхронный просмотр)" }
 dftDrugSynchroView = TvcmUserType(dftMedicFirmSynchroView + 1);
  {* Описание препарата (синхронный просмотр) }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftDrugSynchroView = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftDrugSynchroView }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftDrugSynchroView
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftDrugSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftDrugSynchroView';
end;//Tkw_FormUserType_dftDrugSynchroView.GetWordNameForRegister

function Tkw_FormUserType_dftDrugSynchroView.GetInteger: Integer;
begin
 Result := dftDrugSynchroView;
end;//Tkw_FormUserType_dftDrugSynchroView.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftDrugSynchroView.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftDrugSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
