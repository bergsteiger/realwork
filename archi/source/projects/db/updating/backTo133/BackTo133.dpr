program BackTo133;

uses
  Forms,
  b133Main in 'b133Main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
