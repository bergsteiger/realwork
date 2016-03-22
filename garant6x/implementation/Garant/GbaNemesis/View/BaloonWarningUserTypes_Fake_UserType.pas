unit BaloonWarningUserTypes_Fake_UserType;
 {* Предупреждение }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_Fake_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "Fake" MUID: (4F5E13160332)

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
 {* Константы для типа формы Fake }
 FakeName = 'Fake';
  {* Строковый идентификатор пользовательского типа "Предупреждение" }
 Fake = TvcmUserType(0);
  {* Предупреждение }
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
 Tkw_FormUserType_Fake = {final} class(TtfwInteger)
  {* Слово словаря для типа формы Fake }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_Fake
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_Fake.GetInteger: Integer;
begin
 Result := Fake;
end;//Tkw_FormUserType_Fake.GetInteger

class function Tkw_FormUserType_Fake.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::Fake';
end;//Tkw_FormUserType_Fake.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_Fake.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_Fake }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
