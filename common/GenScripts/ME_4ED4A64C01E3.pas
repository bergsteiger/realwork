unit evSBSColumnBorderMarker;

// ������: "w:\common\components\gui\Garant\Everest\evSBSColumnBorderMarker.pas"
// ���������: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evColumnBorderMarker
 , nevBase
;

type
 _SBSColumnMarker_Parent_ = TevColumnBorderMarker;
 {$Include w:\common\components\gui\Garant\Everest\SBSColumnMarker.imp.pas}
 TevSBSColumnBorderMarker = class(_SBSColumnMarker_)
 end;//TevSBSColumnBorderMarker
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , k2Except
;

type _Instance_R_ = TevSBSColumnBorderMarker;

{$Include w:\common\components\gui\Garant\Everest\SBSColumnMarker.imp.pas}
{$IfEnd} // Defined(evUseVisibleCursors)

end.
