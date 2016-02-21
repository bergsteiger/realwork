unit nevParaListAnchorModifyTypes;

// Модуль: "w:\common\components\gui\Garant\Everest\nevParaListAnchorModifyTypes.pas"
// Стереотип: "UtilityPack"

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
;
{$IfEnd} // Defined(evUseVisibleCursors)

end.
