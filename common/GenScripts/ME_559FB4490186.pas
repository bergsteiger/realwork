unit daFieldListPrim;

// Модуль: "w:\common\components\rtl\Garant\DA\daFieldListPrim.pas"
// Стереотип: "SimpleClass"

{$Include daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , daInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IdaField;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfacePtrList.imp.pas}
 TdaFieldListPrim = class(_l3InterfacePtrList_)
 end;//TdaFieldListPrim

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TdaFieldListPrim;

{$Include l3InterfacePtrList.imp.pas}

end.
