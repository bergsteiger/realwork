unit m3BaseStore.imp;

interface

uses
 l3IntfUses
 , m2InternalInterfaces
 , m3StorageInterfaces
;

type
 _m3BaseStore_ = class(Im2StoreStat)
  function DoGetPosition: Int64;
  function DoGetSize: Int64;
  function DoGetLocksSupported: Integer;
  function DoGetAccess: Integer;
  function DoGetName: WideString;
  procedure Create(anAccess: Tm3StoreAccess);
  function ReadOnly: Boolean;
   {* только для чтения? }
  function Access: LongInt;
   {* режим доступа }
  function LocksSupported: LongInt;
   {* какие замки доступны? }
  function Size: Int64;
   {* размер }
  function Position: Int64;
   {* Позиция }
  function Name: WideString;
 end;//_m3BaseStore_
 
implementation

uses
 l3ImplUses
 , ActiveX
;

end.
