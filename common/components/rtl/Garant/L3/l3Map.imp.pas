{$IfNDef l3Map_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3Map.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::Containers::l3Map
//
// ������� (����-��������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3Map_imp}
//#UC START# *5609096C03BEci*
//#UC END# *5609096C03BEci*
 _l3MapPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3MapPrim.imp.pas}
//#UC START# *5609096C03BEcit*
type
//#UC END# *5609096C03BEcit*
 _l3Map_ = {abstract mixin} class(_l3MapPrim_)
  {* ������� (����-��������) }
//#UC START# *5609096C03BEpubl*
//#UC END# *5609096C03BEpubl*
 end;//_l3Map_

{$Else l3Map_imp}


{$Include ..\L3\l3MapPrim.imp.pas}


//#UC START# *5609096C03BEimpl*
//#UC END# *5609096C03BEimpl*

{$EndIf l3Map_imp}
