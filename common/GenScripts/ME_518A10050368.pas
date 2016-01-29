unit ddRowProperty;

interface

uses
 l3IntfUses
 , ddPropertyObject
 , ddBorder
 , ddTypes
 , k2Interfaces
;

type
 TddRowProperty = class(TddPropertyObject)
  procedure MergeWith(P: TddPropertyObject);
  procedure InheriteFrom(P: TddPropertyObject);
  procedure Write2Generator(const Generator: Ik2TagGenerator);
  procedure Reset;
  function Diff(P: TddPropertyObject;
   aForReader: Boolean): TddPropertyObject;
 end;//TddRowProperty
 
implementation

uses
 l3ImplUses
 , l3Base
 , ddCellProperty
;

end.
