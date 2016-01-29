unit evSBSCell_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evSBSCell_InterfaceFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi::Everest::InterfaceFactories::TevSBSCell
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
  evTableCell_InterfaceFactory,
  l3IID,
  l3Variant
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TevSBSCellInterfaceFactory = class(TevTableCellInterfaceFactory)
 protected
 // overridden protected methods
   function COMQueryTool(aTag: Tl3Tag;
     const aIID: Tl3GUID;
     out theTool;
     const aProcessor: Ik2Processor): Boolean; override;
 end;//TevSBSCellInterfaceFactory
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevRealTools
  {$If defined(evNeedPainters)}
  ,
  evSBSCellPainter
  {$IfEnd} //evNeedPainters
  
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevSBSCellInterfaceFactory

function TevSBSCellInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evNeedPainters)}
 if aIID.EQ(IevPainter) then
  IevPainter(theTool) := TevSBSCellPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(evNeedPainters)}
 if aIID.EQ(InevDrawingShape) then
  InevDrawingShape(theTool) := TevSBSCellPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
  Result := inherited COMQueryTool(aTag, aIID, theTool, aProcessor);
end;//TevSBSCellInterfaceFactory.COMQueryTool

{$IfEnd} //k2ForEditor

end.