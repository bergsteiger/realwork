unit evFormula_InterfaceFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evFormula_InterfaceFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<InterfaceFactory::Class>> Shared Delphi::Everest::InterfaceFactories::TevFormula
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
 TevFormulaInterfaceFactory = class(TevTextParaInterfaceFactory)
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
 end;//TevFormulaInterfaceFactory
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  nevRealTools,
  nevTools,
  nevBase
  {$If defined(evNeedPainters)}
  ,
  evFormulaPainter
  {$IfEnd} //evNeedPainters
  ,
  nevFormulaPara
  {$If defined(evUseVisibleCursors)}
  ,
  evFormulaCursor
  {$IfEnd} //evUseVisibleCursors
  
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TevFormulaInterfaceFactory

function TevFormulaInterfaceFactory.QueryTool(aTag: Tl3Variant;
  const ID: Tl3IID;
  out I: Tk2ToolPrim): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evUseVisibleCursors)}
 if ID.EQ(ev_iidCursor) then
  I := TevFormulaCursor.Create(aTag)
 else
 {$IfEnd} //evUseVisibleCursors
  Result := inherited QueryTool(aTag, ID, I);
end;//TevFormulaInterfaceFactory.QueryTool

function TevFormulaInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
  const aIID: Tl3GUID;
  out theTool;
  const aProcessor: Ik2Processor): Boolean;
 {-}
begin
 Result := true;
 {$If defined(evNeedPainters)}
 if aIID.EQ(IevPainter) then
  IevPainter(theTool) := TevFormulaPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevTextPara) then
  InevTextPara(theTool) := TnevFormulaPara.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(evNeedPainters)}
 if aIID.EQ(InevDrawingShape) then
  InevDrawingShape(theTool) := TevFormulaPainter.Make(aTag)
 else
 {$IfEnd} //evNeedPainters
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevPara) then
  InevPara(theTool) := TnevFormulaPara.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObject) then
  InevObject(theTool) := TnevFormulaPara.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevLeafPara) then
  InevLeafPara(theTool) := TnevFormulaPara.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
 {$If defined(k2ForEditor)}
 if aIID.EQ(InevObjectPrim) then
  InevObjectPrim(theTool) := TnevFormulaPara.Make(aTag)
 else
 {$IfEnd} //k2ForEditor
  Result := inherited COMQueryTool(aTag, aIID, theTool, aProcessor);
end;//TevFormulaInterfaceFactory.COMQueryTool

{$IfEnd} //k2ForEditor

end.