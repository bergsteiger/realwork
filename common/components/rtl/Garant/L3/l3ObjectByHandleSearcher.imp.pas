{$IfNDef l3ObjectByHandleSearcher_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3ObjectByHandleSearcher.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::Garbage::l3ObjectByHandleSearcher
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3ObjectByHandleSearcher_imp}
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = _l3ObjectByHandleSearcher_Parent_;
 {$Include ..\L3\l3Searcher.imp.pas}
 _l3ObjectByHandleSearcher_ = {abstract mixin} class(_l3Searcher_)
 end;//_l3ObjectByHandleSearcher_

{$Else l3ObjectByHandleSearcher_imp}

// start class _l3ObjectByHandleSearcher_

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_4B8919220120_var*
//#UC END# *47B9BAFD01F4_4B8919220120_var*
begin
//#UC START# *47B9BAFD01F4_4B8919220120_impl*
 Assert(aSortIndex = l3_siNative);
 Result := anItem.Handle - aData;
//#UC END# *47B9BAFD01F4_4B8919220120_impl*
end;//CompareItemWithData


{$Include ..\L3\l3Searcher.imp.pas}


{$EndIf l3ObjectByHandleSearcher_imp}
