{$IfNDef nevTextParaTool_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevTextParaTool.imp.pas"
// Стереотип: "Impurity"

{$Define nevTextParaTool_imp}

 _X_ = InevTextPara;
 _nevParaXTool_Parent_ = _nevTextParaTool_Parent_;
 {$Include nevParaXTool.imp.pas}
 _nevTextParaTool_ = class(_nevParaXTool_)
  {* Инструмент для InevTextPara }
 end;//_nevTextParaTool_

{$Else nevTextParaTool_imp}

{$IfNDef nevTextParaTool_imp_impl}

{$Define nevTextParaTool_imp_impl}

type _Instance_R_ = _nevTextParaTool_;

{$Include nevParaXTool.imp.pas}

{$EndIf nevTextParaTool_imp_impl}

{$EndIf nevTextParaTool_imp}

