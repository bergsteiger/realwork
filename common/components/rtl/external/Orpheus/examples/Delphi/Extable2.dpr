program EXTABLE2;

uses
  Forms,
  EXTBL2U in 'EXTBL2U.pas' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
