unit PrimContactList_chatContacts_UserType;
 {* Совещание онлайн }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\PrimContactList_chatContacts_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "chatContacts" MUID: (4BD5B59500D6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки chatContactsLocalConstants }
 str_chatContactsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'chatContactsCaption'; rValue : 'Совещание онлайн');
  {* Заголовок пользовательского типа "Совещание онлайн" }
 {* Константы для типа формы chatContacts }
 chatContactsName = 'chatContacts';
  {* Строковый идентификатор пользовательского типа "Совещание онлайн" }
 chatContacts = TvcmUserType(0);
  {* Совещание онлайн }
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
 Tkw_FormUserType_chatContacts = {final} class(TtfwInteger)
  {* Слово словаря для типа формы chatContacts }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_chatContacts
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_chatContacts.GetInteger: Integer;
begin
 Result := chatContacts;
end;//Tkw_FormUserType_chatContacts.GetInteger

class function Tkw_FormUserType_chatContacts.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::chatContacts';
end;//Tkw_FormUserType_chatContacts.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_chatContactsCaption.Init;
 {* Инициализация str_chatContactsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_chatContacts.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_chatContacts }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
