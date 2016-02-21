unit evControlsBlock_InterfaceFactory;
 {* "фабрика интерфейсов" для блока контролов. }

// Модуль: "w:\common\components\gui\Garant\Everest\evControlsBlock_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evBlock_InterfaceFactory
 , ControlsBlock_Const
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TevControlsBlockInterfaceFactory = class(TevBlockInterfaceFactory)
  {* "фабрика интерфейсов" для блока контролов. }
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevControlsBlockInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 , nevTools
 , nevGUIInterfaces
 , evQueryCardInt
 , nevBase
 {$If Defined(evNeedPainters)}
 , evControlsBlockPainter
 {$IfEnd} // Defined(evNeedPainters)
 , nevControlsBlock
 {$If Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)}
 , evControlsBlockHotSpotTester
 {$IfEnd} // Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)
 {$If Defined(evUseVisibleCursors)}
 , evControlsBlockCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 , nevControlsBlockIevCommonControlMapper
 , nevControlsBlockModelControlMapper
;

function TevControlsBlockInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_485807480091_var*
//#UC END# *4D63D26D033F_485807480091_var*
begin
//#UC START# *4D63D26D033F_485807480091_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_485807480091_impl*
end;//TevControlsBlockInterfaceFactory.QueryTool

function TevControlsBlockInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_485807480091_var*
//#UC END# *53CCBDA5026D_485807480091_var*
begin
//#UC START# *53CCBDA5026D_485807480091_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_485807480091_impl*
end;//TevControlsBlockInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
