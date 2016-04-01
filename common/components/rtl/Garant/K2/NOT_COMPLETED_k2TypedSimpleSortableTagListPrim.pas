unit NOT_COMPLETED_k2TypedSimpleSortableTagListPrim;

// Модуль: "w:\common\components\rtl\Garant\K2\NOT_COMPLETED_k2TypedSimpleSortableTagListPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2TypedSimpleSortableTagListPrim" MUID: (527D1B86018D)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2ListTag
 , l3Variant
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_HasCustomSort}

type
 _k2SimpleTagListPrim_Parent_ = Tk2ListTag;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\K2\k2SimpleTagListPrim.imp.pas}
 Tk2TypedSimpleSortableTagListPrim = class(_k2SimpleTagListPrim_)
  protected
   function ExpandSize(aTargetSize: Integer): Integer; override;
 end;//Tk2TypedSimpleSortableTagListPrim

implementation

uses
 l3ImplUses
 , k2BaseTypes
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

type _Instance_R_ = Tk2TypedSimpleSortableTagListPrim;

{$Include w:\common\components\rtl\Garant\K2\k2SimpleTagListPrim.imp.pas}

function Tk2TypedSimpleSortableTagListPrim.ExpandSize(aTargetSize: Integer): Integer;
//#UC START# *47B975AF02ED_527D1B86018D_var*
//#UC END# *47B975AF02ED_527D1B86018D_var*
begin
//#UC START# *47B975AF02ED_527D1B86018D_impl*
 if aTargetSize = 0 then
  Result := Succ(Capacity)
 else
  Result := aTargetSize;
//#UC END# *47B975AF02ED_527D1B86018D_impl*
end;//Tk2TypedSimpleSortableTagListPrim.ExpandSize

end.
