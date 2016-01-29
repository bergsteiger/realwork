unit l3ChangingChangedNotifier.imp;

interface

uses
 l3IntfUses
;

type
 _l3ChangingChangedNotifier_ = class(_l3Notifier_, Ml3Changing)
 end;//_l3ChangingChangedNotifier_
 
implementation

uses
 l3ImplUses
 , l3Types
 , l3Interfaces
 , l3Base
 , SysUtils
;

end.
