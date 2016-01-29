unit m3NewRootStreamManager;

interface

uses
 l3IntfUses
 , m3RootStreamManager
 , m3StoreHeaderDataPrim
 , ActiveX
 , m3RootStream
;

type
 Tm3NewRootStreamManager = class(Tm3RootStreamManager)
  function Make(const aStream: IStream): Tm3NewRootStreamManager;
  function DoAllocNewFATElement(aFromFreeChainOnly: Boolean): Int64;
  function StoreHeaderDataClass: Rm3StoreHeaderDataPrim;
  procedure DoRemoveFATElementAtPos(aPosition: Int64);
  procedure RemoveTOCBuffData(var ATOCBuffDataPosition: Int64);
  procedure DoClearFATElement(aPosition: Int64);
  function ClusterHeaderSize: Int64;
 end;//Tm3NewRootStreamManager
 
implementation

uses
 l3ImplUses
 , m3StoreHeaderData
 , m3StoreHeaderDataNew
 , m3RootStreamNew
 , m3StorageBlock
 , ComObj
 , m2COMLib
 , Windows
 , SysUtils
;

end.
