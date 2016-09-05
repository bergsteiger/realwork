unit l3DataRefList;
 {* ������ ������ �� ����� ������. ��� ���� ������������ ����������� �������� ����� ������. ��� ������ ������ ���� �������� �������� l3System.GetLocalMem. }

// ������: "w:\common\components\rtl\Garant\L3\l3DataRefList.pas"
// ���������: "SimpleClass"
// ������� ������: "Tl3DataRefList" MUID: (4773DD0B02A3)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Pointer;
 _l3DataRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3DataRefList.imp.pas}
 Tl3DataRefList = class(_l3DataRefList_)
  {* ������ ������ �� ����� ������. ��� ���� ������������ ����������� �������� ����� ������. ��� ������ ������ ���� �������� �������� l3System.GetLocalMem. }
 end;//Tl3DataRefList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4773DD0B02A3impl_uses*
 //#UC END# *4773DD0B02A3impl_uses*
;

type _Instance_R_ = Tl3DataRefList;

{$Include w:\common\components\rtl\Garant\L3\l3DataRefList.imp.pas}

end.
