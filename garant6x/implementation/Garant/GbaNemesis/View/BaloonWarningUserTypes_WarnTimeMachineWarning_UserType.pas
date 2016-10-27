unit BaloonWarningUserTypes_WarnTimeMachineWarning_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnTimeMachineWarning_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "WarnTimeMachineWarning" MUID: (4DA82A170063)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnRedaction_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки WarnTimeMachineWarningLocalConstants }
 str_WarnTimeMachineWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnTimeMachineWarningCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Константы для типа формы WarnTimeMachineWarning }
 WarnTimeMachineWarningName = 'WarnTimeMachineWarning';
  {* Строковый идентификатор пользовательского типа "" }
 WarnTimeMachineWarning = TvcmUserType(WarnRedaction + 1);
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
 Tkw_FormUserType_WarnTimeMachineWarning = {final} class(TtfwInteger)
  {* Слово словаря для типа формы WarnTimeMachineWarning }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_WarnTimeMachineWarning
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_WarnTimeMachineWarning.GetInteger: Integer;
begin
 Result := WarnTimeMachineWarning;
end;//Tkw_FormUserType_WarnTimeMachineWarning.GetInteger

class function Tkw_FormUserType_WarnTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::WarnTimeMachineWarning';
end;//Tkw_FormUserType_WarnTimeMachineWarning.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_WarnTimeMachineWarningCaption.Init;
 {* Инициализация str_WarnTimeMachineWarningCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnTimeMachineWarning.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_WarnTimeMachineWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
