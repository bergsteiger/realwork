unit evPDFWriter;

// Модуль: "w:\common\components\gui\Garant\Everest\evPDFWriter.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomPDFWriter
;

type
 TevPDFWriter = class(TevCustomPDFWriter)
  protected
   procedure ExportPDF; override;
 end;//TevPDFWriter

implementation

uses
 l3ImplUses
 , evDocumentPreview
 , nevBase
 , ddPDFExporter
 , nevDocumentProvider4PDF
 , nevTools
;

procedure TevPDFWriter.ExportPDF;
//#UC START# *53FEE4FE01CB_53FEE940022B_var*
var
 l_DocPara  : InevPara;
 l_Preview  : TevDocumentPreview;
 l_Storable : InevStorable;
 l_Exporter : TddPDFExporter;
//#UC END# *53FEE4FE01CB_53FEE940022B_var*
begin
//#UC START# *53FEE4FE01CB_53FEE940022B_impl*
 l_DocPara := GetDocument;
 if l_DocPara.QT(InevStorable, l_Storable) then
  try
   l_Preview := TevDocumentPreview.Create(TnevDocumentProvider4PDF.Make(l_Storable, l_DocPara.AsObject), evDefaultPreviewCacheKey, nil);
   try
    l_Exporter := TddPDFExporter.Create(Filer.Stream);
    try
     l_Preview.Print2PDF(l_Exporter.GetCanvas(l_Preview.Printer));
    finally
     l_Exporter.Free;
    end;
   finally
    l_Preview.Free;
   end;
  finally
   l_DocPara := nil;
   l_Storable := nil;
  end
 else
  Assert(false);
//#UC END# *53FEE4FE01CB_53FEE940022B_impl*
end;//TevPDFWriter.ExportPDF

end.
