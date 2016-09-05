unit NOT_FINISHED_IniShop;

// Модуль: "w:\archi\source\projects\Archi\Main\NOT_FINISHED_IniShop.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "IniShop" MUID: (4E8309E100D5)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
;

type
 TIniRecord = {$IfDef XE4}record{$Else}object{$EndIf}
 end;//TIniRecord
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 //#UC START# *4E8309E100D5impl_uses*
 //#UC END# *4E8309E100D5impl_uses*
;
{$IfEnd} // Defined(AppClientSide)

end.
