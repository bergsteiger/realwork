program pb2lzw;

uses
  Forms,
  pbz_Main in 'pbz_Main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
