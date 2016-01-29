program BackTo130;

uses
  Forms,
  b130Main in 'b130Main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
