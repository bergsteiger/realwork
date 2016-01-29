unit pull_consumer_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,coseventcomm_int,coseventchanneladmin_int,code_int,any,orb_int;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private

  end;

  TORBThread = class(TThread)
    procedure Execute; override;
  end;


var
  Form1: TForm1;
  dorb: IORB;
  th : TORBThread;

implementation

uses
  orb,utils,orbtypes,cosnaming,cosnaming_int,coseventchanneladmin;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  th := TORBThread.Create(true);
  th.FreeOnTerminate := true;
  th.Resume;
end;

procedure TORBThread.execute;
var
  params : TStrings;
  obj : IORBObject;
  name : TName;
  nc : INamingContext;
  cadm: IConsumerAdmin;
  pull_sup : IProxyPullSupplier;
  ev : IEventChannel;
  a : IAny;
  val: AnsiString;
begin
  params := TStringList.Create;
  try
    split(PChar(Form1.Edit1.Text),params);
    dorb := ORB_Init(params);
    dorb.BOA_Init();
    obj := dorb.resolve_initial_reference('NameService');
    if obj <> nil then
      begin
        nc := TNamingContext._narrow(obj);
        SetLength(name,1);
        name[0].id := 'MyEventChannel';
        name[0].kind := '';
        obj := nc.resolve(name);
        if obj <> nil then
          begin
            ev := TEventChannel._narrow(obj);
            cadm := ev.for_consumers();
            pull_sup := cadm.obtain_pull_supplier();
            Form1.Button1.Enabled := false;
            a := pull_sup.pull;
            a.get_string(val);
            Form1.Memo1.Lines.Add(String(val));
            Form1.Button1.Enabled := True;
          end;
      end;
  finally
    dorb := nil;
    params.free;
    th := nil;
  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if dorb <> nil then
    dorb.shutdown(false);
end;

end.
