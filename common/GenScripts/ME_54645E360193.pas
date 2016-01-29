unit ncsFileTransferReg;

interface

uses
 l3IntfUses
;

implementation

uses
 l3ImplUses
 , ncsMessageFactory
 , ncsGetReadyToDeliveryTasks
 , ncsGetTaskDescription
 , ncsTaskProgress
 , ncsDeliveryResult
 , ncsGetFilePart
 , nscMessagesReg
 , ncsCorrectFolder
 , ncsGetReadyToDeliveryTasksReply
 , ncsGetTaskDescriptionReply
 , ncsGetFilePartReply
 , ncsPushFilePart
;

end.
