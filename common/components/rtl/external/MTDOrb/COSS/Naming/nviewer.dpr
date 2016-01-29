program nviewer;

uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  Forms,
  main in 'main.pas' {MainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
