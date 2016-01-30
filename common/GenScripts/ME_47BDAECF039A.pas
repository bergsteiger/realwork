unit l3ObjectWithHandleRefList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ObjectWithHandleRefList.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ObjectWithHandleRefListPrim
 , l3Types
;

type
 _l3ObjectByHandleSearcher_Parent_ = Tl3ObjectWithHandleRefListPrim;
 {$Include l3ObjectByHandleSearcher.imp.pas}
 Tl3ObjectWithHandleRefList = class(_l3ObjectByHandleSearcher_)
 end;//Tl3ObjectWithHandleRefList

implementation

uses
 l3ImplUses
;

type _Instance_R_ = Tl3ObjectWithHandleRefList;

{$Include l3ObjectByHandleSearcher.imp.pas}

end.
