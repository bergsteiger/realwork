unit ddSub;

interface

uses
 l3IntfUses
 , ddBaseObject
 , l3Base
 , k2Interfaces
;

type
 TddSub = class(TddBaseObject)
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aLiteVersion: Boolean);
 end;//TddSub
 
implementation

uses
 l3ImplUses
;

end.
