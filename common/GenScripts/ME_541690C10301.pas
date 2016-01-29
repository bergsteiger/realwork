unit ddFillAACStack;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , ddTypes
;

type
 TddFillAACStack = class(Tl3SimpleDataContainer)
  procedure Push(aValue: TddFillAAC);
  function Pop: TddFillAAC;
  function Peek: TddFillAAC;
 end;//TddFillAACStack
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
