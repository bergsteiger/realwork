unit ddTextParagraph;

interface

uses
 l3IntfUses
 , ddDocumentAtom
 , ddCharacterProperty
 , ddParagraphProperty
 , ddTextSegmentsList
 , ddSubsList
 , l3Base
 , ddTextSegment
 , k2Interfaces
 , rtfListTable
 , ddCustomDestination
 , l3ProtoObject
;

type
 TddTextParagraph = class(TddDocumentAtom)
  procedure Process;
  procedure CheckListItem;
  function CheckInTable(const Generator: Ik2TagGenerator;
   const LiteVersion: Boolean): Boolean;
  procedure WriteHyperlinks(const Generator: Ik2TagGenerator);
  function WritePAP(const Generator: Ik2TagGenerator;
   LiteVersion: Boolean;
   aStyled: Boolean): Boolean;
  procedure WriteSegments(const Generator: Ik2TagGenerator);
  procedure WriteTabStops(const Generator: Ik2TagGenerator);
  procedure CheckSegments;
  procedure WriteSubs(const aGenerator: Ik2TagGenerator);
  procedure AddOldListItem;
  procedure ClearOldListItem;
  procedure AddItemText(const aItemText: AnsiString);
   {* Добавить текст пункта, как в Word 6/95. }
  procedure AddHyperlink(const aText: AnsiString;
   aDocID: Integer;
   aSubID: Integer);
  procedure AddListIndex(aList: TrtfList;
   aLite: Boolean);
  procedure AddPicture(aPicture: TddDocumentAtom);
  procedure AddSegment(aCHP: TddCharacterProperty;
   const RelativeToText: Boolean); overload;
  procedure AddSegment(aSegment: TddTextSegment); overload;
  procedure AddSub(aSubID: Integer;
   const aName: AnsiString;
   aIsRealName: Boolean);
  procedure ApplyCHP(aCHP: TddCharacterProperty);
  procedure ApplyPAP(aPAP: TddParagraphProperty);
  procedure CorrectSegments(aPrevPara: TddTextParagraph);
  function DeleteLastSegment: Boolean;
  function HaveHyperlinks: Boolean;
  function HaveObjects: Boolean;
  function HaveSegments: Boolean;
  function HyperlinkByCharIndex(Index: LongInt;
   const EndSegment: Boolean): TddTextSegment;
  function ObjectByCharIndex(Index: LongInt;
   const EndSegment: Boolean): TddTextSegment;
  function LastSegment: TddTextSegment;
  procedure PackSegments;
  function PrevCHP(aCurSegment: TddTextSegment): TddCharacterProperty;
  function SegmentByCharIndex(Index: LongInt;
   const EndSegment: Boolean;
   const StartIndex: Integer): TddTextSegment;
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aNeedProcessRow: Boolean;
   LiteVersion: Boolean);
 end;//TddTextParagraph
 
implementation

uses
 l3ImplUses
 , ddTextParaString
;

end.
