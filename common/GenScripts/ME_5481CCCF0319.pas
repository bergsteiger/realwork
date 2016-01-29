unit m3PrimStream;

interface

uses
 l3IntfUses
 , l3BaseStream
 , Classes
 , m3StorageInterfaces
 , l3Interfaces
;

type
 Tm3PrimStream = class(Tl3Stream)
  procedure DoRead(aBuff: Pointer;
   aSize: Integer;
   var theResult: Integer;
   var theReturn: hResult);
  procedure DoWrite(aBuff: Pointer;
   aSize: Integer;
   var theResult: Integer;
   var theReturn: hResult);
  procedure DoSeek(anOffset: Int64;
   anOrigin: TSeekOrigin;
   var theResult: Int64;
   var theReturn: hResult);
  procedure DoSetSize(aSize: Int64;
   var theReturn: hResult);
  procedure LockRegion(anOffset: Int64;
   aSize: Int64;
   aLockType: Integer;
   var theReturn: hResult);
  procedure UnlockRegion(anOffset: Int64;
   aSize: Int64;
   aLockType: Integer;
   var theReturn: hResult);
  procedure Stat(var theStatStg: TStatStg;
   aStatFlag: Integer;
   var theReturn: hResult);
  procedure Commit(aFlags: Integer;
   var theReturn: hResult);
  procedure Revert(var theReturn: hResult);
  procedure Clone(var theStream: IStream;
   var theReturn: hResult);
  procedure Create(anAccess: Tm3StoreAccess);
 end;//Tm3PrimStream
 
implementation

uses
 l3ImplUses
 , Windows
 , m2COMLib
 , ActiveX
 , ComObj
;

end.
