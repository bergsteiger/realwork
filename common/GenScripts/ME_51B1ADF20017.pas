unit CheckingFilesInFolderTest;

interface

uses
 l3IntfUses
 , BaseTest
;

type
 TCheckingFilesInFolderTest = class(TBaseTest)
  procedure DoIt;
  procedure DoDoit;
 end;//TCheckingFilesInFolderTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , l3FileUtils
 , SysUtils
;

end.
