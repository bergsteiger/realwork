unit ncsDataAccessServices;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 TncsDataAccessServices = class(Tl3ProtoObject)
  procedure InitClient;
   {* Настраивает и регестрирует фабрики для TdaDataProviderSuperFactory
Должен быть вызван до обращения к методам TdaDataProviderSuperFactory }
  procedure InitServer;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TncsDataAccessServices
 
implementation

uses
 l3ImplUses
 , SysUtils
 , htDataProviderFactory
 , daDataProviderSuperFactory
 , ncsClientParamsStorage
 , daScheme
 , pgDataProviderFactory
 , ncsServerParamsStorage
;

end.
