unit nsBaseSearchClassList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsBaseSearchClassList.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , BaseSearchInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InsBaseSearchClass;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnsBaseSearchClassList = class(_l3InterfaceRefList_)
 end;//TnsBaseSearchClassList
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

type _Instance_R_ = TnsBaseSearchClassList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
