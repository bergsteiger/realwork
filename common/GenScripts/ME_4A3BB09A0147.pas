unit nevBreakParaAnchor;
 {* ����� ���������-������� }

// ������: "w:\common\components\gui\Garant\Everest\new\nevBreakParaAnchor.pas"
// ���������: "SimpleClass"

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
 {$Include w:\common\components\gui\Garant\Everest\nevBreakParaAnchorModify.imp.pas}
 TnevBreakParaAnchor = class(_nevBreakParaAnchorModify_)
  {* ����� ���������-������� }
 end;//TnevBreakParaAnchor
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
;

{$Include w:\common\components\gui\Garant\Everest\nevBreakParaAnchorModify.imp.pas}
{$IfEnd} // Defined(k2ForEditor)

end.
