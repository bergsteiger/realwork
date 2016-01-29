unit ddPropertyObject;

interface

uses
 l3IntfUses
 , l3Base
 , k2Interfaces
;

type
 TddPropertyObject = class(Tl3Base)
  procedure Clear;
  procedure MergeWith(P: TddPropertyObject);
  procedure InheriteFrom(P: TddPropertyObject);
  procedure Write2Generator(const Generator: Ik2TagGenerator);
  procedure Reset;
  function JoinWith(P: TObject): LongInt;
  function Diff(P: TddPropertyObject;
   aForReader: Boolean): TddPropertyObject;
  procedure AssignFrom(anOther: TddPropertyObject);
  function Clone: Pointer;
 end;//TddPropertyObject
 
implementation

uses
 l3ImplUses
;

end.
