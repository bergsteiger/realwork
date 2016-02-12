unit IafwStatusElementPtrList;

// ������: "w:\common\components\gui\Garant\AFW\implementation\IafwStatusElementPtrList.pas"
// ���������: "SimpleClass"

{$Include afwDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , afwInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IafwStatusElement;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TIafwStatusElementPtrList = class(_l3InterfacePtrList_)
 end;//TIafwStatusElementPtrList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

type _Instance_R_ = TIafwStatusElementPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.
