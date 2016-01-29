unit nevSelection;

interface

uses
 l3IntfUses
 , evBlockCursor
 , nevTools
 , evTypes
 , l3Variant
;

type
 TnevSelection = class(TevBlockCursor)
  {* Курсор с выделением. Для конечного использования. }
  procedure DeleteFoundBlockBeforeSearch;
  procedure Select(aTarget: TevSelectTarget;
   const aCursor: InevPoint;
   Start: Boolean);
   {* выделить часть документа (выделить текущее слово, строку, параграф etc) }
 end;//TnevSelection
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 , evMsgCode
 , evSelectConst
;

end.
