unit l3LongintList;
 {* ������ ����� ����� }

// ������: "w:\common\components\rtl\Garant\L3\l3LongintList.pas"
// ���������: "SimpleClass"
// ������� ������: "Tl3LongintList" MUID: (47BB29D40117)

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
 //#UC START# *47BB29D40117impl_uses*
 //#UC END# *47BB29D40117impl_uses*
;

{$Include w:\common\components\rtl\Garant\L3\l3ListOperations.imp.pas}

end.
