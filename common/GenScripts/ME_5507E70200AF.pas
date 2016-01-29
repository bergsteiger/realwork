unit ncsServerParamsStorage;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , htInterfaces
 , ddAppConfig
;

type
 TncsServerParamsStorage = class(Tl3ProtoObject, IdaParamsStorage, IhtParamsStorage)
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
 end;//TncsServerParamsStorage
 
implementation

uses
 l3ImplUses
 , l3FileUtils
 , StrUtils
 , ddUtils
 , SysUtils
 , evdTaskTypes
 , ddAppConfigConst
 , ddAppConfigStrings
 , ddAppConfigTypes
 , l3Base
 , pgDataProviderFactory
 , htDataProviderFactory
;

end.
