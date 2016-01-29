program Exedprn;

uses
  Forms,
  Exedprnu in 'EXEDPRNU.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
