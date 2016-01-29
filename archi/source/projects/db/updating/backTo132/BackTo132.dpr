program BackTo132;

uses
  Forms,
  b132Main in 'b132Main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
