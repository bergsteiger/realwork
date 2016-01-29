unit RegExpTest;

interface

uses
 l3IntfUses
 , BaseTest
;

type
 TRegExpTest = class(TBaseTest)
  procedure DoIt;
 end;//TRegExpTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , l3RegEx
 , l3String
 , SysUtils
 , l3IniFile
 , l3Parser
 , l3Base
 , l3Interfaces
 , l3Filer
;

end.
