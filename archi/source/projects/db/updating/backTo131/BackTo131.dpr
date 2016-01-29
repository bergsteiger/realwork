program BackTo131;

uses
  Forms,
  b131Main in 'b131Main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
