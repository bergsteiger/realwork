unit ListUserTypes_lftUserCRList1_SynchorForm_UserType;
 {* Синхронный просмотр (настраиваемая вкладка связанных документов 1) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftUserCRList1_SynchorForm_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftRespondentsSynchroForm_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы lftUserCRList1_SynchorForm }
 lftUserCRList1_SynchorFormName = 'lftUserCRList1_SynchorForm';
  {* Строковый идентификатор пользовательского типа "Синхронный просмотр (настраиваемая вкладка связанных документов 1)" }
 lftUserCRList1_SynchorForm = TvcmUserType(lftRespondentsSynchroForm + 1);
  {* Синхронный просмотр (настраиваемая вкладка связанных документов 1) }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftUserCRList1_SynchorForm = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftUserCRList1_SynchorForm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftUserCRList1_SynchorForm
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftUserCRList1_SynchorForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftUserCRList1_SynchorForm';
end;//Tkw_FormUserType_lftUserCRList1_SynchorForm.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftUserCRList1_SynchorForm.GetInteger: Integer;
begin
 Result := lftUserCRList1_SynchorForm;
end;//Tkw_FormUserType_lftUserCRList1_SynchorForm.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftUserCRList1_SynchorForm.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftUserCRList1_SynchorForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
