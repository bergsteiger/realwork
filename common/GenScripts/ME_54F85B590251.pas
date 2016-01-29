unit daDataProviderSuperFactory;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daDataProviderFactory
 , daDataProviderFactoryList
 , daInterfaces
 , daDataProviderParams
 , Classes
 , l3Variant
 , ddAppConfig
 , daTypes
;

type
 TdaDataProviderSuperFactory = class(Tl3ProtoObject)
  function FindFactoryByKey(const aKey: AnsiString): TdaDataProviderFactory;
  function FindFactoryByParamType(const aKey: AnsiString): TdaDataProviderFactory;
  function MakeFromTaggedData(aData: Tl3Tag): TdaDataProviderParams;
  procedure CorrectByClient(aParams: TdaDataProviderParams);
  function IsParamsValid(aParams: TdaDataProviderParams;
   Quiet: Boolean): Boolean;
  procedure FillInConfig(aConfig: TddAppConfiguration;
   aParams: TdaDataProviderParams;
   ForInfoOnly: Boolean);
  procedure FillOutConfig(aConfig: TddAppConfiguration;
   aEtalon: TdaDataProviderParams;
   out aParams: TdaDataProviderParams);
  procedure BuildConfig(aConfig: TddAppConfiguration;
   const aProviderKey: AnsiString;
   ForInfoOnly: Boolean);
  function IndexOfParamType(const aKey: AnsiString): Integer;
  function MakeProvider(aParams: TdaDataProviderParams;
   AllowClearLocks: Boolean): IdaDataProvider;
  procedure LoadDBVersion(aParams: TdaDataProviderParams);
  function CheckLogin(aParams: TdaDataProviderParams;
   const aLogin: AnsiString;
   const aPassword: AnsiString;
   IsRequireAdminRights: Boolean): TdaLoginError;
  procedure Register(aFactory: TdaDataProviderFactory);
  procedure UnRegister(aFactory: TdaDataProviderFactory);
  function MakeFromConfig: TdaDataProviderParams;
  procedure SaveToConfig(aParams: TdaDataProviderParams);
  function MakeParamsFromEVD(aStream: TStream): TdaDataProviderParams;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TdaDataProviderSuperFactory
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
 , ddAppConfigTypes
;

end.
