{$IfNDef nsNodeNotifierPrim_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsNodeNotifierPrim.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nsNodeNotifierPrim" MUID: (48FD8B76020F)
// Имя типа: "_nsNodeNotifierPrim_"

{$Define nsNodeNotifierPrim_imp}

 _l3ChangingChangedNotifier_Parent_ = _nsNodeNotifierPrim_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3ChangingChangedNotifier.imp.pas}
 _l3LockedChange_Parent_ = _l3ChangingChangedNotifier_;
 {$Include w:\common\components\rtl\Garant\L3\l3LockedChange.imp.pas}
 _nsNodeNotifierPrim_ = class(_l3LockedChange_)
 end;//_nsNodeNotifierPrim_

{$Else nsNodeNotifierPrim_imp}

{$IfNDef nsNodeNotifierPrim_imp_impl}

{$Define nsNodeNotifierPrim_imp_impl}

{$Include w:\common\components\rtl\Garant\L3\l3ChangingChangedNotifier.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3LockedChange.imp.pas}

{$EndIf nsNodeNotifierPrim_imp_impl}

{$EndIf nsNodeNotifierPrim_imp}

