unit evSCSubList;

// ������: "w:\common\components\gui\Garant\Everest\evSCSubList.pas"
// ���������: "SimpleClass"
// ������� ������: "TevSCSubList" MUID: (56558873036B)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , evSubCompareInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IevSCSub;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TevSCSubList = class(_l3InterfaceRefList_)
 end;//TevSCSubList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *56558873036Bimpl_uses*
 //#UC END# *56558873036Bimpl_uses*
;

type _Instance_R_ = TevSCSubList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.
