unit nevBreakParaAnchor;
 {* якорь параграфа-разрыва }

// ћодуль: "w:\common\components\gui\Garant\Everest\new\nevBreakParaAnchor.pas"
// —тереотип: "SimpleClass"

{$Include nevDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevSolidParaAnchor
 , nevTools
;

type
 _nevBreakParaAnchorModify_Parent_ = TnevSolidParaAnchor;
 {$Include nevBreakParaAnchorModify.imp.pas}
 TnevBreakParaAnchor = class(_nevBreakParaAnchorModify_)
  {* якорь параграфа-разрыва }
 end;//TnevBreakParaAnchor
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
;

{$Include nevBreakParaAnchorModify.imp.pas}
{$IfEnd} // Defined(k2ForEditor)

end.
