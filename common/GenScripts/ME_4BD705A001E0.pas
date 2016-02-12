unit PrimRightEdition_utRightEdition_UserType;
 {* Текущая редакция }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimRightEdition_utRightEdition_UserType.pas"
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
 {* Константы для типа формы utRightEdition }
 utRightEditionName = 'utRightEdition';
  {* Строковый идентификатор пользовательского типа "Текущая редакция" }
 utRightEdition = TvcmUserType(0);
  {* Текущая редакция }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utRightEdition = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utRightEdition }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utRightEdition
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utRightEdition.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utRightEdition';
end;//Tkw_FormUserType_utRightEdition.GetWordNameForRegister

function Tkw_FormUserType_utRightEdition.GetInteger: Integer;
begin
 Result := utRightEdition;
end;//Tkw_FormUserType_utRightEdition.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utRightEdition.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utRightEdition }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
