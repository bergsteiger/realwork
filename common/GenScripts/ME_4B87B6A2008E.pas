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
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectByHandleSearcher.imp.pas}
 TevSubPanelSubArray = class(_l3ObjectByHandleSearcher_)
 end;//TevSubPanelSubArray

implementation

uses
 l3ImplUses
 , evSubPanelSub
 , l3Memory
;

{$If not Declared(_ItemType_)}type _ItemType_ = TevSubPanelSub;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

type _Instance_R_ = TevSubPanelSubArray;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectByHandleSearcher.imp.pas}

end.
