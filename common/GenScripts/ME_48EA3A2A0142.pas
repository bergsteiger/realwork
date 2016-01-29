unit evEvdDataObject;

interface

uses
 l3IntfUses
 , evReaderDataObject
;

type
 TevEvdDataObject = class(TevReaderDataObject)
  function ReaderClass: Rk2CustomReader;
 end;//TevEvdDataObject
 
implementation

uses
 l3ImplUses
 , evdNativeReader
;

end.
