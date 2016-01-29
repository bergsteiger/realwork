program Extbl13;

uses
  Forms,
  Extbl13u in 'EXTBL13U.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
