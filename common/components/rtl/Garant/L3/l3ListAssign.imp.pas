{$IfNDef l3ListAssign_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3ListAssign.imp.pas"
// Стереотип: "Impurity"

{$Define l3ListAssign_imp}

 _l3ListAssign_ = class(_l3ListAssign_Parent_)
  public
   procedure AssignList(const aList: _ListType_);
 end;//_l3ListAssign_

{$Else l3ListAssign_imp}

{$IfNDef l3ListAssign_imp_impl}

{$Define l3ListAssign_imp_impl}

procedure _l3ListAssign_.AssignList(const aList: _ListType_);
//#UC START# *47CEC8BA02E2_47CEC8860198_var*
var
 i   : Integer;
 l_C : Integer;
//#UC END# *47CEC8BA02E2_47CEC8860198_var*
begin
//#UC START# *47CEC8BA02E2_47CEC8860198_impl*
 Clear;
 if (aList = nil) then
  Exit;
 l_C := aList.Count;
 if (l_C > 0) then
 begin
  Capacity := l_C;
  for i := 0 to Pred(l_C) do
   Add(aList[i]);
 end;//l_C > 0
//#UC END# *47CEC8BA02E2_47CEC8860198_impl*
end;//_l3ListAssign_.AssignList

{$EndIf l3ListAssign_imp_impl}

{$EndIf l3ListAssign_imp}

