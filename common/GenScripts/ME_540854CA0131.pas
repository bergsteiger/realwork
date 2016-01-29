unit m3StoreHeaderDataNew;

interface

uses
 l3IntfUses
 , m3StoreHeaderDataPrim
;

type
 Tm3StoreHeaderDataRecNew = record
 end;//Tm3StoreHeaderDataRecNew
 
 Tm3StoreHeaderDataNew = class(Tm3StoreHeaderDataPrim)
  function DataSize: Integer;
  function Modified: Boolean;
  function rRealSizePrim: Int64;
  function FirstClusterPrim: Int64;
  function rTOCItemListPositionPrim: Int64;
  procedure DoDoLoad;
  procedure DoDoSave;
  procedure DoSaveNextPosition(aNextPosition: Int64);
  procedure InitData(aNew: Boolean);
 end;//Tm3StoreHeaderDataNew
 
implementation

uses
 l3ImplUses
 , m2MemLib
 , m2COMLib
 , ActiveX
 , m3Exceptions
;

end.
