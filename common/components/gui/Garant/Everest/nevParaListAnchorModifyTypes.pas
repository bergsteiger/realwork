unit nevParaListAnchorModifyTypes;

// Модуль: "w:\common\components\gui\Garant\Everest\nevParaListAnchorModifyTypes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nevParaListAnchorModifyTypes" MUID: (4D6E722D0214)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
;

type
 TnevChildrenInfo = record
  rLinear: Boolean;
  rLeafCount: Integer;
  rCountMinus1: Integer;
 end;//TnevChildrenInfo
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 //#UC START# *4D6E722D0214impl_uses*
 //#UC END# *4D6E722D0214impl_uses*
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
