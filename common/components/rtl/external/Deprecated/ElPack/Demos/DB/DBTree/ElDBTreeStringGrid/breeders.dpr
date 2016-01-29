program breeders;

uses
  Forms,
  mailform in 'mailform.pas' {Form1};

{$R BREEDERS.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
