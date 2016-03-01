unit l3ProtoPersistentWithHandleRefList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProtoPersistentWithHandleRefList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoPersistentWithHandleRefListPrim
 , l3Types
;

type
 _l3ObjectByHandleSearcher_Parent_ = Tl3ProtoPersistentWithHandleRefListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectByHandleSearcher.imp.pas}
 Tl3ProtoPersistentWithHandleRefList = class(_l3ObjectByHandleSearcher_)
 end;//Tl3ProtoPersistentWithHandleRefList

implementation

uses
 l3ImplUses
 , l3ProtoPersistentWithHandle
 , l3Memory
;

type _Instance_R_ = Tl3ProtoPersistentWithHandleRefList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectByHandleSearcher.imp.pas}

end.
