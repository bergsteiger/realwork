unit supplier_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  orb,orb_int,utils,orbtypes,cosnaming,cosnaming_int,coseventcomm_int,
  coseventcomm,any,code_int,coseventchanneladmin_int,coseventchanneladmin;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  dorb: IORB;
  params : TStrings;
  obj : IORBObject;
  name : TName;
  nc : INamingContext;
  ev : IEventChannel;
  sadm: ISupplierAdmin;
  push_con : IProxyPushConsumer;
  a : IAny;
begin
  params := TStringList.Create;
  try
    split(PChar(Edit1.Text),params);
    dorb := ORB_Init(params);
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
            sadm := ev.for_suppliers();
            push_con := sadm.obtain_push_consumer();
            a := CreateAny;
            a.put_string('test string');
            push_con.push(a);
          end;
      end;
  finally
    params.free;
  end;
end;

end.
