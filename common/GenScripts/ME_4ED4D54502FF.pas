unit evSBSColumnHotSpot;

// ������: "w:\common\components\gui\Garant\Everest\evSBSColumnHotSpot.pas"
// ���������: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evTableColumnHotSpot
 , nevBase
;

type
 _SBSColumnMarker_Parent_ = TevTableColumnHotSpot;
 {$Include SBSColumnMarker.imp.pas}
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

{$Include SBSColumnMarker.imp.pas}
{$IfEnd} // Defined(evUseVisibleCursors)

end.
