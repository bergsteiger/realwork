{$IfNDef Unknown_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3$Basic Concepts"
// ������: "Unknown.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: Impurity::Class Shared Delphi ���������� � �������������� �����������::L3$Basic Concepts::Ref Counting::Unknown
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define Unknown_imp}
 _UnknownImpl_Parent_ = _Unknown_Parent_;
 {$Include ..\L3\UnknownImpl.imp.pas}
 _Unknown_ = {mixin} class(_UnknownImpl_, IUnknown)
 end;//_Unknown_

{$Else Unknown_imp}

{$Include ..\L3\UnknownImpl.imp.pas}


{$EndIf Unknown_imp}
