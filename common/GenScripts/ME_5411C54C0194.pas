unit m3StorageBlock;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3Memory
 , m3RootStreamManagerPrimPrim
 , l3_String
 , m3StoreHeaderDataPrim
 , m3FileRegion
;

type
 Tm3StorageBlockHeaderData = record
 end;//Tm3StorageBlockHeaderData
 
 Tm3StorageBlockHeader = record
 end;//Tm3StorageBlockHeader
 
 Tm3LockedRegion = record
 end;//Tm3LockedRegion
 
 Tm3StorageBlock = class(Tl3CProtoObject)
  procedure Create(aHeaderData: Tm3StoreHeaderDataPrim);
  procedure Save;
  function Modified: Boolean;
  procedure Load;
  function LockData(aForRead: Boolean): Tm3LockedRegion;
  procedure UnlockData(const aPrevRegion: Tm3LockedRegion);
  function CreatePrev: Tm3StorageBlock;
  function CheckBody: PANSIChar;
  function HeaderModified: Boolean;
  function Read(aBuffer: PANSIChar;
   aSizeToRead: Integer): Integer;
  function Write(aBuffer: PANSIChar;
   aSizeToWrite: Integer): Integer;
  function IsFull: Boolean;
  function CreateNext: Tm3StorageBlock;
  procedure CreatePrim(aManager: Tm3RootStreamManagerPrimPrim;
   aName: Tl3_String;
   aReadOnly: Boolean;
   aPosition: Int64;
   aPrevBlock: Tm3StorageBlock;
   anIndex: Int64);
  procedure SetPositionInStream(aPosition: Int64);
 end;//Tm3StorageBlock
 
implementation

uses
 l3ImplUses
 , SysUtils
 , m2S32Lib
 , m2S64Lib
 , ComObj
 , Windows
 , l3Base
 , m3Exceptions
 , m2MemLib
;

type
 Rm3StorageBlock = class of Tm3StorageBlock;
 
end.
