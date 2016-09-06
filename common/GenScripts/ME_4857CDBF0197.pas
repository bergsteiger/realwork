unit evTableCell_InterfaceFactory;
 {* "фабрика интерфейсов" дл€ €чейки таблицы. }

// ћодуль: "w:\common\components\gui\Garant\Everest\evTableCell_InterfaceFactory.pas"
// —тереотип: "InterfaceFactory"
// Ёлемент модели: "TevTableCell" MUID: (4857CDBF0197)
// »м€ типа: "TevTableCellInterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evParaList_InterfaceFactory
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TevTableCellInterfaceFactory = class(TevParaListInterfaceFactory)
  {* "фабрика интерфейсов" дл€ €чейки таблицы. }
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevTableCellInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 , nevTools
 , nevGUIInterfaces
 , nevBase
 {$If Defined(evNeedPainters)}
 , evTableCellPainter
 {$IfEnd} // Defined(evNeedPainters)
 , nevTableCell
 {$If Defined(evNeedHotSpot)}
 , evTableCellHotSpot
 {$IfEnd} // Defined(evNeedHotSpot)
 , nevTableCellAnchor
 {$If Defined(evUseVisibleCursors)}
 , evTableCellCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evUseVisibleCursors)}
 , evTableCellCursorPair
 {$IfEnd} // Defined(evUseVisibleCursors)
 , TableCell_Const
 //#UC START# *4857CDBF0197impl_uses*
 //#UC END# *4857CDBF0197impl_uses*
;

function TevTableCellInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_4857CDBF0197_var*
//#UC END# *4D63D26D033F_4857CDBF0197_var*
begin
//#UC START# *4D63D26D033F_4857CDBF0197_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_4857CDBF0197_impl*
end;//TevTableCellInterfaceFactory.QueryTool

function TevTableCellInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4857CDBF0197_var*
//#UC END# *53CCBDA5026D_4857CDBF0197_var*
begin
//#UC START# *53CCBDA5026D_4857CDBF0197_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4857CDBF0197_impl*
end;//TevTableCellInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
