unit evTextPara_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evTextPara_InterfaceFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi::Everest::InterfaceFactories::TevTextPara
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  evLeafPara_InterfaceFactory,
  l3IID,
  k2ToolPrim,
  l3Variant
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevTextParaInterfaceFactory = class(TevLeafParaInterfaceFactory)
 protected
 // overridden protected methods
   function COMQueryTool(aTag: Tl3Tag;
     const aIID: Tl3GUID;
     out theTool;
     const aProcessor: Ik2Processor): Boolean; override;
 public
 // overridden public methods
   function QueryTool(aTag: Tl3Variant;
     const ID: Tl3IID;
     out I: Tk2ToolPrim): Boolean; override;
 end;//TevTextParaInterfaceFactory
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevRealTools,
  nevTools,
  nevGUIInterfaces,
  l3Interfaces,
  nevBase
  {$If defined(evUseVisibleCursors)}
  ,
  evTextParaCursor
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evNeedPainters)}
  ,
  evTextParaPainterEx
  {$IfEnd} //evNeedPainters
  ,
  nevTextPara
  {$If defined(evUseVisibleCursors)}
  ,
  evTextCursorPair
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evNeedHotSpot)}
  ,
  evTextParaHotSpotTester
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evUseDeadCursor) AND defined(evUseVisibleCursors)}
  ,
  evDeadCursor
  {$IfEnd} //evUseDeadCursor AND evUseVisibleCursors
  ,
  evTextParaStringImpl,
  nevTextParaAnchor,
  nevTextParaInevTextParaMapper
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevTextParaInterfaceFactory

function TevTextParaInterfaceFactory.QueryTool(aTag: Tl3Variant;
  const ID: Tl3IID;
  out I: Tk2ToolPrim): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidCursor) then
  I := TevTextParaCursor.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidBlock) then
  I := TevTextCursorPair.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
  Result := inherited QueryTool(aTag, ID, I);
end;//TevTextParaInterfaceFactory.QueryTool

function TevTextParaInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evNeedPainters)}
 if aIID.EQ(IevPainter) then
  IevPainter(theTool) := TevTextParaPainterEx.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevTextPara) then
  InevTextPara(theTool) := TnevTextPara.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedHotSpot)}
 if aIID.EQ(InevHotSpotTester2) then
  InevHotSpotTester2(theTool) := TevTextParaHotSpotTester.Make(aTag)
 else
 {$IfEnd} //evNeedHotSpot
 {$If defined(evUseDeadCursor) AND defined(evUseVisibleCursors)}
 if aIID.EQ(IevSavedCursor) then
  IevSavedCursor(theTool) := TevTextParaDeadCursor.Make(aTag)
 else
 {$IfEnd} //evUseDeadCursor AND evUseVisibleCursors
 {$If defined(k2ForEditor)}
 if aIID.EQ(Il3WordsSeq) then
  Il3WordsSeq(theTool) := TevTextParaStringImpl.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevAnchor) then
  InevAnchor(theTool) := TnevTextParaAnchor.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevPara) then
  Result := TnevTextParaInevTextParaMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevParaInternal) then
  Result := TnevTextParaInevTextParaMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevLeafPara) then
  Result := TnevTextParaInevTextParaMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedPainters)}
 if aIID.EQ(InevDrawingShape) then
  InevDrawingShape(theTool) := TevTextParaPainterEx.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObject) then
  InevObject(theTool) := TnevTextPara.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObjectPrim) then
  InevObjectPrim(theTool) := TnevTextPara.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
  Result := inherited COMQueryTool(aTag, aIID, theTool, aProcessor);
end;//TevTextParaInterfaceFactory.COMQueryTool

{$IfEnd} //k2ForEditor

end.