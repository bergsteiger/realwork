{$IfNDef l3MultiMap_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3MultiMap.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "l3MultiMap" MUID: (57E508B5039F)
// Имя типа: "_l3MultiMap_"

{$Define l3MultiMap_imp}

 _l3MultiMapPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3MultiMapPrim.imp.pas}
 _l3MultiMap_ = class(_l3MultiMapPrim_)
  protected
   procedure InitFields; override;
 end;//_l3MultiMap_

{$Else l3MultiMap_imp}

{$IfNDef l3MultiMap_imp_impl}

{$Define l3MultiMap_imp_impl}

{$Include w:\common\components\rtl\Garant\L3\l3MultiMapPrim.imp.pas}

procedure _l3MultiMap_.InitFields;
//#UC START# *47A042E100E2_57E508B5039F_var*
//#UC END# *47A042E100E2_57E508B5039F_var*
begin
//#UC START# *47A042E100E2_57E508B5039F_impl*
 inherited;
 //Duplicates := l3_dupAccept;
 Duplicates := l3_dupIgnore;
//#UC END# *47A042E100E2_57E508B5039F_impl*
end;//_l3MultiMap_.InitFields

{$EndIf l3MultiMap_imp_impl}

{$EndIf l3MultiMap_imp}

