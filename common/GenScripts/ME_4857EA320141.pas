unit evReqCell_InterfaceFactory;

// Модуль: "w:\common\components\gui\Garant\Everest\evReqCell_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevReqCell" MUID: (4857EA320141)
// Имя типа: "TevReqCellInterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evTableCell_InterfaceFactory
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TevReqCellInterfaceFactory = class(TevTableCellInterfaceFactory)
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevReqCellInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevGUIInterfaces
 {$If Defined(evUseVisibleCursors)}
 , evReqCellCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evNeedHotSpot)}
 , evReqCellHotSpot
 {$IfEnd} // Defined(evNeedHotSpot)
;

function TevReqCellInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_4857EA320141_var*
//#UC END# *4D63D26D033F_4857EA320141_var*
begin
//#UC START# *4D63D26D033F_4857EA320141_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_4857EA320141_impl*
end;//TevReqCellInterfaceFactory.QueryTool

function TevReqCellInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4857EA320141_var*
//#UC END# *53CCBDA5026D_4857EA320141_var*
begin
//#UC START# *53CCBDA5026D_4857EA320141_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4857EA320141_impl*
end;//TevReqCellInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
