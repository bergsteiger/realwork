library RenderEVD;
 {* ���������� ��� �������������� EVD-�������� � �������� }

// ������: "w:\common\components\RenderEVD\RenderEVD.dpr"
// ���������: "AdapterTarget"
// ������� ������: "RenderEVD" MUID: (474AD1C7020C)

{$Include w:\common\components\l3XE.inc}

interface

uses
 l3IntfUses
;

implementation

uses
 l3ImplUses
;

exports
//#UC START# *474AD1C7020Cexports*
  RenderFormulaPrim,
  RenderFormula,
  EVDtoRTF,
  EVDtoRTFWithoutCommentDecor,
  SetStyleTable
//#UC END# *474AD1C7020Cexports*
;

end.
