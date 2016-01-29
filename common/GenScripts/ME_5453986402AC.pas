unit ncsMessage;

interface

uses
 l3IntfUses
 , l3Variant
 , csMessage_Const
 , evdNcsTypes
 , k2Base
 , csDIsconnect_Const
 , csDIsconnectReply_Const
;

type
 TncsMessage = class(Tl3Tag)
  function GetTaggedDataType: Tk2Type;
 end;//TncsMessage
 
 TncsMessageClass = class of TncsMessage;
 
 TncsInvalidMessage = class(TncsMessage)
 end;//TncsInvalidMessage
 
 TncsReply = class(TncsMessage)
  procedure Create(aMessage: TncsMessage);
 end;//TncsReply
 
 TncsDIsconnect = class(TncsMessage)
 end;//TncsDIsconnect
 
 TncsDIsconnectReply = class(TncsReply)
 end;//TncsDIsconnectReply
 
implementation

uses
 l3ImplUses
 , l3Utils
 , SysUtils
;

end.
