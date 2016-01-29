unit l3ConstStrings1;

interface

uses
 l3IntfUses
 , l3StringIDEx
 , l3Interfaces
 , l3Types
;

type
 Tl3ConstStrings1 = class(_l3Searcher_, Il3ApplicationL10NStrings)
  procedure Define(const aName: AnsiString;
   const aRus: AnsiString;
   const anAlien: AnsiString);
 end;//Tl3ConstStrings1
 
implementation

uses
 l3ImplUses
 , l3String
 , SysUtils
;

end.
