unit ddHyperlinkTarget;

interface

uses
 l3IntfUses
 , ddBaseObject
 , k2Interfaces
;

type
 TddHyperlinkTarget = class(TddBaseObject)
  procedure Create(aTypeID: Integer;
   aDocID: Integer;
   aSubID: Integer);
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aLiteVersion: Boolean);
 end;//TddHyperlinkTarget
 
implementation

uses
 l3ImplUses
;

end.
