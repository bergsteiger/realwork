unit evDocument_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evDocument_InterfaceFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi::Everest::InterfaceFactories::TevDocument
//
// "фабрика интерфейсов" для документа.
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
  evParaList_InterfaceFactory,
  l3IID,
  k2ToolPrim,
  l3Variant
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevDocumentInterfaceFactory = class(TevParaListInterfaceFactory)
  {* "фабрика интерфейсов" для документа. }
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
 end;//TevDocumentInterfaceFactory
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevRealTools,
  nevGUIInterfaces,
  nevTools,
  nevBase
  {$If defined(evNeedPainters)}
  ,
  evDocumentPainter
  {$IfEnd} //evNeedPainters
  
  {$If defined(evNeedHotSpot)}
  ,
  evDocumentHotSpotTester
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evUseVisibleCursors)}
  ,
  evDocumentCursor
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evDocumentCursorPair
  {$IfEnd} //evUseVisibleCursors
  ,
  nevDocument,
  evDocumentAnchorIndex
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevDocumentInterfaceFactory

function TevDocumentInterfaceFactory.QueryTool(aTag: Tl3Variant;
  const ID: Tl3IID;
  out I: Tk2ToolPrim): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidCursor) then
  I := TevDocumentCursor.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidBlock) then
  I := TevDocumentCursorPair.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
  Result := inherited QueryTool(aTag, ID, I);
end;//TevDocumentInterfaceFactory.QueryTool

function TevDocumentInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evNeedPainters)}
 if aIID.EQ(IevPainter) then
  IevPainter(theTool) := TevDocumentPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(evNeedHotSpot)}
 if aIID.EQ(InevHotSpotTester2) then
  InevHotSpotTester2(theTool) := TevDocumentHotSpotTester.Make(aTag, aProcessor)
 else
 {$IfEnd} //evNeedHotSpot
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevParaList) then
  InevParaList(theTool) := TnevDocument.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevAnchorIndex) then
  IevAnchorIndex(theTool) := TevDocumentAnchorIndex.Make(aTag, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedPainters)}
 if aIID.EQ(InevDrawingShape) then
  InevDrawingShape(theTool) := TevDocumentPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevPara) then
  InevPara(theTool) := TnevDocument.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObject) then
  InevObject(theTool) := TnevDocument.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObjectPrim) then
  InevObjectPrim(theTool) := TnevDocument.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
  Result := inherited COMQueryTool(aTag, aIID, theTool, aProcessor);
end;//TevDocumentInterfaceFactory.COMQueryTool

{$IfEnd} //k2ForEditor

end.