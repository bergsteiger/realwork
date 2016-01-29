unit eeDocumentContainerPrim;

interface

uses
 l3IntfUses
 , nevPrintableDocumentContainer
 , nevTools
 , nevDocumentContainer
 , evOpProc
;

type
 TeeDocumentContainerPrim = class(TnevPrintableDocumentContainer)
 end;//TeeDocumentContainerPrim
 
implementation

uses
 l3ImplUses
 , eeProcessor
 , evDefaultContext
 , eeDocumentPartGenerator
 , eeSubExport
;

end.
