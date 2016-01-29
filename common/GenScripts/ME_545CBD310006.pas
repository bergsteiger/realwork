unit SynPDF;

interface

uses
 l3IntfUses
;

type
 TPdfDocument = class
 end;//TPdfDocument
 
 TPdfCanvas = class
 end;//TPdfCanvas
 
 TPdfStream = class
 end;//TPdfStream
 
 TPdfImage = class
 end;//TPdfImage
 
 TPdfPageGDI = class
 end;//TPdfPageGDI
 
implementation

uses
 l3ImplUses
 , SynCommons
 , SynCrypto
 , SynZip
 , SynGdiPlus
 , SynLZ
;

end.
