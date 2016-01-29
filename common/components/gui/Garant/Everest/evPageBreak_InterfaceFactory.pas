unit evPageBreak_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evPageBreak_InterfaceFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi::Everest::InterfaceFactories::TevPageBreak
//
// "фабрика интерфейсов" для разрыва страницы.
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
  evSolidPara_InterfaceFactory,
  l3IID,
  k2ToolPrim,
  l3Variant
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevPageBreakInterfaceFactory = class(TevSolidParaInterfaceFactory)
  {* "фабрика интерфейсов" для разрыва страницы. }
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
 end;//TevPageBreakInterfaceFactory
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevRealTools,
  nevTools
  {$If defined(evNeedPainters)}
  ,
  evPageBreakPainter
  {$IfEnd} //evNeedPainters
  
  {$If defined(evUseVisibleCursors)}
  ,
  evBreakParaCursor
  {$IfEnd} //evUseVisibleCursors
  ,
  nevBreakParaAnchor
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevPageBreakInterfaceFactory

function TevPageBreakInterfaceFactory.QueryTool(aTag: Tl3Variant;
  const ID: Tl3IID;
  out I: Tk2ToolPrim): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidCursor) then
  I := TevBreakParaCursor.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
  Result := inherited QueryTool(aTag, ID, I);
end;//TevPageBreakInterfaceFactory.QueryTool

function TevPageBreakInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evNeedPainters)}
 if aIID.EQ(IevPainter) then
  IevPainter(theTool) := TevPageBreakPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevAnchor) then
  InevAnchor(theTool) := TnevBreakParaAnchor.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedPainters)}
 if aIID.EQ(InevDrawingShape) then
  InevDrawingShape(theTool) := TevPageBreakPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
  Result := inherited COMQueryTool(aTag, aIID, theTool, aProcessor);
end;//TevPageBreakInterfaceFactory.COMQueryTool

{$IfEnd} //k2ForEditor

end.