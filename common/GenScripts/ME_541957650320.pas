unit DataBaseTester;

interface

uses
 l3IntfUses
 , Classes
 , m3DBInterfaces
;

type
 TDataBaseTester = class(TThread)
  procedure Create(CreateSuspended: Boolean;
   const aDataPath: AnsiString;
   const aBaseName: AnsiString);
  procedure DoBase(const aDB: Im3DB);
  procedure Execute;
 end;//TDataBaseTester
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
 , m3StorageInterfaces
 , l3Stream
 , l3FileUtils
 , m3DB
 , l3Base
;

end.
