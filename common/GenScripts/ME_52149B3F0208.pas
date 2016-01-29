unit ddAppConfigVersions;

interface

uses
 l3IntfUses
 , ddConfigStorages
 , l3Base
 , l3RecList
;

type
 Tdd_acVersionUpgradeProc = procedure(const aStorage: IddConfigStorage);
 
 Tdd_acVersionHandler = record
 end;//Tdd_acVersionHandler
 
 TddAppConfigVersionManager = class(Tl3Base)
  function FindHandler(aFromVersion: Integer;
   out aHandler: Tdd_acVersionHandler): Boolean;
  procedure AddHandler(aFromVersion: Integer;
   aToVersion: Integer;
   aProc: Tdd_acVersionUpgradeProc);
  procedure Upgrade(aFromVersion: Integer;
   aToVersion: Integer;
   const aStorage: IddConfigStorage);
 end;//TddAppConfigVersionManager
 
 Pdd_acVersionHandler = ^Tdd_acVersionHandler;
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
