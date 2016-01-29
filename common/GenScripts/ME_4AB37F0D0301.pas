unit m4Word;

interface

uses
 l3IntfUses
 , l3_String
 , m4DictTypes
 , l3Interfaces
;

type
 Tm4Word = class(Tl3_String)
  {* Слово словаря }
  procedure Create(const aStr: Tl3WString;
   anID: Tm4WordID);
 end;//Tm4Word
 
implementation

uses
 l3ImplUses
;

end.
