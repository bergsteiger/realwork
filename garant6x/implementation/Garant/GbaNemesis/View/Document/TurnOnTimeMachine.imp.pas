{$IfNDef TurnOnTimeMachine_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/TurnOnTimeMachine.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::TurnOnTimeMachine
//
// ���������� InsTurnOnTimeMachine
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define TurnOnTimeMachine_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _TurnOnTimeMachine_ = {mixin} class(_TurnOnTimeMachine_Parent_, InsTurnOnTimeMachine)
  {* ���������� InsTurnOnTimeMachine }
 protected
 // realized methods
   procedure OnDate(aDate: RtlDateTime);
     {* �������� �� ���� }
   procedure OnCurrentRedaction;
     {* �������� � ������ �������� ������� �������� }
   function Get_DisableOps: TnsTurnOnTimeMachineOperations;
 end;//_TurnOnTimeMachine_
{$Else}

 _TurnOnTimeMachine_ = _TurnOnTimeMachine_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else TurnOnTimeMachine_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _TurnOnTimeMachine_

procedure _TurnOnTimeMachine_.OnDate(aDate: RtlDateTime);
//#UC START# *49804EB60303_49805ACC01CF_var*
//#UC END# *49804EB60303_49805ACC01CF_var*
begin
//#UC START# *49804EB60303_49805ACC01CF_impl*
 nsTimeMachineOn(Document, bsBusinessToAdapter(aDate));
//#UC END# *49804EB60303_49805ACC01CF_impl*
end;//_TurnOnTimeMachine_.OnDate

procedure _TurnOnTimeMachine_.OnCurrentRedaction;
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

{$IfEnd} //not Admin AND not Monitorings

{$EndIf TurnOnTimeMachine_imp}
