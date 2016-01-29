unit serv_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,bench,orb_int;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public

  end;


  TORBThread = class(TThread)
    procedure Execute; override;
  end;

var
  Form1: TForm1;
  dorb : IORB;
  th: TThread;

implementation

{$R *.DFM}

uses
  orb,poa_int,bench_impl,bench_int,poa_impl;

procedure TForm1.Button1Click(Sender: TObject);
var
  obj : IORBObject;
  params : TStrings;
  p: IPOA;
begin
  params := TStringList.Create();
  try
    params.add('-ORBIIOPAddr');
    params.add(Edit1.Text);
    dorb := ORB_Init(params);
    obj := dorb.resolve_initial_reference('RootPOA');
    p := TPOA_impl._narrow(obj);
    p.activate_object(TBench_impl.Create());
    p.the_POAManager.activate;
    th := TORBThread.Create(true);
    th.FreeOnTerminate := true;
    th.Resume;
    Button1.Enabled := false;
  finally
    params.free;
  end;
end;

{ TORBThread }

procedure TORBThread.Execute;
begin
  dorb.run;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if dorb <> nil then
    dorb.shutdown(true);
end;

end.
