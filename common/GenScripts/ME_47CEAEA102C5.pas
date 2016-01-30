unit evQueryCardConst;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evQueryCardConst.pas"
// Стереотип: "Interfaces"

{$Include evDefine.inc}

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
  {* Массив индексов иконки состояния для сворачиваемой панели (свернуто, развернуто). }

implementation

uses
 l3ImplUses
;

end.
