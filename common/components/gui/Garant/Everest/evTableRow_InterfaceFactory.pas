unit evTableRow_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evTableRow_InterfaceFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi::Everest::InterfaceFactories::TevTableRow
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
 TevTableRowInterfaceFactory = class(TevParaListInterfaceFactory)
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
 end;//TevTableRowInterfaceFactory
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevRealTools,
  nevTools,
  nevGUIInterfaces,
  nevBase
  {$If defined(evNeedPainters)}
  ,
  evTableRowPainter
  {$IfEnd} //evNeedPainters
  ,
  nevTableRow
  {$If defined(evNeedHotSpot)}
  ,
  evTableRowHotSpot
  {$IfEnd} //evNeedHotSpot
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTableRowCursor
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTableRowCursorPair
  {$IfEnd} //evUseVisibleCursors
  ,
  nevTableRowAnchor
  {$If defined(evUseVisibleCursors)}
  ,
  nevTableRowBaseLine4Print
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  nevTableRowBaseLine4Anchor
  {$IfEnd} //evUseVisibleCursors
  
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevTableRowInterfaceFactory

function TevTableRowInterfaceFactory.QueryTool(aTag: Tl3Variant;
  const ID: Tl3IID;
  out I: Tk2ToolPrim): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidCursor) then
  I := TevTableRowCursor.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidBlock) then
  I := TevTableRowCursorPair.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
  Result := inherited QueryTool(aTag, ID, I);
end;//TevTableRowInterfaceFactory.QueryTool

function TevTableRowInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evNeedPainters)}
 if aIID.EQ(IevPainter) then
  IevPainter(theTool) := TevTableRowPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevTableRow) then
  InevTableRow(theTool) := TnevTableRow.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevParaList) then
  InevParaList(theTool) := TnevTableRow.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedHotSpot)}
 if aIID.EQ(InevHotSpotTester2) then
  InevHotSpotTester2(theTool) := TevTableRowHotSpotTester.Make(aTag, aProcessor)
 else
 {$IfEnd} //evNeedHotSpot
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevAnchor) then
  InevAnchor(theTool) := TnevTableRowAnchor.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evUseVisibleCursors)}
 if aIID.EQ(InevBaseLine4Print) then
  InevBaseLine4Print(theTool) := TnevTableRowBaseLine4Print.Make(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
 {$If defined(evUseVisibleCursors)}
 if aIID.EQ(InevBaseLine4Anchor) then
  InevBaseLine4Anchor(theTool) := TnevTableRowBaseLine4Anchor.Make(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
 {$If defined(evNeedPainters)}
 if aIID.EQ(InevDrawingShape) then
  InevDrawingShape(theTool) := TevTableRowPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevPara) then
  InevPara(theTool) := TnevTableRow.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObject) then
  InevObject(theTool) := TnevTableRow.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObjectPrim) then
  InevObjectPrim(theTool) := TnevTableRow.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
  Result := inherited COMQueryTool(aTag, aIID, theTool, aProcessor);
end;//TevTableRowInterfaceFactory.COMQueryTool

{$IfEnd} //k2ForEditor

end.