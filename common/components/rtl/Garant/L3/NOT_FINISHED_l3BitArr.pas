unit NOT_FINISHED_l3BitArr;

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3BitArr.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "l3BitArr" MUID: (47AC5ABE00B6)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
;

type
 Tl3PtrHash = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   f_MaskSize: Byte;
 end;//Tl3PtrHash

 Tl3PtrArray = {$IfDef XE4}record{$Else}object{$EndIf}
 end;//Tl3PtrArray

 Tl3OneBytePtrHash = {$IfDef XE4}record{$Else}object{$EndIf}
 end;//Tl3OneBytePtrHash

implementation

uses
 l3ImplUses
 , l3BoxMemoryManagerPrim
 //#UC START# *47AC5ABE00B6impl_uses*
 //#UC END# *47AC5ABE00B6impl_uses*
;

end.
