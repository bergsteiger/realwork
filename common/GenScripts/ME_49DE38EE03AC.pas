{$IfNDef nevAnchor_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevAnchor.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nevAnchor" MUID: (49DE38EE03AC)
// Имя типа: "_nevAnchor_"

{$Define nevAnchor_imp}

{$If Defined(k2ForEditor)}
 {$Include w:\common\components\gui\Garant\Everest\nevBasePoint.imp.pas}
 _nevParentPointFactoryEx_Parent_ = _nevBasePoint_;
 {$Include w:\common\components\gui\Garant\Everest\nevParentPointFactoryEx.imp.pas}
 _nevDiff_Parent_ = _nevParentPointFactoryEx_;
 {$Include w:\common\components\gui\Garant\Everest\nevDiff.imp.pas}
 _nevAnchor_ = class(_nevDiff_)
  {* Базовая реализация якорей }
 end;//_nevAnchor_

{$Else Defined(k2ForEditor)}

{$Include w:\common\components\gui\Garant\Everest\nevBasePoint.imp.pas}
_nevParentPointFactoryEx_Parent_ = _nevBasePoint_;
{$Include w:\common\components\gui\Garant\Everest\nevParentPointFactoryEx.imp.pas}
_nevDiff_Parent_ = _nevParentPointFactoryEx_;
{$Include w:\common\components\gui\Garant\Everest\nevDiff.imp.pas}
_nevAnchor_ = _nevDiff_;

{$IfEnd} // Defined(k2ForEditor)
{$Else nevAnchor_imp}

{$IfNDef nevAnchor_imp_impl}

{$Define nevAnchor_imp_impl}

{$If Defined(k2ForEditor)}
{$Include w:\common\components\gui\Garant\Everest\nevBasePoint.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevParentPointFactoryEx.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevDiff.imp.pas}
{$IfEnd} // Defined(k2ForEditor)

{$EndIf nevAnchor_imp_impl}

{$EndIf nevAnchor_imp}

