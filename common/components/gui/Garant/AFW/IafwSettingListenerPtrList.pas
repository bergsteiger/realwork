unit IafwSettingListenerPtrList;
 {* ������ ���������� �� IafwSettingListener }

// ������: "w:\common\components\gui\Garant\AFW\IafwSettingListenerPtrList.pas"
// ���������: "SimpleClass"
// ������� ������: "TIafwSettingListenerPtrList" MUID: (49143FC20016)

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

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
 _ItemType_ = IafwSettingListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TIafwSettingListenerPtrList = class(_l3InterfacePtrList_)
  {* ������ ���������� �� IafwSettingListener }
 end;//TIafwSettingListenerPtrList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *49143FC20016impl_uses*
 //#UC END# *49143FC20016impl_uses*
;

type _Instance_R_ = TIafwSettingListenerPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.
