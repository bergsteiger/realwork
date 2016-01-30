unit nsUserIDList;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Chat\nsUserIDList.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleDataContainer
 , ChatTypes
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TbsUserID;
 _l3AtomicList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3AtomicList.imp.pas}
 TnsUserIDList = class(_l3AtomicList_)
 end;//TnsUserIDList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TnsUserIDList;

{$Include l3AtomicList.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
