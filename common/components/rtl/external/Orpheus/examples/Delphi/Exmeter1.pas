unit Exmeter1;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, OvcBase, OvcMeter, StdCtrls, Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    OvcMeter1: TOvcMeter;
    OvcController1: TOvcController;
    Timer1: TTimer;
    OvcMeter2: TOvcMeter;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  {increase meter 1's display value}
  OvcMeter1.Percent := OvcMeter1.Percent + 1;
  if OvcMeter1.Percent >= 100 then
    OvcMeter1.Percent := 0;

  {decrease meter 2's display value}
  OvcMeter2.Percent := OvcMeter2.Percent - 1;
  if OvcMeter2.Percent = 0 then
    OvcMeter2.Percent := 100;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  OvcMeter1.Percent := 0
end;

end.
