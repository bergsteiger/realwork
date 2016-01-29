unit ncsTaskSendReg;

interface

uses
 l3IntfUses
;

implementation

uses
 l3ImplUses
 , ncsMessageFactory
 , nscMessagesReg
 , ncsSendTask
 , ncsGetTaskDescriptionReply
 , ncsPushFilePart
 , ncsGetFilePartReply
 , ncsSendTaskReply
 , ncsGetPartialTaskDescription
 , ncsGetFilePart
;

end.
