unit pi;

interface

uses
 l3IntfUses
 , pi_int
 , orb
;

type
 TORBInitializer = class
  procedure pre__init(const info: IORBInitInfo);
  procedure post__init(const info: IORBInitInfo);
 end;//TORBInitializer
 
 TInterceptor = class(TLocalORBObject)
  procedure __destroy;
  function __get__name: ANSIString;
 end;//TInterceptor
 
 TClientRequestInterceptor = class(TInterceptor)
  procedure send__request(const ri: IClientRequestInfo);
  procedure send__poll(const ri: IClientRequestInfo);
  procedure receive__reply(const ri: IClientRequestInfo);
  procedure receive__exception(const ri: IClientRequestInfo);
  procedure receive__other(const ri: IClientRequestInfo);
 end;//TClientRequestInterceptor
 
implementation

uses
 l3ImplUses
;

end.
