unit InsConfigNotifyRecipientPtrList;
 {* ������ ���������� �� InsConfigNotifyRecipient }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Settings\InsConfigNotifyRecipientPtrList.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , bsInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InsConfigNotifyRecipient;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TInsConfigNotifyRecipientPtrList = class(_l3InterfacePtrList_)
  {* ������ ���������� �� InsConfigNotifyRecipient }
 end;//TInsConfigNotifyRecipientPtrList

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

type _Instance_R_ = TInsConfigNotifyRecipientPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.
