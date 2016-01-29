unit ncsDefaultProviderHolder;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
;

type
 TncsDefaultProviderHolder = class(Tl3ProtoObject)
  procedure IntCreateProvider;
  procedure IntDoneProvider;
  procedure CreateProvider;
  procedure DoneProvider;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TncsDefaultProviderHolder
 
implementation

uses
 l3ImplUses
 , daDataProviderSuperFactory
 , daDataProviderParams
 , ncsDataAccessServices
 , SysUtils
;

end.
