unit ddDocumentProperty;

interface

uses
 l3IntfUses
 , ddPropertyObject
 , RTFtypes
 , k2Interfaces
;

type
 TddDocumentProperty = class(TddPropertyObject)
  procedure MergeWith(P: TddPropertyObject);
  procedure InheriteFrom(P: TddPropertyObject);
  procedure Write2Generator(const Generator: Ik2TagGenerator);
  procedure Reset;
  function Diff(P: TddPropertyObject;
   aForReader: Boolean): TddPropertyObject;
 end;//TddDocumentProperty
 
implementation

uses
 l3ImplUses
 , ddRTFConst
 , l3Defaults
;

end.
