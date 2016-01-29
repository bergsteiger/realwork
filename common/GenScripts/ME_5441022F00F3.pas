unit m3ReadOnlyRootStreamManager;

interface

uses
 l3IntfUses
 , m3RootStreamManagerPrim
 , m3FileRegion
 , m3StoreHeaderDataPrim
 , l3CustomString
;

type
 Tm3ReadOnlyRootStreamManager = class(Tm3RootStreamManagerPrim)
  procedure Create(anOther: Tm3RootStreamManagerPrim);
  procedure DoLockRegion(aForRead: Boolean;
   const aRegion: Tm3FileRegion);
  procedure DoUnlockRegion(aForRead: Boolean;
   const aRegion: Tm3FileRegion);
  function StoreHeaderDataClass: Rm3StoreHeaderDataPrim;
  function RootStorageFATElement: Int64;
  procedure RemoveTOCBuffData(var ATOCBuffDataPosition: Int64);
  function AllocNewFATElement: Int64;
  procedure RemoveFATElementAtPos(aPosition: Int64);
  function ClusterHeaderSize: Int64;
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
 end;//Tm3ReadOnlyRootStreamManager
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
