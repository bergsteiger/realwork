{$IfNDef evStyleTableListener_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evStyleTableListener.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::StyleTable::evStyleTableListener
//
// ������, ��������� ��������� ������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define evStyleTableListener_imp}
{$If not defined(DesignTimeLibrary)}
 _evStyleTableListenerPrim_Parent_ = _evStyleTableListener_Parent_;
 {$Include ..\Everest\evStyleTableListenerPrim.imp.pas}
 _evStyleTableListener_ = {mixin} class(_evStyleTableListenerPrim_)
  {* ������, ��������� ��������� ������� ������ }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 end;//_evStyleTableListener_
{$Else}

 _evStyleTableListenerPrim_Parent_ = _evStyleTableListener_Parent_;
 {$Include ..\Everest\evStyleTableListenerPrim.imp.pas}
 _evStyleTableListener_ = _evStyleTableListenerPrim_;

{$IfEnd} //not DesignTimeLibrary

{$Else evStyleTableListener_imp}

{$If not defined(DesignTimeLibrary)}

{$Include ..\Everest\evStyleTableListenerPrim.imp.pas}

// start class _evStyleTableListener_

procedure _evStyleTableListener_.Cleanup;
//#UC START# *479731C50290_480DA68701CE_var*
//#UC END# *479731C50290_480DA68701CE_var*
begin
//#UC START# *479731C50290_480DA68701CE_impl*
 evDelStyleTableSpy(Self);
 inherited;
//#UC END# *479731C50290_480DA68701CE_impl*
end;//_evStyleTableListener_.Cleanup

{$IfEnd} //not DesignTimeLibrary

{$EndIf evStyleTableListener_imp}
