unit PrimContactList_chatAddContact_UserType;
 {* Добавить контакт }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\PrimContactList_chatAddContact_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "chatAddContact" MUID: (4BD5B5C8019F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimContactList_chatContacts_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки chatAddContactLocalConstants }
 str_chatAddContactCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'chatAddContactCaption'; rValue : 'Добавить контакт');
  {* Заголовок пользовательского типа "Добавить контакт" }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_chatAddContact = {final} class(TtfwInteger)
  {* Слово словаря для типа формы chatAddContact }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_chatAddContact
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_chatAddContact.GetInteger: Integer;
begin
 Result := chatAddContact;
end;//Tkw_FormUserType_chatAddContact.GetInteger

class function Tkw_FormUserType_chatAddContact.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::chatAddContact';
end;//Tkw_FormUserType_chatAddContact.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_chatAddContactCaption.Init;
 {* Инициализация str_chatAddContactCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_chatAddContact.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_chatAddContact }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
