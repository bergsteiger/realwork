unit ddBreak;

interface

uses
 l3IntfUses
 , ddDocumentAtom
 , RTFtypes
 , ddSectionProperty
 , k2Interfaces
 , ddCustomDestination
;

type
 TddBreak = class(TddDocumentAtom)
  function HasDefaultParams: Boolean;
  procedure Write2Generator(const Generator: Ik2TagGenerator;
   aNeedProcessRow: Boolean;
   LiteVersion: Boolean);
 end;//TddBreak
 
implementation

uses
 l3ImplUses
 , PageBreak_Const
 , SectionBreak_Const
 , k2Tags
 , l3Interfaces
 , l3MinMax
 , SysUtils
 , ddDocumentProperty
;

end.
