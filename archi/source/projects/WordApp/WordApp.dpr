program WordApp;

uses
  Forms,
  uWordApp in 'uWordApp.pas' {WordAppForm};

{$R *.RES}

begin
 Application.Initialize;
 Application.CreateForm(TWordAppForm, WordAppForm);
  Application.Run;
end.
