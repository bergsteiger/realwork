unit evControlPara_InterfaceFactory;

// Модуль: "w:\common\components\gui\Garant\Everest\evControlPara_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevControlPara" MUID: (4858000901EF)
// Имя типа: "TevControlParaInterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evTextPara_InterfaceFactory
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TevControlParaInterfaceFactory = class(TevTextParaInterfaceFactory)
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevControlParaInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 , evQueryCardInt
 , nevGUIInterfaces
 , nevTools
 , nevBase
 {$If Defined(evNeedPainters)}
 , evControlParaPainter
 {$IfEnd} // Defined(evNeedPainters)
 , nevControlPara
 {$If Defined(evUseVisibleCursors)}
 , evControlParaCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evUseVisibleCursors)}
 , evControlParaCursorPair
 {$IfEnd} // Defined(evUseVisibleCursors)
 {$If Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)}
 , evControlParaHotSpotTester
 {$IfEnd} // Defined(evNeedHotSpot) AND NOT Defined(evCanEditControlsAsText)
 , nevControlParaIevControlFriendMapper
 , nevControlParaModelControlMapper
 , ControlPara_Const
;

function TevControlParaInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_4858000901EF_var*
//#UC END# *4D63D26D033F_4858000901EF_var*
begin
//#UC START# *4D63D26D033F_4858000901EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_4858000901EF_impl*
end;//TevControlParaInterfaceFactory.QueryTool

function TevControlParaInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4858000901EF_var*
//#UC END# *53CCBDA5026D_4858000901EF_var*
begin
//#UC START# *53CCBDA5026D_4858000901EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4858000901EF_impl*
end;//TevControlParaInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
