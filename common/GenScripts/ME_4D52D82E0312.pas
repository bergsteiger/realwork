unit vgAnyObjectList;
 {* ������� ���������� �� ������. ������ �� ����������� }

// ������: "w:\common\components\rtl\external\VGScene\vgAnyObjectList.pas"
// ���������: "SimpleClass"

{$Include vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , l3ObjectList
;

type
 TvgAnyObjectList = class(Tl3ObjectList)
  {* ������� ���������� �� ������. ������ �� ����������� }
 end;//TvgAnyObjectList
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
