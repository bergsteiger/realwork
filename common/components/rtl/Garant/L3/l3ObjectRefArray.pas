unit l3ObjectRefArray;
 {* "�������� ������". ������, ������� ������������� ����������� ��� ���������� �������� �� �������� ��������� }

// ������: "w:\common\components\rtl\Garant\L3\l3ObjectRefArray.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObjectRefList
;

type
 _l3OpenArray_Parent_ = Tl3ProtoObjectRefList;
 {$Include l3OpenArray.imp.pas}
 Tl3ObjectRefArray = class(_l3OpenArray_)
  {* "�������� ������". ������, ������� ������������� ����������� ��� ���������� �������� �� �������� ��������� }
 end;//Tl3ObjectRefArray

implementation

uses
 l3ImplUses
 , l3Base
;

type _Instance_R_ = Tl3ObjectRefArray;

{$Include l3OpenArray.imp.pas}

end.
