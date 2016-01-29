unit evControlsBlock_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evControlsBlock_InterfaceFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi::Everest::InterfaceFactories::TevControlsBlock
//
// "фабрика интерфейсов" для блока контролов.
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
  evBlock_InterfaceFactory,
  l3IID,
  k2ToolPrim,
  l3Variant
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevControlsBlockInterfaceFactory = class(TevBlockInterfaceFactory)
  {* "фабрика интерфейсов" для блока контролов. }
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
 end;//TevControlsBlockInterfaceFactory
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevRealTools,
  nevTools,
  nevGUIInterfaces,
  evQueryCardInt,
  nevBase
  {$If defined(evNeedPainters)}
  ,
  evControlsBlockPainter
  {$IfEnd} //evNeedPainters
  ,
  nevControlsBlock
  {$If defined(evNeedHotSpot) AND not defined(evCanEditControlsAsText)}
  ,
  evControlsBlockHotSpotTester
  {$IfEnd} //evNeedHotSpot AND not evCanEditControlsAsText
  
  {$If defined(evUseVisibleCursors)}
  ,
  evControlsBlockCursor
  {$IfEnd} //evUseVisibleCursors
  ,
  nevControlsBlockIevCommonControlMapper,
  nevControlsBlockModelControlMapper
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevControlsBlockInterfaceFactory

function TevControlsBlockInterfaceFactory.QueryTool(aTag: Tl3Variant;
  const ID: Tl3IID;
  out I: Tk2ToolPrim): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidCursor) then
  I := TevControlsBlockCursor.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
  Result := inherited QueryTool(aTag, ID, I);
end;//TevControlsBlockInterfaceFactory.QueryTool

function TevControlsBlockInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evNeedPainters)}
 if aIID.EQ(IevPainter) then
  IevPainter(theTool) := TevControlsBlockPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevCommonControl) then
  IevCommonControl(theTool) := TnevControlsBlock.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedHotSpot) AND not defined(evCanEditControlsAsText)}
 if aIID.EQ(InevHotSpotTester2) then
  InevHotSpotTester2(theTool) := TevControlsBlockHotSpotTester.Make(aTag, aProcessor)
 else
 {$IfEnd} //evNeedHotSpot AND not evCanEditControlsAsText
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevPara) then
  Result := TnevControlsBlockIevCommonControlMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevParaInternal) then
  Result := TnevControlsBlockIevCommonControlMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevParaList) then
  Result := TnevControlsBlockIevCommonControlMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevCustomParaTool) then
  Result := TnevControlsBlockModelControlMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevQueryGroup) then
  Result := TnevControlsBlockModelControlMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevCustomEditorControl) then
  Result := TnevControlsBlockModelControlMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevEditorControl) then
  Result := TnevControlsBlockModelControlMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedPainters)}
 if aIID.EQ(InevDrawingShape) then
  InevDrawingShape(theTool) := TevControlsBlockPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObject) then
  InevObject(theTool) := TnevControlsBlock.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObjectPrim) then
  InevObjectPrim(theTool) := TnevControlsBlock.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
  Result := inherited COMQueryTool(aTag, aIID, theTool, aProcessor);
end;//TevControlsBlockInterfaceFactory.COMQueryTool

{$IfEnd} //k2ForEditor

end.