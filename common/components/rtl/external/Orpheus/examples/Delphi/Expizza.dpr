program Expizza;

uses
  Forms,
  Expizzau in 'EXPIZZAU.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
