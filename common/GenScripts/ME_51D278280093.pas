unit destNorm;

interface

uses
 l3IntfUses
 , ddRTFdestination
 , ddTypes
 , RTFtypes
 , ddTab
 , l3Base
 , l3Memory
 , ddDocumentAtom
 , ddTextParagraph
 , ddDocumentAtomList
 , ddTable
 , ddCellProperty
 , ddCharacterProperty
 , ddRTFState
 , ddParagraphProperty
 , ddRTFProperties
 , Graphics
 , ddPicture
 , l3Interfaces
 , ddCustomRTFReader
 , k2Interfaces
 , rtfListTable
;

type
 TdestNorm = class(TddRTFDestination)
  procedure AddTable(aLevel: Integer);
  procedure Try2AddTable(aLevel: Integer);
  function FindNestedLastTable: TddTable;
  procedure ApplyToCell(aWhat: TIProp;
   aValue: LongInt;
   aCEP: TddCellProperty);
  procedure ApplyToCHP(aWhat: TIProp;
   aValue: Integer;
   aCHP: TddCharacterProperty);
  procedure ApplyToFrame(aWhat: TIProp;
   aValue: LongInt;
   aState: TddRTFState);
  procedure ApplyToPAP(What: TIProp;
   aValue: Integer;
   aPAP: TddParagraphProperty);
  procedure ApplyToRow(aWhat: TIProp;
   aValue: LongInt;
   aState: TddRTFState);
  procedure ApplyToSep(aWhat: TIProp;
   aValue: LongInt);
  procedure ApplyToStyle(aWhat: TIProp;
   aValue: LongInt;
   aState: TddRTFState);
  procedure ApplyToTAB(aWhat: TIProp;
   aValue: LongInt;
   aPAP: TddParagraphProperty);
  function GetFontEvent(aFontID: Integer): TddFontEntry;
  function GetColor(aColorIndex: Integer): TColor;
  function AddTextPara(aInTable: Boolean;
   anItap: Integer): TddTextParagraph; overload;
  procedure AddPicture(aPicture: TddPicture;
   aState: TddRTFState;
   anAssign2Last: Boolean);
  procedure Append(aState: TddRTFState;
   aDest: TdestNorm;
   aInSamePara: Boolean);
  function BufferEmpty: Boolean;
  procedure CorrectCharset(aCHP: TddCharacterProperty;
   aText: Tl3String);
  procedure FlushTextBuffer(aState: TddRTFState;
   aCheckCodePage: Boolean);
  procedure FlushUnicodeBuffer(aState: TddRTFState);
  function LastTable(aCheckNested: Boolean): TddTable;
  procedure Unicode2Text;
  function GetLastTextParaOrCreateNew(aPAP: TddParagraphProperty;
   out aNewPara: Boolean): TddTextParagraph;
  procedure JoinPAPWithLastParaPAP(aPAP: TddParagraphProperty;
   aNeedClose: Boolean);
  procedure Try2ApplyParaProperty(aState: TddRTFState;
   aPara: TddTextParagraph;
   aWasPara: Boolean);
  procedure CheckBeforeWrite(aState: TddRTFState);
  function GetFirstTableWidth: Integer;
  procedure WriteOldStyleItemText(aState: TddRTFState;
   const aItemText: AnsiString);
   {* Поддержка добавления номера стиля из Word 6.0/95. Создает текстовый параграф, если нужно. }
  procedure AddPageBreak(aSymbol: Integer);
  function GetTextBuffer(aState: TddRTFState): Tl3String;
   {* Получение TextBuffer буфера с проверкой UnicodeBuffer }
  procedure AfterClose(aNewDest: TddRTFDestination;
   aState: TddRTFState;
   aCHP: TddCharacterProperty);
  function CheckAnsiChar(aText: AnsiChar;
   aState: TddRTFState): Boolean;
  procedure AddFormula(const aTextPara: TddTextParagraph;
   const aFormulaText: Tl3WString);
  function CanAddTable: Boolean;
  procedure AddShape(aState: TddRTFState;
   aShape: TddDocumentAtom);
  procedure SimpleAddShape(aShape: TddDocumentAtom);
  function AddTextPara(aPAP: TddParagraphProperty): TddTextParagraph; overload;
  function Try2CloseNestedTable(anItap: Integer): Boolean;
  function FindFootnoteSymbol(aState: TddRTFState;
   aSymbol: Integer): Boolean;
  procedure AddFooterHyperlink(aState: TddRTFState);
  function AddParagraph(const anAtom: TddDocumentAtom): Integer;
  function GetParagraphsCount: Integer;
  procedure ParagraphsClear;
  procedure ClearTextBuffer;
  procedure AfterAddPara(const anAtom: TddDocumentAtom);
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestNorm
 
implementation

uses
 l3ImplUses
 , SysUtils
 , ddTableCell
 , ddTableRow
 , ddTextSegment
 , l3Chars
 , ddBreak
 , l3String
 , l3StringEx
 , l3Types
 , Windows
 , ddBorder
 , ddRTFConst
 , ddFormulaParagraph
 , ddFormulaSegment
 , ddRTFShape
 , Classes
;

end.
