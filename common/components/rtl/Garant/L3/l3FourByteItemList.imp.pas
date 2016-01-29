{$IfNDef l3FourByteItemList_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3FourByteItemList.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3FourByteItemList
//
// ������ ��������� �������� � 4 �����.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3FourByteItemList_imp}
 _l3TypedList_Parent_ = _l3FourByteItemList_Parent_;
 {$Include ..\L3\l3TypedList.imp.pas}
 _l3FourByteItemList_ = {abstract mixin} class(_l3TypedList_)
  {* ������ ��������� �������� � 4 �����. }
 end;//_l3FourByteItemList_

{$Else l3FourByteItemList_imp}

// start class _l3FourByteItemList_

procedure DoExchange(var A: _ItemType_;
  var B: _ItemType_
  {$If defined(l3Items_FillItem_NeedsList)}
  ;
  anItems: _l3Items_
  {$IfEnd} //l3Items_FillItem_NeedsList
  );
//#UC START# *47B5C4080270_47B5C2EA02CB_var*
{$IfDef l3Items_IsAtomic}
var
 l_Tmp : _ItemType_;
{$Else  l3Items_IsAtomic}
var
 l_Tmp : Pointer;
{$EndIf l3Items_IsAtomic}
//#UC END# *47B5C4080270_47B5C2EA02CB_var*
begin
//#UC START# *47B5C4080270_47B5C2EA02CB_impl*
 {$IfDef l3Items_IsAtomic}
 l_Tmp := A;
 A := B;
 B := l_Tmp;
 {$Else  l3Items_IsAtomic}
 {$If (SizeOf(_ItemType_) <= 4)}
 l_Tmp := Pointer(A);
 Pointer(A) := Pointer(B);
 Pointer(B) := l_Tmp;
 {$Else}
 Assert(false);
 {$IfEnd}
 {$EndIf l3Items_IsAtomic}
//#UC END# *47B5C4080270_47B5C2EA02CB_impl*
end;//DoExchange


{$Include ..\L3\l3TypedList.imp.pas}


{$EndIf l3FourByteItemList_imp}
