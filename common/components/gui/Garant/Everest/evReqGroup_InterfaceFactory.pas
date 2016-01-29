unit evReqGroup_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evReqGroup_InterfaceFactory.pas"
// Начат: 22.02.2011 17:01
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi::Everest::InterfaceFactories::TevReqGroup
//
// Фабрика интерфейсов для группы реквизитов
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
  evTable_InterfaceFactory,
  l3IID,
  l3Variant
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevReqGroupInterfaceFactory = class(TevTableInterfaceFactory)
  {* Фабрика интерфейсов для группы реквизитов }
 protected
 // overridden protected methods
   function COMQueryTool(aTag: Tl3Tag;
     const aIID: Tl3GUID;
     out theTool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TevReqGroupInterfaceFactory
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevGUIInterfaces,
  nevRealTools
  {$If defined(evNeedHotSpot) AND defined(evReqGroupNeedsRadio)}
  ,
  evReqGroupHotSpotTester
  {$IfEnd} //evNeedHotSpot AND evReqGroupNeedsRadio
  
  {$If defined(evNeedPainters) AND defined(evReqGroupNeedsRadio)}
  ,
  evReqGroupPainter
  {$IfEnd} //evNeedPainters AND evReqGroupNeedsRadio
  
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevReqGroupInterfaceFactory

function TevReqGroupInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evNeedHotSpot) AND defined(evReqGroupNeedsRadio)}
 if aIID.EQ(InevHotSpotTester2) then
  InevHotSpotTester2(theTool) := TevReqGroupHotSpotTester.Make(aTag, aProcessor)
 else
 {$IfEnd} //evNeedHotSpot AND evReqGroupNeedsRadio
 {$If defined(evNeedPainters) AND defined(evReqGroupNeedsRadio)}
 if aIID.EQ(IevPainter) then
  IevPainter(theTool) := TevReqGroupPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters AND evReqGroupNeedsRadio
 {$If defined(evNeedPainters) AND defined(evReqGroupNeedsRadio)}
 if aIID.EQ(InevDrawingShape) then
  InevDrawingShape(theTool) := TevReqGroupPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters AND evReqGroupNeedsRadio
  Result := inherited COMQueryTool(aTag, aIID, theTool, aProcessor);
end;//TevReqGroupInterfaceFactory.COMQueryTool

{$IfEnd} //k2ForEditor

end.