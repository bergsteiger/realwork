unit ncsOneFileDeliverer;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ncsMessageInterfaces
 , ncsTaskedFileDesc
 , Classes
 , ddProgressObj
 , ncsFileDesc
 , ncsMessage
;

type
 TncsOneFileDeliverer = class(Tl3ProtoObject, IncsExecutor, IncsMessageExecutorFactory)
  procedure Create(const aTransporter: IncsTransporter;
   const aTaskID: AnsiString;
   const aLocalPath: AnsiString;
   aRemoteDesc: TncsFileDesc);
  function CheckContinue(aRemoteDesc: TncsFileDesc): Boolean;
  procedure InitNew(aRemoteDesc: TncsFileDesc);
  function LocalControlFileName: AnsiString;
  function LocalPartialFileName: AnsiString;
  procedure SaveControl;
  procedure CommitDelivery;
  function LocalFileName: AnsiString;
  function DoProcess(aProgressor: TddProgressObject): Boolean; overload;
  procedure Execute(const aContext: TncsExecuteContext);
  function MakeExecutor(aMessage: TncsMessage): IncsExecutor;
 end;//TncsOneFileDeliverer
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Stream
 , l3Types
 , l3CRCUtils
 , ncsGetFilePartReply
 , ncsGetFilePart
 , Math
 , ncsPushFilePart
 , ncsMessageExecutorFactory
 , ncsProfile
 , l3Base
 , l3FileUtils
;

end.
