{$IfNDef CellsCountStack_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\CellsCountStack.imp.pas"
// Стереотип: "Impurity"

{$Define CellsCountStack_imp}

 _CellsCountStack_ = class(_CellsCountStack_Parent_)
  private
   f_CellsCountStack: Tl3ProtoIntegerList;
  private
   function GetCellsCountStack: Tl3ProtoIntegerList;
  protected
   procedure FreeCellsCountStack;
   procedure PopCellsCount;
   procedure PushCellsCount;
   function GetTopValue: Integer;
   procedure IncTopValue;
 end;//_CellsCountStack_

{$Else CellsCountStack_imp}

{$IfNDef CellsCountStack_imp_impl}

{$Define CellsCountStack_imp_impl}

procedure _CellsCountStack_.FreeCellsCountStack;
//#UC START# *51483C6A0347_5148407D0202_var*
//#UC END# *51483C6A0347_5148407D0202_var*
begin
//#UC START# *51483C6A0347_5148407D0202_impl*
 FreeAndNil(f_CellsCountStack);
//#UC END# *51483C6A0347_5148407D0202_impl*
end;//_CellsCountStack_.FreeCellsCountStack

function _CellsCountStack_.GetCellsCountStack: Tl3ProtoIntegerList;
//#UC START# *51483B7A0158_5148407D0202_var*
//#UC END# *51483B7A0158_5148407D0202_var*
begin
//#UC START# *51483B7A0158_5148407D0202_impl*
 if (f_CellsCountStack = nil) then
  f_CellsCountStack := Tl3ProtoIntegerList.Make;
 Result := f_CellsCountStack; 
//#UC END# *51483B7A0158_5148407D0202_impl*
end;//_CellsCountStack_.GetCellsCountStack

procedure _CellsCountStack_.PopCellsCount;
//#UC START# *51483C160353_5148407D0202_var*
//#UC END# *51483C160353_5148407D0202_var*
begin
//#UC START# *51483C160353_5148407D0202_impl*
 //{Result := }f_CellsCountStack.Remove(f_CellsCountStack.Count - 1);
 f_CellsCountStack.Delete(f_CellsCountStack.Count - 1);
//#UC END# *51483C160353_5148407D0202_impl*
end;//_CellsCountStack_.PopCellsCount

procedure _CellsCountStack_.PushCellsCount;
//#UC START# *51483BDF0336_5148407D0202_var*
//#UC END# *51483BDF0336_5148407D0202_var*
begin
//#UC START# *51483BDF0336_5148407D0202_impl*
 GetCellsCountStack.Add(0);
//#UC END# *51483BDF0336_5148407D0202_impl*
end;//_CellsCountStack_.PushCellsCount

function _CellsCountStack_.GetTopValue: Integer;
//#UC START# *514842C00318_5148407D0202_var*
//#UC END# *514842C00318_5148407D0202_var*
begin
//#UC START# *514842C00318_5148407D0202_impl*
 Result := f_CellsCountStack.Last;
//#UC END# *514842C00318_5148407D0202_impl*
end;//_CellsCountStack_.GetTopValue

procedure _CellsCountStack_.IncTopValue;
//#UC START# *5148447D01B1_5148407D0202_var*
//#UC END# *5148447D01B1_5148407D0202_var*
begin
//#UC START# *5148447D01B1_5148407D0202_impl*
 f_CellsCountStack[f_CellsCountStack.Count - 1] := f_CellsCountStack[f_CellsCountStack.Count - 1] + 1;
//#UC END# *5148447D01B1_5148407D0202_impl*
end;//_CellsCountStack_.IncTopValue

{$EndIf CellsCountStack_imp_impl}

{$EndIf CellsCountStack_imp}

