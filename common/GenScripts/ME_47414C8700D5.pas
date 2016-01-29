unit afwCanvasEx;

interface

uses
 l3IntfUses
 , l3Canvas
 , afwInterfaces
 , afwTypes
 , l3InternalInterfaces
 , l3CanvasPrim
 , l3PrinterInterfaces
;

type
 TafwCanvasEx = class(Tl3Canvas)
  {* Канва с информацией о разбиении документа на страницы. }
  procedure Create(const aPrinter: IafwPrinter;
   const aPagesArray: TafwPrintPagesArray);
  function Make(const aPrinter: IafwPrinter;
   const aPagesArray: TafwPrintPagesArray): Il3Canvas;
 end;//TafwCanvasEx
 
implementation

uses
 l3ImplUses
 , afwPreviewPage
;

end.
