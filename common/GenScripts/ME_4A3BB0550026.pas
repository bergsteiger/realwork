unit nevBitmapParaAnchor;
 {* ����� ���������-������� }

// ������: "w:\common\components\gui\Garant\Everest\new\nevBitmapParaAnchor.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevSolidParaAnchor
;

type
 TnevBitmapParaAnchor = class(TnevSolidParaAnchor)
  {* ����� ���������-������� }
 end;//TnevBitmapParaAnchor
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(k2ForEditor)

end.
