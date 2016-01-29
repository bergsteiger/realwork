{$IfNDef afwApplicationDataUpdate_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AFW"
// �����: ������� �.�.
// ������: "w:/common/components/gui/Garant/AFW/implementation/afwApplicationDataUpdate.imp.pas"
// �����: 18.12.2007
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::AFW::afwMixIns::afwApplicationDataUpdate
//
// �������, ����������� IafwApplicationDataListener.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define afwApplicationDataUpdate_imp}
 _afwApplicationDataUpdate_ = {mixin} class(_afwApplicationDataUpdate_Parent_, IafwApplicationDataListener)
  {* �������, ����������� IafwApplicationDataListener. }
 protected
 // realized methods
   procedure UpdateFinished;
     {* ����������� ��������� �� ��������� ���������� ������ }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure InitFields; override;
 protected
 // protected methods
   procedure FinishDataUpdate; virtual;
 end;//_afwApplicationDataUpdate_

{$Else afwApplicationDataUpdate_imp}

// start class _afwApplicationDataUpdate_

procedure _afwApplicationDataUpdate_.FinishDataUpdate;
//#UC START# *47EA4E9002C6_47EA4BEF0140_var*
//#UC END# *47EA4E9002C6_47EA4BEF0140_var*
begin
//#UC START# *47EA4E9002C6_47EA4BEF0140_impl*
 // ������ �� ������
//#UC END# *47EA4E9002C6_47EA4BEF0140_impl*
end;//_afwApplicationDataUpdate_.FinishDataUpdate

procedure _afwApplicationDataUpdate_.UpdateFinished;
//#UC START# *4768DD730235_47EA4BEF0140_var*
//#UC END# *4768DD730235_47EA4BEF0140_var*
begin
//#UC START# *4768DD730235_47EA4BEF0140_impl*
 FinishDataUpdate;
//#UC END# *4768DD730235_47EA4BEF0140_impl*
end;//_afwApplicationDataUpdate_.UpdateFinished

procedure _afwApplicationDataUpdate_.Cleanup;
//#UC START# *479731C50290_47EA4BEF0140_var*
//#UC END# *479731C50290_47EA4BEF0140_var*
begin
//#UC START# *479731C50290_47EA4BEF0140_impl*
 if (afw.Application <> nil) and (afw.Application.Data <> nil) then
  afw.Application.Data.Notify.RemoveListener(Self);
 inherited;
//#UC END# *479731C50290_47EA4BEF0140_impl*
end;//_afwApplicationDataUpdate_.Cleanup

procedure _afwApplicationDataUpdate_.InitFields;
//#UC START# *47A042E100E2_47EA4BEF0140_var*
//#UC END# *47A042E100E2_47EA4BEF0140_var*
begin
//#UC START# *47A042E100E2_47EA4BEF0140_impl*
 inherited;
 if (afw.Application <> nil) and (afw.Application.Data <> nil) then
  afw.Application.Data.Notify.AddListener(Self);
//#UC END# *47A042E100E2_47EA4BEF0140_impl*
end;//_afwApplicationDataUpdate_.InitFields

{$EndIf afwApplicationDataUpdate_imp}
