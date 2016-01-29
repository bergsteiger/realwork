unit htDataProviderFactory;

interface

uses
 l3IntfUses
 , daDataProviderFactory
 , daDataProviderParams
 , ddAppConfig
 , daInterfaces
;

type
 ThtDataProviderFactory = class(TdaDataProviderFactory)
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
 end;//ThtDataProviderFactory
 
implementation

uses
 l3ImplUses
 , htDataProviderParams
 , htInterfaces
 , ddUtils
 , SysUtils
 , l3Base
 , ddAppConfigStrings
 , l3IniFile
 , l3FileUtils
 , StrUtils
 , htDataProvider
 , ddAppConfigTypes
;

end.
