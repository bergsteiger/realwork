unit push_consumer_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,coseventcomm,coseventcomm_int,code_int,any,orb_int,poa_int;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure doterminate(Sender: TObject);
  public
    t: TThread;
  end;

  TORBThread = class(TThread)
  protected
    procedure Execute; override;
  public
    //constructor Create;
  end;

  TConsumerImpl = class(TPushConsumer_serv,IPushConsumer)
  protected
    procedure push(const data: IAny); override;
    procedure disconnect_push_consumer; override;
  end;

var
  Form1: TForm1;
  dorb: IORB;
  rootPoa: IPOA;

implementation

uses
  orb,utils,orbtypes,cosnaming,cosnaming_int,coseventchanneladmin,coseventchanneladmin_int,
  poa_impl;

{$R *.DFM}

{constructor TORBThread.Create;
begin
  FreeOnTerminate := false;
  inherited Create(false);
end;}

procedure TORBThread.Execute;
begin
  try
  dorb.run;
  except
    on e: Exception do
      ShowMessage(e.message)
  end;
end;

procedure TForm1.doterminate(Sender: TObject);
begin
  dorb := nil;
  //t := nil;
end;

procedure TConsumerImpl.disconnect_push_consumer;
begin

end;

procedure TConsumerImpl.push(const data: IAny);
var
  str: AnsiString;
begin
  if data.get_string(str) then
    Form1.Memo1.Lines.Add('EventConsumer: '+String(str));
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  params : TStrings;
  obj : IORBObject;
  name : TName;
  nc : INamingContext;
  evf : IEventChannelFactory;
  cadm: IConsumerAdmin;
  push_sup : IProxyPushSupplier;
  cimpl : IPushConsumer;
  ev : IEventChannel;
begin
  if dorb <> nil then
    begin
      dorb.shutdown(true);
      if t <> nil then begin
        t.WaitFor;
        t.Free;
      end;
      Button1.Caption := 'Start';
      exit;
    end;
  params := TStringList.Create;
  try
  try
    split(PChar(Edit1.Text),params);
    dorb := ORB_Init(params);
    obj := dorb.resolve_initial_reference('RootPOA');
    rootPoa := POA_Narrow(obj);

    cimpl := TPushConsumer._narrow(rootPoa.activate_for_this(TConsumerImpl.Create as IServant));

    rootPoa.the_POAManager.activate();

    obj := dorb.resolve_initial_reference('NameService');
    if obj <> nil then
      begin
        nc := TNamingContext._narrow(obj);
        SetLength(name,1);
        name[0].id := 'EventChannelFactory';
        name[0].kind := '';
        obj := nc.resolve(name);
        if obj <> nil then
          begin
            evf := TEventChannelFactory._narrow(obj);
            {ev := evf.create_eventchannel();
            name[0].id := 'MyEventChannel';
            name[0].kind := '';
            try
              nc.bind(name, ev as IORBObject);
            except
              on e : TNamingContext_AlreadyBound do
                nc.rebind(name, ev as IORBObject);
            end;}
            name[0].id := 'MyEventChannel';
            name[0].kind := '';
            try
              obj := nc.resolve(name);
              ev := TEventChannel._narrow(obj);
            except
              on E: TNotFound do begin
                ev := evf.create_eventchannel();
                try
                  nc.bind(name, ev as IORBObject);
                except
                  on e : TAlreadyBound do
                    nc.rebind(name, ev as IORBObject);
                end;
              end;
            end; { try/except }
            cadm := ev.for_consumers();
            push_sup := cadm.obtain_push_supplier();
            push_sup.connect_push_consumer(cimpl);
          end;
      end;
  finally
    params.free;
  end;
  if (dorb <> nil) and (push_sup <> nil) then
    begin
      t := TORBThread.Create(true);
      //t.FreeOnTerminate := true;
      t.OnTerminate := doterminate;
      t.Resume;
      Button1.Caption := 'Stop';
    end;
  except
    on e: exception do
      ShowMessage(e.Message);
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if dorb = nil then exit;
  dorb.shutdown(true);
  if t <> nil then begin
    t.WaitFor;
    t.Free;
  end;
end;

end.
