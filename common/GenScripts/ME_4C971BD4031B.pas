unit ddRTFReader;

interface

uses
 l3IntfUses
 , ddCustomRTFReader
 , ddDocumentAtom
;

type
 TddRTFReader = class(TddCustomRTFReader)
  procedure BeforeClosePara(const aPara: TddDocumentAtom;
   var aNewStyle: Integer);
  procedure AddFooterHyperlink;
  procedure FootNoteSymbol;
 end;//TddRTFReader
 
implementation

uses
 l3ImplUses
;

end.
