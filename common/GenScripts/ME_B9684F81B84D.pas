unit TurnOffTimeMachine_ut_TurnOffTimeMachine_UserType;
 {* Выключить Машину времени / Изменить дату }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\TurnOffTimeMachine_ut_TurnOffTimeMachine_UserType.pas"
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
 {* Константы для типа формы ut_TurnOffTimeMachine }
 ut_TurnOffTimeMachineName = 'ut_TurnOffTimeMachine';
  {* Строковый идентификатор пользовательского типа "Выключить Машину времени / Изменить дату" }
 ut_TurnOffTimeMachine = TvcmUserType(0);
  {* Выключить Машину времени / Изменить дату }
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
 Tkw_FormUserType_ut_TurnOffTimeMachine = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_TurnOffTimeMachine }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_TurnOffTimeMachine
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_TurnOffTimeMachine.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_TurnOffTimeMachine';
end;//Tkw_FormUserType_ut_TurnOffTimeMachine.GetWordNameForRegister

function Tkw_FormUserType_ut_TurnOffTimeMachine.GetInteger: Integer;
begin
 Result := ut_TurnOffTimeMachine;
end;//Tkw_FormUserType_ut_TurnOffTimeMachine.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_TurnOffTimeMachine.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_TurnOffTimeMachine }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
