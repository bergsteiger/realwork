unit m3StoreHeader;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , m3StoreHeaderDataPrim
 , m3RootStreamManagerPrim
 , l3_String
 , l3Base
 , m3StorageInterfaces
;

type
 Tm3StoreHeader = class(Tl3CProtoObject)
  {* Описатель элемента хранилища (потока или подхранилища) }
  procedure CreatePrim(aName: Tl3String;
   aRootStreamManager: Tm3RootStreamManagerPrim;
   aData: Tm3StoreHeaderDataPrim);
  function Create(anAccess: Tm3StoreAccess;
   aName: Tl3String;
   aRootStreamManager: Tm3RootStreamManagerPrim;
   aTOCItemDataPosition: Int64): Tm3StoreHeader;
 end;//Tm3StoreHeader
 
implementation

uses
 l3ImplUses
 , SysUtils
 , ActiveX
;

end.
