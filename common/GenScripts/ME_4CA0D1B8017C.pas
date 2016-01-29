unit GarORBInitializerImpl;

interface

uses
 l3IntfUses
 , pi
 , pi_int
;

type
 TGarORBInitializerImpl = class(TORBInitializer)
  procedure Init;
  procedure pre__init(const info: IORBInitInfo);
  procedure post__init(const info: IORBInitInfo);
 end;//TGarORBInitializerImpl
 
implementation

uses
 l3ImplUses
 , GarClientSecurity
 , pi_impl
 , SysUtils
;

end.
