unit nevBitmapParaAnchor;
 {* ����� ���������-������� }

// ������: "w:\common\components\gui\Garant\Everest\new\nevBitmapParaAnchor.pas"
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
 //#UC START# *4A3BB0550026impl_uses*
 //#UC END# *4A3BB0550026impl_uses*
;
{$IfEnd} // Defined(k2ForEditor)

end.
