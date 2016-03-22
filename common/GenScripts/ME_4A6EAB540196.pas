{$IfNDef AbstactChatWindowList_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Chat\AbstactChatWindowList.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "AbstactChatWindowList" MUID: (4A6EAB540196)
// Имя типа: "_AbstactChatWindowList_"

{$Define AbstactChatWindowList_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _FindDataType_ = TbsUserID;
 _l3Searcher_Parent_ = _AbstactChatWindowList_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 _AbstactChatWindowList_ = class(_l3Searcher_)
  public
   function FindChatWindow(const anUserID: _FindDataType_): _ItemType_;
 end;//_AbstactChatWindowList_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_l3Searcher_Parent_ = _AbstactChatWindowList_Parent_;
{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
_AbstactChatWindowList_ = _l3Searcher_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else AbstactChatWindowList_imp}

{$IfNDef AbstactChatWindowList_imp_impl}

{$Define AbstactChatWindowList_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_4A6EAB540196_var*
//#UC END# *47B9BAFD01F4_4A6EAB540196_var*
begin
//#UC START# *47B9BAFD01F4_4A6EAB540196_impl*
 Assert(aSortIndex = l3_siNative);
 Result := Integer(anItem.UserID) - Integer(aData);
//#UC END# *47B9BAFD01F4_4A6EAB540196_impl*
end;//CompareItemWithData

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

function _AbstactChatWindowList_.FindChatWindow(const anUserID: _FindDataType_): _ItemType_;
//#UC START# *4A6EAC0F00A9_4A6EAB540196_var*
var
 l_IDX: Integer;
//#UC END# *4A6EAC0F00A9_4A6EAB540196_var*
begin
//#UC START# *4A6EAC0F00A9_4A6EAB540196_impl*
 if FindData(anUserID, l_IDX) then
  Result := Items[l_IDX]
 else
  Result := nil;
//#UC END# *4A6EAC0F00A9_4A6EAB540196_impl*
end;//_AbstactChatWindowList_.FindChatWindow
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf AbstactChatWindowList_imp_impl}

{$EndIf AbstactChatWindowList_imp}

