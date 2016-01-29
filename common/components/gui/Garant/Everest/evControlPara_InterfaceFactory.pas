unit evControlPara_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evControlPara_InterfaceFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi::Everest::InterfaceFactories::TevControlPara
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
  evTextPara_InterfaceFactory,
  l3IID,
  k2ToolPrim,
  l3Variant
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevControlParaInterfaceFactory = class(TevTextParaInterfaceFactory)
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
 end;//TevControlParaInterfaceFactory
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevRealTools,
  evQueryCardInt,
  nevGUIInterfaces,
  nevTools,
  nevBase
  {$If defined(evNeedPainters)}
  ,
  evControlParaPainter
  {$IfEnd} //evNeedPainters
  ,
  nevControlPara
  {$If defined(evUseVisibleCursors)}
  ,
  evControlParaCursor
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evUseVisibleCursors)}
  ,
  evControlParaCursorPair
  {$IfEnd} //evUseVisibleCursors
  
  {$If defined(evNeedHotSpot) AND not defined(evCanEditControlsAsText)}
  ,
  evControlParaHotSpotTester
  {$IfEnd} //evNeedHotSpot AND not evCanEditControlsAsText
  ,
  nevControlParaIevControlFriendMapper,
  nevControlParaModelControlMapper
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevControlParaInterfaceFactory

function TevControlParaInterfaceFactory.QueryTool(aTag: Tl3Variant;
  const ID: Tl3IID;
  out I: Tk2ToolPrim): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidCursor) then
  I := TevControlParaCursor.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidBlock) then
  I := TevControlParaCursorPair.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
  Result := inherited QueryTool(aTag, ID, I);
end;//TevControlParaInterfaceFactory.QueryTool

function TevControlParaInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evNeedPainters)}
 if aIID.EQ(IevPainter) then
  IevPainter(theTool) := TevControlParaPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevControlFriend) then
  IevControlFriend(theTool) := TnevControlPara.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedHotSpot) AND not defined(evCanEditControlsAsText)}
 if aIID.EQ(InevHotSpotTester2) then
  InevHotSpotTester2(theTool) := TevControlParaHotSpotTester.Make(aTag)
 else
 {$IfEnd} //evNeedHotSpot AND not evCanEditControlsAsText
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevPara) then
  Result := TnevControlParaIevControlFriendMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevParaInternal) then
  Result := TnevControlParaIevControlFriendMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevLeafPara) then
  Result := TnevControlParaIevControlFriendMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevTextPara) then
  Result := TnevControlParaIevControlFriendMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevControl) then
  Result := TnevControlParaIevControlFriendMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevCommonControl) then
  Result := TnevControlParaIevControlFriendMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevCustomParaTool) then
  Result := TnevControlParaModelControlMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevCustomEditorControl) then
  Result := TnevControlParaModelControlMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevEditorControl) then
  Result := TnevControlParaModelControlMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevEditorControlField) then
  Result := TnevControlParaModelControlMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevEditorFieldWithTree) then
  Result := TnevControlParaModelControlMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevEditorCalendarField) then
  Result := TnevControlParaModelControlMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedPainters)}
 if aIID.EQ(InevDrawingShape) then
  InevDrawingShape(theTool) := TevControlParaPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObject) then
  InevObject(theTool) := TnevControlPara.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObjectPrim) then
  InevObjectPrim(theTool) := TnevControlPara.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
  Result := inherited COMQueryTool(aTag, aIID, theTool, aProcessor);
end;//TevControlParaInterfaceFactory.COMQueryTool

{$IfEnd} //k2ForEditor

end.