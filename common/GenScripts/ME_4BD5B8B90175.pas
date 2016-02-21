unit BaseHistoryWindow_utChatHistory_UserType;
 {* История переписки }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseHistoryWindow_utChatHistory_UserType.pas"
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
 {* Константы для типа формы utChatHistory }
 utChatHistoryName = 'utChatHistory';
  {* Строковый идентификатор пользовательского типа "История переписки" }
 utChatHistory = TvcmUserType(0);
  {* История переписки }
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
 Tkw_FormUserType_utChatHistory = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utChatHistory }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utChatHistory
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utChatHistory.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utChatHistory';
end;//Tkw_FormUserType_utChatHistory.GetWordNameForRegister

function Tkw_FormUserType_utChatHistory.GetInteger: Integer;
begin
 Result := utChatHistory;
end;//Tkw_FormUserType_utChatHistory.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utChatHistory.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utChatHistory }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
