program mebius;

uses
  evdSchema,
  Forms,
  mainform in 'mainform.pas' {MebiusForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMebiusForm, MebiusForm);
  Application.Run;
end.
