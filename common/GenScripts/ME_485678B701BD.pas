unit evPara_InterfaceFactory;
 {* базовый класс "фабрики интерфейсов" для параграфов. }

// Модуль: "w:\common\components\gui\Garant\Everest\evPara_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevPara" MUID: (485678B701BD)
// Имя типа: "TevParaInterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evParaInterfaceFactoryPrim
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TevParaInterfaceFactory = class(TevParaInterfaceFactoryPrim)
  {* базовый класс "фабрики интерфейсов" для параграфов. }
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevParaInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevTools
 , nevBase
 , nevRealTools
 , nevPara
 {$If Defined(evUseVisibleCursors)}
 , evCursorPair
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evUseVisibleCursors)}
 , evParaCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evUseVisibleCursors) AND Defined(evUseDeadCursor)}
 , evDeadCursor
 {$IfEnd} // Defined(evUseVisibleCursors) AND Defined(evUseDeadCursor)
 {$If Defined(evUseVisibleCursors)}
 , evInevBaseLine4AnchorMapper
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evUseVisibleCursors)}
 , evInevBaseLine4PrintMapper
 {$IfEnd} // Defined(evUseVisibleCursors)
 , evIevAnchorIndexMapper
 , nevAnchor
 {$If Defined(evNeedPainters)}
 , evInevDrawingShapeMapper
 {$IfEnd} // Defined(evNeedPainters)
 , evInevParaMapper
;

function TevParaInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_485678B701BD_var*
//#UC END# *4D63D26D033F_485678B701BD_var*
begin
//#UC START# *4D63D26D033F_485678B701BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_485678B701BD_impl*
end;//TevParaInterfaceFactory.QueryTool

function TevParaInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_485678B701BD_var*
//#UC END# *53CCBDA5026D_485678B701BD_var*
begin
//#UC START# *53CCBDA5026D_485678B701BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_485678B701BD_impl*
end;//TevParaInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
