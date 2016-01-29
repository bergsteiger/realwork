unit TurnOffTimeMachine_ut_TurnOffTimeMachine_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/TurnOffTimeMachine_ut_TurnOffTimeMachine_UserType.pas"
// Начат: 24.08.2009 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Common::View::Common::PrimF1Common::TurnOffTimeMachine::ut_TurnOffTimeMachine
//
// Выключить Машину времени / Изменить дату
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
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
    { Константы для типа формы ut_TurnOffTimeMachine }
   ut_TurnOffTimeMachineName = 'ut_TurnOffTimeMachine';
    { Строковый идентификатор пользовательского типа "Выключить Машину времени / Изменить дату" }
   ut_TurnOffTimeMachine = TvcmUserType(0);
    { Выключить Машину времени / Изменить дату }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_TurnOffTimeMachine = {final scriptword} class(TtfwInteger)
    {* Слово словаря для типа формы ut_TurnOffTimeMachine }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_TurnOffTimeMachine
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_TurnOffTimeMachine

class function Tkw_FormUserType_ut_TurnOffTimeMachine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_TurnOffTimeMachine';
end;//Tkw_FormUserType_ut_TurnOffTimeMachine.GetWordNameForRegister

function Tkw_FormUserType_ut_TurnOffTimeMachine.GetInteger: Integer;
 {-}
begin
 Result := ut_TurnOffTimeMachine;
end;//Tkw_FormUserType_ut_TurnOffTimeMachine.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_ut_TurnOffTimeMachine
 Tkw_FormUserType_ut_TurnOffTimeMachine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.