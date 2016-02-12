unit ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType;
 {* Синхронный просмотр (синонимы по международному названию) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftProducedDrugsSynchroForm_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы lftDrugInternationalNameSynonymsSynchroForm }
 lftDrugInternationalNameSynonymsSynchroFormName = 'lftDrugInternationalNameSynonymsSynchroForm';
  {* Строковый идентификатор пользовательского типа "Синхронный просмотр (синонимы по международному названию)" }
 lftDrugInternationalNameSynonymsSynchroForm = TvcmUserType(lftProducedDrugsSynchroForm + 1);
  {* Синхронный просмотр (синонимы по международному названию) }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftDrugInternationalNameSynonymsSynchroForm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftDrugInternationalNameSynonymsSynchroForm';
end;//Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetWordNameForRegister

function Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetInteger: Integer;
begin
 Result := lftDrugInternationalNameSynonymsSynchroForm;
end;//Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftDrugInternationalNameSynonymsSynchroForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
