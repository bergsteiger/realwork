unit l3RecListWithPartialFind;

// ������: "w:\common\components\rtl\Garant\L3\l3RecListWithPartialFind.pas"
// ���������: "SimpleClass"
// ������� ������: "Tl3RecListWithPartialFind" MUID: (47BC6C30022F)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoPtrRecListPrim
 , l3Types
;

type
 Tl3DataAndSize = record
  rData: Pointer;
  rSize: Cardinal;
 end;//Tl3DataAndSize

 _FindDataType_ = Tl3DataAndSize;
 _l3Searcher_Parent_ = Tl3ProtoPtrRecListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 Tl3RecListWithPartialFind = class(_l3Searcher_)
  public
   function FindPart(const aData;
    aDataSize: Cardinal;
    out theIndex: Integer): Boolean;
    {* ����� �� ������ ������, ������ ������������ ������ � aDataSize }
 end;//Tl3RecListWithPartialFind

implementation

uses
 l3ImplUses
 , l3Memory
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* ���������� ������������ ������� � �������. }
//#UC START# *47B9BAFD01F4_47BC6C30022F_var*
//#UC END# *47B9BAFD01F4_47BC6C30022F_var*
begin
//#UC START# *47B9BAFD01F4_47BC6C30022F_impl*
 Assert(aSortIndex = l3_siNative);
 Result := Tl3RecListWithPartialFind(aList).DoCompare(anItem, aData.rData^, aData.rSize);
//#UC END# *47B9BAFD01F4_47BC6C30022F_impl*
end;//CompareItemWithData

type _Instance_R_ = Tl3RecListWithPartialFind;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

function Tl3RecListWithPartialFind.FindPart(const aData;
 aDataSize: Cardinal;
 out theIndex: Integer): Boolean;
 {* ����� �� ������ ������, ������ ������������ ������ � aDataSize }
//#UC START# *47BF0AB902EB_47BC6C30022F_var*
var
 l_DS : Tl3DataAndSize;                                       
//#UC END# *47BF0AB902EB_47BC6C30022F_var*
begin
//#UC START# *47BF0AB902EB_47BC6C30022F_impl*
 l_DS.rData := @aData;
 l_DS.rSize := aDataSize;
 Result := FindData(l_DS, theIndex);
//#UC END# *47BF0AB902EB_47BC6C30022F_impl*
end;//Tl3RecListWithPartialFind.FindPart

end.
