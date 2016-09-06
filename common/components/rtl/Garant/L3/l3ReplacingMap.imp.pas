{$IfNDef l3ReplacingMap_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3ReplacingMap.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "l3ReplacingMap" MUID: (57CE9D2803DF)
// Имя типа: "_l3ReplacingMap_"

{$Define l3ReplacingMap_imp}

 {$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}
 _l3ReplacingMap_ = class(_l3Map_)
  {* Мапа, которая замещает существующие элементы новыми. }
  protected
   procedure InitFields; override;
 end;//_l3ReplacingMap_

{$Else l3ReplacingMap_imp}

{$IfNDef l3ReplacingMap_imp_impl}

{$Define l3ReplacingMap_imp_impl}

{$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}

procedure _l3ReplacingMap_.InitFields;
//#UC START# *47A042E100E2_57CE9D2803DF_var*
//#UC END# *47A042E100E2_57CE9D2803DF_var*
begin
//#UC START# *47A042E100E2_57CE9D2803DF_impl*
 inherited;
 Duplicates := l3_dupChange;
//#UC END# *47A042E100E2_57CE9D2803DF_impl*
end;//_l3ReplacingMap_.InitFields

{$EndIf l3ReplacingMap_imp_impl}

{$EndIf l3ReplacingMap_imp}

