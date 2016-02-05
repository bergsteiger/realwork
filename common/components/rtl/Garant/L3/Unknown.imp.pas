{$IfNDef Unknown_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\Unknown.imp.pas"
// Стереотип: "Impurity"

{$Define Unknown_imp}

 _UnknownImpl_Parent_ = _Unknown_Parent_;
 {$Include UnknownImpl.imp.pas}
 _Unknown_ = class(_UnknownImpl_, IUnknown)
 end;//_Unknown_

{$Else Unknown_imp}

{$IfNDef Unknown_imp_impl}

{$Define Unknown_imp_impl}

{$Include UnknownImpl.imp.pas}

{$EndIf Unknown_imp_impl}

{$EndIf Unknown_imp}

