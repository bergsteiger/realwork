unit evTableCell_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evTableCell_InterfaceFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi::Everest::InterfaceFactories::TevTableCell
//
// "фабрика интерфейсов" для ячейки таблицы.
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
 TevTableCellInterfaceFactory = class(TevParaListInterfaceFactory)
  {* "фабрика интерфейсов" для ячейки таблицы. }
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
 end;//TevTableCellInterfaceFactory
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
  evTableCellPainter
  {$IfEnd} //evNeedPainters
  ,
  nevTableCell
  {$If defined(evNeedHotSpot)}
  ,
  evTableCellHotSpot
  {$IfEnd} //evNeedHotSpot
  ,
  nevTableCellAnchor
  {$If defined(evUseVisibleCursors)}
  ,
  evTableCellCursor
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evTableCellCursorPair
  {$IfEnd} //evUseVisibleCursors
  
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevTableCellInterfaceFactory

function TevTableCellInterfaceFactory.QueryTool(aTag: Tl3Variant;
  const ID: Tl3IID;
  out I: Tk2ToolPrim): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidCursor) then
  I := TevTableCellCursor.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidBlock) then
  I := TevTableCellCursorPair.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
  Result := inherited QueryTool(aTag, ID, I);
end;//TevTableCellInterfaceFactory.QueryTool

function TevTableCellInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evNeedPainters)}
 if aIID.EQ(IevPainter) then
  IevPainter(theTool) := TevTableCellPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevParaList) then
  InevParaList(theTool) := TnevTableCell.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevTableCell) then
  InevTableCell(theTool) := TnevTableCell.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedHotSpot)}
 if aIID.EQ(InevHotSpotTester2) then
  InevHotSpotTester2(theTool) := TevTableCellHotSpotTester.Make(aTag, aProcessor)
 else
 {$IfEnd} //evNeedHotSpot
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevAnchor) then
  InevAnchor(theTool) := TnevTableCellAnchor.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedPainters)}
 if aIID.EQ(InevDrawingShape) then
  InevDrawingShape(theTool) := TevTableCellPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevPara) then
  InevPara(theTool) := TnevTableCell.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObject) then
  InevObject(theTool) := TnevTableCell.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObjectPrim) then
  InevObjectPrim(theTool) := TnevTableCell.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
  Result := inherited COMQueryTool(aTag, aIID, theTool, aProcessor);
end;//TevTableCellInterfaceFactory.COMQueryTool

{$IfEnd} //k2ForEditor

end.