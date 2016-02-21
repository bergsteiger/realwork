unit GarClientSecurity;

// Модуль: "w:\common\components\rtl\Garant\GarORB\GarClientSecurity.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\GarORB\tfwDefine.inc}

interface

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
 , pi
 , SecuritySrv_int
 , pi_int
;

type
 TGarClientSecurity = class(TClientRequestInterceptor)
  protected
   procedure _destroy; override;
   function _get_name: ANSIString; override;
   procedure send_request(const ri: IClientRequestInfo); override;
   procedure send_poll(const ri: IClientRequestInfo); override;
   procedure receive_reply(const ri: IClientRequestInfo); override;
   procedure receive_exception(const ri: IClientRequestInfo); override;
   procedure receive_other(const ri: IClientRequestInfo); override;
  public
   constructor Create(const info: IORBInitInfo); reintroduce;
 end;//TGarClientSecurity

var authorized_session: TCoreSrv_SecuritySrv_Token;
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 , orbtypes
 , Windows
;

constructor TGarClientSecurity.Create(const info: IORBInitInfo);
//#UC START# *4CA0D4D6026F_4CA0D4C90266_var*
//#UC END# *4CA0D4D6026F_4CA0D4C90266_var*
begin
//#UC START# *4CA0D4D6026F_4CA0D4C90266_impl*
 inherited Create;
//#UC END# *4CA0D4D6026F_4CA0D4C90266_impl*
end;//TGarClientSecurity.Create

procedure TGarClientSecurity._destroy;
//#UC START# *4CA0D39501A8_4CA0D4C90266_var*
//#UC END# *4CA0D39501A8_4CA0D4C90266_var*
begin
//#UC START# *4CA0D39501A8_4CA0D4C90266_impl*
//#UC END# *4CA0D39501A8_4CA0D4C90266_impl*
end;//TGarClientSecurity._destroy

function TGarClientSecurity._get_name: ANSIString;
//#UC START# *4CA0D3AD017C_4CA0D4C90266_var*
//#UC END# *4CA0D3AD017C_4CA0D4C90266_var*
begin
//#UC START# *4CA0D3AD017C_4CA0D4C90266_impl*
 Result := 'ClientSecurity';
//#UC END# *4CA0D3AD017C_4CA0D4C90266_impl*
end;//TGarClientSecurity._get_name

procedure TGarClientSecurity.send_request(const ri: IClientRequestInfo);
//#UC START# *4CA0D42302FC_4CA0D4C90266_var*
const
  ISID_SERVER_SECURITY: ServiceId = 3879353251;
var
  sc: ServiceContext;
//#UC END# *4CA0D42302FC_4CA0D4C90266_var*
begin
//#UC START# *4CA0D42302FC_4CA0D4C90266_impl*
  WriteLn('Send_request: ', ri.operation, ' ', GetCurrentThreadId);
  Flush(Output);
  sc.context_id := ISID_SERVER_SECURITY;
  SetLength(sc.context_data, Sizeof(authorized_session));
  Move(authorized_session, sc.context_data[0], Sizeof(authorized_session));
  ri.add_request_service_context(sc, true);
//#UC END# *4CA0D42302FC_4CA0D4C90266_impl*
end;//TGarClientSecurity.send_request

procedure TGarClientSecurity.send_poll(const ri: IClientRequestInfo);
//#UC START# *4CA0D43401E5_4CA0D4C90266_var*
//#UC END# *4CA0D43401E5_4CA0D4C90266_var*
begin
//#UC START# *4CA0D43401E5_4CA0D4C90266_impl*
//#UC END# *4CA0D43401E5_4CA0D4C90266_impl*
end;//TGarClientSecurity.send_poll

procedure TGarClientSecurity.receive_reply(const ri: IClientRequestInfo);
//#UC START# *4CA0D44F0352_4CA0D4C90266_var*
//#UC END# *4CA0D44F0352_4CA0D4C90266_var*
begin
//#UC START# *4CA0D44F0352_4CA0D4C90266_impl*
  WriteLn('Receive_reply: ', ri.operation, ' ', GetCurrentThreadId);
  Flush(Output);
//#UC END# *4CA0D44F0352_4CA0D4C90266_impl*
end;//TGarClientSecurity.receive_reply

procedure TGarClientSecurity.receive_exception(const ri: IClientRequestInfo);
//#UC START# *4CA0D46502E4_4CA0D4C90266_var*
//#UC END# *4CA0D46502E4_4CA0D4C90266_var*
begin
//#UC START# *4CA0D46502E4_4CA0D4C90266_impl*
  WriteLn('Receive_exception: ', ri.operation, ' ', GetCurrentThreadId);
  Flush(Output);
//#UC END# *4CA0D46502E4_4CA0D4C90266_impl*
end;//TGarClientSecurity.receive_exception

procedure TGarClientSecurity.receive_other(const ri: IClientRequestInfo);
//#UC START# *4CA0D47C037F_4CA0D4C90266_var*
//#UC END# *4CA0D47C037F_4CA0D4C90266_var*
begin
//#UC START# *4CA0D47C037F_4CA0D4C90266_impl*
  WriteLn('Receive_other: ', ri.operation, ' ', GetCurrentThreadId);
  Flush(Output);
//#UC END# *4CA0D47C037F_4CA0D4C90266_impl*
end;//TGarClientSecurity.receive_other
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

end.
