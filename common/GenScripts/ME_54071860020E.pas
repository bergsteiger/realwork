unit m3StoreHeaderData;

interface

uses
 l3IntfUses
 , m3StoreHeaderDataPrim
;

type
 Tm3StoreHeaderDataRec = record
  {* Ёлемент оглавлени€ IStorage }
 end;//Tm3StoreHeaderDataRec
 
 Tm3StoreHeaderData = class(Tm3StoreHeaderDataPrim)
  function DataSize: Integer;
  function Modified: Boolean;
  function rRealSizePrim: Int64;
  function FirstClusterPrim: Int64;
  function rTOCItemListPositionPrim: Int64;
  procedure DoDoLoad;
  procedure DoDoSave;
  procedure DoSaveNextPosition(aNextPosition: Int64);
  procedure InitData(aNew: Boolean);
 end;//Tm3StoreHeaderData
 
implementation

uses
 l3ImplUses
 , m2MemLib
 , l3Base
 , ActiveX
 , m2COMLib
 , m3Exceptions
;

end.
