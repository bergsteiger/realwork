unit ddCustomRTFReader;

interface

uses
 l3IntfUses
 , ddLowLevelRTF
 , rtfListTable
 , Graphics
 , ddRTFProperties
 , ddDocumentAtom
 , RTFtypes
 , ddPicture
;

type
 TddCustomRTFReader = class(TddRTFParser)
  {* Попытка разделить TddRTFReader на две части, чтобы используемые в нем классы могли знать об нем. }
  function ListByID(aID: Integer;
   out aWasRestart: Boolean): TrtfList;
  function ColorByIndex(anIndex: Integer): TColor;
  function StyleByNumber(aNumber: Integer): TddStyleEntry;
  function GetFonts(anID: Integer): TddFontEntry;
  procedure BeforeClosePara(const aPara: TddDocumentAtom;
   var aNewStyle: Integer);
  function NeedSkip(aPicture: TddPicture): TRTFPictureSkip;
  procedure IncNextFootnoteNumber;
  procedure AddFooterHyperlink;
  procedure FootNoteSymbol;
 end;//TddCustomRTFReader
 
implementation

uses
 l3ImplUses
 , ddConst
;

end.
