unit NOT_COMPLETED_nevBitmapParaAnchor;
 {* ����� ���������-������� }

// ������: "w:\common\components\gui\Garant\Everest\new\NOT_COMPLETED_nevBitmapParaAnchor.pas"
// ���������: "SimpleClass"
// ������� ������: "TnevBitmapParaAnchor" MUID: (4A3BB0550026)

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
