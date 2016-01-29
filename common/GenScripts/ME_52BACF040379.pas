unit ddBaseObject;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , k2Interfaces
;

type
 TddBaseObject = class(Tl3ProtoObject)
  procedure Assign(anObject: TddBaseObject);
  procedure Create;
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aLiteVersion: Boolean);
 end;//TddBaseObject
 
implementation

uses
 l3ImplUses
 , ddEVDTypesSupport
 , k2Tags
;

end.
