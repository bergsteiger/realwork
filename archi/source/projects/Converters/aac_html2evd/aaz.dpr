program aaz;

uses
  Forms,
  mainform in 'mainform.pas' {AACMakerForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TAACMakerForm, AACMakerForm);
  Application.Run;
end.
