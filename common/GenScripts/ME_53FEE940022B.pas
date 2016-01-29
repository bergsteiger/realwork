unit evPDFWriter;

interface

uses
 l3IntfUses
 , evCustomPDFWriter
;

type
 TevPDFWriter = class(TevCustomPDFWriter)
  procedure ExportPDF;
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

end.
