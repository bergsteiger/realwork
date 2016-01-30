unit evReqRowPainter;

// Модуль: "w:\common\components\gui\Garant\Everest\evReqRowPainter.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , evTableRowPainter
;

type
 TevReqRowPainter = class(TevTableRowPainter)
 end;//TevReqRowPainter
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(evNeedPainters)

end.
