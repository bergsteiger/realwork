unit ListUserTypes_lftRespondentsSynchroForm_UserType;
 {* Синхронный просмотр (ссылка из документа) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftRespondentsSynchroForm_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftCorrespondentsSynchroForm_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы lftRespondentsSynchroForm }
 lftRespondentsSynchroFormName = 'lftRespondentsSynchroForm';
  {* Строковый идентификатор пользовательского типа "Синхронный просмотр (ссылка из документа)" }
 lftRespondentsSynchroForm = TvcmUserType(lftCorrespondentsSynchroForm + 1);
  {* Синхронный просмотр (ссылка из документа) }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftRespondentsSynchroForm = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftRespondentsSynchroForm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftRespondentsSynchroForm
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftRespondentsSynchroForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftRespondentsSynchroForm';
end;//Tkw_FormUserType_lftRespondentsSynchroForm.GetWordNameForRegister

function Tkw_FormUserType_lftRespondentsSynchroForm.GetInteger: Integer;
begin
 Result := lftRespondentsSynchroForm;
end;//Tkw_FormUserType_lftRespondentsSynchroForm.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftRespondentsSynchroForm.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftRespondentsSynchroForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
