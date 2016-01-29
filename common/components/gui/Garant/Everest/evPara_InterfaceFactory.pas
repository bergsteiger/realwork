unit evPara_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evPara_InterfaceFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi::Everest::InterfaceFactories::TevPara
//
// базовый класс "фабрики интерфейсов" для параграфов.
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
  evParaInterfaceFactoryPrim,
  l3IID,
  k2ToolPrim,
  l3Variant
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevParaInterfaceFactory = class(TevParaInterfaceFactoryPrim)
  {* базовый класс "фабрики интерфейсов" для параграфов. }
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
 end;//TevParaInterfaceFactory
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevTools,
  nevBase,
  nevRealTools,
  nevPara
  {$If defined(evUseVisibleCursors)}
  ,
  evCursorPair
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evParaCursor
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseDeadCursor) AND defined(evUseVisibleCursors)}
  ,
  evDeadCursor
  {$IfEnd} //evUseDeadCursor AND evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evInevBaseLine4AnchorMapper
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evInevBaseLine4PrintMapper
  {$IfEnd} //evUseVisibleCursors
  ,
  evIevAnchorIndexMapper,
  nevAnchor
  {$If defined(evNeedPainters)}
  ,
  evInevDrawingShapeMapper
  {$IfEnd} //evNeedPainters
  ,
  evInevParaMapper
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevParaInterfaceFactory

function TevParaInterfaceFactory.QueryTool(aTag: Tl3Variant;
  const ID: Tl3IID;
  out I: Tk2ToolPrim): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidBlock) then
  I := TevCursorPair.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidCursor) then
  I := TevParaCursor.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
  Result := inherited QueryTool(aTag, ID, I);
end;//TevParaInterfaceFactory.QueryTool

function TevParaInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
 {-}
begin
 Result := true;
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevPara) then
  InevPara(theTool) := TnevPara.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevParaInternal) then
  InevParaInternal(theTool) := TnevPara.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evUseDeadCursor) AND defined(evUseVisibleCursors)}
 if aIID.EQ(IevSavedCursor) then
  IevSavedCursor(theTool) := TevDeadCursorParent.Make(aTag)
 else
 {$IfEnd} //evUseDeadCursor AND evUseVisibleCursors
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevAnchor) then
  InevAnchor(theTool) := TnevAnchor.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evUseVisibleCursors)}
 if aIID.EQ(InevBaseLine4Anchor) then
  Result := TevInevBaseLine4AnchorMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //evUseVisibleCursors
 {$If defined(evUseVisibleCursors)}
 if aIID.EQ(InevBaseLine4Print) then
  Result := TevInevBaseLine4PrintMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //evUseVisibleCursors
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevAnchorIndex) then
  Result := TevIevAnchorIndexMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedPainters)}
 if aIID.EQ(InevDrawingShape) then
  Result := TevInevDrawingShapeMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObject) then
  Result := TevInevParaMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObjectPrim) then
  Result := TevInevParaMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
  Result := inherited COMQueryTool(aTag, aIID, theTool, aProcessor);
end;//TevParaInterfaceFactory.COMQueryTool

{$IfEnd} //k2ForEditor

end.