unit NOT_COMPLETED_k2TypedSimpleTagListPrim;

// Модуль: "w:\common\components\rtl\Garant\K2\NOT_COMPLETED_k2TypedSimpleTagListPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2TypedSimpleTagListPrim" MUID: (527D14900028)

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

 {$Define l3Items_NoSort}

type
 _k2SimpleTagListPrim_Parent_ = Tk2ListTag;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\K2\k2SimpleTagListPrim.imp.pas}
 Tk2TypedSimpleTagListPrim = class(_k2SimpleTagListPrim_)
  protected
   function ExpandSize(aTargetSize: Integer): Integer; override;
 end;//Tk2TypedSimpleTagListPrim

implementation

uses
 l3ImplUses
 , k2BaseTypes
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

type _Instance_R_ = Tk2TypedSimpleTagListPrim;

{$Include w:\common\components\rtl\Garant\K2\k2SimpleTagListPrim.imp.pas}

function Tk2TypedSimpleTagListPrim.ExpandSize(aTargetSize: Integer): Integer;
//#UC START# *47B975AF02ED_527D14900028_var*
//#UC END# *47B975AF02ED_527D14900028_var*
begin
//#UC START# *47B975AF02ED_527D14900028_impl*
 if aTargetSize = 0 then
  Result := Succ(Capacity)
 else
  Result := aTargetSize;
//#UC END# *47B975AF02ED_527D14900028_impl*
end;//Tk2TypedSimpleTagListPrim.ExpandSize

end.
