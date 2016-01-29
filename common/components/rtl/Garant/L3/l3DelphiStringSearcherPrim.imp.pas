{$IfNDef l3DelphiStringSearcherPrim_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3DelphiStringSearcherPrim.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3DelphiStringSearcherPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3DelphiStringSearcherPrim_imp}
 _FindDataType_ = AnsiString;
 _l3Searcher_Parent_ = _l3DelphiStringSearcherPrim_Parent_;
 {$Include ..\L3\l3Searcher.imp.pas}
 _l3DelphiStringSearcherPrim_ = {abstract mixin} class(_l3Searcher_)
 end;//_l3DelphiStringSearcherPrim_

{$Else l3DelphiStringSearcherPrim_imp}

// start class _l3DelphiStringSearcherPrim_

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_4B891136016F_var*
//#UC END# *47B9BAFD01F4_4B891136016F_var*
begin
//#UC START# *47B9BAFD01F4_4B891136016F_impl*
 Result := l3Compare(ItemToWStr(anItem), aData, aSortIndex);
//#UC END# *47B9BAFD01F4_4B891136016F_impl*
end;//CompareItemWithData


{$Include ..\L3\l3Searcher.imp.pas}


{$EndIf l3DelphiStringSearcherPrim_imp}
