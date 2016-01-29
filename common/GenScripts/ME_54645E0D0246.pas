unit ncsGetReadyToDeliveryTasksReply;

interface

uses
 l3IntfUses
 , ncsMessage
 , csGetReadyToDeliveryTasksReply_Const
 , evdTasksHelpers
 , k2Base
;

type
 TncsGetReadyToDeliveryTasksReply = class(TncsReply)
 end;//TncsGetReadyToDeliveryTasksReply
 
implementation

uses
 l3ImplUses
;

end.
