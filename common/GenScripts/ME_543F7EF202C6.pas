unit m3RootStreamManagerPrimPrim;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3Logger
 , l3CustomString
 , m3FileRegion
;

type
 Tm3RootStreamManagerPrimPrim = class(Tl3CProtoObject)
  procedure ReadData(aPosition: Int64;
   out aData;
   aSize: Integer);
  procedure WriteData(aPosition: Int64;
   const aData;
   aSize: Integer);
  function AllocatedStreamSize: Int64;
  procedure SetPositionAndValidateIt(aPosition: Int64;
   var thePosition: Int64);
  procedure Create(aLogger: Tl3Logger);
  function IsValidLink(aPosition: Int64;
   aName: Tl3CustomString): Boolean;
  function DoIsValidPosition(aPosition: Int64;
   aName: Tl3CustomString): Boolean;
  function IsValidPosition(aPosition: Int64;
   aName: Tl3CustomString): Boolean;
  procedure DoUnlockRegion(aForRead: Boolean;
   const aRegion: Tm3FileRegion);
  procedure DoLockRegion(aForRead: Boolean;
   const aRegion: Tm3FileRegion);
  procedure LockRegion(aForRead: Boolean;
   const aRegion: Tm3FileRegion);
  procedure UnlockRegion(aForRead: Boolean;
   const aRegion: Tm3FileRegion);
  procedure ReloadHeader(aName: Tl3CustomString);
  procedure ReadDataAtCurrent(out aData;
   aSize: Integer);
  function ClusterBodySize: Int64;
  function AllocNewCluster: Int64;
  function ClusterHeaderSize: Int64;
  function ClusterSize: Int64;
  procedure RemoveTOCBuffData(var ATOCBuffDataPosition: Int64);
 end;//Tm3RootStreamManagerPrimPrim
 
implementation

uses
 l3ImplUses
 , m2COMLib
 , SysUtils
 , l3Base
;

end.
