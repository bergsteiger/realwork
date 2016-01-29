program ExMove;

uses
  Forms,
  Exmove1 in 'EXMOVE1.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
