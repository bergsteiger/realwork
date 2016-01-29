unit destFootnote;

interface

uses
 l3IntfUses
 , destNorm
 , ddRTFState
 , RTFtypes
 , k2Interfaces
 , ddRTFdestination
 , ddDocumentAtom
;

type
 TdestFootnote = class(TdestNorm)
  procedure Try2AddFootNote(anInClose: Boolean);
  procedure FootNoteSymbol;
 end;//TdestFootnote
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , l3Chars
 , evdStyles
 , l3String
 , ddTextParagraph
;

end.
