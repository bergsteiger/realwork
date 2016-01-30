{$IfNDef StandardAtomicList_imp}

// Модуль: "w:\common\components\SandBox\StandardAtomicList.imp.pas"
// Стереотип: "Impurity"

{$Define StandardAtomicList_imp}

 _AtomicList_Parent_ = TRefcounted;
 {$Include AtomicList.imp.pas}
 _StandardAtomicList_ = class(_AtomicList_)
 end;//_StandardAtomicList_

{$Else StandardAtomicList_imp}

{$IfNDef StandardAtomicList_imp_impl}

{$Define StandardAtomicList_imp_impl}

{$Include AtomicList.imp.pas}

{$EndIf StandardAtomicList_imp_impl}

{$EndIf StandardAtomicList_imp}

