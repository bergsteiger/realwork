unit evHTMLDataObject;

interface

uses
 l3IntfUses
 , evReaderDataObject
;

type
 TevHTMLDataObject = class(TevReaderDataObject)
  function ReaderClass: Rk2CustomReader;
 end;//TevHTMLDataObject
 
implementation

uses
 l3ImplUses
 , ddHTMLReader
;

end.
