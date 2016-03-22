unit PrimWorkJournal_utWorkJournal_UserType;
 {* Журнал работы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\PrimWorkJournal_utWorkJournal_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utWorkJournal" MUID: (4BD6D74C0111)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utWorkJournal = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utWorkJournal }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utWorkJournal
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utWorkJournal.GetInteger: Integer;
begin
 Result := utWorkJournal;
end;//Tkw_FormUserType_utWorkJournal.GetInteger

class function Tkw_FormUserType_utWorkJournal.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utWorkJournal';
end;//Tkw_FormUserType_utWorkJournal.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utWorkJournal.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utWorkJournal }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
