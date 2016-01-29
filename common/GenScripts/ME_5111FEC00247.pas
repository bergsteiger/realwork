unit ddCellProperty;

interface

uses
 l3IntfUses
 , ddPropertyObject
 , ddBorder
 , ddTypes
 , k2Interfaces
;

type
 TddCellProperty = class(TddPropertyObject)
  procedure Create(aClearBorder: TddClearBoder);
  procedure Assign(aCellProperty: TddCellProperty);
  function IsCellOffseDefault: Boolean;
  procedure MergeWith(P: TddPropertyObject);
  procedure InheriteFrom(P: TddPropertyObject);
  procedure Write2Generator(const Generator: Ik2TagGenerator);
  procedure Reset;
  function Diff(P: TddPropertyObject;
   aForReader: Boolean): TddPropertyObject;
 end;//TddCellProperty
 
implementation

uses
 l3ImplUses
 , l3Base
 , ddBase
;

end.
