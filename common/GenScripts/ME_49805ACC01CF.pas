{$IfNDef TurnOnTimeMachine_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\TurnOnTimeMachine.imp.pas"
// ���������: "Impurity"
// ������� ������: "TurnOnTimeMachine" MUID: (49805ACC01CF)
// ��� ����: "_TurnOnTimeMachine_"

{$Define TurnOnTimeMachine_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _TurnOnTimeMachine_ = class(_TurnOnTimeMachine_Parent_, InsTurnOnTimeMachine)
  {* ���������� InsTurnOnTimeMachine }
  protected
   procedure OnDate(aDate: RtlDateTime);
    {* �������� �� ���� }
   procedure OnCurrentRedaction;
    {* �������� � ������ �������� ������� �������� }
   function Get_DisableOps: TnsTurnOnTimeMachineOperations;
 end;//_TurnOnTimeMachine_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_TurnOnTimeMachine_ = _TurnOnTimeMachine_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else TurnOnTimeMachine_imp}

{$IfNDef TurnOnTimeMachine_imp_impl}

{$Define TurnOnTimeMachine_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure _TurnOnTimeMachine_.OnDate(aDate: RtlDateTime);
 {* �������� �� ���� }
//#UC START# *49804EB60303_49805ACC01CF_var*
//#UC END# *49804EB60303_49805ACC01CF_var*
begin
//#UC START# *49804EB60303_49805ACC01CF_impl*
 nsTimeMachineOn(Document, bsBusinessToAdapter(aDate));
//#UC END# *49804EB60303_49805ACC01CF_impl*
end;//_TurnOnTimeMachine_.OnDate

procedure _TurnOnTimeMachine_.OnCurrentRedaction;
 {* �������� � ������ �������� ������� �������� }
//#UC START# *49804ED003A8_49805ACC01CF_var*
//#UC END# *49804ED003A8_49805ACC01CF_var*
begin
//#UC START# *49804ED003A8_49805ACC01CF_impl*
 nsTimeMachineOn(Document, TdmStdRes.GetCurEditionDate(Document));
//#UC END# *49804ED003A8_49805ACC01CF_impl*
end;//_TurnOnTimeMachine_.OnCurrentRedaction

function _TurnOnTimeMachine_.Get_DisableOps: TnsTurnOnTimeMachineOperations;
//#UC START# *49805F2C0082_49805ACC01CFget_var*
//#UC END# *49805F2C0082_49805ACC01CFget_var*
begin
//#UC START# *49805F2C0082_49805ACC01CFget_impl*
 // ���� �� ������ ���� �������� ������� ��������, �� ������ ��������
 // ��������� �� ���� �������� ������� �������� ����������� (CQ OIT5-26843):
 if (ViewArea <> nil) and
   ViewArea.IsDateCurrentRedationEmpty then
  Result := [ns_ontmCurrentRedactionOp]
 else
  Result := [];
//#UC END# *49805F2C0082_49805ACC01CFget_impl*
end;//_TurnOnTimeMachine_.Get_DisableOps
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf TurnOnTimeMachine_imp_impl}

{$EndIf TurnOnTimeMachine_imp}

