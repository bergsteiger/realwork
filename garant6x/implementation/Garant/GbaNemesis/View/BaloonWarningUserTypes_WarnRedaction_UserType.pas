unit BaloonWarningUserTypes_WarnRedaction_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnRedaction_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "WarnRedaction" MUID: (4DA829BE0146)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnTimeMachineOn_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки WarnRedactionLocalConstants }
 str_WarnRedactionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnRedactionCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Константы для типа формы WarnRedaction }
 WarnRedactionName = 'WarnRedaction';
  {* Строковый идентификатор пользовательского типа "" }
 WarnRedaction = TvcmUserType(WarnTimeMachineOn + 1);
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
 Tkw_FormUserType_WarnRedaction = {final} class(TtfwInteger)
  {* Слово словаря для типа формы WarnRedaction }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_WarnRedaction
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_WarnRedaction.GetInteger: Integer;
begin
 Result := WarnRedaction;
end;//Tkw_FormUserType_WarnRedaction.GetInteger

class function Tkw_FormUserType_WarnRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::WarnRedaction';
end;//Tkw_FormUserType_WarnRedaction.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_WarnRedactionCaption.Init;
 {* Инициализация str_WarnRedactionCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnRedaction.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_WarnRedaction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
