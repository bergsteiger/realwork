{$IfNDef evCacheableStyleTableListener_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evCacheableStyleTableListener.imp.pas"
// �����: 29.06.2009 10:14
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::StyleTable::evCacheableStyleTableListener
//
// ��������� �� ��������� ������� ������, ������� ������ �����-�� ��������� ��������� �� � ����� �
// �� �����, ����� ��������� � ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define evCacheableStyleTableListener_imp}
{$If not defined(DesignTimeLibrary)}
 _evStyleTableListenerPrim_Parent_ = _evCacheableStyleTableListener_Parent_;
 {$Include ..\Everest\evStyleTableListenerPrim.imp.pas}
 _evCacheableStyleTableListener_ = {mixin} class(_evStyleTableListenerPrim_)
  {* ��������� �� ��������� ������� ������, ������� ������ �����-�� ��������� ��������� �� � ����� � �� �����, ����� ��������� � ���� }
 protected
 // overridden protected methods
   procedure Release; override;
 end;//_evCacheableStyleTableListener_
{$Else}

 _evStyleTableListenerPrim_Parent_ = _evCacheableStyleTableListener_Parent_;
 {$Include ..\Everest\evStyleTableListenerPrim.imp.pas}
 _evCacheableStyleTableListener_ = _evStyleTableListenerPrim_;

{$IfEnd} //not DesignTimeLibrary

{$Else evCacheableStyleTableListener_imp}

{$If not defined(DesignTimeLibrary)}

{$Include ..\Everest\evStyleTableListenerPrim.imp.pas}

// start class _evCacheableStyleTableListener_

procedure _evCacheableStyleTableListener_.Release;
//#UC START# *479F2AFB0397_4A485B9801E0_var*
//#UC END# *479F2AFB0397_4A485B9801E0_var*
begin
//#UC START# *479F2AFB0397_4A485B9801E0_impl*
 evDelStyleTableSpy(Self);
 inherited;
//#UC END# *479F2AFB0397_4A485B9801E0_impl*
end;//_evCacheableStyleTableListener_.Release

{$IfEnd} //not DesignTimeLibrary

{$EndIf evCacheableStyleTableListener_imp}
