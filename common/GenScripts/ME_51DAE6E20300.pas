unit MemorySizeTest;

interface

uses
 l3IntfUses
 , TestFrameWork
;

type
 TMemorySizeTest = class(TTestCase)
  procedure DoIt;
 end;//TMemorySizeTest
 
implementation

uses
 l3ImplUses
 , l3MemorySizeUtils
 , SysUtils
;

end.
