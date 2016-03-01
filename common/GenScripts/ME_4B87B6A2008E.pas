unit evSubPanelSubArray;

// Модуль: "w:\common\components\gui\Garant\Everest\evSubPanelSubArray.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evSubPanelSubArrayPrim
 , l3Types
;

type
 _l3ObjectByHandleSearcher_Parent_ = TevSubPanelSubArrayPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectByHandleSearcher.imp.pas}
 TevSubPanelSubArray = class(_l3ObjectByHandleSearcher_)
 end;//TevSubPanelSubArray

implementation

uses
 l3ImplUses
 , evSubPanelSub
 , l3Memory
;

type _Instance_R_ = TevSubPanelSubArray;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectByHandleSearcher.imp.pas}

end.
