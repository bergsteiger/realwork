unit KPagetTest2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  GenerationContents_int, GenerationContents, SecuritySrv_int, SecuritySrv,
  // MTDORB units
  orb_int, orb, req_int, code_int, imr, imr_int, env_int, stdstat, std_seq,
  pi_impl, pi, pi_int, any,
  orbtypes, exceptions, except_int, poa_int, poa, CosNaming_int, CosNaming;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  GarORBInitializerImpl = class(TORBInitializer)
  protected
    procedure pre_init(const info: IORBInitInfo); override;
    procedure post_init(const info: IORBInitInfo); override;
  public
    class procedure Init;
  end;

  ClientSecurity = class(TClientRequestInterceptor)
  protected
    procedure _destroy; override;
    function _get_name: AnsiString; override;
    procedure send_request(const ri: IClientRequestInfo); override;
    procedure send_poll(const ri: IClientRequestInfo); override;
    procedure receive_reply(const ri: IClientRequestInfo); override;
    procedure receive_exception(const ri: IClientRequestInfo); override;
    procedure receive_other(const ri: IClientRequestInfo); override;
  public
    constructor Create(const info: IORBInitInfo);
  end;

var
  Form1: TForm1;
  authorized_session : TCoreSrv_SecuritySrv_Token;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  orb_props : TStringList;
  obj : IORBObject;
  main_orb : IORB;
  nc : INamingContext;
  name : TName;
  kpage : IServerGate_GenerationContents_Page;
  kpage_factory : IServerGate_GenerationContents_PageFactoryManagerSrv;
  session_manager : ICoreSrv_SecuritySrv_SessionManager;
  labels : AnsiString;
begin
  Memo1.Clear;
  authorized_session.sid := 0;
  authorized_session.uid := 0;

  Memo1.Lines.Add('ORB_Init...');
  orb_props := TStringList.Create;
  orb_props.Add('-ORBINITREF');
  orb_props.Add('NameService=corbaloc::1.2@mdp:5053/NameService');

  GarORBInitializerImpl.Init();

  main_orb := ORB_Init(orb_props);
  Memo1.Lines.Add('complete ORB_Init!');

  Memo1.Lines.Add('resolve_initial_reference for NameService...');
  obj := main_orb.resolve_initial_reference('NameService');
  Memo1.Lines.Add('complete resolve_initial_reference for NameService!');
  if obj <> nil then
    begin
      nc := TNamingContext._narrow(obj);
      Memo1.Lines.Add('complete TNamingContext._narrow!');

      SetLength(name,1);
      name[0].id := 'CoreSrv::SecuritySrv::SessionManager';
      name[0].kind := '';
      obj := nc.resolve(name);
      session_manager := TCoreSrv_SecuritySrv_SessionManagerFactoryManagerSrv._narrow(obj).get();
      authorized_session := session_manager.login('tester', 'tester');
      Memo1.Lines.Add('complete session_manager.login!');

      name[0].id := 'ServerGate::GenerationContents::Page';
      name[0].kind := '';
      obj := nc.resolve(name);
      Memo1.Lines.Add('complete resolve factory for ServerGate::GenerationContents::Page!');
      kpage_factory := TServerGate_GenerationContents_PageFactoryManagerSrv._narrow(obj);
      Memo1.Lines.Add('complete IServerGate_GenerationContents_PageFactoryManagerSrv._narrow!');

      kpage := kpage_factory.get('456C0DD70110');
      Memo1.Lines.Add('complete kpage_factory.get!');

      labels := kpage.get_labels();
      Memo1.Lines.Add('complete kpage.get_labels!');

      Memo1.Lines.Add(labels);

      session_manager.logout();
      Memo1.Lines.Add('complete session_manager.logout!');
    end;
end;

{ GarORBInitializerImpl }

class procedure GarORBInitializerImpl.Init;
begin
  TPIManager.RegisterOrbInitializer(GarORBInitializerImpl.Create());
end;

procedure GarORBInitializerImpl.post_init(const info: IORBInitInfo);
begin
  info.add_client_request_interceptor(ClientSecurity.Create(info));
end;

procedure GarORBInitializerImpl.pre_init(const info: IORBInitInfo);
begin

end;

{ ClientSecurity }

constructor ClientSecurity.Create(const info: IORBInitInfo);
begin
end;

procedure ClientSecurity.receive_exception(const ri: IClientRequestInfo);
begin
end;

procedure ClientSecurity.receive_other(const ri: IClientRequestInfo);
begin
end;

procedure ClientSecurity.receive_reply(const ri: IClientRequestInfo);
begin
end;

procedure ClientSecurity.send_poll(const ri: IClientRequestInfo);
begin
end;

procedure ClientSecurity.send_request(const ri: IClientRequestInfo);
const
  ISID_SERVER_SECURITY: ServiceId = 3879353251;
var
  sc: ServiceContext;
begin
  sc.context_id := ISID_SERVER_SECURITY;
  SetLength(sc.context_data, Sizeof(authorized_session));
  Move(authorized_session, Pointer(sc.context_data)^, Sizeof(authorized_session));
  ri.add_request_service_context(sc, true);
end;

procedure ClientSecurity._destroy;
begin
end;

function ClientSecurity._get_name: AnsiString;
begin
  Result := 'ClientSecurity';
end;

end.

