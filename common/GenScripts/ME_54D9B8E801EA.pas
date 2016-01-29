unit ddStyleSegment;

interface

uses
 l3IntfUses
 , ddTextSegment
 , k2Interfaces
 , ddCharacterProperty
;

type
 TddStyleSegment = class(TddTextSegment)
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aCHP: TddCharacterProperty;
   aParentCHP: TddCharacterProperty;
   LiteVersion: Boolean);
  function Clone: TddTextSegment;
  function SkipSegment(aDiffCHP: TddCharacterProperty;
   LiteVersion: Boolean): Boolean;
 end;//TddStyleSegment
 
implementation

uses
 l3ImplUses
 , ddTypes
 , ddRTFConst
 , l3String
 , l3Types
 , l3LogFont
 , l3FontManager
 , Windows
 , RTFtypes
 , l3Interfaces
 , evdStyles
;

end.
