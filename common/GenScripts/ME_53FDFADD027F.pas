{$IfNDef m3HeaderIDSupplier_imp}

// Модуль: "w:\common\components\rtl\Garant\m3\m3HeaderIDSupplier.imp.pas"
// Стереотип: "Impurity"

{$Define m3HeaderIDSupplier_imp}

 _m3HeaderIDSupplier_ = class(_m3HeaderIDSupplier_Parent_)
  public
   class function HeaderID: TCLSID; virtual; abstract;
 end;//_m3HeaderIDSupplier_

{$Else m3HeaderIDSupplier_imp}

{$IfNDef m3HeaderIDSupplier_imp_impl}

{$Define m3HeaderIDSupplier_imp_impl}

{$EndIf m3HeaderIDSupplier_imp_impl}

{$EndIf m3HeaderIDSupplier_imp}

