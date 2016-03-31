unit nsDocumentStreamList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\ExternalObjects\nsDocumentStreamList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsDocumentStreamList" MUID: (55A387E502D7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 _ItemType_ = IbsDocumentStreamWrapper;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnsDocumentStreamList = class(_l3InterfaceRefList_)
 end;//TnsDocumentStreamList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TnsDocumentStreamList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.
