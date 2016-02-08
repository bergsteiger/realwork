unit l3IDIndex;
 {* ������ ����� � ������������ ������ �� �������������� ��������������. }

// ������: "w:\common\components\rtl\Garant\L3\l3IDIndex.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3IDIndexPrim
 , l3Types
;

type
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = Tl3IDIndexPrim;
 {$Include l3Searcher.imp.pas}
 Tl3IDIndex = class(_l3Searcher_)
  {* ������ ����� � ������������ ������ �� �������������� ��������������. }
 end;//Tl3IDIndex

implementation

uses
 l3ImplUses
;

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* ���������� ������������ ������� � �������. }
//#UC START# *47B9BAFD01F4_47BAA0C70262_var*
//#UC END# *47B9BAFD01F4_47BAA0C70262_var*
begin
//#UC START# *47B9BAFD01F4_47BAA0C70262_impl*
 Assert(aSortIndex = l3_siNative);
 Result := anItem.StringID - aData;
//#UC END# *47B9BAFD01F4_47BAA0C70262_impl*
end;//CompareItemWithData

type _Instance_R_ = Tl3IDIndex;

{$Include l3Searcher.imp.pas}

end.
