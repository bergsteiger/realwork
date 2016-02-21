unit RedactionsUserTypes_utRedaction_UserType;
 {* Редакции }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\RedactionsUserTypes_utRedaction_UserType.pas"
// Стереотип: "UserType"

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
 {* Константы для типа формы utRedaction }
 utRedactionName = 'utRedaction';
  {* Строковый идентификатор пользовательского типа "Редакции" }
 utRedaction = TvcmUserType(0);
  {* Редакции }
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
 Tkw_FormUserType_utRedaction = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utRedaction }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utRedaction
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utRedaction';
end;//Tkw_FormUserType_utRedaction.GetWordNameForRegister

function Tkw_FormUserType_utRedaction.GetInteger: Integer;
begin
 Result := utRedaction;
end;//Tkw_FormUserType_utRedaction.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utRedaction.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utRedaction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
