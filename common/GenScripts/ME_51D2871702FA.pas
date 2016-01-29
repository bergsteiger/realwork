unit ddRTFState;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ddBorder
 , ddCellProperty
 , ddCharacterProperty
 , ddParagraphProperty
 , RTFtypes
 , ddSectionProperty
 , ddRowProperty
 , l3ProtoObjectRefList
;

type
 TddRTFState = class(Tl3ProtoObject)
  function Clone: TddRTFState;
  procedure Create(anUC: Integer);
  procedure Assign(anObject: TddRTFState);
 end;//TddRTFState
 
 TrtfStateStack = class(Tl3ProtoObjectRefList)
  function Peek: TddRTFState;
  function Pop: TddRTFState;
  procedure Push(anUC: Integer);
  function PeekPrev: TddRTFState;
 end;//TrtfStateStack
 
implementation

uses
 l3ImplUses
 , SysUtils
 , ddTypes
;

end.
