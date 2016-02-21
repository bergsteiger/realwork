unit k2TagList;

// Модуль: "w:\common\components\rtl\Garant\K2\k2TagList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2TagListPrim
 , l3Types
;

type
 _k2TagByIntegerSearcher_Parent_ = Tk2TagListPrim;
 {$Include w:\common\components\rtl\Garant\K2\k2TagByIntegerSearcher.imp.pas}
 Tk2TagList = class(_k2TagByIntegerSearcher_)
 end;//Tk2TagList

implementation

uses
 l3ImplUses
 , l3Base
 , l3Variant
 , l3Memory
;

{$If not Declared(_ItemType_)}type _ItemType_ = Tl3Variant;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

type _Instance_R_ = Tk2TagList;

{$Include w:\common\components\rtl\Garant\K2\k2TagByIntegerSearcher.imp.pas}

end.
