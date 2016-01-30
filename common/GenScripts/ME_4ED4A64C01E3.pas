unit evSBSColumnBorderMarker;

// Модуль: "w:\common\components\gui\Garant\Everest\evSBSColumnBorderMarker.pas"
// Стереотип: "SimpleClass"

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
 {$Include SBSColumnMarker.imp.pas}
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

{$Include SBSColumnMarker.imp.pas}
{$IfEnd} // Defined(evUseVisibleCursors)

end.
