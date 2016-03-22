{$IfNDef TurnOffTimeMachine_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\TurnOffTimeMachine.imp.pas"
// ���������: "Impurity"
// ������� ������: "TurnOffTimeMachine" MUID: (4980620401ED)
// ��� ����: "_TurnOffTimeMachine_"

{$Define TurnOffTimeMachine_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _TurnOffTimeMachine_ = class(_TurnOffTimeMachine_Parent_, InsTurnOffTimeMachine)
  {* ���������� InsTurnOffTimeMachine }
  protected
   f_DontResetRedactions: Boolean;
  protected
   procedure TimeMachineOnOff(aPureOff: Boolean = False); virtual;
   procedure GotoActualRedaction;
    {* ��������� � ������� � ���������� �������� }
   procedure StayInCurrentRedaction;
    {* ��������� � �������� � ������� �������� }
   procedure ChangeDate(aDate: RtlDateTime);
    {* �������� }
   function Get_DisableOps: TnsTurnOffTimeMachineOperations;
 end;//_TurnOffTimeMachine_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_TurnOffTimeMachine_ = _TurnOffTimeMachine_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else TurnOffTimeMachine_imp}

{$IfNDef TurnOffTimeMachine_imp_impl}

{$Define TurnOffTimeMachine_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 {* ��������� � ������� � ���������� �������� }
//#UC START# *49805EED0054_4980620401ED_var*
//#UC END# *49805EED0054_4980620401ED_var*
begin
//#UC START# *49805EED0054_4980620401ED_impl*
 f_DontResetRedactions := False;
 TimeMachineOnOff;
//#UC END# *49805EED0054_4980620401ED_impl*
end;//_TurnOffTimeMachine_.GotoActualRedaction

procedure _TurnOffTimeMachine_.StayInCurrentRedaction;
 {* ��������� � �������� � ������� �������� }
//#UC START# *49805EFF013C_4980620401ED_var*
//#UC END# *49805EFF013C_4980620401ED_var*
begin
//#UC START# *49805EFF013C_4980620401ED_impl*
 f_DontResetRedactions := True;
 TimeMachineOnOff;
//#UC END# *49805EFF013C_4980620401ED_impl*
end;//_TurnOffTimeMachine_.StayInCurrentRedaction

procedure _TurnOffTimeMachine_.ChangeDate(aDate: RtlDateTime);
 {* �������� }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf TurnOffTimeMachine_imp_impl}

{$EndIf TurnOffTimeMachine_imp}

