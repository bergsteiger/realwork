program Exmeter;

uses
  Forms,
  Exmeter1 in 'EXMETER1.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
