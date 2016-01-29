unit CustomAutoTestsSuite;

interface

uses
 l3IntfUses
 , TestFrameWork
;

type
 TCustomAutoTestSuite = class(TTestSuite)
  function GetDataFolder: AnsiString;
   {* Возвращает папку с данными для создания тестов. }
  function GetExt: AnsiString;
  procedure CheckExists(const aDirName: AnsiString);
  function Try2FindTest(const aTestName: AnsiString): Boolean;
 end;//TCustomAutoTestSuite
 
implementation

uses
 l3ImplUses
 , KTestRunner
 , SysUtils
 , l3Base
 , l3FileUtils
;

end.
