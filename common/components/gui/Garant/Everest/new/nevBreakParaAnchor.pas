unit nevBreakParaAnchor;
 {* якорь параграфа-разрыва }

// ћодуль: "w:\common\components\gui\Garant\Everest\new\nevBreakParaAnchor.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TnevBreakParaAnchor" MUID: (4A3BB09A0147)

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevSolidParaAnchor
 , nevTools
;

type
 _nevBreakParaAnchorModify_Parent_ = TnevSolidParaAnchor;
 {$Include w:\common\components\gui\Garant\Everest\nevBreakParaAnchorModify.imp.pas}
 TnevBreakParaAnchor = class(_nevBreakParaAnchorModify_)
  {* якорь параграфа-разрыва }
 end;//TnevBreakParaAnchor
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 //#UC START# *4A3BB09A0147impl_uses*
 //#UC END# *4A3BB09A0147impl_uses*
;

{$Include w:\common\components\gui\Garant\Everest\nevBreakParaAnchorModify.imp.pas}
{$IfEnd} // Defined(k2ForEditor)

end.
