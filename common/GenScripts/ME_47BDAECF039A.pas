unit l3ObjectWithHandleRefList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ObjectWithHandleRefList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ObjectWithHandleRefListPrim
 , l3Types
;

type
 _l3ObjectByHandleSearcher_Parent_ = Tl3ObjectWithHandleRefListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectByHandleSearcher.imp.pas}
 Tl3ObjectWithHandleRefList = class(_l3ObjectByHandleSearcher_)
 end;//Tl3ObjectWithHandleRefList

implementation

uses
 l3ImplUses
 , l3ProtoObjectWithHandle
 , l3Memory
;

{$If not Declared(_ItemType_)}type _ItemType_ = Tl3ProtoObjectWithHandle;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

type _Instance_R_ = Tl3ObjectWithHandleRefList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectByHandleSearcher.imp.pas}

end.
