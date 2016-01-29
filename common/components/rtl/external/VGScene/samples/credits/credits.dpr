program credits;

uses
  Forms,
  creditsfrm in 'creditsfrm.pas' {Form13};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm13, Form13);
  Application.Run;
end.
