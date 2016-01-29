unit daDataProviderFactory;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daDataProviderParams
 , ddAppConfig
 , daTypes
;

type
 TdaDataProviderFactory = class(Tl3ProtoObject)
  function MakeFromConfig: TdaDataProviderParams;
  procedure LoadCommonParams(aParams: TdaDataProviderParams);
  procedure SaveCommonParams(aParams: TdaDataProviderParams);
  procedure SaveToConfig(aParams: TdaDataProviderParams);
  function ParamType: TdaDataProviderParamsClass;
  procedure CorrectByClient(aParams: TdaDataProviderParams);
  function IsParamsValid(aParams: TdaDataProviderParams;
   Quiet: Boolean): Boolean;
  procedure FillOutConfig(aConfig: TddAppConfiguration;
   aEtalon: TdaDataProviderParams;
   out aParams: TdaDataProviderParams);
  procedure FillInConfig(aConfig: TddAppConfiguration;
   aParams: TdaDataProviderParams;
   ForInfoOnly: Boolean);
  procedure BuildConfig(aConfig: TddAppConfiguration;
   const aProviderKey: AnsiString;
   ForInfoOnly: Boolean);
  function MakeProvider(aParams: TdaDataProviderParams;
   AllowClearLocks: Boolean): IdaDataProvider;
  procedure LoadDBVersion(aParams: TdaDataProviderParams);
  function CheckLogin(aParams: TdaDataProviderParams;
   const aLogin: AnsiString;
   const aPassword: AnsiString;
   IsRequireAdminRights: Boolean): TdaLoginError;
  function DoMakeProvider(aParams: TdaDataProviderParams;
   ForCheckLogin: Boolean;
   AllowClearLocks: Boolean): IdaDataProvider;
  procedure LoginCheckSucceed(aParams: TdaDataProviderParams);
  function Key: AnsiString;
  function ParamKey: AnsiString;
 end;//TdaDataProviderFactory
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
