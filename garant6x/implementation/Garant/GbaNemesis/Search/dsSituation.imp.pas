{$IfNDef dsSituation_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Search"
// �����: ������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Search/dsSituation.imp.pas"
// �����: 2008/01/30 08:25:26 
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 ������� ����������� ���������� �������::SearchLite::Search::Search::dsSituation
//
// ���������� ���������� ������������� ��� ����������� �� �������� ��� 6.� (CQ: OIT5-28303)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dsSituation_imp}
 _InitDataType_ = IdeSearch;
 {$Include ..\Search\dsTagSimpleTree.imp.pas}
 _CurrentChangedListener_Parent_ = _dsTagSimpleTree_;
 {$Include ..\Search\CurrentChangedListener.imp.pas}
 _dsSituation_ = {abstract vac} class(_CurrentChangedListener_, IdsSituation, IbsCurrentChangedListener {from IdsSituation})
  {* ���������� ���������� ������������� ��� ����������� �� �������� ��� 6.� (CQ: OIT5-28303) }
 private
 // private fields
   CurrentChangedListener : IbsCurrentChangedListener;
   f_BlockNotification : Integer;
    {* ���� ��� �������� BlockNotification}
 protected
  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure InitFields; override;
   procedure DoCurrentChanged(const aNode: Il3SimpleNode); override;
     {* �������� �������. }
   procedure CurrentChangedNotification(const aNode: Il3SimpleNode); override;
 private
 // private properties
   property BlockNotification: Integer
     read f_BlockNotification
     write f_BlockNotification;
 protected
 // ������ �������������� � ����������� �����������
   function As_IbsCurrentChangedListener: IbsCurrentChangedListener;
 end;//_dsSituation_

{$Else dsSituation_imp}


{$Include ..\Search\dsTagSimpleTree.imp.pas}

{$Include ..\Search\CurrentChangedListener.imp.pas}

// start class _dsSituation_

procedure _dsSituation_.Cleanup;
//#UC START# *479731C50290_49242CB201D0_var*
//#UC END# *479731C50290_49242CB201D0_var*
begin
//#UC START# *479731C50290_49242CB201D0_impl*
 if (UseCaseController <> nil) then
  UseCaseController.As_Il3ChangeNotifier.Unsubscribe(IbsCurrentChangedListener(Self));
 inherited;
//#UC END# *479731C50290_49242CB201D0_impl*
end;//_dsSituation_.Cleanup

procedure _dsSituation_.InitFields;
//#UC START# *47A042E100E2_49242CB201D0_var*
//#UC END# *47A042E100E2_49242CB201D0_var*
begin
//#UC START# *47A042E100E2_49242CB201D0_impl*
 inherited;
 BlockNotification := 0;
 if (UseCaseController <> nil) then
  UseCaseController.As_Il3ChangeNotifier.Subscribe(IbsCurrentChangedListener(Self));
//#UC END# *47A042E100E2_49242CB201D0_impl*
end;//_dsSituation_.InitFields

procedure _dsSituation_.DoCurrentChanged(const aNode: Il3SimpleNode);
//#UC START# *47F0C1BF0314_49242CB201D0_var*
//#UC END# *47F0C1BF0314_49242CB201D0_var*
begin
//#UC START# *47F0C1BF0314_49242CB201D0_impl*
 inherited;
 if (CurrentChangedListener <> nil) then
 begin
  Inc(f_BlockNotification);
  try
   CurrentChangedListener.Process(aNode);
  finally
   Dec(f_BlockNotification);
  end;//try..finally
 end;//CurrentChangedListener <> nil
//#UC END# *47F0C1BF0314_49242CB201D0_impl*
end;//_dsSituation_.DoCurrentChanged

procedure _dsSituation_.CurrentChangedNotification(const aNode: Il3SimpleNode);
//#UC START# *49242A4E0252_49242CB201D0_var*
//#UC END# *49242A4E0252_49242CB201D0_var*
begin
//#UC START# *49242A4E0252_49242CB201D0_impl*
 if (BlockNotification = 0) then
  inherited;
//#UC END# *49242A4E0252_49242CB201D0_impl*
end;//_dsSituation_.CurrentChangedNotification

procedure _dsSituation_.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 Supports(aDS, IbsCurrentChangedListener, CurrentChangedListener);
end;

procedure _dsSituation_.ClearRefs;
begin
 inherited;
 CurrentChangedListener := nil;
end;

// ������ �������������� � ����������� �����������

function _dsSituation_.As_IbsCurrentChangedListener: IbsCurrentChangedListener;
begin
 Result := Self;
end;

{$EndIf dsSituation_imp}
