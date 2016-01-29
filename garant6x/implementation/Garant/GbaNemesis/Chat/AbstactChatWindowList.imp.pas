{$IfNDef AbstactChatWindowList_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Chat"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Chat/AbstactChatWindowList.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Встроенные продукты::Chat::Chat::ChatImpl::AbstactChatWindowList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define AbstactChatWindowList_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _FindDataType_ = TbsUserID;
 _l3Searcher_Parent_ = _AbstactChatWindowList_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 _AbstactChatWindowList_ = {mixin} class(_l3Searcher_)
 public
 // public methods
   function FindChatWindow(const anUserID: _FindDataType_): _ItemType_;
 end;//_AbstactChatWindowList_
{$Else}

 _l3Searcher_Parent_ = _AbstactChatWindowList_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 _AbstactChatWindowList_ = _l3Searcher_;

{$IfEnd} //not Admin AND not Monitorings

{$Else AbstactChatWindowList_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _AbstactChatWindowList_

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_4A6EAB540196_var*
//#UC END# *47B9BAFD01F4_4A6EAB540196_var*
begin
//#UC START# *47B9BAFD01F4_4A6EAB540196_impl*
 Assert(aSortIndex = l3_siNative);
 Result := Integer(anItem.UserID) - Integer(aData);
//#UC END# *47B9BAFD01F4_4A6EAB540196_impl*
end;//CompareItemWithData


{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

// start class _AbstactChatWindowList_

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

{$IfEnd} //not Admin AND not Monitorings

{$EndIf AbstactChatWindowList_imp}
