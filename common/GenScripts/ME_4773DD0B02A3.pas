unit l3DataRefList;
 {* ������ ������ �� ����� ������. ��� ���� ������������ ����������� �������� ����� ������. ��� ������ ������ ���� �������� �������� l3System.GetLocalMem. }

// ������: "w:\common\components\rtl\Garant\L3\l3DataRefList.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

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
;

type _Instance_R_ = Tl3DataRefList;

{$Include w:\common\components\rtl\Garant\L3\l3DataRefList.imp.pas}

end.
