unit eeDocumentContainerPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeDocumentContainerPrim.pas"
// Начат: 30.03.2011 20:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Everest Engine::eeDocumentContainer::TeeDocumentContainerPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

{$If defined(Nemesis)}
uses
  nevPrintableDocumentContainer,
  nevTools,
  evOpProc,
  nevDocumentContainer
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TeeDocumentContainerPrim = class(TnevPrintableDocumentContainer)
 protected
 // overridden protected methods
   function DoGetSubEx(anID: Integer;
    aLayerID: Integer): IevSub; override;
   procedure MakeProcessor(out theProcessor: TevCustomUndoProcessor); override;
   function PartGeneratorClass: RevDocumentPartGenerator; override;
 end;//TeeDocumentContainerPrim
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  eeProcessor,
  evDefaultContext,
  eeDocumentPartGenerator,
  eeSubExport
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TeeDocumentContainerPrim

function TeeDocumentContainerPrim.DoGetSubEx(anID: Integer;
  aLayerID: Integer): IevSub;
//#UC START# *47F27721012A_4D9357060196_var*
//#UC END# *47F27721012A_4D9357060196_var*
begin
//#UC START# *47F27721012A_4D9357060196_impl*
 if HasDocument then
  Result := TeeSubExport.Make(Document.AsObject, Processor, anID, aLayerID)
 else
  Result := nil;
//#UC END# *47F27721012A_4D9357060196_impl*
end;//TeeDocumentContainerPrim.DoGetSubEx

procedure TeeDocumentContainerPrim.MakeProcessor(out theProcessor: TevCustomUndoProcessor);
//#UC START# *47F35245009A_4D9357060196_var*
//#UC END# *47F35245009A_4D9357060196_var*
begin
//#UC START# *47F35245009A_4D9357060196_impl*
 theProcessor := TeeProcessor.Create(TevDefaultContext);
//#UC END# *47F35245009A_4D9357060196_impl*
end;//TeeDocumentContainerPrim.MakeProcessor

function TeeDocumentContainerPrim.PartGeneratorClass: RevDocumentPartGenerator;
//#UC START# *48033300004D_4D9357060196_var*
//#UC END# *48033300004D_4D9357060196_var*
begin
//#UC START# *48033300004D_4D9357060196_impl*
 Result := TeeDocumentPartGenerator;
//#UC END# *48033300004D_4D9357060196_impl*
end;//TeeDocumentContainerPrim.PartGeneratorClass

{$IfEnd} //Nemesis

end.