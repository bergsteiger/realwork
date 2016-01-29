unit ncsGetPartialTaskDescriptionExecutor;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ncsMessageInterfaces
;

type
 TncsGetPartialTaskDescriptionExecutor = class(Tl3ProtoObject, IncsExecutor)
  procedure Create(const aBasePath: AnsiString;
   const aFileName: AnsiString);
  function Make(const aBasePath: AnsiString;
   const aFileName: AnsiString): IncsExecutor;
  procedure Execute(const aContext: TncsExecuteContext);
 end;//TncsGetPartialTaskDescriptionExecutor
 
implementation

uses
 l3ImplUses
 , ncsGetTaskDescriptionReply
 , ncsGetPartialTaskDescription
 , SysUtils
 , ncsFileDesc
 , l3Stream
 , Classes
 , l3Types
 , l3CRCUtils
;

end.
