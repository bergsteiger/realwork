unit nsDocumentStreamList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\ExternalObjects\nsDocumentStreamList.pas"
// Стереотип: "SimpleClass"

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
 _ItemType_ = IbsDocumentStreamWrapper;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefList.imp.pas}
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

{$Include l3InterfaceRefList.imp.pas}

end.
