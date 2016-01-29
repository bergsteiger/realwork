unit m3StgMgr;

interface

uses
 l3IntfUses
;

type
 Tm3StorageManager = class
 end;//Tm3StorageManager
 
 Tm3FullModeStorageManager = class(Tm3StorageManager)
 end;//Tm3FullModeStorageManager
 
 Tm3ReadModeStorageManager = class(Tm3StorageManager)
 end;//Tm3ReadModeStorageManager
 
implementation

uses
 l3ImplUses
 , m3ArchiveStorage
 , m3StorageService
 , m3FileStream
 , m3SplittedFileStream
;

end.
