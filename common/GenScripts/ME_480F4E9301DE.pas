{$IfNDef nevParaListTool_imp}

// ������: "w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas"
// ���������: "Impurity"

{$Define nevParaListTool_imp}

 _X_ = InevParaList;
 _nevParaXTool_Parent_ = _nevParaListTool_Parent_;
 {$Include w:\common\components\gui\Garant\Everest\new\nevParaXTool.imp.pas}
 _nevParaListTool_ = class(_nevParaXTool_)
  {* ���������� ��� InevParaList }
 end;//_nevParaListTool_

{$Else nevParaListTool_imp}

{$IfNDef nevParaListTool_imp_impl}

{$Define nevParaListTool_imp_impl}

{$Include w:\common\components\gui\Garant\Everest\new\nevParaXTool.imp.pas}

{$EndIf nevParaListTool_imp_impl}

{$EndIf nevParaListTool_imp}

