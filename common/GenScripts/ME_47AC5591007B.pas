{$IfNDef k2Tag_imp}

// Модуль: "w:\common\components\rtl\Garant\K2\k2Tag.imp.pas"
// Стереотип: "Impurity"

{$Define k2Tag_imp}

 _k2TagPrim_Parent_ = _k2Tag_Parent_;
 {$Include k2TagPrim.imp.pas}
 _k2Tag_ = class(_k2TagPrim_)
  {* Реализация тега. }
 end;//_k2Tag_

{$Else k2Tag_imp}

{$IfNDef k2Tag_imp_impl}

{$Define k2Tag_imp_impl}

type _Instance_R_ = _k2Tag_;

{$Include k2TagPrim.imp.pas}

{$EndIf k2Tag_imp_impl}

{$EndIf k2Tag_imp}

