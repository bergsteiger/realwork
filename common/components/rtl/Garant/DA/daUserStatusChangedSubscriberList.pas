unit daUserStatusChangedSubscriberList;

// Модуль: "w:\common\components\rtl\Garant\DA\daUserStatusChangedSubscriberList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaUserStatusChangedSubscriberList" MUID: (573983CB019E)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , daInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IdaUserStatusChangedSubscriber;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TdaUserStatusChangedSubscriberList = class(_l3InterfacePtrList_)
 end;//TdaUserStatusChangedSubscriberList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *573983CB019Eimpl_uses*
 //#UC END# *573983CB019Eimpl_uses*
;

type _Instance_R_ = TdaUserStatusChangedSubscriberList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.
