unit l3ObjectWithHandleRefList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ObjectWithHandleRefList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ObjectWithHandleRefList" MUID: (47BDAECF039A)

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
 //#UC START# *47BDAECF039Aimpl_uses*
 //#UC END# *47BDAECF039Aimpl_uses*
;

type _Instance_R_ = Tl3ObjectWithHandleRefList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectByHandleSearcher.imp.pas}

end.
