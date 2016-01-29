unit SysUtils;

interface

uses
 l3IntfUses
;

type
 TMultiReadExclusiveWriteSynchronizer = class
  {* TMultiReadExclusiveWriteSynchronizer protects memory in a multi-threaded application. }
 end;//TMultiReadExclusiveWriteSynchronizer
 
 TFileName = type AnsiString;
  {* TFileName is a string that represents a file name. }
 
 Exception = class(TObject)
  {* Base Exception. }
 end;//Exception
 
 ExceptClass = class of Exception;
 
 EOSError = class(Exception)
 end;//EOSError
 
 TFormatSettings = record
  {* TFormatSettings defines a thread-safe string formatting context. }
 end;//TFormatSettings
 
 TProcedure = procedure;
  {* TProcedure is used as the type for generic procedures that do not have arguments. }
 
 EAbort = class
 end;//EAbort
 
 EAssertionFailed = class(Exception)
 end;//EAssertionFailed
 
 TSearchRec = record
  {* TSearchRec defines file information searched for by FindFirst or FindNext. }
 end;//TSearchRec
 
 EOutOfMemory = class
 end;//EOutOfMemory
 
implementation

uses
 l3ImplUses
;

end.
