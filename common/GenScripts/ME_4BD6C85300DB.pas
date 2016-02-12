unit PrimMedicListSynchroView_mlsfMedicFirm_UserType;
 {* Описание }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicListSynchroView_mlsfMedicFirm_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMedicListSynchroView_mlsfDrugList_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы mlsfMedicFirm }
 mlsfMedicFirmName = 'mlsfMedicFirm';
  {* Строковый идентификатор пользовательского типа "Описание" }
 mlsfMedicFirm = TvcmUserType(mlsfDrugList + 1);
  {* Описание }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_mlsfMedicFirm = {final} class(TtfwInteger)
  {* Слово словаря для типа формы mlsfMedicFirm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_mlsfMedicFirm
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_mlsfMedicFirm.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::mlsfMedicFirm';
end;//Tkw_FormUserType_mlsfMedicFirm.GetWordNameForRegister

function Tkw_FormUserType_mlsfMedicFirm.GetInteger: Integer;
begin
 Result := mlsfMedicFirm;
end;//Tkw_FormUserType_mlsfMedicFirm.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_mlsfMedicFirm.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_mlsfMedicFirm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
