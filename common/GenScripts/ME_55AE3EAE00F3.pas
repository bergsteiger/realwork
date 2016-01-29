unit L3XMLWriterTest;

interface

uses
 l3IntfUses
 , BaseTest
;

type
 TL3XMLWriterTest = class(TBaseTest)
  procedure BuildXML;
  procedure DoIt;
 end;//TL3XMLWriterTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , l3Interfaces
 , l3XMLWriter
 , SysUtils
 , l3Filer
 , l3Types
;

end.
