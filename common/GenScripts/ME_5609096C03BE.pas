{$IfNDef l3Map_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3Map.imp.pas"
// ���������: "Impurity"

{$Define l3Map_imp}

 //#UC START# *5609096C03BEci*
 //#UC END# *5609096C03BEci*
 _l3MapPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3MapPrim.imp.pas}
 //#UC START# *5609096C03BEcit*
type
 //#UC END# *5609096C03BEcit*
 _l3Map_ = {abstract} class(_l3MapPrim_)
  {* ������� (����-��������) }
 //#UC START# *5609096C03BEpubl*
 //#UC END# *5609096C03BEpubl*
 end;//_l3Map_

{$Else l3Map_imp}

{$IfNDef l3Map_imp_impl}

{$Define l3Map_imp_impl}

type _Instance_R_ = _l3Map_;

{$Include l3MapPrim.imp.pas}

//#UC START# *5609096C03BEimpl*
//#UC END# *5609096C03BEimpl*

{$EndIf l3Map_imp_impl}

{$EndIf l3Map_imp}

