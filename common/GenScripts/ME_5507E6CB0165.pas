unit ncsClientParamsStorage;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , htInterfaces
 , pgInterfaces
 , ddAppConfig
;

type
 TncsClientParamsStorage = class(Tl3ProtoObject, IdaParamsStorage, IhtParamsStorage, IpgParamsStorage)
  function Make: IdaParamsStorage;
  function ProviderKey: AnsiString;
  procedure InitStorage;
  function Login: AnsiString;
  function Password: AnsiString;
  function DocStoragePath: AnsiString;
  function DocImagePath: AnsiString;
  function HomeDirPath: AnsiString;
  function StationName: AnsiString;
  function TablePath: AnsiString;
  function LockPath: AnsiString;
  function TempPath: AnsiString;
  function StationErrorMessage: AnsiString;
  function TablePathErrorMessage: AnsiString;
  function LockPathErrorMessage: AnsiString;
  function OuterConfigEdit: Boolean;
  procedure BuildConfig(aConfig: TddAppConfiguration;
   const aProviderKey: AnsiString); overload;
  function DataServerHostName: AnsiString;
  function DataServerPort: Integer;
 end;//TncsClientParamsStorage
 
implementation

uses
 l3ImplUses
 , l3IniFile
 , l3Utils
 , l3Base64
 , l3FileUtils
 , SysUtils
;

end.
