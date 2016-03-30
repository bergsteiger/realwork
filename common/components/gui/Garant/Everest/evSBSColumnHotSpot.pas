unit evSBSColumnHotSpot;

// Модуль: "w:\common\components\gui\Garant\Everest\evSBSColumnHotSpot.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevSBSColumnHotSpot" MUID: (4ED4D54502FF)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evTableColumnHotSpot
 , nevBase
;

type
 _SBSColumnMarker_Parent_ = TevTableColumnHotSpot;
 {$Include w:\common\components\gui\Garant\Everest\SBSColumnMarker.imp.pas}
 TevSBSColumnHotSpot = class(_SBSColumnMarker_)
 end;//TevSBSColumnHotSpot
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , k2Except
;

type _Instance_R_ = TevSBSColumnHotSpot;

{$Include w:\common\components\gui\Garant\Everest\SBSColumnMarker.imp.pas}
{$IfEnd} // Defined(evUseVisibleCursors)

end.
