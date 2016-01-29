{$IfNDef TurnOffTimeMachine_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/TurnOffTimeMachine.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Работа с документом и списком документов::Document::View::Document::TurnOffTimeMachine
//
// Реализация InsTurnOffTimeMachine
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define TurnOffTimeMachine_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _TurnOffTimeMachine_ = {mixin} class(_TurnOffTimeMachine_Parent_, InsTurnOffTimeMachine)
  {* Реализация InsTurnOffTimeMachine }
 protected
 // realized methods
   procedure GotoActualRedaction;
     {* выключить и перейти в актуальную редакцию }
   procedure StayInCurrentRedaction;
     {* выключить и остаться в текущей редакции }
   procedure ChangeDate(aDate: RtlDateTime);
     {* изменить }
   function Get_DisableOps: TnsTurnOffTimeMachineOperations;
 protected
 // protected fields
   f_DontResetRedactions : Boolean;
 protected
 // protected methods
   procedure TimeMachineOnOff(aPureOff: Boolean = False); virtual;
 end;//_TurnOffTimeMachine_
{$Else}

 _TurnOffTimeMachine_ = _TurnOffTimeMachine_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else TurnOffTimeMachine_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _TurnOffTimeMachine_

procedure _TurnOffTimeMachine_.TimeMachineOnOff(aPureOff: Boolean = False);
//#UC START# *4980630101F0_4980620401ED_var*
//#UC END# *4980630101F0_4980620401ED_var*
begin
//#UC START# *4980630101F0_4980620401ED_impl*
 if aPureOff or defDataAdapter.TimeMachine.IsOn then
 begin
  defDataAdapter.TimeMachine.SwitchOff;
  TnsTimeMachineOffEvent.Log(Document);
 end//if aPureOff...
 else
  nsUtils.nsTimeMachineOn(Document, TdmStdRes.GetCurEditionDate(Document));
//#UC END# *4980630101F0_4980620401ED_impl*
end;//_TurnOffTimeMachine_.TimeMachineOnOff

procedure _TurnOffTimeMachine_.GotoActualRedaction;
//#UC START# *49805EED0054_4980620401ED_var*
//#UC END# *49805EED0054_4980620401ED_var*
begin
//#UC START# *49805EED0054_4980620401ED_impl*
 f_DontResetRedactions := False;
 TimeMachineOnOff;
//#UC END# *49805EED0054_4980620401ED_impl*
end;//_TurnOffTimeMachine_.GotoActualRedaction

procedure _TurnOffTimeMachine_.StayInCurrentRedaction;
//#UC START# *49805EFF013C_4980620401ED_var*
//#UC END# *49805EFF013C_4980620401ED_var*
begin
//#UC START# *49805EFF013C_4980620401ED_impl*
 f_DontResetRedactions := True;
 TimeMachineOnOff;
//#UC END# *49805EFF013C_4980620401ED_impl*
end;//_TurnOffTimeMachine_.StayInCurrentRedaction

procedure _TurnOffTimeMachine_.ChangeDate(aDate: RtlDateTime);
//#UC START# *49805F0D0221_4980620401ED_var*
//#UC END# *49805F0D0221_4980620401ED_var*
begin
//#UC START# *49805F0D0221_4980620401ED_impl*
 nsTimeMachineOn(Document, bsBusinessToAdapter(aDate));
//#UC END# *49805F0D0221_4980620401ED_impl*
end;//_TurnOffTimeMachine_.ChangeDate

function _TurnOffTimeMachine_.Get_DisableOps: TnsTurnOffTimeMachineOperations;
//#UC START# *49805F190314_4980620401EDget_var*
//#UC END# *49805F190314_4980620401EDget_var*
begin
//#UC START# *49805F190314_4980620401EDget_impl*
 Result := [];
//#UC END# *49805F190314_4980620401EDget_impl*
end;//_TurnOffTimeMachine_.Get_DisableOps

{$IfEnd} //not Admin AND not Monitorings

{$EndIf TurnOffTimeMachine_imp}
