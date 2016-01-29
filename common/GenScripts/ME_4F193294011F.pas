unit StgIndexTest;

interface

uses
 l3IntfUses
 , BaseTest
;

type
 TStgIndexTest = class(TBaseTest)
  procedure DoIt;
 end;//TStgIndexTest
 
implementation

uses
 l3ImplUses
 , m3SplittedFileStream
 , TestFrameWork
 , m3StorageIndexAdapter
 , SysUtils
 , l3FileUtils
 , m3DB
 , m3DBInterfaces
 , m4DBInterfaces
 , m4DB
 , l3Base
 , m3StgMgr
;

end.
