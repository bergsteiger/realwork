unit GarClientSecurity;

interface

uses
 l3IntfUses
 , pi
 , SecuritySrv_int
 , pi_int
;

type
 TGarClientSecurity = class(TClientRequestInterceptor)
  procedure Create(const info: IORBInitInfo);
  procedure __destroy;
  function __get__name: ANSIString;
  procedure send__request(const ri: IClientRequestInfo);
  procedure send__poll(const ri: IClientRequestInfo);
  procedure receive__reply(const ri: IClientRequestInfo);
  procedure receive__exception(const ri: IClientRequestInfo);
  procedure receive__other(const ri: IClientRequestInfo);
 end;//TGarClientSecurity
 
implementation

uses
 l3ImplUses
 , orbtypes
 , Windows
;

end.
