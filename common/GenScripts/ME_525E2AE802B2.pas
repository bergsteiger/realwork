unit ddBorderPart;

interface

uses
 l3IntfUses
 , ddBaseObject
 , RTFtypes
 , k2Interfaces
;

type
 TddBorderPart = class(TddBaseObject)
  procedure Clear;
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aLiteVersion: Boolean);
 end;//TddBorderPart
 
implementation

uses
 l3ImplUses
 , Graphics
;

end.
