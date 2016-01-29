unit ncsGetFilePartExecutor;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ncsMessageInterfaces
;

type
 TncsGetFilePartExecutor = class(Tl3ProtoObject, IncsExecutor)
  procedure Create(const aBasePath: AnsiString;
   const aFileName: AnsiString);
  function Make(const aBasePath: AnsiString;
   const aFileName: AnsiString): IncsExecutor;
  procedure Execute(const aContext: TncsExecuteContext);
 end;//TncsGetFilePartExecutor
 
implementation

uses
 l3ImplUses
 , ncsPushFilePart
 , Math
 , SysUtils
 , l3Types
 , Classes
 , l3Stream
 , ncsGetFilePartReply
 , ncsGetFilePart
;

end.
