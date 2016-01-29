{$IfNDef l3OtherTypedListView_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3OtherTypedListView.imp.pas"
// �����: 08.06.2011 22:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::Containers::l3OtherTypedListView
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3OtherTypedListView_imp}
 {$Include ..\L3\l3OtherListView.imp.pas}
 _l3OtherTypedListView_ = {mixin} class(_l3OtherListView_)
 protected
 // property methods
   function pm_GetItems(anIndex: Integer): _ItemType_;
 public
 // public properties
   property Items[anIndex: Integer]: _ItemType_
     read pm_GetItems;
     default;
 end;//_l3OtherTypedListView_

{$Else l3OtherTypedListView_imp}

{$Include ..\L3\l3OtherListView.imp.pas}

// start class _l3OtherTypedListView_

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

{$EndIf l3OtherTypedListView_imp}
