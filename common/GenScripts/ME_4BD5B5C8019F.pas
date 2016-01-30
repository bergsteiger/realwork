unit PrimContactList_chatAddContact_UserType;
 {* Добавить контакт }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\PrimContactList_chatAddContact_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimContactList_chatContacts_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы chatAddContact }
 chatAddContactName = 'chatAddContact';
  {* Строковый идентификатор пользовательского типа "Добавить контакт" }
 chatAddContact = TvcmUserType(chatContacts + 1);
  {* Добавить контакт }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_chatAddContact = {final} class(TtfwInteger)
  {* Слово словаря для типа формы chatAddContact }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_chatAddContact
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_chatAddContact.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::chatAddContact';
end;//Tkw_FormUserType_chatAddContact.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_chatAddContact.GetInteger: Integer;
begin
 Result := chatAddContact;
end;//Tkw_FormUserType_chatAddContact.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_chatAddContact.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_chatAddContact }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
