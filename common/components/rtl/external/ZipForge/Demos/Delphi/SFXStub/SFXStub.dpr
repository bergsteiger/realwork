program SFXStub;

uses
  Forms,
  uMain in 'uMain.pas' {For�m1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
