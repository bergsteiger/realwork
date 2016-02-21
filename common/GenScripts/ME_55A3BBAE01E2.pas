unit nsDeferredTreeList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsDeferredTreeList.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 {$If NOT Defined(Monitorings)}
 , FoldersDomainInterfaces
 {$IfEnd} // NOT Defined(Monitorings)
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InsDeferredTree;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnsDeferredTreeList = class(_l3InterfaceRefList_)
 end;//TnsDeferredTreeList
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TnsDeferredTreeList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
{$IfEnd} // NOT Defined(Admin)

end.
