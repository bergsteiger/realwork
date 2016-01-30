unit InsContextSearchHistoryNotifierList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\rtl\Garant\ContextHistory\InsContextSearchHistoryNotifierList.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3SimpleDataContainer
 , ContextHistoryInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InsContextSearchHistoryNotifier;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfacePtrList.imp.pas}
 TInsContextSearchHistoryNotifierList = class(_l3InterfacePtrList_)
 end;//TInsContextSearchHistoryNotifierList
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

type _Instance_R_ = TInsContextSearchHistoryNotifierList;

{$Include l3InterfacePtrList.imp.pas}
{$IfEnd} // NOT Defined(Admin)

end.
