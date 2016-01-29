unit k2CustomFileGenerator;

interface

uses
 l3IntfUses
 , k2CustomStackGeneratorEx
;

type
 Tk2CustomFileGenerator = class(Tk2CustomStackGeneratorEx)
  {* Базовый писатель тегов в файл. }
  procedure OutEOL;
   {* Выводит конец строки. }
 end;//Tk2CustomFileGenerator
 
implementation

uses
 l3ImplUses
;

end.
