unit PrimContactList_chatAddContact_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/Forms/PrimContactList_chatAddContact_UserType.pas"
// Начат: 01.10.2009 2:05
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Встроенные продукты::Chat::View::Chat::PrimContactList::chatAddContact
//
// Добавить контакт
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  PrimContactList_chatContacts_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы chatAddContact }
  chatAddContactName = 'chatAddContact';
   { Строковый идентификатор пользовательского типа "Добавить контакт" }
  chatAddContact = TvcmUserType(chatContacts + 1);
   { Добавить контакт }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_chatAddContact = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы chatAddContact }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_chatAddContact
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_chatAddContact

class function Tkw_FormUserType_chatAddContact.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::chatAddContact';
end;//Tkw_FormUserType_chatAddContact.GetWordNameForRegister

function Tkw_FormUserType_chatAddContact.GetInteger: Integer;
 {-}
begin
 Result := chatAddContact;
end;//Tkw_FormUserType_chatAddContact.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_chatAddContact
 Tkw_FormUserType_chatAddContact.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.