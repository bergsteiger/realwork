unit ArchiStorageTest;

interface

uses
 l3IntfUses
 , BaseTest
 , m3DBInterfaces
;

type
 TArchiStorageTest = class(TBaseTest)
  procedure DoIt;
  procedure DoBase(const aDB: Im3DB);
  function NeedTestRenaming: Boolean;
 end;//TArchiStorageTest
 
implementation

uses
 l3ImplUses
 , m3DB
 , m3StorageInterfaces
 , SysUtils
 , l3FileUtils
 , l3Base
 , l3Interfaces
 , l3Stream
 , l3Types
 , m3SplittedFileStream
 , TestFrameWork
;

end.
