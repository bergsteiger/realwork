unit l3MouseListenersList;

// ������: "w:\common\components\rtl\Garant\L3\l3MouseListenersList.pas"
// ���������: "SimpleClass"
// ������� ������: "Tl3MouseListenersList" MUID: (4F7420740306)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Interfaces
 , l3Memory
 , l3Types
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Il3MouseListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 Tl3MouseListenersList = class(_l3InterfacePtrList_)
 end;//Tl3MouseListenersList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4F7420740306impl_uses*
 //#UC END# *4F7420740306impl_uses*
;

type _Instance_R_ = Tl3MouseListenersList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.
