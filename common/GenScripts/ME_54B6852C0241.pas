unit l3CriticalSectionHolderPrim.imp;

interface

uses
 l3IntfUses
 , SyncObjs
;

type
 _l3CriticalSectionHolderPrim_ = class
  procedure Lock;
  procedure Unlock;
  procedure CreateCS;
  procedure FreeCS;
 end;//_l3CriticalSectionHolderPrim_
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
