unit l3MessageID;

interface

uses
 l3IntfUses
 , l3StringIDEx
 , Dialogs
 , l3Interfaces
 , Pl3StringIDExList
;

type
 Tl3MessageData = object
 end;//Tl3MessageData
 
 Tl3Message = object
 end;//Tl3Message
 
 Tl3MessageID = object(Tl3StringIDEx)
  {* Локализуемое сообщение }
 end;//Tl3MessageID
 
 Tl3MessageC = object(Tl3Message)
 end;//Tl3MessageC
 
 Pl3MessageID = ^Tl3MessageID;
 
implementation

uses
 l3ImplUses
 , Pl3MessageIDList
 , l3String
 , SysUtils
;

end.
