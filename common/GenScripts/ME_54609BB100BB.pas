unit ncsExecutorFactoryList;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsExecutorFactoryList.pas"
// Стереотип: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , ncsMessageInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IncsMessageExecutorFactory;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TncsExecutorFactoryList = class(_l3InterfacePtrList_)
 end;//TncsExecutorFactoryList
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TncsExecutorFactoryList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
