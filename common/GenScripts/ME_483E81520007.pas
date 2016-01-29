unit k2CustomFileParser;

interface

uses
 l3IntfUses
 , k2CustomFileReader
;

type
 Tk2CustomFileParser = class(Tk2CustomFileReader)
  {* Базовый класс "читателей" тегов, обладающий парсером. }
 end;//Tk2CustomFileParser
 
implementation

uses
 l3ImplUses
;

end.
