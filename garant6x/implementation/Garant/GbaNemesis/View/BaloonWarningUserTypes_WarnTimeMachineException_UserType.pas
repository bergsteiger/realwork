unit BaloonWarningUserTypes_WarnTimeMachineException_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnTimeMachineException_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "WarnTimeMachineException" MUID: (4DA82A2C0226)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnTimeMachineWarning_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки WarnTimeMachineExceptionLocalConstants }
 str_WarnTimeMachineExceptionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnTimeMachineExceptionCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Константы для типа формы WarnTimeMachineException }
 WarnTimeMachineExceptionName = 'WarnTimeMachineException';
  {* Строковый идентификатор пользовательского типа "" }
 WarnTimeMachineException = TvcmUserType(WarnTimeMachineWarning + 1);
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
 Tkw_FormUserType_WarnTimeMachineException = {final} class(TtfwInteger)
  {* Слово словаря для типа формы WarnTimeMachineException }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_WarnTimeMachineException
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_WarnTimeMachineException.GetInteger: Integer;
begin
 Result := WarnTimeMachineException;
end;//Tkw_FormUserType_WarnTimeMachineException.GetInteger

class function Tkw_FormUserType_WarnTimeMachineException.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::WarnTimeMachineException';
end;//Tkw_FormUserType_WarnTimeMachineException.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_WarnTimeMachineExceptionCaption.Init;
 {* Инициализация str_WarnTimeMachineExceptionCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnTimeMachineException.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_WarnTimeMachineException }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
