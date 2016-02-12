unit Il3ContextFilterParamsNotifierPtrList;
 {* Список УКАЗАТЕЛЕЙ на Il3ContextFilterParamsNotifier }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\Il3ContextFilterParamsNotifierPtrList.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3TreeInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Il3ContextFilterParamsNotifier;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TIl3ContextFilterParamsNotifierPtrList = class(_l3InterfacePtrList_)
  {* Список УКАЗАТЕЛЕЙ на Il3ContextFilterParamsNotifier }
 end;//TIl3ContextFilterParamsNotifierPtrList

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

type _Instance_R_ = TIl3ContextFilterParamsNotifierPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.
