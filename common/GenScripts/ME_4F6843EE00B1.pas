unit ddBorder;

interface

uses
 l3IntfUses
 , ddPropertyObject
 , ddTypes
 , ddBorderPart
 , RTFtypes
 , k2Interfaces
;

type
 TddBorderPartArray = array [TddBorderParts] of TddBorderPart;
 
 TddBorder = class(TddPropertyObject)
  function HasAllFramePart: Boolean;
  procedure MergeWith(P: TddPropertyObject);
  procedure InheriteFrom(P: TddPropertyObject);
  procedure Write2Generator(const Generator: Ik2TagGenerator);
  procedure Reset;
  function Diff(P: TddPropertyObject;
   aForReader: Boolean): TddPropertyObject;
 end;//TddBorder
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Base
 , evdFrame_Const
;

end.
