unit ddHyperlink;

interface

uses
 l3IntfUses
 , ddTextSegment
 , k2Interfaces
 , ddCharacterProperty
;

type
 TddHyperlink = class(TddTextSegment)
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aCHP: TddCharacterProperty;
   aParentCHP: TddCharacterProperty;
   LiteVersion: Boolean);
  function Clone: TddTextSegment;
  function SkipSegment(aDiffCHP: TddCharacterProperty;
   LiteVersion: Boolean): Boolean;
 end;//TddHyperlink
 
implementation

uses
 l3ImplUses
 , ddTypes
 , ddHyperlinkTarget
;

end.
