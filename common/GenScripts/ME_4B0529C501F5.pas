unit IafwMenuUnlockedPostBuildPtrList;

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\IafwMenuUnlockedPostBuildPtrList.pas"
// Стереотип: "SimpleClass"

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
 _ItemType_ = IafwMenuUnlockedPostBuild;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfacePtrList.imp.pas}
 TIafwMenuUnlockedPostBuildPtrList = class(_l3InterfacePtrList_)
 end;//TIafwMenuUnlockedPostBuildPtrList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TIafwMenuUnlockedPostBuildPtrList;

{$Include l3InterfacePtrList.imp.pas}

end.
