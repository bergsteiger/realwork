unit DiffTest;

interface

uses
 l3IntfUses
 , BaseTest
;

type
 TDiffTest = class(TBaseTest)
  procedure DoIt;
 end;//TDiffTest
 
implementation

uses
 l3ImplUses
 , l3Diff
 , l3DiffSupport
 , TestFrameWork
 , l3Filer
 , SysUtils
;

end.
