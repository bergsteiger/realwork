{$IfNDef StandardAtomicList_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "SandBox"
// ������: "StandardAtomicList.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: Impurity::Class Shared Delphi Sand Box::SandBox::FinalContainers::StandardAtomicList
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define StandardAtomicList_imp}
 _AtomicList_Parent_ = TRefcounted;
 {$Include ..\SandBox\AtomicList.imp.pas}
 _StandardAtomicList_ = {mixin} class(_AtomicList_)
 end;//_StandardAtomicList_

{$Else StandardAtomicList_imp}

{$Include ..\SandBox\AtomicList.imp.pas}


{$EndIf StandardAtomicList_imp}
