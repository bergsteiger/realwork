unit DocumentUserTypes_dftMedicFirm_UserType;
 {* Описание фирмы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftMedicFirm_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDrug_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы dftMedicFirm }
 dftMedicFirmName = 'dftMedicFirm';
  {* Строковый идентификатор пользовательского типа "Описание фирмы" }
 dftMedicFirm = TvcmUserType(dftDrug + 1);
  {* Описание фирмы }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedicFirm = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftMedicFirm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftMedicFirm
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftMedicFirm.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftMedicFirm';
end;//Tkw_FormUserType_dftMedicFirm.GetWordNameForRegister

function Tkw_FormUserType_dftMedicFirm.GetInteger: Integer;
begin
 Result := dftMedicFirm;
end;//Tkw_FormUserType_dftMedicFirm.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftMedicFirm.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftMedicFirm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
