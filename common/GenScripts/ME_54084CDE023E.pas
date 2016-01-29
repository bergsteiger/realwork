unit m3StoreHeaderDataPrim;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3_String
 , m3RootStreamManagerPrimPrim
;

type
 Rm3StoreHeaderDataPrim = class of Tm3StoreHeaderDataPrim;
 
 Tm3StoreHeaderDataPrim = class(Tl3CProtoObject)
  function DataSize: Integer;
  function Modified: Boolean;
  procedure DoDoLoad;
  procedure DoDoSave;
  function SaveToExistingPlace: Int64;
  procedure Load;
  procedure Save;
  procedure CreateNew(aStream: Tm3RootStreamManagerPrimPrim);
  procedure Create(aStream: Tm3RootStreamManagerPrimPrim;
   aPosition: Int64;
   aIsReadOnly: Boolean;
   aName: Tl3_String);
  function SaveToNewPlace(var theRootSize: Int64): Int64;
  procedure DoSaveNextPosition(aNextPosition: Int64);
  procedure Lock;
  procedure Unlock;
  procedure CreatePrim(aStream: Tm3RootStreamManagerPrimPrim;
   aPosition: Int64;
   aIsReadOnly: Boolean;
   aName: Tl3_String;
   aNeedLock: Boolean);
  procedure CreateAtExistingPlace(aStream: Tm3RootStreamManagerPrimPrim;
   aPosition: Int64);
  procedure CreateForDeletion(aStream: Tm3RootStreamManagerPrimPrim;
   aPosition: Int64);
  procedure InitData(aNew: Boolean);
  procedure DoLoad;
  procedure DoSave;
  procedure Delete(aNextPosition: Int64);
 end;//Tm3StoreHeaderDataPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
 , m3Exceptions
 , m2COMLib
 , ActiveX
 , ComObj
 , l3Base
 , Windows
 , m3FileRegion
 , l3Interlocked
;

end.
