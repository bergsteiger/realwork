unit evTextPara_InterfaceFactory;

// Модуль: "w:\common\components\gui\Garant\Everest\evTextPara_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevTextPara" MUID: (48577C150116)
// Имя типа: "TevTextParaInterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evLeafPara_InterfaceFactory
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TevTextParaInterfaceFactory = class(TevLeafParaInterfaceFactory)
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevTextParaInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 , nevTools
 , nevGUIInterfaces
 , l3Interfaces
 , nevBase
 {$If Defined(evUseVisibleCursors)}
 , evTextParaCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evNeedPainters)}
 , evTextParaPainterEx
 {$IfEnd} // Defined(evNeedPainters)
 , nevTextPara
 {$If Defined(evUseVisibleCursors)}
 , evTextCursorPair
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evNeedHotSpot)}
 , evTextParaHotSpotTester
 {$IfEnd} // Defined(evNeedHotSpot)
 {$If Defined(evUseVisibleCursors) AND Defined(evUseDeadCursor)}
 , evDeadCursor
 {$IfEnd} // Defined(evUseVisibleCursors) AND Defined(evUseDeadCursor)
 , evTextParaStringImpl
 , nevTextParaAnchor
 , nevTextParaInevTextParaMapper
 , TextPara_Const
 //#UC START# *48577C150116impl_uses*
 //#UC END# *48577C150116impl_uses*
;

function TevTextParaInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_48577C150116_var*
//#UC END# *4D63D26D033F_48577C150116_var*
begin
//#UC START# *4D63D26D033F_48577C150116_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_48577C150116_impl*
end;//TevTextParaInterfaceFactory.QueryTool

function TevTextParaInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_48577C150116_var*
//#UC END# *53CCBDA5026D_48577C150116_var*
begin
//#UC START# *53CCBDA5026D_48577C150116_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_48577C150116_impl*
end;//TevTextParaInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
