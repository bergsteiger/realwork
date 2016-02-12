unit PrimLeftEdition_utLeftEdition_UserType;
 {* Предыдущая редакция }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimLeftEdition_utLeftEdition_UserType.pas"
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
 {* Константы для типа формы utLeftEdition }
 utLeftEditionName = 'utLeftEdition';
  {* Строковый идентификатор пользовательского типа "Предыдущая редакция" }
 utLeftEdition = TvcmUserType(0);
  {* Предыдущая редакция }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utLeftEdition = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utLeftEdition }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utLeftEdition
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utLeftEdition.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utLeftEdition';
end;//Tkw_FormUserType_utLeftEdition.GetWordNameForRegister

function Tkw_FormUserType_utLeftEdition.GetInteger: Integer;
begin
 Result := utLeftEdition;
end;//Tkw_FormUserType_utLeftEdition.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utLeftEdition.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utLeftEdition }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
