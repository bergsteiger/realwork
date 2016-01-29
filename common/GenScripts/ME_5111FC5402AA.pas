unit ddTextSegment;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddCharacterProperty
 , ddDocumentAtom
 , l3Base
 , ddHyperlinkTarget
 , ddHyperlinkTargetList
 , k2Interfaces
 , l3ProtoObject
;

type
 TddTextSegment = class(Tl3ProtoDataContainer)
  procedure AddTarget(aDocID: LongInt;
   aSubID: LongInt;
   aTypeID: Integer);
  procedure Create;
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aCHP: TddCharacterProperty;
   aParentCHP: TddCharacterProperty;
   LiteVersion: Boolean);
  procedure DoWriteSegmentProps(const Generator: Ik2TagGenerator;
   aCHP: TddCharacterProperty;
   aParentCHP: TddCharacterProperty;
   LiteVersion: Boolean);
  function Clone: TddTextSegment;
  function SkipSegment(aDiffCHP: TddCharacterProperty;
   LiteVersion: Boolean): Boolean;
  function IsHyperlink: Boolean;
  function IsObjectSegment: Boolean;
 end;//TddTextSegment
 
implementation

uses
 l3ImplUses
 , ddTypes
 , ddEVDTypesSupport
 , k2Tags
;

end.
