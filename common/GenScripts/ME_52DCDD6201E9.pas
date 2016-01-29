unit ddRTFSegmentWriter;

interface

uses
 l3IntfUses
 , ddDocument
 , ddTextSegmentQueue
 , ddTextParagraph
 , ddRTFProperties
 , ddTextSegment
 , ddCharacterProperty
 , ddParagraphProperty
;

type
 TddRTFSegmentWriter = class(TddDocumentGenerator)
  {* Предок, умеющий выливать сегменты. }
  procedure CheckFinishSegments(const aPara: TddTextParagraph;
   anIndex: Integer);
  function CheckObjectSegment(const aPara: TddTextParagraph;
   anIndex: Integer;
   const aStyle: TddStyleEntry): Boolean;
  procedure CheckSegmentStart(const aPara: TddTextParagraph;
   const aSeg: TddTextSegment);
  procedure CheckSegmentFinish(const aSeg: TddTextSegment);
  procedure CheckStartSegments(const aPara: TddTextParagraph;
   anIndex: Integer);
  function Style2RTF(aStyle: TddStyleEntry;
   aBlockIndent: Integer;
   anIgnoreLeftIndent: Boolean): AnsiString;
  function CHP2RTF(aCHP: TddCharacterProperty;
   aParent: TddCharacterProperty;
   const WithStyle: Boolean): AnsiString;
  function DIffCHP2RTF(aCHP1: TddCharacterProperty;
   aCHP2: TddCharacterProperty): AnsiString;
  procedure WriteSegmentObject(aSegment: TddTextSegment;
   aCHP: TddCharacterProperty);
  function PAP2RTF(aPAP: TddParagraphProperty;
   aBlockIndent: Integer;
   anIgnoreLeftIndent: Boolean;
   WithStyle: Boolean): AnsiString;
  procedure Init4Segments;
  procedure DeInit4Segments;
  procedure IncBracesCount(aValue: Integer;
   aWriteBarket: Boolean);
  procedure DecBracesCount(aValue: Integer);
  procedure WriteOpenBarket;
  procedure WriteCloseBarket;
 end;//TddRTFSegmentWriter
 
implementation

uses
 l3ImplUses
 , ddTypes
 , SysUtils
 , evdTypes
 , l3Base
 , RTFtypes
 , ddPicture
 , l3Chars
 , ddPictureSegment
 , ddFormulaSegment
 , ddHyperlink
 , ddObjectSegment
;

end.
