unit vgAnyObjectList;
 {* ������� ���������� �� ������. ������ �� ����������� }

// ������: "w:\common\components\rtl\external\VGScene\vgAnyObjectList.pas"
// ���������: "SimpleClass"
// ������� ������: "TvgAnyObjectList" MUID: (4D52D82E0312)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

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
 //#UC START# *4D52D82E0312impl_uses*
 //#UC END# *4D52D82E0312impl_uses*
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
