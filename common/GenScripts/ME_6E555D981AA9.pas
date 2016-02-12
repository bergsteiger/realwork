unit TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType;
 {* Включить Машину времени }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы ut_TurnOnTimeMachine }
 ut_TurnOnTimeMachineName = 'ut_TurnOnTimeMachine';
  {* Строковый идентификатор пользовательского типа "Включить Машину времени" }
 ut_TurnOnTimeMachine = TvcmUserType(0);
  {* Включить Машину времени }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_TurnOnTimeMachine = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_TurnOnTimeMachine }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_TurnOnTimeMachine
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_TurnOnTimeMachine.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_TurnOnTimeMachine';
end;//Tkw_FormUserType_ut_TurnOnTimeMachine.GetWordNameForRegister

function Tkw_FormUserType_ut_TurnOnTimeMachine.GetInteger: Integer;
begin
 Result := ut_TurnOnTimeMachine;
end;//Tkw_FormUserType_ut_TurnOnTimeMachine.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_TurnOnTimeMachine.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_TurnOnTimeMachine }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
