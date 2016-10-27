unit BaseChatWindow_cwChat_UserType;
 {* Переписка }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseChatWindow_cwChat_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "cwChat" MUID: (4BD6D5500287)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки cwChatLocalConstants }
 str_cwChatCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cwChatCaption'; rValue : 'Переписка');
  {* Заголовок пользовательского типа "Переписка" }
 {* Константы для типа формы cwChat }
 cwChatName = 'cwChat';
  {* Строковый идентификатор пользовательского типа "Переписка" }
 cwChat = TvcmUserType(0);
  {* Переписка }
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
 Tkw_FormUserType_cwChat = {final} class(TtfwInteger)
  {* Слово словаря для типа формы cwChat }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_cwChat
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_cwChat.GetInteger: Integer;
begin
 Result := cwChat;
end;//Tkw_FormUserType_cwChat.GetInteger

class function Tkw_FormUserType_cwChat.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::cwChat';
end;//Tkw_FormUserType_cwChat.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_cwChatCaption.Init;
 {* Инициализация str_cwChatCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cwChat.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_cwChat }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
