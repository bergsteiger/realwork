unit ClientUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OSThread, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    edLoop: TEdit;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TDoit1 = class(TORBThread)
  public
    procedure Run(); override;
  end;

  TDoit2 = class(TORBThread)
  public
    procedure Run(); override;
  end;

var
  Form1: TForm1;

implementation

uses orb, orb_int, simple_int, simple;

{$R *.DFM}

const
  ch: array [0..1] of char = ('+', '-');

var
  loops: integer;
  s1: Isimple1;
  s2: Isimple2;
  doit1: IORBThread;
  doit2: IORBThread;

{ TDoit1 }

procedure TDoit1.Run();
var
  i: integer;
  c: AnsiChar;
begin
  c := AnsiChar(FArg^);
  for i := 1 to loops do begin
    s1.func(c);
    yield();
  end;
end;

{ TDoit2 }

procedure TDoit2.Run();
var
  i: integer;
  c: AnsiChar;
begin
  c := AnsiChar(FArg^);
  for i := 1 to loops do begin
    s2.func(c);
    yield();
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  dorb : IORB;
  obj: IORBObject;
  params: TStrings;
  start1,stop1,start2,stop2: _SYSTEMTIME;
begin
  params := TStringList.Create;
  try
    params.add('-ORBBindAddr');
    params.add('inet:127.0.0.1:10000');
    dorb := ORB_Init(params);
  finally
    params.Free;
  end;
  loops := StrToInt(edLoop.Text);
  obj := dorb.bind('IDL:simple1:1.0');
  s1 := Tsimple1._narrow(obj);
  obj := dorb.bind('IDL:simple2:1.0');
  s2:= Tsimple2._narrow(obj);
  if (s1 = nil) or (s2 = nil) then Exit;
  doit1 := TDoit1.Create();
  doit2 := TDoit2.Create();
  getsystemtime(start1);
  doit1.start(@ch[0]);
  getsystemtime(start2);
  doit2.start(@ch[1]);
  doit1.wait();
  getsystemtime(stop1);
  doit1 := nil;
  doit2.wait();
  getsystemtime(stop2);
  doit2 := nil;
  s1.flush;
  s2.flush;
  memo1.Lines.Add(FloatToStr(((stop1.wSecond - start1.wSecond)*1000 + (stop1.wMilliseconds - start1.wMilliseconds)) / loops)+' ms per call');
  memo1.Lines.Add(FloatToStr(((stop2.wSecond - start2.wSecond)*1000 + (stop2.wMilliseconds - start2.wMilliseconds)) / loops)+' ms per call');
end;

end.
