unit ncsFileListDeliverer;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ncsOneFileDelivererList
 , ncsMessageInterfaces
 , ddProgressObj
 , ncsFileDescHelper
 , SysUtils
;

type
 EncsEmptyResults = class(Exception)
 end;//EncsEmptyResults
 
 TncsFileListDeliverer = class(Tl3ProtoObject)
  procedure PrepareDescription(const aList: FileDescHelper);
  procedure Create(const aTransporter: IncsTransporter;
   aProgressor: TddProgressObject;
   const aTaskID: AnsiString;
   const aLocalPath: AnsiString);
  function Execute(const aList: FileDescHelper): Boolean;
 end;//TncsFileListDeliverer
 
implementation

uses
 l3ImplUses
 , l3Interfaces
 , l3FileUtils
 , l3Base
 , ncsOneFileDeliverer
 , ncsFileDesc
;

end.
