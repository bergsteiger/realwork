unit m4WordList;

interface

uses
 l3IntfUses
 , l3StringList
 , m4DictTypes
 , m4Word
 , l3Interfaces
;

type
 Tm4WordList = class(Tl3StringList)
  {* Список слов }
  function AddWord(const aStr: Tl3WString): Tm4WordID;
  procedure Create;
 end;//Tm4WordList
 
implementation

uses
 l3ImplUses
 , l3Types
 , SysUtils
;

end.
