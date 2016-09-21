unit daUserIDList;

// Модуль: "w:\common\components\rtl\Garant\DA\daUserIDList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaUserIDList" MUID: (57E12B9702E6)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , daTypes
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TdaUserID;
 _l3AtomicList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3AtomicList.imp.pas}
 TdaUserIDList = class(_l3AtomicList_)
 end;//TdaUserIDList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57E12B9702E6impl_uses*
 //#UC END# *57E12B9702E6impl_uses*
;

type _Instance_R_ = TdaUserIDList;

{$Include w:\common\components\rtl\Garant\L3\l3AtomicList.imp.pas}

end.
