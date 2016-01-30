unit PrimWorkJournal_utWorkJournal_UserType;
 {* Журнал работы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\PrimWorkJournal_utWorkJournal_UserType.pas"
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
 {* Константы для типа формы utWorkJournal }
 utWorkJournalName = 'utWorkJournal';
  {* Строковый идентификатор пользовательского типа "Журнал работы" }
 utWorkJournal = TvcmUserType(0);
  {* Журнал работы }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utWorkJournal = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utWorkJournal }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utWorkJournal
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utWorkJournal.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utWorkJournal';
end;//Tkw_FormUserType_utWorkJournal.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utWorkJournal.GetInteger: Integer;
begin
 Result := utWorkJournal;
end;//Tkw_FormUserType_utWorkJournal.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utWorkJournal.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utWorkJournal }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
