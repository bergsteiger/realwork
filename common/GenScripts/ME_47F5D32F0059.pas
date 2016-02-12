{$IfNDef nevParaTool_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevParaTool.imp.pas"
// Стереотип: "Impurity"

{$Define nevParaTool_imp}

 _X_ = InevPara;
 _nevParaXTool_Parent_ = _nevParaTool_Parent_;
 {$Include w:\common\components\gui\Garant\Everest\new\nevParaXTool.imp.pas}
 _nevParaTool_ = class(_nevParaXTool_)
  {* Инструмент для InevPara }
 end;//_nevParaTool_

{$Else nevParaTool_imp}

{$IfNDef nevParaTool_imp_impl}

{$Define nevParaTool_imp_impl}

{$Include w:\common\components\gui\Garant\Everest\new\nevParaXTool.imp.pas}

{$EndIf nevParaTool_imp_impl}

{$EndIf nevParaTool_imp}

