unit afwDocumentPreviewList;

// ������: "w:\common\components\gui\Garant\AFW\implementation\afwDocumentPreviewList.pas"
// ���������: "SimpleClass"

{$Include afwDefine.inc}

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
 _ItemType_ = IafwDocumentPreview;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefList.imp.pas}
 TafwDocumentPreviewList = class(_l3InterfaceRefList_)
 end;//TafwDocumentPreviewList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TafwDocumentPreviewList;

{$Include l3InterfaceRefList.imp.pas}

end.
