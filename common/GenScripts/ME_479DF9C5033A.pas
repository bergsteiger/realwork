unit l3ProtoPtrRecListPrim;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProtoPtrRecListPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ProtoPtrRecListPrim" MUID: (479DF9C5033A)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3PureMixIns
 , l3Interfaces
 , l3Types
 , Classes
 , l3Except
;

 {$Define l3Items_NeedsBeforeFreeItem}

 {$Define l3Items_HasChanging}

 {$Define l3Items_IsProto}

type
 _DataType_ = Tl3Ptr;
 _l3Changing_Parent_ = Tl3ProtoDataContainer;
 {$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}
 _l3UntypedList_Parent_ = _l3Changing_;
 {$Include w:\common\components\rtl\Garant\L3\l3UntypedList.imp.pas}
 Tl3ProtoPtrRecListPrim = class(_l3UntypedList_)
 end;//Tl3ProtoPtrRecListPrim

implementation

uses
 l3ImplUses
 , SysUtils
 , RTLConsts
 , l3Base
 , l3MinMax
;

{$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}

type _Instance_R_ = Tl3ProtoPtrRecListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UntypedList.imp.pas}

end.
