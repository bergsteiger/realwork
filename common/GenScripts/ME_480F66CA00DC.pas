{$IfNDef nevTextParaTool_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevTextParaTool.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nevTextParaTool" MUID: (480F66CA00DC)
// Имя типа: "_nevTextParaTool_"

{$Define nevTextParaTool_imp}

 _X_ = InevTextPara;
 _nevParaXTool_Parent_ = _nevTextParaTool_Parent_;
 {$Include w:\common\components\gui\Garant\Everest\new\nevParaXTool.imp.pas}
 _nevTextParaTool_ = class(_nevParaXTool_)
  {* Инструмент для InevTextPara }
 end;//_nevTextParaTool_

{$Else nevTextParaTool_imp}

{$IfNDef nevTextParaTool_imp_impl}

{$Define nevTextParaTool_imp_impl}

{$Include w:\common\components\gui\Garant\Everest\new\nevParaXTool.imp.pas}

{$EndIf nevTextParaTool_imp_impl}

{$EndIf nevTextParaTool_imp}

