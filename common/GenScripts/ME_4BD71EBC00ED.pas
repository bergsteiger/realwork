unit PrimDiction_utDiction_UserType;
 {* Толковый словарь }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimDiction_utDiction_UserType.pas"
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
 {* Константы для типа формы utDiction }
 utDictionName = 'utDiction';
  {* Строковый идентификатор пользовательского типа "Толковый словарь" }
 utDiction = TvcmUserType(0);
  {* Толковый словарь }
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
 Tkw_FormUserType_utDiction = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utDiction }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utDiction
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utDiction.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utDiction';
end;//Tkw_FormUserType_utDiction.GetWordNameForRegister

function Tkw_FormUserType_utDiction.GetInteger: Integer;
begin
 Result := utDiction;
end;//Tkw_FormUserType_utDiction.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utDiction.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utDiction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
