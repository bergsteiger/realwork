{$IfNDef nevPrimPoint_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\nevPrimPoint.imp.pas"
// Стереотип: "Impurity"

{$Define nevPrimPoint_imp}

{$If Defined(evUseVisibleCursors)}
 {$Include w:\common\components\gui\Garant\Everest\nevBasePoint.imp.pas}
 _nevParentPointFactoryExVOID_Parent_ = _nevBasePoint_;
 {$Include w:\common\components\gui\Garant\Everest\nevParentPointFactoryExVOID.imp.pas}
 _nevPrimPoint_ = class(_nevParentPointFactoryExVOID_)
  {* Примитивная точка }
 end;//_nevPrimPoint_

{$Else Defined(evUseVisibleCursors)}

{$Include w:\common\components\gui\Garant\Everest\nevBasePoint.imp.pas}
_nevParentPointFactoryExVOID_Parent_ = _nevBasePoint_;
{$Include w:\common\components\gui\Garant\Everest\nevParentPointFactoryExVOID.imp.pas}
_nevPrimPoint_ = _nevParentPointFactoryExVOID_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else nevPrimPoint_imp}

{$IfNDef nevPrimPoint_imp_impl}

{$Define nevPrimPoint_imp_impl}

{$If Defined(evUseVisibleCursors)}
{$Include w:\common\components\gui\Garant\Everest\nevBasePoint.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevParentPointFactoryExVOID.imp.pas}
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf nevPrimPoint_imp_impl}

{$EndIf nevPrimPoint_imp}

