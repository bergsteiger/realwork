{$IfNDef nevParaListTool_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas"
// Стереотип: "Impurity"

{$Define nevParaListTool_imp}

 _X_ = InevParaList;
 _nevParaXTool_Parent_ = _nevParaListTool_Parent_;
 {$Include nevParaXTool.imp.pas}
 _nevParaListTool_ = class(_nevParaXTool_)
  {* Инструмент для InevParaList }
 end;//_nevParaListTool_

{$Else nevParaListTool_imp}

{$IfNDef nevParaListTool_imp_impl}

{$Define nevParaListTool_imp_impl}

type _Instance_R_ = _nevParaListTool_;

{$Include nevParaXTool.imp.pas}

{$EndIf nevParaListTool_imp_impl}

{$EndIf nevParaListTool_imp}

