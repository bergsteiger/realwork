unit k2SimpleTagList;

// Модуль: "w:\common\components\rtl\Garant\K2\k2SimpleTagList.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , l3DataContainerWithoutIUnknownPrim
 , k2TagList
 , l3Variant
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_NoSort}

type
 _k2SimpleTagListPrim_Parent_ = Tl3DataContainerWithoutIUnknownPrim;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\K2\k2SimpleTagListPrim.imp.pas}
 Tk2SimpleTagList = class(_k2SimpleTagListPrim_)
  public
   procedure JoinWith(anOther: Tk2TagList); overload;
 end;//Tk2SimpleTagList

implementation

uses
 l3ImplUses
 , k2BaseTypes
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
 , l3IID
 , l3InterfacesMisc
;

type _Instance_R_ = Tk2SimpleTagList;

{$Include w:\common\components\rtl\Garant\K2\k2SimpleTagListPrim.imp.pas}

procedure Tk2SimpleTagList.JoinWith(anOther: Tk2TagList);
//#UC START# *5319D72D03D1_5319CECC039A_var*
var
 i   : Integer;
 l_C : Integer;
//#UC END# *5319D72D03D1_5319CECC039A_var*
begin
//#UC START# *5319D72D03D1_5319CECC039A_impl*
 l_C := anOther.Count;
 if (l_C > 0) then
 begin
  Capacity := Count + l_C;
  for i := 0 to Pred(l_C) do
   Add(anOther.ItemSlot(i)^);
 end;//l_C > 0
//#UC END# *5319D72D03D1_5319CECC039A_impl*
end;//Tk2SimpleTagList.JoinWith

end.
