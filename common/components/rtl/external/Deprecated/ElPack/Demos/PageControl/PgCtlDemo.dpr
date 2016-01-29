program PgCtlDemo;

uses
  Forms,
  PgCtlDemoMain in 'PgCtlDemoMain.pas' {PgCtlDemoMainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Page control evaluator';
  Application.CreateForm(TPgCtlDemoMainForm, PgCtlDemoMainForm);
  Application.Run;
end.

