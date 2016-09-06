unit l3PointerUtils;

// Модуль: "w:\common\components\rtl\Garant\L3\l3PointerUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "l3PointerUtils" MUID: (57CE8E0B0357)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
;

function l3ComparePointers(A: Pointer;
 B: Pointer): Integer;

implementation

uses
 l3ImplUses
 //#UC START# *57CE8E0B0357impl_uses*
 //#UC END# *57CE8E0B0357impl_uses*
;

function l3ComparePointers(A: Pointer;
 B: Pointer): Integer;
//#UC START# *57CE8E2403E7_57CE8E0B0357_var*
//#UC END# *57CE8E2403E7_57CE8E0B0357_var*
begin
//#UC START# *57CE8E2403E7_57CE8E0B0357_impl*
 Result := PChar(A) - PChar(B);
//#UC END# *57CE8E2403E7_57CE8E0B0357_impl*
end;//l3ComparePointers

end.
