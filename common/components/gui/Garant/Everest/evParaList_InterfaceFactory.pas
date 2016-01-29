unit evParaList_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evParaList_InterfaceFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi::Everest::InterfaceFactories::TevParaList
//
// "фабрика интерфейсов" для списка параграфов.
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
  evPara_InterfaceFactory,
  l3IID,
  k2ToolPrim,
  l3Variant
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevParaListInterfaceFactory = class(TevParaInterfaceFactory)
  {* "фабрика интерфейсов" для списка параграфов. }
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
 end;//TevParaListInterfaceFactory
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevRealTools,
  nevTools,
  nevGUIInterfaces,
  nevBase
  {$If defined(evUseVisibleCursors)}
  ,
  evParaListCursor
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evNeedPainters)}
  ,
  evParaListPainter
  {$IfEnd} //evNeedPainters
  ,
  nevParaList
  {$If defined(evUseVisibleCursors)}
  ,
  evParaListCursorPair
  {$IfEnd} //evUseVisibleCursors
  ,
  nevParaListAnchor
  {$If defined(evNeedHotSpot)}
  ,
  evParaListHotSpotTester
  {$IfEnd} //evNeedHotSpot
  ,
  nevParaListInevParaListMapper
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevParaListInterfaceFactory

function TevParaListInterfaceFactory.QueryTool(aTag: Tl3Variant;
  const ID: Tl3IID;
  out I: Tk2ToolPrim): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidCursor) then
  I := TevParaListCursor.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidBlock) then
  I := TevParaListCursorPair.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
  Result := inherited QueryTool(aTag, ID, I);
end;//TevParaListInterfaceFactory.QueryTool

function TevParaListInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evNeedPainters)}
 if aIID.EQ(IevPainter) then
  IevPainter(theTool) := TevParaListPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevParaList) then
  InevParaList(theTool) := TnevParaList.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevAnchor) then
  InevAnchor(theTool) := TnevParaListAnchor.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedHotSpot)}
 if aIID.EQ(InevHotSpotTester2) then
  InevHotSpotTester2(theTool) := TevParaListHotSpotTester.Make(aTag, aProcessor)
 else
 {$IfEnd} //evNeedHotSpot
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevPara) then
  Result := TnevParaListInevParaListMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevParaInternal) then
  Result := TnevParaListInevParaListMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedPainters)}
 if aIID.EQ(InevDrawingShape) then
  InevDrawingShape(theTool) := TevParaListPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObject) then
  InevObject(theTool) := TnevParaList.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObjectPrim) then
  InevObjectPrim(theTool) := TnevParaList.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
  Result := inherited COMQueryTool(aTag, aIID, theTool, aProcessor);
end;//TevParaListInterfaceFactory.COMQueryTool

{$IfEnd} //k2ForEditor

end.