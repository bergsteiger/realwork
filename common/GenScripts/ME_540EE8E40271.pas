unit m3RootStreamManager;

interface

uses
 l3IntfUses
 , m3RootStreamManagerPrim
 , m3RootStream
 , l3Int64List
 , l3RevertedInt64List
 , m3FileRegion
 , l3CustomString
;

type
 Tm3RootStreamManager = class(Tm3RootStreamManagerPrim)
  procedure Create(aStream: Tm3RootStream);
  function DoAllocNewFATElement(aFromFreeChainOnly: Boolean): Int64;
  procedure DoRemoveFATElementAtPos(aPosition: Int64);
  procedure FreeAllocatedFATElements;
  procedure DoClearFATElement(aPosition: Int64);
  procedure ValidateAllocatedSize;
  procedure FreeAllocatedClusters;
  function HasLockedRegions: Boolean;
  procedure DoLockRegion(aForRead: Boolean;
   const aRegion: Tm3FileRegion);
  procedure DoUnlockRegion(aForRead: Boolean;
   const aRegion: Tm3FileRegion);
  function RootStorageFATElement: Int64;
  function AllocNewFATElement: Int64;
  procedure RemoveFATElementAtPos(aPosition: Int64);
  function ClusterBodySize: Int64;
  function AllocNewCluster: Int64;
  function ReadOnly: Boolean;
  procedure ReadData(aPosition: Int64;
   out aData;
   aSize: Integer);
  procedure WriteData(aPosition: Int64;
   const aData;
   aSize: Integer);
  function AllocatedStreamSize: Int64;
  procedure SetPositionAndValidateIt(aPosition: Int64;
   var thePosition: Int64);
  procedure ReloadHeader(aName: Tl3CustomString);
  procedure ReadDataAtCurrent(out aData;
   aSize: Integer);
 end;//Tm3RootStreamManager
 
implementation

uses
 l3ImplUses
 , SysUtils
 , m2COMLib
 , m3Exceptions
 , ActiveX
 , l3Base
 , ComObj
 , l3Types
 , l3Memory
 , l3Logger
 , l3SysUtils
 , Windows
;

end.
