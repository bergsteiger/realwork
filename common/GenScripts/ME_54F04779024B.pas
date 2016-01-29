unit ncsServiceProviderParamsFactory;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ncsServiceProviderParams
 , ddAppConfig
 , daGUITypes
;

type
 TncsServiceProviderParamsFactory = class(Tl3ProtoObject)
  procedure FillInConfig(aConfig: TddAppConfiguration;
   aParams: TncsServiceProviderParams;
   ForInfoOnly: Boolean);
  procedure FillOutConfig(aConfig: TddAppConfiguration;
   aParams: TncsServiceProviderParams);
  procedure BuildConfig(aConfig: TddAppConfiguration;
   aCallBack: TBuildConfigProc;
   const aProviderKey: AnsiString;
   ForInfoOnly: Boolean);
  function MakeEmpty: TncsServiceProviderParams;
  function MakeFromConfig: TncsServiceProviderParams;
  procedure SaveToConfig(aParams: TncsServiceProviderParams);
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TncsServiceProviderParamsFactory
 
implementation

uses
 l3ImplUses
 , l3Base64
 , l3Utils
 , l3IniFile
 , ddAppConfigTypes
 , ddAppConfigStrings
 , SysUtils
;

end.
