unit evTable_InterfaceFactory;
 {* "фабрика интерфейсов" для таблицы. }

// Модуль: "w:\common\components\gui\Garant\Everest\evTable_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevTable" MUID: (4857E163036B)
// Имя типа: "TevTableInterfaceFactory"

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
 TevTableInterfaceFactory = class(TevParaListInterfaceFactory)
  {* "фабрика интерфейсов" для таблицы. }
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevTableInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 , nevTools
 , nevGUIInterfaces
 , evInternalInterfaces
 , nevBase
 {$If Defined(evNeedPainters)}
 , evTablePainter
 {$IfEnd} // Defined(evNeedPainters)
 {$If Defined(evUseVisibleCursors)}
 , evTableCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evUseVisibleCursors)}
 , evTableCursorPair
 {$IfEnd} // Defined(evUseVisibleCursors)
 , nevTable
 , nevTableAnchor
 {$If Defined(evNeedHotSpot)}
 , evTableHotSpot
 {$IfEnd} // Defined(evNeedHotSpot)
 {$If Defined(evNeedHotSpot)}
 , nevTableIevChangeParamToolMapper
 {$IfEnd} // Defined(evNeedHotSpot)
;

function TevTableInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_4857E163036B_var*
//#UC END# *4D63D26D033F_4857E163036B_var*
begin
//#UC START# *4D63D26D033F_4857E163036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_4857E163036B_impl*
end;//TevTableInterfaceFactory.QueryTool

function TevTableInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4857E163036B_var*
//#UC END# *53CCBDA5026D_4857E163036B_var*
begin
//#UC START# *53CCBDA5026D_4857E163036B_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4857E163036B_impl*
end;//TevTableInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
