unit l3LongintList;
 {* ������ ����� ����� }

// ������: "w:\common\components\rtl\Garant\L3\l3LongintList.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3LongintListPrim
;

type
 _ListType_ = Tl3LongintListPrim;
 _l3ListOperations_Parent_ = Tl3LongintListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3ListOperations.imp.pas}
 Tl3LongintList = class(_l3ListOperations_)
  {* ������ ����� ����� }
 end;//Tl3LongintList

implementation

uses
 l3ImplUses
 , l3Memory
;

{$Include w:\common\components\rtl\Garant\L3\l3ListOperations.imp.pas}

end.
