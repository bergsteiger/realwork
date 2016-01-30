unit l3NodeList;
 {* ������ ����� ������. }

// ������: "w:\common\components\rtl\Garant\L3\l3NodeList.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3Tree_TLB
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Il3Node;
 _l3InterfaceRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefList.imp.pas}
 Tl3NodeList = class(_l3InterfaceRefList_)
  {* ������ ����� ������. }
 end;//Tl3NodeList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = Tl3NodeList;

{$Include l3InterfaceRefList.imp.pas}

end.
