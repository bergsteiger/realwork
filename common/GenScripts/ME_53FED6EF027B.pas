unit evCustomPDFWriter;

interface

uses
 l3IntfUses
 , k2CustomFileGenerator
 , k2DocumentBuffer
 , nevTools
 , l3Variant
;

type
 TevCustomPDFWriter = class(Tk2CustomFileGenerator)
  {* Писатель PDF-файлов. }
  procedure ExportPDF;
  function GetDocument: InevPara;
 end;//TevCustomPDFWriter
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
