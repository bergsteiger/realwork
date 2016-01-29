{$IfNDef l3OpenArray_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3OpenArray.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3OpenArray
//
// "�������� ������". ������, ������� ������������� ����������� ��� ���������� �������� �� ��������
// ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3OpenArray_imp}
 _l3OpenArray_ = {mixin} class(_l3OpenArray_Parent_)
  {* "�������� ������". ������, ������� ������������� ����������� ��� ���������� �������� �� �������� ��������� }
 protected
 // overridden protected methods
   function GetItem(Index: Integer): _ItemType_; override;
   procedure CheckSetItem(anIndex: Integer); override;
     {* ��������� ���������� ������� ��� �������. }
 end;//_l3OpenArray_

{$Else l3OpenArray_imp}

// start class _l3OpenArray_

function _l3OpenArray_.GetItem(Index: Integer): _ItemType_;
//#UC START# *47B1CCC901BE_4B86890E0307_var*
//#UC END# *47B1CCC901BE_4B86890E0307_var*
begin
//#UC START# *47B1CCC901BE_4B86890E0307_impl*
 if (Index >= Count) then
  l3FillChar(Result, SizeOf(Result))
 else
  Result := Inherited GetItem(Index);
//#UC END# *47B1CCC901BE_4B86890E0307_impl*
end;//_l3OpenArray_.GetItem

procedure _l3OpenArray_.CheckSetItem(anIndex: Integer);
//#UC START# *47B49FF70034_4B86890E0307_var*
//#UC END# *47B49FF70034_4B86890E0307_var*
begin
//#UC START# *47B49FF70034_4B86890E0307_impl*
 if (anIndex >= Count) then
  Count := Succ(anIndex)
 else
  inherited;
//#UC END# *47B49FF70034_4B86890E0307_impl*
end;//_l3OpenArray_.CheckSetItem

{$EndIf l3OpenArray_imp}
