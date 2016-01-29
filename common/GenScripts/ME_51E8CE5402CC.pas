unit ddTab;

interface

uses
 l3IntfUses
 , ddBaseObject
 , ddTypes
 , k2Interfaces
;

type
 TddTab = class(TddBaseObject)
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aLiteVersion: Boolean);
 end;//TddTab
 
implementation

uses
 l3ImplUses
 , l3Interfaces
 , l3Chars
;

end.
