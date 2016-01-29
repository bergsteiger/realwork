unit l3ChangingWithLock.imp;

interface

uses
 l3IntfUses
;

type
 _l3ChangingWithLock_ = class(_l3ChangingChangedNotifier_)
  procedure LockNotification;
  procedure UnLockNotification;
 end;//_l3ChangingWithLock_
 
implementation

uses
 l3ImplUses
 , l3Types
 , l3Interfaces
 , l3Base
 , SysUtils
;

end.
