unit evSBSColumnBorderMarker;

// Модуль: "w:\common\components\gui\Garant\Everest\evSBSColumnBorderMarker.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevSBSColumnBorderMarker" MUID: (4ED4A64C01E3)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

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
