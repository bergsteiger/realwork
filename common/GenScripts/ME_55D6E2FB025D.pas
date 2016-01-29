unit pgDataProviderFactory;

interface

uses
 l3IntfUses
 , daDataProviderFactory
 , daDataProviderParams
 , ddAppConfig
 , daInterfaces
;

type
 TpgDataProviderFactory = class(TdaDataProviderFactory)
  function Key: AnsiString;
  function MakeFromConfig: TdaDataProviderParams;
  procedure SaveToConfig(aParams: TdaDataProviderParams);
  function ParamType: TdaDataProviderParamsClass;
  procedure FillOutConfig(aConfig: TddAppConfiguration;
   aEtalon: TdaDataProviderParams;
   out aParams: TdaDataProviderParams);
  procedure FillInConfig(aConfig: TddAppConfiguration;
   aParams: TdaDataProviderParams;
   ForInfoOnly: Boolean);
  procedure BuildConfig(aConfig: TddAppConfiguration;
   const aProviderKey: AnsiString;
   ForInfoOnly: Boolean);
  procedure LoadDBVersion(aParams: TdaDataProviderParams);
  function DoMakeProvider(aParams: TdaDataProviderParams;
   ForCheckLogin: Boolean;
   AllowClearLocks: Boolean): IdaDataProvider;
  procedure LoginCheckSucceed(aParams: TdaDataProviderParams);
 end;//TpgDataProviderFactory
 
implementation

uses
 l3ImplUses
 , pgDataProviderParams
 , pgDataProvider
 , pgInterfaces
 , ddAppConfigTypes
 , l3Base
 , SysUtils
 , l3IniFile
 , l3FileUtils
;

end.
