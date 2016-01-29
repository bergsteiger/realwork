unit nevPrintableDocumentContainer;

interface

uses
 l3IntfUses
 , nevPersistentDocumentContainer
 , nevTools
 , afwInterfaces
 , nevBase
 , evOpProc
 , evDocumentPreview
 , evHAFPainterEx
;

type
 RevDocumentPreview = class of TevDocumentPreview;
 
 RevHAFPainter = class of TevHAFPainterEx;
 
 TnevPrintableDocumentContainer = class(TnevPersistentDocumentContainer)
  function DocumentForPreview: InevDocumentProvider;
  function MakeHAFPainter(const aMacroReplacer: IafwHAFMacroReplacer): IafwHAFPainter;
  function HAFPainterClass: RevHAFPainter;
  function DocumentPreviewClass: RevDocumentPreview;
  function Info: InevStorable;
 end;//TnevPrintableDocumentContainer
 
implementation

uses
 l3ImplUses
 , evEditorWindowProcessor
 , evDefaultContext
 , nevInterfaces
 , l3String
 , l3Chars
 , evFormatHAFMacroReplacer
 , l3Base
 , evFixedHAFMacroReplacer
 , k2Tags
 , nevDocumentProviderEx
 , nevDocumentProvider
 , l3Variant
 , l3StringIDEx
;

end.
