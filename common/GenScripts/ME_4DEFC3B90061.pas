{$IfNDef l3OtherTypedListView_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3OtherTypedListView.imp.pas"
// Стереотип: "Impurity"

{$Define l3OtherTypedListView_imp}

 {$Include l3OtherListView.imp.pas}
 _l3OtherTypedListView_ = class(_l3OtherListView_)
  protected
   function pm_GetItems(anIndex: Integer): _ItemType_;
  public
   property Items[anIndex: Integer]: _ItemType_
    read pm_GetItems;
    default;
 end;//_l3OtherTypedListView_

{$Else l3OtherTypedListView_imp}

{$IfNDef l3OtherTypedListView_imp_impl}

{$Define l3OtherTypedListView_imp_impl}

{$Include l3OtherListView.imp.pas}

function _l3OtherTypedListView_.pm_GetItems(anIndex: Integer): _ItemType_;
//#UC START# *4DEFC3FF0116_4DEFC3B90061get_var*
//#UC END# *4DEFC3FF0116_4DEFC3B90061get_var*
begin
//#UC START# *4DEFC3FF0116_4DEFC3B90061get_impl*
 {$IfDef l3ViewListIsTag}
 Result := f_List.Child[f_Sorter[anIndex]];
 {$Else  l3ViewListIsTag}
 Result := f_List[f_Sorter[anIndex]];
 {$EndIf l3ViewListIsTag}
//#UC END# *4DEFC3FF0116_4DEFC3B90061get_impl*
end;//_l3OtherTypedListView_.pm_GetItems

{$EndIf l3OtherTypedListView_imp_impl}

{$EndIf l3OtherTypedListView_imp}

