{$IfNDef nevAnchor_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevAnchor.imp.pas"
// Стереотип: "Impurity"

{$Define nevAnchor_imp}

{$If Defined(k2ForEditor)}
 {$Include nevBasePoint.imp.pas}
 _nevParentPointFactoryEx_Parent_ = _nevBasePoint_;
 {$Include nevParentPointFactoryEx.imp.pas}
 _nevDiff_Parent_ = _nevParentPointFactoryEx_;
 {$Include nevDiff.imp.pas}
 _nevAnchor_ = class(_nevDiff_)
  {* Базовая реализация якорей }
 end;//_nevAnchor_

{$Else Defined(k2ForEditor)}

{$Include nevBasePoint.imp.pas}
_nevParentPointFactoryEx_Parent_ = _nevBasePoint_;
{$Include nevParentPointFactoryEx.imp.pas}
_nevDiff_Parent_ = _nevParentPointFactoryEx_;
{$Include nevDiff.imp.pas}
_nevAnchor_ = _nevDiff_;

{$IfEnd} // Defined(k2ForEditor)
{$Else nevAnchor_imp}

{$IfNDef nevAnchor_imp_impl}

{$Define nevAnchor_imp_impl}

{$If Defined(k2ForEditor)}
{$Include nevBasePoint.imp.pas}

{$Include nevParentPointFactoryEx.imp.pas}

{$Include nevDiff.imp.pas}
{$IfEnd} // Defined(k2ForEditor)

{$EndIf nevAnchor_imp_impl}

{$EndIf nevAnchor_imp}

