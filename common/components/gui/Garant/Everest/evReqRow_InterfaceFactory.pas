unit evReqRow_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evReqRow_InterfaceFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi::Everest::InterfaceFactories::TevReqRow
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
  evTableRow_InterfaceFactory,
  l3IID,
  l3Variant
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevReqRowInterfaceFactory = class(TevTableRowInterfaceFactory)
 protected
 // overridden protected methods
   function COMQueryTool(aTag: Tl3Tag;
     const aIID: Tl3GUID;
     out theTool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TevReqRowInterfaceFactory
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevRealTools,
  nevGUIInterfaces,
  evQueryCardInt
  {$If defined(evNeedPainters)}
  ,
  evReqRowPainter
  {$IfEnd} //evNeedPainters
  
  {$If defined(evNeedHotSpot) AND not defined(evCanEditControlsAsText)}
  ,
  evReqRowHotSpotTester
  {$IfEnd} //evNeedHotSpot AND not evCanEditControlsAsText
  ,
  evReqRowModelControlMapper
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevReqRowInterfaceFactory

function TevReqRowInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evNeedPainters)}
 if aIID.EQ(IevPainter) then
  IevPainter(theTool) := TevReqRowPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(evNeedHotSpot) AND not defined(evCanEditControlsAsText)}
 if aIID.EQ(InevHotSpotTester2) then
  InevHotSpotTester2(theTool) := TevReqRowHotSpotTester.Make(aTag, aProcessor)
 else
 {$IfEnd} //evNeedHotSpot AND not evCanEditControlsAsText
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevReq) then
  Result := TevReqRowModelControlMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(IevComboReq) then
  Result := TevReqRowModelControlMapper.Make(aTag, aIID, theTool, aProcessor)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedPainters)}
 if aIID.EQ(InevDrawingShape) then
  InevDrawingShape(theTool) := TevReqRowPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
  Result := inherited COMQueryTool(aTag, aIID, theTool, aProcessor);
end;//TevReqRowInterfaceFactory.COMQueryTool

{$IfEnd} //k2ForEditor

end.