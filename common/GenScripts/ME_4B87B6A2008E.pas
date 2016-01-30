unit evSubPanelSubArray;

// Модуль: "w:\common\components\gui\Garant\Everest\evSubPanelSubArray.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evSubPanelSubArrayPrim
 , l3Types
;

type
 _l3ObjectByHandleSearcher_Parent_ = TevSubPanelSubArrayPrim;
 {$Include l3ObjectByHandleSearcher.imp.pas}
 TevSubPanelSubArray = class(_l3ObjectByHandleSearcher_)
 end;//TevSubPanelSubArray

implementation

uses
 l3ImplUses
;

type _Instance_R_ = TevSubPanelSubArray;

{$Include l3ObjectByHandleSearcher.imp.pas}

end.
