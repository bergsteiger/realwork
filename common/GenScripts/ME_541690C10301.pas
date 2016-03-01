unit ddFillAACStack;

// Модуль: "w:\common\components\rtl\Garant\dd\ddFillAACStack.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , ddTypes
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TddFillAAC;
 _l3EnumList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3EnumList.imp.pas}
 TddFillAACStack = class(_l3EnumList_)
  public
   procedure Push(aValue: TddFillAAC);
   function Pop: TddFillAAC;
   function Peek: TddFillAAC;
 end;//TddFillAACStack

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TddFillAACStack;

{$Include w:\common\components\rtl\Garant\L3\l3EnumList.imp.pas}

procedure TddFillAACStack.Push(aValue: TddFillAAC);
//#UC START# *5416925A01A0_541690C10301_var*
//#UC END# *5416925A01A0_541690C10301_var*
begin
//#UC START# *5416925A01A0_541690C10301_impl*
 Add(aValue);
//#UC END# *5416925A01A0_541690C10301_impl*
end;//TddFillAACStack.Push

function TddFillAACStack.Pop: TddFillAAC;
//#UC START# *54169293003D_541690C10301_var*
//#UC END# *54169293003D_541690C10301_var*
begin
//#UC START# *54169293003D_541690C10301_impl*
 Result := Peek;
 DeleteLast;
//#UC END# *54169293003D_541690C10301_impl*
end;//TddFillAACStack.Pop

function TddFillAACStack.Peek: TddFillAAC;
//#UC START# *541694B502B2_541690C10301_var*
//#UC END# *541694B502B2_541690C10301_var*
begin
//#UC START# *541694B502B2_541690C10301_impl*
 Assert(Count > 0);
 Result := TddFillAAC(Last);
//#UC END# *541694B502B2_541690C10301_impl*
end;//TddFillAACStack.Peek

end.
