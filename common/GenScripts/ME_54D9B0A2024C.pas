unit ddObjectSegment;

interface

uses
 l3IntfUses
 , ddTextSegment
 , k2Interfaces
 , ddCharacterProperty
;

type
 TddObjectSegment = class(TddTextSegment)
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aCHP: TddCharacterProperty;
   aParentCHP: TddCharacterProperty;
   LiteVersion: Boolean);
  function SkipSegment(aDiffCHP: TddCharacterProperty;
   LiteVersion: Boolean): Boolean;
 end;//TddObjectSegment
 
implementation

uses
 l3ImplUses
 , ddTypes
;

end.
