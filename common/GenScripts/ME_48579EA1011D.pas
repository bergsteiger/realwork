unit evParaList_InterfaceFactory;
 {* "фабрика интерфейсов" для списка параграфов. }

// Модуль: "w:\common\components\gui\Garant\Everest\evParaList_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevParaList" MUID: (48579EA1011D)
// Имя типа: "TevParaListInterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evPara_InterfaceFactory
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TevParaListInterfaceFactory = class(TevParaInterfaceFactory)
  {* "фабрика интерфейсов" для списка параграфов. }
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevParaListInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 , nevTools
 , nevGUIInterfaces
 , nevBase
 {$If Defined(evUseVisibleCursors)}
 , evParaListCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evNeedPainters)}
 , evParaListPainter
 {$IfEnd} // Defined(evNeedPainters)
 , nevParaList
 {$If Defined(evUseVisibleCursors)}
 , evParaListCursorPair
 {$IfEnd} // Defined(evUseVisibleCursors)
 , nevParaListAnchor
 {$If Defined(evNeedHotSpot)}
 , evParaListHotSpotTester
 {$IfEnd} // Defined(evNeedHotSpot)
 , nevParaListInevParaListMapper
;

function TevParaListInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_48579EA1011D_var*
//#UC END# *4D63D26D033F_48579EA1011D_var*
begin
//#UC START# *4D63D26D033F_48579EA1011D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_48579EA1011D_impl*
end;//TevParaListInterfaceFactory.QueryTool

function TevParaListInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_48579EA1011D_var*
//#UC END# *53CCBDA5026D_48579EA1011D_var*
begin
//#UC START# *53CCBDA5026D_48579EA1011D_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_48579EA1011D_impl*
end;//TevParaListInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
