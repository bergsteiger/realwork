unit GarClientSecurity;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GarORB"
// Модуль: "w:/common/components/rtl/Garant/GarORB/GarClientSecurity.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::GarORB::IniAndFini::TGarClientSecurity
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\GarORB\tfwDefine.inc}

interface

{$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  pi,
  pi_int,
  SecuritySrv_int
  ;
{$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit

{$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
type
 TGarClientSecurity = class(TClientRequestInterceptor)
 protected
 // realized methods
   procedure _destroy; override;
   function _get_name: ANSIString; override;
   procedure Send_request(const ri: IClientRequestInfo); override;
   procedure Send_poll(const ri: IClientRequestInfo); override;
   procedure Receive_reply(const ri: IClientRequestInfo); override;
   procedure Receive_exception(const ri: IClientRequestInfo); override;
   procedure Receive_other(const ri: IClientRequestInfo); override;
 public
 // public methods
   constructor Create(const info: IORBInitInfo); reintroduce;
 end;//TGarClientSecurity
{$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit

  {$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
var
   authorized_session : TCoreSrv_SecuritySrv_Token;
  {$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit

implementation

{$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  orbtypes,
  Windows
  ;
{$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit

{$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}

// start class TGarClientSecurity

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

procedure TGarClientSecurity.Send_request(const ri: IClientRequestInfo);
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
end;//TGarClientSecurity.Send_request

procedure TGarClientSecurity.Send_poll(const ri: IClientRequestInfo);
//#UC START# *4CA0D43401E5_4CA0D4C90266_var*
//#UC END# *4CA0D43401E5_4CA0D4C90266_var*
begin
//#UC START# *4CA0D43401E5_4CA0D4C90266_impl*
//#UC END# *4CA0D43401E5_4CA0D4C90266_impl*
end;//TGarClientSecurity.Send_poll

procedure TGarClientSecurity.Receive_reply(const ri: IClientRequestInfo);
//#UC START# *4CA0D44F0352_4CA0D4C90266_var*
//#UC END# *4CA0D44F0352_4CA0D4C90266_var*
begin
//#UC START# *4CA0D44F0352_4CA0D4C90266_impl*
  WriteLn('Receive_reply: ', ri.operation, ' ', GetCurrentThreadId);
  Flush(Output);
//#UC END# *4CA0D44F0352_4CA0D4C90266_impl*
end;//TGarClientSecurity.Receive_reply

procedure TGarClientSecurity.Receive_exception(const ri: IClientRequestInfo);
//#UC START# *4CA0D46502E4_4CA0D4C90266_var*
//#UC END# *4CA0D46502E4_4CA0D4C90266_var*
begin
//#UC START# *4CA0D46502E4_4CA0D4C90266_impl*
  WriteLn('Receive_exception: ', ri.operation, ' ', GetCurrentThreadId);
  Flush(Output);
//#UC END# *4CA0D46502E4_4CA0D4C90266_impl*
end;//TGarClientSecurity.Receive_exception

procedure TGarClientSecurity.Receive_other(const ri: IClientRequestInfo);
//#UC START# *4CA0D47C037F_4CA0D4C90266_var*
//#UC END# *4CA0D47C037F_4CA0D4C90266_var*
begin
//#UC START# *4CA0D47C037F_4CA0D4C90266_impl*
  WriteLn('Receive_other: ', ri.operation, ' ', GetCurrentThreadId);
  Flush(Output);
//#UC END# *4CA0D47C037F_4CA0D4C90266_impl*
end;//TGarClientSecurity.Receive_other

{$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit

end.