unit MultyOperationTest;

interface

uses
 l3IntfUses
 , BaseTest
;

type
 TMultyOperationTest = class(TBaseTest)
  procedure DoIt();
  procedure ClearBase(const aBasePath: AnsiString);
 end;//TMultyOperationTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , DataBaseTester
 , SysUtils
 , m3SplittedFileStream
 , m3DBInterfaces
 , m3DB
;

end.
