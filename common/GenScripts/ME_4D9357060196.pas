unit eeDocumentContainerPrim;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeDocumentContainerPrim.pas"
// Стереотип: "SimpleClass"

{$Include eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , nevPrintableDocumentContainer
 , nevTools
 , nevDocumentContainer
 , evOpProc
;

type
 TeeDocumentContainerPrim = class(TnevPrintableDocumentContainer)
  protected
   function DoGetSubEx(anID: Integer;
    aLayerID: Integer): IevSub; override;
   procedure MakeProcessor(out theProcessor: TevCustomUndoProcessor); override;
   function PartGeneratorClass: RevDocumentPartGenerator; override;
 end;//TeeDocumentContainerPrim
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , eeProcessor
 , evDefaultContext
 , eeDocumentPartGenerator
 , eeSubExport
;

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
{$IfEnd} // Defined(Nemesis)

end.
