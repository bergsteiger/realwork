unit BaseChatWindow_cwChat_UserType;
 {* Переписка }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseChatWindow_cwChat_UserType.pas"
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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cwChat = {final} class(TtfwInteger)
  {* Слово словаря для типа формы cwChat }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_cwChat
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_cwChat.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::cwChat';
end;//Tkw_FormUserType_cwChat.GetWordNameForRegister

function Tkw_FormUserType_cwChat.GetInteger: Integer;
begin
 Result := cwChat;
end;//Tkw_FormUserType_cwChat.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cwChat.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_cwChat }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
