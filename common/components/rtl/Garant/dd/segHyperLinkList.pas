unit segHyperLinkList;

// ������: "w:\common\components\rtl\Garant\dd\segHyperLinkList.pas"
// ���������: "SimpleClass"
// ������� ������: "TsegHyperLinkList" MUID: (55DC908902FC)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddNSRCSegments
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TsegHyperLink;
 _l3NotSortedObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3NotSortedObjectRefList.imp.pas}
 TsegHyperLinkList = class(_l3NotSortedObjectRefList_)
 end;//TsegHyperLinkList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *55DC908902FCimpl_uses*
 //#UC END# *55DC908902FCimpl_uses*
;

type _Instance_R_ = TsegHyperLinkList;

{$Include w:\common\components\rtl\Garant\L3\l3NotSortedObjectRefList.imp.pas}

end.
