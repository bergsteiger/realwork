unit evMultiSelection;

interface

uses
 l3IntfUses
 , nevSelection
 , nevRangeList
 , nevTools
 , l3Variant
 , evTypes
;

type
 TevMultiSelection = class(TnevSelection)
  function MakeSelectionCopy(aSelection: TnevRangeList): TnevRangeList;
  procedure CheckSelectedList;
  procedure SelectionStart(aNeedUnselect: Boolean);
  procedure SelectionProcess(const aStart: InevPoint;
   const aFinish: InevPoint);
  procedure SelectionFinish(const aStart: InevPoint;
   const aFinish: InevPoint;
   var aNeedUnselect: Boolean);
  procedure DoAssignSelByRecursion(const aView: InevView;
   const aSource: InevRange);
   {* Рекурсивно разобрать выделение на мультиблоки }
 end;//TevMultiSelection
 
implementation

uses
 l3ImplUses
 , l3Base
 , evMultiSelectionBlock
 , l3Types
 , l3MinMax
 , evMsgCode
 , nevRangeListTools
 , nevFacade
 , evTableCellUtils
;

end.
