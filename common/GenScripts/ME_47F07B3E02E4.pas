unit l3Notifier.imp;

interface

uses
 l3IntfUses
;

type
 _l3Notifier_ = class(_l3NotifierBase_)
  procedure CallNotify(aOperation: Integer;
   aIndex: Integer);
 end;//_l3Notifier_
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

end.
