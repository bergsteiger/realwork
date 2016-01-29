unit ddTextSegmentQueue;

interface

uses
 l3IntfUses
 , ddTextSegmentsList
 , ddTextSegment
;

type
 TddTextSegmentQueue = class(TddTextSegmentsList)
  function Pop: TddTextSegment;
  procedure Push(const aTextSegment: TddTextSegment);
  procedure IncBraceCount(aValue: Integer);
  procedure DecBraceCount(aValue: Integer);
  function PopLast: TddTextSegment;
  function GetHyperlink: TddTextSegment;
  procedure ClearHyperlinkID(const aSeg: TddTextSegment);
  procedure MoveHyperlinkToBottom;
   {* Переместить гиперссылку в конец очереди. }
 end;//TddTextSegmentQueue
 
implementation

uses
 l3ImplUses
 , ddHyperlink
;

end.
