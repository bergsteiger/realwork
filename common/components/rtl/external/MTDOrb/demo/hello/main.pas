unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,orb_int,orb;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses
  helloworld,helloworld_int;

procedure TForm1.Button1Click(Sender: TObject);
var
  orb : IORB;
  obj : IORBObject;
  helloworld : IHelloWorld;
begin
  orb := ORB_Init(nil);
  obj := orb.string_to_object(AnsiString(Edit1.Text));
  if obj <> nil then
    begin
      helloworld := THelloWorld._narrow(obj);
      helloworld.hello;
    end;
end;

end.

