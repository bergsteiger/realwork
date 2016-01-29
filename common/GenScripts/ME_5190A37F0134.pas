unit ddRTFdestination;

interface

uses
 l3IntfUses
 , ddCustomDestination
 , RTFtypes
 , ddCustomRTFReader
 , ddRTFState
 , l3Base
 , k2Interfaces
;

type
 TddRTFDestination = class(TddCustomDestination)
  procedure Clear;
  procedure AddAnsiChar(aText: AnsiChar;
   aState: TddRTFState);
  procedure AddString(aText: Tl3String;
   aState: TddRTFState);
  procedure AddUnicodeChar(aText: Word;
   aState: TddRTFState);
  procedure ApplyProperty(propType: TPropType;
   What: TIProp;
   Value: LongInt;
   aState: TddRTFState);
  procedure ParseSymbol(Symbol: Integer;
   propType: TPropType;
   aState: TddRTFState);
  procedure Write(const aGenerator: Ik2TagGenerator);
  procedure WriteText(aText: Tl3String;
   aState: TddRTFState); overload;
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState); overload;
  function ReadData: Boolean;
  procedure FlushBuffer(aState: TddRTFState);
  procedure Create(aRTFReader: TddCustomRTFReader);
  procedure BeforeCloseParagraph(const aDocAtom: TObject;
   var aNewStyle: Integer);
 end;//TddRTFDestination
 
implementation

uses
 l3ImplUses
;

end.
