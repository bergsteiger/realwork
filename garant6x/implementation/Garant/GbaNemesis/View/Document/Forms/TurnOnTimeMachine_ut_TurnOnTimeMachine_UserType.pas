unit TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType;
 {* Включить Машину времени }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_TurnOnTimeMachine" MUID: (6E555D981AA9)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки ut_TurnOnTimeMachineLocalConstants }
 str_ut_TurnOnTimeMachineCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_TurnOnTimeMachineCaption'; rValue : 'Включить Машину времени');
  {* Заголовок пользовательского типа "Включить Машину времени" }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_TurnOnTimeMachine = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_TurnOnTimeMachine }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_TurnOnTimeMachine
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_TurnOnTimeMachine.GetInteger: Integer;
begin
 Result := ut_TurnOnTimeMachine;
end;//Tkw_FormUserType_ut_TurnOnTimeMachine.GetInteger

class function Tkw_FormUserType_ut_TurnOnTimeMachine.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_TurnOnTimeMachine';
end;//Tkw_FormUserType_ut_TurnOnTimeMachine.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_TurnOnTimeMachineCaption.Init;
 {* Инициализация str_ut_TurnOnTimeMachineCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_TurnOnTimeMachine.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_TurnOnTimeMachine }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
