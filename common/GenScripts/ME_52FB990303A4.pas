unit csNotifyObj;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , CsNotification
;

type
 TCsOnNotificationProc = function(aNotificationType: TCsNotificationType;
  aNumber: Integer;
  const aText: AnsiString): Boolean of object;
 
 TcsNotifyObj = class(Tl3ProtoObject)
  procedure Create(aProc: TCsOnNotificationProc);
 end;//TcsNotifyObj
 
implementation

uses
 l3ImplUses
;

end.
