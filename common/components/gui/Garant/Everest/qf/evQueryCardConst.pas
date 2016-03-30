unit evQueryCardConst;

// ћодуль: "w:\common\components\gui\Garant\Everest\qf\evQueryCardConst.pas"
// —тереотип: "Interfaces"
// Ёлемент модели: "evQueryCardConst" MUID: (47CEAEA102C5)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
;

const
 csLogicBTN = 'SelectBTN';
 csAddBTN = 'AddBTN';
 csDeleteBTN = 'DeleteBTN';
 cMinusKeyCode = 189;
 cPlusKeyCode = 188;
 ImgIndexArr: array [Boolean] of Integer = (114, 113);
  {* ћассив индексов иконки состо€ни€ дл€ сворачиваемой панели (свернуто, развернуто). }

implementation

uses
 l3ImplUses
;

end.
